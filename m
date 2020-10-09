Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34317288CA4
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Oct 2020 17:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389286AbgJIPas (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Oct 2020 11:30:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:34384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388473AbgJIPas (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 9 Oct 2020 11:30:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C218CAC8C;
        Fri,  9 Oct 2020 15:30:46 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        wahrenst@gmx.net,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Raspberry Pi 4 PoE HAT fan support
Date:   Fri,  9 Oct 2020 17:30:27 +0200
Message-Id: <20201009153031.986-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi everyone,
this series aims at adding support to RPi's official PoE HAT fan[1].

The HW setup is the following:

| Raspberry Pi                               | PoE HAT		          |
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

Nicolas Saenz Julienne (3):
  dt-bindings: pwm: Add binding for RPi firmware PWM bus
  DO NOT MERGE: ARM: dts: Add RPi's official PoE hat support
  pwm: Add Raspberry Pi Firmware based PWM bus

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml |  21 ++
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |  54 +++++
 drivers/pwm/Kconfig                           |   7 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-raspberrypi.c                 | 216 ++++++++++++++++++
 .../pwm/raspberrypi,firmware-pwm.h            |  13 ++
 6 files changed, 312 insertions(+)
 create mode 100644 drivers/pwm/pwm-raspberrypi.c
 create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-pwm.h

-- 
2.28.0

