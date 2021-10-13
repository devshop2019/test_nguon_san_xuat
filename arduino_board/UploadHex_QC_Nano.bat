rem https://stackoverflow.com/questions/27772861/get-serial-com-port-description-in-windows-batch
@echo off
:start

set MyFile=QC_Firmware_Vietduino_4__n17_11_2019_Nano.hex
set charac=
set myCom=COM8
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
%arduino_board%\firmware/avrdude -C%arduino_board%\firmware/avrdude.conf -v -patmega328p -carduino -P%myCom% -b115200 -D -Uflash:w:%~dp0\firmware/%MyFile%:i



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
          
set /p choice="Nhan Enter de nap board NANO tiep theo. Nhap so COM neu COM sai. VD: 10"
if '%choice%'=='' goto start
if not '%choice%'=='y' set choice=%choice:~0,1%
rem set /p DUMMY=Hit ENTER to continue...

if not '%choice%'=='' set myCom=COM%choice%
goto upload