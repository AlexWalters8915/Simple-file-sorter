@echo off
@break off
@title File sorter 1.0
@color 0a
@cls

:: Get current user for targeting
set "current_user=%USERNAME%"
:: Target current file location
set "base_directory=%~dp0"
echo You are about to sort the files located at.....
echo %base_directory%\
::prompt for user confirmation
set /p userChoice=Do you want sort this location? (y/n): 

if /i not "%userChoice%"=="y" (
    echo Exiting the script.
    exit /b 0
)

setlocal EnableDelayedExpansion

:: Create folder structure inside "BatSort"
set "baseFolder=C:\Users\%current_user%\Documents\BatSort"
set "folders=pdf Images gif Videos Office\Word Office\Powerpoint Office\Excel MP3"

if not exist "%baseFolder%" (
    mkdir "%baseFolder%"
    echo Main folder created.
)

:: Create all of the needed sub folders 
for %%f in (%folders%) do (
    set "subfolder=%baseFolder%\%%f"
    if not exist "!subfolder!" (
        mkdir "!subfolder!"
        echo Created folder: !subfolder!
    ) 
)

echo Folder structure check complete.....
echo Now sorting files please wait.....
move /Y %base_directory%\*.jpg %baseFolder%\Images\
move /Y %base_directory%\*.png %baseFolder%\Images\
move /Y %base_directory%\*.tiff %baseFolder%\Images\
move /Y %base_directory%\*.pdf %baseFolder%\pdf\
move /Y %base_directory%\*.gif %baseFolder%\gif\
move /Y %base_directory%\*.mp4 %baseFolder%\Videos\
move /Y %base_directory%\*.doc* %baseFolder%\Office\Word\
move /Y %base_directory%\*.ppt %baseFolder%\Office\Powerpoint\
move /Y %base_directory%\*.xlx %baseFolder%\Office\Excel\
move /Y %base_directory%\*.mp3 %baseFolder%\MP3\
::Old does not function as intended
::ROBOCOPY %base_directory% "C:\Users\%current_user%\Documents\BatSort\Images" *.jpg *.png *.tiff /LEV:0 /MOVE
::ROBOCOPY %base_directory% "C:\Users\%current_user%\Documents\BatSort\pdf" *.pdf /LEV:0 /MOVE
::ROBOCOPY %base_directory% "C:\Users\%current_user%\Documents\BatSort\gif" *.gif /LEV:0 /MOVE
::ROBOCOPY %base_directory% "C:\Users\%current_user%\Documents\BatSort\Videos" *.mp4 /LEV:0 /MOVE
::ROBOCOPY %base_directory% "C:\Users\%current_user%\Documents\BatSort\pdf" *.pdf /LEV:0 /MOVE
::ROBOCOPY %base_directory% "C:\Users\%current_user%\Documents\BatSort\Office\Word" *.doc *.docx /LEV:0 /MOVE
::ROBOCOPY %base_directory% "C:\Users\%current_user%\Documents\BatSort\Office\Powerpoint" *.ppt /LEV:0 /MOVE
::ROBOCOPY %base_directory% "C:\Users\%current_user%\Documents\BatSort\Office\Excel" *.xlx  /LEV:0 /MOVE
::ROBOCOPY %base_directory% "C:\Users\%current_user%\Documents\BatSort\Office\MP3" *.mp3 /LEV:0 /MOVE
::Start of used code

:: Check and create the "Length32" folder inside "BatSort\Images"
set "length32Folder=%baseFolder%\Images\Length32"
if not exist "!length32Folder!" (
    mkdir "!length32Folder!"
    echo Created folder: !length32Folder!
) 
:: Checks image folder for file names fitting name standard for textures
for %%I in ("%baseFolder%\Images\*") do (
    set "filename=%%~nxI"
    set "nameLength=0"

    for /l %%A in (0, 1, 31) do (
        set "char=!filename:~%%A,1!"
        if not "!char!"=="" (
            set /a "nameLength+=1"
        )
    )

    if !nameLength! equ 32 (
        move /Y "%%I" "!length32Folder!"
        echo Moved file to Length32 folder: "%%I"
    )
)
Echo Cleanup complete.......
::End
pause
exit