Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAFA202733
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgFTWoN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:44:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:55943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbgFTWoM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592693002;
        bh=exgY33UX1mwRdxvLq8yooJTHfmjPedUVVmEPFY8Wxms=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JBv4w0m4fUZXFqvaoIbr9dXZUDiQqmvQ4ioKKwtnNr8qgyBa4BG/kOiVOASuUfdz3
         yBjIZxS3dzErvIBYnwpky1YCgS0l7H4HVKd+2uPAAPrXdkPTrfPN+8ON0/SukiY+PA
         sdnQbFWz+tk/LUoxvqth+RzEMaAVmP+9GtfVokZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1j328S1M1O-00jnKT; Sun, 21
 Jun 2020 00:43:22 +0200
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
        Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 09/10] MAINTAINERS: Add entry for Netronix embedded controller
Date:   Sun, 21 Jun 2020 00:42:20 +0200
Message-Id: <20200620224222.1312520-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a65/Uk4zRPdbL+IjcV4kAQ99Lb08INVuwG5/wNz6bYWQ+nM3Q9r
 W2TutNVZXIZOUC0etTK03LElim/glyhxLFYIlDNQtixa6qEIkcInbfnpQZT8T68b1EVXG3S
 OWV1HTw+ppWJfHlftINozC77z0hcFIPAi8An81cPnK4/3eQPKRO8Z1pjVoICXx0dx9bF6WN
 tcWUPjbQ5/Su6cKOt9qiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SU2qUZVZ8c0=:/3Mhge4lP4yfuQJDIZRgR0
 86BKuRLH7WVPJTbL8W0owLdBkDGHeaG9UT47pAoJYP8IfeVL3vADlbKbgm+auZYEHucvgRdL9
 fJFj1bp/29hGVgPQqQRRCBMlm1p5HIOTfduwrRsV8YlQOdzhXvrSqZEo8eJVjz4OygZs7Iv/6
 DIUUM87Kc3wrk1pOB0rxZi7aC7fSRufRgaROttB5wGiCCnRcInBouWQEVjVFXKi4hlB7+SMr1
 WKXnzEqWE7zlR4hIO+ZsEWO2GWkBWPTU8/oBDbIXEc3NQJ23PbvniHtP4U/iA1xiIzF1+TUaN
 y5GPteuFASACUnekidZx/icd1yhXMB3I4ND/JSEQpXptG2PUJCKmelmoaxKL9p16sStZnpd1F
 wgd6jzuJqEN2h9bkraoVP8uUJbWMcx/8YXLY4vIeQ4S0vWUiKZp9kqbudPBJEj9mpM2alBeK7
 sNy3LNp3Ytx8wCP0I2jdZ2MylBitP0I7g1D+cLOnwweHT96RNHmDxZy/39kVd6FrS8r2PKsyp
 JcgZSv1f3MAnpzx4dgMB1wpSiDDtGfD0fchfdCjD9tcBhiInnd0IyVnTDFGyTIexVH9iIhH2G
 wREdD8OZ4r3dvpfoxtNKpBD3bXJZP8F1e8YXYI0Lnsatmai7DXd+GxmaJpokGSTSeAsOeIoxM
 mqb0wgkCpRb5waPJlbQ8Fy/U0xwqXB8vMLvVBAxhoCO4CbQ2pyz49doDo0Hyi38hUIFdz9V6x
 hksBJuOBfro5J/m7uMSsfJukLaLwEu+r/UoTkOEgXXtNj7CZZfY3Q7vHwR5gepy9sttLlzh/+
 4GjzN5wCCzT+j3aEpseGoT+0SsPohsSZVomuwXFILCuWGOy9Wd+IXo2eCayCqvmK8cRN9+lfa
 5UQJgUtOpTtpbAi33x3wM3OLl7rkq93mHEszi5aBdfrMdUwgfj5pexKanUGNHMHyYyNevZIUn
 2X7w8Tp3p8Mf7J5ZGAqyzTaN4fvhBeRNnT0ROTGeNentL11rZ/LuLFBGXplL1qh2F5SxymYrf
 RLSPnsSJfgeFExQSz2vbygeelKnnJzUNDe3UToKBr1lrCUtcRED/y7tHC5GeoZ6JBBkEVbvVx
 bbWlvCNUSThgpz5ROBPR37Z0ehlC51dJhQX+RZOBMlkkAVDWZVOzJ8D89/z7GsHuNFsdN5soY
 B10kcBiNY4+hFpQc1ZsXIMku6byA+tWotmwEO11tO6K0c1y0en7KdFhRmgxy9SD+JGec8kTpC
 VLzmO1z4v03UOLN2j
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let's make sure I'll notice when there are patches for the NTXEC
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c4..d4333f7490f5d 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11850,6 +11850,17 @@ F:	include/net/netrom.h
 F:	include/uapi/linux/netrom.h
 F:	net/netrom/

+NETRONIX EMBEDDED CONTROLLER
+M:	Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+F:	Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
+F:	Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
+F:	drivers/mfd/ntxec.c
+F:	drivers/pwm/pwm-ntxec.c
+F:	drivers/rtc/rtc-ntxec.c
+F:	include/linux/mfd/ntxec.h
+
 NETRONOME ETHERNET DRIVERS
 M:	Jakub Kicinski <kuba@kernel.org>
 L:	oss-drivers@netronome.com
=2D-
2.27.0

