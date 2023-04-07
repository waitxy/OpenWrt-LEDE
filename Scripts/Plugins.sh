#!/bin/bash

svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser package/luci-app-filebrowser
#infinityfreedom
git clone --depth 1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
# 流量监控
svn co https://github.com/haiibo/packages/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon
svn co https://github.com/haiibo/packages/trunk/wrtbwmon package/wrtbwmon
# 在线用户
svn co https://github.com/haiibo/packages/trunk/luci-app-onliner package/luci-app-onliner
sed -i '/bin\/sh/a\uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '/nlbwmon/a\uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
# Alist
svn co https://github.com/sbwml/luci-app-alist/trunk/luci-app-alist package/luci-app-alist
svn co https://github.com/sbwml/luci-app-alist/trunk/alist package/alist


#luci-app-store
git clone --depth=1 --single-branch https://github.com/linkease/istore.git
#adguardhome
#git clone --depth=1 --single-branch https://github.com/rufengsuixing/luci-app-adguardhome.git
#ikoolproxy
#git clone --depth 1 https://github.com/iwrt/luci-app-ikoolproxy package/luci-app-ikoolproxy
#Design Theme
git clone --depth=1 --single-branch https://github.com/gngpp/luci-theme-design.git
#Design Config
git clone --depth=1 --single-branch https://github.com/gngpp/luci-app-design-config.git
#Open Clash
git clone --depth=1 --single-branch --branch "dev" https://github.com/vernesong/OpenClash.git

#Open Clash Core
export CORE_VER=https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/core_version
export CORE_TUN=https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux
export CORE_DEV=https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux
export CORE_MATE=https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux
export CORE_TYPE=$(if [ "$OWRT_TYPE" = "X86" ] ; then echo "amd64" ; else echo "arm64" ; fi)
export TUN_VER=$(curl -sfL $CORE_VER | sed -n "2p")

cd ./OpenClash/luci-app-openclash/root/etc/openclash
mkdir ./core && cd ./core

curl -sfL -o ./tun.gz "$CORE_TUN"-"$CORE_TYPE"-"$TUN_VER".gz
gzip -d ./tun.gz && mv ./tun ./clash_tun

curl -sfL -o ./meta.tar.gz "$CORE_MATE"-"$CORE_TYPE".tar.gz
tar -zxf ./meta.tar.gz && mv ./clash ./clash_meta

curl -sfL -o ./dev.tar.gz "$CORE_DEV"-"$CORE_TYPE".tar.gz
tar -zxf ./dev.tar.gz

chmod +x ./clash* ; rm -rf ./*.gz
