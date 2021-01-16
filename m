Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD62F8EFE
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Jan 2021 20:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbhAPT4F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 16 Jan 2021 14:56:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:52071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbhAPTzu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 16 Jan 2021 14:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610826814;
        bh=Zrew4jwwEazJ7Dllk9MHmtO8jaMlk/hT5Dw6YvClR/4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c7jRuPn01ckk9k+eJRktFYOEczckucrXxCjTSECDS9kwi1KhPWUyHDRGFmfsS9+Cc
         t96MPJWB+HHvzGEgPX3NOfURVTK/oIWw4IZaBHDnuDeruQ0GcqRj2SqMpR2RGBESN3
         hQ+5F+GOAgPQ1H56hOERFYu5ZCY+DI54Lu//2z/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1lQxEF1PCT-00Qkwr; Sat, 16
 Jan 2021 20:53:34 +0100
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v8 1/7] dt-bindings: Add vendor prefix for Netronix, Inc.
Date:   Sat, 16 Jan 2021 20:48:20 +0100
Message-Id: <20210116194826.3866540-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
References: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HiynVg2n95mfhAnnA27gk7aAmI+Xvc5cJw8uxHU4v/ZTZeJq7QV
 NjErQno/qIhdQd2mn90PYk2P0D2HQ0gp9Bn0Gom6broecvapn+CzCygTG1rPQtCUPEsOJDr
 ern+oFnjM68n7DQ+UtLl9RejoXaaOqs8D8tUk2Ly3OXPctaOEICJHR3Zq5XiRZZnpyoifMq
 9mOzhZMr2VBgGispTGCgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R8/y07E7piA=:lCh+scgNUbPKofgJdS7Itg
 e8/DPShqjqGlYPfy7avUFHjR53/G/5c7CYN/DGgBMMmQuouTLAbGz20pHmbRtjcdu4KXF+Bdv
 ALu5AOojEHD9ZfBimt5zvrVRbwuz6PLY1vRR5q0szr8Ig+Sd+Vzhr4wG01N2L6OrUCV6KKsSm
 MCU8cK96Iqj8KSODfXgBqMxaLDYUwontU/Fds3CnmdU6rmjFsJP2lUy8ene8TA6O1esaMxy3N
 5F/pksoQVEvXQch060lRvjTvnW1aupP2l1ixcDDT5Z0BYzriE+n12gEKX06ZRDB3d2HkxaTcv
 QHEbQBOS7fv4y85ap/BEisNjVUN4hzrHcrKuHGf7aB4vl/Vhu3sEHdSSNdhzUto/asGuPw63L
 cwyEiYA2jM5UplFyPlQfsxiqBNPDDqDcWtOT064CPhNGMAnpMAO2HNCUjUZXQg8ZB/k9iTEQi
 PukDCAySHbOk69BaYGpXVTuGHdNPckAGsfqH8/RELRapDQ5r8gIl8UW5BAZkofdxFx0+bfQvl
 HOk4SWu9f4wbO5jVoQjyQNaj7iQv/zLEkiQycpU8L1V6J0OGwULeYqnEuhqbP6/73NJUpG542
 PAU8tANbvpHHYTvXffYyew1CMyzT0wFYVbxi7eIHRyhFpO/+m7JCaum8kjzymjkaIKo5dGJun
 nub+3kLyYDu+jQqEjSfLaa24uw7fkp63Vr+YVM2p+JKRzE7UcFZcACnT8WiP3bseBj3vajuSu
 qdqF/bsUJV9pLRVtTEB9ynUDLLpdcfRA56T6VF2eD9cV6QXyxIqKPZCTsA+KHmVOFzQZclVam
 mc+I8Izs755ougGc3MV3keU9XwiuLLMaJDqdQbpsSivfYMTLnXMlO+SpT277jdjLhce5V6zms
 l2XYuD6gga/wJJmWn9VA==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Netronix, Inc. (http://www.netronixinc.com/) makes ebook reader board
designs, which are for example used in Kobo and Tolino devices.

An alternative prefix for Netronix would be "ntx", which is already used
in code released by Netronix. It is shorter, but perhaps less clear.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Rob Herring <robh@kernel.org>
=2D--
v4-v8:
- No changes

v3:
- https://lore.kernel.org/lkml/20200924192455.2484005-2-j.neuschaefer@gmx.=
net/
- Add Acked-by tag

v2:
- No changes
=2D--
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docu=
mentation/devicetree/bindings/vendor-prefixes.yaml
index 041ae90b0d8fd..4d36b8173b568 100644
=2D-- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -756,6 +756,8 @@ patternProperties:
     description: Broadcom Corporation (formerly NetLogic Microsystems)
   "^netron-dy,.*":
     description: Netron DY
+  "^netronix,.*":
+    description: Netronix, Inc.
   "^netxeon,.*":
     description: Shenzhen Netxeon Technology CO., LTD
   "^neweast,.*":
=2D-
2.29.2

