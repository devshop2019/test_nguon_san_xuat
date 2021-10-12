rem https://stackoverflow.com/questions/27772861/get-serial-com-port-description-in-windows-batch
@echo off
:start

set MyFile=QC_Firmware_Vietduino_4__n17_11_2019_UNO.hex
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

%arduino_board%\firmware/avrdude -C%arduino_board%\firmware/avrdude.conf -v -patmega328p -carduino -P%DeviceID% -b115200 -D -Uflash:w:%~dp0\firmware/%MyFile%:i

echo ---------QbbC-----------sbbC
echo ---------QbbC-----------sbbC
echo ---------QbbC-----------sbbC
echo ---------QbbC-----------sbbC------bbC-pbbbbbbbp--------qbbbbPPbbbbp
echo ---------QbbC-----------sbbC------bbbbC-----Sbbb------bbD--------bbbp
echo ---------QbbC-----------sbbC------bbP--------Qbb-----QbD----------Qbb
echo ---------QbbC-----------sbbC------bbP--------Qbb-----bbP----------Qbb
echo ---------dbbC-----------dbb-------bbP--------Qbb-----bbb----------Qbb
echo ----------bbb-----------bbP-------bbP--------Qbb-----Qbb----------bbP
echo -----------Qbbp-------pbbP--------bbP--------Qbb------Qbbp------pbbP
echo -------------PbbbbbbbbbP----------QbP--------dbb--------bbbbbbbbbP
            
set /p choice="Nhan Enter de nap board UNO tiep theo. Nhan "y" sau do Enter de tat cua so"
if '%choice%'=='' goto start
if not '%choice%'=='y' set choice=%choice:~0,1%
rem set /p DUMMY=Hit ENTER to continue...

