# Resource scripts


These scripts need `JSON::Fast` and `LWP::Simple` installed as prerrequisites. They're no longer needed once the JSON files have been generated.

These scripts will download the text files from the Unicode consortium web and convert them into a JSON file that will be actually used by the module during precompilation.

    ./generate-map-confusables.p6

will generate the `confusables.json` file. You need to move it to the `../data` directory overwiting the existing one.

    ./generate-map-ws.p6

will generate the other file, ditto.
