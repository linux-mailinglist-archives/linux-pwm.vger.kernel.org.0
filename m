Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22649B955
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfHXAK6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Aug 2019 20:10:58 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:56624 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHXAK6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Aug 2019 20:10:58 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 9A9A077D4B8; Sat, 24 Aug 2019 02:10:56 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 3/6] pwm: atmel: replace loop in prescale calculation by ad-hoc calculation
Date:   Sat, 24 Aug 2019 02:10:38 +0200
Message-Id: <20190824001041.11007-4-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190824001041.11007-1-uwe@kleine-koenig.org>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The calculated values are the same with the modified algorithm. The only
difference is that the calculation is a bit more efficient.

Acked-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Changes since (implicit) v1 sent with Message-Id:
20190815214133.11134-3-uwe@kleine-koenig.org

 - Added Claudiu's Ack

 drivers/pwm/pwm-atmel.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index f497f84771f0..3786ab9db5cf 100644
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

