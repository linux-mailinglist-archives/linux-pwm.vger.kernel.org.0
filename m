Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3B20271E
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgFTWni (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:43:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:45831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbgFTWng (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592692947;
        bh=OudamScKxsSwesQWI5fhg8i4uztyIzbbtXHCU+btXqg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JJlLzu+EP2kHN1UTDpUwB6LsqYgcAztufiCAgWCcxVFKraKCiYMrmS+mXlItATNNc
         Ar2ZNr4QuMEd1/btmPM4zx9DQe1/1C/Ki4Grla16r4HglxaDLrhr3slsSc2iXWxzcg
         iPLI2pWnBBJ38Vv5EeauBsNsISVxdiCIdDGhLFy8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s51-1jlPPh33Ch-0022vZ; Sun, 21
 Jun 2020 00:42:26 +0200
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
Subject: [RFC PATCH 02/10] dt-bindings: Add vendor prefix for Netronix, Inc.
Date:   Sun, 21 Jun 2020 00:42:13 +0200
Message-Id: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yZqldghSPumPDLmSQbkIreQsfprG56cHRfGVJLO/YVdhlg8pdjP
 qZiYkkWMBRqMgwiDDZxJ/FCfw8bxfnQru0qx9L7azU4/GJDQAEj3hBxzxC5XMdXgaq80k6Y
 SHT+PXTXWZyf8p9LmwX14SH2+bFjtxTBBb9kbDuWJfCuNiZWshywX2QCJaoqMczHJC6Q/50
 JgFxTAZrllSeaBrtPHSFQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:do6d/UNjmsA=:R9Ie587I12yWywA8J5SpSB
 BLF9Oth0uc8kZzgmzZ4+u54wt5yGQoaFfnpyHNx4l7IyNaDg6+/+R/f1hgPMu85eYY5HE09ge
 bFeuKAfPblPLjhk0gxae1vikVfpqrY6RpY8N5eF3Xa9+zkrpqK4Y89pTbt/tflnz2axOUyiu0
 BvAA44P73R7IBIZ8spCb0xBlEBH3SzTHQ8G/xDG7QHTuO8Nu/6jGu0nDuRW58tKjlP8wVDFTf
 ZzI9LiHs6GpZ78j9HiXl6PekpypY+lpzMEUnH27lemTM4RJsYLGbIwfBZL+heIywhQX97MHAb
 5SL6uP52Mi69J2ULGvkXFHkJzx/Fs7i7I7IYxkPKL/ymU8MFvMKscDgY+G5K3Ck09weMxr7gP
 Jy0jIGL22XQFWJqcl0V2qb9wGpXdofOxE7C5RVcPq0cDuRJmOmj5VIulyg5E06RTTPEFlHBND
 k2o+uWYiXoSgdVdqipbTMtaXSI4e4JI8U0fmy06dtPFWD0sn9phBsvgv/n7NEdnRGrzFLNBke
 oij8xPQsuUXQy9zd+A47jW3jBXI+kBB2ef23e0Newv7WVZ67d12hN8ctUwrRFROZYR7JC2OoH
 W5o6AdCPx+LdxxuKcq9SOT7R2f8YmacLH2k4LXIPVzqTbtjmiPsxpyyJNLNSZH+o34UgQDOat
 Ai/Np7TPrDTSBHyAzDYL2vxL0w33qfURn5JvzZgROmpDVmJKA5zqCnHexmYh9brcPIHBbyJnx
 IF5z7a8gKg+OEQpH3svSXi2q2BccfSlCEGZoAX+9ymRTM9U5nxCsb6viJpR5q+XHUyZbSvgHy
 GTpx4KurBhFmMCbBR77FoeEz47J77XtYMhtMI2TPgRWWCDE6+vaGYROumvr7Fo6EwYLlAyXwk
 ugZd6n5oTK6CzP5bkqC3e7G0qbXlzqHF3hOA6xh1/YtSo8243CecXf7SF0XM2hYffsQlOS+ph
 qT94vPkRWA1tbFbEFuiGCoBPnwL4igL1WDeXeBw93/uNzFEGV3wZ7m/RwjtjoR9zZUQFnZUYA
 US1nlqIwAY5Dq6mZcFv0w8eFA6mBmnO1qA/pSzihnRaemJPqBZccuknxaQJ8IaAwL3mEDR3GH
 vMpRDMTFujK3T8upXyiZVDnqBlgx21pKIOvv8txYkHugk9kedVQGtxKT98Wz5r0fqkz+cIwDb
 KXYWUc+ZoCBB5uWY1GKLQiYDQzU8VrTak0TZMvQxC2K+njpePApu/khJrp/lKWlzKaPzWZ/Ih
 jixY0YPWy90Yjy2NK
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Netronix, Inc. (http://www.netronixinc.com/) makes ebook reader board
designs, which are for example used in Kobo and Tolino devices.

An alternative prefix for Netronix would be "ntx", which is already used
in code released by Netronix. It is shorter, but perhaps less clear.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docu=
mentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85fc..516c6b6668fba 100644
=2D-- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -704,6 +704,8 @@ patternProperties:
     description: Broadcom Corporation (formerly NetLogic Microsystems)
   "^netron-dy,.*":
     description: Netron DY
+  "^netronix,.*":
+    description: Netronix, Inc.
   "^netxeon,.*":
     description: Shenzhen Netxeon Technology CO., LTD
   "^neweast,.*":
=2D-
2.27.0

