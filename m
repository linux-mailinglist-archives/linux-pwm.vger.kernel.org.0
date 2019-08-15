Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48828F689
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2019 23:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbfHOVlx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Aug 2019 17:41:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56155 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfHOVlw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Aug 2019 17:41:52 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyNVA-0007cF-3T; Thu, 15 Aug 2019 23:41:44 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyNV8-0003Go-HM; Thu, 15 Aug 2019 23:41:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH 2/3] pwm: atmel: use a constant for maximum prescale value
Date:   Thu, 15 Aug 2019 23:41:32 +0200
Message-Id: <20190815214133.11134-2-uwe@kleine-koenig.org>
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

The maximal prescale value is 10 for all supported variants. So drop the
member in the variant description and introduce a global constant instead.

This reduces the size of the variant descriptions and the .apply() callback
can be compiled a bit more effectively.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-atmel.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index ac3d7a200b9e..d7a6d32b5774 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -50,6 +50,8 @@
 #define PWMV2_CPRD		0x0C
 #define PWMV2_CPRDUPD		0x10
 
+#define PWM_MAX_PRES		10
+
 struct atmel_pwm_registers {
 	u8 period;
 	u8 period_upd;
@@ -59,7 +61,6 @@ struct atmel_pwm_registers {
 
 struct atmel_pwm_config {
 	u32 max_period;
-	u32 max_pres;
 };
 
 struct atmel_pwm_data {
@@ -126,7 +127,7 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 	for (*pres = 0; cycles > atmel_pwm->data->cfg.max_period; cycles >>= 1)
 		(*pres)++;
 
-	if (*pres > atmel_pwm->data->cfg.max_pres) {
+	if (*pres > PWM_MAX_PRES) {
 		dev_err(chip->dev, "pres exceeds the maximum value\n");
 		return -EINVAL;
 	}
@@ -289,7 +290,6 @@ static const struct atmel_pwm_data atmel_sam9rl_pwm_data = {
 	.cfg = {
 		/* 16 bits to keep period and duty. */
 		.max_period	= 0xffff,
-		.max_pres	= 10,
 	},
 };
 
@@ -303,7 +303,6 @@ static const struct atmel_pwm_data atmel_sama5_pwm_data = {
 	.cfg = {
 		/* 16 bits to keep period and duty. */
 		.max_period	= 0xffff,
-		.max_pres	= 10,
 	},
 };
 
@@ -317,7 +316,6 @@ static const struct atmel_pwm_data mchp_sam9x60_pwm_data = {
 	.cfg = {
 		/* 32 bits to keep period and duty. */
 		.max_period	= 0xffffffff,
-		.max_pres	= 10,
 	},
 };
 
-- 
2.20.1

