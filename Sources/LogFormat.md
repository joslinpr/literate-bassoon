
# HAPROXY Log Format

## Chart

|Field  |  Format  |  Extract from the example above|
|------|---------|-------------------------------------------------------------|
|1  |  process_name '[' pid ']:'  |  haproxy[14389]:|
|2  |  client_ip ':' client_port  |  10.0.1.2:33317|
|3  |  '[' request_date ']'  |  [06/Feb/2009:12:14:14.655]|
|4  |  frontend_name  |  http-in|
|5  |  backend_name '/' server_name  |  static/srv1|
|6  |  TR '/' Tw '/' Tc '/' Tr '/' Ta*  |  10/0/30/69/109|
|7  |  status_code  | 200|
|8  |  bytes_read*  |  2750|
|9  |  captured_request_cookie  |-|
|10  |  captured_response_cookie  |-|
|11  |  termination_state  |----|
|12  |  actconn '/' feconn '/' beconn '/' srv_conn '/' retries*  |  1/1/1/1/0|
|13  |  srv_queue '/' backend_queue  |  0/0|
|14  |  '{' captured_request_headers* '}'  |  {haproxy.1wt.eu}|
|15  |  '{' captured_response_headers* '}'  |  {}|
|16  |  '"' http_request '"'  |  "GET /index.html HTTP/1.1"|

## Detailed fields description

- "client_ip" is the IP address of the client which initiated the TCP
    connection to haproxy. If the connection was accepted on a UNIX socket
    instead, the IP address would be replaced with the word "unix". Note that
    when the connection is accepted on a socket configured with "accept-proxy"
    and the PROXY protocol is correctly used, or with a "accept-netscaler-cip"
    and the NetScaler Client IP insertion protocol is correctly used, then the
    logs will reflect the forwarded connection's information.
- "client_port" is the TCP port of the client which initiated the connection.
    If the connection was accepted on a UNIX socket instead, the port would be
    replaced with the ID of the accepting socket, which is also reported in the
    stats interface.
- "request_date" is the exact date when the first byte of the HTTP request
    was received by haproxy (log field %tr).
- "frontend_name" is the name of the frontend (or listener) which received
    and processed the connection.
- "backend_name" is the name of the backend (or listener) which was selected
    to manage the connection to the server. This will be the same as the
    frontend if no switching rule has been applied.
- "server_name" is the name of the last server to which the connection was
    sent, which might differ from the first one if there were connection errors
    and a redispatch occurred. Note that this server belongs to the backend
    which processed the request. If the request was aborted before reaching a
    server, "\<NOSRV\>" is indicated instead of a server name. If the request was
    intercepted by the stats subsystem, "\<STATS\>" is indicated instead.
- "TR" is the total time in milliseconds spent waiting for a full HTTP
    request from the client (not counting body) after the first byte was
    received. It can be "-1" if the connection was aborted before a complete
    request could be received or a bad request was received. It should
    always be very small because a request generally fits in one single packet.
    Large times here generally indicate network issues between the client and
    haproxy or requests being typed by hand. See section 8.4 "Timing Events"
    for more details.
- "Tw" is the total time in milliseconds spent waiting in the various queues.
    It can be "-1" if the connection was aborted before reaching the queue.
    See section 8.4 "Timing Events" for more details.
- "Tc" is the total time in milliseconds spent waiting for the connection to
    establish to the final server, including retries. It can be "-1" if the
    request was aborted before a connection could be established. See section
    8.4 "Timing Events" for more details.
- "Tr" is the total time in milliseconds spent waiting for the server to send
    a full HTTP response, not counting data. It can be "-1" if the request was
    aborted before a complete response could be received. It generally matches
    the server's processing time for the request, though it may be altered by
    the amount of data sent by the client to the server. Large times here on
    "GET" requests generally indicate an overloaded server. See section 8.4
    "Timing Events" for more details.
- "Ta" is the time the request remained active in haproxy, which is the total
    time in milliseconds elapsed between the first byte of the request was
    received and the last byte of response was sent. It covers all possible
    processing except the handshake (see Th) and idle time (see Ti). There is
    one exception, if "option logasap" was specified, then the time counting
    stops at the moment the log is emitted. In this case, a '+' sign is
    prepended before the value, indicating that the final one will be larger.
    See section 8.4 "Timing Events" for more details.
- "status_code" is the HTTP status code returned to the client. This status
    is generally set by the server, but it might also be set by haproxy when
    the server cannot be reached or when its response is blocked by haproxy.
- "bytes_read" is the total number of bytes transmitted to the client when
    the log is emitted. This does include HTTP headers. If "option logasap" is
    specified, this value will be prefixed with a '+' sign indicating that
    the final one may be larger. Please note that this value is a 64-bit
    counter, so log analysis tools must be able to handle it without
    overflowing.
- "captured_request_cookie" is an optional "name=value" entry indicating that
    the client had this cookie in the request. The cookie name and its maximum
    length are defined by the "capture cookie" statement in the frontend
    configuration. The field is a single dash ('-') when the option is not
    set. Only one cookie may be captured, it is generally used to track session
    ID exchanges between a client and a server to detect session crossing
    between clients due to application bugs. For more details, please consult
    the section "Capturing HTTP headers and cookies" below.
- "captured_response_cookie" is an optional "name=value" entry indicating
    that the server has returned a cookie with its response. The cookie name
    and its maximum length are defined by the "capture cookie" statement in the
    frontend configuration. The field is a single dash ('-') when the option is
    not set. Only one cookie may be captured, it is generally used to track
    session ID exchanges between a client and a server to detect session
    crossing between clients due to application bugs. For more details, please
    consult the section "Capturing HTTP headers and cookies" below.
- "termination_state" is the condition the session was in when the session
    ended. This indicates the session state, which side caused the end of
    session to happen, for what reason (timeout, error, ...), just like in TCP
    logs, and information about persistence operations on cookies in the last
    two characters. The normal flags should begin with "--", indicating the
    session was closed by either end with no data remaining in buffers. See
    below "Session state at disconnection" for more details.
- "actconn" is the total number of concurrent connections on the process when
    the session was logged. It is useful to detect when some per-process system
    limits have been reached. For instance, if actconn is close to 512 or 1024
    when multiple connection errors occur, chances are high that the system
    limits the process to use a maximum of 1024 file descriptors and that all
    of them are used. See section 3 "Global parameters" to find how to tune the
    system.
- "feconn" is the total number of concurrent connections on the frontend when
    the session was logged. It is useful to estimate the amount of resource
    required to sustain high loads, and to detect when the frontend's "maxconn"
    has been reached. Most often when this value increases by huge jumps, it is
    because there is congestion on the backend servers, but sometimes it can be
    caused by a denial of service attack.
- "beconn" is the total number of concurrent connections handled by the
    backend when the session was logged. It includes the total number of
    concurrent connections active on servers as well as the number of
    connections pending in queues. It is useful to estimate the amount of
    additional servers needed to support high loads for a given application.
    Most often when this value increases by huge jumps, it is because there is
    congestion on the backend servers, but sometimes it can be caused by a
    denial of service attack.
- "srv_conn" is the total number of concurrent connections still active on
    the server when the session was logged. It can never exceed the server's
    configured "maxconn" parameter. If this value is very often close or equal
    to the server's "maxconn", it means that traffic regulation is involved a
    lot, meaning that either the server's maxconn value is too low, or that
    there aren't enough servers to process the load with an optimal response
    time. When only one of the server's "srv_conn" is high, it usually means
    that this server has some trouble causing the requests to take longer to be
    processed than on other servers.
- "retries" is the number of connection retries experienced by this session
    when trying to connect to the server. It must normally be zero, unless a
    server is being stopped at the same moment the connection was attempted.
    Frequent retries generally indicate either a network problem between
    haproxy and the server, or a misconfigured system backlog on the server
    preventing new connections from being queued. This field may optionally be
    prefixed with a '+' sign, indicating that the session has experienced a
    redispatch after the maximal retry count has been reached on the initial
    server. In this case, the server name appearing in the log is the one the
    connection was redispatched to, and not the first one, though both may
    sometimes be the same in case of hashing for instance. So as a general rule
    of thumb, when a '+' is present in front of the retry count, this count
    should not be attributed to the logged server.
- "srv_queue" is the total number of requests which were processed before
    this one in the server queue. It is zero when the request has not gone
    through the server queue. It makes it possible to estimate the approximate
    server's response time by dividing the time spent in queue by the number of
    requests in the queue. It is worth noting that if a session experiences a
    redispatch and passes through two server queues, their positions will be
    cumulative. A request should not pass through both the server queue and the
    backend queue unless a redispatch occurs.
- "backend_queue" is the total number of requests which were processed before
    this one in the backend's global queue. It is zero when the request has not
    gone through the global queue. It makes it possible to estimate the average
    queue length, which easily translates into a number of missing servers when
    divided by a server's "maxconn" parameter. It is worth noting that if a
    session experiences a redispatch, it may pass twice in the backend's queue,
    and then both positions will be cumulative. A request should not pass
    through both the server queue and the backend queue unless a redispatch
    occurs.
- "captured_request_headers" is a list of headers captured in the request due
    to the presence of the "capture request header" statement in the frontend.
    Multiple headers can be captured, they will be delimited by a vertical bar
    ('|'). When no capture is enabled, the braces do not appear, causing a
    shift of remaining fields. It is important to note that this field may
    contain spaces, and that using it requires a smarter log parser than when
    it's not used. Please consult the section "Capturing HTTP headers and
    cookies" below for more details.
- "captured_response_headers" is a list of headers captured in the response
    due to the presence of the "capture response header" statement in the
    frontend. Multiple headers can be captured, they will be delimited by a
    vertical bar ('|'). When no capture is enabled, the braces do not appear,
    causing a shift of remaining fields. It is important to note that this
    field may contain spaces, and that using it requires a smarter log parser
    than when it's not used. Please consult the section "Capturing HTTP headers
    and cookies" below for more details.
- "http_request" is the complete HTTP request line, including the method,
    request and HTTP version string. Non-printable characters are encoded (see
    below the section "Non-printable characters"). This is always the last
    field, and it is always delimited by quotes and is the only one which can
    contain quotes. If new fields are added to the log format, they will be
    added before this field. This field might be truncated if the request is
    huge and does not fit in the standard syslog buffer (1024 characters). This
    is the reason why this field must always remain the last one.j

    [Source](https://cbonte.github.io/haproxy-dconv/2.0/configuration.html#8.2.3)
