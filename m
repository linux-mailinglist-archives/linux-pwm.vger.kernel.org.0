Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF12BFC27
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Nov 2020 23:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKVW3C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 22 Nov 2020 17:29:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:57009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKVW3B (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 22 Nov 2020 17:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606084084;
        bh=dtj6W0yQf7os9N3ERREUeHWvsknYOOEdVVmOyejekNA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=h/GRGXfbBiL+/lpTZgwrHt3pZF/wodtFXaF3v3pamkHQXUYtg+kXroip+WtBglXds
         6lt5NC1hw30gcZr2B+GBzil7Zx106IaNYNm95Kjs1y9f/gePqtERCzAcYEKktgIR9u
         9Sq+HsA6lP1NdlG0IAZ0BtMJHOhRooNgiusf3FtE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpNo-1k753W0XfG-00ZxeN; Sun, 22
 Nov 2020 23:28:04 +0100
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
Subject: [PATCH v4 0/7] Netronix embedded controller driver for Kobo and Tolino ebook readers
Date:   Sun, 22 Nov 2020 23:27:32 +0100
Message-Id: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9fi5cn1W4wIcwCMcrpIiO4wYE9TOSPxMlnZh0pqNYCi6ZkuOZOS
 FpNAVw0/CXpxZWSb9uyyO2BbA8nftnwSgEOfBGfQw4xNwEBM6wtqce3lmyvErhqhmyJiiuI
 rb/ylvH/d+i9pw4rrm8+DyYwhbAkVtu5zv/lF+C9XgM78YSLIvRwqnDbBRXuZRsO6K2dHoZ
 a5+vhcgSaapQh/eTPVWhw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:70fq3pGexNk=:VsRFl5purtQlQ5PHwaSKYR
 GLKpzbG+q7Ce+cUt3+XDjKktTLpgKhCHmjd8MDuqkP2uFCH6mxilTAteKF/Up4mL8Q61Tx1Og
 EZ0p94NeilOGJWsUwznmo5G3/CkareGLT9WJEtbziCqsuLYsq7thR0CNm8D01gmSQGiEI7bKu
 LRA06rv0f5CPlEMcOmROEVbvt/fo4pOyv3HFCdu5dVBoym3X/FecGEohpY6Ffq8seNh1Q31So
 qNGEM8GQ7J3U8PXcYg83/c1JAKIWag3DfKLOCWDInhzPAeOD18lkx1GynT9BMndCXedXCzZQY
 EcGrye8feArmieWZwEdHnvoCmuORJyzYa6a8Vumgt97gQ+G3+fNEf5GJhM5garEP/gvDVX0Vk
 gXQhpyp7g5KHSA3uXKmb0wYSmWfX+Vm1tteOBq/WNVzgmEDDFD4P6tGpJ7y6fkCJSqVgOcX03
 1iHLR1znUH/cEArRTO+cGyc/LaR+WoAX71md1Jh6xS96j0r0InLPCpJ6M7h9c6uf69DeXR6hn
 qewxhdzTysc0D1Yzcuo6gTANmgD1cvCZOgwI8UsQfokY8azNRfMU3D9KiRIjTTv86FE620ODf
 51i9rm9Y2NTovwyl0K4YWxpxNOaGQeFuyyjmy3v+qwLjeJs0ty/4qR+tmAc1YXf1qu7NSDdsH
 Xleq9QaWohOnrO4eUJ7hKJL78vTpphd4ZULT4C+Yprr2buYAsBP14ZbMtVqBGZzI+r9N9bH8J
 t8uWbZmhg39hacvZ2vfXChlSUJWsgRxn/1lxsPnaYmx7WweGjdt9Hlk4iyDNAPyyHGVZ4cPen
 0an7RqIWBWF5mNMxn2bGp7vlKRlGAlmf+5fhmvgKuGmbFEClvihB5iNWEZJyOse0XSPchix1X
 OcOISfXqyyOwTS6iG3+Q==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patchset adds basic support for the embedded controller found on
older ebook reader boards designed by/with the ODM Netronix Inc.[1] and
sold by Kobo or Tolino, for example the Kobo Aura and the Tolino Shine.
These drivers are based on information contained in the vendor kernel
sources, but in order to all information in a single place, I documented
the register interface of the EC on GitHub[2].

[1]: http://www.netronixinc.com/products.aspx?ID=3D1
[2]: https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-co=
ntroller

v4:
- Spell out ODM (original design manufacturer)
- Solve corner cases in the RTC driver
- Clean up use of log levels vs. error codes
- Add more comments explaining some peculiarities
- Add missing MODULE_ALIAS lines
- Various other cleanups


v3:
- https://lore.kernel.org/lkml/20200924192455.2484005-1-j.neuschaefer@gmx.=
net/
- A few code cleanups
- A few devicetree related cleanups
- PWM and RTC functionality were moved from subnodes in the devicetree to
  the main node. This also means that the subdrivers no longer need DT
  compatible strings, but are instead loaded via the mfd_cell mechanism.
- The drivers are now published under GPLv2-or-later rather than GPLv2-onl=
y.


v2:
- https://lore.kernel.org/lkml/20200905133230.1014581-1-j.neuschaefer@gmx.=
net/
- Moved txt DT bindings to patch descriptions and removed patch 1/10
  "DT bindings in plain text format"
- New patch 7/10 "rtc: Introduce RTC_TIMESTAMP_END_2255"
- Rebased on 5.9-rc3
- Various other changes which are documented in each patch

v1:
- https://lore.kernel.org/lkml/20200620223915.1311485-1-j.neuschaefer@gmx.=
net/

Jonathan Neusch=C3=A4fer (7):
  dt-bindings: Add vendor prefix for Netronix, Inc.
  dt-bindings: mfd: Add binding for Netronix embedded controller
  mfd: Add base driver for Netronix embedded controller
  pwm: ntxec: Add driver for PWM function in Netronix EC
  rtc: New driver for RTC in Netronix embedded controller
  MAINTAINERS: Add entry for Netronix embedded controller
  ARM: dts: imx50-kobo-aura: Add Netronix embedded controller

 .../bindings/mfd/netronix,ntxec.yaml          |  76 ++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   9 +
 arch/arm/boot/dts/imx50-kobo-aura.dts         |  16 +-
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/ntxec.c                           | 216 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   8 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ntxec.c                       | 166 ++++++++++++++
 drivers/rtc/Kconfig                           |   8 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ntxec.c                       | 158 +++++++++++++
 include/linux/mfd/ntxec.h                     |  34 +++
 14 files changed, 706 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

=2D-
2.29.2

