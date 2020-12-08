Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7872D1FCA
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 02:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgLHBNI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 20:13:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:50343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgLHBNH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 20:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607389839;
        bh=pnWfE1q4e+S1NcScWWdH3l56DjjQYX0DB2eDmmG2Qmw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AKQ2iQ0qyuboRtIt3wsgQEUHoMTJK7lz8W8pTBEWLwy6qkvyOghWfRmaQj0f2Vb2A
         nkqAaMdN0O1K+7nnvck+SOrSmiRl76yu3a/VfLapbED0+DocT93LVNCbpmJIPfRJK5
         gpeCjapk2bi1NGR6T4H4RXMyRfHU9Ap/5ej3oUmQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1kSrP415kP-00K6ae; Tue, 08
 Dec 2020 02:10:39 +0100
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
Subject: [PATCH v6 1/7] dt-bindings: Add vendor prefix for Netronix, Inc.
Date:   Tue,  8 Dec 2020 02:09:54 +0100
Message-Id: <20201208011000.3060239-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
References: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jLNKQX72YE6HNCrjXmN3THj8hVdDQ5skL5MYyC79rsgWv1+w+CK
 rKbCb9+26R5YFuwL0WD3Sn8gAxZL+wn8+LkQ5Jc73cZL8Je13kNw9BG+eeAwId6ucIb3+53
 VGzRydEuYZl64RcZEB7ZeGnFqofNJHOEXOhYy155ixfJmg330iknjH3oR0mouqnS72Y2VXq
 EAvLuMya4kPyfw9EnxCVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:suINVp6qRSc=:Y4S+wKKlX+AzqPSZmgUBwl
 Kkm/Gce0T1WYUPv1AfdeNSpRsGxIzDyirh5F37k1Zl9xl/1E0/zr7cIcGeG8hVpgHm/P3/bc2
 vcplii5VushZiy04TTpi+PHc6NfPxCJYHN4b3wSVrExqoC5bTIpoTTBGslUuJSHFN6wJTAqsD
 UUJGIKUw4qBk0G3OwTLODJJmgPmaQjL8Onk5CDektW0I0YXBJzojuBIkD8RMoGaKQL/tHoTKN
 pcNWdzArPK36Jam35dzntOpzZyfaKYW2CjZvXIwYVmcqKk8tBoG514Fh+tBKVPnp1gjknDl9H
 PECgsPPm6yo75HQKa8V1VGYwziKCxfPjvaaQmQzOf9HkF8wikspzIzTCy0rYiLSoNFBfXLgq8
 e6vM49TxZ1RlCm1pjTihS7F1i/dmMG3cdAHhMHyTLd2tsJX419Kb1YSZe9kN+yPnexWLtXQAH
 vMusuE+cY0u73P47AR+b90wBIfuX6b6GACmKsSlhO3mdWg8Fd7MfGrvjANYFHNZr5UPNiq4Z+
 ocr+u2LC3mIN6090uN3GUvIfzWDbHvDDwgQRh7B10v2RelDffMNkBPXaH+pT21prdGE/Q+/7O
 fZrQxG7BqOPDIwg1sxt76w7sTmarBJuq744+zlHMbVcP49d9mTVBV0fc6Qbdg//NMvo2rWfr4
 H554fm8rI1YBwa7zqeMNU/fVnpAglU6KnKZHjAWHq6Nd/8kXgmqbo76rr1ElE8My3Fu1+1L0O
 hr6C24U2KYEUdHAcMFhiHl0hHH7nX28KQscgdAQMGuj5WAr5SYK94Du5S4O7RD3lcfnnNA/I1
 7gflXmXX1HRQrccDqvGn/BOSNQrShzJI4u8l9Q/vG/b43NI2pFvYmGhejJy6NWU098jW0wVvJ
 Agob6qs2Z4H5+CMdv1oQ==
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
v4-v6:
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

