Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5925E7EA
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 15:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgIENem (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 09:34:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:35183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgIENe2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 09:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599312808;
        bh=rvCCbE4pID8W9dS94D/nwDcZnqQFH63RXYcvweJTvUY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HciZmbaGZOejIIDSC1Bk5MATvt9k/YY5/oVSWFWNE9F3eKSSIsdWWA/zdhht7GehX
         QXkVBUB1fhW9hexr79f+Ggoh6PUxG4+zd5cyVLY9Skpe2x8nGvhhQs8Rwwt23kl7z3
         74IjlW7pyP9nVhC5XPzt9xcPTS9JAEyXZHBWkR3I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1jx1T61wDw-00HiaX; Sat, 05
 Sep 2020 15:33:28 +0200
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
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 01/10] dt-bindings: Add vendor prefix for Netronix, Inc.
Date:   Sat,  5 Sep 2020 15:32:21 +0200
Message-Id: <20200905133230.1014581-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L1lxZBEqC4oQRcYC8Ye2ZaSaJiFuYq/v3pYJeYuD9nVH2S8v6fg
 TKjEkhmqkWVW3IoB9WuytdxC+R6Zp5uPAxzEe4NoNkOsvQ6Vz7hexOC5DSlCVrsNs6obqZQ
 DBiudNkvyYo8GNx85RyEMBgfdK2AnCMR6k3W+dq4O33c8SGRdBNomwa99tVFh2rASqwpLGL
 H5AXaJdvAXEAtos+UDa7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zv2w5A5nZ7k=:LFdqtJL5il7MuSKPb3xe+q
 navuPcaouVZmBBpxFabdwAIzjmgwNZhXCi97UgpqrUcBuwEReQO9xVcmN2c6yiYR7oUqqU/OT
 QHrvUdbePo5tZi3MSy3uDq/ntER0xBXAkVLIAug7GM3e+YIOnZoMldMHb6QVRN95kH9kctPCr
 BYnpQ4PDFL3FxLKf9pulZIlrSqkOazyPtiNXk389ikM9tSurjXIqnpH3t9rNWD8bfjtdO0HyX
 zN8svXK4ROy1mzLI2YEHI9sZ3IZTlxFbnPppZTIddd0y0TXg8MJyrqn4zFiTRBT7+j6RVdDqo
 0goP/U9mCRQuAq1dI5pW7r4+HKcZ9Cgb+Kzv0x2CqJIywWiSV+YX6/Kx/wWtqCMqQUPfGwxMS
 2+EG6fgluljbVRAOt4kZ4yyCFBLVWZmdpfejL265SnxyB2GufbB+PXs1Ory9zuPvpsSue2N3G
 Zk7/bdukRVX+z1Rh8KsfMQdzxib9OI9V3k76LaNF3Jx860iNuK0zfElF51bKWq4Ybt98r1Am1
 mxulXua1iL15+kQAhISj5JwJHk2kRofGw9y5Y13mzZpNevN4rPAy4wlreBGaZwrXOPIZmhykK
 laD9Hy/qN0tV52xMzyoD4+SFtjPUActonqCm5zf5nc6nq8P79HSphCE223iZs+kEvYnTTshp4
 na7EeybCf6dNZcEXI1HYnhPgKpY6osmNEs6cbBd4o6yxOBx7cXuAKP46xcxuEytpsSso9/mjm
 8yu7AQAjqIMx7H3TPOIt+7l6PQ+ZPlvX1d53SwfLACpoTV8Wq21WQVmteBz5qjkXDGVRcePpG
 9YCX7HC3UpLUOgX+bIE935X28PSgLAyvFE1YxPkG/vSWh+Mo+CnRYfQgcLbkHIx6O787c37Md
 HFkH3djG0oPC9yiJ2Qg90JtblEOWSzX7vQNhUxwoKz7N0/k8AZXVvLBm26Wn5ZyMS93mBXZtM
 4mpZo9lIDU7X/05fldaVRo4uzGqVSnMAVrgT5gLuySW8YXwXeMgGao4Ib9V+Q4wBOJTZuWeEb
 0NWdI6tUPCoigcI2mP5AsdTPZJ+w/tgloJtjxdT2K2q+POpw0juHpNTXkp2LvGf5LOojY0eD1
 ggk65v89rtgiJ4j0cfrlyvleKIKKoDBq5hfU6D8uIqQQgxRjMZ7BfBHysYSkhsBoa7zcKsmmO
 JK/Hw5nZ0Lsv/+nmjvuLjEDeQpXD62/Ursp8CeY22tjOwHGifHucP+cY1zlPIcMs4rbZPx1mu
 lUHWn6CPXDEac3Yc2YvKRaTauw/ChZyGNEq0bYw==
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
v2:
- No changes
=2D--
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docu=
mentation/devicetree/bindings/vendor-prefixes.yaml
index 63996ab035217..fa173802000a0 100644
=2D-- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -712,6 +712,8 @@ patternProperties:
     description: Broadcom Corporation (formerly NetLogic Microsystems)
   "^netron-dy,.*":
     description: Netron DY
+  "^netronix,.*":
+    description: Netronix, Inc.
   "^netxeon,.*":
     description: Shenzhen Netxeon Technology CO., LTD
   "^neweast,.*":
=2D-
2.28.0

