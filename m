Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF568F68A
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2019 23:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfHOVl4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Aug 2019 17:41:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35617 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfHOVlz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Aug 2019 17:41:55 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyNVA-0007cG-3U; Thu, 15 Aug 2019 23:41:44 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyNV8-0003Gr-M0; Thu, 15 Aug 2019 23:41:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH 3/3] pwm: atmel: replace loop in prescale calculation by ad-hoc calculation
Date:   Thu, 15 Aug 2019 23:41:33 +0200
Message-Id: <20190815214133.11134-3-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815214133.11134-1-uwe@kleine-koenig.org>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The calculated values are the same with the modified algorithm. The only
difference is that the calculation is a bit more efficient.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-atmel.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index d7a6d32b5774..42fe7bc043a8 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -60,7 +60,7 @@ struct atmel_pwm_registers {
 };
 
 struct atmel_pwm_config {
-	u32 max_period;
+	u32 period_bits;
 };
 
 struct atmel_pwm_data {
@@ -119,17 +119,27 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned long long cycles = state->period;
+	int shift;
 
 	/* Calculate the period cycles and prescale value */
 	cycles *= clk_get_rate(atmel_pwm->clk);
 	do_div(cycles, NSEC_PER_SEC);
 
-	for (*pres = 0; cycles > atmel_pwm->data->cfg.max_period; cycles >>= 1)
-		(*pres)++;
+	/*
+	 * The register for the period length is cfg.period_bits bits wide.
+	 * So for each bit the number of clock cycles is wider divide the input
+	 * clock frequency by two using pres and shift cprd accordingly.
+	 */
+	shift = fls(cycles) - atmel_pwm->data->cfg.period_bits;
 
-	if (*pres > PWM_MAX_PRES) {
+	if (shift > PWM_MAX_PRES) {
 		dev_err(chip->dev, "pres exceeds the maximum value\n");
 		return -EINVAL;
+	} else if (shift > 0) {
+		*pres = shift;
+		cycles >>= *pres;
+	} else {
+		*pres = 0;
 	}
 
 	*cprd = cycles;
@@ -289,7 +299,7 @@ static const struct atmel_pwm_data atmel_sam9rl_pwm_data = {
 	},
 	.cfg = {
 		/* 16 bits to keep period and duty. */
-		.max_period	= 0xffff,
+		.period_bits	= 16,
 	},
 };
 
@@ -302,7 +312,7 @@ static const struct atmel_pwm_data atmel_sama5_pwm_data = {
 	},
 	.cfg = {
 		/* 16 bits to keep period and duty. */
-		.max_period	= 0xffff,
+		.period_bits	= 16,
 	},
 };
 
@@ -315,7 +325,7 @@ static const struct atmel_pwm_data mchp_sam9x60_pwm_data = {
 	},
 	.cfg = {
 		/* 32 bits to keep period and duty. */
-		.max_period	= 0xffffffff,
+		.period_bits	= 32,
 	},
 };
 
-- 
2.20.1

