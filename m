Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F492B8348
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 18:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgKRRpE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 12:45:04 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:53834 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgKRRpE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Nov 2020 12:45:04 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id D36D3C7D0F7;
        Wed, 18 Nov 2020 18:45:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1605721502;
        bh=H9OwDD0L8d1vX7kjVmEBiiZc8e6+OxHVW4PFdXs3lM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtYx8D6DEh7xcKUzhD44wFJskmYKuNZ4n8cywu6nxHFenBKVCxmzvvjdrK0gPzEs9
         G6A/xlIfPhxZorBwt7yEWKfgwmXoUgu5f5W+GJr9HqhuYcedPpwvCn5wgqEiYN9Unu
         2HLQBkbuQzBfE2sSeIhJrEn9KuXwfpfKV6SBlzCU=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 2/3] pwm: pca9685: Set full OFF bits in probe
Date:   Wed, 18 Nov 2020 18:44:16 +0100
Message-Id: <20201118174417.278011-2-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
References: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The full OFF bits are set by default in the PCA9685 LEDn_OFF_H
registers at POR. LEDn_ON_L/H and LEDn_OFF_L default to 0.

The datasheet states that LEDn_OFF and LEDn_ON should never be both set
to the same values.

This patch removes the clearing of the full OFF bit in the probe
function. We still clear the rest of the OFF regs but now we set the
full OFF bit to avoid having both OFF and ON registers set to 0 and
start up in a safe default state.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 20f1314e6754..88028222335f 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -499,9 +499,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
 	regmap_write(pca->regmap, PCA9685_MODE1, reg);
 
-	/* Clear all "full off" bits */
+	/* Reset OFF registers to HW default (only full OFF bit is set) */
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
-	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
 
 	pca->chip.ops = &pca9685_pwm_ops;
 	/* Add an extra channel for ALL_LED */
-- 
2.29.2

