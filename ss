#!/bin/bash
git config --global user.name "hugo-adword"
git config --global user.email "00.hugo.ad@gmail.com"

#tg
tg(){
	bot_api=$bot_api 
	your_telegram_id=$1 
	msg=$2 
	curl -s "https://api.telegram.org/bot${bot_api}/sendmessage" --data "text=$msg&chat_id=${your_telegram_id}&parse_mode=html"
}

id=-1001273969756 
tg $id "DerpFest _Compile _Status: TRIGGERED!.
Triggered _at:- $(date).
https://cirrus-ci.com/build/$CIRRUS_BUILD_ID
https://cirrus-ci.com/task/$CIRRUS_TASK_ID"

mkdir -p /tmp/rom 
cd /tmp/rom

repo init -q --no-repo-verify --depth=1 -u git://github.com/DerpFest-11/manifest.git -b 11 -g default,-device,-mips,-darwin,-notdefault

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j 30 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j 8

#device
git clone https://github.com/adnan-44/device_xiaomi_vince --single-branch -b testing device/xiaomi/vince
git clone https://github.com/adnan-44/vendor_xiaomi_vince --single-branch -b testing vendor/xiaomi/vince --depth 1
git clone https://github.com/Blacksuan19/kernel_dark_ages_vince.git --single-branch -b darky kernel/xiaomi/vince
rm -rf hardware/qcom-caf/wlan && git clone https://android.googlesource.com/platform/hardware/qcom/wlan hardware/qcom-caf/wlan

# Hal
rm -rf hardware/qcom-caf/msm8996
git clone https://gitlab.com/hugo-adword/hardware_qcom_audio.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/audio
git clone https://gitlab.com/hugo-adword/hardware_qcom_display.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/display
git clone https://gitlab.com/hugo-adword/hardware_qcom_media.git --single-branch -b r11.0 hardware/qcom-caf/msm8996/media

cd kernel/xiaomi/vince && git revert fec013b9f5bb70c1e51285aa6e042f21f4298447 --no-edit && cd ../../..

