Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977CB4906CB
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jan 2022 12:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiAQLH1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Jan 2022 06:07:27 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42001 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbiAQLHS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Jan 2022 06:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642417637; x=1673953637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+qH7HMSOPFKBmxTG20fZqNF22IDbX+pnvB7ZV38QTjs=;
  b=i0Qpf1RtNAt0xGGdvJWFyVvXbD4cCLG9OCIRZ4JGZXUyTYkozm2Brud7
   LNtFgcKT63a8ukuFSSFyBu61d7/tCNONFOdfneyzSxz97Ms7JgzjIM22y
   w/6U5zllFhW513UBKn7P9BbGr7WbJ99BJiZ20cqbt6B0nUf+FVAb9z3YY
   k6WbE1R7MzZ139Ls/EkyLjp+vC9wsYQSK5z/gUsppOUxxUNm26y2SWjst
   Wff91MNMLJjlC52Z3hhO7C4Yf9G4in7+IvfUd6BeVBt3TyqZlyUyYmuMF
   zl3LPuuBRYsORqSRWa5WRUTJrcAnR7HpaxBTsyVYxXuwD3YxJ6GbxsIwx
   w==;
IronPort-SDR: mX316A7WpmrbaPTYrB9t9max+bjjvZ0MBkiPzPyBorNlby4Ai+Wo2F1rN+BLHXJZRWofFlbdUl
 ro5VNUUdQrWqfb/atlJGxUU8AOdmv3JDU75Irtpc+6XjhYDLbIGw0SdvyvwBIpBW0u+6oPfG47
 mVkiwH1yZ8+RpHIMDCQoJ6Sz1FhEYejgqRvPOnvmzETDxtXg9ZfWGzns8IKWUwgpz1b49bbUtt
 faDd13jsk7CTO4bzXr1kIf8Ysicbt7bHXob6VJ0OCXlPb05Xd1xaqOTmrFNAfocFnNLBFori5h
 ruiqsXCU+44a6UuGcaeJnIi8
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="158890129"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2022 04:07:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 17 Jan 2022 04:07:05 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 17 Jan 2022 04:06:59 -0700
From:   <conor.dooley@microchip.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <robh+dt@kernel.org>, <jassisinghbrar@gmail.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <broonie@kernel.org>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     <krzysztof.kozlowski@canonical.com>, <geert@linux-m68k.org>,
        <bin.meng@windriver.com>, <heiko@sntech.de>,
        <lewis.hanly@microchip.com>, <conor.dooley@microchip.com>,
        <daire.mcnamara@microchip.com>, <ivan.griffin@microchip.com>,
        <atishp@rivosinc.com>
Subject: [PATCH v4 11/14] riscv: dts: microchip: refactor icicle kit device tree
Date:   Mon, 17 Jan 2022 11:07:52 +0000
Message-ID: <20220117110755.3433142-12-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117110755.3433142-1-conor.dooley@microchip.com>
References: <20220117110755.3433142-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Assorted minor changes to the MPFS/Icicle kit device tree:

- rename serial to mmuart to match microchip documentation
- move phy0 inside mac1 node to match phy configuration
- add labels where missing (cpus, cache controller)
- add missing address cells & interrupts to MACs

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../microchip/microchip-mpfs-icicle-kit.dts   |  37 ++---
 .../boot/dts/microchip/microchip-mpfs.dtsi    |  65 +++++----
 arch/riscv/configs/icicle_kit_defconfig       | 134 ++++++++++++++++++
 3 files changed, 186 insertions(+), 50 deletions(-)
 create mode 100644 arch/riscv/configs/icicle_kit_defconfig

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index ab803f71626a..c51bd7cf500f 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/* Copyright (c) 2020 Microchip Technology Inc */
+/* Copyright (c) 2020-2021 Microchip Technology Inc */
 
 /dts-v1/;
 
@@ -13,11 +13,11 @@ / {
 	compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";
 
 	aliases {
-		ethernet0 = &emac1;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		serial2 = &serial2;
-		serial3 = &serial3;
+		ethernet0 = &mac1;
+		serial0 = &mmuart0;
+		serial1 = &mmuart1;
+		serial2 = &mmuart2;
+		serial3 = &mmuart3;
 	};
 
 	chosen {
@@ -39,19 +39,19 @@ &refclk {
 	clock-frequency = <600000000>;
 };
 
-&serial0 {
+&mmuart0 {
 	status = "okay";
 };
 
-&serial1 {
+&mmuart1 {
 	status = "okay";
 };
 
-&serial2 {
+&mmuart2 {
 	status = "okay";
 };
 
-&serial3 {
+&mmuart3 {
 	status = "okay";
 };
 
@@ -61,7 +61,10 @@ &mmc {
 	bus-width = <4>;
 	disable-wp;
 	cap-sd-highspeed;
+	cap-mmc-highspeed;
 	card-detect-delay = <200>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
 	sd-uhs-sdr12;
 	sd-uhs-sdr25;
 	sd-uhs-sdr50;
@@ -72,22 +75,22 @@ &i2c2 {
 	status = "okay";
 };
 
-&emac0 {
+&mac0 {
 	phy-mode = "sgmii";
 	phy-handle = <&phy0>;
-	phy0: ethernet-phy@8 {
-		reg = <8>;
-		ti,fifo-depth = <0x01>;
-	};
 };
 
-&emac1 {
+&mac1 {
 	status = "okay";
 	phy-mode = "sgmii";
 	phy-handle = <&phy1>;
 	phy1: ethernet-phy@9 {
 		reg = <9>;
-		ti,fifo-depth = <0x01>;
+		ti,fifo-depth = <0x1>;
+	};
+	phy0: ethernet-phy@8 {
+		reg = <8>;
+		ti,fifo-depth = <0x1>;
 	};
 };
 
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index c7d73756c9b8..62bd00092bcc 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/* Copyright (c) 2020 Microchip Technology Inc */
+/* Copyright (c) 2020-2021 Microchip Technology Inc */
 
 /dts-v1/;
 #include "dt-bindings/clock/microchip,mpfs-clock.h"
@@ -15,7 +15,7 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "sifive,e51", "sifive,rocket0", "riscv";
 			device_type = "cpu";
 			i-cache-block-size = <64>;
@@ -33,7 +33,7 @@ cpu0_intc: interrupt-controller {
 			};
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -60,7 +60,7 @@ cpu1_intc: interrupt-controller {
 			};
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -87,7 +87,7 @@ cpu2_intc: interrupt-controller {
 			};
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -114,7 +114,7 @@ cpu3_intc: interrupt-controller {
 			};
 		};
 
-		cpu@4 {
+		cpu4: cpu@4 {
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -152,8 +152,9 @@ soc {
 		compatible = "simple-bus";
 		ranges;
 
-		cache-controller@2010000 {
+		cctrllr: cache-controller@2010000 {
 			compatible = "sifive,fu540-c000-ccache", "cache";
+			reg = <0x0 0x2010000 0x0 0x1000>;
 			cache-block-size = <64>;
 			cache-level = <2>;
 			cache-sets = <1024>;
@@ -161,10 +162,9 @@ cache-controller@2010000 {
 			cache-unified;
 			interrupt-parent = <&plic>;
 			interrupts = <1>, <2>, <3>;
-			reg = <0x0 0x2010000 0x0 0x1000>;
 		};
 
-		clint@2000000 {
+		clint: clint@2000000 {
 			compatible = "sifive,fu540-c000-clint", "sifive,clint0";
 			reg = <0x0 0x2000000 0x0 0xC000>;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
@@ -174,6 +174,15 @@ clint@2000000 {
 					      <&cpu4_intc 3>, <&cpu4_intc 7>;
 		};
 
+		dma@3000000 {
+			compatible = "sifive,fu540-c000-pdma";
+			reg = <0x0 0x3000000 0x0 0x8000>;
+			interrupt-parent = <&plic>;
+			interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>,
+				     <30>;
+			#dma-cells = <1>;
+		};
+
 		plic: interrupt-controller@c000000 {
 			compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xc000000 0x0 0x4000000>;
@@ -188,15 +197,6 @@ plic: interrupt-controller@c000000 {
 			riscv,ndev = <186>;
 		};
 
-		dma@3000000 {
-			compatible = "sifive,fu540-c000-pdma";
-			reg = <0x0 0x3000000 0x0 0x8000>;
-			interrupt-parent = <&plic>;
-			interrupts = <23>, <24>, <25>, <26>, <27>, <28>, <29>,
-				     <30>;
-			#dma-cells = <1>;
-		};
-
 		clkcfg: clkcfg@20002000 {
 			compatible = "microchip,mpfs-clkcfg";
 			reg = <0x0 0x20002000 0x0 0x1000>;
@@ -204,7 +204,7 @@ clkcfg: clkcfg@20002000 {
 			#clock-cells = <1>;
 		};
 
-		serial0: serial@20000000 {
+		mmuart0: serial@20000000 {
 			compatible = "ns16550a";
 			reg = <0x0 0x20000000 0x0 0x400>;
 			reg-io-width = <4>;
@@ -216,7 +216,7 @@ serial0: serial@20000000 {
 			status = "disabled";
 		};
 
-		serial1: serial@20100000 {
+		mmuart1: serial@20100000 {
 			compatible = "ns16550a";
 			reg = <0x0 0x20100000 0x0 0x400>;
 			reg-io-width = <4>;
@@ -228,7 +228,7 @@ serial1: serial@20100000 {
 			status = "disabled";
 		};
 
-		serial2: serial@20102000 {
+		mmuart2: serial@20102000 {
 			compatible = "ns16550a";
 			reg = <0x0 0x20102000 0x0 0x400>;
 			reg-io-width = <4>;
@@ -240,7 +240,7 @@ serial2: serial@20102000 {
 			status = "disabled";
 		};
 
-		serial3: serial@20104000 {
+		mmuart3: serial@20104000 {
 			compatible = "ns16550a";
 			reg = <0x0 0x20104000 0x0 0x400>;
 			reg-io-width = <4>;
@@ -257,37 +257,36 @@ mmc: mmc@20008000 {
 			compatible = "microchip,mpfs-sd4hc", "cdns,sd4hc";
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
-			interrupts = <88>, <89>;
+			interrupts = <88>;
 			clocks = <&clkcfg CLK_MMC>;
 			max-frequency = <200000000>;
 			status = "disabled";
 		};
 
-		emac0: ethernet@20110000 {
+		mac0: ethernet@20110000 {
 			compatible = "cdns,macb";
 			reg = <0x0 0x20110000 0x0 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupt-parent = <&plic>;
-			interrupts = <64>, <65>, <66>, <67>;
+			interrupts = <64>, <65>, <66>, <67>, <68>, <69>;
 			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
 			clock-names = "pclk", "hclk";
 			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
 		};
 
-		emac1: ethernet@20112000 {
+		mac1: ethernet@20112000 {
 			compatible = "cdns,macb";
 			reg = <0x0 0x20112000 0x0 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupt-parent = <&plic>;
-			interrupts = <70>, <71>, <72>, <73>;
+			interrupts = <70>, <71>, <72>, <73>, <74>, <75>;
 			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
-			status = "disabled";
 			clock-names = "pclk", "hclk";
-			#address-cells = <1>;
-			#size-cells = <0>;
+			status = "disabled";
 		};
-
 	};
 };
diff --git a/arch/riscv/configs/icicle_kit_defconfig b/arch/riscv/configs/icicle_kit_defconfig
new file mode 100644
index 000000000000..f484130e723d
--- /dev/null
+++ b/arch/riscv/configs/icicle_kit_defconfig
@@ -0,0 +1,134 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_CGROUP_BPF=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_SOC_MICROCHIP_POLARFIRE=y
+CONFIG_SMP=y
+CONFIG_CMDLINE="earlyprintk earlycon=sbi debug uio_pdrv_genirq.of_id=generic-uio"
+CONFIG_JUMP_LABEL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_BLK_DEV_ZONED=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_NETLINK_DIAG=y
+CONFIG_PCI=y
+CONFIG_PCI_DEBUG=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_PCIE_MICROCHIP_HOST=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_NBD=y
+CONFIG_BLK_DEV_NVME=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_ATA=y
+CONFIG_NETDEVICES=y
+CONFIG_MACB=y
+CONFIG_R8169=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
+CONFIG_HW_RANDOM=y
+CONFIG_HW_RANDOM_POLARFIRE_SOC=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MICROCHIP=y
+CONFIG_SPI=y
+CONFIG_SPI_POLARFIRE_SOC=y
+CONFIG_SPI_POLARFIRE_SOC_QSPI=y
+CONFIG_SPI_SPIDEV=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_POLARFIRE_SOC=y
+CONFIG_POWER_RESET=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_VIDEO_CLASS=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_DRM=y
+CONFIG_DRM_RADEON=y
+CONFIG_DRM_NOUVEAU=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PLATFORM=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_ACM=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_POLARFIRE_SOC=y
+CONFIG_USB_INVENTRA_DMA=y
+CONFIG_USB_SERIAL=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SPI=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_POLARFIRE_SOC=y
+CONFIG_DMADEVICES=y
+CONFIG_SF_PDMA=y
+CONFIG_UIO=y
+CONFIG_UIO_PDRV_GENIRQ=y
+CONFIG_UIO_DMEM_GENIRQ=y
+CONFIG_UIO_MICROCHIP_CAN=y
+CONFIG_UIO_MICROCHIP_PDMA=y
+CONFIG_UIO_MICROCHIP_DMA=y
+CONFIG_MAILBOX=y
+CONFIG_POLARFIRE_SOC_MAILBOX=y
+CONFIG_POLARFIRE_SOC_SYS_CTRL=y
+CONFIG_POLARFIRE_SOC_GENERIC_SERVICE=y
+CONFIG_IIO=y
+CONFIG_IIO_SW_DEVICE=y
+CONFIG_IIO_SW_TRIGGER=y
+CONFIG_PAC193X=y
+CONFIG_PWM=y
+CONFIG_PWM_MICROCHIP_CORE=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_FANOTIFY=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
+CONFIG_EXFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
+CONFIG_PRINTK_TIME=y
+CONFIG_SCHED_STACK_END_CHECK=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_WQ_WATCHDOG=y
+CONFIG_SCHEDSTATS=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_STACKTRACE=y
-- 
2.32.0

