Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9635A25E880
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 16:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIEOtg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 10:49:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:42887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgIEOtf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 10:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599317302;
        bh=IEqH3VoTRXkoCSwxpZXBM0ZvuxmxgH/x3EDZy/MG2ug=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=W0utoWUmqvO2Wd2qTBiiYg1KT/7DFNZCaZ1br1LTG0jedm7h24I8c6dIUsOPf8h/Z
         5l3ZfMKmOEcNRy/RRKhdWWZGnSPnyuHRIlk+gMmU/W1Ai5VQRXPZc4MnF4slMpb5w9
         GbKMrXyhMc4SiLKLFqLpwzbSAcmraVYT2440Ycvg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDkm-1kTvby1Z5U-00xYm9; Sat, 05
 Sep 2020 16:48:22 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 10/10] ARM: dts: imx50-kobo-aura: Add Netronix embedded controller
Date:   Sat,  5 Sep 2020 16:45:02 +0200
Message-Id: <20200905144503.1067124-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vd9WOJrL43K7tgXIjq+fdw9XpujdDSKHb/13PJSlNAFTkIecV3o
 YX60zXdJjQ7qrZGkVCx1QVkyHK577opkAkZxYApe/pLtMTeHNJdsZBVrxxltqp8R826PARL
 YT8qR1GI4TmQgraabm+q2Jo32c+tsVXi91TIHEnv5RGm3QIjbzxvXecgaroLZC4XJTqqpdO
 nUWXhlV+LNhWwUkEfiCzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U1k4lbRWrSE=:kW2LDdSUqFSDmkB9xbWR4m
 wDNaXCZB0NWQdgtEuiPwP3ZYwh6M4FN0JbvRQfRMjfqiIDsl3g6vah7ukL3aXCRxfh/Jiuowu
 +vhJ1xFxvhrEOlTyPVJn3ozg94YY1L7NYBQ9Jm5LncQHjf/VekSvkgFSA1JhFXqOoTQ3f9mpb
 biihceeKyndJsAOtgJGGzxbplyE9Jsuc+p9vOnBdtl7PTRs9La7TLZqbyiYaJAaU8RmPbxBEn
 gdzGAuJ4sWA+5DkWodqXLOAQYS9W7/InG1mEQ1A2pcCqmqSahIPiA72B3Bhy0wIsjte1o2z3n
 OaM4xOlmoyfLO5urSaKLPpiveHzyjDOE4M0z0exteSeeN+PYJ+2gbafpEp7Hr2EAwVs534sgq
 DH9aP2/QIRo0cwYIQFQrU8GC3Vfpbobo6e7oxolfaIQZvYpcSpAZIuJI9/AAjsvrVaI18tl7N
 F7f8Xx2fA+LStWZYYUlWpAZEx8bljyK8RoxoGu/1s8ggU/0myLny/AOjmw3wjmHvEzsDEJ7Vp
 TZLaYbqEaDgkY271WWe4snF0/hDIPrZDnn4BRm+4BDjJRYq7eYXEZSb+fEW95CuXhF5ig9xzW
 MoO9n2+0gX6zA4RCBw/cQQgmjV2JskpaAr1Bqmfh1E7QPiKViuPdh3SHiVP5O+yeInsti7y0P
 O268Rve+4x4jxXYUVPa90bS45F4jn2sIonIzF9WGS05bN4zbtzVNbXODMXTkfc81oz7WWnXkr
 igVcOtmVrn7NZ+EiHZW2D4NcAATzQAg+l4kGW8CVuLXio5txNmg5XVZN7ujryaiZTUTsiow9W
 gta1dBmrXPIq6MZtRykxi/lkFBTpUo6GUtyjqAJCCsbFV9tRBAGMsJb7dmvau5zV2TJly0TVm
 qyBaM/nuew9hqvB2gJZhk86sBnUVLWEl8rVa1m/ExI1pnCp0k9jnBTzaOjxacHDZf/TueqfxT
 S5zu8IgrNZgLxpS6mA8vG0pExVmUbd48DkMkAuzfbNj2UT0VJ3H5zZIDWSEu/cipqjR8WQSln
 Kx/+ueTNRIZHqcZEI2bSHdKIV1yDPySIVTgTSGLLYs8T85zpTB7UGy4uZ68LOPXBEFFAFFJpd
 PU9uAzWLYvlvlPrrYZR/dZXne7MDTNM/59YFoDYou8mhjNqzORK09d/JWucccI8DMmy+kFxKY
 Ue0LoqLnyPRPe3F8Z4Ls1dHGwLd+31wlwlbQhjaIiEeRQmI1EpXDcHUV+V/FgsYFowN5COD+m
 XqerjoYe32hvo49OC70pAwbeklHL10pJRjmzZLQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Enable the Netronix EC on the Kobo Aura ebook reader.

Several features are still missing:
 - Frontlight/backlight. The vendor kernel drives the frontlight LED
   using the PWM output of the EC and an additional boost pin that
   increases the brightness.
 - Battery monitoring
 - Interrupts for RTC alarm and low-battery events

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- Fix pwm-cells property (should be 2, not 1)
=2D--
 arch/arm/boot/dts/imx50-kobo-aura.dts | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/imx=
50-kobo-aura.dts
index a0eaf869b9135..003a7d894902c 100644
=2D-- a/arch/arm/boot/dts/imx50-kobo-aura.dts
+++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 #include "imx50.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>

 / {
 	model =3D "Kobo Aura (N514)";
@@ -135,10 +136,34 @@ &i2c3 {
 	pinctrl-0 =3D <&pinctrl_i2c3>;
 	status =3D "okay";

-	/* TODO: embedded controller at 0x43 */
+	embedded-controller@43 {
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_ec>;
+		compatible =3D "netronix,ntxec";
+		reg =3D <0x43>;
+		system-power-controller;
+		interrupts-extended =3D <&gpio4 11 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells =3D <1>;
+
+		ec_pwm: pwm {
+			compatible =3D "netronix,ntxec-pwm";
+			#pwm-cells =3D <2>;
+		};
+
+		rtc {
+			compatible =3D "netronix,ntxec-rtc";
+		};
+	};
 };

 &iomuxc {
+	pinctrl_ec: ec {
+		fsl,pins =3D <
+			MX50_PAD_CSPI_SS0__GPIO4_11		0x0	/* INT */
+		>;
+	};
+
 	pinctrl_gpiokeys: gpiokeys {
 		fsl,pins =3D <
 			MX50_PAD_CSPI_MISO__GPIO4_10		0x0
=2D-
2.28.0

