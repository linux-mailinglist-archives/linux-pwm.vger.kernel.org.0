Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E133C188455
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 13:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCQMdf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 08:33:35 -0400
Received: from mail-eopbgr00102.outbound.protection.outlook.com ([40.107.0.102]:23107
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbgCQMdf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 08:33:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRce5piF4Siy2dETghFy0J7BX1K+EuGBRdaMF6D0HEW5oi0YE/SWt54XgK2l2AAYdnpBCwVyXJ166Kp6jWiLQIrYIjROKBPFZvvcFHNxtblRTAXccRP6fckpZ3J6845cgdRiGRWIsyb8uPtwvXYXmvBk1feIc6YLasW4urbGE8D191vCIENG2QDDW4Q2WEyG7i2OFOWsre2nq3/I00TZRCbk0th/aBHSLr8ZbSD6yo1KDJjvNKdBGoMA6iWAKDZHHTQjRDSNWU8zmEOrYRKFacGfbwyuawmKcgUS1ZSHgkecp/hIBCCUrla2F2V9XrzyVhh6vpVjOYO9nh1SXe6EKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82kulA8ji5q3ysz4nsElSwam1xMV6WqSJo2CjWUdpsI=;
 b=nDF6asTUcwtwbcWpNWgjLHi/SJgtwDeERy26UYxFeFX3dB3wm+MfZhXiUf5Kh4JOzVAR4eeJj1RWatPQBVYC3wAyl6oH6FRSyYxv56vCY3+dqIPWcmdywqkwjyKEi8t6NLliA9Y0H7rf7lf/d50bRYp429hnUdzpANobWmo26DJkMUkuFIs+8/UXe5OkqdIjxGcZPpq1pEZJWfIkp7nzX6KYbm610PKlwP+rwrP1yR9JqBGgw1g9pbvCYrOG5Klazw3bdm6oIjOzbHfTvoLXGjqExOEtgUlAvNNREFAalz4WrftrDhRoWHY600HtW/jg1hnAh14sFrerViAKq/IKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82kulA8ji5q3ysz4nsElSwam1xMV6WqSJo2CjWUdpsI=;
 b=J2vXHQMN5Mhihp1Nk/0ob7QdWqTIt8/NN3oPgBU+/kS310+oAe7FOWluNcuYXHaUbdvy3t7NREXEMwQJWMktIrIQ9uAqlSbx5yWkY/Jn+uD/kgXaw+IxWSNBHciMysKIqHROQJjRTUNSKszmpHgYC2+rBJHb6/AsQJl+0VyNOQc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB4462.eurprd05.prod.outlook.com (10.171.182.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 12:32:56 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 12:32:56 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Paul Barker <pbarker@konsulko.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Lechner <david@lechnology.com>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [RFC PATCH 7/7] arm: dts: pwm: replace polarity constant with macro
Date:   Tue, 17 Mar 2020 14:32:31 +0200
Message-Id: <20200317123231.2843297-8-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::19) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by PR0P264CA0055.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14 via Frontend Transport; Tue, 17 Mar 2020 12:32:56 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cf6849a-bb29-4d99-5041-08d7ca6f5220
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB4462F774B9FFEE8B3C8C8451F9F60@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(396003)(136003)(366004)(346002)(376002)(199004)(66946007)(6666004)(66476007)(66556008)(5660300002)(7406005)(36756003)(7416002)(30864003)(1076003)(4326008)(26005)(6496006)(44832011)(52116002)(54906003)(81166006)(81156014)(2906002)(8676002)(55236004)(316002)(186003)(8936002)(956004)(478600001)(2616005)(6486002)(86362001)(16526019)(95444002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4462;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXIdAqM06X/qSAnrCzCaBSGeQ+JUbptcZJkoVIdk14ROueYjHn60MJMxoaiWMwsDyskhyKE5xd96erhJ3Lhl0XPqKW6T/e7XBl6hZAroG1rqcpZjI78Y9dGrZmyZ1WMUKKUOXe0EHz5ZsYS/icK7z6msJzQVKbRzZ/tOjmjgyLzaOwHUXKgl70aYXCxCkse4LcFlE4HQkcC5kWN8lUGTE78ODak6GMB11vPh35LeMN0Ox1DfVagIDvR6XtH/cOUfW/z46DkJYfcRnL8h4BmlnHaOGMOBdSiCgQKEw8TDmixSZavmzECgwQXlszKtYUczwISv0hC2A0c8KIrIix9NoUlcNrLGlLY6dzxmZDdbtpAd3CcC0OhSIJedsJY1LTvcLg6iPaywbwCRasEqJDxVWxizxJ61mZQSyxaUTyw0H9qmOJiTQqETR20DUTL1Fam5IFf96zPAy3MCQApHDmOWTnZs5niPOl1QvT210uoQCSJsmPiG8pxnRufNJDqRNqj5
X-MS-Exchange-AntiSpam-MessageData: O2Wp8K5vbuXUdHxPHQK9d4OK0aLTdJ3wvdp+oNqLqHrQGjgoKofPRxTrThKQNOe4gnhbx5oSGFxFmDOgmk/07xo99jME7YSOWfzJbOeiqaRYY4IaWF1bPRhuobA3xv3+iAY4uIbVR8mJc/vz4eDrWw==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf6849a-bb29-4d99-5041-08d7ca6f5220
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:32:56.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nNVUt2OtsSWkvp9AagC2c7ZYtF4TSsw8KkdqGDJThmz+CoG4CxnJL8PeFDk/seedyQd+1RmlXPPjxMZEvrF6Voi3tsBVa3Od7IaZFdCVKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4462
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There is the PWM_POLARITY_NORMAL defined and describled in
<dt-bindings/pwm/pwm.h> and used by pwm drivers.

This patch converts all '0' constant in pwms parameters into
PWM_POLARITY_NORMAL.

Replace with sed regexp:
's/(pwms = <&[a-zA-Z_0-9]+ [0-9]+ [0-9]+) 0>/\1 PWM_POLARITY_NORMAL>/'

Then:
- included pwm.h in some dts/dtsi to fix building errors about undefined
  symbols.
- fixed the patman warnings about the code format;

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 arch/arm/boot/dts/am335x-cm-t335.dts               | 2 +-
 arch/arm/boot/dts/am335x-evm.dts                   | 2 +-
 arch/arm/boot/dts/am3517-evm.dts                   | 2 +-
 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi      | 2 +-
 arch/arm/boot/dts/at91-kizbox2-common.dtsi         | 6 +++---
 arch/arm/boot/dts/at91-kizbox3_common.dtsi         | 8 ++++----
 arch/arm/boot/dts/at91-kizboxmini-common.dtsi      | 6 +++---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts        | 2 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts        | 2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                | 2 +-
 arch/arm/boot/dts/at91sam9x5dm.dtsi                | 2 +-
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts  | 4 ++--
 arch/arm/boot/dts/da850-evm.dts                    | 2 +-
 arch/arm/boot/dts/da850-lego-ev3.dts               | 4 ++--
 arch/arm/boot/dts/exynos4412-midas.dtsi            | 2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          | 2 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      | 2 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          | 2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 2 +-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         | 2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         | 2 +-
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    | 4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 2 +-
 arch/arm/boot/dts/imx53-tx53-x13x.dts              | 5 +++--
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts          | 2 +-
 arch/arm/boot/dts/imx6q-display5.dtsi              | 2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts       | 2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts       | 2 +-
 arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi            | 4 ++--
 arch/arm/boot/dts/imx7-colibri.dtsi                | 4 +++-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              | 3 ++-
 arch/arm/boot/dts/imx7d-pico.dtsi                  | 3 ++-
 arch/arm/boot/dts/imx7d-sdb.dts                    | 3 ++-
 arch/arm/boot/dts/imx7ulp-evk.dts                  | 3 ++-
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            | 2 +-
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi   | 2 +-
 arch/arm/boot/dts/meson8b-ec100.dts                | 4 ++--
 arch/arm/boot/dts/meson8b-mxq.dts                  | 4 ++--
 arch/arm/boot/dts/meson8b-odroidc1.dts             | 4 ++--
 arch/arm/boot/dts/motorola-mapphone-common.dtsi    | 3 ++-
 arch/arm/boot/dts/omap3-gta04.dtsi                 | 2 +-
 arch/arm/boot/dts/omap3-n900.dts                   | 2 +-
 arch/arm/boot/dts/rk3288-veyron-edp.dtsi           | 2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               | 2 +-
 arch/arm/boot/dts/rv1108-evb.dts                   | 2 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts             | 2 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi               | 2 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts             | 2 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts                | 2 +-
 arch/arm/boot/dts/vf-colibri.dtsi                  | 4 +++-
 51 files changed, 76 insertions(+), 66 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index c6fe9db660e2..cb1ec60fb455 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -48,7 +48,7 @@ vwlan_fixed: fixedregulator2 {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&ecap0 0 50000 0>;
+		pwms = <&ecap0 0 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
 		default-brightness-level = <8>;
 	};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 68252dab32c3..dd8eba3d85c7 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -115,7 +115,7 @@ switch10 {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&ecap0 0 50000 0>;
+		pwms = <&ecap0 0 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
 		default-brightness-level = <8>;
 	};
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index a1fd3e63e86e..206e00db67f7 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -144,7 +144,7 @@ bl: backlight {
 		pinctrl-names = "default";
 		power-supply = <&vdd_io_reg>;
 		pinctrl-0 = <&backlight_pins>;
-		pwms = <&pwm11 0 5000000 0>;
+		pwms = <&pwm11 0 5000000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>; /* gpio_182 */
diff --git a/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi b/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
index bea920b192b6..839b0d1e8a17 100644
--- a/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
+++ b/arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi
@@ -10,7 +10,7 @@
 / {
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&hlcdc_pwm 0 50000 0>;
+		pwms = <&hlcdc_pwm 0 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/at91-kizbox2-common.dtsi b/arch/arm/boot/dts/at91-kizbox2-common.dtsi
index af38253a6e7a..cea5226c5118 100644
--- a/arch/arm/boot/dts/at91-kizbox2-common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox2-common.dtsi
@@ -63,21 +63,21 @@ pwm_leds {
 
 		blue {
 			label = "pwm:blue:user";
-			pwms = <&pwm0 2 10000000 0>;
+			pwms = <&pwm0 2 10000000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "none";
 		};
 
 		green {
 			label = "pwm:green:user";
-			pwms = <&pwm0 1 10000000 0>;
+			pwms = <&pwm0 1 10000000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 
 		red {
 			label = "pwm:red:user";
-			pwms = <&pwm0 0 10000000 0>;
+			pwms = <&pwm0 0 10000000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
index 299e74d23184..f1a8448ba6e1 100644
--- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
+++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
@@ -73,7 +73,7 @@ &pinctrl_pwm0_pwm_h2
 
 		red {
 			label = "pwm:red:user";
-			pwms = <&pwm0 0 10000000 0>;
+			pwms = <&pwm0 0 10000000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 			status = "disabled";
@@ -81,7 +81,7 @@ red {
 
 		green {
 			label = "pwm:green:user";
-			pwms = <&pwm0 1 10000000 0>;
+			pwms = <&pwm0 1 10000000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 			status = "disabled";
@@ -89,14 +89,14 @@ green {
 
 		blue {
 			label = "pwm:blue:user";
-			pwms = <&pwm0 2 10000000 0>;
+			pwms = <&pwm0 2 10000000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			status = "disabled";
 		};
 
 		white {
 			label = "pwm:white:user";
-			pwms = <&pwm0 3 10000000 0>;
+			pwms = <&pwm0 3 10000000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/at91-kizboxmini-common.dtsi b/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
index fddf267b2d17..60dad4ff6f27 100644
--- a/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
+++ b/arch/arm/boot/dts/at91-kizboxmini-common.dtsi
@@ -59,7 +59,7 @@ leds: pwm_leds {
 
 		led_blue: pwm_blue {
 			label = "pwm:blue:user";
-			pwms = <&pwm0 2 10000000 0>;
+			pwms = <&pwm0 2 10000000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "none";
 			status = "disabled";
@@ -67,14 +67,14 @@ led_blue: pwm_blue {
 
 		led_green: pwm_green {
 			label = "pwm:green:user";
-			pwms = <&pwm0 0 10000000 0>;
+			pwms = <&pwm0 0 10000000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 
 		led_red: pwm_red {
 			label = "pwm:red:user";
-			pwms = <&pwm0 1 10000000 0>;
+			pwms = <&pwm0 1 10000000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 4f123477e631..d9813299fd47 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -42,7 +42,7 @@ bl_reg: backlight-regulator {
 
 	panel_bl: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&hlcdc_pwm 0 100000 0>;
+		pwms = <&hlcdc_pwm 0 100000 PWM_POLARITY_NORMAL>;
 
 		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
 				     10 11 12 13 14 15 16 17 18 19
diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
index 4d7cee569ff2..0ab4533ca789 100644
--- a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
@@ -105,7 +105,7 @@ pinctrl_usba_vbus: usba_vbus {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&hlcdc_pwm 0 50000 0>;
+		pwms = <&hlcdc_pwm 0 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index d36e162a8817..958c87abd865 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -189,7 +189,7 @@ usb0: ohci@500000 {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&hlcdc_pwm 0 50000 0>;
+		pwms = <&hlcdc_pwm 0 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		power-supply = <&bl_reg>;
diff --git a/arch/arm/boot/dts/at91sam9x5dm.dtsi b/arch/arm/boot/dts/at91sam9x5dm.dtsi
index a9278038af3b..a04ca0b08494 100644
--- a/arch/arm/boot/dts/at91sam9x5dm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5dm.dtsi
@@ -11,7 +11,7 @@
 / {
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&hlcdc_pwm 0 50000 0>;
+		pwms = <&hlcdc_pwm 0 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		power-supply = <&bl_reg>;
diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index 56fa951bc86f..12c19f45efad 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -41,14 +41,14 @@ leds {
 
 		white {
 			label = "white";
-			pwms = <&pwm 0 600000 0>;
+			pwms = <&pwm 0 600000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 
 		red {
 			label = "red";
-			pwms = <&pwm 1 600000 0>;
+			pwms = <&pwm 1 600000 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 		};
 	};
diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f2e7609e5346..d62503cb9a88 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -34,7 +34,7 @@ backlight: backlight-pwm {
 		 * schematic needs to be 1015171 (15 March 2010), Rev A
 		 * or newer.
 		 */
-		pwms = <&ecap2 0 50000 0>;
+		pwms = <&ecap2 0 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 99>;
 		default-brightness-level = <7>;
 	};
diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index afd04a423856..4dc42901c6f4 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -118,7 +118,7 @@ sound {
 		compatible = "pwm-beeper";
 		pinctrl-names = "default";
 		pinctrl-0 = <&ehrpwm0b_pins>;
-		pwms = <&ehrpwm0 1 1000000 0>;
+		pwms = <&ehrpwm0 1 1000000 PWM_POLARITY_NORMAL>;
 		amp-supply = <&amp>;
 	};
 
@@ -185,7 +185,7 @@ bt_slow_clk: bt-clock {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&ecap2 0 30518 0>;
+		pwms = <&ecap2 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	/* ARM local RAM */
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 3023bc3b68ce..ee64081abce9 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -171,7 +171,7 @@ charger_reg: CHARGER {
 			max77693_haptic {
 				compatible = "maxim,max77693-haptic";
 				haptic-supply = <&ldo26_reg>;
-				pwms = <&pwm 0 38022 0>;
+				pwms = <&pwm 0 38022 PWM_POLARITY_NORMAL>;
 			};
 
 			charger {
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 8ff243ba4542..d97b290565e2 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -33,7 +33,7 @@ led1 {
 
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
-		pwms = <&pwm 0 10000 0>;
+		pwms = <&pwm 0 10000 PWM_POLARITY_NORMAL>;
 		#cooling-cells = <2>;
 		cooling-levels = <0 102 170 230>;
 	};
diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index c952a615148e..8b94b9d88f1e 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -196,7 +196,7 @@ xxti {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 1000000 0>;
+		pwms = <&pwm 0 1000000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpx3 0 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 4f9297ae0763..5edd2b94135a 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -37,7 +37,7 @@ emmc_pwrseq: pwrseq {
 
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
-		pwms = <&pwm 0 20972 0>;
+		pwms = <&pwm 0 20972 PWM_POLARITY_NORMAL>;
 		#cooling-cells = <2>;
 		cooling-levels = <0 130 170 230>;
 	};
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 2bcbdf8a39bf..1a89f3783b42 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -34,7 +34,7 @@ aliases {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 1000000 0>;
+		pwms = <&pwm 0 1000000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
 		default-brightness-level = <7>;
 		power-supply = <&tps65090_fet1>;
diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index 812659260278..c7d81c4d3465 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -20,7 +20,7 @@ pwmleds {
 
 		blueled {
 			label = "blue:heartbeat";
-			pwms = <&pwm 2 2000000 0>;
+			pwms = <&pwm 2 2000000 PWM_POLARITY_NORMAL>;
 			pwm-names = "pwm2";
 			max_brightness = <255>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 5da2d81e3be2..ecebb6867329 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -43,7 +43,7 @@ emmc_pwrseq: pwrseq {
 
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
-		pwms = <&pwm 0 20972 0>;
+		pwms = <&pwm 0 20972 PWM_POLARITY_NORMAL>;
 		#cooling-cells = <2>;
 		cooling-levels = <0 130 170 230>;
 	};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 892d389d6d09..ef22f2b37dea 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -22,7 +22,7 @@ pwmleds {
 
 		blueled {
 			label = "blue:heartbeat";
-			pwms = <&pwm 2 2000000 0>;
+			pwms = <&pwm 2 2000000 PWM_POLARITY_NORMAL>;
 			pwm-names = "pwm2";
 			max_brightness = <255>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
index 56acd832f0b3..90d80aa8b160 100644
--- a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
+++ b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
@@ -16,7 +16,7 @@ pwmleds {
 
 		greenled {
 			label = "green:mmc0";
-			pwms = <&pwm 1 2000000 0>;
+			pwms = <&pwm 1 2000000 PWM_POLARITY_NORMAL>;
 			pwm-names = "pwm1";
 			/*
 			 * Green LED is much brighter than the others
@@ -28,7 +28,7 @@ greenled {
 
 		blueled {
 			label = "blue:heartbeat";
-			pwms = <&pwm 2 2000000 0>;
+			pwms = <&pwm 2 2000000 PWM_POLARITY_NORMAL>;
 			pwm-names = "pwm2";
 			max_brightness = <255>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 60ab0effe474..ef289c040a78 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -32,7 +32,7 @@ aliases {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 1000000 0>;
+		pwms = <&pwm 0 1000000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 100 500 1000 1500 2000 2500 2800>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpx2 2 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index 6cdf2082c742..57d5d7fe3881 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -48,6 +48,7 @@
 /dts-v1/;
 #include "imx53-tx53.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Ka-Ro electronics TX53 module (LVDS)";
@@ -61,7 +62,7 @@ aliases {
 
 	backlight0: backlight0 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 0>;
+		pwms = <&pwm2 0 500000 PWM_POLARITY_NORMAL>;
 		power-supply = <&reg_3v3>;
 		brightness-levels = <
 			  0  1  2  3  4  5  6  7  8  9
@@ -81,7 +82,7 @@ backlight0: backlight0 {
 
 	backlight1: backlight1 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 500000 0>;
+		pwms = <&pwm1 0 500000 PWM_POLARITY_NORMAL>;
 		power-supply = <&reg_3v3>;
 		brightness-levels = <
 			  0  1  2  3  4  5  6  7  8  9
diff --git a/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts b/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
index 51a9bb9d6bc2..12c43823b1ed 100644
--- a/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
@@ -50,7 +50,7 @@ / {
 };
 
 &backlight {
-	pwms = <&pwm2 0 500000 0>;
+	pwms = <&pwm2 0 500000 PWM_POLARITY_NORMAL>;
 	/delete-property/ turn-on-delay-ms;
 };
 
diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/imx6q-display5.dtsi
index 83524bb99eb3..b37382b0a4f1 100644
--- a/arch/arm/boot/dts/imx6q-display5.dtsi
+++ b/arch/arm/boot/dts/imx6q-display5.dtsi
@@ -56,7 +56,7 @@ backlight_lvds: backlight {
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_backlight>;
-		pwms = <&pwm2 0 5000000 0>;
+		pwms = <&pwm2 0 5000000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <  0   1   2   3   4   5   6   7   8   9
 				      10  11  12  13  14  15  16  17  18  19
 				      20  21  22  23  24  25  26  27  28  29
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
index ac3050a835e5..507133858719 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
@@ -50,7 +50,7 @@ / {
 };
 
 &backlight {
-	pwms = <&pwm2 0 500000 0>;
+	pwms = <&pwm2 0 500000 PWM_POLARITY_NORMAL>;
 	/delete-property/ turn-on-delay-ms;
 };
 
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
index a773f252816c..6656da97c7d2 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
@@ -50,7 +50,7 @@ / {
 };
 
 &backlight {
-	pwms = <&pwm2 0 500000 0>;
+	pwms = <&pwm2 0 500000 PWM_POLARITY_NORMAL>;
 	/delete-property/ turn-on-delay-ms;
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi b/arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi
index 2ca2eb37e14f..04387d0fe8f3 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi
@@ -48,7 +48,7 @@ aliases {
 
 	backlight0: backlight0 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 500000 0>;
+		pwms = <&pwm2 0 500000 PWM_POLARITY_NORMAL>;
 		power-supply = <&reg_lcd0_pwr>;
 		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
 				     10 11 12 13 14 15 16 17 18 19
@@ -66,7 +66,7 @@ backlight0: backlight0 {
 
 	backlight1: backlight1 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 500000 0>;
+		pwms = <&pwm1 0 500000 PWM_POLARITY_NORMAL>;
 		power-supply = <&reg_lcd1_pwr>;
 		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
 				     10 11 12 13 14 15 16 17 18 19
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index dbb98b03f9ad..4b0d8f35e119 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -4,12 +4,14 @@
  *
  */
 
+#include <dt-bindings/pwm/pwm.h>
+
 / {
 	bl: backlight {
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		pwms = <&pwm1 0 5000000 0>;
+		pwms = <&pwm1 0 5000000 PWM_POLARITY_NORMAL>;
 		enable-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 	};
 
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 6b4acea1ef79..b3e32b3a7a35 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "imx7d.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Boundary Devices i.MX7 Nitrogen7 Board";
@@ -26,7 +27,7 @@ backlight-j9 {
 
 	backlight_lcd: backlight-j20 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000 0>;
+		pwms = <&pwm1 0 5000000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index e57da0d32b98..08f0f46f1e60 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -5,11 +5,12 @@
 /dts-v1/;
 
 #include "imx7d.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 50000 0>;
+		pwms = <&pwm4 0 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 36 72 108 144 180 216 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 869efbc4af42..e924ee8eddcb 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -5,6 +5,7 @@
 /dts-v1/;
 
 #include "imx7d.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Freescale i.MX7 SabreSD Board";
@@ -129,7 +130,7 @@ reg_fec2_3v3: regulator-fec2-3v3 {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000 0>;
+		pwms = <&pwm1 0 5000000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-evk.dts
index eff51e113db4..818bc0fac3d4 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "imx7ulp.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "NXP i.MX7ULP EVK";
@@ -24,7 +25,7 @@ memory@60000000 {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&tpm4 1 50000 0>;
+		pwms = <&tpm4 1 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 20 25 30 35 40 100>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index ebbe1518ef8a..e9ea04540c16 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -49,7 +49,7 @@ audio_clock: audio_clock {
 	lcd_backlight: backlight {
 		compatible = "pwm-backlight";
 
-		pwms = <&pwm3 0 5000000 0>;
+		pwms = <&pwm3 0 5000000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpio5 14 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
index f7b82ced4080..4bf696c3c242 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
@@ -149,7 +149,7 @@ bl: backlight {
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
 		pinctrl-0 = <&backlight_pins>;
-		pwms = <&pwm10 0 5000000 0>;
+		pwms = <&pwm10 0 5000000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>; /* gpio_154 */
diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 163a200d5a7b..0380206eb13f 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -150,7 +150,7 @@ vcck: regulator-vcck {
 
 		vin-supply = <&vcc_5v>;
 
-		pwms = <&pwm_cd 0 1148 0>;
+		pwms = <&pwm_cd 0 1148 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
@@ -234,7 +234,7 @@ vddee: regulator-vddee {
 
 		vin-supply = <&vcc_5v>;
 
-		pwms = <&pwm_cd 1 1148 0>;
+		pwms = <&pwm_cd 1 1148 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/meson8b-mxq.dts
index 33037ef62d0a..910942d4785a 100644
--- a/arch/arm/boot/dts/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/meson8b-mxq.dts
@@ -39,7 +39,7 @@ vcck: regulator-vcck {
 		regulator-min-microvolt = <860000>;
 		regulator-max-microvolt = <1140000>;
 
-		pwms = <&pwm_cd 0 1148 0>;
+		pwms = <&pwm_cd 0 1148 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
@@ -86,7 +86,7 @@ vddee: regulator-vddee {
 
 		vin-supply = <&vcc_5v>;
 
-		pwms = <&pwm_cd 1 1148 0>;
+		pwms = <&pwm_cd 1 1148 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index a2a47804fc4a..cb7411fc6d84 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -132,7 +132,7 @@ vcck: regulator-vcck {
 
 		vin-supply = <&p5v0>;
 
-		pwms = <&pwm_cd 0 12218 0>;
+		pwms = <&pwm_cd 0 12218 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <91 0>;
 
 		regulator-boot-on;
@@ -164,7 +164,7 @@ vddee: regulator-vddee {
 
 		vin-supply = <&p5v0>;
 
-		pwms = <&pwm_cd 1 12218 0>;
+		pwms = <&pwm_cd 1 12218 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <91 0>;
 
 		regulator-boot-on;
diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index b6e82b165f5c..87b78dbe4b42 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -178,7 +178,8 @@ pwm9: dmtimer-pwm-9 {
 
 	vibrator {
 		compatible = "pwm-vibrator";
-		pwms = <&pwm9 0 10000000 0>, <&pwm8 0 10000000 0>;
+		pwms = <&pwm9 0 10000000 PWM_POLARITY_NORMAL>,
+		       <&pwm8 0 10000000 PWM_POLARITY_NORMAL>;
 		pwm-names = "enable", "direction";
 		direction-duty-cycle-ns = <10000000>;
 	};
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 409a758c99f1..a30278267ac2 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -138,7 +138,7 @@ lcd_in: endpoint {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm11 0 12000000 0>;
+		pwms = <&pwm11 0 12000000 PWM_POLARITY_NORMAL>;
 		pwm-names = "backlight";
 		brightness-levels = <0 11 20 30 40 50 60 70 80 90 100>;
 		default-brightness-level = <9>;	/* => 90 */
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 4089d97405c9..99e5f0e5a271 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -152,7 +152,7 @@ pwm9: dmtimer-pwm {
 
 	ir: n900-ir {
 		compatible = "nokia,n900-ir";
-		pwms = <&pwm9 0 26316 0>; /* 38000 Hz */
+		pwms = <&pwm9 0 26316 PWM_POLARITY_NORMAL>; /* 38000 Hz */
 	};
 
 	rom_rng: rng {
diff --git a/arch/arm/boot/dts/rk3288-veyron-edp.dtsi b/arch/arm/boot/dts/rk3288-veyron-edp.dtsi
index 32c0f10765dd..56404139ac28 100644
--- a/arch/arm/boot/dts/rk3288-veyron-edp.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-edp.dtsi
@@ -47,7 +47,7 @@ backlight: backlight {
 		enable-gpios = <&gpio7 RK_PA2 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
-		pwms = <&pwm0 0 1000000 0>;
+		pwms = <&pwm0 0 1000000 PWM_POLARITY_NORMAL>;
 		post-pwm-on-delay-ms = <10>;
 		pwm-off-delay-ms = <10>;
 		power-supply = <&backlight_regulator>;
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 54a6838d73f5..58dd4fbd057c 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -101,7 +101,7 @@ vdd_logic: vdd-logic {
 		compatible = "pwm-regulator";
 		regulator-name = "vdd_logic";
 
-		pwms = <&pwm1 0 1994 0>;
+		pwms = <&pwm1 0 1994 PWM_POLARITY_NORMAL>;
 		pwm-supply = <&vcc33_sys>;
 
 		pwm-dutycycle-range = <0x7b 0>;
diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 30f3d0470ad9..dc7efab6af93 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -53,7 +53,7 @@ backlight: backlight {
 			240 241 242 243 244 245 246 247
 			248 249 250 251 252 253 254 255>;
 		default-brightness-level = <200>;
-		pwms = <&pwm0 0 25000 0>;
+		pwms = <&pwm0 0 25000 PWM_POLARITY_NORMAL>;
 	};
 
 	vcc_sys: vsys-regulator {
diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 1aeac33b0d34..30814ae5c09d 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -159,7 +159,7 @@ led-4 {
 
 	buzzer {
 		compatible = "pwm-beeper";
-		pwms = <&pwm 0 1000000 0>;
+		pwms = <&pwm 0 1000000 PWM_POLARITY_NORMAL>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_out>;
 	};
diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 8ff70b856334..68c909588fa8 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -324,7 +324,7 @@ fuelgauge@36 {
 
 	vibrator: pwm-vibrator {
 		compatible = "pwm-vibrator";
-		pwms = <&pwm 1 44642 0>;
+		pwms = <&pwm 1 44642 PWM_POLARITY_NORMAL>;
 		pwm-names = "enable";
 		vcc-supply = <&vibrator_pwr>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index 84b38f185199..440c6811ff58 100644
--- a/arch/arm/boot/dts/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkv210.dts
@@ -42,7 +42,7 @@ ethernet@18000000 {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000 0>;
+		pwms = <&pwm 3 5000000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun5i-gr8-evb.dts b/arch/arm/boot/dts/sun5i-gr8-evb.dts
index 4c20d731a9c6..0e4e2cee3a64 100644
--- a/arch/arm/boot/dts/sun5i-gr8-evb.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-evb.dts
@@ -69,7 +69,7 @@ chosen {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 10000 0>;
+		pwms = <&pwm 0 10000 PWM_POLARITY_NORMAL>;
 		enable-gpios = <&axp_gpio 1 GPIO_ACTIVE_HIGH>;
 
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index fba37b8756f7..ff7c703cde4f 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -39,6 +39,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/pwm/pwm.h>
+
 / {
 	aliases {
 		ethernet0 = &fec1;
@@ -49,7 +51,7 @@ bl: backlight {
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		pwms = <&pwm0 0 5000000 0>;
+		pwms = <&pwm0 0 5000000 PWM_POLARITY_NORMAL>;
 		enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
 		status = "disabled";
 	};
-- 
2.24.1

