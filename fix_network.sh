#!/bin/bash

echo "🔧 正在修复 wlan0 无线网络..."

# 重载驱动
echo "♻️ 重载 iwlwifi 模块..."
sudo modprobe -r iwlwifi && sudo modprobe iwlwifi

# 启动接口
echo "📶 尝试启用 wlan0..."
sudo ip link set wlan0 up

# 获取 DHCP 地址
echo "🌐 请求 IP 地址..."
sudo dhclient wlan0

# 确保节能未关闭接口
echo "⚡ 设置 wlan0 电源控制为 on..."
echo on | sudo tee /sys/class/net/wlan0/device/power/control

echo "✅ wlan0 应该已恢复连接！"

