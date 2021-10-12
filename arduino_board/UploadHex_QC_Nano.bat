rem https://stackoverflow.com/questions/27772861/get-serial-com-port-description-in-windows-batch
@echo off
:start

set MyFile=QC_Firmware_Vietduino_4__n17_11_2019_Nano.hex
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

echo --------------------------------------------------------------------------------
echo ---dbbbb----------sbbP----------------------------------------------------------
echo ---dbbbbb---------sbbP----------------------------------------------------------
echo ---dbbPbbbp-------sbbP--------pppppp--------pp----pppp------------ppppp---------
echo ---dbbP-Sbbb------sbbP-----pbbbbbbbbbbb-----bbQpbbbbbbbbp-----sQbbbbbbbbbp------
echo ---dbbP---Qbbp----sbbP----bbP-------SbbP----bbbP------Qbb----pbbP-------Qbb-----
echo ---dbbP----Sbbb---sbbP-------------ppbbP----bbb-------QbbC--sbbP---------bbb----
echo ---dbbP------Qbbp-sbbP-----pbbbbbbbbPbbP----bbb-------QbbC--dbbP---------Qbb----
echo ---dbbP-------SbbbdbbP---qbbP--------bbP----bbb-------QbbC---bbb---------bbP----
echo ---dbbP---------QbbbbP---Qbbp------qbbbb----bbb-------QbbC---Sbbp------qbbD-----
echo ---dbbP----------SbbbP----bbbbbbbbbbPQbb----bbb-------QbbC-----bbbbbbbbbbP------
echo --------------------------------------------------------------------------------
          
set /p choice="Nhan Enter de nap board NANO tiep theo. Nhan "y" sau do Enter de tat cua so"
if '%choice%'=='' goto start
if not '%choice%'=='y' set choice=%choice:~0,1%
rem set /p DUMMY=Hit ENTER to continue...

