#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box}
#rm -rf feeds/packages/net/adguardhome
rm -rf feeds/luci/applications/luci-app-adguardhome
#git clone https://github.com/kenzok78/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/zow2023/luci-app-adguardhome package/luci-app-adguardhome
rm -rf package/luci-app-adguardhome/patches

#git clone https://github.com/4IceG/luci-app-parentalcontrol package/luci-app-parentalcontrol
git clone https://github.com/VizzleTF/luci-theme-footstrap package/luci-theme-footstrap
git clone https://github.com/rule2c/luci-app-netcontrol package/luci-app-netcontrol

#git clone https://github.com/gaobin89/luci-app-timecontrol package/luci-app-timecontrol
#git clone https://github.com/muink/luci-app-tn-netports package/luci-app-tn-netports

rm -rf feeds/luci/applications/luci-app-dae
rm -rf feeds/luci/applications/luci-app-daed
rm -rf feeds/luci/applications/luci-app-homeproxy
rm -rf feeds/packages/net/{dae,daed}

git clone https://github.com/zow2023/InfinityDuck package/new/InfinityDuck
git clone https://github.com/zow2023/luci-app-honk package/honk
git clone https://github.com/zow2023/openwrt_helloworld package/helloworld
rm -rf package/helloworld/dae

rm -rf feeds/packages/lang/node
git clone https://github.com/sbwml/feeds_packages_lang_node -b packages-25.12 feeds/packages/lang/node

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 27.x feeds/packages/lang/golang

# Modify default IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
sed -i 's/OpenWrt/W6-WRT/g' package/base-files/files/bin/config_generate

# 合并仓库预置defconfig和自定义config
if [ -f "defconfig/mt7986-ax7800.config" ]; then
    echo "检测到仓库预置defconfig，进行合并..."
    cp defconfig/mt7986-ax7800.config .config.base
    cat .config >> .config.base
    mv .config.base .config
fi
echo "CONFIG_DEVEL=y" >> .config
echo "CONFIG_CCACHE=y" >> .config
