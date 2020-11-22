Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F32BFC2A
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Nov 2020 23:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKVW3C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 22 Nov 2020 17:29:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:36037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgKVW3B (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 22 Nov 2020 17:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606084102;
        bh=FkEwDMxgZLTHim30OmXS5VuBshTlz294C3jIoXfipxY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bE65ExyOQVzCGTQGoUiRsYFa+BC58jhf5CA77gayyIG60/mU+uLCkFBV542x+TjtX
         hkKtnXO+oA3D611vtt+ln8tNXQ3/1dtl4+dC9zVSmwrSUnAT7b53fp9YHDzFB+Y8yb
         d9UhksvPcq/VBdoTrY8vmKfl/AZ00bN5PUO6hDfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof5H-1jsUwx0sK9-00p84C; Sun, 22
 Nov 2020 23:28:22 +0100
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/7] dt-bindings: mfd: Add binding for Netronix embedded controller
Date:   Sun, 22 Nov 2020 23:27:34 +0100
Message-Id: <20201122222739.1455132-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nF3kkwMmgt9OIwH8iqvES5UGpX6cz3/hWNyTI5w7mqGWydvJ8Mc
 1noR+XyHeLXC6lce+wgyZqWWRXqc2XOIkXI79SqB1acVaKQKwdHqYjKF2Qo9pDvnlXgWT/y
 4s6Yj25dYUbIkMCUG3xGzwz/inb8EGTFD4fPtPY3rRAOOe94PofEQ31pM8rCRvtdN1igAQd
 enBL8osT0OUNVofvLmm8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nEuwsUuSLow=:zQBob9Q6ol5V3Z8hqZvFGh
 pfluGE579FA+K3JHGdBPbVKQ95bS8GtltwPGupjqIeWGC6E6Bdt1e+cIJ8olKbIXT51WOk0OG
 1riIRIcFwUm9V5B5687dvFyyW5jabp8LuEJxuGGvNOLLDrgYzj46aYXunZ6AOlAmSCLmlCSOx
 M4WG1NC+eLKTJIZZFFUuQ4Y5XIyBLmAWBYl1blBoKgan/olKILh3WvkrYmYyZsM9aJkJxr5Aw
 FgC+pVvdgp5T2AL6PnPQJvzKXhdJDjW1bENKw8Dp9FQaIWY1zo2A6u/jKREk2fEYxJdtU0/Pl
 /9sxqWtmEQmokSEIpisjwM/Z9PnvZpab4COSfvIvbkNxdijGu5svMNrMI1RyOEjXH+Qiha0om
 FnriutIxNoUduezogkG7kEJ7s211AnKaeEiJYJqsPUYEItjP/dBjmkAR+3OwKVurtUS1pTK8I
 V9IAbh7fTOtQAL0GGYI/UGQFzr179piHsuJ84L+Iv8gsCkJPSP6A0KPgnZNgh1jCYn8kzcsNW
 6LibGm0dKX0SlRozcNsnKBEJ/zcZpykV/KtSfGZesfYmoR1GjND2BuA6X3H4oIONUIJG5BvXn
 hKspwPOJtxr7r7ukpzkWMMGO7Tpbd75pXFTpfwqegtZWFCl+/UBaXytiPi3UIns/nXggBVf6t
 Zeba9lYAP7CgHu49V+AbhXgYew261mlxN8qIaq+Q9TtQubT6IwbP/JSP5kvlznFHEKTVX87IN
 SIOYVRisi4lb9NmECLisrR3XbxImAkZYUYynI6ixMmvXu3N9c6lRFq799Ef8Y69b+MBiz9SoA
 sRdUHQT0d52mvq9n+xPXv0sdHfEDdGDtqjYMNDxqqKTWPzPzB3QJ352kmx3+f6xpwXi1Mx/QX
 8JV1vjxGxCspwAlCwF2A==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This EC is found in e-book readers of multiple brands (e.g. Kobo,
Tolino), and is typically implemented as a TI MSP430 microcontroller.

It controls different functions of the system, such as power on/off,
RTC, PWM for the backlight. The exact functionality provided can vary
between boards.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Rob Herring <robh@kernel.org>
=2D--

v4:
- Add R-b tag

v3:
- https://lore.kernel.org/lkml/20200924192455.2484005-3-j.neuschaefer@gmx.=
net/
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
2.29.2

