Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9918525E7ED
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgIENfT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 09:35:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:46561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgIENer (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 09:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599312831;
        bh=dUozDayDb3rFWMmvDYXmPqx3PtWjU/j5UWsQB+GibEk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dKmlOkci75mW5whWMWqHXkc7HzP21sXxTAwPH9lCJ2HOB2zShwVgnEz2YhZhvRAHv
         1SAYqEeAsxMZ4h/uouL90pLNPtbfEb4QynsxhJ3PagmiF634JkfHkuh/44xyavmpMv
         V6gsxA8eYEdfzUueOCVbROPIu21Y2uXCwO6oYpTc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHnm-1kXjrp1uaw-00toAA; Sat, 05
 Sep 2020 15:33:51 +0200
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 02/10] dt-bindings: mfd: Add binding for Netronix's embedded controller
Date:   Sat,  5 Sep 2020 15:32:22 +0200
Message-Id: <20200905133230.1014581-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KsJzyKCQwvS5BlRV0/850L0IdR6x4/dBrHBq7mSHZliTz8m15VR
 aOCXTl1oQJda9EIus66MyDVy9PVrf1df1zrgqUz4Zt/YXICmKRkNMGBR84B7sDEgDl3+yba
 WkmNDtiG8VAfYfRitvk0Sy/ovX8cTu8e+ETW3EFKXNE/zZXMgz5druzR5fVPayywYP3zLdG
 6HHrIm1Ttfw/jGrYFXLYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:71DsHEi3L3I=:T10erDS9EyZBaX8oDbQspC
 NnhLkb2BRMKd2VGqsu6pvf0KwC8U0EB4I/CLxB0+dBRXqhL6VdBKSiixDvh9ilJKLUEFIloyf
 lLNP7y+rKRIzPV1b0vsbLZ24nICXSvLQEHPgRYqtS0WC+G5fOsFeXfbmOEMP6iLPGsTH+DLYN
 /P6ISkyF/mR+OFr8E2iu1KTxrwkOLY0SKHmDwYbn1KDAEKewiAOa6QRBliIPLPuUfOLRO3nb7
 CMx9HDsm2qYBTFwFNAXPft4SFJJEwY9mPQOC2clmdotuzhTvkDj0qqkSYr7b5igVZ1vGhKGZa
 ZfR1FlrKToOoSM4+GKdZgZdw41xvHhNegdUfHYNKL/58hKf5+qqr3f//iitYkGNV7jt5u4d7s
 55eNY0S5Dl5B4BAJ9H3jgntd47FWvzbgTW+HMjAkrVLKzhnQlsplyTahpHP7SACM+OBjDomif
 q2RMYQWUMMkWRXKi5Jc6q2/KfUIlRvduoL/l3oR0G7D+RP8DmHSLujzrEtd+zbsUSVQIAHSxo
 IqLl3OnNEJdSelMuyAQCZHuZxJT46EOBsQSNzsqnK3GzbVX9zFYM4PuwTseaRyl9ekBsVIQoH
 VuHQrByq7A5x0DoDhE0y57pjMFR9DPFNFeTr8GZYtX6N8KD0wWzFg7foz3qsBStmOTlQIzBxS
 b0Gh4hj9YYyEFVj47XsAny0O5atLVzYv81ICQLM8OlGQ0ummRI/XjzO4ziD8aR/jzfg9+/TSa
 pFoG49va7jen2OTqA3EFVTUQQxuoK9reubfYy7wGD8pEjS77TOnE+/vOMk6UDLqexqZS4y5XQ
 EsTKGyg7/OByN2itgH0KiLS56RBqDDNjjs2UBgv1hW0GGQ7zrJ4GNCXaD3tn/ejgVfCrppFEY
 XnTGMXRdBn0cisd6nNk87J7B0HjPoj2AOwB5sJ5b9DV6/5nftONQfU2lhMI/pKO7gzjDe/TK2
 HupgCbDeKR2lJJEJLpjDPMZXcJivy2D/ODfbSnY0GrqkW0DeS80pjS+u6VQaCpU6QULA8xkxB
 ErDc2fEfKVoj5Sb0ab+Mz4qVwAxifJPH11aZE4JfE78Y/f6AY15y1+qCwr7qyMeW5K4ckut3l
 oSPtih6LwglvqwwnDSQ706lXum2bZ2nYADUro47ZvI7hAWs7rmm7BewYCHymrrB82MYWMAVIq
 PISxogXIVtjPC+WZ190wbn3+CS6vYeWf4IXVoS3OveYqkYJJYmCfe0Od5FUAHswMq1WTdbQ8u
 zkmSLVDrSBiE6P2Xsl5NALOXNr0yzhAN4HcoAlQ==
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
v2:
- Add the plaintext DT binding for comparison


For reference, here is the binding in text form:

  Netronix Embedded Controller

  This EC is found in e-book readers of multiple brands (e.g. Kobo, Tolino=
), and
  is typically implemented as a TI MSP430 microcontroller.


  Required properties:
  - compatible: should be "netronix,ntxec"
  - reg: The I2C address of the EC

  Optional properties:
  - system-power-controller:
    See Documentation/devicetree/bindings/power/power-controller.txt
  - interrupts or interrupts-extended
  - interrupt-controller
  - #interrupt-cells: Should be 1

  Optional subnodes:

  Sub-nodes are identified by their compatible string.

   compatible string              | description
  --------------------------------|--------------------------------------
   netronix,ntxec-pwm             | PWM (used for backlight)
   netronix,ntxec-rtc             | real time clock


  Example:

  &i2c3 {
  	pinctrl-names =3D "default";
  	pinctrl-0 =3D <&pinctrl_i2c3>;
  	status =3D "okay";

  	ec: embedded-controller@43 {
  		pinctrl-names =3D "default";
  		pinctrl-0 =3D <&pinctrl_ntxec>;

  		compatible =3D "netronix,ntxec";
  		reg =3D <0x43>;
  		system-power-controller;
  		interrupt-parent =3D <&gpio4>;
  		interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
  		interrupt-controller;
  		#interrupt-cells =3D <1>;

  		pwm {
  			compatible =3D "netronix,ntxec-pwm";
  			#pwm-cells =3D <2>;
  		};

  		rtc {
  			compatible =3D "netronix,ntxec-rtc";
  			interrupts-extended =3D <&ec 15>;
  			interrupt-names =3D "alarm";
  		};
  	};
  };
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
2.28.0

