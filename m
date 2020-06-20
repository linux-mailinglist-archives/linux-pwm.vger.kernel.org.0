Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A60202722
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgFTWnj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:43:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:36951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbgFTWnf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592692955;
        bh=ndIbgrYQmb2subu3Oe9fLJNTph0wDs4Jgr3O6ddsGCs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=J+FgROFFQ3bRtxN3HX8GAAM80SYvrFVum3jbjkMuDoZv82bbzd7p4v2lwUObmvi9U
         RKKkU7ABlhhOf3ucQr/YoDYi2VelWwIOv4bta+W+0QX2BbXRhXfTtTs9zySXTLu11L
         7T1AUf5LhLDeDqYz6VADvdNbwPyJo8wPvWSJhok8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1j0ZJq0foH-00vh75; Sun, 21
 Jun 2020 00:42:35 +0200
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
Subject: [RFC PATCH 05/10] dt-bindings: pwm: Add bindings for PWM function in Netronix EC
Date:   Sun, 21 Jun 2020 00:42:16 +0200
Message-Id: <20200620224222.1312520-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cHtrETJXmtzDsxaAmeos/P2xE+50CNmj6sgaAzFuUOlSUWq/6Ys
 cqIg7vWmvwXLCa21o6GeBXwf7oIpciGmMqEZBvyiohhFZM1XVsvYPlRTVOpG6EouIIfpHjN
 oRsfkw7/ClzqOiL+Ze+SJxfetrwj8+i5loPqfXmdK6ge0n7fr6C0p4UdWe8JtrynlkTEetf
 o6hOJXw2ktAxvqog9HAtw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U9UJEZBhzvM=:b/45FR0hRI3CJbRxSnghbs
 4CVZ30R7wRT0hf/CVO3qu1lLPiL64OTe48LZB7taUb79jr8YtYz3PoP4kXOOJ7ly9HJYTV5Zc
 LgKtHTFsqYIQ3Go2aeby/iy3BgsvbCEcLEaMAGpNs2w0ICbZCNkB5Nfs/r6NcyWCrr2T8eTXs
 pk+5MnFTiweecLuDjO8tMwlItb4ERwxiReHLzWhIW+SGwLQO1br+3BDyWYilMsZmFECvPIXy7
 R8PTNl0Pp0XAS+VJJ8FETabtlYYJPyYzrm/sf4FxwfkNH8WmG7GQrKqSU/hE2kruPsomsJgbz
 VylHazUogB7jLAuVfvJRvOoTeBk/IhRxX8Wdu88H3NjVCM4NI3nEE5H4tmhnWtZsrMHj3P46J
 X2VwLnEIjtMvaRZauEtnc3Lk6f1e2EwKKjSmZra5J9wM8Zws9gFoU9Np5I9fsMyMS4DtVscHm
 iQST7d2sMiChWnmRRxzJqlXCtZLeJFK+ntFKVpupt/UAv0bJshq1daszb0BzPm0F6u0Qg3wtH
 Opt9xdEDU0G21u/025dZrOwyjdHl5VdwsscVUCkGlw5cOi1RsiOTY7gLP6CVlfOO+Fnr3ZUD6
 pB2BOCPTjKq6F13nAMl9erVGVBGcbjlp2VgFiajIgVQPWHVeGFI2CO0wU5hZ5UynxOcg8ekI4
 dHL8mcmn2v2Pr55i+kuNomAuiaPbfgMhqnGyafvkmxq0MPH2wvdUSs1SDAtaVdV6OY3rEEjnq
 iarr91l9VRFmF0XsEMKFC92gjt2XeM4Hzej52q0W38s6jVc9AaWx1aMYusxnObCZPeTAwFQbE
 5g3U/ZxPlApbj67/DauJBq7BdZ8/NLQmOGCLMQVp2MAXAFFgtzYasDZZZWjOX/Th2kUcaDN+I
 /4je8CQoaIG0UGtbZsAkFLy/1LMvLLPS3RZnSBbBgeyqEUOKmMbV1QwweQvoxrDoyxrHMi7Gy
 f0CXDruLnA9KezIt5srHTBpDD/s8cnyqpoIMkRwLzNo6vntAGe4flze443K5S0lvoeTaE/Lhg
 FK6WurPDfcgGo7nc0XLaWxFV23mCGRplOl0wIVexTiT7P5ZX+0/H2CBUg1iNb/gUgsUz/OvYr
 NHO8JLR/iMAhn7YqXEib1JicjAFSXpl7DZCkiwZlBCf0qq3sZ9SQZ65/6ZdcYN44uMkx2/tSr
 JUicJiTDBAVIjZFgVdM/hOgF2/wViONZSXF3ZCMfWDTBXZHst1/sSne2cl0mqYQKVr5KeVl9W
 4L+uoGkI98FY33KXZ
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Netronix embedded controller as found in Kobo Aura and Tolino Shine
supports one PWM channel, which is used to control the frontlight
brightness on these devices.

Known problems:
- `make dt_binding_check` shows the following warnings:
  Documentation/devicetree/bindings/mfd/netronix,ntxec.example.dts:49.17-4=
2:
  Warning (pwms_property): /example-0/backlight:pwms: cell 2 is not a
  phandle reference
  Documentation/devicetree/bindings/mfd/netronix,ntxec.example.dts:49.17-4=
2:
  Warning (pwms_property): /example-0/backlight:pwms: Could not get
  phandle node for (cell 2)

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../bindings/mfd/netronix,ntxec.yaml          | 13 ++++++++
 .../bindings/pwm/netronix,ntxec-pwm.yaml      | 33 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-p=
wm.yaml

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/D=
ocumentation/devicetree/bindings/mfd/netronix,ntxec.yaml
index 596df460f98eb..6562c41c5a9a9 100644
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
@@ -53,5 +56,15 @@ examples:
                     interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
                     interrupt-controller;
                     #interrupt-cells =3D <1>;
+
+                    ec_pwm: pwm {
+                            compatible =3D "netronix,ntxec-pwm";
+                            #pwm-cells =3D <1>;
+                    };
             };
     };
+
+    backlight {
+            compatible =3D "pwm-backlight";
+            pwms =3D <&ec_pwm 0 50000>;
+    };
diff --git a/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml=
 b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
new file mode 100644
index 0000000000000..1dc1b1aba081c
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
+    const: 1
+
+required:
+  - compatible
+  - "#pwm-cells"
=2D-
2.27.0

