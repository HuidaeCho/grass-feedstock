@echo on
cmake -B build %CMAKE_ARGS% -DPython3_EXECUTABLE="%PYTHON%" -DWITH_OPENGL=OFF
if errorlevel 1 exit /b 1

set CMAKE_BUILD_PARALLEL_LEVEL=1
cmake --build build --config Release -j%CPU_COUNT% --verbose
if errorlevel 1 exit /b 1

cmake --install build --config Release
if errorlevel 1 exit /b 1

mkdir "%PREFIX%\etc\conda\activate.d"
echo set "PATH=%CONDA_PREFIX%\Library\lib\grass85\bin;%%PATH%%" > "%PREFIX%\etc\conda\activate.d\grass-activate.bat"

echo "===== Installed Files ====="
dir /s /b %PREFIX%

echo "===== bin/grass.bat ====="
type %PREFIX%\Library\bin\grass.bat
echo "===== End of bin/grass.bat ====="
