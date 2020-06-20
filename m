Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551FD20272A
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgFTWnd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:43:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:43239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbgFTWna (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592692949;
        bh=fz9iJvS+IQADqhRoQ/zH92wyy5n1baG4XghBRzehFfE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FvOk5311cG2uyND48G8BKzya2u9fpnzaHK8YmvdJKt7M50kVWwih9sHWwaiS8M3sP
         BtgpHe3JYcdxUgJFJre3O6v7nIwP2dOB7jUccvNBJwfy5UfqbDmKfa04CvoyXDhH6P
         7zDO9qrru+atBrEKXrG6QomzjJG03XZj3te4JOE4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1jSVUF2jyU-00KNXT; Sun, 21
 Jun 2020 00:42:29 +0200
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
        Andreas Kemnade <andreas@kemnade.info>
Subject: [RFC PATCH 03/10] dt-bindings: mfd: Add binding for Netronix's embedded controller
Date:   Sun, 21 Jun 2020 00:42:14 +0200
Message-Id: <20200620224222.1312520-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QskTcHILhGvocIQPvfd8FUOVQFGG/i9pz7IBgR13JIg2w4J5Spj
 zrU3wG1ZFT6FxWvc0CbTK0QAWqyc7FSbsTspi1g6jgJSJXPbILQ+pCY46jXupZggraGL8iV
 Rk7sUAPsGFeqgYHzkkEhQlrzu2z2aTn9MM+dYYhYIcaanJTQ/BG4Q71Nqo5cuZYC6A17THV
 I1j1Nb56pjLV5QKAV6+gQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QtZPHCNxCyc=:IUkoyC/pOkJHsLV5zwhJyy
 +cWf4MfNeJK2AUnWJzPpNA2DY+10efIyXrp7CC3rd3nu54sRs2pfKTwbamsgIEq9+TRMVL505
 RieT9GtFm7qKvtkBGFp1k4OYAI7MUZkclyHw+ko7h1RyrqtBGUTlOCKzTxjI0zRgfbS1mQort
 W1ik/LnXWBkbcb/GYtZ82IguXGVLJZHweOs+zcNeDfxf3bb4urQC57MVO7Is4amG/CaoMvrH8
 c4aOHxNg8kra24qicrEmtWbreY492foqYxkqq3zsKErPtcilZVRjzyvbezT+6xhTRpoT6l8+W
 YfttDhcNAnRPG/XRNbun1iiKd8s7tqa3Ha01yPr90vryIUFgHxMhEBBCsjSvWj9xh5UgHvlZX
 Np4vfDVa2DKXYxnhKy0LSD7qjCrkxooEdfpg1ho0wpu1rq7XDwgWnKPaJjUo43jQMR9Q8VgjS
 0wGvS+XvOzSHlWBu7LcJIm3dQbRZiCbFkLOD5AIYCoMo+pAdq7K302CEDJXRCeMUO3gymlNkO
 hm9JHIZFR4rs0gH2Yo1GD+uSb+09JnMt3ktmjCRpLcpxtFyB4xRgIlE8cBzOAnvcKD7/FLUAP
 x9BB4uH1F80Tib2N78Aq9cNhkRgVLydhT+qY37+KjO2dSbeWgvNQW2JzknBQEoSazqg7FGveP
 dqxxQrV0U3nTUYwUVMEGz/Lo/UldmmI/zXYNhpslQVGpHA5xjoSW360NeR5yrB9wSuHC3D7gX
 aMg0/Ik4N7hmp2ZPdPIAmXpbgUbjRQYL9yQvgmJ3Hzdj3lHvoq2YuGZKhMrMpJnr9XWnzWRax
 n0ng6pQdSlDxF//bvdwQSaiS5HWvhUHf8/J4kYQytqAWGTkGfJNusJdOyX++E7xaq+C+e6Tys
 kK7JYM/Jh+m4n9WJVo7gqAgWaX1AdIKOJa05nfaXoC9dqI8khc1PbKgCL2Lt/lhenqU0sNapX
 WeNEYn2wpOn3KrmevFcSPnTHF7mW9HV/VQQ+uhEOHckdMehtskSlHFV1EQmnl9iBLF5jCUBYf
 TXeqkYX9X6r/XWOgRxIOwRfJVFqINXgnqymozObNFFFQ5yUnhiiyhdwNU/F4opc9lxxPt1q5Z
 nxDuMP6e6qRkjU2QwdI9fNmhkVxeGu5bF9yxrfuvYMJkt4wQHbm+nuvCjAYG92JC86F8bwH3C
 v6A4EaLyXoaBXo+1ES5jqSJeiPZQ3kZ9tU1qIHkY9njfZcN1oWzyf6+h3rAjfKigCjNyxDWLN
 7x7HZkTLOWToUzmip
Sender: linux-pwm-owner@vger.kernel.org
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
 .../bindings/mfd/netronix,ntxec.yaml          | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/D=
ocumentation/devicetree/bindings/mfd/netronix,ntxec.yaml
new file mode 100644
index 0000000000000..596df460f98eb
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
@@ -0,0 +1,57 @@
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
+required:
+  - compatible
+  - reg
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
+                    interrupt-controller;
+                    #interrupt-cells =3D <1>;
+            };
+    };
=2D-
2.27.0

