Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B207D25E81A
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgIENh1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 09:37:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:60687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgIENg0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 09:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599312868;
        bh=u6aT3F2Q3gGj9nh0VqE3OXnqr1dQ+ZyFPqUs/hm8TgM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VTrOrwLdl4pu3ogu+tX1ulxWEe25edkYiUMGaIhQ/mTYlTRBQOoFvpqExbfUQUSry
         JOrlpStlTpnVAsnfTjlxaxKe2R/Gunh+GF03rfAbLw6g+nu60sbvsYBZFZsOK+GajF
         ItQfPSPZGJ6UY6SwcxSmNpqIB/LPZwDjYOYwZzsw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fis-1kh7lb4104-0121s1; Sat, 05
 Sep 2020 15:34:28 +0200
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
Subject: [PATCH v2 04/10] dt-bindings: pwm: Add bindings for PWM function in Netronix EC
Date:   Sat,  5 Sep 2020 15:32:24 +0200
Message-Id: <20200905133230.1014581-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BsE/idGOdG/2VXSLRx4X2BZv664ZNJ0vKz0CEYNYAzQ7v4uWeOA
 AH0UJ2IvlSFVX/IPDzYUdnVcGC28q2xjtegYX7p1jz6XfdEKfPefQNjGkbZtUVs0iWyDsdq
 pi1cQ/C4oPqlEjjGnAJWf4fX/TKoh1ScMzVbK0LXQgdYA4NsLCioS6RizAlvLK1+CLNqmE7
 y1U84rzjlrWmDVonmfVwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l9Pn3RK6sU4=:32jTXN2fuXC35YyG4qm9yc
 rqzKI+D7X8fDm05U4U7UdsotjDgUMgt6dXGzqe6hTgvIDavtF1XZ39TZc9FIAtwNSivTUAZ87
 281tV/cSuc5eQtMxk22j11gA8XDt4Sz9M7v89ej54wYhswdpfMB5F4enFZSLzC+nSeUIOq5kz
 K12u+VqN7ImWu/xmahRs4V/Wl2NwQIJ44mxCD5CEfKHW/17b+9z2IrDFX5NlEr4b8sYROI3eU
 fxqV3tQc5pDk8pHYIC/IvaHtA28gC4CwPPgW/TfvFBvMm5T6/nVRrZ+sslUbW5dhIRY2hNREj
 68444En7rlvmeg0JYRA6NNZ4y1fysrOa7GLnp3DbjwFm9rFiRWEhpjayYguXa9abljff42YEx
 cU92jNa7+ccR91m8Ig7QBIRBuLT438N6++695t/lBMNLob/XpYhPZ3Q01yQ+A2BnX47iMpBxp
 TbzowqVtlz5GeBAEZCobwlOLI13McPrvCiOprOpbBmYpkpc2OEkyS/GDm32vQ0q4b/VXDqX8e
 X2JdSvamxIB3A9CHs+sSkzKLRCn61r0+jQHcvsUgz3xq0t8yh8xMiKerGIresipwdmokXOq9p
 yPmXghPsgckUPApCt1KGI7F+uMNoH1jWAoWkedKKofq7VKaM7zZwpxnSD2/4w+C6kQmAS+PPG
 MXFSDiFzpHjz1M3VTDdS5Bkv/YKK28r9c6v7UAvhYH03Kb7tIxjDt2bHhsfD0eoeqCh2IFuVP
 bRRF7hPCqGRjrp6ydImrY+xczgbyTbZZmlCmT4VEW2kr/H4iQhJuviIjpg+HMIyJTSaQxNIOd
 cMdN3flWBpfZe/mc1C6uRmYe/rcYe8ndELUT0LrzitHbqpEeQkOTiNB3cj5AQJRrLFCBxmGWu
 ico6cruOgvc45p2TaVJtL5pV1ry+cMaKB/bHEtjAOWKEuiHSo58E7AZIdMZG8jhI9Y8lvm06K
 ylRtcrbePCjaE+eqAmXEf+pTqpCr5eDNPZU3/4oTs9cKspXsC7muJfU5i+bDBwLmRhElPqjhv
 5aIMBEjR/7BHC20WhFr8gAGB802rwo+y6dLxiuWQDPwsvtahqvKybyO7az5kI7tlebOvcyesy
 qv/KyjhP0oWNKqQCRro/10VOjjWzUl4frT86KXg+DNrQkq7P9005Het/s7AxMqFJrq38AAL8a
 v0NZHR2T28KJ9c+8pSHqsvvPi98mSqvABWRFJBvtFe/BqN6ilvXx1lV4UdBmRIH9ecgppIhMJ
 Kg2t0RUPELK4a94nagaOer/50rwkWsi54i2g7ig==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Netronix embedded controller as found in Kobo Aura and Tolino Shine
supports one PWM channel, which is used to control the frontlight
brightness on these devices.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- Add plaintext binding to patch description, for comparison
- Fix pwm-cells property (should be 2, not 1)
- Add dummy regulator to example, because the pwm-backlight binding requir=
es a
  power supply


For reference, here is the binding in text form:


  PWM functionality in Netronix Embedded Controller

  Required properties:
  - compatible: should be "netronix,ntxec-pwm"
  - #pwm-cells: should be 2.

  Available PWM channels:
  - 0: The PWM channel controlled by registers 0xa1-0xa7

  Example:

  	embedded-controller@43 {
  		compatible =3D "netronix,ntxec";
  		...

  		ec_pwm: pwm {
  			compatible =3D "netronix,ntxec-pwm";
  			#pwm-cells =3D <1>;
  		};
  	};

  	...

  	backlight {
  		compatible =3D "pwm-backlight";
  		pwms =3D <&ec_pwm 0 50000>;
  	};
=2D--
 .../bindings/mfd/netronix,ntxec.yaml          | 19 +++++++++++
 .../bindings/pwm/netronix,ntxec-pwm.yaml      | 33 +++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-p=
wm.yaml

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/D=
ocumentation/devicetree/bindings/mfd/netronix,ntxec.yaml
index 596df460f98eb..73c873dda3e70 100644
=2D-- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
@@ -31,6 +31,9 @@ properties:
     description:
       The EC can signal interrupts via a GPIO line

+  pwm:
+    $ref: ../pwm/netronix,ntxec-pwm.yaml
+
 required:
   - compatible
   - reg
@@ -53,5 +56,21 @@ examples:
                     interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
                     interrupt-controller;
                     #interrupt-cells =3D <1>;
+
+                    ec_pwm: pwm {
+                            compatible =3D "netronix,ntxec-pwm";
+                            #pwm-cells =3D <2>;
+                    };
             };
     };
+
+    backlight {
+            compatible =3D "pwm-backlight";
+            pwms =3D <&ec_pwm 0 50000>;
+            power-supply =3D <&backlight_regulator>;
+    };
+
+    backlight_regulator: regulator-dummy {
+            compatible =3D "regulator-fixed";
+            regulator-name =3D "backlight";
+    };
diff --git a/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml=
 b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
new file mode 100644
index 0000000000000..0c9d2801b8de1
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/netronix,ntxec-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM functionality in Netronix embedded controller
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+description: |
+  See also Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+
+  The Netronix EC contains PWM functionality, which is usually used to dr=
ive
+  the backlight LED.
+
+  The following PWM channels are supported:
+    - 0: The PWM channel controlled by registers 0xa1-0xa7
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: netronix,ntxec-pwm
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - "#pwm-cells"
=2D-
2.28.0

