Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AAC2BFD3A
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Nov 2020 01:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKWAKL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 22 Nov 2020 19:10:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:34297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgKWAKL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 22 Nov 2020 19:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606090163;
        bh=TIuVy2yYea4meeUQk6HAaV69tfQRHqFlxaHQ7pmQGAQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V6QOdxEioDA9smqYYMyBF3ctrQLuW/uTbMCOmVy/PMdsblquhHN4odXn4czaZna7F
         x4rm+hKLDy2cwHEXKQzaJryHm2dJ9mHRwAAJ0nCzUTAG/2iyWrEqmbf9Ma7zzjVans
         TUnE8sW4ZOgnDI0k7VxIl9Ir12i9wYRrvBPDsFAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1jtZ2F4AJR-00q8Xg; Mon, 23
 Nov 2020 01:09:23 +0100
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
Subject: [PATCH v4 7/7] ARM: dts: imx50-kobo-aura: Add Netronix embedded controller
Date:   Mon, 23 Nov 2020 01:09:13 +0100
Message-Id: <20201123000913.1506944-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uLvaOtwI9plaURv1O6GufQthB1uZzTJiP2EgUwf1AYpCa+pmgnb
 zzyFdg8ayPJrfMmtGlXjR9sNu2TWGnE8ZbHGG0tuhGtbWUiz+0aO+XnPw4Kiw6gO7Hiy4ea
 Lf6Fk6wYSok+Dyl+GWKTgdjJlUjmK0aZSvuQI/qNkQgy1WprFT99pQqk6pxRyy3fzpWSmKo
 1bbqjlOZbLD67lpSLjn1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:abVzIFyQpNU=:QxZxYx4estxtNikpjhXwTf
 Ig1RjLRQThLpRFES6t+D5aZFvysbUZCfNpwLGHa3sDV6+Utd0OdN1JuiaAiryCSsrhIoJjDed
 rGJOeqZawRCxpngYSc4rXQ4d9vdG69cEoiTMOYB42X4wvR9Ll2bsNCKUsvzQSmjXvimF/90nG
 T3Lb50DzmVrIPN4Y3gkA6+9FRrEBjTVP8vRr3yQqE3Ann6aKxPV7zwoWBBW1fDecqJ6XC5OyR
 1Pp+c/JBKP0TcTf3s+tsnU9pQvCQvPGKFvF2gmsxQ0ZfUrlxIZosca651b7Ac1XBgJaBuLW0b
 TPQZfFVAe2UxHouIlBW5WWAB03hEp5VnG+/PzPqgZ2VoxQ24HHY4zKJSYqOAEoW2IreQnT3Cv
 wlIcYG8zCPnLkkvQ5uRyceuboo9aJcjQX49o7B3Bp78QtzjhSHA3L7BcppHFBZ+rkBBHrhl91
 yUv5Ig43se2VJIcNzU9S9CPHO3MVjrAPgjUOzVmcR0QFyaon9QQr066Be0d5Le7TWYzKA/khm
 ZlNBQvDUvQOY/CDnFLSvM+QOpltpYV+5wG7hSOIhLWMy8tSr2Mqn7jNEzG1263WOWd1EkC3+1
 RHCtnW3rN2B2rdb9qkk0BGAzJ7THJXbqvOmb00edrokVZwtZrWrZMxCbqiHfR7FFNxccfcWwl
 tdeKuBOSHeDeUuyABibHbIHauMUEDqkhyANfJtLRM5IFD3VOMDm3gmlYxU+Ii3uZDOVnsub7h
 IM3ebfybW9lLG8ylYpyvLLASeUD9pCgrpT/CcPT93N8g5aRZaQ3LGhE482Dh47kx8a6Jr2t/9
 ZYyvlOVrVTsIV2CrunTFY00kn7QIQICWCZc4QpwVWSv4Cg7Rz6H3O5/Ib43wgzm/TeM90bqOR
 IutSw/tRhbIlt5dclFnw==
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
v4:
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

