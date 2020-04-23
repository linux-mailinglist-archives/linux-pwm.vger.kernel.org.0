Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B661B6235
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2020 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgDWRq3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Apr 2020 13:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbgDWRq2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Apr 2020 13:46:28 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E82C09B042;
        Thu, 23 Apr 2020 10:46:28 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E320A22F99;
        Thu, 23 Apr 2020 19:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1587663986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fbl5Ev06XHPQ6bOW/xCAY2dvNLIEvNxrk8zF984jvaw=;
        b=sMd5Sf/Gr7RDhCy0+J0cj0WYWOD0lOYOkQEwhSmS6CAWOek6JVxnbjkp7z9W0lvIqGzIs6
        b6eRHnVgVWaTIxuTWGTr+jr15rr1ZYhjeSrq/0F6TLIiYfzE2Wgrt/nOLGdrDQqTAUniBz
        DqFfsoQQwq0NxBO0PaIgCwuVxGZF3pk=
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
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
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 00/16] Add support for Kontron sl28cpld
Date:   Thu, 23 Apr 2020 19:45:27 +0200
Message-Id: <20200423174543.17161-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: E320A22F99
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM(0.00)[1.002];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         FREEMAIL_CC(0.00)[linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org,walle.cc];
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

This is my first take of a MFD driver. I don't know whether the subsystem
maintainers should only be CCed on the patches which affect the subsystem
or on all patches for this series. I've chosen the latter so you can get a
more complete picture.

[1] https://lore.kernel.org/linux-devicetree/0e3e8204ab992d75aa07fc36af7e4ab2@walle.cc/

Changes since v2:
As suggested by Guenter Roeck:
 - added sl28cpld.rst to index.rst
 - removed sl28cpld_wdt_status()
 - reverse christmas tree local variable ordering
 - assign device_property_read_bool() retval directly
 - introduce WDT_DEFAULT_TIMEOUT and use it if the hardware reports
   0 as timeout.
 - set WDOG_HW_RUNNING if applicable
 - remove platform_set_drvdata() leftover

As suggested by Bartosz Golaszewski:
 - don't export gpio_regmap_simple_xlate()
 - combine local variable declaration of the same type
 - drop the "struct gpio_regmap_addr", instead use -1 to force an address
   offset of zero
 - fix typo
 - use "struct gpio_regmap_config" pattern, keep "struct gpio_regmap"
   private. this also means we need a getter/setter for the driver_data
   element.

As suggested by Linus Walleij:
 - don't store irq_domain in gpio-regmap. drop to_irq() altogether for now.
   Instead there is now a new patch which lets us set the irqdomain of the
   gpiochip_irqchip and use its .to_irq() function. This way we don't have
   to expose the gpio_chip inside the gpio-regmap to the user.

Changes since v1:
 - use of_match_table in all drivers, needed for automatic module loading,
   when using OF_MFD_CELL()
 - add new gpio-regmap.c which adds a generic regmap gpio_chip
   implementation
 - new patch for reqmap_irq, so we can reuse its implementation
 - remove almost any code from gpio-sl28cpld.c, instead use gpio-regmap and
   regmap-irq
 - change the handling of the mfd core vs device tree nodes; add a new
   property "of_reg" to the mfd_cell struct which, when set, is matched to
   the unit-address of the device tree nodes.
 - fix sl28cpld watchdog when it is not initialized by the bootloader.
   Explicitly set the operation mode.
 - also add support for kontron,assert-wdt-timeout-pin in sl28cpld-wdt.

As suggested by Bartosz Golaszewski:
 - define registers as hex
 - make gpio enum uppercase
 - move parent regmap check before memory allocation
 - use device_property_read_bool() instead of the of_ version
 - mention the gpio flavors in the bindings documentation

As suggested by Guenter Roeck:
 - cleanup #includes and sort them
 - use devm_watchdog_register_device()
 - use watchdog_stop_on_reboot()
 - provide a Documentation/hwmon/sl28cpld.rst
 - cleaned up the weird tristate->bool and I2C=y issue. Instead mention
   that the MFD driver is bool because of the following intc patch
 - removed the SL28CPLD_IRQ typo

As suggested by Rob Herring:
 - combine all dt bindings docs into one patch
 - change the node name for all gpio flavors to "gpio"
 - removed the interrupts-extended rule
 - cleaned up the unit-address space, see above

Michael Walle (16):
  include/linux/ioport.h: add helper to define REG resource constructs
  mfd: mfd-core: Don't overwrite the dma_mask of the child device
  mfd: mfd-core: match device tree node against reg property
  dt-bindings: mfd: Add bindings for sl28cpld
  mfd: Add support for Kontron sl28cpld management controller
  irqchip: add sl28cpld interrupt controller support
  watchdog: add support for sl28cpld watchdog
  pwm: add support for sl28cpld PWM controller
  gpiolib: Introduce gpiochip_irqchip_add_domain()
  gpio: add a reusable generic gpio_chip using regmap
  gpio: add support for the sl28cpld GPIO controller
  hwmon: add support for the sl28cpld hardware monitoring controller
  arm64: dts: freescale: sl28: enable sl28cpld
  arm64: dts: freescale: sl28: map GPIOs to input events
  arm64: dts: freescale: sl28: enable LED support
  arm64: dts: freescale: sl28: enable fan support

 .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  51 +++
 .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 ++
 .../bindings/mfd/kontron,sl28cpld.yaml        | 162 ++++++++
 .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++
 .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/sl28cpld.rst              |  36 ++
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts     |  14 +
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts    |   9 +
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 124 +++++++
 drivers/gpio/Kconfig                          |  15 +
 drivers/gpio/Makefile                         |   2 +
 drivers/gpio/gpio-regmap.c                    | 348 ++++++++++++++++++
 drivers/gpio/gpio-sl28cpld.c                  | 184 +++++++++
 drivers/gpio/gpiolib.c                        |  20 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sl28cpld-hwmon.c                | 151 ++++++++
 drivers/irqchip/Kconfig                       |   3 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sl28cpld.c                |  97 +++++
 drivers/mfd/Kconfig                           |  21 ++
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/mfd-core.c                        |  31 +-
 drivers/mfd/sl28cpld.c                        | 153 ++++++++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sl28cpld.c                    | 203 ++++++++++
 drivers/watchdog/Kconfig                      |  11 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/sl28cpld_wdt.c               | 233 ++++++++++++
 include/linux/gpio-regmap.h                   |  69 ++++
 include/linux/gpio/driver.h                   |   3 +
 include/linux/ioport.h                        |   5 +
 include/linux/mfd/core.h                      |  26 +-
 35 files changed, 2079 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
 create mode 100644 Documentation/hwmon/sl28cpld.rst
 create mode 100644 drivers/gpio/gpio-regmap.c
 create mode 100644 drivers/gpio/gpio-sl28cpld.c
 create mode 100644 drivers/hwmon/sl28cpld-hwmon.c
 create mode 100644 drivers/irqchip/irq-sl28cpld.c
 create mode 100644 drivers/mfd/sl28cpld.c
 create mode 100644 drivers/pwm/pwm-sl28cpld.c
 create mode 100644 drivers/watchdog/sl28cpld_wdt.c
 create mode 100644 include/linux/gpio-regmap.h

-- 
2.20.1

