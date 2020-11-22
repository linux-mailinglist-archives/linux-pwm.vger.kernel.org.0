Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9273B2BFC80
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Nov 2020 23:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgKVWjs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 22 Nov 2020 17:39:48 -0500
Received: from mout.gmx.net ([212.227.17.20]:53467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgKVWjs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 22 Nov 2020 17:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606084743;
        bh=TwTXmICFzYAmTOHiZEt5ZI/UPPTORMtHYQaQQ0Nwy74=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jqOQno30nk5O3lm0TqTj1PVXroG/P9rLYX60tQmUfFuUehCnfyJ8f7s7u/bwn+Oee
         lbk6Mp/272ca30SVIchkvOdK7xkIU7dkDk54x6jDC50m1maOVHUjqCacHBXMwIQZYi
         cETLbymyqpclY/rdKyho0E7QENN99PTcRPmnHGNI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2aN-1jzd7A08ZD-00k5Zw; Sun, 22
 Nov 2020 23:39:03 +0100
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
Subject: [PATCH v4 6/7] MAINTAINERS: Add entry for Netronix embedded controller
Date:   Sun, 22 Nov 2020 23:27:38 +0100
Message-Id: <20201122222739.1455132-7-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7m+8C/IVVqK0Q1ljY43DVWLQAvl5vN2s7HxeLIgsIRon1jAyFZV
 iwwWYfTVEkJk3wmq9XUw+d+d/EjaWA4aIM48vfFMAL0dgYeJAdAvKmBrK8MsBy3qGhWiVW5
 O8BTpdLTqOoOTu+0/3889Lz2Vyx5E3mghu7ZVtSSNUtxoQVqIz4d6Ly1EMlRRqkBilr+eiV
 7xXNGWFk52QmJJseZtMkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HhrMhAcY/vA=:DoOMzHUUWh8eLJf0nIDwZy
 BDxBfzloMHFt2l1oyumXpx0fX+ELNkE107J8DMat6VTQ7GkQscsvcTK/igsS5qF70C7KGyr8Y
 xYIlRFFt94/hgzAanqlPl3QEhHS0/BQ0aJVyZT/yC/HqNwkyxZr2to19KOvfMPODxGt4yn2s1
 GCD3SZFIRSrcOsgw6FFZA7QZpNGFWC1sw29jxd/L5CluVgstWY82tvtjk3pC8czcP5uHe6eC1
 rKuBDUNESQS6Ka3vnrJnsqn82I8KeqqcOxcj6gyuDtW0vzqzWyI/Lu8nYYam5zwXrGI4ivaae
 n4Jc32WWetlO0KcBdHJ8gW9tKnGpllT2Edg3hiCPXwOBDuCUrAnn+f2x82gQfgDfCyVkAWoEm
 zyn3ptGjKOwCITb1rubZdoMo0qfYsRmoLELN1YBLJ2RErGslatjNUVLSA6CLkwSqjR8XNnNtH
 mrfnmK7btSvXVs6DdUv49PyVEjqPULy39F9RSlUPlBpoMQ8ZZ+K9r/EY422LK248ljjTQF6wY
 OcTpHoKmAkHW8MDxdBbqOGA/KVfxwmdPFt4w+1Yf/m+6k3fqx/ZWvvFhAzhP6+9L4EWiwdMRq
 3HoCWE8ncAChBmWERy7p8AFhjrnKcxOhDy+PNxARkromSRTrA9kfuslae9A5SeIIRUnA9wFMz
 h48ket/fYu53Xc7kYOlO33saUNbgS1ScVv2fcf5PLnhAzi5Cc85Pt/nbgHyebn8tVTaRNX4EM
 Q7t2/E/HGx2HLIMbFOKfXce3CawDwubjKiAVru0ODzgXLD+QoaEXMRgGb8RiY/hbiGKT+Pb9t
 RtZIWmwn27GsXTwetBNyUXfEAh+UAWuySsQcRD68YGylTalMlL0hzgor8u36YQdjTYnhMg68h
 VOlHrVjUS04/0hEyJ4Tg==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let's make sure I'll notice when there are patches for the NTXEC
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
v4:
- No changes

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
index e451dcce054f0..ea4a6c7cfb8dd 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12100,6 +12100,15 @@ F:	include/net/netrom.h
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

