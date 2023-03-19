@echo off
title MIO-KITCHEN
if exist %~dp0bin/log.txt del bin/log.txt
mode con cols=60 lines=32
if exist %~dp0bin\bdcs.bat start /b cmd /v:on /c "%~dp0bin\bdcs.bat"
set main=%0
rem Check path
for /f "tokens=1-4 delims= " %%c in ("%~dp0") do (
	if not "%%d"=="" (
		echo.目录中存在空格，请重新配置路径
		echo.There are spaces in the directory, please reconfigure the path
		pause
		exit /b 1
	)
)
:load
setlocal enabledelayedexpansion
cd %~dp0
if not "!errorlevel!"=="0" (echo.Cannot load bins....&pause&exit)
set cjgl=%~dp0bin\plug\Manager.cmd
set angxjb=META-INF/com/google/android/update-binary
set setsave=%~dp0bin\setting.ini
set aml=%~dp0bin\plug\addmenu.txt
for /f "delims=" %%u in ('findstr /v /b "#" %setsave%') do (set "%%u")
if "!debug!"=="0" (
	set slog=^>^>!local!/bin/log.txt
	) else (set slog=1^>nul 2^>nul)
for /f "delims=" %%o in ('!cygpath! %~dp0^|!sed! "s/cygdrive/mnt/g"') do (set wslpath=%%o)
set delta_generator=!wslpath!bin/delta_generator
set bls=!busybox! ls
set du=!busybox! du
if not exist bin\language\%language_u%.txt (
set qyts=Set your language
call :set_language
goto :load
) else (
set ln=1
for /f "delims=" %%l in (bin\language\!language_u!.txt) do (
set "t!ln!=%%l"
set /a ln=!ln!+1))
:cmdtool
if "%1"=="-h" (
	call :ce MIO-KITCHEN V%VERSION%
	!cecho! {0c} -i {#}{0a}Rom File{#}{\n}
	echo                 Unpack Rom File
	!cecho! {0c} -h {#}{0a}Help{#}{\n}
	echo                 Show Help
	!cecho! {0c} [File] {#}{\n}
	echo                 Unpack File
	pause
	exit /b 0
) else (
	if not "%1"=="" (
		if "%1"=="-i" (
			if not exist "%2" (
				call :er rom cmdtool
				exit /b 0
			) else (call :jbz %2)
		)
		if exist "%1" (call :jbz %1) else (!cecho! {0c}!t5!{#}{\n})
		)
)
:hm
set sparse=0
for /f "delims=" %%u in ('findstr /v /b "#" %setsave%') do (set "%%u")
for %%i in (romxa xz rom zy romdz xmmc modbj xz zl Device) do (set %%i=)
set dat=1
set br=1
set dbzl=0
cls
call :ce MIO-KITCHEN V%VERSION% %t111%:M.K.C-TEAM
echo.%fgf%
!figlet! -f !figletfont! !zywz!|!lolcat!
!cecho! {0c}%~dp0{#}{\n}
echo %fgf%
call :cx  %t1%
echo %fgf%
set nuu=1
for /d %%a in (*) do (
if not %%a==bin (
call :ce [!nuu!] [%%a]
set g!nuu!=%%a
set /a nuu=!nuu!+1
))
echo.%fgf%
echo %PROCESSOR_ARCHITECTURE%
echo Super %t65%=!supers!
echo %fgf%
echo [02].%t3% [03].%t31%
if "!lwms!"=="ON" (echo [04].%t24% [05].%t74%&echo.[07].%t112%)
echo [09].%t26% [01].%t4%
call :addmenu
echo [00].%t21%
set /p zy=%t7%
if "%zy%"=="00" goto :delxm
if "%zy%"=="02" call :jbsz
if "%zy%"=="03" goto :mp
if "%zy%"=="04" goto :download-rom
if "%zy%"=="05" goto :hqmiui
if "%zy%"=="06" call :cu
if "%zy%"=="09" call :setting
if "%zy%"=="07" call !report!
if "%zy%"=="01" exit
if exist !zy! (call :jbz !zy!)
if exist !g%zy%! (set xmmc=!g%zy%!&cd !g%zy%!&goto :menu)
echo.%t5%&pause&goto :hm
:delxm
set /p xmmcd=%t16%
for %%i in (!xmmcd!) do (
if "%%i"=="" (call :er Project)
if exist !g%%i! (echo.%t51%!g%%i!&!rm! -rf !g%%i!)
)
goto :hm
:hqmiui
call :tgui "!t83!" "!t83!" Device Device
if "!Device!"=="" (goto :hm)
ECHO.%t79%...
set sfxz=
for /f "tokens=*" %%i in ('!busybox! bash bin\getRecoveryROM.sh !Device!') do (
	call :cx %t80%: %%i
	set /p sfxz=%t81%[Y/N] --^>
	if "!sfxz!"=="Y" (set xzlj=%%i&call :download)
)
pause
goto :hm
:mp
cd %local%
call :tgui "%t17%" "%t17%" New xjxm
if exist !xjxm! (echo.%t11%&goto :mp)
if "!xjxm!"=="" goto :hm
md !xjxm!
if "!errorlevel!"=="0" (
	set xmmc=!xjxm!
	cd !xjxm!
goto :menu) else (goto :hm)
:bandizip
if "%1"=="j" (!bz! x %2 %3 %slog%
if not "!errorlevel!"=="0" goto :hm)
if "%1"=="d" !bz! a -r -aoa !local!\%2.zip !cd!\* %slog%
exit /b 0
:p7zip
if "%1"=="j" (!p7zip! x %2 -o./%3/ -y %slog% 
if not "!errorlevel!"=="0" goto :hm)
if "%1"=="d" !p7zip! a -tzip !local!\%2.zip !cd!\* %slog%
exit /b 0
:jbsz
set romxa=&set rom=
for /f "delims=" %%i in ('!zenity! --file-selection --title="%t7%ROM"^|!iconv! -f utf-8 -t gbk') do (set rom=%%i)
if "!rom!"=="bin" (echo.%t14%&goto :jbsz)
if "!rom!"=="" (call :er ROM)
if not exist %rom% (call :er ROM)
call :jbz %rom%
:jbz
set kzm=%~x1
set kzms=%~x1
set uz=1
for /f %%i in ('echo%~x1^|!busybox! tr a-z A-Z') do (set kzms=%%i)
if exist %~n1 (set xmmc=%~n1_%time:~9,2%) else (set xmmc=%~n1)
call :cxm t19 xmmc
echo %t10% [%kzms%]:%~nx1
if "%2"=="link" (set zqlj=) else (set zqlj=%~dp1)
if "!kzm!"==".img" (
	set uz=0
	md !xmmc!
move !zqlj!%~nx1 %xmmc%)
if "!kzm!"==".ozip" (!pybox! ozip2zip !zqlj!%~nx1&!rm! -rf %~nx1&set kzm=.zip)
if "!kzm!"==".ops" (!opscrypto! decrypt !zqlj!%~n1.ops&set kzm=.zip)
if "!kzm!"==".ofp" (
	set /p clqlx=%t49%？[MTK/QC]
	if "!clqlx!"=="MTK" (!pybox! ofp_mtk_decrypt !zqlj!%~n1.ofp %xmmc%) else (!pybox! ofp_qc_decrypt !zqlj!%~n1.ofp %xmmc%))
if "!uz!"=="1" (mkdir !xmmc!&call :!yscx! j !zqlj!%~n1!kzm! !xmmc!)
if "!zqlj!"=="" (
	if exist %~n1%kzm% (!rm! -rf %~n1%kzm%)
	if exist %~nx1 (!rm! -rf %~nx1))
cd %cd%\!xmmc!\
goto :menu
:jb
if not exist config mkdir config
if exist UPDATE.APP (
	echo.%t9% [APP]:UPDATE.APP
	!splituapp! -f ./UPDATE.APP %slog%
	if exist UPDATE.APP del UPDATE.APP
	if exist super.img (!simg2img! super.img super_raw.img
	del super.img
	move super_raw.img super.img)
	if exist super_2.img (!simg2img! super_2.img super_2_raw.img
	del super_2.img
	move super_2_raw.img super_2.img)
	)
if exist super.img.1 (
	fd=1
	echo.%t9% [Section]:super
	for /f %%a in ('!busybox! ls -d super.img.*') do (
		set fdjx=!fdjx! super.img.!fd!
		set /a fd=!fd!+1
	)
	!rm! -rf super.img.*
	!simg2img! !fdjx! super.img
)
if exist images (!mv! images/* ./)
if exist super.img.zst (!zstd! --rm -d super.img.zst -o super.img)
if exist super.dxy (!zstd! --rm -d super.dxy -o super.img)
if exist system.new.dat.1 (
echo.vivo>vivo
for /f %%h in ('dir /b *.new.dat'^|!sed! 's/.new.dat//g') do (
echo.%%h
if exist %%h.new.dat.1 (
ECHO.%t46% %%h
set fd=1
for /f %%a in ('!busybox! ls -d %%h.new.dat.*') do (
	set fdjx=!fdjx! %%h.new.dat.!fd!
	set /a fd=!fd!+1
	)
type %%h.new.dat !fdjx!>%%h.new.dat2
!rm! -rf %%h.new.dat.*
!rm! -rf %%h.new.dat
move %%h.new.dat2 %%h.new.dat
set fdjx=&set fd=1
)
)
)
for /f %%h in ('dir /b *.lz4 2^>nul') do (
if exist %%h (
	echo.%t9% [LZ4]:%%h
	!lz4! -d %%h %%~nh
!rm! -rf %%h))
if exist payload.bin (
	echo %t9% [Payload]:payload.bin
	!payloadunpack! -o !cd! !cd!\payload.bin
	ECHO.2>supersz
	if exist boot.img !rm! -rf payload.bin)
if exist super.img (
	echo %t9% [Super]:Super.img
	for /f "delims=" %%h in ('!xxd! -p -l 4 super.img 2^>nul') do ( if "%%h"=="3aff26ed" (call :simg2img super))
	for /f "delims=" %%h in ('!xxd! -p -l 4 super_2.img 2^>nul') do ( if "%%h"=="3aff26ed" (call :simg2img super_2))
	if exist super.img (
		%lpunpack% %cd%\super.img %cd%  %slog%
		!busybox! wc -c <%cd%\super.img > config\super_size.txt
		)
	if exist super_2.img  %lpunpack% %cd%\super_2.img %cd% %slog%
	if exist system_a.img (
		ECHO.2>supersz
		!rm! -rf super.img
		!rm! -rf super_2.img
		for /f %%i in ('!bls! "*_a.img"^|!sed! 's/_a//g'') do  (ren %%~ni_a.img %%~ni.img )
	) else (
		ECHO.1>supersz
		!rm! -rf super.img
		!rm! -rf super_2.img
)
)
if exist system.img_sparsechunk* (
	ECHO.%t46% system.img_sparsechunk^*
	for %%a in (system.img_sparsechunk*) do (!sparse2img! %%a system.img))
for /r %%k in (*.new.dat.br *.dat *.img) do (
for /f "tokens=1-4 delims=." %%a in ("%%~nxk") do (call :ubdi %%a)
if not exist config (md config)
)
)
goto :menu
:ubdi
for %%i in (!spart!) do (if "%1"=="%%i" (echo. !t113! %1&exit /b 0))
if exist %1.new.dat.br echo %t9% [BR]:%1.new.dat.br&%brotli% -dj %1.new.dat.br
if exist %1.new.dat (
echo %t9% [DAT]:%1.new.dat
!pybox! sdat2img %1.transfer.list %1.new.dat %1.img %slog%
if exist %1.img del %1.new.dat %1.transfer.list %1.patch.dat )
if not exist config md config
if exist %1.img (
for /f "delims=" %%h in ('!xxd! -p -l 4 %1.img ') do (
	if "%%h"=="3aff26ed" (call :simg2img %1)
	if "%%h"=="73717368" (call :unsquashfs %1)
	)
for /f "delims=" %%e in ('!xxd! -p -s "!erofsoff!" -l !len! %1.img 2^>nul') do ( if "%%e"=="!erofsmagic!" (
ECHO.%t9% [IMG-EROFS]:%1.img
rem !erofsUnpack! %1.img !cd!\ > config\%1_erofs
!extracterofs! -i %1.img -o !cd!\ -x > config\%1_erofs
call :erofs_fsfix %1
if exist %1 !rm! -rf %1.img ))
for /f "delims=" %%w in ('!xxd! -p -s "!ext4off!" -l !len! %1.img 2^>nul') do (
if "%%w"=="!ext4magic!" (
ECHO.%t9% [IMG-EXT]:%1.img
!pybox! imgextractor %1.img %cd%\ %slog%
if exist %1 !rm! -rf %1.img )))
exit /b 0
:erofs_fsfix
rem 非常不幸，此段补丁已被DXY抄袭！
!sed! -i '2i /lost+found 0 0 0700' config/%1_fs_config
!sed! -i '2i /lost\\\+found u:object_r:system_file:s0' config/%1_file_contexts
!sed! -i '2i /%1/lost\\\+found u:object_r:system_file:s0' config/%1_file_contexts
if exist %1/media/theme/miui_mod_icons/dynamic  (
!rm! -rf %1/media/theme/miui_mod_icons/dynamic/com.google.android.apps.nbu.
)
if exist %1/%1/media/theme/miui_mod_icons/dynamic  (
!rm! -rf %1/%1/media/theme/miui_mod_icons/dynamic/com.google.android.apps.nbu.
)
if exist %1/etc/?permissions? (!rm! -rf %1/etc/?permissions?)
exit /b 0
:unsquashfs
echo.%t9% [IMG-squashfs]:%1.img
!unsquashfs! %1.img > config\%1_squashfs
move squashfs-root %1
if exist %1 !rm! -rf %1.img
exit /b 0
:simg2img
ECHO.%t9% [SPARSE]:%1.img
!simg2img! %1.img %1_raw.img
if exist %1_raw.img (!rm! -rf %1.img)
move %1_raw.img %1.img
exit /b 0
:menu
cls
set xz=&set zl=&set dat=1&set br=1&set dbzl=0&set sparse=0&set payload=0
!cecho! {0b}
echo.%fgf%
ECHO.!date! !time!
for /f %%i in ('dir /b /s "build.prop" 2^>nul') do (
	for /f "eol=# tokens=1-3* delims==" %%1 in (%%i) do (
	if %%1==ro.miui.ui.version.name echo.%t87%:%%2
	if %%1==ro.build.version.sdk echo.%t88%:%%2
	if %%1==ro.build.version.release echo.%t89%:%%2
	if %%1==ro.product.locale echo.%t90%:%%2
	if %%1==ro.product.model echo.%t91%:%%2
	if %%1==ro.dolby.model echo.%t91%:%%2
	if %%1==ro.product.name echo.%t92%:%%2
	if %%1==ro.dolby.device echo.%t92%:%%2
	if %%1==ro.product.cpu.abi echo.%t93%：%%2
	)
)
echo.%fgf%
!cecho! {0a}!t19!%xmmc%{#}{\n}
!cecho! {03}
set romdz=%cd%
!cecho! [1].%t23% [2].%t20% %xmmc%{\n}
!cecho! [3].%t35% [4].%t30%{\n}
!cecho! [5].%t58% boot [6].%t57% boot{\n}
!cecho! [7].%t58% dtbo [8].%t57% dtbo{\n}
!cecho! [9].%t58% logo [10].%t57% logo{\n}
!cecho! [11].%t57% super.img{\n}
!cecho! [12].%t99% [13].%t59%{\n}
!cecho! [14].%t57% %t78% [15].%t57% DAT{\n}
!cecho! [16].%t58% %t108% %t78% [17].%t57% %t108% %t78%{\n}
call :addmenu cr
!cecho! [18] %t57% Payload{\n}
!cecho! {0c}[0].%t22% {#}{\n}
!cecho! {07}
set /p xz=%t7%
call :addmenu pd !xz!
if "!xz!"=="" cls&goto :menu
if "!xz!"=="1" set dbzl=1&call :dbrom
if "!xz!"=="2" cd %local%&echo.%t51%%romdz%&!rm! -rf %romdz%&goto :hm
if "!xz!"=="3" call !cjgl!
if "!xz!"=="4" call :jb
if "!xz!"=="5" call :jboot
if "!xz!"=="6" call :dboot
if "!xz!"=="7" call :jdtbo
if "!xz!"=="8" call :ddtbo
if "!xz!"=="9" call :jlogo
if "!xz!"=="10" call :dlogo
if "!xz!"=="11" set dat=0&goto :psuper
if "!xz!"=="12" set modbj=1&call :dbrom
if "!xz!"=="13" call :tqdgjx
if "!xz!"=="14" set dat=0&goto :PIMG
if "!xz!"=="15" set br=0&call :dbrom
if "!xz!"=="0" cd %local%&goto :hm
if "!xz!"=="16" goto :uci
if "!xz!"=="17" goto :pci
if "!xz!"=="18" set payload=1&call :dbrom
pause
goto :menu
:pci
set /p ina=%t71% %t78% %t109%
echo.[0].Sparse [1].Raw
set /p sparse=%t71%
if exist !ina!.img (
if "!sparse!"=="1" for /f "delims=" %%z in ('!xxd! -p -s "!ext4off2!" -l !len! "!ina!.img"') do (if "%%z"=="!ext4magic!" (call :simg2img !ina!))
if "!sparse!"=="0" for /f "delims=" %%z in ('!xxd! -p -s "!ext4off!" -l !len! "!ina!.img"') do (if "%%z"=="!ext4magic!" (call :img2simg !ina!))
)
if exist !ina! call :mimg !ina!
if "!Sparse!"=="0" (
set /p dat=%t57% !ina!.new.dat[1/0]
set /p br=%t57% !ina!.new.dat.br[1/0]
call :datbr !ina!)
goto :menu
:uci
set /p ina=%t62%
call :ubdi !ina!
set ina=
goto :menu
:loadsuper
for /f %%k in ('dir /b *.img 2^>nul^|!busybox! sed "s/dsp//g;s/vm-bootsys//g;s/cust//g;s/userdata//g"') do (
if exist %%~nk.img (for /f "delims=" %%e in ('!xxd! -p -s "!erofsoff!" -l !len! %%~nk.img ') do (if "%%e"=="!erofsmagic!" (set superlb=%%~nk !superlb!))
for /f "delims=" %%e in ('!xxd! -p -s "!ext4off!" -l !len! %%~nk.img ') do (if "%%e"=="!ext4magic!" (set superlb=%%~nk !superlb!))
))
exit /b 0
:psuper
cls
if "!ssparse!"=="0" (set sparse_xz=ON) else (set sparse_xz=OFF)
echo.%t57%super
set superlb=
if exist !dtbj! (call :readsuper) else (call :loadsuper)
call :super-info
echo.[1].VAB [2].A-only
ECHO.[3].Sparse:%sparse_xz%
set /p sfqlx=%t60%？
if "!sfqlx!"=="1" echo.2>supersz&call :dbrom
if "!sfqlx!"=="2" echo.1>supersz&call :dbrom
if "!sfqlx!"=="3" (if "!ssparse!"=="0" (set ssparse=1) else (set ssparse=0)
goto :psuper)
goto :menu
:jlogo
for /f %%i in ('dir /b /s logo.img') do set logo=%%i
if "!logo!"=="" call :er LOGO menu
if exist !logo! (md logo&call !logo_dumper! !logo! extract %cd%\ ) else (call :er LOGO menu)
exit /b 0
:dlogo
for /f %%i in ('dir /b /s logo.img') do set logo=%%i
if "!logo!"=="" call :er LOGO menu
if exist !logo! (call !logo_dumper! !logo! inject %cd%\ ) else (call :er menu)
exit /b 0
:jdtbo
for /f %%i in ('dir /b /s dtbo.img') do (set dtbofile=%%i)
if "!dtbofile!"=="" (call :er !dtbofile! menu)
if not exist !dtbofile! (call :er !dtbofile! menu)
set csd=
!rm! -rf dtbo
mkdir dtbo\dtbo 2>nul
mkdir dtbo\dts 2>nul
!mkdtboimg! dump !dtbofile! -b %cd%\dtbo\dtbo\dtbo > %cd%\dtbo\dtbo_imageinfo.txt
if exist !dtbofile! (!rm! -rf !dtbofile!)
for /f "tokens=*" %%i in ('!bls! %cd%\dtbo\dtbo\') do (
if "!csd!"=="" set csd=-1
set /a csd=!csd!+1
echo %t97% dtbo.!csd!为dts.!csd!
!dtc! -@ -i "dtb" -O "dts" %cd%\dtbo\dtbo\dtbo.!csd! -o %cd%\dtbo\dts\dts.!csd! %slog%)
!rm! -rf %cd%\dtbo\dtbo
echo.Done!
exit /b 0
:ddtbo
if not exist %cd%\dtbo\dts\ call :er dts menu
set csd=&set wjs=
!rm! -rf %cd%\dtbo\dtbo
mkdir dtbo\dtbo
for /f "tokens=*" %%i in ('!bls! %cd%\dtbo\dts\') do (
if  "!csd!"=="" set csd=-1
set /a csd=!csd!+1
echo %t98% dts.!csd!为dtbo.!csd!
set wjs=!wjs! %cd%\dtbo\dtbo\dtbo.!csd!
!dtc! -@ -i "dts" -O "dtb" %cd%\dtbo\dts\dts.!csd! -o %cd%\dtbo\dtbo\dtbo.!csd! %slog%
)
!mkdtboimg! create %cd%\dtbo.img --page_size=4096 !wjs!
!rm! -rf dtbo
ECHO Done!
exit /b 0
:jboot
if exist boot (rd  /s /q boot)
mkdir boot
if exist boot.img (call !jboot! %cd%\boot.img) else (call :er boot menu)
exit /b 0
:dboot
if exist boot (call !dboot!) else (call :er boot menu)
exit /b 0
:jtdq
if exist config\%1_size.txt call :ol %t32% [%t33%]:%1.....
set /p size=<"config\%1_size.txt"
echo.!size! B
if exist %1 !fspatch! %1 config\%1_fs_config %slog%
exit /b 0
:dtdq
if exist %1 (
!fspatch! %1 config\%1_fs_config %slog%
call :ol %t32% [%t34%]:%1......
for /f %%i in ('!busybox! du -sb !cd!\%1^|!busybox! cut -f 1') do (set ts=%%i)
if "!ts!"=="0" set ts=4096
call :rsize !ts!
echo.!size! B
if exist !dtbj! (
!sed! -i "s/resize %1\s.*/resize %1 !size!/" !dtbj! %slog%
!sed! -i "s/# Grow partition %1 from 0 to\s.*/# Grow partition %1 from 0 to !size!/" !dtbj! %slog%
!sed! -i "s/resize %1_a\s.*/resize %1_a !size!/" !dtbj! %slog%
!sed! -i "s/# Grow partition %1_a from 0 to\s.*/# Grow partition %1_a from 0 to !size!/" !dtbj! %slog%)
)
exit /b 0
:readsuper
for /f "eol=# tokens=1-3* delims= " %%1 in (!dtbj!) do (
if %%1==add_group (set dbfz=%%2&set supers=%%3)
if %%1==resize (set superlb=%%2 !superlb!)
)
exit /b 0
:dbrom
if exist boot (call !dboot!)
cd %romdz%
if "!modbj!"=="1" (
set dbzl=1
set ssparse=1
if exist META-INF !rm! -rf META-INF
!busybox! cp -r !local!/bin/FlashTool/* ./
if exist !dtbj! (echo.1>supersz) else (echo.2>supersz))
if exist supersz (set sparse=1)
for /d %%a in (*) do (
if exist config\%%a_squashfs (
	echo.!t15! [IMG-squashfs]:%%a.img
	!mksquashfs! %%a %%a.img
	if exist %%a.img !rm! -rf %%a
)
call :mimg %%a
)
if exist vm.img (move vm.img vm-bootsys.img)
if exist supersz (
	if "!ssparse!"=="0" (set spa=--sparse) else (set spa=)
	set /p sf=<supersz
	if exist config\super_size.txt (set supers=<config\super_size.txt)
	set superlb=
	if exist !dtbj! (call :readsuper)
	echo.%t15% [Super]:super.img
if exist super (!rm! -rf super&md super) else (md super)
if not defined superlb (call :loadsuper)
if "!superlb!"=="" (call :loadsuper)
call :super-info
if "!sf!"=="1" (
if not exist super (mkdir super)
md super
for %%i in (!superlb!) do (if exist %%i.img (move %%i.img %cd%\super\%%i.img))
for /f %%i in ('!bls! "super/*.img"') do (
set size=%%~zi
set cod=--partition %%~ni:!supersx!:!size!:!dbfz! --image %%~ni=super\%%~ni.img
set full=!full! !cod!
set command=)
ECHO.A-only
if "!modbj!"=="1" (echo.A>META-INF/da
set scriptmt=A
!busybox! sed -i "s/(#parttype#)/A/g" !angxjb!
)
%lpmake% --metadata-size 65536 -super-name super -metadata-slots 2 -device super:!supers! --group !dbfz!:!supers! !full! !spa! --out super.img %slog%
set sparse=0
if exist super.img (!rm! -rf super)
)

if "!sf!"=="2" (
if not exist super (mkdir super)
md super
for %%i in (!superlb!) do (if exist %%i.img (move %cd%\%%i.img %cd%\super\%%i.img))
for /f %%d in ('!bls! "super/*.img"') do (
set size2=%%~zd
set ml1=--partition %%~nd_a:!supersx!:!size2!:!dbfz!_a --image %%~nd_a=super\%%~nd.img
set ml2=--partition %%~nd_b:readonly:0:!dbfz!_b
set "full=!full! !ml1!"
set "full2=!full2! !ml2!"
set ml1=
set ml2=
)
ECHO.V-AB
if "!modbj!"=="1" (echo.AB>META-INF/ota
set scriptmt=AB
!busybox! sed -i "s/(#parttype#)/AB/g" !angxjb!
)
%lpmake% --metadata-size 65536 -super-name super -metadata-slots 3 -device super:!supers! --group !dbfz!_a:!supers! !full! --group !dbfz!_b:!supers! !full2! --virtual-ab !spa! --out super.img %slog%
if exist super.img (!rm! -rf super)
set sparse=0
)
if "!modbj!"=="1" (
	if not exist images md images
	if not exist image md image
	if exist firmware-update (
		!mv! firmware-update/* ./image
		!rm! -rf firmware-update)
	if exist super.img (
	!zstd! -5 --rm super.img
	!mv! super.img.zst ./images
	!mv! *.bin ./image)
	!mv! *.img ./image
	for %%i in (preloader_raw preloader_ufs preloader_emmc) do (if exist image\%%i.img move image\%%i.img images\%%i.img)
	for /f %%g in ('!bls! "image/*.img"') do (
	if exist image\%%~ng.img (
	move image\%%~ng.img images\%%~ng.img
	if "!scriptmt!"=="AB" (
    !busybox! sed -i "/#oi/i package_extract_file \"images/%%~ng.img\" \"/dev/block/bootdevice/by-name/%%~ng_a\"" !angxjb!
    !busybox! sed -i "/#oi/i package_extract_file \"images/%%~ng.img\" \"/dev/block/bootdevice/by-name/%%~ng_b\"" !angxjb!
    )
    if "!scriptmt!"=="A" (!busybox! sed -i "/#oi/i package_extract_file \"images/%%~ng.img\" \"/dev/block/bootdevice/by-name/%%~ng\"" !angxjb!
    )
    ))
    !busybox! dos2unix !angxjb!
    !busybox! cp -r image/* ./images/
	!rm! -rf image
)
)
if "!payload!"=="1" goto :ppayload
for /f  %%o in ('dir /b *.img 2^>nul ^|!sed! 's/_new//g'') do (call :datbr %%~no )
if "!dbzl!"=="1" !rm! -rf config&echo.%t15% [ZIP]:%xmmc%.zip&call :!yscx! d !xmmc!
if "!modbj!"=="1" (cd !local!
if exist !local!\!xmmc!.zip !rm! -rf !xmmc!
echo.%t96%:!local!\!xmmc!.zip
if "!modbj!"=="1" pause&goto :hm) else (goto :menu)
:img2simg
if exist %1.img (
echo.%t15% [sparse]:%1.img
!img2simg! %cd%\%1.img %cd%\%1_s.img %slog%
!rm! -rf %1.img
move !cd!\%1_s.img !cd!\%1.img
)
exit /b 0
:datbr
if exist %1_new.img call :img2simg %1_new
if exist %1.img for /f "delims=" %%z in ('!xxd! -p -s "!ext4off2!" -l !len! "%1.img"') do (
if "%%z"=="!ext4magic!" if "!dat!"=="1" echo.%t15% [DAT]:%1.new.dat&!img2sdat! %1.img -o %cd%\ -v 4 -p %1 %slog%
if exist %1.new.dat !rm! -rf %1.img )
if exist %1.new.dat if "!br!"=="1" echo.%t15% [BR]:%1.new.dat.br&!brotli! -q !brgl! -j -w 24 %1.new.dat -o %1.new.dat.br&!rm! -rf %1.new.dat
exit /b 0
:mimg
if exist config\%1_file_contexts (
if exist !dtbj! (call :dtdq %1) else (
if exist supersz (if exist !dtbj! (call :dtdq %1) else (call :dtdq %1)) else (if not exist config\%1_size.txt (call :dtdq %1) else (call :jtdq %1)))
if exist %1 if exist config\%1_erofs (
echo.%t15% [IMG-EROFS]:%1.img
!mkerofs! --mount-point %1 --fs-config-file config\%1_fs_config --file-contexts config\%1_file_contexts %1.img %1 -z !erofsgs! %slog%
if exist %1.img !rm! -rf %1
) else (
if "!dbfs!"=="1" (call :mke2fs %1) else (call :make_ext4fs %1)
)
)
exit /b 0
:ppayload
for /f %%i in ('dir /b *.img') do (
set "p1=!p1!:%%~ni"
set "p2=!p2!:%%~ni.img"
echo.%t57% %t78%：%%~nxi
)
if not exist payload_properties.txt (call :er payload_properties.txt menu)
if exist !dtbj! (call :readsuper) else (call :loadsuper)
echo.super_partition_groups^=!dbfz!>info.txt
echo.!dbfz!_size^=!supers!>>info.txt
echo.!dbfz!_partition_list^=!superlb!>>info.txt
wsl !delta_generator! --partition_names^=!p1:~1! --new_partitions^=!p2:~1! --dynamic_partition_info_file^=./info.txt
wsl !delta_generator! --in_file^=./payload.bin --properties_file^=./payload_properties.txt
if exist payload.bin (!rm! -rf *.img)
goto :menu
:super-info
if exist supersz (set /p sf=<supersz)
if "!sf!"=="1" (set sfs=A-only) else (if "!sf!"=="2" (set sfs=Virtual-AB) else (set sfs=Unknow))
echo.%fgf%
echo.%t65%:!supers!
echo.%t40%:!dbfz!
echo.%t76%:!superlb!
echo.%t77%:!sfs!
echo.%fgf%
exit /b 0
:rsize
set number=%1
if /i %1 gtr 2684354560 set bs=1.0658
if /i %1 leq 2684354560 set bs=1.1158
if /i %1 leq 1073741824 set bs=1.1258
if /i %1 leq 536870912 set bs=1.1558
if /i %1 leq 104857600 set bs=1.4058
if /i %1 leq 1048576 (set bs=1&set number=2097152)
for /f "tokens=1 delims=." %%i in ('echo !number!*!bs!^|!busybox! bc') do (set size=%%i)
exit /b 0
:PIMG
cls
ECHO.%t57% %t78%
ECHO.[1].%t57% Sparse %t78%
ECHO.[2].%t57% Raw %t78%
ECHO.[3].%t57% Erofs ==^> EXT4
ECHO.[4].%t43%
set /p pixz=%t7%
if "!pixz!"=="1" (set dat=0&set sparse=0&call :dbrom)
if "!pixz!"=="2" (set sparse=1&set dat=0&call :dbrom)
if "!pixz!"=="3" (!rm! -rf config/*_erofs&set sparse=1&set dat=0&call :dbrom)
if "!pixz!"=="4" goto :menu
goto :PIMG
:make_ext4fs
echo.%t15% [IMG]:%1.img
if "!sparse!"=="0" (set sp=-s) else (set sp=)
if exist %1 (!makextfs! -J -T 1 !sp! -S config\%1_file_contexts -l !size! -C config\%1_fs_config -L %1 -a %1 %cd%\%1.img %cd%\%1\ %slog%)
call :dim %1
if "!jxys!"=="ON" if "!sparse!"=="1" !resize2fs! -M %cd%\%1.img %slog%
exit /b 0
:dim
if exist %1.img (
!rm! -rf %1
!rm! -rf %1_new.img
!rm! -rf config/%1_file_contexts
!rm! -rf config/%1_fs_config
)
exit /b 0
:mke2fs
if exist %1 (for /f "tokens=1 delims=." %%u in ('echo !size!/4096^|!busybox! bc') do (set size2=%%u))
echo.%t15% [IMG]:%1.img
!mke2fs! -O ^has_journal -L %1 -I 256 -M /%1 -m 0 -t ext4 -b 4096 %cd%\%1_new.img !size2! %slog%
if exist %1_new.img (
	!e2fsdroid! -e -T 0 -S !cd!\config\%1_file_contexts -C !cd!\config\%1_fs_config -a /%1 -f !cd!\%1 !cd!\%1_new.img %slog%
	if not "!errorlevel!"=="0" !rm! -rf %1_new.img&call :make_ext4fs %1
	)
if "!jxys!"=="ON" (!resize2fs! -M %cd%\%1_new.img %slog%)
if "!sparse!"=="0" (if exist %1_new.img !img2simg! %cd%\%1_new.img %cd%\%1.img&!rm! -rf %1_new.img) else (move %cd%\%1_new.img %cd%\%1.img )
call :dim %1
exit /b 0
:download-rom
set xzlj=
call :tgui "%t25%" "%t25%" Link xzlj
if "%xzlj%"=="" (goto :hm) else (goto :download)
:download
if "!xzyq!"=="1" (
	!aria2c! --max-concurrent-downloads=16 --max-connection-per-server=16 --split=16 --file-allocation=none %xzlj%||goto :hm
) else (
	!axel! -a -n 10 -k %xzlj% ||goto :hm
)
if "!modbj!"=="1" (call :jbz %xzlj% link) else (
!zenity! -question -text="!t44!" -title="MIO-KITCHEN"
if "!errorlevel!"=="0" (call :jbz %xzlj% link) else (goto :hm))
:setting
cls
if "!dbfs!"=="1" (set dbfsn=mke2fs+e2fsdroid) else (set dbfsn=make_ext4fs)
if "!xzyq!"=="1" (set xzyqn=aria2c) else (set xzyqn=axel)
if "!debug!"=="1" (set debugn=OFF) else (set debugn=ON)
call :ce [Language]:%language_u%
call :cx [1].%t28%
call :cxm t27 dbfsn
call :cx [2].mke2fs+e2fsdroid  [3].make_ext4fs
call :ol Super
call :cxm t40 dbfz
call :cx [4].main [5].qti_dynamic_partitions [05].!t108!
call :ol ERofs
call :cxm t50 erofsgs
call :cx [7].lz4 [8].lz4hc [9].lzma
call :ol Super %t57%
call :cxm t65 supers
call :cx [10].%t64% super %t57% %t65%
call :ol Br
call :cxm t70 brgl
call :cx [11].%t64% br %t70%
call :cxm t69 xzyqn
call :cx [12].Aria2c [13].Axel
call :cxm t66 zywz
call :cx [14].%t64% logo %t68% [15].%t64% %t66%
call :cxm t67 debugn
call :cx [16].ON [17].OFF
call :cxm t75 lwms
call :cx [18].ON [19].OFF
call :cxm t101 jxys
call :cx [20].ON [21].OFF
call :ol Super
call :cxm t104 supersx
call :cx [22].none [23].readonly
call :ol %t105%
call :cxm t106 yscx
call :cx [24].p7zip [25].bandizip
call :ol Erofs
call :cxm t110 erofsver
call :cx [28].1.4 [29].1.5 [30].1.6
call :cxm t113 spart
call :cx [31].!t108! !t113!
!cecho! {0e}[0].%t22%{#}{\n}
set /p si=%t7%
if "!si!"=="1" call :set_language
if "!si!"=="2" call :sed dbfs 1
if "!si!"=="3" call :sed dbfs 2
if "!si!"=="4" call :sed dbfz main
if "!si!"=="5" call :sed dbfz qti_dynamic_partitions
if "!si!"=="05" call :tgui "!t64!" "!t40!" "!dbfz!" ndbfz&call :sed dbfz !ndbfz!
if "!si!"=="7" call :sed erofsgs lz4
if "!si!"=="8" call :sed erofsgs lz4hc
if "!si!"=="9" call :sed erofsgs lzma
if "!si!"=="10" call :tgui "!t71!!t65!" "%t72%" "!supers!" supersize&call :sed supers !supersize!
if "!si!"=="11" call :tgui "%t71%%t70%" [0-9] "!brgl!" brgls&call :sed brgl !brgls!
if "!si!"=="12" call :sed xzyq 1
if "!si!"=="13" call :sed xzyq 2
if "!si!"=="14" call :zdlogo
if "!si!"=="15" call :tgui "%t71%%t66%" M.K.C "!zywz!" zywzn&call :sed zywz !zywzn!
if "!si!"=="16" call :sed debug 0
if "!si!"=="17" call :sed debug 1
if "!si!"=="18" call :sed lwms ON
if "!si!"=="19" call :sed lwms OFF
if "!si!"=="20" call :sed jxys ON
if "!si!"=="21" call :sed jxys OFF
if "!si!"=="22" call :sed supersx none
if "!si!"=="23" call :sed supersx readonly
if "!si!"=="24" call :sed yscx p7zip
if "!si!"=="25" call :sed yscx bandizip
if "!si!"=="28" call :sed erofsver 1.4
if "!si!"=="29" call :sed erofsver 1.5
if "!si!"=="30" call :sed erofsver 1.6
if "!si!"=="31" call :tgui "%t108%%t113%" M.K.C "!spart!" nspart&!sed! -i 's/spart=!spart!/spart=!nspart!/g' !setsave!
if "!si!"=="0" cls&goto :load
set fjlb_new=&set si=&set brgls=&set supersize=
for /f "delims=" %%u in ('findstr /v /b "#" %setsave%') do (set "%%u")
goto :setting
:ce
echo.%*|!iconv! -f gbk -t utf-8|!lolcat!
exit /b 0
:ol
set /p "=%1 %2"<nul|!iconv! -f gbk -t utf-8|!lolcat!
exit /b 0
:cxm
!cecho! {0c}!%1!{#}{05} !%2!!%3!{#}{\n}
exit /b 0
:cx
!cecho! {0a}%*{#}{\n}
exit /b 0
:tgui
for /f "delims=" %%i in ('!zenity! --entry --title=%1 --text=%2 --entry-text=%3 -ok-label=!t107!^|!iconv! -f utf-8 -t gbk') do (set "%4=%%i")
if "!%4!"=="" goto :setting
exit /b 0
:sed
%sed% -i 's/%1=!%1!/%1=%2/g' %setsave%
exit /b 0
:zdlogo
cls
set nu=1
for /f %%a in ('!bls! %~dp0bin\fonts\*.flf') do (
echo [!nu!] [%%~na]
!figlet! -f %~dp0bin\fonts\%%~nxa !zywz!|!lolcat!
set g!nu!=%%~nxa
set /a nu=!nu!+1
)
set /p logox=%t63%？
if exist %~dp0bin\fonts\!g%logox%! (%sed% -i '/figletfont=/d' %setsave%&echo.figletfont=bin\fonts\!g%logox%! >> %setsave%)
exit /b 0
:tqdgjx
if exist super.img (ECHO.super.img)
if exist payload.bin (ECHO.payload.bin)
set /p jxmc=!t62!:
if exist payload.bin (!payloadunpack! -output !cd! -partitions !jxmc! payload.bin)
if exist super.img (!lpunpack! -p !jxmc! super.img)
set jxmc=
exit /b 0
:set_language
set num=0
for /f "delims=" %%a in ('dir /b "bin\language\*.txt"') do (
set /a num=!num!+1
echo.[!num!].%%~na
set g!num!=%%~na
set zdy=!num!
)
set /p cj=%t29%%qyts%
if !cj! gtr !zdy! Goto :set_language
if exist bin\language\!g%cj%!.txt call :sed language_u !g%cj%!
call :load
exit /b 0
:addmenu
if "%1"=="cr" for /f %%i in (%aml%) do (if exist %~dp0bin\plug\%%i call %~dp0bin\plug\%%i %1)
if "%1"=="pd" for /f %%i in (%aml%) do (if exist %~dp0bin\plug\%%i call %~dp0bin\plug\%%i %1 %2)
exit /b 0
:er
!zenity! --notification --title="MIO-KITCHEN" --text="%1 %t8%"
pause
if "%2"=="" (goto :hm) else (goto :%2)