Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5042B7B9F
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 11:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKRKqy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 05:46:54 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:55913 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgKRKqy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Nov 2020 05:46:54 -0500
X-Greylist: delayed 612 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 05:46:53 EST
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 54FCC4406E6;
        Wed, 18 Nov 2020 12:30:57 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] gpio: mvebu: Armada 8K/7K PWM support
Date:   Wed, 18 Nov 2020 12:30:41 +0200
Message-Id: <cover.1605694661.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The gpio-mvebu driver supports the PWM functionality of the GPIO block for 
earlier Armada variants like XP, 370 and 38x. This series extends support to 
newer Armada variants that use CP11x and AP80x, like Armada 8K and 7K.

This series adds adds the 'pwm-offset' property to DT binding. 'pwm-offset' 
points to the base of A/B counter registers that determine the PWM period and 
duty cycle.

The existing PWM DT binding reflects an arbitrary decision to allocate the A 
counter to the first GPIO block, and B counter to the other one. In attempt to 
provide better future flexibility, the new 'pwm-offset' property always points 
to the base address of both A/B counters. The driver code still allocates the 
counters in the same way, but this might change in the future with no change to
the DT.

Tested AP806 and CP110 (both) on Armada 8040 based system.

Baruch Siach (5):
  gpio: mvebu: update Armada XP per-CPU comment
  gpio: mvebu: switch pwm duration registers to regmap
  gpio: mvebu: add pwm support for Armada 8K/7K
  arm64: dts: armada: add pwm offsets for ap/cp gpios
  dt-bindings: ap806: document gpio pwm-offset property

 .../arm/marvell/ap80x-system-controller.txt   |   8 +
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |   3 +
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  10 ++
 drivers/gpio/gpio-mvebu.c                     | 165 +++++++++++-------
 4 files changed, 124 insertions(+), 62 deletions(-)

-- 
2.29.2

