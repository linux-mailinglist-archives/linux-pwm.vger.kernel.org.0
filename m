Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942432D7B5F
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbgLKQtZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 11:49:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:34216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389466AbgLKQsu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 11 Dec 2020 11:48:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B06C2ADCD;
        Fri, 11 Dec 2020 16:48:07 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH v6 00/11] Raspberry Pi PoE HAT fan support
Date:   Fri, 11 Dec 2020 17:47:49 +0100
Message-Id: <20201211164801.7838-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The aim of this series is to add support to the fan found on RPi's PoE
HAT. Some commentary on the design can be found below. But the imporant
part to the people CC'd here not involved with PWM is that, in order to
achieve this properly, we also have to fix the firmware interface the
driver uses to communicate with the PWM bus (and many other low level
functions). Specifically, we have to make sure the firmware interface
isn't unbound while consumers are still up. So, patch #1 & #2 introduce
reference counting in the firwmware interface driver and patches #3 to
#8 update all firmware users. Patches #9 to #11 introduce the new PWM
driver.

I sent everything as a single series as the final version of the PWM
drivers depends on the firwmare fixes, but I'll be happy to split this
into two separate series if you think it's better.

--- Original cover letter below ---

This series aims at adding support to RPi's official PoE HAT fan[1].

The HW setup is the following:

| Raspberry Pi                               | PoE HAT                    |
 arm core -> Mailbox -> RPi co-processor -> I2C -> Atmel MCU -> PWM -> FAN

The arm cores have only access to the mailbox interface, as i2c0, even if
physically accessible, is to be used solely by the co-processor
(VideoCore 4/6).

This series implements a PWM bus, and has pwm-fan sitting on top of it as per
this discussion: https://lkml.org/lkml/2018/9/2/486. Although this design has a
series of shortcomings:

- It depends on a DT binding: it's not flexible if a new hat shows up with new
  functionality, we're not 100% sure we'll be able to expand it without
  breaking backwards compatibility. But without it we can't make use of DT
  thermal-zones, which IMO is overkill.

- We're using pwm-fan, writing a hwmon driver would, again, give us more
  flexibility, but it's not really needed at the moment.

I personally think that it's not worth the effort, it's unlikely we'll get
things right in advance. And ultimately, if the RPi people come up with
something new, we can always write a new driver/bindings from scratch (as in
not reusing previous code).

That said, I'm more than happy to change things if there is a consensus that
another design will do the trick.

[1] https://www.raspberrypi.org/blog/introducing-power-over-ethernet-poe-hat/

---

Changes since v5:
 - Small cleanups
 - Add extra code comments

Changes since v4:
 - Cleanup devm calls
 - Rename compatible string so it's unique to the PoE HAT

Changes since v3:
 - Split first patch, #1 introduces refcount, then #2 the devm function
 - Fix touchscreen function
 - Use kref

Changes since v2:
 - Introduce devm_rpi_firmware_get()
 - Small cleanups in PWM driver

Changes since v1:
 - Address PWM driver changes
 - Fix binding, now with 2 cells

Nicolas Saenz Julienne (11):
  firmware: raspberrypi: Keep count of all consumers
  firmware: raspberrypi: Introduce devm_rpi_firmware_get()
  clk: bcm: rpi: Release firmware handle on unbind
  gpio: raspberrypi-exp: Release firmware handle on unbind
  reset: raspberrypi: Release firmware handle on unbind
  soc: bcm: raspberrypi-power: Release firmware handle on unbind
  staging: vchiq: Release firmware handle on unbind
  input: raspberrypi-ts: Release firmware handle when not needed
  dt-bindings: pwm: Add binding for RPi firmware PWM bus
  DO NOT MERGE: ARM: dts: Add RPi's official PoE hat support
  pwm: Add Raspberry Pi Firmware based PWM bus

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml |  20 ++
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |  54 +++++
 drivers/clk/bcm/clk-raspberrypi.c             |   2 +-
 drivers/firmware/raspberrypi.c                |  69 +++++-
 drivers/gpio/gpio-raspberrypi-exp.c           |   2 +-
 drivers/input/touchscreen/raspberrypi-ts.c    |   2 +-
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-raspberrypi-poe.c             | 216 ++++++++++++++++++
 drivers/reset/reset-raspberrypi.c             |   2 +-
 drivers/soc/bcm/raspberrypi-power.c           |   2 +-
 .../interface/vchiq_arm/vchiq_arm.c           |   2 +-
 .../pwm/raspberrypi,firmware-poe-pwm.h        |  13 ++
 include/soc/bcm2835/raspberrypi-firmware.h    |  10 +
 14 files changed, 395 insertions(+), 9 deletions(-)
 create mode 100644 drivers/pwm/pwm-raspberrypi-poe.c
 create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-poe-pwm.h

-- 
2.29.2

