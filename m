Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A02BFC26
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Nov 2020 23:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKVW3G (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 22 Nov 2020 17:29:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:48899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKVW3F (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 22 Nov 2020 17:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606084094;
        bh=2b/jpxzeqaLVuVE3ul1wtEuNUT7aGevK/efjK6yAcks=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JvnfmawMmfuCIV4LKLhQxhM96Kj5b7InDDOLQcng2Y5m1mt4RlnYYEu0HB0Qr/bTq
         HXrFzfeutrPo7i5tUAlyU1ZRAwKqWqS3Dulp1b+W9OnJf5QudFcmu+7KNrF/5POGJ6
         czrrrnG+Ze4k6o06d55O+A6KTlP/+GlrL/ckul40=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McY8d-1k6o4Z1SCz-00czgp; Sun, 22
 Nov 2020 23:28:14 +0100
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
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 1/7] dt-bindings: Add vendor prefix for Netronix, Inc.
Date:   Sun, 22 Nov 2020 23:27:33 +0100
Message-Id: <20201122222739.1455132-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zEN6Ybp/rxr6QJ2xW71Sa5SlULigJxIfPZ1yuxgJ91bOrAoGt6r
 iu96T4pbbhmNhaqw1k1kTVFjg2PcftrSc1SURH+riGe0F0O5/xdbYqWsJoPPHWioGTDLtzT
 fSApI0sLgNTyGyIlmLTmJ0PHgjFjdoFCc2fScHLEXhWq0HB3lQ1dWNjPDeOB5uxIoR/DHqY
 eJQZCPRblPeq7+mDdoSZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EAr8dmh+WW0=:i8ty95oYQZxVuP3cZBWe2+
 oqvYIC63s+H2yTkWTZLhKiMwyKgn2k6b0Fg8O7CZfQWlkfB19ChW2YM1U3DZ+pmTke3CU8cmf
 BIihbTuGu9t5CxjAD21Qx4DNbd6Sicc0UEJXsp9dgEHVv3M26x2N6rTjxrxDJZRNGckIEY+qY
 l2iaxED3Dzj/RozWZ4bebylZiOjGtiK4aotKX3XYYMD/Pdgbx89zEVTx2ElKm64Awd1rgXylZ
 Ke+vl+p9N9anXX/f3Br+KFESUYFLnRnPAAgB42Dn+7KFikwSk8YzrW3YJIvUwXdGgCerYRhPn
 7KoP2xkDI+xYfgj4H4OEhk3CkoueqLwd54MNUu9JE6H8ebp/gV9mbnq6nRyJhECDP0r8DwNy4
 HTEcvW+gExYPqqEgXLsznbor1adjo+ZPXSwdBhZW2H3Sj+5wGlbAKm+GcOEojRnKYrAEBDwHN
 9lzsvEfi0+TEwRLyTve7lrcO0Y3mbGBP9b7zBIFxmiQc2LVBuxvhcW9tS/r9rtGsnpJdXzfVW
 dUv7NG8L5RoxYeU+wSiR6h786MB3cUjXMluyA84e+YVHswBD0NUgpntY0pCLL0TKyZQ+2vLML
 OdkkSfzy/PMztiqfRINqOf78pA+G0eoIXDJ7hQGFYavDPZfTYW3JmIqbIuG/u+VOW3hxx0OGn
 zBP+aKJmPeX0aYf9/IK53PNDgsdWVYp0cRT3FoO3jKyrTq3NyWRboqDMooZjfMH41YXVH4yNC
 R8Tzx8ocG+9VssTjwHQITB3a81i3jyvcnaRIBcC1YgX1hNmQ7URSBBbp7jLfLcAPCAcEXSwlD
 KM2xUkKMUyOTqVB15Eq5UmcxeVQIPSsgXAqan8qwNvy9496YuolOPm7UMEvHtRvC076bm5PPj
 7EjfjXGDMfgjREO75nJA==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Netronix, Inc. (http://www.netronixinc.com/) makes ebook reader board
designs, which are for example used in Kobo and Tolino devices.

An alternative prefix for Netronix would be "ntx", which is already used
in code released by Netronix. It is shorter, but perhaps less clear.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Rob Herring <robh@kernel.org>
=2D--
v4:
- No changes

v3:
- https://lore.kernel.org/lkml/20200924192455.2484005-2-j.neuschaefer@gmx.=
net/
- Add Acked-by tag

v2:
- No changes
=2D--
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docu=
mentation/devicetree/bindings/vendor-prefixes.yaml
index 2735be1a84709..cbf28f992b71e 100644
=2D-- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -726,6 +726,8 @@ patternProperties:
     description: Broadcom Corporation (formerly NetLogic Microsystems)
   "^netron-dy,.*":
     description: Netron DY
+  "^netronix,.*":
+    description: Netronix, Inc.
   "^netxeon,.*":
     description: Shenzhen Netxeon Technology CO., LTD
   "^neweast,.*":
=2D-
2.29.2

