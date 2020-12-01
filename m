Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA862C951A
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 03:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgLACSw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 21:18:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:48665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgLACSw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Nov 2020 21:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606788972;
        bh=8cmA5+575w3kIUQc3qXvROhNutCWPpMSRH/kfain2W0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hGMyhd+XtmP+GM9R7TS52XclLKeqwEkivy2O7PwaE4E9TOymjTMoCBYCPDFgjf5j1
         LtipnREP3YC30EkhkV5/I5oROkqG9NJofY4Vd0MZxIUxpdgdDY04ojnO210YH7/sx/
         Zrs3ZbOcR+bxXN1MK7x3WyqaUe/6PFtAbjOSbIpI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1jz7qv3REc-00zJ9R; Tue, 01
 Dec 2020 03:16:11 +0100
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v5 1/7] dt-bindings: Add vendor prefix for Netronix, Inc.
Date:   Tue,  1 Dec 2020 02:15:07 +0100
Message-Id: <20201201011513.1627028-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
References: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FyMg03WbZYrN6o5UWchWZJEKNCGTDCfkSp/27SBR7cFGJC8SORp
 IBE5E2Gyp78ZTRYBNUSBAqmgGFEluAVNiWoFkVT+iUiof2Qjzp5JzYp9Oqo18BspG+mJV1s
 i8iDtW7ka6pcjlV8bg9qwDGnQ5aIGOSjCEbb/fs8NKQZfGCjw5mW4BD2yWM7PuAGqHpqYNn
 z+T2+vmxpdMTGQMsEPvOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gqmnMUIVyf8=:HHqzUP80JNa5jQucQSmXMX
 61vPKxGzQoq8PbfTLaSAmDfdnrjlwAGPZBM1aeYHE+iEtETuqjSTilPrPAE0e9zk+iJ6PjL7S
 jkRfiEPsA0heclhSHpLl0EKC0Nta+z+29tP1X1/JnauKS42ic033Ki0BpgKoGgiR7hXrmZX9l
 JzIrGRkyYFZMVvfi6D3Krwe1Z8+f38ydd3rNPCjsR/poQzKwBalbvN31dY9Ig/pYBNIymOexn
 RiOn5BQlZl22QXSX8mLi8vQ/4BqzFWq30DpwNRBgZv6ERNkpPMF9BD7n0zNeaY3SRjRfSFHgC
 ju+c95tl3vC1lPKwZ/Rlm8/8i256DhohfOns2kqsQX5gnC041BfV1SS5ooKM06afXyLvQ8B0G
 OYBsPGNxtU0zCP8ER/QTHqQP+8VRZEy2jwRP4U9lDH/tb5Dp8M4eYKSH/+FukWYMhq3vGBr5F
 THblPmGB2SFinz/YnLXXzKLSUXjRP+fltgVCOmTFmtJYFsSHctsriJ1XMi5LEry4AvXXP3pb5
 0jaMPeH6dvUg2zElwDiLogb7QvXWCbMFAs5LjtRdveapHkQMZCsKQuUhvyXX9XZeDwdapW1dR
 JMPVdOuNyt8bG06Ae9vrIjhY+7W/iEBml+Mxq2MzHWUhkyb0GIw4z4lcztN/fS4m7y0+6Elgl
 Ib5pXaukX7QPlrRtCLqg5GBaK/9g208uIClOf7zbs3ra3kUymt1R/ffJx1K4Am2k4QTOB5WtX
 6wcFY5wHVqcP28EsEeZS+WHwVuN0UWde+9WSHz3aTTTYqdBZQcmIX2e8dl1DUps+DdLpdPZxC
 hMqRxEOu10V2ctRiF9TYQ7SgWZ+iVgBaUQw+aQmW3tMIv4J9K/bwgYA9PTL4iPmdtLN1hZIcC
 gZ17LKy76qejSQlg8EEw==
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

v4, v5:
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
index 2735be1a84709..cbf28f992b71e 100644
=2D-- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -726,6 +726,8 @@ patternProperties:
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

