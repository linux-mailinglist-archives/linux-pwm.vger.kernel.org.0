Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2AE27793B
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 21:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgIXT0o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 15:26:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:33321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgIXT0o (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Sep 2020 15:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600975562;
        bh=4RP05Hxu1YyFCz7+DB7beV9x6hPWq+uDXnTvDpZdY6k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hsSQXm0Oq6VogrOInBGGpvEucQOQbIzFwmoIikwUhl9YtvqFJWXti50juDgryWoxv
         mdbUNoIbQib3Zb/qBt2P6tnjB/NTqCZ73ecMj5LmyMVFeeeAb5EqT+PGljsKcHQEvc
         Gwcyt6wUf5OaDgrfAIoJlKlQNQQ9iF6IFn6Ew9SI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6Mt-1kvPez1hel-00aA47; Thu, 24
 Sep 2020 21:26:02 +0200
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
Subject: [PATCH v3 2/7] dt-bindings: mfd: Add binding for Netronix embedded controller
Date:   Thu, 24 Sep 2020 21:24:50 +0200
Message-Id: <20200924192455.2484005-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qIN3ysCKzKV3E5U7e0Zvu94KfThse5uh01FGd94RNlLA36XGY8l
 Y1vNOclGmg8YGMfZO+sqyDVFSUMVMtr2YvjymT4L8q2Xk/YfkQoNim4gVLoCPVe2CXuZZS1
 h4YG4QJsgnwg/wR0GoJ4PM1kFUyfAq9cy4P5UTu8eFV4SzakZ7JCPjDt3sfIayylmpAnlEl
 1ptuHS16ONJ7Qqyk98g+w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q1gx0ANm+Fk=:Uz6o9t87EdUULbT26pkTS4
 I2waJcKQPiiBL+aMyrZLnMslGbyFapvEowFE29Kbj0xBkefSUaokU0YVpDDt8Ot2yJpiH5h+0
 +N+BEIAL+QpRD7/yTAk5kK3F0rs3nbHTrIPMrDUQ7mYJAUK+h9sklqLqYB7gZR0ivPDvTzqnE
 Uk0c4Jt5cQHsq6oCppD1stKsvUv5IQ6VZguMe41uhzfbBL83NTtKwUY6TKs+fyREVrLEvPU2B
 UL6bbIDrvxcn8ecJ91i63WrqT1YITn0xpqEPX8Xpg5f/S5irZXY8idtSkxgejmg50vSnXDhpw
 Q7YRvWa/CHE0oBhWQ/bXC4ikgYgvComa7VlPBOiyHSUcJ2LVi3RDFCTdFoqHRAvAQgLSlXeSr
 Dg36yzFFYnzCB7pILOfXHe4C7KWvdfQcqsryrEH7lmb96LVFGaxy1PAIzv+P2FG+xgWXE29lg
 y/ghHP7QZv9sUNWSJAv0Unj/rDTV1P+JHxDg3SZ2n/x3m8W+tjwUvVDN6WByYKmKq3ATaZkdX
 PVaztpDYMD87WK7RRpM5Ek+FfgJRW1rH55Qh75MOovC0aRG1gvttKXrNdqHWKa67rPVnzkzYW
 ryY5R5En9JMF1Q2yD2u49MJ6hy1Jp1rQjvr2JvjxdIQVyuqhEfXj5SV9MIPliFg85dbTDDKcO
 GZm2F66mRhZycfdoShPZC38S/lKZ86Hd4aLEAnnfFQyUHNr76/unKOBBQvhTO/FWbNA0Cu3iP
 yujRNLKPbPovjXylO57SNtWxylRPegneu66g7WHsNkK2vQ8DNaIjH6m6UkKPdUyBUNXZybP7Z
 tRSHcFGKkPUAP558qGOLFP0y4oTF9iYN7kB8QuEXYj50fg6eMGAhwzsIi7X0T5jQ2QSI1J3ND
 /kr0FdfaGTWUIBCx7lVtdMaHgu0OkldW74W4B2mAv0l4xv4EdOxFDrFoMAMwTkcmoIYRiA7x5
 sFIDZjzxEz5mHQOo/0Ga2kYuv0u3/aKyp0N0reVdW7frfHIXh+LiDEowctzYT3w9/l7bhlb9F
 FRYAdrzngHBVxOcnRhqw3tjiJ0dVOHJQNx/Uvrj1SvLBOropC3Ib5Bl36s/wcakT1oRzcCikL
 bENd1KNA1xCi7axkN8JAuR23JGyAHDslFfuWho4xOcgJxZBCEBjIuxQbeRZTS2ZMhCkXiUVsC
 FeQPqlc49m9S4Q7LBqCxGuuUVQ8n63fb9GfEStPB9StFA09GuN32TesFa81l+ULgMrgz8/aw1
 3uZsePsDv1RezN1dCSk0NmYpM+Q9/17jdJ2craw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This EC is found in e-book readers of multiple brands (e.g. Kobo,
Tolino), and is typically implemented as a TI MSP430 microcontroller.

It controls different functions of the system, such as power on/off,
RTC, PWM for the backlight. The exact functionality provided can vary
between boards.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v3:
- Remove binding in text form patch description again
- Add additionalProperties: false
- Remove interrupt-controller property from example
- Merge pwm/rtc nodes into main node

v2:
- https://lore.kernel.org/lkml/20200905133230.1014581-3-j.neuschaefer@gmx.=
net/
- Add the plaintext DT binding for comparison
=2D--
 .../bindings/mfd/netronix,ntxec.yaml          | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/D=
ocumentation/devicetree/bindings/mfd/netronix,ntxec.yaml
new file mode 100644
index 0000000000000..59a630025f52f
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/netronix,ntxec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Netronix Embedded Controller
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+description: |
+  This EC is found in e-book readers of multiple brands (e.g. Kobo, Tolin=
o), and
+  is typically implemented as a TI MSP430 microcontroller.
+
+properties:
+  compatible:
+    const: netronix,ntxec
+
+  reg:
+    items:
+      - description: The I2C address of the EC
+
+  system-power-controller:
+    type: boolean
+    description: See Documentation/devicetree/bindings/power/power-contro=
ller.txt
+
+  interrupts:
+    minItems: 1
+    description:
+      The EC can signal interrupts via a GPIO line
+
+  "#pwm-cells":
+    const: 2
+    description: |
+      Number of cells in a PWM specifier.
+
+      The following PWM channels are supported:
+        - 0: The PWM channel controlled by registers 0xa1-0xa7
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            ec: embedded-controller@43 {
+                    pinctrl-names =3D "default";
+                    pinctrl-0 =3D <&pinctrl_ntxec>;
+
+                    compatible =3D "netronix,ntxec";
+                    reg =3D <0x43>;
+                    system-power-controller;
+                    interrupt-parent =3D <&gpio4>;
+                    interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
+                    #pwm-cells =3D <2>;
+            };
+    };
+
+    backlight {
+            compatible =3D "pwm-backlight";
+            pwms =3D <&ec 0 50000>;
+            power-supply =3D <&backlight_regulator>;
+    };
+
+    backlight_regulator: regulator-dummy {
+            compatible =3D "regulator-fixed";
+            regulator-name =3D "backlight";
+    };
=2D-
2.28.0

