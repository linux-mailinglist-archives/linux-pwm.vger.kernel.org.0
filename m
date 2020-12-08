Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1892E2D209A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 03:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgLHCNQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 21:13:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:37181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgLHCNQ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 21:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607393466;
        bh=OLRgMJVF5Woco/wE8srh876TdhfxC/CBxXp95Aag1Sw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h/s6ucfcAiEWLKJPFuyYLAH+iY+em/PysCegmqP6m2AINFu0aMUUEKCME+fUsNw5k
         VjYQNKg34hGOlNNHDj/7rbnV/6Sis+eOrz1hCOcLAUSYJL8gWUJA+0PQde4/7Aw+Fg
         tdlO3IOh5oabvupfmWZbUWololiuP7hZDUineTMo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ykW-1kpEQ02tHi-0063xc; Tue, 08
 Dec 2020 03:11:06 +0100
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
Subject: [PATCH v6 7/7] ARM: dts: imx50-kobo-aura: Add Netronix embedded controller
Date:   Tue,  8 Dec 2020 02:10:00 +0100
Message-Id: <20201208011000.3060239-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
References: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hj42vB6Qt5VgXLNmP/8JQZYM4kptpRvcy4iGsqOpkwfovVUgks6
 WcaKaf0DX/ow8DkZUB7XehG1fE2N1KGjZoaNLe6LvPjKwp9JCNe+ebRuXSZtP0nWOldLFnA
 1D9Bt1b6hLvKp8hUCIBj3DZkUzaTPXCqH1v0YnN7muafylxCdv8fvrXf5IKfuo4ipvKZPMD
 CMDvtIqLqP6anv0KcmnTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7bZdBAIBoh8=:eSr3n2acQWh9DMJwYzNd6D
 50QVJYXuhBdvO/d+HEEQuzBiICRC5g8c4BY/U/8+SMOL2+2y+cvYcdwxGbKa3uBvugL0u+MmG
 xL0NBLlyBCbFxEyQWnaDuX7QsCW82E1VPX3q21ki1oxDXBDAGRdJzHncVKUoqFDk6bapwwvu1
 DoXMMYHsr02c0/pdL0PpAkRv/gKkDImR9BilZiEeN1rVMOeuH4LtGquod0ketLqtg4nuKXnU4
 lU6L+DJiSRsPH/5sQppSieoh32+WYuxK0tGfcJuowZdXlsWIHH+RMWyx5zcoVGjqdbqpASpXL
 2jLvdqsg3CYWrq6sJpIyM0VJpF7HI+N1sctwVl8Bg05X2TrDEVfklERrBt6TY1E0moqEfE3a/
 5wEvrktwFuGJvOYEH2T0UMNUIhpa3R0W+/RPY5G9c8r6hlv6ZMjhHXjUeS9dMyORAnnz0elgc
 IKha9ovKfK6YOB0GP+KfD6NNxzObLSmc/iMNDiwHxQwZ1tAvTYHyy8m/hDh3KwxxGYxDGlmIh
 26FPx5opCvVjTYTUd2BeGwReouFMwJI7JGRik6eIEkKyD2eaw+XKrqKgsZ/8pA+YYpj3h1CDM
 FHh2ot19hF/CT4RQrL+I/6T6uM7kUGhPJMT81dDm5ugjqMHZk3m0e1GERkx21ikXNLC9+RkMV
 3VeDCqL6INycdeE5MhZyTzLoypEjA0P77ElBL0PxFwrsU2MJ0v45ckt1U//IagUwHe69351JK
 IpbQgtVxcHqt6PVwZBw/XWU+Y9qrDGMocaGdWbFMjWwT9mdfGA+KffbJ1p7M/fF1/XU8TkWZR
 vmcabzcPtSAmRQMQaOyDFeznBfKcSiq0YKggzg9VKvSurGaD8g3fWP3NzNgvW5pUcQYxATjMD
 xuuMxEprrDhto9TiiOsg==
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
v5, v6:
- no changes

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

