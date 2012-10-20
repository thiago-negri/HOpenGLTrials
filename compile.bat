::set /p main=Nome do arquivo Main: 
set main=Main

del *.hi *.o %main%.exe

ghc -O2 -threaded -optl-mwindows -o %main%.exe %main%.hs

pause