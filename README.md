# VideoSpeedUP

A simple Windows batch tool for speeding up multiple video files in one folder.

[![Windows](https://img.shields.io/badge/Platform-Windows-0078D6)](https://www.microsoft.com/windows)
[![FFmpeg](https://img.shields.io/badge/Engine-FFmpeg-2F6BFF)](https://www.ffmpeg.org/)
[![Batch](https://img.shields.io/badge/Type-Batch%20Script-4CAF50)](https://en.wikipedia.org/wiki/Batch_file)

English | 中文

## Overview

VideoSpeedUP automatically scans the current folder for supported video files, lets you choose a playback speed, and generates accelerated MP4 outputs without overwriting the originals.

## Features

- Batch processing for multiple videos in one directory
- Supports `MP4`, `MKV`, `MOV`, `FLV`, and `AVI`
- Preset speeds: `1.25x`, `1.50x`, `1.75x`, and `2.00x`
- Auto-detects original frame rate and recalculates the output frame rate
- Keeps audio in sync by adjusting tempo automatically
- Outputs files as `filename_speed.mp4`
- Skips already processed files to avoid duplicates

## Quick Start

1. Put your videos in the same folder as `VideoSpeedUp.bat`.
2. Double-click the script.
3. Select the desired speed from the menu.
4. The script processes all compatible videos automatically.

## Example

Input:

- `demo.mp4`

Selected speed:

- `1.5x`

Output:

- `demo_1.5x.mp4`

## Requirements

- Windows 7 or later
- `ffmpeg.exe` and `ffprobe.exe` in the same directory as the script

## Notes

- Files are processed in the current directory only; subfolders are not scanned.
- Output is saved in MP4 format for compatibility and simple playback.
- Files already ending with `_1.25x`, `_1.5x`, `_1.75x`, or `_2.00x` are ignored automatically.

## License

This project is intended for personal and learning use. No separate commercial license is declared.

---

# VideoSpeedUP

一款适用于 Windows 的批量视频加速脚本，能够在同一目录中快速处理多部视频文件。

[![Windows](https://img.shields.io/badge/Platform-Windows-0078D6)](https://www.microsoft.com/windows)
[![FFmpeg](https://img.shields.io/badge/Engine-FFmpeg-2F6BFF)](https://www.ffmpeg.org/)
[![Batch](https://img.shields.io/badge/Type-Batch%20Script-4CAF50)](https://en.wikipedia.org/wiki/Batch_file)

## 项目简介

VideoSpeedUP 会自动扫描当前目录中的视频文件，允许用户选择播放倍速，并生成加速后的 MP4 文件，同时保留原始视频不被覆盖。

## 功能特性

- 批量处理同一目录中的多部视频
- 支持 `MP4`、`MKV`、`MOV`、`FLV`、`AVI`
- 默认倍速：`1.25x`、`1.50x`、`1.75x`、`2.00x`
- 自动检测原始帧率并重新计算输出帧率
- 自动同步调整音频时长与播放速度
- 输出文件命名为 `原文件名_倍速.mp4`
- 自动跳过已处理文件，避免重复生成

## 快速开始

1. 将视频文件放入 `VideoSpeedUp.bat` 所在目录。
2. 双击运行脚本。
3. 在弹出菜单中选择所需倍速。
4. 程序会自动处理目录中的所有兼容视频。

## 示例

输入：

- `demo.mp4`

选择倍速：

- `1.5x`

输出：

- `demo_1.5x.mp4`

## 运行要求

- Windows 7 或更高版本
- 与脚本同目录下存在 `ffmpeg.exe` 和 `ffprobe.exe`

## 说明

- 仅处理当前目录中的视频文件，不会递归处理子目录。
- 输出文件默认保存为 MP4，兼容性更高，便于播放与编辑。
- 已命名为 `_1.25x`、`_1.5x`、`_1.75x`、`_2.00x` 的文件会自动跳过。

## 许可证

本项目仅用于个人学习和日常使用，未声明额外商业许可。
