mkdir Source
cp pdxinfo Source

set game_bin="OdinHelloWorld"

odin build src -out=Source/pdex.dll -debug -build-mode:shared && %PLAYDATE_SDK_PATH%\bin\pdc Source %game_bin%.pdx && PlaydateSimulator %game_bin%.pdx