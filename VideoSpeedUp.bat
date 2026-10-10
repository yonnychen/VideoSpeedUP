@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

echo 正在处理当前目录下的所有视频文件...
echo.

for %%F in (*.mp4 *.mkv *.mov *.flv *.avi) do (
    set "FILENAME=%%~nF"
    
    :: 检查文件名是否以 _1.5x 结尾，避免重复加速
    if not "!FILENAME:~-5!"=="_1.5x" (
        echo ----------------------------------------------------
        echo 正在处理: "%%F"
        
        set "INPUT=%%F"
        set "OUTPUT=!FILENAME!_1.5x.mp4"
        set "TEMP_RAW=temp_!RANDOM!.264"

        :: 1. 用 ffprobe 获取帧率比值（如 25/1 或 30000/1001）
        for /f "usebackq delims=" %%A in (`ffprobe -v error -select_streams v:0 -show_entries stream^=r_frame_rate -of csv^=p^=0 "!INPUT!"`) do (
            set "FPS_RATIO=%%A"
        )

        :: 2. 调用 powershell 精准计算 1.5 倍帧率（避免 CMD 字符转义问题）
        for /f "usebackq delims=" %%B in (`powershell -NoProfile -Command "([double]('!FPS_RATIO!'.Split('/')[0]) / [double]('!FPS_RATIO!'.Split('/')[1])) * 1.5"`) do (
            set "NEW_FPS=%%B"
        )

        echo 检测到原始帧率: !FPS_RATIO!，加速后帧率: !NEW_FPS!

        :: 3. 提取 H.264 裸流（加入 h264_mp4toannexb 滤镜，补齐 SPS/PPS 头部）
        ffmpeg -y -v error -i "!INPUT!" -an -c:v copy -bsf:v h264_mp4toannexb "!TEMP_RAW!"

        :: 4. 以新帧率无损封装，同时将音频加速 1.5 倍
        ffmpeg -y -v fatal -r !NEW_FPS! -i "!TEMP_RAW!" -i "!INPUT!" -map 0:v -map 1:a? -c:v copy -filter:a "atempo=1.5" "!OUTPUT!"

        :: 5. 删除临时裸流
        if exist "!TEMP_RAW!" del "!TEMP_RAW!"

        echo 完成: "!OUTPUT!"
    )
)

echo.
echo ====================================================
echo 全部视频处理完毕！
pause