Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE492F028D
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Jan 2021 19:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbhAISFT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 9 Jan 2021 13:05:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:53571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbhAISFR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 9 Jan 2021 13:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610215372;
        bh=GshT6Emj2YPd4xDlfNg8v444oOEqvQ7VPXB25G6wNjg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ST/NLreBMxyp3rs0wQyPO8T5jXl6de4euwFAOyNHsdPUil/tvCTA5b7hU2IRjhLC2
         NFU5TE34tu0HCpZbdO59nbcRUbV3XotSLzebrJzLAtq9V0xpn/JAf/Tvh8zwG1Wb4B
         z6XSXWNGTHPKNSLhPi5r2kDOWn2MZcv/9i0+JAWE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1kKa2l352O-00dlrC; Sat, 09
 Jan 2021 19:02:51 +0100
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
Subject: [PATCH v7 0/7] Netronix embedded controller driver for Kobo and Tolino ebook readers
Date:   Sat,  9 Jan 2021 19:02:13 +0100
Message-Id: <20210109180220.121511-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PpsWGt2cJ2vTxq46vyyclCzBKkk9EFV5FUbpr9tDhdVWQPdDBWy
 sLYlF1q/j78lAA7uI64n01A5VNRR3dPyWjtOq3zUMvw9y3J/Uoal+O0IESEkhJCvbZghvqB
 NVQJ7NOduA2MAOiWM9zuBnQCTfBvpSR6KXu84SFkxVywlWa3UTORO5MlpCnBEt16SedwKuV
 wUhpyhJwuriv2nN6zSSSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NbWmK64jiis=:A2NkSQOAqPUQo2ba7pYZs0
 3HXT3+nzeiRSKIHJKZN1D8M/fUNKOE/kziqOVujnV4i2KGoFmNcD1nJia0qoKLvONKIQbyL5p
 LV+9YZsqIEIigKsmL7NZhKcG0xx+r2F8SBZ6WWKHBqf7LLyG5JnUV8SaGEVFgjNWBGJXEkz2O
 53eusRgy9LNpfzM7UErM4TBqe5Oh7a+HGpnSxSPWfq7X4TgZt8xKXQ6jIBJxRi0uZoKDUmBfW
 uqEpZWS3Onf4O52Tz0o9IXcHFYai2itL9Mzi+X1GiCx1I8smbY5OFvoDz4csdftiXyMXUPNiw
 FRf2TIBIhLDyekQM9qZSmTzysRvBTUkV3gYPzoDpN4VDabTwJegiZ6LGSRV37sUkao7eT5M35
 KD+UFbt8gCvGKpx/yaS8ChaxdjkNBjYE5uHCM+rvu8fw6Skslyhh3bMPr5oLW+bkqsLp815g5
 7QXlp22GJIfCrLvIHkxE/Kpvq77K3icoV0D5vp1v96kVgM+hzeKyq5KWdMcBARj7ttGJrEsW+
 O3C7NWmAeqOZYOHuRvW7iZvCi7jHCJgRWh0cgvgh7BpO+yzfCIVJgdiBbE1qeuUxOCFMJMZDt
 5KqC23Yft0Ag2pPD8uADEgc/S823kWTgdryiFhsfNstEbGhvRjMozm7p0NpRuQhM3hSe2sQqG
 akJXhd7wBl2ciqoii8fX2eibd7z7A0kpXrtvYjwCukwQoMD31CSlNZky8E7fJP04n4inPJlsK
 gmaT8WHerihM1wPg8y526FeVN5x8/6bnollzQA2ZEaAJanQlEasBo400NdtgCjyzzstEkDdoA
 ydrfGwCzK/mliYE8iCzIKkaPAdFw5zXFMCZ9FWIMNiKoMSUisVdSqaWLqbU4GTQcJaa/IhwfA
 Xyu30HMHUusyR0rXDrAw==
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

v7:
- Adjust the RTC patch to a change in the RTC API:
  rtc_register_device is now devm_rtc_register_device.
- Add a #define for the known firmware version (0xd726).
  Lee Jones suggested doing this in a follow-up patch, but since I'm
  respinning the series anyway, I'm doing it here.

v6:
- Additional cleanups in the PWM driver
- Added Lee Jones' ACK to the MFD driver patch

v5:
- https://lore.kernel.org/lkml/20201201011513.1627028-1-j.neuschaefer@gmx.=
net/
- Avoid truncation of PWM period and duty cycle to 32 bits
- A few cleanups and additional comments in the PWM driver
- Use regmap_multi_reg_write

v4:
- https://lore.kernel.org/lkml/20201122222739.1455132-1-j.neuschaefer@gmx.=
net/
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
 drivers/pwm/pwm-ntxec.c                       | 182 +++++++++++++++
 drivers/rtc/Kconfig                           |   8 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ntxec.c                       | 143 ++++++++++++
 include/linux/mfd/ntxec.h                     |  37 +++
 14 files changed, 710 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

=2D-
2.29.2

