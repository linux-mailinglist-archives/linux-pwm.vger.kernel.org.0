Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0202301EFC
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Jan 2021 22:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhAXVpQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Jan 2021 16:45:16 -0500
Received: from mout.gmx.net ([212.227.15.18]:47351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbhAXVpL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 24 Jan 2021 16:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611524567;
        bh=pfoAHiS3JW+I+IidEQrjOYzxyrhSYw62WId/6NSEQ1I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iOm5i1FBUc49tNc3Rildb1gpiy1Eyq9i2Fchh1iaWCH6aYi7J/m1JPmCwDfhy8HwN
         oqc1JvUmXEC6yQjMqcQIJBrgc7xqSJBcEs7IVLti/FPVhhbI+VXVXnH2voQg+5AYwg
         /eWsLz7RJYOaMUq6rc/z274ILHgjcvTQOC/2Ry2k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1lKE4p2Ejs-00Ihtj; Sun, 24
 Jan 2021 22:42:47 +0100
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Max Merchel <Max.Merchel@tq-group.com>
Subject: [PATCH v9 1/7] dt-bindings: Add vendor prefix for Netronix, Inc.
Date:   Sun, 24 Jan 2021 22:41:21 +0100
Message-Id: <20210124214127.3631530-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RA2BOFMmPLxT6sYRc5u7dbmApp3Hn60nxFWYkZtmUBIzM536iYu
 sUyRmV8X5K8BTan6FX5xGbAwnTO1Nk200smNCqnLYm1jR0IexV7adj3+TYC2ivBk+9Ic/Mf
 lVEhxQwVHOOAfJGrL5SPAYMox6lgr+0lEYWqlfw9jT/hfsTrOU9CHynFUf72iOJQZXqtr94
 3IPgN/jmJitCg1WaewdFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fEJR78faCKg=:o8y3iK1imYk4TvctkwX7lu
 84QN/OjJePjfxcy7PYe5ZhfBvLt0j4wNGBnrtDqIaywEAUnqvB5PpA7suonImNVuuTE0sDeqs
 MpTL2cxP9RaSG6YsfHjojXygxL86WP0beFActHDNLsa4SXppwOQ2ZvSt3GKsg1SH+QiVib+QA
 r/D84Mbyve1ybf13/yRJ8zsVdyYQ0CsXMUL9lPWATOe9i13fqES5ttl5yVDeRpMzRxdMvkB4B
 cegHBt+/2E+/WQ/JfdrGHB+6IYrT30cqlWjGA6uoir/wh7rmKgpfMGuYZUl7ahaQ4Y/lTgd30
 fW/b83g2ndy++HguO83xDopTruIkuS9sDh1UXvni3Rd9FaEHLUSU4467tD72wRCCYw7vgmTvK
 Cp8LDSd06nlSjidtImmta9BZ2a3Qoh1WMORYSHte81eYo1+YcuLt6CuReU897mKTwXi53QTFL
 kI9ft0aeMqej3wcWkyXdPPEcZWFdUa1hCMnZl4ogvblCRCDvLdn4yHA11b3evoJ8A2JUZNrWD
 /r8FuChCOx/VNiR2YNlBAP5DpxqW3/yyBSc3a7H/gQ1VTwydgOOj4b7f9oLbOV1gzViOHUzHK
 eICxyhEAeTxUR/G7vuX5IBu4Qkgm3sTcVJo0hXYOEggsXeb1gI8Q7ch/9aAEo5HAdvnk8HLaY
 99xiocTjG/AlRLRFLGKg+GXlmzJoE6MfCQmWnHVAmWHeB3NN5uAQu5O+IIbxyiF5CE5n9RwOT
 eo5cwBFRlqQFQ7iTnLOwe6uF7GMJrHrY07Y0sZnyy0SzcXUQzZ0INdfxVH9weufradEiEh3JC
 OCX0RL/WJw384SIDjKM99E5tuJWzDJB42wKuywAJ+G8f1HrfIkQKHLn/le3czqwtvSOruJT1d
 J58r70hZLHQDY0RIy86Q==
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
v4-v9:
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

