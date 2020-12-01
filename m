Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2363D2C95B5
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 04:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgLADSt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 22:18:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:45867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLADSs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Nov 2020 22:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606792583;
        bh=oMV1BsE+zyZdphaHIIA7I4yA5HiRt24ClTAmEH7qgi0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FSlC2zyl4E9+Oh6GYRbIopFfsFjQ04dd7R4VGLqCIeMzxder+iELESfFECrhgpBlo
         hVxPYtJK1pFtnywtp7qbxaVyMMrp8DqrJ2D5shTdOrzwgHFvBxH3h6oseY45tvn6EY
         EU1zhK06FhWuVl2Y2kEYv6Y4+BRZx7wjDpQ6j5Go=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1kDMUP2AYs-00c7ur; Tue, 01
 Dec 2020 04:16:23 +0100
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
Subject: [PATCH v5 2/7] dt-bindings: mfd: Add binding for Netronix embedded controller
Date:   Tue,  1 Dec 2020 02:15:08 +0100
Message-Id: <20201201011513.1627028-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
References: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vz3vJigvuTH3GzmHI6h4VbmnOp32aE5QRt0GwXcvdVOzIzllyWS
 i8BVZm0ZfXdpS+MZsTHTJIF8KmT59/cOCJpyhN8zJJp2BnJcDy6bls40rSuAlntjAyXQi8u
 jUQ3RMxz2WtfSS9a/XLotrBYWsQp6Zv8uCEBMn1rGB7UyIecwwbeIGN5+Xp1EzinOPsO+GA
 +W7oFQX9jiIxQyb2t+3mw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QQq6oDqUxps=:6T85xH+8S1ysT0AdqBKdwb
 nXmG6NCoxCSbF1c1dIQDo3gGyPzoiAZXMTppcsdD8eFzmnJoOuSaUrn5hYLSm3O/nfglFO69Q
 6bXObsFyagScL01w/nbxYqf9gcto8myDVKxoMxaU6QAFchz746ubYR5PqsapaLQ2YRc/RpgiY
 LurIj3IyNEBNG0IvB3fmJ1tOD8DBsun5CZrKSAmcAvt61a+1Ji1ktJVKcBR+3By9+a1pKeWAQ
 UV/HX3GMDWrU1J9dJGd5wz0JVWOVx2ijOix9Bw8XJCUG538sheMEH82nX7DUT8Ul/zSdnV+8Q
 D4ltVBtFE54LcKULOMYeFuF6XoVxxU6RRp6ONH3mCTpyZSrVq0CdGOIdtDrTgDC7NA+ub9hO/
 CsGp6QVsbBqcutezZe8usyo/0p5+aoEVLAOTJzOGEKMvhurY3Bt7+fDxJF13CxV1DlhhhzJXt
 n4+NWlG1XAZIejiH4VQlJ/NRsflU4YbHVIG6X6O6kAB4r8VdadrXl3GWGoHxjYbyOjJaJbEs1
 gFP6PqL8KQPtAWpZCRaiXnWntjcTKCRNf26bQw7UsivGD8SLpGT9Vv2PSsJwT3XqAO5DRF4Ws
 2AA+qCnoAeV9n8/egeO29BO6NXjh+HJNq/drbb9WcVgHEz5g6PcFmNoEimH4c4CRZJS6mCsKK
 fOUYPfa/9Py2ufiT23VxK474NWUZQgoiOU5l3/FmOBZnYVTGvWCIqU+2if2erW0dblh2yPOPT
 OjfoUHoBh9cC2rU0oCIokRZgaTLkWZV3XnNhhgciOkFqTp7H8g60X8C+/LaGd1OvetML7DZyL
 a+EKc7+e8+AMd9yLPLxLLu4Kfb9S44uEsopMVMFIGA1EQWYI/Zi8Eya0Y8r8oJRoLp+BnVKvZ
 Z/wyAbEJUaBLju9+NJlw==
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

v5:
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

