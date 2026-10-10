@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

echo 正在处理当前目录下的所有视频文件...
echo.

echo 请选择加速倍数:
echo 1. 1.25x
echo 2. 1.50x
echo 3. 1.75x
echo 4. 2.00x
set /p "CHOICE=请输入 1、2、3 或 4: "
if not defined CHOICE set "CHOICE=2"

if "%CHOICE%"=="1" (
    set "SPEED=1.25"
    set "SPEED_TAG=1.25x"
) else if "%CHOICE%"=="2" (
    set "SPEED=1.5"
    set "SPEED_TAG=1.5x"
) else if "%CHOICE%"=="3" (
    set "SPEED=1.75"
    set "SPEED_TAG=1.75x"
) else if "%CHOICE%"=="4" (
    set "SPEED=2.00"
    set "SPEED_TAG=2.00x"
) else (
    echo 无效选项，请输入 1、2、3 或 4。
    pause
    exit /b 1
)

for %%F in (*.mp4 *.mkv *.mov *.flv *.avi) do (
    set "FILENAME=%%~nF"
    
    :: 跳过已生成的加速文件，避免重复处理
    if /i not "!FILENAME:~-6!"=="_1.25x" if /i not "!FILENAME:~-5!"=="_1.5x" if /i not "!FILENAME:~-6!"=="_1.75x" if /i not "!FILENAME:~-6!"=="_2.00x" (
        echo ----------------------------------------------------
        echo 正在处理: "%%F"
        
        set "INPUT=%%F"
        set "OUTPUT=!FILENAME!_!SPEED_TAG!.mp4"
        set "TEMP_RAW=temp_!RANDOM!.264"

        :: 1. 用 ffprobe 获取帧率比值（如 25/1 或 30000/1001）
        for /f "usebackq delims=" %%A in (`ffprobe -v error -select_streams v:0 -show_entries stream^=r_frame_rate -of csv^=p^=0 "!INPUT!"`) do (
            set "FPS_RATIO=%%A"
        )

        :: 2. 调用 powershell 精准计算所选倍速对应的新帧率
        for /f "usebackq delims=" %%B in (`powershell -NoProfile -Command "$fps = ([double]('!FPS_RATIO!'.Split('/')[0]) / [double]('!FPS_RATIO!'.Split('/')[1])) * [double]'!SPEED!'; $fps.ToString('0.########', [Globalization.CultureInfo]::InvariantCulture)"`) do (
            set "NEW_FPS=%%B"
        )

        echo 检测到原始帧率: !FPS_RATIO!，加速后帧率: !NEW_FPS!

        :: 3. 提取 H.264 裸流（加入 h264_mp4toannexb 滤镜，补齐 SPS/PPS 头部）
        ffmpeg -y -v error -i "!INPUT!" -an -c:v copy -bsf:v h264_mp4toannexb "!TEMP_RAW!"

        :: 4. 以新帧率无损封装，同时按相同倍速加速音频
        ffmpeg -y -v fatal -r !NEW_FPS! -i "!TEMP_RAW!" -i "!INPUT!" -map 0:v -map 1:a? -c:v copy -filter:a "atempo=!SPEED!" "!OUTPUT!"

        :: 5. 删除临时裸流
        if exist "!TEMP_RAW!" del "!TEMP_RAW!"

        echo 完成: "!OUTPUT!"
    )
)

echo.
echo ====================================================
echo 全部视频处理完毕！
pause