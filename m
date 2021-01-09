Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB052F02C5
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Jan 2021 19:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbhAISHb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 9 Jan 2021 13:07:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:45599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbhAISHZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 9 Jan 2021 13:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610215499;
        bh=BXFHLRrmZEFTrHUZU9YWQgsUIyoTn9ioNYRTBZCq8QA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CtWdOAHJOrULK+8y9ULVssGZX3DKKVr54WAE0t5k7qTIMQL/glXpkT5l+gidEyD6V
         kK319yoD0SttSOgLupxyKjpAYi28y9SdTCnbgSwNJJCc4yekfc0I0AAQaVj4e9Nl8a
         VX5bGSg9x73xEPQWxWF5OXoBmcn2gsFh87ql0z9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUqF-1koelp3x5b-00D11D; Sat, 09
 Jan 2021 19:04:59 +0100
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
Subject: [PATCH v7 2/7] dt-bindings: mfd: Add binding for Netronix embedded controller
Date:   Sat,  9 Jan 2021 19:02:15 +0100
Message-Id: <20210109180220.121511-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109180220.121511-1-j.neuschaefer@gmx.net>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G9JfvNlKTk6g31LtLz23K/QbaXjnACKNG57wlNXxZJcGdvifzlJ
 9B7JnFm07xp4tbAlHf+86BdbwRZru7H/rFKD2fK92HuSPqfY/5Xasr6VN8gBDYOp7DR1oVS
 fJqzU70IewJ/cetjwUL27J8iQ+TlC5fSCfH3zAgmiFd9uGPfMjAma3gQeH40xyPP0pzNu5r
 PoiweiIS4BLRloJ5MSXig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hi4E1BbiO4w=:HSn9KO0QfjCaC9NC7W3Utm
 rd1dkilQzxfjGgc77QKJqRodVT0E4iSkAtWNaF5mlhOThUxmnSuyGabFXayJJK0GjDZVEUuI3
 8pBfa5uqvqxTUPdywMrfvJOqAklcFgy64gqBqNMOptIlAoRM0b/pPK8+RcEOEEYP4dM8dLr/b
 eAhGnCu94ITGCm03unwjGnOLZhPiM0r3FC3F8VUmfpVXMO055eFchRM3pN8o1rc5gOQDfQOhE
 5OA1Vx4PgrOihAGUowGEg6rJDD8jZleyIcWxDXkwN8QA69y/hOUQC+lipf3Jxz8nBbFkn3J1u
 65Z2SJ003u+3rZI9jrQqNG7Hd1/iJEGrUFp+3B8PXgn2Fbb+7foSU/SPDLNfduU2yz2wbtadn
 5Ib7+eAeP3BlBR0A+tUiD+Hec2v7wAU11BWt5pMeHZatvoKoU9wt9MDTxUjRfNGgfEJBzK9BC
 Qz31lD9rZQwIPwqGnXrJAyxLLLtSDLDXR3W1mXboJZpdvEGyoSwTdwyoFaV74E88VaoTfZHWl
 nrAVuc6OV8X3CImydm59F20aWHNfsSfCIyk91XpqTdnl7o7W5y3iNuw0cmlkTyLdo9JOFgxCC
 8xc7QrTQ+rQIKQS18/IqAQTmMiHbiP50kaKf3r9mXKAV8+lhm2HY6I1Lm8nLvVL9gR+qkiIEj
 u8AoaAmxy2PFOLuUq0sf+b88GEfcdFd4TC0XbD5XUCf3ZEMLLf5/k4Xt4LGX9KnIeIyGF4WkC
 TdGnzAoO2A6DltVseGAlVEM+HZx7Wo4hrpOjp1BWrdUkWHe+5TasHP6nfpDSSjZgBUodXrJ64
 lCQaiS6O0vU5i79lAB8oeo61r5fxcX5E0RP0wgVTt/32IfzYSuaij8rCjVs+XMhQGhs9JRQdN
 NipLOayWL/q0y+h/XTtA==
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
v5-v7:
- no changes

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

