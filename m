Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA4D277933
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 21:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgIXT0X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 15:26:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:33775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgIXT0W (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 24 Sep 2020 15:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600975511;
        bh=xvKpT2sSHqHPJQ8jydYdVwKtyMXMEaIf3CKJyHKFaRw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Htfk9GXZjY7fVSEmBQn04kVLARb4ZcqvPGBxFmbX+YStHjRUmygQfBQDrt7TtbX5r
         epSKEZquIUummXF/eNdL+eiUDR+6+PQloJcd2MpSqtL8oOz+5bKDQ/H/YWs0GT+8MA
         nNleSZ/jngF2Zwj0IVqKwWxWQmuEeH+khudWRMZ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1k9POE2uxI-00CBUJ; Thu, 24
 Sep 2020 21:25:10 +0200
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
Subject: [PATCH v3 0/7] Netronix embedded controller driver for Kobo and Tolino ebook readers
Date:   Thu, 24 Sep 2020 21:24:48 +0200
Message-Id: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IhDg/ovkn5AdYA7QuoVxKZ58LTbWLOf0Gah9TeIWVC5P5Vq7OX+
 rTcniKqkXxZ3MF+cRtLPxh7uQhf3icDZtGW60DLHKALB6ONkAGSL3t7gVs0IjaFJvuZfoZF
 /mb10k0XVoKRCKwfHifoifIta0u+xcYK/opArVe6QFKfFVz4g5ytFEAXaLQKd1FC1r3joOC
 as9tTuGSaPcybtsh4ZdeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f6IDfeE5Jkc=:5kOe0vkfJKlzW3CSsC29Fn
 gAFmnVt9zsJ3NNLHygMRyhZM4qkb+buYhuRZCvoR2qkcE8RpOzkt93dUDqD17xXqo+0Ihi2/6
 KLD/UrrB0pPbuipdg8k/F3GArktjxXcZ4rTKpOyj2kvcpRAAPty9YNx/Ef0pd+pJQ1yX8Aeaz
 7LcOBt5Ol0rWjA7ZIVTNf5AXZP38AH5I5j+2X+SN2n9G3prNXUMEMK0uFzQ1k2CfKAboOijqj
 MovrdnPkkdF1fWDn/Cm3nsjXnZZUgt67DcUXSmAJrrO0eR93S2z7+xvUFp3SimqKjKB7tbjNt
 9mlI+mwAo44uS7a6xTfKLZYvKvrhQe+deaWqkDLcUrGUgtxf8pHJm9UFL2VGiFb2WxfvuSZ/w
 75PumImpdRm6rLFsJsx/rtIGMq9jPgl17xIYQWvNQvhbQ0C8ppg2of3HbTKXIyVCPVYvqL5Ck
 gI7USUqFU4GoNm0c5cwFPmLqlT9HtzutHMy2WAD60thDEpaNducCWJYnETQBVwNeXJhfAlMN/
 Bt4Lr8jv5BPezj9im5WVHxMRx/LgHlUH07vucDM0/AAYQh3/V+lysTMB/0vYvZOnsk4EhB5jB
 p8uXp5JrJPrT2m8gufziu3tfNMk5ZhLIo+CbDuWA8vtu2AfzNEvt2EBXnLhobN51wGSXTK6h0
 gIik0AO2AaX7sTvqkdGHxyZDSjV4J1hcJCpz6RTKrQfZBqB7ipft8Pw4A/WyiT6/GS1A48Igz
 LsgR8A06N/TNPUOqi5d2VnHHQ/ErgICKRT4j9yPaPPQSdwgdDZTG03Vs+WumtSmNHjijVksZr
 0c/Ot72pydCtjoWvj/lbNS0qb7VgB6jWAWU/YhmGEyG/XcqT4ZE1DB5luelz87zPWrgBmcCFO
 QnxzlFJq9cNcupYOKNxvyq9oHCal6dmuhrWqTogBZBgx+8m5oBRfcjHcmKeBWhF/AzggmDN/I
 +1Omr3FVNh+E56BfKh9JdkJaDGxJN4c0qia0o1vonYgcapUi0BdKnMxaUXfw6mJzRj/pwJt5b
 BHsKD6BmIk4SDnt2f2jvbaKn5oT6WCGXWAe8i5e/I9P5OVgfs/oQwQ/DAwoVu6AS2aQLyAoTX
 8Pb77K0cl3QgPB8F0IXOopTFZMOtRHEKLLoOrrPzNKh7evFuKEu+lM5Xo65S1RWAurQCVk2SO
 JZ+wI6VbSeFjOH/mVV0KmGvA+Sk131MbcT2FcfsiiYoyvpMYDGsnYDb9QiHfWBiKpRwszNyv/
 XuS4k+pgyWb4PYuP1JEqUSZpOCBb6499edkk2CA==
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


v3:
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

 .../bindings/mfd/netronix,ntxec.yaml          |  76 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   9 +
 arch/arm/boot/dts/imx50-kobo-aura.dts         |  17 +-
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/ntxec.c                           | 206 ++++++++++++++++++
 drivers/pwm/Kconfig                           |   8 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ntxec.c                       | 161 ++++++++++++++
 drivers/rtc/Kconfig                           |   8 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-ntxec.c                       | 132 +++++++++++
 include/linux/mfd/ntxec.h                     |  31 +++
 14 files changed, 662 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.y=
aml
 create mode 100644 drivers/mfd/ntxec.c
 create mode 100644 drivers/pwm/pwm-ntxec.c
 create mode 100644 drivers/rtc/rtc-ntxec.c
 create mode 100644 include/linux/mfd/ntxec.h

=2D-
2.28.0

