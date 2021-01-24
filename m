Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A2301EF5
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Jan 2021 22:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhAXVpC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Jan 2021 16:45:02 -0500
Received: from mout.gmx.net ([212.227.17.20]:44747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbhAXVo6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 24 Jan 2021 16:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611524573;
        bh=ngTCQG3YidRGM9uatLNaoIdxkdT5FvSPUy7gUjLrx78=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fzSonySvdOY3WOj72SvnKV6EMG1MNPcNNXCg7eN/+A7qQe1Szpu+mDTkVb0P5s7Cq
         hdK22t9i+6jmvqxSJPYDRnzEG1HnZzfqHYEOeekBSLhzzU1Vnxq6IkIwFc52C0dkH8
         TYgZssEAxUPR7vwQdadV+hXkRVbJN3aYubnJIFkc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1m0OWp0lDC-013dMk; Sun, 24
 Jan 2021 22:42:53 +0100
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
Subject: [PATCH v9 2/7] dt-bindings: mfd: Add binding for Netronix embedded controller
Date:   Sun, 24 Jan 2021 22:41:22 +0100
Message-Id: <20210124214127.3631530-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JIe7A0UYeZlLX5PnpR7cFCKPznxi8JqQH+a8jEEq4mWvs1e2WN3
 7aI7VMeWOuj9wh7tokKFnMNfEZiNWbh8FZhggqkKHjCap7oLBswwNLfkk51AbEi/Kq0Mt63
 6vvM318fjHDkEIrahMyExq6RuNCcoyRBve3/qct2aZV35ga01TxJF2EastBwTNE2UyvlBrJ
 F9uNd/UnYF3TfTW4TR1rQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PsRlcRtmN0E=:T6B8ye0ru9REaopNGDYWNG
 4Dj2y8DI9pgKknEM9k7mB4yaNw0gq1kd9V3yTOexzcamPdliu41+RUwfKzjNppFMCXVBlUu8c
 4AyJ1QEoDy8qjNAYTuzo5EEucpUtKt+H4WvomHZdIvNz4j1f3ckYdr3JxBtgjotDyP5wiOEV5
 L7tCrh0VKmwJ0xnqf+J1DWUi/TzIRKNUIMK8Q9Ue6Jf3VxeNSnQzIRG2rLA1ie9/hKn0btLRn
 WWjX+XMVURss18lPp8+nMuUL09yKHaWljmwbQnnu081891ZDETSA1+nmzlauTbBLjctpBNYZY
 Ko924Fc2tozNnGdOYOssqMtUUH5n7aW+3LtqGU10W3MBO3AhFfUG0JW4Hww57YlL/hejvzOAm
 2vDP8xZkhffU26i1YTyvaiTFgb5LdnjfqCjPD53FfkmATsxNHzgqVR6ysKgbMzlJjhAtbKL0p
 4GeTPM1oJWs8wf4MWX01G9pMgDtxv7UmCCfTKCD+uGmUiDshxguIX3NF2wFwURRtSXnoWvaG0
 PAN749r7eWqOSNAEIm4TGuoSRP7ycUTQRORQlJZysFlgOY5KeApGJKdN9+9kqfB4hlQrno0c3
 cnk8GhbFMGu27PPErxLFs1IXZ+UEm8Yvz6B621ZnurOmQomG+KWGBEjUvZ/Qq17lPwvc//Sdg
 l8q3Q9Bzb0slWgskxtQId59xfeOWfO4i2aTe7Imz3znaYsIXT2n3/hiuDSZUimn52HBoTWx1d
 wOVf8MAqFOHEFNTcQ6OVqdAxi0tZocx1Zg4xOxZ5aetT81FuzsR1HStsCBC2ZnDBLF22fylQP
 YA4almOZJwHX/wfSpe54pVwNojcevoh7NRNuRa6AMOxPa/veOG4ySbTfGHTo0PvdlOvA74SO4
 ClRF9Vf4MgHljrF4FS1Q==
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
v5-v9:
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

