Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318942F8F06
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Jan 2021 20:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbhAPTz5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 16 Jan 2021 14:55:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:48053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbhAPTzv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 16 Jan 2021 14:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610826817;
        bh=qu0Nv0k8UIi/GWgWvwmLRmyI5GZIM8QL8R88849zarE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ThDlMn7Fvh0T7vBvzN8FZjsl813SEjDttS+1hY5L+UOkkbX4SOwR/KV+kePGbSbP8
         x1H0uks0FqE3malf9x9x8EJjDMUNZeGOXksL+x9lOxTNJkmMxNYNB4gyfYkQbVAVCa
         /X156mVsg1GreZZFuZldKLmdAscMKeP+DrqxxQHU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1lTz5S2vq2-00UJe0; Sat, 16
 Jan 2021 20:53:36 +0100
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
Subject: [PATCH v8 2/7] dt-bindings: mfd: Add binding for Netronix embedded controller
Date:   Sat, 16 Jan 2021 20:48:21 +0100
Message-Id: <20210116194826.3866540-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
References: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9HvTZzmITnHdkKjxY+6LjIGBOUZXAFxxNbfTkOacLyWIUqGwcNi
 nejIXml6JblxkoT4lz8IWr5m1+oJ5Av92Ql7/iolimuoFJyabY2Tlb8H/2s+bffl7Ei1C3O
 11M6UIJVcHHAcCxftzndk3B58K9EwDoDEZ0vVEv9Pkf72BVDyMSkVkLd1aBfjCfCVNAhYYf
 VX4tVoNPRlGvTOmMJCIgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Px+wNsIa9X4=:l8pn6zOGTZVJjKIVRLLbmv
 +VTXyMkRvWa9GDdN+NVgu8nGOOdbddwUoRO5wS8vBzHM8MY8CqQ7nyEaTXkyb2iTYAJrYmEpx
 CRQJyZJT9IFwGpWhs8SO+kxFeEIi4TVztKoUA7gErUIww2GXjfcd05B4soHLvZKXaN0Ylsdu8
 t6+/hv1Ddy4cdbaJIje9eudkBpDR53Un9uIAtWjLQl29QLyM+lG7Utixlf56297hRRhZtHhHS
 XWwVwWHXldt05cb4Sf1JfJokBnpqY79BtohuJFQGbw+HrWo0b9sjf+Xx/pKZfAPdOCYGDvmsp
 11anxWJaLsdRBs2plxPJBa/NzGOjWt86B2O8KPl/0qbXXENQM19DwQXZEzd+jrynUzoTsnQLm
 HcdZBMclrb4PtdusCspm82BO7XfDZvRH9lRqbBGPCDn/3OrZgbEGNGrIeeejpkPHKQAbfvhVV
 g3LfK+3QrkWlrR+f+hidbah/xTS5yd1vz89Q50OYj9RS8HvbmEVM/WhfCC4SIGX5r+QjO4uf0
 ytKiw3kmCMgSH+CiBIYEIv23+rH1UR/zRyOQt7BjPUaf3Y/bstZEsckrdpJDVWDnqVYho/tdc
 Kbf+epsj6kxeNH8YKDBfa/4CHCh3v3+fobW++MS1hLojiNzNQ8pPr029hhwyr8vz2a0FtVwwV
 8GMgMPRNrQsTK+enZ7B2PvE+GlNh9D+azApkonmv1dq9joHTDlp9SPe8yDavxbwF/mzrCZh7W
 czOk0b6qDVZCOA9DtPWzdOcC7ZbpzPcII9LsCKiDNqOBHXwt3MBFrVt4mAk9QGWFd8H10s3a1
 N0ldURu/rzD7AbQ6Aih7RdcxjzrFzdXY+yHkg4bZ/VRud845rIDcYWzG2oQdrK6wkhaF6E2cZ
 Sm0J6Aj53wVjSrzshYRA==
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
v5-v8:
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

