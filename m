Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A420272C
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgFTWns (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:43:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:40865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgFTWne (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592692960;
        bh=quWpSURYzI37HAY+ZRXyoXMx0x6xymIR9XadTNWbOm0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jXPADqgsQRfGRq3jn39dE8CWtm9UG80OHy4kt1PrelCzVkXkybJYMQphTkqHVBJPP
         YLLnHZSdABYy1qBb26AMLiEERbuGCVV7DGKhldESZJ8O/um3jRfTMWYVgUr0dpqXBl
         H2aQzH9d7skrZZ34gaihGa/eIu/8MAeG72wXESfI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1ixHWs3fLx-00yvXe; Sun, 21
 Jun 2020 00:42:40 +0200
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
Subject: [RFC PATCH 07/10] dt-bindings: rtc: Add bindings for Netronix embedded controller RTC
Date:   Sun, 21 Jun 2020 00:42:18 +0200
Message-Id: <20200620224222.1312520-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kINr04vGH8PFK0WI4mNxqdxrk/BTSB+q42S51+k3h8qzZN+MKBg
 39ozPRxm1iOnsGPo7aKAazPj9u1koqGdtnXsm0yBV2EzCMz/snPFdqb96BNKl5DiZ3SZSWJ
 3jTi+1yoxznDEVo2nCsnqKjZJ5DlIrdVICxcD6GJxhXyxEKFNkXUFUVbcUNMK2GZCU0rg3t
 5RQbWuraPRT5G7Q6GQWaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l5Qjo2w9OhQ=:WCuhRPDe5N3Khy2z5xz9L/
 rb0zLra1fWmgwAE5b/+YqxhmK/yGKgtg3IY3h5PLyFF7zFqLgdNUnnx9pLBByPyyoIlQ8gC8r
 Z4zw3VuQ0ogI07MvbGLQZKYcxvwsXoUqUQ9FBQsuRgv3zURDWxpDnlNBCDgMq7jdyM4wEuBEH
 NqJsSx/0rNq1lpV1LGrkaOrukiDghyQeDWJnXQxfaPbEglxcvj1EYTt7hVDH1R159ON7C0UZV
 ZBfs8HE/KhSFrY1hJZRfjhJpLigZBGWslMko5jP/3lmVwjP5clf5t3mZ2gT7nY0M0A+tzuSiJ
 RBajDzAVfUhP6ccgLptPSeM1KZImK/4X74SSSqSzyOI7r6y9lsvgP8AOa2KQoH6oB2fgwFdVW
 foL+K1a9DZ9lP+pRQ/rWH5kfMa2J8fC4cVNiC9BmWP8K1sOXTAn/ge2mmubaCHwfmDf/vsy46
 JEyOsAPT/vttnayLGhMGPptu9LqbzTae6H4cnDcCtv/Y4SMYyZLcOeCynP/B4I0Iduysl0DK6
 du7lISZkqDGKtViqJOJgJRUHgLCHhT8P5PHhn2tn7e1eS9UTxVwR3LdkduObqwt78objrvyK4
 K+qTMfG3AAebRFORWVrRaOkaF1WEfYlxHNk40k68P58qX7pPweH5Ih3IYrYzSTkeaE5JpblLO
 VRdtn83Kx/eRKIXcYV216AEQLh7kfGzDlvHj4JTbqcg0Db+RNBJLTW3s7BehJF5VVBQc37TIp
 m7SSMZnLXXnVAa+0rGwRd7+8OqpeUg2PKViDWJpo22mt0fIXjgNwpu8oH8cwPWJg2t8iii9jv
 WVMw0tgfK00/RwA42SUEZGmay+gZw4/CgkSjttfjvgzZyT2T35bQAFFScpjE7n5FWn6Jr8aNP
 e5CUOCuH9ccb2VF3wuRXDA+9ifLavvO1I95VLxybYSxaVQRwaxykN1Q7m+BdQMYDMR5J3Rn+r
 g6b2pQA4ozXIa7tGrJXzcIdLFApeYA5h0SpHETeMHznHyf3lBug26ikiIK9SK8UINPXY9/WdD
 WEt/jx1rTFj0Dldgk1uWPcevCtU3UelskVKKc0pzRDK9Q39xZd5CjZzFDNqBtKDYUC6w8PwlZ
 qkIrrp4Jc/NstteeqCcs4awLU2EZ672W7G1LV8+9vJYa2s2JM/kpCX0DAD71Lxpp96gIEPpfD
 pU/2wcDHBPnAISBOBHp6Ufn9BUzpo3Q9Hxp2YrvQ/KK+f2VauYs9yfaxcpTFj3rbhZytMLMS3
 4kXQD+CJkowm3JN8x
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Netronix EC implements an RTC with the following functionality:

- Calendar-based time keeping with single-second resolution
- Automatic power-on with single-minute resolution
- Alarm at single-second resolution

This binding only supports timekeeping for now.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../bindings/mfd/netronix,ntxec.yaml          |  7 +++++
 .../bindings/rtc/netronix,ntxec-rtc.yaml      | 27 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-r=
tc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/D=
ocumentation/devicetree/bindings/mfd/netronix,ntxec.yaml
index 6562c41c5a9a9..f6a32f46f47bb 100644
=2D-- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
@@ -34,6 +34,9 @@ properties:
   pwm:
     $ref: ../pwm/netronix,ntxec-pwm.yaml

+  rtc:
+    $ref: ../rtc/netronix,ntxec-rtc.yaml
+
 required:
   - compatible
   - reg
@@ -61,6 +64,10 @@ examples:
                             compatible =3D "netronix,ntxec-pwm";
                             #pwm-cells =3D <1>;
                     };
+
+                    rtc {
+                            compatible =3D "netronix,ntxec-rtc";
+                    };
             };
     };

diff --git a/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml=
 b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
new file mode 100644
index 0000000000000..4b301ef7319c8
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/netronix,ntxec-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RTC functionality in Netronix embedded controller
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+description: |
+  See also Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+
+  The Netronix EC contains an RTC, which can be used for time-keeping, al=
arm,
+  and automatic power-on. Note that not all of this functionality is curr=
ently
+  supported in this binding.
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+properties:
+  compatible:
+    const: netronix,ntxec-rtc
+
+required:
+  - compatible
=2D-
2.27.0

