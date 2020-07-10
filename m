Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C7421AE73
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2020 07:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGJFUJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Jul 2020 01:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJFTu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jul 2020 01:19:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF24C08C5DC
        for <linux-pwm@vger.kernel.org>; Thu,  9 Jul 2020 22:19:48 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jtlRo-0006zd-5G; Fri, 10 Jul 2020 07:19:44 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jtlRn-0005eU-91; Fri, 10 Jul 2020 07:19:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Paul Barker <pbarker@konsulko.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        kernel@pengutronix.de
Subject: [PATCH v2] ARM: dts: imx: default to #pwm-cells = <3> in the SoC dtsi files
Date:   Fri, 10 Jul 2020 07:19:37 +0200
Message-Id: <20200710051937.20647-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The imx-pwm driver supports 3 cells and this is the more flexible setting.
So use it by default and overwrite it back to two for the files that
reference the PWMs with just 2 cells to minimize changes.

This allows to drop explicit setting to 3 cells for the boards that already
depend on this. The boards that are now using 2 cells explicitly can be
converted to 3 individually.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

v1 was sent with Message-Id:
<20200709144527.23528-1-uwe@kleine-koenig.org> yesterday. Paul noticed
that I forgot to convert imx51.dtsi. This is fixed up here now affecting 
arch/arm/boot/dts/imx51-ts4800.dts and arch/arm/boot/dts/imx51.dtsi.

I also added a note to the commit log that the boards using 2 cells
can/should be converted separately. Also I used the right sender address
now.

Best regards
Uwe

 arch/arm/boot/dts/imx1.dtsi                      |  2 +-
 arch/arm/boot/dts/imx25.dtsi                     |  8 ++++----
 arch/arm/boot/dts/imx27.dtsi                     |  2 +-
 arch/arm/boot/dts/imx31.dtsi                     |  2 +-
 arch/arm/boot/dts/imx50.dtsi                     |  4 ++--
 arch/arm/boot/dts/imx51-ts4800.dts               |  1 +
 arch/arm/boot/dts/imx51.dtsi                     |  4 ++--
 arch/arm/boot/dts/imx53-kp.dtsi                  |  8 ++++++++
 arch/arm/boot/dts/imx53-m53evk.dts               |  1 +
 arch/arm/boot/dts/imx53-ppd.dts                  |  2 ++
 arch/arm/boot/dts/imx53-tqma53.dtsi              |  8 ++++++++
 arch/arm/boot/dts/imx53-tx53.dtsi                |  1 -
 arch/arm/boot/dts/imx53.dtsi                     |  4 ++--
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts      |  1 +
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts      |  1 +
 arch/arm/boot/dts/imx6dl-mamoj.dts               |  1 +
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi       |  1 -
 arch/arm/boot/dts/imx6q-ba16.dtsi                |  1 +
 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts           |  1 -
 arch/arm/boot/dts/imx6q-display5.dtsi            |  1 -
 arch/arm/boot/dts/imx6q-kp.dtsi                  |  2 ++
 arch/arm/boot/dts/imx6q-mccmon6.dts              |  1 -
 arch/arm/boot/dts/imx6q-novena.dts               |  1 +
 arch/arm/boot/dts/imx6q-pistachio.dts            |  1 +
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts   |  1 +
 arch/arm/boot/dts/imx6qdl-apalis.dtsi            |  1 +
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi           |  1 +
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi     |  1 +
 arch/arm/boot/dts/imx6qdl-colibri.dtsi           |  1 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi           |  1 +
 arch/arm/boot/dts/imx6qdl-emcon.dtsi             |  3 +++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi            |  1 +
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi            |  1 +
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi            |  1 +
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi            |  1 +
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi            |  1 +
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi            |  1 +
 arch/arm/boot/dts/imx6qdl-icore.dtsi             |  1 +
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi         |  2 ++
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi     |  3 +++
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi    |  2 ++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi        |  2 ++
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi       |  1 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi         |  1 +
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi         |  3 +++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi           |  1 +
 arch/arm/boot/dts/imx6qdl-savageboard.dtsi       |  1 +
 arch/arm/boot/dts/imx6qdl-tx6.dtsi               |  2 --
 arch/arm/boot/dts/imx6qdl.dtsi                   |  8 ++++----
 arch/arm/boot/dts/imx6sl-evk.dts                 |  1 +
 arch/arm/boot/dts/imx6sl.dtsi                    |  8 ++++----
 arch/arm/boot/dts/imx6sll-evk.dts                |  1 +
 arch/arm/boot/dts/imx6sll.dtsi                   |  8 ++++----
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts         |  1 +
 arch/arm/boot/dts/imx6sx-sdb.dtsi                |  1 +
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts |  3 +++
 arch/arm/boot/dts/imx6sx.dtsi                    | 16 ++++++++--------
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi          |  1 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts      |  1 +
 arch/arm/boot/dts/imx6ul-geam.dts                |  1 +
 arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi |  1 +
 arch/arm/boot/dts/imx6ul-isiot.dtsi              |  1 +
 arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts  |  1 +
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi    |  1 +
 arch/arm/boot/dts/imx6ul-pico.dtsi               |  1 +
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi              |  1 -
 arch/arm/boot/dts/imx6ul.dtsi                    | 16 ++++++++--------
 arch/arm/boot/dts/imx6ull-colibri.dtsi           |  4 ----
 68 files changed, 116 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index b30448cde582..9b940987864c 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -125,7 +125,7 @@ uart2: serial@207000 {
 			};
 
 			pwm: pwm@208000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx1-pwm";
 				reg = <0x00208000 0x1000>;
 				interrupts = <34>;
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 1123e683025c..b3ea4a17723f 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -411,7 +411,7 @@ gpio4: gpio@53f9c000 {
 
 			pwm2: pwm@53fa0000 {
 				compatible = "fsl,imx25-pwm", "fsl,imx27-pwm";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				reg = <0x53fa0000 0x4000>;
 				clocks = <&clks 106>, <&clks 52>;
 				clock-names = "ipg", "per";
@@ -430,7 +430,7 @@ gpio3: gpio@53fa4000 {
 
 			pwm3: pwm@53fa8000 {
 				compatible = "fsl,imx25-pwm", "fsl,imx27-pwm";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				reg = <0x53fa8000 0x4000>;
 				clocks = <&clks 107>, <&clks 52>;
 				clock-names = "ipg", "per";
@@ -488,7 +488,7 @@ slcdc@53fc0000 {
 
 			pwm4: pwm@53fc8000 {
 				compatible = "fsl,imx25-pwm", "fsl,imx27-pwm";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				reg = <0x53fc8000 0x4000>;
 				clocks = <&clks 108>, <&clks 52>;
 				clock-names = "ipg", "per";
@@ -535,7 +535,7 @@ wdog@53fdc000 {
 
 			pwm1: pwm@53fe0000 {
 				compatible = "fsl,imx25-pwm", "fsl,imx27-pwm";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				reg = <0x53fe0000 0x4000>;
 				clocks = <&clks 105>, <&clks 52>;
 				clock-names = "ipg", "per";
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 002cd223f22d..cadf11cf94e2 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -134,7 +134,7 @@ gpt3: timer@10005000 {
 			};
 
 			pwm: pwm@10006000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx27-pwm";
 				reg = <0x10006000 0x1000>;
 				interrupts = <23>;
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 18270ec648fe..8fe1a2d3681e 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -327,7 +327,7 @@ pwm: pwm@53fe0000 {
 				interrupts = <26>;
 				clocks = <&clks 10>, <&clks 42>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 1f4ecbca5225..f951f2e1c020 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -289,7 +289,7 @@ iomuxc: iomuxc@53fa8000 {
 			};
 
 			pwm1: pwm@53fb4000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx50-pwm", "fsl,imx27-pwm";
 				reg = <0x53fb4000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
@@ -299,7 +299,7 @@ pwm1: pwm@53fb4000 {
 			};
 
 			pwm2: pwm@53fb8000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx50-pwm", "fsl,imx27-pwm";
 				reg = <0x53fb8000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM2_IPG_GATE>,
diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 4344632f7940..6ecb83e7f336 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -113,6 +113,7 @@ &ipu_di0_disp1 {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_backlight>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index d3583aad8323..57d851c75bc0 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -400,7 +400,7 @@ iomuxc: iomuxc@73fa8000 {
 			};
 
 			pwm1: pwm@73fb4000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx51-pwm", "fsl,imx27-pwm";
 				reg = <0x73fb4000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
@@ -410,7 +410,7 @@ pwm1: pwm@73fb4000 {
 			};
 
 			pwm2: pwm@73fb8000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx51-pwm", "fsl,imx27-pwm";
 				reg = <0x73fb8000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM2_IPG_GATE>,
diff --git a/arch/arm/boot/dts/imx53-kp.dtsi b/arch/arm/boot/dts/imx53-kp.dtsi
index 8b25416a5303..4508f34139a0 100644
--- a/arch/arm/boot/dts/imx53-kp.dtsi
+++ b/arch/arm/boot/dts/imx53-kp.dtsi
@@ -162,6 +162,14 @@ MX53_PAD_EIM_D20__GPIO3_20 0x1e4
 	>;
 };
 
+&pwm1 {
+	#pwm-cells = <2>;
+};
+
+&pwm2 {
+	#pwm-cells = <2>;
+};
+
 &uart1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index daab56abe94a..a1a6228d1aa6 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -321,6 +321,7 @@ &ipu_di1_disp1 {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index 5ff9a179c83c..4b39921f88dd 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -598,12 +598,14 @@ &pmu {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
 };
 
 &pwm2 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
index ea90fd95ad01..9a6cb138adf3 100644
--- a/arch/arm/boot/dts/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -209,6 +209,14 @@ MX53_PAD_PATA_CS_1__UART3_RXD_MUX	0x1e4
 	};
 };
 
+&pwm1 {
+	#pwm-cells = <2>;
+};
+
+&pwm2 {
+	#pwm-cells = <2>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 4ab135906949..7c9730f3f820 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -542,7 +542,6 @@ &nfc {
 &pwm2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
-	#pwm-cells = <3>;
 };
 
 &sdma {
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index afa57bf7b0ed..cb782c99160e 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -525,7 +525,7 @@ port@2 {
 			};
 
 			pwm1: pwm@53fb4000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
 				reg = <0x53fb4000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
@@ -535,7 +535,7 @@ pwm1: pwm@53fb4000 {
 			};
 
 			pwm2: pwm@53fb8000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
 				reg = <0x53fb8000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM2_IPG_GATE>,
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
index 37f80ab8ccd0..809ca5611072 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
@@ -79,5 +79,6 @@ &ipu1_di0_disp0 {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
index 8d8c8c27e482..4d58cb4436d9 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
@@ -69,5 +69,6 @@ &ipu1_di0_disp0 {
 };
 
 &pwm3 {
+	#pwm-cells = <2>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index 385ce7b0029e..028951955bde 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -303,6 +303,7 @@ &ipu1_di0_disp0 {
 };
 
 &pwm3 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 2b9423d55c37..c4a235d212b6 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -540,7 +540,6 @@ &pcie {
 };
 
 &pwm1 {
-	#pwm-cells = <3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "disabled";
diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 37c63402157b..fc81f2f4b62d 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -334,6 +334,7 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-dhcom-pdk2.dts b/arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
index a2dd7e549568..a685b1c3208f 100644
--- a/arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
+++ b/arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
@@ -253,7 +253,6 @@ &pcie {
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-	#pwm-cells = <3>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/imx6q-display5.dtsi
index 83524bb99eb3..fef5d7254536 100644
--- a/arch/arm/boot/dts/imx6q-display5.dtsi
+++ b/arch/arm/boot/dts/imx6q-display5.dtsi
@@ -399,7 +399,6 @@ lvds0_out: endpoint {
 };
 
 &pwm2 {
-	#pwm-cells = <3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
index 24c8169baf44..1ade0bff681d 100644
--- a/arch/arm/boot/dts/imx6q-kp.dtsi
+++ b/arch/arm/boot/dts/imx6q-kp.dtsi
@@ -378,12 +378,14 @@ MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
 };
 
 &pwm2 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-mccmon6.dts b/arch/arm/boot/dts/imx6q-mccmon6.dts
index a4d295455e67..55692c73943d 100644
--- a/arch/arm/boot/dts/imx6q-mccmon6.dts
+++ b/arch/arm/boot/dts/imx6q-mccmon6.dts
@@ -237,7 +237,6 @@ lvds0_out: endpoint {
 };
 
 &pwm2 {
-	#pwm-cells = <3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 69f170ff31c5..52e3567d1859 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -455,6 +455,7 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts b/arch/arm/boot/dts/imx6q-pistachio.dts
index a31b17eaf51c..7a33e54cc0f1 100644
--- a/arch/arm/boot/dts/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/imx6q-pistachio.dts
@@ -570,6 +570,7 @@ lvds0_out: endpoint {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
index c54362fcc508..a57c2e3a8435 100644
--- a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
+++ b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
@@ -203,6 +203,7 @@ lvds1_out: endpoint {
 };
 
 &pwm2 {
+	#pwm-cells = <2>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index e34be8fabd93..dbdd7db60325 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -371,6 +371,7 @@ &pwm3 {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "disabled";
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index b8e74ab3c993..2577eb4f535a 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -211,6 +211,7 @@ &pcie {
 };
 
 &pwm3 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index 376750882ed3..d38630d4b892 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -336,6 +336,7 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 240b86d2eb71..1d9f527c04bb 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -312,6 +312,7 @@ &pwm2 {
 
 /* Colibri PWM<A> */
 &pwm3 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "disabled";
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index e3be453d8a4a..67042793b0ca 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -233,6 +233,7 @@ MX6QDL_PAD_EIM_DA8__GPIO3_IO08	0x17059
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
index 70d26616d771..35e230f991f1 100644
--- a/arch/arm/boot/dts/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
@@ -737,14 +737,17 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	status = "okay";
 };
 
 &pwm3 {
+	#pwm-cells = <2>;
 	status = "okay";
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 60563ff0b7ce..65fe66f0c9ad 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -365,6 +365,7 @@ &pwm3 {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 8942bec65c5c..545b7831692d 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -356,6 +356,7 @@ &pwm3 {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index c40583dbd96d..52fbc6719fab 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -419,6 +419,7 @@ &pwm3 {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default", "state_dio";
 	pinctrl-0 = <&pinctrl_pwm4_backlight>;
 	pinctrl-1 = <&pinctrl_pwm4_dio>;
diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
index 69ca70d3baa8..d295898f1dec 100644
--- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
@@ -471,6 +471,7 @@ &pwm3 {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index aee9221f0f29..201c17b15df2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -365,6 +365,7 @@ timing0: g101evn010 {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 76d6cf57f1c3..b30c1487252d 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -401,6 +401,7 @@ &pwm3 {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 756f3a9f1b4f..f2f475ea74e0 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -245,6 +245,7 @@ mipi_csi2_in: endpoint {
 };
 
 &pwm3 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index 2418cf8f2317..d526f01a2c52 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -497,6 +497,7 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
@@ -509,6 +510,7 @@ &pwm3 {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index c3415aa348a2..185a1a31ca39 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -736,12 +736,14 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
 };
 
 &pwm2 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
@@ -754,6 +756,7 @@ &pwm3 {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index ed53f07c6b7b..4bbe54e1ddb5 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -639,6 +639,7 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
@@ -651,6 +652,7 @@ &pwm3 {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 8b0e432099b5..c63e1bc1ad3a 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -596,6 +596,7 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
@@ -608,6 +609,7 @@ &pwm3 {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
index 9ebd438dce7d..019938562aa9 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
@@ -218,6 +218,7 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index cf628465cd0a..55f736dbee0b 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -800,6 +800,7 @@ timing0: hsd100pxn1 {
 };
 
 &pwm3 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 8468216dae9b..95f9ddab5996 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -687,18 +687,21 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
 };
 
 &pwm3 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 28b35ccb3757..550e22511e34 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -729,6 +729,7 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-savageboard.dtsi b/arch/arm/boot/dts/imx6qdl-savageboard.dtsi
index a616e3c400d3..02e6d36e85fa 100644
--- a/arch/arm/boot/dts/imx6qdl-savageboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-savageboard.dtsi
@@ -140,6 +140,7 @@ lvds0_out: endpoint {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index c68cb90fd801..362e65ccaa78 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -738,14 +738,12 @@ MATRIX_KEY(2, 2, KEY_KP9) /* 0x02020049 */
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-	#pwm-cells = <3>;
 	status = "disabled";
 };
 
 &pwm2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
-	#pwm-cells = <3>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 32114cf6acee..b055ec152279 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -510,7 +510,7 @@ aipstz@207c000 { /* AIPSTZ1 */
 			};
 
 			pwm1: pwm@2080000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02080000 0x4000>;
 				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
@@ -521,7 +521,7 @@ pwm1: pwm@2080000 {
 			};
 
 			pwm2: pwm@2084000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02084000 0x4000>;
 				interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -532,7 +532,7 @@ pwm2: pwm@2084000 {
 			};
 
 			pwm3: pwm@2088000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02088000 0x4000>;
 				interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -543,7 +543,7 @@ pwm3: pwm@2088000 {
 			};
 
 			pwm4: pwm@208c000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x0208c000 0x4000>;
 				interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index bc86cfaaa9c2..b1b069e723d2 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -575,6 +575,7 @@ display_out: endpoint {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 911d8cf77f2c..45794b91a31d 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -344,7 +344,7 @@ uart4: serial@2038000 {
 			};
 
 			pwm1: pwm@2080000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg = <0x02080000 0x4000>;
 				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
@@ -354,7 +354,7 @@ pwm1: pwm@2080000 {
 			};
 
 			pwm2: pwm@2084000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg = <0x02084000 0x4000>;
 				interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -364,7 +364,7 @@ pwm2: pwm@2084000 {
 			};
 
 			pwm3: pwm@2088000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg = <0x02088000 0x4000>;
 				interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -374,7 +374,7 @@ pwm3: pwm@2088000 {
 			};
 
 			pwm4: pwm@208c000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg = <0x0208c000 0x4000>;
 				interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 5ace9e6acf85..c755cbdb7cde 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -260,6 +260,7 @@ display_out: endpoint {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index edd3abb9a9f1..f327405253f6 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -331,7 +331,7 @@ pwm1: pwm@2080000 {
 				clocks = <&clks IMX6SLL_CLK_PWM1>,
 					 <&clks IMX6SLL_CLK_PWM1>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm2: pwm@2084000 {
@@ -341,7 +341,7 @@ pwm2: pwm@2084000 {
 				clocks = <&clks IMX6SLL_CLK_PWM2>,
 					 <&clks IMX6SLL_CLK_PWM2>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm3: pwm@2088000 {
@@ -351,7 +351,7 @@ pwm3: pwm@2088000 {
 				clocks = <&clks IMX6SLL_CLK_PWM3>,
 					 <&clks IMX6SLL_CLK_PWM3>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm4: pwm@208c000 {
@@ -361,7 +361,7 @@ pwm4: pwm@208c000 {
 				clocks = <&clks IMX6SLL_CLK_PWM4>,
 					 <&clks IMX6SLL_CLK_PWM4>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			gpt1: timer@2098000 {
diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
index d84ea6999377..66af78e83b70 100644
--- a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
@@ -229,6 +229,7 @@ &pcie {
 };
 
 &pwm4 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index 3e5fb72f21fc..81bc7675d2e9 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -281,6 +281,7 @@ display_out: endpoint {
 };
 
 &pwm3 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
index 6b728b03f1f2..d25e27d0315f 100644
--- a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
+++ b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
@@ -505,18 +505,21 @@ &pcie {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
 };
 
 &pwm2 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
 };
 
 &pwm6 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm6>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 94e3df47d1ad..43b270d7abd9 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -413,7 +413,7 @@ pwm1: pwm@2080000 {
 				clocks = <&clks IMX6SX_CLK_PWM1>,
 					 <&clks IMX6SX_CLK_PWM1>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm2: pwm@2084000 {
@@ -423,7 +423,7 @@ pwm2: pwm@2084000 {
 				clocks = <&clks IMX6SX_CLK_PWM2>,
 					 <&clks IMX6SX_CLK_PWM2>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm3: pwm@2088000 {
@@ -433,7 +433,7 @@ pwm3: pwm@2088000 {
 				clocks = <&clks IMX6SX_CLK_PWM3>,
 					 <&clks IMX6SX_CLK_PWM3>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm4: pwm@208c000 {
@@ -443,7 +443,7 @@ pwm4: pwm@208c000 {
 				clocks = <&clks IMX6SX_CLK_PWM4>,
 					 <&clks IMX6SX_CLK_PWM4>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			flexcan1: can@2090000 {
@@ -1337,7 +1337,7 @@ pwm5: pwm@22a4000 {
 				clocks = <&clks IMX6SX_CLK_PWM5>,
 					 <&clks IMX6SX_CLK_PWM5>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm6: pwm@22a8000 {
@@ -1347,7 +1347,7 @@ pwm6: pwm@22a8000 {
 				clocks = <&clks IMX6SX_CLK_PWM6>,
 					 <&clks IMX6SX_CLK_PWM6>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm7: pwm@22ac000 {
@@ -1357,7 +1357,7 @@ pwm7: pwm@22ac000 {
 				clocks = <&clks IMX6SX_CLK_PWM7>,
 					 <&clks IMX6SX_CLK_PWM7>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm8: pwm@22b0000 {
@@ -1367,7 +1367,7 @@ pwm8: pwm@22b0000 {
 				clocks = <&clks IMX6SX_CLK_PWM8>,
 					 <&clks IMX6SX_CLK_PWM8>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index 265bf4108cb6..64c2d1e9f7fc 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -228,6 +228,7 @@ display_out: endpoint {
 };
 
 &pwm1 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
index 5d3805b07032..a0bbec57ddc7 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
@@ -168,6 +168,7 @@ &pwm4 {
 };
 
 &pwm5 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm5>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-geam.dts b/arch/arm/boot/dts/imx6ul-geam.dts
index 9f63706383a7..a0097da03f38 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/imx6ul-geam.dts
@@ -195,6 +195,7 @@ timing0: timing0 {
 };
 
 &pwm8 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm8>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi b/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
index 18966350bfd8..935a77d717a6 100644
--- a/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
+++ b/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
@@ -155,6 +155,7 @@ lcdif_out: endpoint {
 };
 
 &pwm3 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index cc9adce638f5..14fc4828ba4e 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -187,6 +187,7 @@ timing0: timing0 {
 };
 
 &pwm8 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm8>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts b/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
index 5bad29683cc3..5bfad4655b22 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
@@ -41,6 +41,7 @@ &lcdif {
 };
 
 &pwm7 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm7>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
index 53a25fba34f6..a35be2a369b3 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
@@ -153,6 +153,7 @@ rtc@32 {
 };
 
 &pwm8 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm8>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-pico.dtsi b/arch/arm/boot/dts/imx6ul-pico.dtsi
index df1da98ab10f..357ffb2f5ad6 100644
--- a/arch/arm/boot/dts/imx6ul-pico.dtsi
+++ b/arch/arm/boot/dts/imx6ul-pico.dtsi
@@ -175,6 +175,7 @@ display_out: endpoint {
 };
 
 &pwm3 {
+	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index bb6dbfd5546b..938a32ced88d 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -549,7 +549,6 @@ ETQ570 {
 &pwm5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm5>;
-	#pwm-cells = <3>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 5379a03391bd..74ae25a5ab72 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -371,7 +371,7 @@ pwm1: pwm@2080000 {
 				clocks = <&clks IMX6UL_CLK_PWM1>,
 					 <&clks IMX6UL_CLK_PWM1>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -382,7 +382,7 @@ pwm2: pwm@2084000 {
 				clocks = <&clks IMX6UL_CLK_PWM2>,
 					 <&clks IMX6UL_CLK_PWM2>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -393,7 +393,7 @@ pwm3: pwm@2088000 {
 				clocks = <&clks IMX6UL_CLK_PWM3>,
 					 <&clks IMX6UL_CLK_PWM3>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -404,7 +404,7 @@ pwm4: pwm@208c000 {
 				clocks = <&clks IMX6UL_CLK_PWM4>,
 					 <&clks IMX6UL_CLK_PWM4>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -734,7 +734,7 @@ pwm5: pwm@20f0000 {
 				clocks = <&clks IMX6UL_CLK_PWM5>,
 					 <&clks IMX6UL_CLK_PWM5>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -745,7 +745,7 @@ pwm6: pwm@20f4000 {
 				clocks = <&clks IMX6UL_CLK_PWM6>,
 					 <&clks IMX6UL_CLK_PWM6>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -756,7 +756,7 @@ pwm7: pwm@20f8000 {
 				clocks = <&clks IMX6UL_CLK_PWM7>,
 					 <&clks IMX6UL_CLK_PWM7>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -767,7 +767,7 @@ pwm8: pwm@20fc000 {
 				clocks = <&clks IMX6UL_CLK_PWM8>,
 					 <&clks IMX6UL_CLK_PWM8>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 9145c536d71a..6cf95939121d 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -145,25 +145,21 @@ &lcdif {
 &pwm4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
-	#pwm-cells = <3>;
 };
 
 &pwm5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm5>;
-	#pwm-cells = <3>;
 };
 
 &pwm6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm6>;
-	#pwm-cells = <3>;
 };
 
 &pwm7 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm7>;
-	#pwm-cells = <3>;
 };
 
 &sdma {
-- 
2.27.0

