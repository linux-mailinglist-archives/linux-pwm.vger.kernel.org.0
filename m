Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0C42F0313
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Jan 2021 20:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbhAITHa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 9 Jan 2021 14:07:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:47167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbhAITHa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 9 Jan 2021 14:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610219124;
        bh=bdGrd1dHjfVfOxioH7vVPzF5jNF+vaOKNr4aewtxsNQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PRxo9KgPYNYPVY37ejEOnQwj9mKGW1Ke6JKuzn673MRVdHhwTsr6i+82aVL4D+Oh1
         KU9jki6e+8jV+8TrvTf0yAENKSWg9ocXYzBQvpJZEN9wATsB2n2yN+os5b6UzPFNlk
         5NIJpEHWv/a+jJsKROlFV5Yv910yDQHdp05BI9NM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXyP-1kSYZf1kml-00Z3Il; Sat, 09
 Jan 2021 20:05:24 +0100
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
Subject: [PATCH v7 6/7] MAINTAINERS: Add entry for Netronix embedded controller
Date:   Sat,  9 Jan 2021 19:02:19 +0100
Message-Id: <20210109180220.121511-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109180220.121511-1-j.neuschaefer@gmx.net>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KmkJFeZTX6fxl/vvb7KaCz13YKnxpIFBgwuleEreUkdEXRjQaJN
 ym9OQH1YStZ+nh0+myxdLQHqwLV1JQrY7ULIq/ur3Ag09ibEyw+Z9hnHInUzePHDcho3T3p
 ByNgxs+rHFHHCr0eALxGEKTG8rfegqPycbJoK9YPySSnzOxzrgvCREoV8lJQvu3C7NaEaln
 tyPamt820YYZC9nJ0G/BQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q0O+ZaAEP6c=:wlHAQkxk9oGVy/frDBGgad
 SlUNt5ULoStHGVvZTg8vr0U+P7rwFOdX1k6rbL/HQw+YdKqxqH7jKi+lwBq/Zu5vhza9QTqdB
 pdYN1CPmif2BpxAgfbEK3vQ6XK6Tz4PgdKo1c5wbrzALIBfV2U8yDhZC59jndD7DpGq6blXfn
 taF14Ad76CppjWbQE2RQd0pL//Q+4hsaCuv5fh6p+5TXTX3tLuJb4Zbn/nyyAXXSSMrANurcp
 Lej8yIKSaD5p0UZVPMWR3nBiwVlcKZqBf6u3khEYDNfFT+Z0EFJdRsuWqL7OUW/wvO59ykVdc
 hQcXOLNdXiKxVrS8NDTm/0ADb2wZBDyJnP8OrMwAym8qKO5fPUMW2NmJun0w9tav7x0+pGtSC
 NNEVpzWzpDdlzIdh5Dvg3mv1WFDQITwtXT52MAp6tmIoX+GtV08btX4xE8ev0k41smkkW1BHr
 FpnDYYjq/vIbvkaohuP8P3ulBwUEga2ycVB7JVZA/rSoXz2+WCVb5VLKtkaFI+vm7Yv/21ftZ
 2ad0BgJx+1KeEbf2hHT+y8R5d51+ZCERVySPxY6bREw9k4Q/pAo4Ow6S3e9aSHcarZbU0HbZ1
 I+s+mJWkk+4+J3SlNBHc72194aQwmO+hBs1+0OYHLeaeBtuxhbfBeH+0oMMm9BYVkkqg3cmU7
 aBaOXK14Io4svXDu3bspVCBt2SvTH+xf4YLFB0vwzF/Mc/590cZdLH2tAbXtgaebERcWwdhzj
 PmDnihh/qAtfV6ufszjCxowkDRx8Y5nl6q9uk9SL32kONsCdVJxn3nTzip6obtkJduXfrPBsU
 fQehbVj6UXLmiGrmmogOTxQmmZSrnljq6xOEtYm77OaICseOM5HnFlPyl4qSpujtNt3sBh4Xb
 T+GRoY/Pz70bdTw5U1/w==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let's make sure I'll notice when there are patches for the NTXEC
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v4-v7:
- no changes

v3:
- https://lore.kernel.org/lkml/20200924192455.2484005-7-j.neuschaefer@gmx.=
net/
- Remove pwm and rtc bindings

v2:
- https://lore.kernel.org/lkml/20200905144503.1067124-2-j.neuschaefer@gmx.=
net/
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

