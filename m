Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBDE2F8F57
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Jan 2021 21:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAPU4q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 16 Jan 2021 15:56:46 -0500
Received: from mout.gmx.net ([212.227.17.20]:42013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbhAPU4J (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 16 Jan 2021 15:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610830439;
        bh=8S9aI3ClrGBcFUY7dvHm0J6Z1DKlVcMmgEJFmYkG5Gw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=URX2uOP0BbwciB1uYUiHWfahdeLR2+3LihSdeNF4CGyGHl66cao0oFH168KDg/Ke9
         TonCUIh+VbS97H+Y3qOorDxqqmnnWI/Fcey6GRTHGL/O7bgB0SHRWXCMdUfpNHLVyB
         zh3MuiCDAd8NBz3n+gxLx7fuAgKSK7iBVTJZ33zk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMyf-1lMWAh2ztR-00MHuL; Sat, 16
 Jan 2021 21:53:58 +0100
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
Subject: [PATCH v8 6/7] MAINTAINERS: Add entry for Netronix embedded controller
Date:   Sat, 16 Jan 2021 20:48:25 +0100
Message-Id: <20210116194826.3866540-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
References: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u0DJpXh3/VFmATk3b2+OGivHMdWFxS49GuyPCDgWwI1vfQzSnhj
 MwJqQcar3AQsRv2J6UQ+nZVJUiSOfkckOLAa4iGnzlFoHiJmjRJO7dprHRgA+JICNl2OqbO
 CarA8SQvpw/oXYICpfTKHrGJOsiuy9KiptoV4E8YcS5FbZODN+jiFPXxHT0Bu0uuomS9k7d
 kiSrPUmJ048fn15i3Qveg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g2JU5UqzKjE=:1RUtdlFmVSzHHrS6bfDh8r
 6xeeBjYTHSB/Nhgked09r3Hy4cS1De2spa5tiOi12AuaCnkkapdwjqMuqyEkAx29Kps/448NU
 OgJA97W+IbVt5zuO7em3Ua5eM6dK+lBhTQT87hVTDtHUeckwRzn2klrU8w6pEl/3+1MUTQazb
 5Bv6ipROkaVIWFUxAAE32NzeoEazDbWa8ogLC3SVPKiNopG110QC/R3sLbECn7oxUb7Vg3X9+
 N6KnjkC4/zyYxHFoUPmpmG4VKenG09+SYGekzud6ON9HGGG4eZ9G+kgHb2AzeaRzLxn6yY0YP
 3nAWawFQMjWzAiw35W8Nb02A2Pfn21vUomzR1Bd0J8qomtMfrrdcSmbSPXz9lE8QBanNwbcZn
 HMDuljY5DE9WdhtTZ3RuHG5lxtfEHyfvyx+pN89uU8+lg59Eu//xDI2ZicCOTiDehVA8wf7sO
 5nT68MLOWdvvitjp7mxrlBG3yHL09vS8fQjmKOrJwpmRpTfawQLlQWoc23hBPAZWPEB/bcgcW
 c2FNjorM/sfjZ8Tl2Z4vo43b/Op4Uji3qg1OzQpIiMZnZiHPgXQLN4sie/t1Wn3bmk21N9clt
 dXzNsqrwU+dAO72RkXhBOoVWWmG0WLmCxswxZHs3VTVjAEGJ0WVojDOwCW1juS7QCUx068UWG
 HpCQDV94RdBXdc0MCbyvRyfW+3GB6TZk8vzgho25Gg4WP1oMMit6xwE8Nx5k+S9U/pmuupdTy
 42yqXaNUCti/iTCeCM4X0NTE/GSaRvVhISBW9+R+/6MquaULeZ0Ye4oLPUNZ67PbVWbZpuvB6
 C2PjXx52w+XAxL9FLqIuFb3oVKIw3IEaiI/NzpYHTP9iV/L1fX4cact7fyhS7wIfEYaziijIA
 F4+jaXqL6nRnNpKDonYA==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let's make sure I'll notice when there are patches for the NTXEC
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v4-v8:
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

