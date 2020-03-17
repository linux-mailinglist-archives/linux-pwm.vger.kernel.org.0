Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A979188FBD
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 21:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCQUuv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 16:50:51 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:57217 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQUuv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 16:50:51 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0D1DA23E3C;
        Tue, 17 Mar 2020 21:50:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1584478246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9s1oQ4jq4pc56CEahZRpEbRnFk8T32v+b2fT2eRreEE=;
        b=qce08iWXtRajtnoSLXDjM1QKGpUAFHSDUgGSEcHGW3Cj/PC34Uaf4/Vo5xxlHtQ8P6BNYg
        lEHg2dwzb2isgJtP0nuBHmcX3ASQiJeZI0CBXD8U3ZTPh7fb/MXg0ksEIlJD3bFFu3dKEM
        DpgRvvwPFbSDcOfN9eADOSPG9Xbhg6U=
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH 00/18] Add support for Kontron sl28cpld
Date:   Tue, 17 Mar 2020 21:49:59 +0100
Message-Id: <20200317205017.28280-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 0D1DA23E3C
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM(0.00)[0.662];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.1:email,0.0.0.0:email];
         RCPT_COUNT_TWELVE(0.00)[22];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         FREEMAIL_CC(0.00)[linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,walle.cc];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Kontron sl28cpld is a board management chip providing gpio, pwm, fan
monitoring and an interrupt controller. For now this controller is used on
the Kontron SMARC-sAL28 board. But because of its flexible nature, it
might also be used on other boards in the future. The individual blocks
(like gpio, pwm, etc) are kept intentionally small. The MFD core driver
then instantiates different (or multiple of the same) blocks. It also
provides the register layout so it might be updated in the future without a
device tree change; and support other boards with a different layout or
functionalities.

See also [1] for more information.

There is one problem though:

Documentation/devicetree/bindings/mfd/kontron,sl28cpld.example.dts:32.24-41.19: Warning (unique_unit_address): /example-0/i2c/sl28cpld@4a/gpio@0: duplicate unit-address (also used in node /example-0/i2c/sl28cpld@4a/pwm@0)
Documentation/devicetree/bindings/mfd/kontron,sl28cpld.example.dts:43.24-52.19: Warning (unique_unit_address): /example-0/i2c/sl28cpld@4a/gpio@1: duplicate unit-address (also used in node /example-0/i2c/sl28cpld@4a/pwm@1)

This is because the reg property is used to match multiple MFD cells which
has the same devicetree compatible string. See patch 3. So only the (reg,
compatible string) is unique. Maybe I should use a different property but
reg?

This is my first take of a MFD driver. I don't know wether the subsystem
maintainers should only be CCed on the patches which affect the subsystem
or on all patches for this series. I've chosen the latter so you can get a
more complete picture.

[1] https://lore.kernel.org/linux-devicetree/0e3e8204ab992d75aa07fc36af7e4ab2@walle.cc/

Michael Walle (18):
  include/linux/ioport.h: add helper to define REG resource constructs
  mfd: mfd-core: Don't overwrite the dma_mask of the child device
  mfd: mfd-core: match device tree node against reg property
  dt-bindings: mfd: Add bindings for sl28cpld
  mfd: Add support for Kontron sl28cpld management controller
  irqchip: add sl28cpld interrupt controller support
  dt-bindings: watchdog: Add bindings for sl28cpld watchdog
  watchdog: add support for sl28cpld watchdog
  dt-bindings: pwm: Add bindings for sl28cpld PWM controller
  pwm: add support for sl28cpld PWM controller
  dt-bindings: gpio: Add bindings for sl28cpld GPIO controller
  gpio: add support for the sl28cpld GPIO controller
  dt-bindings: hwmon: Add bindings for sl28cpld hardware monitoring
  hwmon: add support for the sl28cpld hardware monitoring controller
  arm64: dts: freescale: sl28: enable sl28cpld
  arm64: dts: freescale: sl28: map GPIOs to input events
  arm64: dts: freescale: sl28: enable LED support
  arm64: dts: freescale: sl28: enable fan support

 .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  52 +++
 .../hwmon/kontron,sl28cpld-hwmon.yaml         |  28 ++
 .../bindings/mfd/kontron,sl28cpld.yaml        | 146 ++++++++
 .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  33 ++
 .../watchdog/kontron,sl28cpld-wdt.yaml        |  30 ++
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts     |  14 +
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts    |   9 +
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 119 +++++++
 drivers/gpio/Kconfig                          |  11 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-sl28cpld.c                  | 332 ++++++++++++++++++
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sl28cpld-hwmon.c                | 146 ++++++++
 drivers/irqchip/Kconfig                       |   3 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sl28cpld.c                |  92 +++++
 drivers/mfd/Kconfig                           |  21 ++
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/mfd-core.c                        |  28 +-
 drivers/mfd/sl28cpld.c                        | 155 ++++++++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sl28cpld.c                    | 192 ++++++++++
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/sl28cpld_wdt.c               | 238 +++++++++++++
 include/linux/ioport.h                        |   5 +
 28 files changed, 1682 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
 create mode 100644 drivers/gpio/gpio-sl28cpld.c
 create mode 100644 drivers/hwmon/sl28cpld-hwmon.c
 create mode 100644 drivers/irqchip/irq-sl28cpld.c
 create mode 100644 drivers/mfd/sl28cpld.c
 create mode 100644 drivers/pwm/pwm-sl28cpld.c
 create mode 100644 drivers/watchdog/sl28cpld_wdt.c

-- 
2.20.1

