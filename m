Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF6225E7E7
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgIENe0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 09:34:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:46607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgIENeU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 09:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599312791;
        bh=X1JDHzlfCU+ENBN8/vZv+W5ToAriCbagxrRnZa4rg4o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kqdI1zVLoU5y3EfpwgRA1BDh4J0yUqBLRGr4sWg+olhwiwry59OqCiN6WnYbOeCFa
         SnhcPcpXkC5dPR6eXqAXZ2h6CVrwraE/9nc0jqVv1hV56Pdl7x/nO89+rHJ7pI8qz/
         wOaha/I05g5I2D90hV7ygGFwrXoMYEljsc9neK+4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDnC-1kQ9Av1Vug-00CfCO; Sat, 05
 Sep 2020 15:33:11 +0200
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 00/10] Netronix embedded controller driver for Kobo and Tolino ebook readers
Date:   Sat,  5 Sep 2020 15:32:20 +0200
Message-Id: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:62bYLLM6POKbq+fOwuftSVMbihyuuRYmQtF18cpq0SrmlLm0khW
 5OA0mdlU64S2+frZGjmJzDs/OoG19cGkL5pmLCv0o3zX49yFoC/PR22iROGxQA5hb7fYVaA
 nhmQN+3Qvy+JGI4L/uvQ6ihKJTWSsWNze3rIK3YTLKKCS50ahtCGR7bNNVJA5Kb7fXRLDBv
 9mdRHu0y44h3vUJR5lhog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fg1zqR7bC9o=:hie2Q9J9itFryKJun2EHb6
 w26FfeniqaZ9EH+mb9+9d3wreGPWx7J9rfuJ+LjKoRI4Yn+hlUOAn9LVRlajPVwHJxSH9PewR
 fazsTWPLE6pUzHYhks0qaf9hskxJNOcbbAYRKS7ekah5J+V3Th4BP+3f7VwUGmBhf5Qsc13Cs
 uUJfwBcanZ6nRamOZ6v+0gbw5chkTPjdGH/YUTeF0d7WTArIHn4SK4B8t23/N2nhfT1hcaRCr
 k3q0NzHBOR75cITlj+ORu0qkcDy/lanjoMn1VWaFKXOUpSJUc8HDpvXZVjchUTG8WkKSSIf8Z
 wdv6ncOhGg+TfeM0f0i0WWENbnkBxs4dwtgpYJ2Mtj+mysfJ4W9ii5KSkKlLZYNieA11zFmNA
 BxGN+hH5Dkp8xBj5qpQ8E1MU1nw/TNB8dzP4J7K5fsKnK2pgOrX9+5l0nkUsSHbqJzgZV/gPT
 cGvlLhW6kSZfpMK1jJk+l1JP1gGTXZRXMMAlfGsXsyQ/JLni7cNZQwErLjnnEMpdNZ/62cpt3
 xxSFB/Kd7LbTFtIhHpE8Fh8nJ/7YpSIqLPGXxa9LBoB1GW/upN9X0cWzmKZJ7kVlPbP2oOv0E
 XAigo+BI1DKJ4eoFghw4J2ZTLcvhgYc/hG5T5FHA6CumfuAtoPlwuKfk7ka7ufHQUXvIYqt7F
 BzKhIYp5icEE1VQQzzxbVVDTMwkyNOjcyOKcma9knTjVgvtfwbWkFpR7pPhheAtVG3S5GoOqE
 ZvDr09N8PgatP5Fum41PORDcQxVRRhICdvmS2VsbSORW/5tIXSLF4pG5WGNKktQU5eoZIsWtS
 U+0Leuyk7MbAqrUeRAHUtun4C+SiCgvQPhsCSJ1eCNRu9Rx51y9qYD49iSUxOB35HYM/uIT1y
 Fux+dOO7oswgNGbSd42YFMHkmA7ZvFbF7MITkUdQlKRErHTb6xKuyhYmOTPg3WrCLKJ0nCM+X
 B38srR3CQgacumjKwVBmEO4kT3K50iIqi4laehetl12YLyIpasa4EocSMtcU+dEpTX/UVKXEu
 JHSWT08FnxAiuIsHoTGsKS1POxJTRCbP4i5RF2m6BN3RKldJHlVr47cfTT7cUqnPcWLKyoz9P
 A6X3hEzItB1YOtII2q2MTCP51b2tSClbvNIPoWdn2HTYkY5l3ODH0qqrSQ4JunZxUupnzg1D7
 fLdF0Ddzx7so9MVwDVZmTHDW+MG0pdlIGzBD3E8GWYiW1FBg2aDuva5r3xGAnZ8JeLj8ifVim
 YooW/KrRY9YRC1xGBbLpqySBih66011jGmTCTcA==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patchset adds basic support for the embedded controller found on
older ebook reader boards designed by/with the ODM Netronix Inc.[1] and
sold by Kobo or Tolino, for example the Kobo Aura and the Tolino Shine.
These drivers are based on information contained in the vendor kernel
sources, but in order to all information in a single place, I documented
the register interface of the EC on GitHub[2].

As previously, I'm not sure I got the YAML DT bindings right. I have
included the plain text DT bindings for reference, in the patch
descriptions where they are relevant.

[1]: http://www.netronixinc.com/products.aspx?ID=3D1
[2]: https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-co=
ntroller


Changes in v2:
- Moved txt DT bindings to patch descriptions and removed patch 1/10
  "DT bindings in plain text format"
- New patch 7/10 "rtc: Introduce RTC_TIMESTAMP_END_2255"
- Rebased on 5.9-rc3
- Various other changes which are documented in each patch

v1:
- https://lore.kernel.org/lkml/20200620223915.1311485-1-j.neuschaefer@gmx.=
net/


Jonathan Neusch=C3=A4fer (10):
  dt-bindings: Add vendor prefix for Netronix, Inc.
  dt-bindings: mfd: Add binding for Netronix's embedded controller
  mfd: Add base driver for Netronix embedded controller
  dt-bindings: pwm: Add bindings for PWM function in Netronix EC
  pwm: ntxec: Add driver for PWM function in Netronix EC
  dt-bindings: rtc: Add bindings for Netronix embedded controller RTC
  rtc: Introduce RTC_TIMESTAMP_END_2255
  rtc: New driver for RTC in Netronix embedded controller
  MAINTAINERS: Add entry for Netronix embedded controller
  ARM: dts: imx50-kobo-aura: Add Netronix embedded controller

 .../bindings/mfd/netronix,ntxec.yaml          |  83 +++++++
 .../bindings/pwm/netronix,ntxec-pwm.yaml      |  33 +++
 .../bindings/rtc/netronix,ntxec-rtc.yaml      |  27 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  11 +
 arch/arm/boot/dts/imx50-kobo-aura.dts         |  27 ++-
 drivers/mfd/Kconfig                           |   7 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/ntxec.c                           | 216 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   8 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ntxec.c                       | 160 +++++++++++++
 drivers/rtc/Kconfig                           |   8 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ntxec.c                       | 130 +++++++++++
 include/linux/mfd/ntxec.h                     |  24 ++
 include/linux/rtc.h                           |   1 +
 17 files changed, 739 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml
 create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-p=
wm.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-r=
tc.yaml
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

=2D-
2.28.0

