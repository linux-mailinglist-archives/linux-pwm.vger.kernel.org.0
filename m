Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4D2F8EFD
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Jan 2021 20:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbhAPTzv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 16 Jan 2021 14:55:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:42255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbhAPTzu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 16 Jan 2021 14:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610826805;
        bh=GPwpLT1TZGAzF9ivuj9lbpm+O/HMOu8CWT/rfk2UPaI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fPnVDEZbfIuTXMJ71Pznz87GMcBuTYxG4YfvJuIAbiCqmZYJNNasKw97HBsu/j7aa
         s74AuQiR+tfT+FL+0Kq/UoEf2XP8AmTndHJrEdt4vIs21OLaJ7co2qiRix5tOa/blg
         yWC6EwfTJqAztzu9Svitjewh/zay/jC50m6yyDA8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.209]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGVx-1lPqEj3vAb-00PdJO; Sat, 16
 Jan 2021 20:53:25 +0100
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
Subject: [PATCH v8 0/7] Netronix embedded controller driver for Kobo and Tolino ebook readers
Date:   Sat, 16 Jan 2021 20:48:19 +0100
Message-Id: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Sq8EerqbjWZ15AShxTA3L88ejasz3s3OzWxE+MUqIpHQ9CoCyE
 cD+Li5754+zHG5nK0ThbmZbGA7QFTMPQ2j8VuQbvXM+EwXWf/amX6hEQGOZssK6RdZgB4Ay
 BIjsrVBGx43irdhetOuYmcfKk53XaB2/tuONPuDF47RQDbRlOkp38qVHzEGWHFYKCs0Xbay
 9670XgHJtoRPvFt04G0Gg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CTmruEhhFgQ=:VTtaFXP2BB9L51574srDOO
 MA+6yYIS2+1cJbiRvjdimPEGfoH8WTG+GjZIfpIJmhhOskZyfw9Ri3VfG44TDYd7zfI2MKIfZ
 tw2D/BTShNnZPosWKS/eArbekW2PJ2f2Widz7uWjDIqyAvX2jGerWdLL+DSNMHqvpeW2nU/9z
 8wG8S+a8U+9myVwykzr71c1tjwLXjZzG8FU4eGwgZRE8fpValUnD7GUPHscUHXzAJ+s39hyw6
 Rg8bLK65nWciEFM54cZ0EQOT0vdPZYn+l1eNjb62RNjcd+czYX1SN5qyHvBZX9t8cgmgxVtE9
 HqTnBWyZaaY4Gr1PFM/Hlr+WpYbGqpsT1+JbJZXCWJPheL3ar1OXOcR8a7VhAlAj3Qkq+FjJE
 MOkJRViDS0OwFE8++i+j87oyafsgtFjBatbs8ODh8SMjj59MCfvvuXcOyRTZPJCSw5aP2zNEn
 krSSQ94WMUDXLfz8qG5mCByc/wmNdLnxnf4Kj8jx2KN6hsDlIWBqMATS7L2ews/FZzCPFX9gx
 T9CYeETWEuinIfDZ/rfffw+nIA8v7q9gDIY5cmOWaGtpqVmNZkbRcOoQH7/eDN1IOmh2syq8s
 A8V99GdlcBDjquDSOeWLfQ+r5Xxa+A7gO8iGbFNefB6aF7rPTW+JlDKLsvdKluzrWeMmXcUMi
 C2xzB0vP0DZeq+tHq8h1RjFsWNUSJGS7H1L/z/4e9QSRppX7FxJhOKaGQEAkbvBGR1VSUc5E1
 bBtRNhHYZEL04S5TUKb2m4pB1eTWq6f5Ks3luorhPpz5sj+WnZIgyVxof8FdaxhosLQciULgu
 EVCGqyXCzsafc9Grz+PmyWr+XHNwI0sucvNnfALAS9RwTLcprZ997XQSS+eJynL+0TXwAoC5A
 ftKmmuv2D4m4W8n/jR6w==
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

v8:
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

