Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110DD2F0311
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Jan 2021 20:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhAITHf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 9 Jan 2021 14:07:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:52635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbhAITHe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 9 Jan 2021 14:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610219126;
        bh=beDFWMFQH5cVEblcA3Gd98HHThRVyNU/HW/JMjwDv+E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GVrMersmNZOPW3JOV9lRKY4Mf0rbxmgsdavGx7fcZxnOTDIpu9wmgncZMOacZKMrD
         /Oix2U8C5r+AzDeOcKMtGBsxCs8YilxRHThui6aYOWm3+3FDlXbJiBhxi1I31UjPDn
         Rk+/Hb2Tkthe2zvkD509S54sQjCvfEOXsG7k3bvA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1kjP2K2Uqw-00G036; Sat, 09
 Jan 2021 20:05:26 +0100
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v7 7/7] ARM: dts: imx50-kobo-aura: Add Netronix embedded controller
Date:   Sat,  9 Jan 2021 19:02:20 +0100
Message-Id: <20210109180220.121511-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109180220.121511-1-j.neuschaefer@gmx.net>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HOscdZhtcppg+O3FCnk9a2KxpaGEBDszhkK1cm9MYgZycE754P1
 pf3Dc1S8tipzSe8hh2qchdOFrj+1GporoDZ6wJAIFJEysWL/9ZhShhc93QRVkhgvt+MQcNu
 VBypSFDmK1n6VJzhK75zALkB2DN7lwnQit1E32fSUddaLekOdhtWEATpKAK3FRUA2luVzcQ
 Fz3FXszv+SrcpUWBQLaIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:y+0rmWr9ruU=:5wKkfmM9TRYM4p1/NxSKzY
 LtiJdANiuIem7DV3QI8QmK5ysefqJdmPuilmM13PlPOOiPibZ23zE+/sbqLHaa8V36SlJlH6Q
 rO63muOUa+laFA1DOMw7lIYW3juLbNTPyyd7K6FHlDATGZGna6OfDIfQ3fgSc+CvoCZoqEPbb
 JvHPDP9Jnpi3GgfwsKwzqmwXXDObX1oc6rnr9awhGJeX26ynQ1yP75anhNPkz20OlgU5klw0A
 x4zPmPJ/ZPzon2+VPc59vGxVEiaUx7O5BobNBbixT3kvhfatEiBy0a8dv6OWtfa1T5uQkA4zI
 2SGhvcQl25aME1j75JX9pmCLnKjE7Hdm1YHzkhntV3F4M9rCjoek81qQ4Hl8RR6peu9YWnRqs
 J5c9Zhxnl4IFB2jFQGYSrfLWNidNEOfzJaLtfCDifGGKf/YoSLD/PDhA4r2SDeYNdHBwZs5go
 u2pr46lHmpYnhDU+dvXaqYCOnIGCZH+VDBZWg23laDXyXEjADbPzQjBxLv4+vsYCNea66DUlZ
 L8PJOvamjiGSlCAlKeAMwSRut55t3V2rMhJXkuOXU0cXUo61bnI9+YqdlJuhyidSWnWLpBvpO
 UlI9Y6ivRv1Y/kpWQNOFYJlvUgOydTe86j3fTw+T5yWYOcDoAWqCjiuL7NpojIP3Vq0DoQjPl
 bEg5by99YVevegZM1jLPJJpk2kdEFcL5UXXRwTzgTmWYceI3dAZ2FVnBuyJej6SRopftT4rPq
 91SV1l0IrS0r56js19XMOV1GKnvGZGQw/vvHl7vVNLvFEG/HEN0HIV1arCB7v4B6RKKyuWYNh
 iGdkrfvUsVuZ24qC55oEo22MA+CHtw1E7NqZ97bxEWflXwkatdX22piJPP/9EzSkqMECONw73
 GoOz6yZ5b2cmg5Ye1zPQ==
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
v5-v7:
- no changes

v4:
- https://lore.kernel.org/lkml/20201123000913.1506944-1-j.neuschaefer@gmx.=
net/
- Add 'grp' suffix to pinctrl node

v3:
- https://lore.kernel.org/lkml/20200925050818.2512375-1-j.neuschaefer@gmx.=
net/
- Remove interrupt-controller property from embedded-controller node
- subnodes of embedded-controller node in to the main node

v2:
- https://lore.kernel.org/lkml/20200905144503.1067124-3-j.neuschaefer@gmx.=
net/
- Fix pwm-cells property (should be 2, not 1)
=2D--
 arch/arm/boot/dts/imx50-kobo-aura.dts | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/imx=
50-kobo-aura.dts
index 97cfd970fe742..82ce8c43be867 100644
=2D-- a/arch/arm/boot/dts/imx50-kobo-aura.dts
+++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
@@ -143,10 +143,24 @@ &i2c3 {
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
+		#pwm-cells =3D <2>;
+	};
 };

 &iomuxc {
+	pinctrl_ec: ecgrp {
+		fsl,pins =3D <
+			MX50_PAD_CSPI_SS0__GPIO4_11		0x0	/* INT */
+		>;
+	};
+
 	pinctrl_gpiokeys: gpiokeysgrp {
 		fsl,pins =3D <
 			MX50_PAD_CSPI_MISO__GPIO4_10		0x0
=2D-
2.29.2

