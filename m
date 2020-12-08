Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E022D2094
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 03:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgLHCNO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 21:13:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:60517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgLHCNN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 21:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607393458;
        bh=WBl3UrUkR8LNzp1EKh9L7GsYc+XMH2QlTuD5DMeOSsI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c/gMM1JwkqA70r2eT8hu0Vm9AHadbAa4uktdnkzeVYuQeEOnSrXJgD+mxvVojzpEY
         SNf2B3GhVvtGK+ouAFOcWXGWrSz6Sp+UevQ+HU9swhV4Z3Zcr7+fQGXNx1He21DmLX
         GBblwFY7zGouMnTCnrJ9agL3m1r3GI+KIEm24/kQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1jwrRn2A7J-00yuzK; Tue, 08
 Dec 2020 03:10:58 +0100
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
Subject: [PATCH v6 6/7] MAINTAINERS: Add entry for Netronix embedded controller
Date:   Tue,  8 Dec 2020 02:09:59 +0100
Message-Id: <20201208011000.3060239-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
References: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KrRMGiDmIbt0sBNUbCS4VOY+FTc3iGce8A+/3NciAwGds7DAC4A
 HU5zyIPz1YAcGXB0yBjRqBhxui/w+mWKbFBZ7CkITOfBJrecikXxPJmbwLqtlZ+kPkvfXHC
 n5pKbaGyqjDghlbbuyP7lQSmHJ51Ni6/TDLtwizyQ5OUwiV93GAUZm2nntPH50tKinpixa/
 oV4nXdDhbB9trdckJz6Ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M7CN/MeYUhE=:ZVQHiMlpAZY9664thIOZ+3
 rVdlAFm00hd2Gt1Mo2SY1wLXnT3zjJH41VEZdt1hNbza93CIp6FKN+5eXOuc0qYYDke48jJmn
 P4ubYkj2I61CTn5W8yR6YUxQWOfPJbE1vunUwh6IZ8nYvybNmcY1KvtFan9OsAGfLjEX6kWSr
 vh+FnG57ORB4N5PlUM3ZQ//qylnd6puXa+rh6qZ4KDpuzvA3X26sNENoKeDYxoluwZokPd1l0
 vTMFTvEOGRTlA9+y46bO5VhdH7DVqOb1I1j3FdW+IxiAVLf7zp287FQSD3Po4a6kYOPJzzFuU
 rJfqDGgIHbe0MdYUN2MPBSBYM2sKEuJ2mFQ8CIlqisMSfwYm+2vyFQA+DoWNc4/zHrMj+EOIy
 vzls3j1qvSWNH+U6tHRpuvx8jE6B+aROuoxEghc5gnzaGuj4iicblAL4Dxul10YNr7dMZbb+r
 RQqSyI3s4u2f5mkiBZg07T2I/9DGERGuIGlPNJGRClSOU2r3RQFPeB7CLtv+/85G9ZHkczSJP
 gI+j0eeJSPkLFrk76Wt2xU7lFStoe1QdBdOKzYioFFpGa3iU4eBcScFT/Rsplcv7lSynf3k2a
 uq8zNmOgoaet9+5NjOBT2hA9v/CQvSDZWV+HsyocU+6P6sDEXOH0FSJMEo/ZL94CFHT6/Wr87
 MWoDOErflRMXAiAxcEVc9VGURa6c0/eZ7Cc98WiyuDhbN/71bRUnpSTuwPv9kpKCsmih93Fz9
 ylBOFrsBSfJmzp7eYqI2ewl18ys9Dnd4AvMGNTlpuDl9+iTvibxscBJJaKOAyKopBoc+yiZoy
 GcrpMaVFcjoUtWgOpQ0HaTt/1LscM3ErYJyN5SFDGRZGzOVzhlUvMH5vVfJdBNHB0chSkinfa
 vH1/JmlYgqeehdJ90Xgw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let's make sure I'll notice when there are patches for the NTXEC
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v4-v6:
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

