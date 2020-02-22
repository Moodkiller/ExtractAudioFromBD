@echo off
set /p start=Ep Start? 
set /p end=Ep End? 
echo %cd%
set /p AudioProjectsSubDir=Audio Projects Sub Directory? 


for /L %%A in (%start%,1,%end%) do call :subProA "%%A"
pause
goto :EOF

:subProA

set s_num=%~1
if %~1 LSS 10 set s_num=0%~1

"C:/Program Files/MKVToolNix\mkvmerge.exe" --ui-language en --output "Z:\Audio Projects\%AudioProjectsSubDir%\Ep%s_num%.mka" --audio-tracks 1 --no-video --no-subtitles --language 1:eng "(" "Z:\Audio Projects\%AudioProjectsSubDir%\Ep%s_num%.m2ts" ")"

"C:\Program Files\MKVToolNix\mkvextract.exe" --ui-language en tracks "Z:\Audio Projects\%AudioProjectsSubDir%\Ep%s_num%.mka" 0:"Z:\Audio Projects\%AudioProjectsSubDir%\Ep%s_num%_track1_eng.truehd"

"C:\Program Files\eac3to\eac3to.exe" "Z:\Audio Projects\%AudioProjectsSubDir%\Ep%s_num%_track1_eng.truehd" "Z:\Audio Projects\%AudioProjectsSubDir%\Ep%s_num%_track1_eng.flac" -down24

rem TidyUpTime
if not exist mka mkdir mka
move "Z:\Audio Projects\%AudioProjectsSubDir%\Ep%s_num%.mka" "Z:\Audio Projects\%AudioProjectsSubDir%\mka\Ep%s_num%.mka"

if not exist truehd mkdir truehd
move "Z:\Audio Projects\%AudioProjectsSubDir%\Ep%s_num%_track1_eng.truehd" "Z:\Audio Projects\%AudioProjectsSubDir%\truehd\Ep%s_num%_track1_eng.truehd"

if not exist flac mkdir flac
move "Z:\Audio Projects\%AudioProjectsSubDir%\Ep%s_num%_track1_eng.flac" "Z:\Audio Projects\%AudioProjectsSubDir%\flac\Ep%s_num%_track1_eng.flac"

del "Z:\Audio Projects\%AudioProjectsSubDir%\Ep%s_num%_track1_eng - Log.txt"

echo %s_num%
rem ##

goto :EOF
@pause
