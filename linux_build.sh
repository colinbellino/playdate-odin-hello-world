mkdir Source
cp pdxinfo Source

game_bin="OdinHelloWorld"

odin build src -out=Source/pdex -debug -build-mode:shared && \
pdc --verbose Source ${game_bin}.pdx && \
PlaydateSimulator ${game_bin}.pdx