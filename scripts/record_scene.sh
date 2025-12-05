#!/usr/bin/env bash
set -e

OUT_DIR=/data/rosbags
mkdir -p "$OUT_DIR"

STAMP=$(date +%Y%m%d_%H%M%S)
NAME=${1:-scene}
BAG_PREFIX="${NAME}_${STAMP}"

rosbag record -b 2048 \
  /depth_to_rgb/camera_info \
  /depth_to_rgb/hw_registered/image_rect \
  /depth_to_rgb/image_raw \
  /rgb/camera_info \
  /rgb/image_raw \
  /rgb/image_rect_color \
  /tf_static \
  /tf \
  -O "${OUT_DIR}/${BAG_PREFIX}"
