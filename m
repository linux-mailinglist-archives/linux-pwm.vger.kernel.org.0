Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4E12F02C1
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Jan 2021 19:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbhAISHY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 9 Jan 2021 13:07:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:37809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbhAISHX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 9 Jan 2021 13:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610215496;
        bh=iWxnjypnR1plNrfXr1xJKm3wD/fZ9cxl+w1r81KUhso=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Up4hIZQ8S5e+S5V+Q9in89C7YriUsESyP8GI+l0dJpsXgXh9hps2R253bqdcXe+7n
         jlY3iLXynC8IsTuqOKt+e/pFurua2/25t4kQodicO74jCFp6WsquJ8sUM0Vf6XxJOi
         bq7a+jCW+AcnPbrUS4zLm8Mt/OsmgYY+oe+9Ajr0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1kr7c61P7O-00ASWN; Sat, 09
 Jan 2021 19:04:56 +0100
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
        Max Merchel <Max.Merchel@tq-group.com>
Subject: [PATCH v7 1/7] dt-bindings: Add vendor prefix for Netronix, Inc.
Date:   Sat,  9 Jan 2021 19:02:14 +0100
Message-Id: <20210109180220.121511-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109180220.121511-1-j.neuschaefer@gmx.net>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zPqNcg1CXeoHM0np2OoEXcoXC9FroCfRaHf9cUotROz6im2cb08
 EdwTbeK3AVvr3x4qekWlyXFPs/Huo1EVcBhN2G8bloGeYZmfot3Ove0YDCU+nFm1Rz8Grt3
 7I6l1V5aqj+eIc7Xx6+JrYY/c96ZCXM0EBxiKTsvnoW26psLtHbAbxhA3+71c1jw72nd4FM
 jIBsAKtMcNRgDIpL9tblg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DoINDYjpa1E=:scygcgNWNuflFLI8qP/AhW
 eMD6m6GcI9kkFrMCcAY9nxuRK1bYxYeuJcYJPAe/vk+9y6N4TuDkjFDyq7CpdbjC0A3wlboE3
 QJoXXDNET43HhIZBjtFBnOxvcSXb5gW4DHbUTYA2e92aTIZLIiHj036xZWZb1JhAbZ3gT1io7
 88YnzMGj4MlRUEs3DNDLE5LEmX5P5p8d5pRTI8s0OOWvIItjVIGYLClgT71PX3cmZ7vPijXUE
 v94Alj8SBsVK6n8HRPav8AAWPbO8gAj8o5Y1gNBpt5MwtAotuupYYCrjLrSY7HhXL0O3B0cWN
 i/IQrm6ffDpAXfx3f14JqF6gdauB7LbQ5R2ydO767Dc8i0OXUmL724CXFnFL+Srq/qoddJRZ9
 n7PNeaBvZYIOaYm5xHJcqC6XS/7QCIoytZhPakmZPDnDLyuZ0XXYBtxymt4XHsByjvWSaejWt
 C/fFemKQrpm09s0q9UAsl7xpLiM5OD2nJ5/e61YtuvyKOl6Zj2AiBEbSOUN+NkV5yfUAkC+Z6
 yqwjLixfql05dJt9MVdvVShce6M/jryfqimjwHnKWJRRg4ULG/iCzcGxmhqBMQ6Tju38mw/xC
 ZpFk7bFmMGoK31A3T4/oKQY6U8Y4u8Hjz8zt2Ayu6uvxClUTQ63Q5iNeKazf55t1PkO8stbSY
 9+eVsjcKl6FpQGjy48UUOckKoxk8/QgEtYBXSKa0djkLdyO86/cSX6PXGWKYGMUV9PqDH6ZBl
 eqfPliHin5qweeqbAm/iLhx01+g8faC3basm0LahOCWVK5WgCNNW6jw5H/CzXzo13dnkop+24
 bAzUNNs5CNXSGtTxpmBR6rYcmYBb8nPSeLkEvBKrarDaZPH2UHeJ94Z0Gl8HSIsmaDVpmNfoN
 ewbnmaPyGRH8mmAxXyZQ==
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
v4-v7:
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

