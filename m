Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700D5301EF0
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Jan 2021 22:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhAXVoK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Jan 2021 16:44:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:36473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbhAXVoH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 24 Jan 2021 16:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611524499;
        bh=OGBt6M8IQWjiHAV/655kqYXJ5MXhTensXWSL8k3IArc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JZhWla0I3qVZrhuMQ4ZK5aVpWkCfyrJt08klN8Poy8ojhUcq/w6ceRtsU5kwnOFPj
         iSAQn4v4V1CeC1he1CWg/zIEvYMog9mxsuv1UlOt3j0rcDaBLTpnvs1ZpxaZdd6yWx
         bRr/kjtSh2rwnMueZse1GJdAfUDa6tgRuZ9roCb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79yG-1m4GA22aAG-017WPR; Sun, 24
 Jan 2021 22:41:39 +0100
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
Subject: [PATCH v9 0/7] Netronix embedded controller driver for Kobo and Tolino ebook readers
Date:   Sun, 24 Jan 2021 22:41:20 +0100
Message-Id: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f6c1ljZB7upShSxu/0hskwVEBvKfWoUUBSNBEDQza9OG2OZEv5G
 68UgdJAAYZ595oQz38pflCvOJiHHoQO9k5xYglJsYXfAHax5jj/dzFKC1uNjOROtruiW0/h
 +FVWYd6FpFQLnr1gs6/nqra/2jvTwuTudE2w0AvaJy++y0/yIPuvuekvDhahkxQRQ23ZufS
 DCY0pk5VNgquV60dMJaqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ksam/uOunhc=:8bFyoXwEst0QwW9ZT9QeZK
 DU3rTW1YjranW9PIpYlGXNxARLOAemOfkj3LWVDblCUw+KGqXKtPa0Ei/P1DyCRclbcnQmnIF
 na29e+gEwiU8Z3jdmEGrVwXMK8gHgLtkJYUlnoC+gnBc2APYbYzaqaYlPakr/CB5hrZfQ210z
 /7cZWFWLqR4Nr11byPwtuY0WewlHxSsaQiMiZh1NZ6JDbB8avs8dSxdB7XCW6pQ3duaJIG3BU
 FMv6ybe6L21tWAjDZyqZB5IBLFQ7Wm0GRNT96EOgpinGllrVql+FKgY7aspETlxNm7Sw04Y6o
 i99vz/SuY7tK81B7mIKaajBmieFDAHmkbh2gyb97a8GxilRqs3jvPwOKmlxy6afmaj6xofsAN
 ShYlIwQvz2O8fvBhK8GpLp+THXJyFy51MYtyEz7hrP3XtpVhNDBYBIyL3I23vztPJ4KYiYpbJ
 zAMsxna6PognAUvZIaQioadLx/ue0Oq88lG/Hiw4Ch9t9UuBvjz4A10doUh+xvKWFmAE2uZxl
 vBLFPvDiOoufCDsos+gm8fWrxqQlYGoOKpZn0+pZumKHuhb0e1qyn/2jzowu5jp+pjoxe1s0x
 JNmXBgakVzbDdBTOvPzwbn/PskCpXFw9ZjxWDRplPLRcsa/NhWxJ8goYBTT+/AkOh1rWP4mBE
 54630zDSMmgR2R/n1WTA+LoUw+2oDAARaFqXxCA39m990UHCsYlixzpbjo//EOsdot7d8JDMJ
 ty255LX7OHSkPejQf6htYYfys7SDy1ELKsqWXh5QIiJeeRObMRC4hiML8yclRJ8llSFjkYK2H
 OUV/hNJzIK1xUdutCGllLeHK19b6BH3wHnDbMbXXOmLDnnhRaV5EfgAMCTX+CIlGntFEoPWoq
 Ez/XNcGca78fMxFBWEwA==
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

v9:
- Fixed a bug in the error handling of ntxec_probe,
  Reported-by: kernel test robot <lkp@intel.com>
- Added Thierry Reding's ACK to the PWM patch

v8:
- https://lore.kernel.org/lkml/20210116194826.3866540-1-j.neuschaefer@gmx.=
net/
- MFD: Add missing module metadata to the core driver
- PWM/RTC: Copy dev.of_node from the parent device, to ensure that these
  devices are linked to the devicetree node

v7:
- https://lore.kernel.org/lkml/20210109180220.121511-1-j.neuschaefer@gmx.n=
et/
- Adjust the RTC patch to a change in the RTC API:
  rtc_register_device is now devm_rtc_register_device.
- Add a #define for the known firmware version (0xd726).
  Lee Jones suggested doing this in a follow-up patch, but since I'm
  respinning the series anyway, I'm doing it here.



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
 drivers/mfd/ntxec.c                           | 221 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   8 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ntxec.c                       | 184 +++++++++++++++
 drivers/rtc/Kconfig                           |   8 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ntxec.c                       | 145 ++++++++++++
 include/linux/mfd/ntxec.h                     |  37 +++
 14 files changed, 719 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

=2D-
2.29.2

