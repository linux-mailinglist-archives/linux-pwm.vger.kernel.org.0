Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4462D5A3A
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 13:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbgLJMRP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 07:17:15 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:58274 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388197AbgLJMRC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Dec 2020 07:17:02 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 49959440048;
        Thu, 10 Dec 2020 14:16:08 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 0/3] gpio: mvebu: Armada 8K/7K PWM support
Date:   Thu, 10 Dec 2020 14:15:57 +0200
Message-Id: <cover.1607601615.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series makes two changes to v3:

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
  dt-bindings: ap806: document marvell,gpio pwm-offset property

 .../arm/marvell/ap80x-system-controller.txt   |   8 ++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |   3 +
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  10 ++
 drivers/gpio/gpio-mvebu.c                     | 101 ++++++++++++------
 4 files changed, 89 insertions(+), 33 deletions(-)

-- 
2.29.2

