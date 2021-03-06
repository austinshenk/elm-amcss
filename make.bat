@echo off
setlocal enabledelayedexpansion
 echo ------COMPILING APP------^
 && elm make src/Main.elm --optimize --output=build/index.js^
 && echo ------UGLIFYING JS-------^
 && uglifyjs build/index.js --output=build/index.uglified.js --compress pure_funcs=["F2","F3","F4","F5","F6","F7","F8","F9","A2","A3","A4","A5","A6","A7","A8","A9"],pure_getters,keep_fargs=false,unsafe_comps,unsafe^
 && uglifyjs build/index.uglified.js --mangle --output=dist/index.min.js^
 && echo ------GZIP JS------------^
 && gzip dist/index.min.js -o dist^
 && echo ------COMPILING CSS------^
 && elm make src/Main/Css.elm --output=build/css.js^
 && echo ------RENDERING CSS------^
 && node build/generate-css.js^
 && echo ------UGLIFYING CSS------^
 && uglifycss build/index.css > dist/index.min.css^
 && echo ------GZIP CSS-----------^
 && gzip dist/index.min.css -o dist
