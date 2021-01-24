Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FD0301F52
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Jan 2021 23:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbhAXWpX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Jan 2021 17:45:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:39429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbhAXWpV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 24 Jan 2021 17:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611528194;
        bh=gqVO40eczKBUp/da1hK+DhMl8PPZZmUQs32NGJO13Zo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FQ9dRhvBDWB1+I8KmP53vX62FTHZwJX9Aq3Dtjgc556Pbxyw22W4RoFd9YJf2HW1s
         jxWxfWuQ6Bkh+XozjvOEufrvBgzUcgypACRb6oOI4ldzdsx3hR0NY69VfDrk8TPEqh
         WPcjbjSBW3tChvv1LpvT06UkLOI/D8bMmnTvdWjk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1lrN9R1KAR-00vBU1; Sun, 24
 Jan 2021 23:43:14 +0100
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
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v9 6/7] MAINTAINERS: Add entry for Netronix embedded controller
Date:   Sun, 24 Jan 2021 22:41:26 +0100
Message-Id: <20210124214127.3631530-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nuU7O2Nx39WachKnyElDQYQZ+/yJ2bMGoEvTzri0Ak3qc1M1yii
 F/EuyxFnGvcE6Xx8jJkwKhykpvOTGxhltxY/mKFkkh6hEKEocBQduFsHIoH46vQknAtpOTy
 8YaoZeiW8HqU9XtBj/Sot+TNRGe+E6mx7cT6lTrQe7njcOwZLdK5Yc/UpYDsPT+ZaoFyWMS
 Vl1Zvwl68QGlpRtmeYnug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ApS4o7QpSbs=:QSYKZoSaESccNTeSFmND36
 0iwEveFM/VjkFWk9JdaD/pOy/37yfLTfdpklFuYhYDOu6yUPcXgvR4oGQUN59UCtstXOxSexl
 bZLwoQaDCbgtyPXkC1iI3hvzG+ryPIRJEspMKbNYcfS8ZNMbnPLJ2Stk3pTsCIchDVbhovhtg
 RFP8t/heg8EHsUzc57+rk51trzYNHg6IGgZbYshBrwLxTFnYFgY0w6WuYduJa4Fe95Z2oJOYP
 Rh5UgJesRok4xrHziUpNyIBw9GIJpyWUF3qOdYiii9zgVGGmT+VPpQVH1KS8olllaxjunJx7D
 FW++oJ4hyh9ctSYtOz6wbtCfBVmVcg5Rl1solfDR6mG5kppT3hvfl8lM2TG8RX9thNx8chgIi
 jaSuojg6+AHTBPv2cHWP114OeigJTZO60Dl1v5fndgffiTHhawq+Fo16vVQ5UqqrCs7OsAHYM
 1LKKGG6Ls6mXIOk3DsMn6jdz9GFfdxago5Grw63TZGk0f0hF/W3ag3lZmg7/TAUPtJ9DsQzb4
 HZQECH+dJ7RLQQGi9U9So7JlRiUJZs1yD5CcjDVZSwvYE4BlU39JHQ6G1HflnP/ec3PtqPuKO
 LX16VkjPqRtL3PdhS7n8zByXPFZLHqRSDiL5HccjqBEOojThvr18btvwa9YtCProWIejNklUi
 rX9AlSBaahwV6RwfCmmBrO0e6P1ay0B3IMHEbHPmhx33nP3Arh3HQSmUKRjPaKjAyShDWWBa3
 NOOGZBDbTGGuE4q+0lGc4AwwZ5ZhWGz50PQzdClBIElrkUB6e95fLnT2a1cn0LFnTbepkg6UT
 BmVPpfyKGjbBYXcsKKtPIiYSnxHYUteItFOQiAQTLkXNKVyRhq9MvgKNGwzjdVShaNQ2T6+Da
 lavaFPWMcb88uTRn9uAQ==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let's make sure I'll notice when there are patches for the NTXEC
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v4-v9:
- no changes

v3:
- https://lore.kernel.org/lkml/20200924192455.2484005-7-j.neuschaefer@gmx.=
net/
- Remove pwm and rtc bindings

v2:
- No changes
=2D--
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9f..0c6e739e3afb7 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12298,6 +12298,15 @@ F:	include/net/netrom.h
 F:	include/uapi/linux/netrom.h
 F:	net/netrom/

+NETRONIX EMBEDDED CONTROLLER
+M:	Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+F:	drivers/mfd/ntxec.c
+F:	drivers/pwm/pwm-ntxec.c
+F:	drivers/rtc/rtc-ntxec.c
+F:	include/linux/mfd/ntxec.h
+
 NETRONOME ETHERNET DRIVERS
 M:	Simon Horman <simon.horman@netronome.com>
 R:	Jakub Kicinski <kuba@kernel.org>
=2D-
2.29.2

