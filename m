Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC04277954
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgIXT3B (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 15:29:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:47501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbgIXT3B (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Sep 2020 15:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600975685;
        bh=tkswMYiJHuOplMgXDoI19/wmwW33bJ9gmJGG21R3n4w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HGaKRk2KHWR20nSbmPKPbY1q496x43THCZkb4nHA7JSyK6IMkbgKhTetYVPExS0GY
         6Evce2FbGghEpzHQ/iq1dSiuSss5CJ1oSZlfSmeeQKq0cXV44hZqAg6jVyaJt6PlcF
         iI0DCIzefv/MLCube39V7aQoDt3Gd0pL2T4EXf8E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHru-1kbHNX0NUg-00tjzO; Thu, 24
 Sep 2020 21:28:05 +0200
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
Subject: [PATCH v3 6/7] MAINTAINERS: Add entry for Netronix embedded controller
Date:   Thu, 24 Sep 2020 21:24:54 +0200
Message-Id: <20200924192455.2484005-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GaOsMeCsmwQHEurNROd7IPeF1FHhthoSmqsJTawoxATBVyBahAA
 bONZSpwDuTCJZGbi6MVEP+O0flWzyLon2GFMElwSbdRwhwHilneAYc9XRJpoODdnNg9sWR1
 2ah325YQJfDqoKOiHNMGo/3U9H04VICPV710ptbLoZDt56Kd7mh2d6uFCouqVmmPYWZI2/e
 rP1Kq9F9nH5XaOHF2QcHA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aBK5xLr6xz4=:8wC3tSy7LNU0RZZkzosbRd
 mrgoBR0OAwqs+e0ai0eXhkwGRKeKw29e/39DJTqptGOyLXG6fp1g3v9y3VQmoH4OcSDOgV9DW
 qoWdYFInWqWBvIVFlBDX5sgOk77q6+JAx7zT7Q4C/0ptrbQhf1sT9QmaBdzYceEzJVkr6P8Ma
 YuC+GW0AZOpJrfCUYcdmToqC0wxxzb1fstuPdpfflYqhof6FLuWQ7wrt2LtXLOBIQrhH+g5QN
 oaNYnXGXclrf/LP1N1nP5K8+zanvx/1SRNAyLRuv8Np91m8VgFPCJ8x8xFyi+OBNC2Uvs24U5
 Lh/g5xel0meyPB/IOtew5cl30lqRyNROBdM3N1m0CQKH838uyDlBza2QX4tNuUvLvfcTYf3HC
 W8KXgOR6Cy/5MfQi2+xQV0TjNDd9w1FkMeNf1rm9PQyCE8Y65XljfodKaYPgTXN3hYGp/MlFE
 cDwZa7k68v790Hcqq3FaRXSUTPIQLZUYUM9T7uy6D/HT3C76eoHp8OkFLgTNbkVMWi2etvsFG
 hl0oKUmMEW419EB+GYJaPaIwUygfZ2+t6qirGWPdI3mSQZPdYGohBN7uLsXRA+niNOerSD7kx
 qZztazSfdt/VEUMabkMUEXBkbVVbdaXXr42AFmCoNvW5Z0DdBAT+Y8NOFxtDGms1SWAdEY8ux
 6hME/d7WZUZcG86lfYq48bYsA70joiQAw5yvF+XDL96Xg4pI0eYiPgt9zCzE+FMPk8XUtW1g3
 Yfja2phvSEWS1c9Z4K60/5+lKnveZMkf+bwb3qVZGOqocs5RwbmmoZrmgzLLatI+9ZZzaEGhc
 3vY+HtMBTVfRFfkMyWXeggIIqExdSxbU4fghLvBVZNT45i17g6ZfBX3B4z9QASXF4e4MAT9hJ
 WqqjMv9FyjrdihSE4Cv/Nq0RUrEmiuWVobe8cE7vNUWLvhclmUtWjIa0MeBm/60B3mKCBfI3Y
 Zig6MAk8V/Qm3JJHx0VFmb8WNt+qsOGc4wzfCyW3cywqJROj/laCHGuWlJ2kN8RdhBZ+e2dvs
 RYNLtf3CXNlr7n8N7WhDx8oEgpAX5kX6QYx4WhWSeOwG5uPakcSW25n8G0gkfPd+D3QlVphu3
 UvzRf0x2QNKhQGC6w9Idxs5IbEBL4+FWshAhK9m6WRqXWXisHQgh2gRaXMa7B7VWNNXGbEMIP
 Rg05kPv/DZrCTh3hruiMpy9Rq0XUWng0xYJeAWE8KJs3xz/lno3MZed7ZENqBkBb+W5WbkfMm
 h8sh0GWadlO8HFzU76SLJQvqIyQniHhjXKZnjpw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let's make sure I'll notice when there are patches for the NTXEC
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v3:
- Remove pwm and rtc bindings

v2:
- https://lore.kernel.org/lkml/20200905144503.1067124-2-j.neuschaefer@gmx.=
net/
- No changes
=2D--
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d746519253c3a..f28f7cb890d05 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12019,6 +12019,15 @@ F:	include/net/netrom.h
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
2.28.0

