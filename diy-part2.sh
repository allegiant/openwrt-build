#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/openwrt-passwall

# add luci-app-ssr-plus
git clone --depth=1 https://github.com/fw876/helloworld package/lean/helloworld

# add luci-app-adblock-plus
git clone --depth=1 https://github.com/small-5/luci-app-adblock-plus.git package/luci-app-adblock-plus

## overclock 1000Mhz--0x312 1100Mhz--0x362 1200Mhz--0x3B2
sed -i '57s/89/98/' target/linux/ramips/patches-5.10/322-mt7621-fix-cpu-clk-add-clkdev.patch
sed -i 'N;118 a +\t\tif ((pll & 0x7f0) == 0x2b0) {\n+\t\t\tvolatile u32 i;\n+\n+\t\t\tpr_info("CPU Clock: 880MHz, start overclocking\\n");\n+\t\t\tpll &= ~0x7ff;\n+\t\t\tpll |= 0x362;\n+\t\t\trt_memc_w32(pll, MEMC_REG_CPU_PLL);\n+\t\t\tfor (i = 0; i < 1000; i++);\n+\t\t}' target/linux/ramips/patches-5.10/322-mt7621-fix-cpu-clk-add-clkdev.patch

