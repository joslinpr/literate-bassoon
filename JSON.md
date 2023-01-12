#	Book of Knowledge
##	JSON.md
##	Working with JSON
###	Converting json to yaml
` #	jq -f toYaml < Data.json `

or

` #	cmd | jq -f toYaml > Data.yaml `

Where toYaml is:
```
#	From: https://stackoverflow.com/questions/53315791/how-to-convert-a-json-response-into-yaml-in-bash#53330236
#	purpose: converts Json to Yaml
#	remarks:
#	You can use 'yq -y' to convert json to yaml, but ...
#	* this function can be used several times within a single jq program
#	* this function may be faster than using yq
#	* maybe yq is not available in your environment
#	#	input: any Json
#	output: json converted to yaml
def toYaml:
   def handleMultilineString($level):
      reduce ([match("\n+"; "g")]                       #	find groups of '\n'
              | sort_by(-.offset))[] as $match
             (.; .[0:$match.offset + $match.length] +
                 "\n\("    " * $level)" +               #	add one extra '\n' for every group of '\n's. Add indention for each new line
                 .[$match.offset + $match.length:]);

   def toYamlString($level):
      if type == "string"
      then handleMultilineString($level)
           | sub("'"; "''"; "g")           #	escape single quotes
           | "'\(.)'"                      #	wrap in single quotes
      else .
      end;

   def _toYaml($level):
      (objects | to_entries[] |
          if (.value | type) == "array" then
              "\(.key):", (.value | _toYaml($level))
          elif (.value | type) == "object" then
              "\(.key):", "\("    ")\(.value | _toYaml($level))"
          else
              "\(.key): \(.value | toYamlString($level))"
          end
      )
      // (arrays | select(length > 0)[] | [_toYaml($level)] |
          "  - \(.[0])", "\("    ")\(.[1:][])"
      )
      // .;

   _toYaml(1);
```
[//]: #	( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
