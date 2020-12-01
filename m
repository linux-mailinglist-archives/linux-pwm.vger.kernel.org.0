Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300CB2C948C
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 02:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgLABSd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 20:18:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:34545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgLABSd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Nov 2020 20:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606785355;
        bh=mD0Si5W49evwADqXMAI9/Un1LBCPTBcDxQlGOJrxn+g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bzTeNGFSNBvYoVCNZ2QIQpDvSFOpk5YVXzIIepsg0gYvdAfglsEj4reL5k7dCGXtM
         yc0cHM5SaFmJcDlj/+2GJiS9ZkvaO4ZTswUbjRsoStFc9TUYrRmpX5SK89DPyQqmy7
         QvcWpHJKUi/8r3yKziP4FZHA6MPV6DEP76WkBYf8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKGP-1kz2R80npR-00FilY; Tue, 01
 Dec 2020 02:15:55 +0100
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
Subject: [PATCH v5 0/7] Netronix embedded controller driver for Kobo and Tolino ebook readers
Date:   Tue,  1 Dec 2020 02:15:06 +0100
Message-Id: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SX923n3QBE3V79LeM2lq2SqSH46aAJ2pp9lz28fvewY9IxFxeum
 tIlpd4v6DpGfzWKWtfuGqjC8aOqs8k8zHIUMm5ohrLHV/V+p9ik5AeNb1+H5VlzG7RxLh6o
 MRRnQA6qEc5dzG58N4nNHIUGI1R6WX/DA5VRmNp/1qLj8qAt3Ib5eBbWzqUcIGmv0QpENY6
 wlOh0zbRFEFgHy+hZIJDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bvndPoRiDog=:XjqbPRvTdzaE3VMzEp6pW6
 KyYdfRIs8iSO7faGcBMo7mnh1P7GCWPtlkWgT6p7l86fDptWXxYRMSn2zD9yYEtZpx1JkgD3O
 ictGk1EDF3a5/3Twfe1/qzk1Gol7y8NSV5M0wan0uz2sSnavNjvTRUloyB0pl+nI5t+wPyyWm
 fy4u4Sueh8obE2zamTRx/+pwzAxWGL/Q4tcfg6usqmVtExbRmEo8KAb+tM0lfUdaoCdqSaHeU
 9sd7RITBsFIzprN7A6dHFELpodJNrIY8CVpDWMA3gw3Rsl3OK7iy/UZwNWgbD/q5wfgKoYO4I
 jBx7Eu+97n15tWkPJvcbCJZEiXxtcoxU9oFIFEJ7YnjVyXBSQ6mpIdtWgVyR2WJTgbZc88Iis
 JbFwEEehGcZPV5sXoti9LEbIJyhHnUauBaEsaRULn/HNyDZRlNVn5Tqn0pP6FN9oEBTd5L16e
 vGbzyaC4GvprTD5OZ8nZK0wmbKTohGtkk4lvcRSG1xoZfMkAGxh+eZdg+0ToDmoc2NdTX25pA
 Ypfnt2Px73JJNh7mRuTrYI0U09ZL0WNbqbxgQQ/MBFKWQYxUa22M90Fzb5OUndYfQXJd5bVpT
 mZsOWse/zBgBPglsAR6O7Vc0Vcos0Dsp9nvp3mJglobtJJawk9o0DG0Zaa+bRa/OPys0NQw4U
 1RP1jqTD5xTd/5B8RETDkqJMxcY0jj5hH7BpkhxALjqyJDy44lnpPajnQYfZRFBnloO70PGUr
 y23sSY7lMi5jVjZ4KRb4Psmb7yJbXkjRvrySeLHCATTITbW+oXq/mx1ps0zZHA9fVbGVdE76z
 ZYFnxQOk4aXwpl0UKCwdY8iApUDFdwsV5PqDuuxf2I/9dsi2zaHWwym7Dfk0H1artAdnVc3Wm
 sO8D/Osnx7zUicaov8EA==
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

v5:
- Avoid truncation of PWM period and duty cycle to 32 bits
- A few cleanups and additional comments in the PWM driver
- Use regmap_multi_reg_write

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
 drivers/pwm/pwm-ntxec.c                       | 173 ++++++++++++++
 drivers/rtc/Kconfig                           |   8 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ntxec.c                       | 143 ++++++++++++
 include/linux/mfd/ntxec.h                     |  34 +++
 14 files changed, 698 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

=2D-
2.29.2

