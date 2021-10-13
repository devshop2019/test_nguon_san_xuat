rem https://stackoverflow.com/questions/27772861/get-serial-com-port-description-in-windows-batch
@echo off
:start

set myCom=COM8

set MyFile=QC_Firmware_Vietduino_4__n17_11_2019_Promini_3V.hex
set charac=
setlocal

for /f "delims=" %%I in ('wmic path Win32_SerialPort get DeviceID^,Caption^,Description^,Name^,ProviderType /format:list ^| find "="') do (
    set "%%I"
)
set arduino_board=%~dp0
echo %DeviceID%
echo %Caption%
echo %Description%
echo %Name%
echo %ProviderType%

if not '%DeviceID%'=='' if not '%DeviceID%'=='COM1' set myCom=%DeviceID%
if not '%DeviceID%'=='' echo myCom : %myCom%; DeviceID: %DeviceID%
:upload
%arduino_board%\firmware/avrdude -C%arduino_board%\firmware/avrdude.conf -v -patmega328p -carduino -P%myCom% -b57600 -D -Uflash:w:%~dp0\firmware/%MyFile%:i

echo --------------------------------------------------------------------------------
echo --qppp---------pppC--spp----------------pp------------ppppp----spp----------qpp-
echo --QbDbb-------dbQbP---------------------------------pbP---Pbb---Sbb---------bP--
echo --QbCQbp------bCQbP---pp---pp-ppppp-----pp----------P------QbP---Sbb-------bD---
echo --QbC-Qb-----bP-QbP--sbb---bbPC---QbC---bb--------------ppbP------Qbp-----Qb----
echo --QbC--bb---pD--QbP--sbb---bD------bb---bb----------------Pbbp-----Qb----pbC----
echo --QbC--Sbp-db---QbP--sbb---bb------bb---bb------------------bb------bb--pbC-----
echo --QbC---QbpbP---QbP--sbb---bb------bb---bb---------Sbb-----qbD-------bbsbP------
echo --QbC----QbP----QbP--sbb---bb------bb---bb-----------bbbpbbbP---------bbP-------
echo --------------------------------------------------------------------------------

set /p choice="Nhan Enter de nap board PRO MINI 3V tiep theo. Nhap so COM neu COM sai. VD: 10"
if '%choice%'=='' goto start
if not '%choice%'=='y' set choice=%choice:~0,1%
rem set /p DUMMY=Hit ENTER to continue...

if not '%choice%'=='' set myCom=COM%choice%
goto upload
