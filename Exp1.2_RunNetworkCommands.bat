@echo off
title Computer Networks Lab - Experiment 1.2 Command Suite
color 0A

echo ======================================================
echo EXPERIMENT 1.2: NETWORK CONFIGURATION AND TESTING
echo ======================================================
echo.

echo [1/8] Running: hostname
hostname
echo.
pause

echo [2/8] Running: ipconfig /all
ipconfig /all
echo.
pause

echo [3/8] Running: ping 8.8.8.8 -n 4
ping 8.8.8.8 -n 4
echo.
pause

echo [4/8] Running: tracert -d 8.8.8.8
tracert -d 8.8.8.8
echo.
pause

echo [5/8] Running: netstat -ano (first 20 lines)
powershell -Command "netstat -ano | Select-Object -First 20"
echo.
pause

echo [6/8] Running: arp -a
arp -a
echo.
pause

echo [7/8] Running: nslookup google.com
nslookup google.com
echo.
pause

echo [8/8] Running: route print (IPv4 Routing Table)
powershell -Command "route print -4 | Select-Object -First 25"
echo.
echo ======================================================
echo All Experiment 1.2 commands executed successfully!
echo ======================================================
pause
