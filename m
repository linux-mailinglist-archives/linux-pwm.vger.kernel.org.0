Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C2A301F61
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Jan 2021 23:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbhAXWpq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Jan 2021 17:45:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:43761 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbhAXWpn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 24 Jan 2021 17:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611528196;
        bh=sg3yBbp50vfrYLkKAlXRA+RR1vEiKn1pGAikI0/PYIU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SmZraJ6POwAcOMCHuw+hHwm2dKtjPP8/eHrBwgbng3FZZbl0KMNN5VIHQ/vEO/AJW
         pTSrlPTf8brOAqkBDbIExGEcGKblMGccjeb/Ww1AHClPT9vmyXrZKLdQlvkybhbwn4
         Fm4GMHkuqc84F6ggdn3LWA7KnDS2oxdGWBeyRB5Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1lcrrw0y2K-00ZO2Q; Sun, 24
 Jan 2021 23:43:16 +0100
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
Subject: [PATCH v9 7/7] ARM: dts: imx50-kobo-aura: Add Netronix embedded controller
Date:   Sun, 24 Jan 2021 22:41:27 +0100
Message-Id: <20210124214127.3631530-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Sy4IOcIVDcvHo+UWdq+IOx1Cv41T9tOawPNDQyq0hxHhOWhB00
 +DdNuhs4FPEOKxVGKz+ki5FPiKl4K/EZaDmAF/n9psmSmYjX9vwRmNf338yTmLdoeJetDOj
 kj4cOfyGGnvQZ+W762oMkfx8/cjgrc1DjPz9NqCeTHmvNqrMrAkfj5gweHQGdHpoPrOy3an
 pJhaBFQd/fuzw97036VPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gNgS/8uAUow=:xyhyjNnOaXX0RGp7ZKeEzB
 U+goVGK2xu2XcM2RfXhLVRQ0Iu3SLWsFJKuTiZRJR1P1hovwVWc4gzlt4e5CoOqWMa2NRILMA
 rwiVZ608I0pmcNw+7bN9DMY5fQPOlowVoSXzsuheDew/JpYuLXTGcyGugxNyArYBRy9GAo6br
 WHqHwfBWTVb2209DJ37KPE6bFNcoLAWTV9rWrK1sqzRlWuSz82mA7BzIX1KR8z/0e5WXwM9Jx
 m+tTZgMDIMI4bz1j1iG/RJYMJRLDu0S2iTM3OGlY2Jgr7U/dpyWnwhbY8KcNy8EHe0cjAvGn1
 pbuo2FJ5t7bHvwfvNJg8VYO926OktfQNh+oS1N86ryRtFATr1vpbRaepFw1aByHxQBn6hobun
 7xAoHqrP/P9wK/9mp3yn/2fH0lYFTsQ2GI0i3RDxyvvKpkOCqu+80d4d3WWgmtOKYI2EZwK6b
 MZ5sHGNKd7MruJJ8bHw/F2KflMm0XEG1WuFhSwrhpFHddZSz3UakOu1Y6Az9r4p1zGDwG1z4z
 HYKwpuqacW5o1klizXZeLY7glrQh8pabdNk4z5xfqLGyu+x8lAs46r5ymG2uRAqD7M3ngaRuU
 Ltmx421O3QsXMhhUX85TJKxigVBMpENqyNnT0tCXyJ8WnBTvGnFouAn2IAt/suvE2oQk+2irQ
 yLUiXE/MsQItUayTdKP12F+6T7JNfIE+fnLlvdan6XlFm9T6x2Dzktn0QKUh8dVtNJ2TLZwjM
 c6Ewk4aWOAvNvY1wEx1RCPDgGboC4AVvIWwuEZ0PwkZELl0Rf9B4orXJbIbcB8BiolIsisi1I
 rXZagP3muLh0Sm0WX54goXqGRvLDDWPcBccmgIFT/+Yg+j/BT1upowy9L62nwYcN2XOxrC/rn
 Wyt9JYHsrKi2LIvgitrw==
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
v5-v9:
- no changes

v4:
- https://lore.kernel.org/lkml/20201123000913.1506944-1-j.neuschaefer@gmx.=
net/
- Add 'grp' suffix to pinctrl node

v3:
- Remove interrupt-controller property from embedded-controller node
- subnodes of embedded-controller node in to the main node

v2:
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

