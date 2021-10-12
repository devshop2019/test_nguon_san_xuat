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
echo --Qbbbb------------bbbbP--------------------------------------------------------
echo --QbbQbb----------pbDbbP--------------------------------------------------------
echo --Qbb-bbb--------QbPsbbP--------ppppp------------ppppp---pp--------pppppp-------
echo --Qbb--bbp------sbD-sbbP-----pbbbPPPbbbb------pbbbPPPbbbpbb----qbbbPPPPbbbbp----
echo --Qbb--Sbb------bb--sbbP----bbP-------Sbbp---pbD-------bbbb----bbP-------Sbb----
echo --Qbb---Qbb----pbP--sbbP---Qbbppppppppppbb--dbbP--------Qbb-----------ppppbbP---
echo --Qbb----bbp--dbP---sbbP---QbbPPPPPPPPPPPP--Qbb---------Qbb----qbbbbbbbPPQbbP---
echo --Qbb----sbb-sbD----sbbP---Qbbp--------------bbb--------bbb---QbbP-------dbbP---
echo --Qbb-----QbbpbC----sbbP----bbbp------pbbP---Sbbbp----pbbbb---Qbbp------pbbbC---
echo --Qbb------QbbP-----sbbP------bbbbbbbbbP-------PbbbbbbPPQbb----PbbbbbbbbP-bbb---
echo --------------------------------------------------------bbP---------------------
echo ---------------------------------------------Qbbp-----pbbD----------------------
echo ----------------------------------------------PbbbbbbbbPC-----------------------
echo -------------------------------------------------------------------------------

            
set /p choice="Nhan Enter de nap board MEGA2560 tiep theo. Nhan "y" sau do Enter de tat cua so"
if '%choice%'=='' goto start
if not '%choice%'=='y' set choice=%choice:~0,1%
rem set /p DUMMY=Hit ENTER to continue...

