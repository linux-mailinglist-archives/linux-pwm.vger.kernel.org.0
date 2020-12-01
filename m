Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398582C97FD
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 08:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgLAHTe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Dec 2020 02:19:34 -0500
Received: from mout.gmx.net ([212.227.15.19]:43011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgLAHTd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 1 Dec 2020 02:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606807025;
        bh=5CW4HOQArD0ga03PAufrXrrqr/PGZhg5w5QyN9LY5+w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dg6UYBrRE4m7GWZcAN2j1qNMHWUO0AYCJiSafjFy9jcQbH/SIOebw5Ds5kyt7OXO1
         BdBYum4+sqr0YFVnqrCKym+4YGVZzihT+nnTngUyhKShWC/E1WiiAuepb1FbZsHa/a
         PD6+MQL1hRaxiRDSRjVnFsufu9H0x1HB+ZXhCpfM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1jtXud0Y9C-00rUKI; Tue, 01
 Dec 2020 08:17:05 +0100
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
Subject: [PATCH v5 6/7] MAINTAINERS: Add entry for Netronix embedded controller
Date:   Tue,  1 Dec 2020 02:15:12 +0100
Message-Id: <20201201011513.1627028-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
References: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0jQyFfee5jYVyk0F/4yqqagvTFNbSZgQo8QuIW7MRTI/7zgyN7O
 NUPnrSUmpRGSqdeGOZoszPfCMlM6oNVN7LlIDRyjrTDO/h2Qn2gaIC8vA5IhmuJ39Pooz36
 nlM/3P1J61T/bKwoiQ9XGdmXuOgBPWty5Tp896ty8u15ZklcEffVY4tHUDmyeiTygJUFOMa
 1jTKwKhGfkQhxC+YQ07JQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vBQhdFPsBIU=:sBSq7NRSzSOvrGYzREJRwQ
 JAUmJhJCCo2QWEY4ELIVfJ5db0D5qCziYoafcpbVi9eXgeGKsz9ly1m7kP9psevyA0CRzTaZk
 mx5ITA0z3I4XAI8elaakBesiuQ+olW0TtfQi6znOdrAF+NO9bBJl9T89X5RL3yA7JG5KV8/KJ
 9nbLmVF7m9V8FRrZ38J4cavpIgH28qHVltqbnBaemvtcf+YwRnmNCmvQWer160oJmncM3WrKj
 LTnJZpfq4/dZv5OulQuNSWF/1c8KnSK7xvGPu02lRhFvLYsxDipAwcQ1ClynpJ1guu5JwfhK9
 7d1n578hVnlwwfo2J1QM4HnCCT+uNNABew925vgnMJ5NESnLFoz0+7EGR31eMxUDtfzZLhnLQ
 ///6pfpoHKaJzyrJoqEWliVBJnmJa87kfP6L+x8YSuw7mpCGbNdFc6fDwOtoRdgJmNVgkOgQ5
 eOq9bJqF+8AQOlHzCike98dTFbxR0iGQubXTmLV8MP1ascXtQgFHR5N2zwSCXIjURYKKUPbHm
 3rTqYmp3jbMR8DujI1j/2VLzotzg/e72fGtYcRKQU+BbvbN8I/QWB/YFnlG8TER6TvTBMiKFT
 gR7XPxcXpnRlLNYrT1ovBNDA6YHoyL53yDlykYVZPGCnTnocnA5kb165snzA0lsxVemf6K8hn
 CAx81MvqazviJkZVLK4H+24IUmt4gHaXtZpMiGBDVM0bWbF0PzImjfhxNK1Dco1ck148nU7/z
 oQBOXXg3a2LArpzN/mKHYgaAwaVzDl8ZabZ+VIOymqwaXD/TJgvtUSi+bNBZOo/Ij9Ld7yABE
 nesgWiqzwgvsfPlj6OU0dJDO/0546Ey1TL91HlyI+zt+ilon/zM04bLCqqTRu4IJjrV8L+9P3
 FkkPw9ub4bekq1pu3bAw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let's make sure I'll notice when there are patches for the NTXEC
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v4, v5:
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
index 2daa6ee673f7f..9eedf3c1e1e09 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12087,6 +12087,15 @@ F:	include/net/netrom.h
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

