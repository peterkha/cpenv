@echo off

REM put your RAW extension here
SET _rawexten=.raf

REM put your custom extension here.  for example if lightroom is configured to generate a new file named DSCF9999-rt.jpg, the custom extension is -rt 
SET _customext=-rt

REM choose a jpeg quality level
SET _jpegquality=95

REM put your rawtherapee exec folder here.  name must be in quotes
SET _rawtherapee_folder="C:\Program Files\RawTherapee\"

REM rawtherapee exec name
SET _rawtherapee_exec=rawtherapee.exe

REM rawtherapee.exe runtime output and error output logs
SET _runtimeout="%TEMP%"\rawthp.txt
SET _runtimeerr="%TEMP%"\rawthpe.txt


SET _extension=%~x1
SET _inputfile=%~dpn1
SETLOCAL enabledelayedexpansion
REM removes customextension from input file
if NOT %_customext%a == a SET _rawfile=!_inputfile:%_customext%=!
if %_customext%a == a SET _rawfile=%_inputfile%


pushd %_rawtherapee_folder%

echo Edit raw file then close program.  Processing settings need to be saved to sidecar next to image (.pp3)
start /wait %_rawtherapee_exec% "%_rawfile%%_rawexten%" > %_runtimeout% 2> %_runtimeerr%

if "%_extension%" == ".tif" SET _outputformat=-t
if "%_extension%" == ".jpg" SET _outputformat=-j%_jpegquality%

echo.
echo Processing the just-edited raw file using the sidecar, outputting to same input filename.  Output file automatically overwritten!
echo.
echo on
start /B cmd /c %_rawtherapee_exec% -o "%_rawfile%%_customext%%_extension%" -s %_outputformat% -Y -c "%_rawfile%%_rawexten%" ^> %_runtimeout% 2^> %_runtimeerr%

popd

:EXIT






