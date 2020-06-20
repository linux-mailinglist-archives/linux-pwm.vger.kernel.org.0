Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA7C20272F
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgFTWoE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:44:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:60347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbgFTWoD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592693004;
        bh=VyVCIBxPFyt78YSnxS+0Id2tmE8pzSJjUVG0PtP0FGo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CFnOTQM3hDO8qn9SOfaIxccrUDsONIICDvI+jIsmU+SlgaKoyLBeI2FNpplaFvAWy
         6vY1mnLluuZd7IZt/swaQFqEX18Q7jG2KaUvebExAJHnaAawbBx2eqD9VRW6+OUS7b
         rt5yw5PsHF5ZMIRapjiBMysuRzC8UMFUS1FKtUgw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1j0qH413NO-00m7VT; Sun, 21
 Jun 2020 00:43:24 +0200
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
        Andreas Kemnade <andreas@kemnade.info>
Subject: [RFC PATCH 10/10] ARM: dts: imx50-kobo-aura: Add Netronix embedded controller
Date:   Sun, 21 Jun 2020 00:42:21 +0200
Message-Id: <20200620224222.1312520-9-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4FNCq66znOgeVyoZjrNrgMQNLnnTq7LrgHosR3ZKBWDuWQR51Y9
 hYPhfmsJMKVLhNUIXKWpXJ8DaN+Mi7bhYl3wdJNS0UubbVPRgXNfjSkkZ5Sakhi9Sdwyrqb
 n/bhq7zcYZO6wnOqrkTvllNX/Rorn0iDQKN/y2kqkLi3twA6ydDRZZjvdVGpX8tOPT+hgXi
 qyEaws9q/M2HxQVCbgODg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UY/7ZGF2UsM=:2TV1b5ihDM1IbSjjYU1cq1
 RurzmoY+h7ogNf0pk+B8diNEMciUuUtbF+eEBnMAlAYZQAeyf7ODTcGaAYuxubkKzrw6pRrKJ
 u7YKup/L3RbNQoPDjcWXk4fy6YId5jZy64LSPR1WidU++P1QdFUMTRGMWdhQZRHO2wIaO1BZn
 pHCfee3VGUHyqGqVCsLTVs+nflPhgABgpwXuXsfcI7/8A6YfGAsPsMbNIyWSZ9tHEGmFYIrXV
 9sw+s9jn3cymB1+YgQBkvFyB3pz5SCd4jYb11PbjEXKNeBh8PslQ240dM4MRaMPBzmpsfqKzd
 KqKZ9BV56kgqBZ0rqvOt+lJiaiIHTK5vvbTwOq4x5h0CL1x2Y7X2N8h2G0eGp8UFoJKBezwZ/
 bptNe9he5o2CR60qp6N7yD0sKvcY0Zven21jgG1dd8+DHfVHZ1rN2XY2vM5U/W0niVLm/JVfB
 gZ33qS2Thm0GwLuVsIxhLIKT0ZlBEUFS4VhQNhi98hXbiiZYHHR53hFQzWiP1sKO3z4Our42E
 0IVOARxJspuAOEqe+aXN1hCpwcfpDg+BWJ7dgKhX4N+Fnp9gHg+7KNHXbkzcIqP3V92O0rPba
 M9ftV0TJkC6NfKOo/SJasHwCVxlJFzkbHcbK57O4PNMZ3cxmyVNamvu46vkMKdKRcqk/EJAQq
 5gia4k5YBdK+aeFaDR09cV714TJyM6Dd7A/B79plDwQs/lzQiRlQLF0dmiJwtLG7fo6xX5evk
 7RPAZWCIjix7UrczoIc39V/7i7ymswXVcynXVEd0ujyQOmWG1o3RzWj450uvLgZToixsKuuUq
 KGZmeDaq8Or82WumlQWOQrcyRQs8dI/KM0xj/TwIUJXahH4mAfR10uTlxIFg0sLxYZognpgVP
 qDruGDJNBKefU/b+VzCyuE+Mda+XtDSapia4GD9fseEy/7U2DRmZ36JKDE63uKdgfZtlFXuv4
 A1cEFebGf3D/i8AJaFUFevkThCFTLPmDye9CabeWM486RdZriVTukJ920ITC2cAWzpAvJV93p
 XAsaI1gazr2r4BfRSecIP0hsrjuO7zsDsCAWskQTzEQ4rXEshJ1HGGFJuiIEeT9lcxPRspQmB
 O5GzmmA+VzRqk1K63LwvFdcz0X6nWMfZjvFiFUlHSpceygtOdqA11RG8sx5tyYrT4n1tlI7Xc
 ijf+a/KpCxLlVe1eTikWgm3UKYCPw6bjRo7MVI9Euzi3A+UP97FKrDiq8RN+x9J1Z4DzjO667
 BmUzrKMJbsAVFhh5M
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
2.27.0

