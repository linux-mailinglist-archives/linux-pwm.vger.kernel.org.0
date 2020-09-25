Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC18D277FC5
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 07:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgIYFKG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 01:10:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:41681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgIYFKF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 25 Sep 2020 01:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601010538;
        bh=HlgnC3df/tJycBpbEiuMsr+Bt4rnu2osQrbv2JddJP0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lQtEBzqQO3CgdvtzpOK8YL46GR8Ea/No6z/+imZZajAuJjXh4+m8EV/o48HicQ6j5
         a3czcqf3smBpr8Y7xYJL6CdJDg50Y5HM7CYoeMPW2y0lMrubL9mYOjQ2YqMt/NRWtC
         w/rvdpaHB2p49hW34Jyqx6d0wnoSwDCDoAKJsoyA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwfac-1kg4922a1S-00yB85; Fri, 25
 Sep 2020 07:08:58 +0200
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
Subject: [PATCH v3 7/7] ARM: dts: imx50-kobo-aura: Add Netronix embedded controller
Date:   Fri, 25 Sep 2020 07:08:18 +0200
Message-Id: <20200925050818.2512375-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nFSbCxYo1nlk4h1TGxOTycwOxGsiVBkLTP+jxKBPubrqFtoiXOt
 UhgfLQwcAL7GuTFPSvGVq/uyUN89Cz4VHuv9YGqdwFN3ATncYCB2rNDcfDyaJDoPnvAu+wv
 dKrwRZvpGHgo7HH3vaodHF9te1ugFsggudcQm4G29a75qCzjTHthOaV8CsFgwLn9NAeKD7N
 G/NyBCqBjMS7Ivz6inXgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+B0cR6PdDqs=:+0l3nJJy2/OjnpViXaD2sG
 DnuBotzhqffsfhtCoY3ClI3vjVk85XHTf8uK9RFKVfF865ozqfVtYKOsE5WSgagYImZiORhb9
 sqvx+UWcB/Xr3eExNzL7i8RZ1ezNtr6MLG5Lntjb3HULQNl+8wnByd8Sl1fS8uPU4j/NTvXAd
 UljBVT9Bli0r06MkB13/jdC5OcuDTKbYKzPYGtX4F//lE9Ev7sdKocfpSfR2uHYVR5lquiBng
 1VyEFUEz3xoAH+TcPnIhsFWMM/wrMFxlJnTrqmSjEo+WJ+edMLZmQZNXdhP74St0dOEGgK3Jw
 FsVvAGzUoww5rXl2vU6hjFn+N0WcxCvnLZRTdLV/rPeLrRhBqiJ7/kaBAYwiPuhEC6P9fWVM7
 BhQ2NxzKIdECsQCTlGObzmzHlVWiQWxp+N/1PbW2/BxBXAv0fn2MP92s4+JYv8WsulKXvzjfI
 8kokiDWdxcgM3iHaF5tDwTFQKH1iw6GEv2ZsdJkLPALiv5YreM7uVl2m4vovLs4+0/WJ29zLv
 pFPulGuNW4R86lBQEJNL/CE2qFgkgDVEgy2Busu9V/ebUeONOzgIKFmLnzErzaxRKdu9TKhlQ
 JOSgT9YaDYC7rhR+WF/dERlxP9w0j66Fk/y/+EUVGcSVJ6y1IfvYnM2g4oTuDMAGOakiqPP5o
 thstMAVv3+FGHp3yJwF8q7xcWe5FKsohTyHNin6IFgDjb/Prwbuc1aTDXhosOiLb2cNEmfUPM
 M+3cPhDwDxxhWrWjLkCqOK2Uv8ddsbxM9vpihyj2rEXIukw4wkrI++WlX6Cv+Ovy2yRK5Skt8
 U34+KsHuelnv/NK6k2j3NGszjyzK8rX9Z51D6xHeD09TMXHB68faKC2y5ACwEuzMRVPiGBJ8K
 TP/BIMGEt2PmvjvrFKc0QP5MJkky6MIEVf+wbvcXyhfCpLb09cd5CDfw7JETxZ8GRh2OOmsbW
 Epy/Or473mN6xwzyx/JC43hYwDdVpoyB3TmSDPmNPFBGMZf5Bisp6Iew+i7rU2SJRZMPJvALD
 mlxfiHEUYLhkS8+D3E508elVCBl1QPGdBZasUQ8Am81ZcAqzZNbikGr6xVNLeZfKjOwgrrKPp
 53Hv81zU4YyYcYRIZjkGdomu+VPZWKfZktHksv4p0uZDB3snk2Hmos7BuKRuULiJe6aXcjgDv
 8CJjtMBpsYr/W6wYYXAFED8RO4sbl0MR/6LD9ARFDqUNKcZ+uvr6U394tqDWMzGFWf80ljYYO
 hlHUTCqRV0j56lEVl4ME5E7sejwPtG/vErzanxA==
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

v3:
- Remove interrupt-controller property from embedded-controller node
- subnodes of embedded-controller node in to the main node

v2:
- https://lore.kernel.org/lkml/20200905144503.1067124-3-j.neuschaefer@gmx.=
net/
- Fix pwm-cells property (should be 2, not 1)
=2D--
 arch/arm/boot/dts/imx50-kobo-aura.dts | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/imx=
50-kobo-aura.dts
index a0eaf869b9135..2d1a59091a37c 100644
=2D-- a/arch/arm/boot/dts/imx50-kobo-aura.dts
+++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 #include "imx50.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>

 / {
 	model =3D "Kobo Aura (N514)";
@@ -135,10 +136,24 @@ &i2c3 {
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

