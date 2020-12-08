Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E829F2D1FC1
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 02:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgLHBM6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 20:12:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:55055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgLHBM6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Dec 2020 20:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607389833;
        bh=c2lCCBVoa7NqW2IXm0ep6Gr7hxzbV7nLmo8Osur1zL8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HaXbRuvjOW0L6G8c17mgTHyugFAiyKMteYoXCU7xVLNEbTfrLlIMw1Ex1DZ4YH9yr
         pG3H4ZnAF/U2ZZYt/Jo6g7C2XfvBXK/+PMo7NbcY+1zI8u3fNb3RWl/HQbWTr3e0hJ
         C+bmRWU+ERWjAKzWJTmV7uzFptLyPdvh6piP1rNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmjw-1karlC3K94-00TE92; Tue, 08
 Dec 2020 02:10:32 +0100
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
Subject: [PATCH v6 0/7] Netronix embedded controller driver for Kobo and Tolino ebook readers
Date:   Tue,  8 Dec 2020 02:09:53 +0100
Message-Id: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ENIIn/3dWWFC0mU8QABx04IqRQNtlQplYarvQi2oFDUQAt2m2ut
 BJGgQaypc6cxCjKxNuwva0m90bI6EZAvWEn0p4LkHYlTjEUEah60A/UlKndmgs/NIgtPNMg
 0vVEbVt7wOHQ5Z3IS2UNoDCFTGbRc1zM/TT/0eYLCUir7UlL+Upmzu9f7McK8Tx7X1uo99r
 A8TceVMKBDLGVPsW+KhaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sNemWzqW2uc=:Su5D5oQVYl1XOWjq4lg79i
 JRvqY/9eBBz6VaKAj5XhhOb/hjNgfuSPJm0iM9/fULHe5iZO1D3oC3He/95RhSR7CCgrZgx/s
 JiP6wNXHZ/yGWBKC1Fe4Mh4L0PRM/WO6Ev7+PfFjzdWR5PkaST+ioJAq8BdL5UasoOh60c64Z
 MKtOi7IiMwR0UrK1A+3oOkZNbXEYhZR5uWwtD9do6+3Z1uD/fTjWDKvYGuxgGxQb6aNhKx1a3
 Od9ZuN+LWWiz0ZAurkxl9lOjEka8bAQR9ejXkQcNrtVkwF1XmEDnTDZSiafTOWGWuYGGYMQJM
 9c+aZq2TtTOZwHGn/1bO84LjNryA/xWiSfI2bTkDYeDzG078Q6BhQdvsdHtG5CUBfcfhCoNL2
 xOgObxJR/fjXPNt88JdBnaoS2iw1g+Im0BLOyaihw+koTjIaDedBFzorC0+zEcKxl7KqUaFtM
 5izSk1Y5n+dasZ9s27FFSBuxo8MfOrElYrkKEIRkgfm2hZYrfaL3LIFrSB94uJ5CHxeMGpgg0
 EcfM9FOXB/852eew3IsAM2xJCHF/6egla00scF5qTMqyHT8pe6mRQjLp32t7UBT+g+zuFyOti
 MwQggpF+iJ6+cLQuBchQwgL1R50bEkzhZ3oQNHaRznDbnksqkdhDu96RFh0Dfq2doS+Zn36hh
 CNXHLUfvJuINuVOn0FCvLmAyK71rdU8wZTs/QdcoU3M4WAEYf9Pj+4fiM59LT882/PL/MlsO2
 W544ZtmqqgGkbxzz8N4JXshfNe8YBtrfCdseHYAeaPZWNcDjpHqc2z/jJZLRQHnLGDLU5wcJ+
 EI7Shf32413Bd9tLUjnWeTlnAkS+szoyy/ALrbcyq5XuTSKAdnWGypl6c9Lf4+0FenAAucfCw
 MCLehzvyJ9rWmsOHa5jg==
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
 include/linux/mfd/ntxec.h                     |  34 +++
 14 files changed, 707 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

=2D-
2.29.2

