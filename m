Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17972F8F55
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Jan 2021 21:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbhAPU4r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 16 Jan 2021 15:56:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:48835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbhAPU4I (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 16 Jan 2021 15:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610830440;
        bh=7B6YBniBlOdUKUBNpIZoTRJoQhsWL/33VK8gWA6nQR0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ljKvnS5DcTcWGglUZc7S5r2nf+1Ay8faK0t+OTQTHDxY0fQup1oJOWZBb4ypbLOB9
         2zxYqQrl6VVlb5cDxkXDrInME0yNy2mFoMcfS9e2v809/mLiWol+4BqIb6W1+pw0lH
         DHvVRvAVohb5s6jzznWpA850XFRAK4X+Uq8sXF84=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1lS4bN0qpx-00Rm0T; Sat, 16
 Jan 2021 21:54:00 +0100
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
Subject: [PATCH v8 7/7] ARM: dts: imx50-kobo-aura: Add Netronix embedded controller
Date:   Sat, 16 Jan 2021 20:48:26 +0100
Message-Id: <20210116194826.3866540-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
References: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+jp6Fwxyu/nDxR+wW8seHUGOUPvLEAiset4N4MtufT7Oc6Q1H2z
 vgGOQA8TIu2zXrneixwjHpWyVlmxoN+ZyoKCu9fow5rgm8q7OhqO+Xe+crmZ5Ynsnri35tl
 H2YBkUBonCUhLUxk4Pe1J3quJbTC/eTjf/woiTfoJJUAf4DksWKkht7Misn58jht2pbNlv4
 GZEQZDNhUQrhmKmD1v8/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V1e2MGs1JUw=:DlxAGfpi0DVwORanN725CO
 dgmkRx7uNS5HKdTuGsGB2HBOxdR31P8eSxJQImujGcx7JBZS7YLt16T2ekImW+vDvhi5DA7xL
 FXIMb+RdCWLjTUoJeTqpwIgeX/76XUBJ3sX1G3CocUlp5S6Np2T3mM9+2PK+Y8Uj/KIE7IlwQ
 PIOHGTNNPIjkTsdh3p9hCySSUKcXoE9FcLAEOWVv9m10oL9DY9dviEWLmqY/ng3Tqxoy64H+q
 +QcsFZS3Ixpe0VltL4Kx01fWuLUurcR+7+WB9Av4wcA2qxGYzC7gXu3PYEO/4tsd3KKCEr4bF
 VP9Gr7Oqp0wl430YPeknqj5hj9v9jxzgVMzmi9lNhpo77MJ4EAlRgimj7EhoWr1Tzc3544Wb7
 QLBOTlm4yMNTjfQOFP91eg5UP8c7K9yCx3UYKMbo6UTd/+CBprWQ0q6OMT5xIE8vXfKRwFC7P
 ktHrqUgCuoa/w/cgdHuCrgjCEmE8C/bQYsRXT5/u6LpL6gnn7aKoeL281fMRhDMEppZFATEAF
 JvTsp8pw8e3HruZBWGc9gYNcUxPZyvSGEXFTsiUoBvcfK25Xhir86wvjs40NCK35XKNp+FRZ6
 cmeBQ+rUSF6INSDceXZA9GIq/34Qr/RVqbxvYpztU5KEAH9Q8JtNBMpNeNIHVcic9NPY8CG04
 Hzrnq6ccohlQPG3uXlEjEF7JDpFFWJubqR1I5Hth/Bf7QDGTY3bwTSxoJw+IcOpn+Un4Pdy3x
 JXvTC1hAQoEpYKjBBrIBb1wo3qV5Hhomr1RESOfB12o3uKZhroZtXlFiWimmAw7n68qdGay6A
 NhkMH4BkKSvM5ajk3ppRDQvuYA/aTw9zuC6rYXBgFyWrS6dYltI+ypnW9zwEXQo3ul2PGFhcK
 EAlQCbQASncgDUl5U2SQ==
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
v5-v8:
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

