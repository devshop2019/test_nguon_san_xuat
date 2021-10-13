rem https://stackoverflow.com/questions/27772861/get-serial-com-port-description-in-windows-batch
@echo off
:start

set myCom=COM8

set MyFile=QC_Firmware_Vietduino_4__n17_11_2019_Promini_5V.hex
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
echo --Qbbb--------qbbb---QbP----------------bb-----------bbbbbbbbP--bb----------bb--
echo --QbDbb-------bPbb----------------------------------QbP---------Sbb--------pb---
echo --Qb-Sbp-----pP-bb---QbP--sbbpbbbbbp----bb----------bD-pppp------Sbb------pbC---
echo --Qb--Qb----pb--bb---QbP--sbb-----QbP---bb---------dbbPP-Pbbb-----Sbp----dbP----
echo --Qb---bb--sbC--bb---QbP--sbb-----QbP---bb------------------bb-----Qb---sbP-----
echo --Qb---Sbp-bP---bb---QbP--sbb-----QbP---bb---------pp-------bD------Qb--bP------
echo --Qb----QbpP----bb---QbP--sbb-----QbP---bb---------Sbbp---pbb--------bbQP-------
echo --PP-----PP-----PP----PC---PP------PC---PP-----------PPbbPP-----------PP--------
echo --------------------------------------------------------------------------------
         
set /p choice="Nhan Enter de nap board PRO MINI 5V tiep theo. Nhap so COM neu COM sai. VD: 10"
if '%choice%'=='' goto start
if not '%choice%'=='y' set choice=%choice:~0,1%
rem set /p DUMMY=Hit ENTER to continue...

if not '%choice%'=='' set myCom=COM%choice%
goto upload
