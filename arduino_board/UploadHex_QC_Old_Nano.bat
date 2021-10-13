rem https://stackoverflow.com/questions/27772861/get-serial-com-port-description-in-windows-batch
@echo off
:start

set myCom=COM8

set MyFile=QC_Firmware_Vietduino_4__n17_11_2019_Old_Nano.hex
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
echo -----ppbbbbpp-------------ppp--------pp-----------------------------------------
echo ---QbP------Sbbp----------Qbbb-------bb-----------------------------------------
echo --bD----------Qbp---------Qb-bbp-----bb-----ppbbbpp----pp-pbbbp------ppbbbp-----
echo -QbP----------sbb---------Qb--Sbb----bb---bbC----Sbb---bbP----bb---pbP----Sbb---
echo -QbC----------sbb---------Qb----bbp--bb------pppppbb---bb-----QbP--bP------sbC--
echo --bb----------pbC---------Qb-----Sbb-bb---QbPPPC--bb---bb-----QbP--bb------dbP--
echo ---bbp------pbb-----------Qb-------Qbbb--sbb-----Qbb---bb-----QbP--bbp----pbP---
echo -----PPbbbbPP-------------PP--------SPP----PbbbPP-Pb---PP-----PPC----PbbbbP-----
echo --------------------------------------------------------------------------------
            
set /p choice="Nhan Enter de nap board OLD NANO THUONG tiep theo. Nhap so COM neu COM sai. VD: 10"
if '%choice%'=='' goto start
if not '%choice%'=='y' set choice=%choice:~0,1%
rem set /p DUMMY=Hit ENTER to continue...

if not '%choice%'=='' set myCom=COM%choice%
goto upload
