:: Make sure npm is latest version
npm install -g npm@latest

:: Core Elm package
npm install -g elm

:: Package for compiling ELM to CSS
npm install -g elm-css

:: Elm-format binary for formatting Elm files
:: Expiremental flag is just to make sure we get the latest one
npm install -g elm-format@exp



:: Install Elm package modules to project
elm-package install



:: Elm formatting package
apm install elm-format

:: Built in terminal
apm install platformio-ide-terminal

:: Adds syntax highlighting for Elm
apm install language-elm


:: Set elm-format's binary path to global Node module path (i.e. C:/Users/ashenk/AppData/Roaming/npm/node_modules/elm-format/unpacked_bin/elm-format)
