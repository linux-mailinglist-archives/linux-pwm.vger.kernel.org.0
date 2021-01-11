Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAC12F11CE
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 12:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbhAKLrv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 06:47:51 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:43407 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729795AbhAKLrv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Jan 2021 06:47:51 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id DA19D44083C;
        Mon, 11 Jan 2021 13:47:02 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 0/3] gpio: mvebu: Armada 8K/7K PWM support
Date:   Mon, 11 Jan 2021 13:46:26 +0200
Message-Id: <cover.1610364681.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This version is identical to v4 with the typo fix from v5.

This series has no dependency on the fixes series that I posted separately.

Tested on top of v5.11-rc2.

Changes in v7:

  * Split the get_state fix to a separate independent fixes series

Changes in v6:

  * Reduce rounding error in the get_state fix (RMK)

Changes in v5:

  * Add a fix for get_state

  * Fix typo in patch #4 subject line

  * Add Rob's review tag on the binding documentation patch

Changes in v4:

  * Remove patches that are in LinusW linux-gpio for-next and fixes

  * Rename the 'pwm-offset' property to 'marvell,pwm-offset' as suggested by 
    Rob Herring

The original cover letter follows (with DT property name updated).

The gpio-mvebu driver supports the PWM functionality of the GPIO block for
earlier Armada variants like XP, 370 and 38x. This series extends support to
newer Armada variants that use CP11x and AP80x, like Armada 8K and 7K.

This series adds adds the 'marvell,pwm-offset' property to DT binding. 
'marvell,pwm-offset' points to the base of A/B counter registers that 
determine the PWM period and duty cycle.

The existing PWM DT binding reflects an arbitrary decision to allocate the A
counter to the first GPIO block, and B counter to the other one. In attempt to
provide better future flexibility, the new 'marvell,pwm-offset' property 
always points to the base address of both A/B counters. The driver code still 
allocates the counters in the same way, but this might change in the future 
with no change to the DT.

Tested AP806 and CP110 (both) on Armada 8040 based system.

Baruch Siach (3):
  gpio: mvebu: add pwm support for Armada 8K/7K
  arm64: dts: armada: add pwm offsets for ap/cp gpios
  dt-bindings: ap806: document gpio marvell,pwm-offset property

 .../arm/marvell/ap80x-system-controller.txt   |   8 ++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |   3 +
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  10 ++
 drivers/gpio/gpio-mvebu.c                     | 101 ++++++++++++------
 4 files changed, 89 insertions(+), 33 deletions(-)

-- 
2.29.2

