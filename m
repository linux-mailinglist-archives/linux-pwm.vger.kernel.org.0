Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF902C98F8
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 09:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgLAITi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Dec 2020 03:19:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:58495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgLAITi (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 1 Dec 2020 03:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606810636;
        bh=mRSwhYo5MyWsCdHB5+e3Gx83UCUE0iBfViL+Q4vEyKM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IQJ3KKLuzJx7kX5OrkJhcmO59yN+1029w67QhfziVUyejA6/N5+FWQsA8CWc3mp8a
         l4hj4FZJgRqazCFym3IK2TfjeO2hpd0x4+hGjr9fR466GiQkNYj1qg1Xgi3Fcdk76y
         G1ZSa8T9giammzKjrSLPqURBY3AUGINuycdXe8pc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MlNtP-1kKFx03OI9-00liNG; Tue, 01
 Dec 2020 09:17:15 +0100
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
Subject: [PATCH v5 7/7] ARM: dts: imx50-kobo-aura: Add Netronix embedded controller
Date:   Tue,  1 Dec 2020 02:15:13 +0100
Message-Id: <20201201011513.1627028-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
References: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cbp+ZxxFLt6uSqgwaiNybHmSG/zGeL63zhvHt9F5lx2AbHxq2sV
 7lnQCNZlo22TyRxqdG8DRtu+oHo7PHLfysY3ZlpI1Qxbvx+43oTMI4KAPoJYYc9GmrZSiTN
 EU22/wwVBQZhYr8cDz5lwqP6IAWBwCsNvsiuE8IVBYtt8azDWItv+rlXyZnZ3wtSnHBpzle
 7YTzlkIDJjfEll2nL9flQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sCKVuFCAFfU=:+2W6b2deI1jF9uW9a7VSpM
 2XjWtm5y38Yk+zrLFekMLK2VvP3KyaGRahTYEXDwrqFpj0m7oyUJFqf/wpHrcwFSzC+Q5xwnN
 KO/4EeE54BTAITBu4PvRQaZPuzBhM/aJWiRpV8P3i1FKc0ijJOwMVH0DoGAQppGlsndFJi4Yw
 R3S7Lcjicoo2ySHHubGIKpsVYOuQSeuwyS8s88H4sQKEv9gngxEdbmrz0rGDhxPnPnvK1Uxgj
 rUFe0nviA0OPziNC1ibAe9RTs2DBIF7WjBNYQdVFfbGSRh32LJ7kFjBsaUnPb59rgKG7Tdw4r
 7d2UEIOe5284ZmDhuBJVOmHZo0fzt5++lnXGzkM80Dh7/p3Shn66629MFw/V4IJBJLzX0fu5y
 gTJutRqD2SylS2dVvofjMuSRZ9PHXuUy502HmFZhM5ve1fLgU+HtHpjqNjF3vhhKwI+Xhz1gv
 NnbgFPc9kcICepn/JfiT6WBMbJPbxsSKHetaM7dyDoVAgIQK80CPrJX3WX+cpE0KZBvDYq0as
 y0TRwrAW2WeUxLWmNoSMX4YKy5eJ2+Twynl8JtR2SpoLJVKSGPIqHL4+em8Up+sgL0gVla1/8
 F2sqkAqWjgD08U+JBZ49sbRRYqYl7KZL7XLfK4TVl+iiF6+ksN4VB6k/B0hnjFdK9bMUbgtNU
 MZvy3VDIk7dbMTX+7JAW2sbWe5kGsh5jKVff6MGZpkIZXXGXmN77aAn+hDvpXXIGOAbDhtreD
 ep3XmWcLcKpFkY4ji5C4cWstFb0fCd7Hmw21sRS5AhS8+g1HneFPXujIwGSR5DdlmQg3HWnG8
 e/Gw4/hS6t9Gqx0i1IGlqH0jcUiEn1KHbE1B7kPlM+t4hZcUPK6EIdweTnuz4isN/HTFEA6Ce
 5DjO77E+J1qkcvmzM23g==
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

v5:
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

