game_bin="OdinHelloWorld"

odin build src -out=Source/pdex.dylib -debug -build-mode:shared && \
pdc --verbose Source ${game_bin}.pdx && \
~/Developer/PlaydateSDK/bin/Playdate\ Simulator.app/Contents/MacOS/Playdate\ Simulator ${game_bin}.pdx