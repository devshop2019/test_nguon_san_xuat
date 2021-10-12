rem https://stackoverflow.com/questions/27772861/get-serial-com-port-description-in-windows-batch
@echo off
:start

set MyFile=QC_Firmware_Vietduino_4__n17_11_2019_mega2560.hex
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

%arduino_board%\firmware/avrdude -C%arduino_board%\firmware/avrdude.conf -v -patmega2560 -cwiring -P%DeviceID% -b115200 -D -Uflash:w:%~dp0\firmware/%MyFile%:i

echo --------------------------------------------------------------------------------
echo ---bb---------pb---------bbbb-------dbbb----------------------------------------
echo ----bb-------pbC---------bbSbp------bPbb----------------------------------------
echo -----bb-----dbC----------bb-Qb-----QP-bb----bbPPPbbp----bbPPPbbbb---pbPPPPbbp---
echo -----Sbp---sbP-----------bb--bb---pD--bb---bP------bb--bP------bb----------bb---
echo ------Sbp--bP------------bb---bp-sb---bb--QbPPPPPPPPP-sbC------bb---pbbbbPPbb---
echo -------bb-bP-------------bb---SbpbP---bb---bb------pp--Qb-----pbb--bb------bb---
echo --------QbD--------------bb----QbP----bb----bbbppbbP----SbbbbbDbb---bbbpbbPQb---
echo -------------------------------------------------------pp-----dbP---------------
echo --------------------------------------------------------bbbppbbC----------------
echo --------------------------------------------------------------------------------
            
set /p choice="Nhan Enter de nap board UNO tiep theo. Nhan "y" sau do Enter de tat cua so"
if '%choice%'=='' goto start
if not '%choice%'=='y' set choice=%choice:~0,1%
rem set /p DUMMY=Hit ENTER to continue...

