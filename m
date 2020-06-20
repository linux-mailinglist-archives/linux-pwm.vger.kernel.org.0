Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C065A202710
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgFTWku (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:40:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:54137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbgFTWkt (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592692778;
        bh=RAGt25AVvKDJqw+9yrZ6l9R/dNd3yaSsWc/0KCEdEok=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kH7Ei4ieh2JUrr/ROU7TdjAoSKb+n28ITwkBr9SAprIfWshyAfYhOJNu6oYRcAngU
         40sLYvte81TXLuxXRbH3mLQM7TObUZdEM9VF4h9jg5ctm424S4ime1otN9Nh0Phs0v
         cAHzgEHuGLfDyaPRSYvJdUdLaF1XR7EnaHDlRpJk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1ioF2D3RyW-017Qzr; Sun, 21
 Jun 2020 00:39:37 +0200
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
        Andreas Kemnade <andreas@kemnade.info>
Subject: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo and Tolino ebook readers
Date:   Sun, 21 Jun 2020 00:39:04 +0200
Message-Id: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dB3zkFm6Dp37mtCsRvQnO4dmzEkVo0+p+QNR4wonzzE+gE8OPo7
 a/51mlxEjTz9/maj1H88yYo34qY3L1M/CIyNDHBBzdIb/9rkmSm1TdnWS2/gK3n6uLuM9xj
 vcykaFX5b7WmGtn4RyPj7JEtQyzIkf7LfRByhtJc1hj2ux0ztZimykMSIrlkanH0q3MZm/V
 L6WuFVU+gAYKtFYZFod/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e7qQ6lwVSYM=:97UP3ASFO3a8AXrXwwpeVd
 KopbwNa1a1hucFz8HTDIO9Qzq/NcOHCCkhxyGCLWZN+5MsNrJ10BYCoKd2MYRxvEyr/VBfD3P
 Hyb4neb64b730uhOC8/iH0W16QsTYFmy6ZJ0OEp/bzFdpbkNvAw/khtdLXhzFN+2gqi/u00aj
 8hr+1WHq7TWmMy7HXgMufbOBIhxemUC4/FSceeFgTg7hUEa6Cz4xu3Yc6Fzu92d2iDBZbZ4MO
 DGLXX8yVtwciFUE2oBf1VrsSDHf5CpB/SWdBqfYGKGLVjSXgtKbhO17cp26BShwZ97WtlUGTo
 z9GeoyO7Hl2PmMyOt+TLZ0z7c6BxXLl7YK+HsdAj0gSk7bO/lRwh4QLESNin1UpKYeHMQx225
 h07qL05/jMS5+HiLVNCwrK5qc3nbdVi9fJyNDdt0p4ilaZTy0pBKMfumQmFcDTaJct6TbEvUa
 UXq7dP2w9MN+Mak/bEa/vlDBEmNswH/lmM41FghkhpXxjKEqLprfVjuY4W1fWO6UeLws8ZSqY
 u2vP9TLTg+3CeeoFnMbYfNKzCwcStQ6Jp99u7GA5qYPjgOQUxgJOkuY9DxCvaz1evFNicWZDf
 PEBMN1jQ5nyUZw28JMl/SgwC6WOCeucySG7UAXKgOdSkpm5aUXrzRwHWEpqpe1xNNnrVIgsSQ
 n1b360e1sT8+kaS3U4O/w8C0hwjIEnYOP6/XURX+2caOGGio+a6+8ccVIpi63udwXnllVbaIN
 8GbMaYPH0AqCKlQeBaQDZpE2URJdHvARFrrlfp3fwjaSt9jYMiXSl8kxfq7Lkmv79NeXK4mct
 s2cjDkM+BWTgOkW2/lCxESXkm24ucyTGZlW8jOi8TyXlL3eZ6DO8uu2xLQpNDZYgeokYj6gMW
 VDH1fnwKv1yVw/jEWD8Cklv40M9SLmKrbOBxYsqqtbU/fSLygXAGxAp+k2odCrxmLYxBmDbJi
 LPZz5x//lgtcWHcTtXZYkd5JghBHjdtlFNm/0QRMrZwQaUWnR66ZUXBBl9kfFNFZ4YAi/uwqW
 J6Cup1je6gVahK5xbtHWOIYeDWFe5AGt0IiefzW4tGEkDBmn7Qb4SBG4ZANfZoctXwHut81Zv
 /7rc6sdWkEJYcbXVpWqeXG7Uv3zdq0TRRjKZtepINKWOXz0PIsW872W67v8rWhD7I9rJePT3L
 C/lnyDVWj8vLZdfbXlRN0zYlukiaJYGd7X+ynCeNzWOkT52sZgaP4V8KALz4KijDNdt2EA2Ft
 Mnhcu4IDQHqEPh8Hi
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

This patchset adds basic support for the embedded controller found on
older ebook reader boards designed by/with the ODM Netronix Inc.[1] and
sold by Kobo or Tolino, for example the Kobo Aura and the Tolino Shine.
These drivers are based on the vendor kernel sources, but in order to
all information in a single place, I documented the register interface
of the EC on GitHub[4].

A few things still needs to be ironed out, hence the RFC tag:
 - The reboot/reset handler in patch 3/10 calls into I2C code, which may
   sleep, but reboot handlers are apparently not allowed to sleep.
 - I'm not sure I got the YAML DT bindings right. I have also included
   the plain text DT bindings for reference.


Jonathan

[1]: http://www.netronixinc.com/products.aspx?ID=3D1
[2]: https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-co=
ntroller

Jonathan Neusch=C3=A4fer (10):
  DT bindings in plain text format
  dt-bindings: Add vendor prefix for Netronix, Inc.
  dt-bindings: mfd: Add binding for Netronix's embedded controller
  mfd: Add base driver for Netronix embedded controller
  dt-bindings: pwm: Add bindings for PWM function in Netronix EC
  pwm: ntxec: Add driver for PWM function in Netronix EC
  dt-bindings: rtc: Add bindings for Netronix embedded controller RTC
  rtc: New driver for RTC in Netronix embedded controller
  MAINTAINERS: Add entry for Netronix embedded controller
  ARM: dts: imx50-kobo-aura: Add Netronix embedded controller

 .../bindings/mfd/netronix,ntxec.txt           |  58 ++++++
 .../bindings/mfd/netronix,ntxec.yaml          |  77 +++++++
 .../bindings/pwm/netronix,ntxec-pwm.txt       |  27 +++
 .../bindings/pwm/netronix,ntxec-pwm.yaml      |  33 +++
 .../bindings/rtc/netronix,ntxec-rtc.txt       |  17 ++
 .../bindings/rtc/netronix,ntxec-rtc.yaml      |  27 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  11 +
 arch/arm/boot/dts/imx50-kobo-aura.dts         |  27 ++-
 drivers/mfd/Kconfig                           |   7 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/ntxec.c                           | 188 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   4 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ntxec.c                       | 148 ++++++++++++++
 drivers/rtc/Kconfig                           |   4 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ntxec.c                       | 115 +++++++++++
 include/linux/mfd/ntxec.h                     |  30 +++
 19 files changed, 777 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.t=
xt
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml
 create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-p=
wm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-p=
wm.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-r=
tc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-r=
tc.yaml
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

=2D-
2.27.0

