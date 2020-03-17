Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99D718844A
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 13:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCQMdM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 08:33:12 -0400
Received: from mail-bgr052101134067.outbound.protection.outlook.com ([52.101.134.67]:55685
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbgCQMdL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 08:33:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdbzNbA+yVBwfCsuAeBduGF/33F0g4qeg9kaRicH5rbhXLssA63xSbSwoB1bWFgEhOOqy4Eu6HEUDwKdmHhtUiD1OchbZfZ7wF16MlThtL7i6BIkX0ByTArzSRF9387jAFHiWHwVID41L9ybxJhZZeatBv/3XvVkSZ3Lzq342MmBtuteSGwEML/Mz2kvnJNfHtw0v4YXnR2QTmzObnL6Al4Iauygf5EiLlNUngw8vgOPrE0ZpgSG2b3D5cBE5gfSDD4n88ygAZT4oVJq0m2B5xWpRUbofKTX921RhXfxgfUP+AmWC+4jtl8KtVyXS8m7qIgLt7zfKc8qTOVuKO8JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wtL1nZXpd+XXipa1VX+ckcknea0pBxc/qEXwx6X1Tc=;
 b=d9JDGBTiMsKOwGUuYyeLv9Eh31aX7COLALLX1MN/JqHitpP64KxQDoVUcHn4lXC/sSZWWzU19JS1lt0mMgs8F88tfi8GQc2TYVDkE0bOca8y1cvgooUvdTd+YGDkK6NBgdx4odR6HiirpqgNU/36VIrFJmbbucsLOrsEUCPp/J7Er89nmAA3nd4tTs2P7wlLahtNbLu8ibYk1pMIiifCakJ0fngTTgrt2oeO5e7mjKVJ6Irff2DZ2G84NJ/sOokimvb7yMpUkf5C73ISlbvnjIArv/9+j8GhDlafX9OoO7bxO+zkYsxrGTmxGcmQdayS+Jwl+1VEhvFbvr6+r5OoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wtL1nZXpd+XXipa1VX+ckcknea0pBxc/qEXwx6X1Tc=;
 b=LzvEkGksEIx3rsShVBrkHUvMlz6jfjxXcT5uxy3cBQe/gnQwJump3s9jhHOJgU48bVYjbwC4D4es1O+THpHXrmmzbCCUI4ZM5oMADc18Pz6y4/97EC/hUvVZI1LVT7d4D406c5wmGOBFPlkgTi8N2x/u9q9yYNQDF+0WZ4Pm/V8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB4462.eurprd05.prod.outlook.com (10.171.182.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 12:32:54 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 12:32:54 +0000
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
        =?UTF-8?q?Andrius=20=C5=A0tikonas?= <andrius@stikonas.eu>,
        Andy Yan <andy.yan@rock-chips.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Kever Yang <kever.yang@rock-chips.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nick Xie <nick@khadas.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Soeren Moch <smoch@web.de>, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [RFC PATCH 6/7] arm64: dts: pwm: replace polarity constant with macro
Date:   Tue, 17 Mar 2020 14:32:30 +0200
Message-Id: <20200317123231.2843297-7-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0218.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::14) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (82.193.109.226) by PR0P264CA0218.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14 via Frontend Transport; Tue, 17 Mar 2020 12:32:54 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [82.193.109.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ef9f637-63f4-49e2-4979-08d7ca6f50c6
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:|VI1PR05MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB44627295B1362D175A332164F9F60@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(4636009)(39850400004)(396003)(136003)(366004)(346002)(376002)(199004)(66946007)(6666004)(66476007)(66556008)(5660300002)(7406005)(36756003)(7416002)(30864003)(1076003)(4326008)(26005)(6496006)(44832011)(52116002)(54906003)(81166006)(81156014)(2906002)(8676002)(55236004)(316002)(186003)(8936002)(956004)(478600001)(2616005)(6486002)(86362001)(16526019)(23200700001);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR05MB4462;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;CAT:OSPM;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Grtzewr3FeoAz6uyJQ90Y/K5++wcacWMwVqqUqDG1xfOyCQAzGLv1kFOww1sTodsb0HNU31A9qphIT9AjEhEH2M3JUUgzjeLrsXh9z+1nf+wYmI22yJnFuuSn69okhY0JEJj8Qva41TFVqA1GaB4N4dbvHYnINgTBMuKo+TyMrE8wq0OfbJI9w9WHVPS+yKOypIBT4fMgqg3YkNQv+r1Ia62zPbf8Fx6dtbsbCBi+xn7fBTzZieRU9gW3DAILmjz/STq92WfHZU99DtwsaRqdc2xvxgv0ZUZzUC3vI3FIjfCJTe7BcNZmp3V+0E/Mr+QGmipg6lQgFeG8HxwjCSxI7VvUDNchW0LUNlM+xRcoty3X8f2f8iIk9A0TVkDxEQbezxM5pFMrqD6R29GFlNtdt41Mc1LsZFoSJhWOMjNK7om6d9RBNYFkpK0XEkInXDjrPyHalEFZcV5JjJASvY89fiQdynaf0wuaTECd0jG9itNhgGIhYFTNZqFUH3z+DILTAfFgJuoqs50XEk8C71oENWGNMkkYcOXzkvD5Mvr2+RwC/zfX9v3Bksw4ewtJ+J3ptNM2japxrMg9HMQq6nxJ9ciNNUGHOaGjX7QTqDh2QTwra47PuRSPNZwZSV619A/jwoiBufhRnS0m74pe8ipraSL4z4lkqwUmPQRoXLZWZPHSxevid35VaqZ3hYALeEuusrGhyMpv/fF/1qjCnzEwWDH4MPXCQC42OzfbUeHiqQayoUBoaPjoGNf/fF5bdoUpt29669SNFSZ4FzosXHwLw==
X-MS-Exchange-AntiSpam-MessageData: XL/q3X9IA1St81Jaz6ffDv1irHLS5vYAB9mLfcKY63WmDFKX7iKzf3RHgLTrYQ/loKChb2UQTsOY7d0kseUifN//ZDrqTyNzU4nE04J/uHJUivXZivsNLM1IEHq9fHTJBUqnYZYZyYEhqsLL2Fh7bA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef9f637-63f4-49e2-4979-08d7ca6f50c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:32:54.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vS0/x60yo50mruhFSVS2DZRk+k8Gcn5nkZUcE6B8Kxjker3T7U86a48/RKzZBJzpS6n8jZPUoBjbq4Ot4FYj0BqV3Uz7Fp8kP/KOFaNIaOA=
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
- include pwm.h in some dts/dtsi to fix building errors about undefined
  symbols.
- fix the patman warnings about the code format;

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts      | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts       | 2 +-
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts             | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                 | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi          | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts          | 5 +++--
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts            | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts         | 5 +++--
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi    | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts       | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts       | 7 ++++---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi        | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                  | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts       | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts     | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi           | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi       | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi          | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts       | 3 ++-
 .../boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts    | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 +-
 .../arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi      | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts      | 5 +++--
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts         | 3 ++-
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi         | 4 +++-
 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts     | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts           | 7 ++++---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi      | 3 ++-
 arch/arm64/boot/dts/rockchip/px30-evb.dts                  | 2 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi                     | 1 +
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts             | 2 +-
 arch/arm64/boot/dts/rockchip/rk3308.dtsi                   | 1 +
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts                | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi       | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi               | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi       | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts          | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi         | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                   | 1 +
 44 files changed, 77 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 64b1c54f87c0..adbcf6abf338 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -23,7 +23,7 @@ aliases {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 0>;
+		pwms = <&pwm 0 50000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <0 5 10 15 20 30 40 55 70 85 100>;
 		default-brightness-level = <2>;
 		enable-gpios = <&pio 3 23 GPIO_ACTIVE_HIGH>; /* PD23 */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index f5df5f705b72..083f3dc9deaa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -21,7 +21,7 @@ aliases {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 50000 0>;
+		pwms = <&pwm 0 50000 PWM_POLARITY_NORMAL>;
 		power-supply = <&reg_dcdc1>;
 		brightness-levels = <0 5 7 10 14 20 28 40 56 80 112>;
 		default-brightness-level = <5>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index cb1360ae1211..97b31a914def 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -356,7 +356,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ab 0 30518 0>; /* PWM_A at 32.768KHz */
+		/* PWM_A at 32.768KHz */
+		pwms = <&pwm_ab 0 30518 PWM_POLARITY_NORMAL>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index aace3d32a3df..e536436f6306 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/meson-axg-gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 87b9a47a51b9..c1f8232fdde1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/g12a-aoclkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 168f460e11fa..7408c5b58105 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -141,7 +141,7 @@ vddcpu: regulator-vddcpu {
 
 		vin-supply = <&dc_in>;
 
-		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwms = <&pwm_AO_cd 1 1250 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
@@ -176,7 +176,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sound {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 2a324f0136e3..7b1e17267ae3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -141,7 +141,7 @@ vddcpu: regulator-vddcpu {
 
 		vin-supply = <&main_12v>;
 
-		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwms = <&pwm_AO_cd 1 1250 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 4f2596d82989..8cc90ae9b326 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -141,7 +141,7 @@ vddcpu: regulator-vddcpu {
 
 		vin-supply = <&dc_in>;
 
-		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwms = <&pwm_AO_cd 1 1250 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
@@ -232,7 +232,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index b1fab5749ca8..9d1411724dbb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -20,7 +20,7 @@ vddcpu_a: regulator-vddcpu-a {
 
 		vin-supply = <&dc_in>;
 
-		pwms = <&pwm_ab 0 1250 0>;
+		pwms = <&pwm_ab 0 1250 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
@@ -39,7 +39,7 @@ vddcpu_b: regulator-vddcpu-b {
 
 		vin-supply = <&vsys_3v3>;
 
-		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwms = <&pwm_AO_cd 1 1250 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 8830d3844885..4c3252b0cc67 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -127,7 +127,7 @@ vddcpu_a: regulator-vddcpu-a {
 
 		vin-supply = <&main_12v>;
 
-		pwms = <&pwm_ab 0 1250 0>;
+		pwms = <&pwm_ab 0 1250 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
@@ -146,7 +146,7 @@ vddcpu_b: regulator-vddcpu-b {
 
 		vin-supply = <&main_12v>;
 
-		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwms = <&pwm_AO_cd 1 1250 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
index ccd0bced01e8..15759f3df472 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
@@ -109,7 +109,7 @@ vddcpu_a: regulator-vddcpu-a {
 
 		vin-supply = <&main_12v>;
 
-		pwms = <&pwm_ab 0 1250 0>;
+		pwms = <&pwm_ab 0 1250 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
@@ -128,7 +128,7 @@ vddcpu_b: regulator-vddcpu-b {
 
 		vin-supply = <&main_12v>;
 
-		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwms = <&pwm_AO_cd 1 1250 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
@@ -282,7 +282,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 12d5e333e5f2..4e1a429b3dff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -72,7 +72,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 40db06e28b66..d584c99e60c6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	interrupt-parent = <&gic>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index d6ca684e0e61..6dc2e6aafe97 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -79,7 +79,8 @@ wifi_32k: wifi-32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index 65ec7dea828c..77d1d729e857 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -109,7 +109,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index e803a466fe4e..41406fba88bc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -83,7 +83,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 45cb83625951..59e436c41da9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -77,7 +77,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	hdmi-connector {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index dee51cf95223..2d0c4badfe3b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -82,7 +82,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
index a1119cfb0280..90cfdb96cba9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
@@ -93,7 +93,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
index c8d74e61dec1..69b9f2a31ae3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
@@ -72,7 +72,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 440bc23c7342..95b654846db8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -47,7 +47,7 @@ pwmleds {
 
 		power {
 			label = "vim:red:power";
-			pwms = <&pwm_AO_ab 1 7812500 0>;
+			pwms = <&pwm_AO_ab 1 7812500 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 62dd87821ce5..28c814460d72 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -72,7 +72,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 6ac678f88bd8..b7923f2278b7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -76,7 +76,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index d5dc12878dfe..674e5e765a32 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -87,7 +87,7 @@ pwmleds {
 
 		power {
 			label = "vim:red:power";
-			pwms = <&pwm_AO_ab 1 7812500 0>;
+			pwms = <&pwm_AO_ab 1 7812500 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
@@ -187,7 +187,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 420a88e9a195..87475bd61cdf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -81,7 +81,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 90815fa25ec6..a5babf55a937 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "Khadas VIM3";
@@ -167,7 +168,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index dbbf29a0dbf6..23e3bc0cc765 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -25,7 +25,7 @@ vddcpu: regulator-vddcpu {
 
 		vin-supply = <&vsys_3v3>;
 
-		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwms = <&pwm_AO_cd 1 1250 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index cb1b48f5b8b1..e55631b815c3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -116,7 +116,7 @@ pwmleds {
 
 		power {
 			label = "sei610:red:power";
-			pwms = <&pwm_AO_ab 0 30518 0>;
+			pwms = <&pwm_AO_ab 0 30518 PWM_POLARITY_NORMAL>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 			active-low;
@@ -187,7 +187,7 @@ vddcpu: regulator-vddcpu {
 
 		vin-supply = <&dc_in>;
 
-		pwms = <&pwm_AO_cd 1 1500 0>;
+		pwms = <&pwm_AO_cd 1 1500 PWM_POLARITY_NORMAL>;
 		pwm-dutycycle-range = <100 0>;
 
 		regulator-boot-on;
@@ -336,7 +336,8 @@ wifi32k: wifi32k {
 		compatible = "pwm-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+		/* PWM_E at 32.768KHz */
+		pwms = <&pwm_ef 0 30518 PWM_POLARITY_NORMAL>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 250fc01de78d..f70703df97e3 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/sound/samsung-i2s.h>
 
 / {
@@ -913,7 +914,7 @@ charger_reg: CHARGER {
 		haptic: max77843-haptic {
 			compatible = "maxim,max77843-haptic";
 			haptic-supply = <&ldo38_reg>;
-			pwms = <&pwm 0 33670 0>;
+			pwms = <&pwm 0 33670 PWM_POLARITY_NORMAL>;
 			pwm-names = "haptic";
 		};
 	};
diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index 0a680257d9c2..f9359ece5b28 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -57,7 +57,7 @@ vol-up-key {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 25000 0>;
+		pwms = <&pwm1 0 25000 PWM_POLARITY_NORMAL>;
 		power-supply = <&vcc3v3_lcd>;
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 60de8e9c421b..97bf03d536a3 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/power/px30-power.h>
+#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index aa256350b18f..502d2d9fa8dc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -22,7 +22,7 @@ ir_rx {
 
 	ir_tx {
 		compatible = "pwm-ir-tx";
-		pwms = <&pwm5 0 25000 0>;
+		pwms = <&pwm5 0 25000 PWM_POLARITY_NORMAL>;
 	};
 
 	leds {
diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index ac43bc3f7031..f3d0295a8046 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 #include <dt-bindings/thermal/thermal.h>
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 694b0d08d644..6fd15469b6f0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -47,7 +47,7 @@ backlight: backlight {
 			240 241 242 243 244 245 246 247
 			248 249 250 251 252 253 254 255>;
 		default-brightness-level = <200>;
-		pwms = <&pwm0 0 25000 0>;
+		pwms = <&pwm0 0 25000 PWM_POLARITY_NORMAL>;
 	};
 
 	edp_panel: edp-panel {
@@ -72,7 +72,7 @@ clkin_gmac: external-gmac-clock {
 
 	vdd_center: vdd-center {
 		compatible = "pwm-regulator";
-		pwms = <&pwm3 0 25000 0>;
+		pwms = <&pwm3 0 25000 PWM_POLARITY_NORMAL>;
 		regulator-name = "vdd_center";
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index d63faf38cc81..c233f8a2f444 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -20,7 +20,7 @@ chosen {
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
-		pwms = <&pwm0 0 25000 0>;
+		pwms = <&pwm0 0 25000 PWM_POLARITY_NORMAL>;
 		brightness-levels = <
 			  0   1   2   3   4   5   6   7
 			  8   9  10  11  12  13  14  15
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 1384dabbdf40..ae44d55e38d1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -50,7 +50,7 @@ ppvar_centerlogic_pwm: ppvar-centerlogic-pwm {
 		compatible = "pwm-regulator";
 		regulator-name = "ppvar_centerlogic_pwm";
 
-		pwms = <&pwm3 0 3337 0>;
+		pwms = <&pwm3 0 3337 PWM_POLARITY_NORMAL>;
 		pwm-supply = <&ppvar_sys>;
 		pwm-dutycycle-range = <100 0>;
 		pwm-dutycycle-unit = <100>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index 4373ed732af7..e7c2d31bece2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -164,7 +164,7 @@ backlight: backlight {
 		enable-gpios = <&gpio4 21 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
-		pwms = <&pwm1 0 1000000 0>;
+		pwms = <&pwm1 0 1000000 PWM_POLARITY_NORMAL>;
 		pwm-delay-us = <10000>;
 	};
 
@@ -217,7 +217,7 @@ &ppvar_bigcpu {
 
 &ppvar_bigcpu_pwm {
 	/* On scarlet ppvar big cpu use pwm3 */
-	pwms = <&pwm3 0 3337 0>;
+	pwms = <&pwm3 0 3337 PWM_POLARITY_NORMAL>;
 	regulator-min-microvolt = <800074>;
 	regulator-max-microvolt = <1299226>;
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 2f3997740068..f5ebafb64820 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -101,7 +101,7 @@ ppvar_bigcpu_pwm: ppvar-bigcpu-pwm {
 		compatible = "pwm-regulator";
 		regulator-name = "ppvar_bigcpu_pwm";
 
-		pwms = <&pwm1 0 3337 0>;
+		pwms = <&pwm1 0 3337 PWM_POLARITY_NORMAL>;
 		pwm-supply = <&ppvar_sys>;
 		pwm-dutycycle-range = <100 0>;
 		pwm-dutycycle-unit = <100>;
@@ -130,7 +130,7 @@ ppvar_litcpu_pwm: ppvar-litcpu-pwm {
 		compatible = "pwm-regulator";
 		regulator-name = "ppvar_litcpu_pwm";
 
-		pwms = <&pwm2 0 3337 0>;
+		pwms = <&pwm2 0 3337 PWM_POLARITY_NORMAL>;
 		pwm-supply = <&ppvar_sys>;
 		pwm-dutycycle-range = <100 0>;
 		pwm-dutycycle-unit = <100>;
@@ -159,7 +159,7 @@ ppvar_gpu_pwm: ppvar-gpu-pwm {
 		compatible = "pwm-regulator";
 		regulator-name = "ppvar_gpu_pwm";
 
-		pwms = <&pwm0 0 3337 0>;
+		pwms = <&pwm0 0 3337 PWM_POLARITY_NORMAL>;
 		pwm-supply = <&ppvar_sys>;
 		pwm-dutycycle-range = <100 0>;
 		pwm-dutycycle-unit = <100>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index e87a04477440..979fd0832efd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -161,7 +161,7 @@ fan: pwm-fan {
 		cooling-levels = <0 150 200 255>;
 		#cooling-cells = <2>;
 		fan-supply = <&vsys_5v0>;
-		pwms = <&pwm0 0 40000 0>;
+		pwms = <&pwm0 0 40000 PWM_POLARITY_NORMAL>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
index e0d75617bb7e..c63a115930aa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
@@ -62,7 +62,7 @@ fan: pwm-fan {
 		cooling-levels = <0 12 18 255>;
 		#cooling-cells = <2>;
 		fan-supply = <&vcc12v0_sys>;
-		pwms = <&pwm1 0 50000 0>;
+		pwms = <&pwm1 0 50000 PWM_POLARITY_NORMAL>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 9f225e9c3d54..3656a8d71b4a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -19,7 +19,7 @@ chosen {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm0 0 25000 0>;
+		pwms = <&pwm0 0 25000 PWM_POLARITY_NORMAL>;
 	};
 
 	clkin_gmac: external-gmac-clock {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 9bca25801260..2712270e93ca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -58,7 +58,7 @@ fan: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
 		fan-supply = <&vcc12v_dcin>;
-		pwms = <&pwm1 0 50000 0>;
+		pwms = <&pwm1 0 50000 PWM_POLARITY_NORMAL>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
index b4d8f60b7e44..0b658374fb9a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
@@ -79,7 +79,7 @@ backlight: backlight {
 			248 249 250 251 252 253 254 255>;
 		default-brightness-level = <200>;
 		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
-		pwms = <&pwm0 0 25000 0>;
+		pwms = <&pwm0 0 25000 PWM_POLARITY_NORMAL>;
 		status = "okay";
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 28c7ee540439..8e7dfa8449c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/power/rk3399-power.h>
+#include <dt-bindings/pwm/pwm.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
-- 
2.24.1

