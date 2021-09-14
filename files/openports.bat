@echo off

start cmd /k sc config W3SVC start=disabled

start cmd /k net stop was /y

echo Ports opened

exit 
