Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE83B25E82C
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 15:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgIENwz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 09:52:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:33465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbgIENgZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 09:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599312888;
        bh=oB862ovvKrxnFrmHbMCSfUj8GGDxcJ/jixBV6lZKv/Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=k4LfdyL9A+K1gxU3PB7ejxBozNmNntB6J/4OndUwkMCnJgTzmmkv+4XLRVfiaNPTE
         wgVWJdmKIBk4H/nm0wqw8uIVj2SRa8hUQC24RuZmDR7XzxK6a+hUWO9DrT+qUZcZrD
         RUA1JOEfdYSlA9rAeiHwEZdz8cSFdQp+o+i5XnE4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1kEYL92zs8-0002MP; Sat, 05
 Sep 2020 15:34:47 +0200
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
Subject: [PATCH v2 06/10] dt-bindings: rtc: Add bindings for Netronix embedded controller RTC
Date:   Sat,  5 Sep 2020 15:32:26 +0200
Message-Id: <20200905133230.1014581-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TZpuykeJdULCir7TLJLo7AGLc8R0kvTY5dCpFHXfT1Fx47XRCE9
 24Jw4Jwoc/bPG+D/c4IQipGKpf/SFgh/I6SRC5zN/ByScZKtbpjyHM15mqNN8s/nG3A3Ohz
 dsPIwlZzsSWuOdr9cjlnWAbiqL7uVHeqkqFfmuGrWNwMggk1UzWvRTYrMgZC/H++zQCobq+
 RMEW1AMp2SjRXxYRHpQxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S5q3cVrTyaI=:ie9pgEotpTy1HY6RmNy7Ue
 XwychflidZQcYVmwYUlzMlyqY5zzAsGkHY1WUO4oOZA3srn9fVzD6ubpkgBTjCr4SWipLvytZ
 y2zH0egrtJhRwd/0Bh5Q6aKCKHhRd5dKiptC3mPAE+TRnghsixtZL5ukeUwt/TS6IVj9lInnW
 C3sQwHqwUqrANgZun0tayejT3pVKymdc0POfkz7sL6CwXXxNQrY4ZYT+ro++Sa0scl07yWXT6
 axWCWYSOBcFD3i+R9KRMMpuLskfbrO+neEVQWC81vDK3PNsymue2fkCm4tMMvAqRYPKa4BVGb
 6qTUki+KlGFCVI+nYnMabYgbEot3NZVwuIkU2Clb55xO7sl54foiduYydTF436qsc+vuZKR9J
 pZTK89YtX9Sv4js0suhGutQNrTmNW09nDTl/y/O62w98w/x+3P/4RnDeJuqA4mA7I1oO6S/By
 Pql3GJ0nzYpY2QxHPFD4yfpWvoS2a14mBeMDdgGCavZqf4C1YBlWOITprRxy107m1XC8WkM3F
 JNNAzLmp2bPe5OIbZW/UXmM7xdYqxlmND9a5y+KU6R2vVvXoJMAVykihBD680kw6Q5AXrUrZz
 BOqskKZx6BYPXBYJaFDGOZSwMiiq6pcWHDmey+1ogg6GlZKiiOFqsxNPdkzZ/05EjgEycGumP
 ExVX22RUXMa6T9TyxZWunfxGErVwZgFCGpTnhfaw/e4QwOA/VGfpu4yFinPa/v/ulCgmV+zM7
 0I/rDfNuypGPw9KgK+uDgrtfX5PW0qs5Y0p+iY1v9AeYBnak/hVSfk16tCWO03k2WSTiU2cJp
 SM9fwQI3c1JqIOWj0nybaSvYZiyeTAgcAA9Fj0LlpQSZYT4zpXdTXdRxKOQU9NLgqzW2bqwrU
 LxsRCNPxAGWbbMRUg/gGE3TJq9RLf1/LRaGIFgaqQBFJxd20AHLuf+xvHBpHupTDC+5cJrtRo
 2pF6miDmjVUf4yv7DH6HdqrI0YKVcoF3oo056rr89Oxh6ZSB9JIKUOmGx7qxDpQxMFhQR+HrB
 vrE35S9Oryt2Fkq4fQo6YzpRDMGmkXmK2B/IWcgRfUBZNy1BxajLa+2iENFYz6RBOleOJnjL9
 RqTuuWRAdszLEpL91AUrDe0Mws6L3+wRh29qZsgP2VaaG7qtEnSbGeBrbFoPjWZMsxXn8yyZN
 4sjbSXeG1ettPm76PZUw9Bhc4GvwLksuAOaeX6bC6jzn6xEuz/lIrOQZM3o1cB6oXFNBWIhNB
 2i0jByC4lobc94/V/AZRWjAA/weU3IAf1N39Qdw==
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

v2:
- Add plaintext binding to the patch description, for reference


For reference, here is the binding in text form:


  Netronix embedded controller RTC

  Required properties:

  - compatible: should be "netronix,ntxec-rtc"


  Example:

  	embedded-controller@43 {
  		compatible =3D "netronix,ntxec";
  		...

  		rtc {
  			compatible =3D "netronix,ntxec-rtc";
  		};
  	}
=2D--
 .../bindings/mfd/netronix,ntxec.yaml          |  7 +++++
 .../bindings/rtc/netronix,ntxec-rtc.yaml      | 27 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-r=
tc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/D=
ocumentation/devicetree/bindings/mfd/netronix,ntxec.yaml
index 73c873dda3e70..7e1a21a82d82b 100644
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
                             #pwm-cells =3D <2>;
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
2.28.0

