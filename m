Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391B22D1FCD
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 02:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgLHBNL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 20:13:11 -0500
Received: from mout.gmx.net ([212.227.15.15]:37375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgLHBNJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 20:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607389841;
        bh=zwgIpukD+PzbwgBGrDejjNFMv1JXBd0sGsF2ybRM7R8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BtUI3TImqSEcmHPyd7QedxOSkoocDu6MvHI8CPtn5R9Qp/3tqcxxZM96SCIm/k+Jq
         0KP+W4nOgrRU/RSviAfdyd+FYqZz1xz4p9cYcvTVaymgd1YnaN7YyF1T9rtqotUc5i
         gDKiLqxr22kcKp5g5ynqrEPtLosmpzeY5z59xXUA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1kD6ht2N0q-00ZMbv; Tue, 08
 Dec 2020 02:10:41 +0100
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
Subject: [PATCH v6 2/7] dt-bindings: mfd: Add binding for Netronix embedded controller
Date:   Tue,  8 Dec 2020 02:09:55 +0100
Message-Id: <20201208011000.3060239-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
References: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H6n+tRg6gp1Pqa2RaM+LSuIxVzFop3f1GBwliFyGy8zNr5eglA8
 GpnXdcLa+S/eLXy95E04FmKIOu9Ez+zy7/JqjkP2wQiiqrNjritGr0WgnBBTCzSCtE52fOE
 kjpQtzg908G18m766EnSSepwtkUdn6GVbNXAvLaJc/Ux3VNNF4WyA9cMdq6ge/jX1RMT+Pt
 A9B5LHzpHmW7bgJYkvdtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0SYESpryKA8=:Z1Y4Va7YiJvg/oRqdG4jtG
 FEJORfpP2WCnc1aavBAN5OWDkiRfuYVdyMMHvBO2LEgmmBiEUqam7h+xj2wieOO6qRt/7ERUG
 NyjQ/IKvSAGC/rxG0VOeLlLmBhZDsqDUqVibopSN8Irs+ZmglwxkcYCzzu3hOexU7Q2tPtqie
 /GIEZ8HTkcLyyyjVSbx2cBAE9wTKhVor7PRPrKRlK6Jfjd0LNirP0gMI8e20hOOqeeC/Q5htN
 Z6r59fNvi/Jl6vAR6jK0cg6Ev5P7qlwVke1Ems9vq4GEpKuKmMdTaHn1jtrVSbOSIJbZRd3FM
 0/MQbqbqt3xnFdvZSfMYzLhpZ7wHUR9ERI4Z6WOUVB9lE3le/7FaQk2SUUol5EAXy9Ve5JysZ
 MBUZq9Yt5Vox0w6aayQBv62nUYU5+nm8dDDy1Q9HgP7wKGFsuCANkKVM7TAHZ42EjGN8Y4ZaC
 QXd1F5B4rGlMxtbjhGWWQIvZUWe9MH3rWHvDxYHuzCgSSbxSwGCaW2GFrsJtgYBK/XMxOAmYO
 GUrTS90diNCiO2vXrrNNszOH77RMoCXhRIPXqIKeBtQh1EaijO+qU4PsLvdt3Aga/9+UvDYtR
 wUe3ftdgHjLWTH4FEmGk4BEDpeLFZhF1pUn/wZMqAJLgnwel7t2QbthMU3k69xypNJ7C/R8jl
 7htTgnAHF2vdYTM5NK3AWaTKU972xgL4j+RSHUFbYB9tNdbWOPiGCBSUuypZOMzzXw0HxFN46
 7/xCnl4Bpc3C9YRTQ6o5uaHmWlKi1o1PbSJG0DEaOa59gv9UxRvnpJMFwj34dK9IUCiTAocql
 fgC/4qmfdsjFbJstzJuwo+/DzC0dYKg6OdvwSydK94RGHyiHXvM2wpEEK0+nruC1naYbDIxwU
 Re+3USYRc9ZLrSIBsN5A==
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
v5, v6:
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

