@echo off

pushd ..
premake5.exe --file=Premake5.lua vs2022
popd
pause