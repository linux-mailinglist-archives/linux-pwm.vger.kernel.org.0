Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD89B954
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 02:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfHXAKy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Aug 2019 20:10:54 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:56610 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHXAKy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Aug 2019 20:10:54 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 9EAB077D4B6; Sat, 24 Aug 2019 02:10:52 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 2/6] pwm: atmel: use a constant for maximum prescale value
Date:   Sat, 24 Aug 2019 02:10:37 +0200
Message-Id: <20190824001041.11007-3-uwe@kleine-koenig.org>
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

The maximal prescale value is 10 for all supported variants. So drop the
member in the variant description and introduce a global constant instead.

This reduces the size of the variant descriptions and the .apply() callback
can be compiled a bit more effectively.

Acked-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Changes since (implicit) v1, sent with Message-Id:
20190815214133.11134-2-uwe@kleine-koenig.org:

 - Added Claudiu's Ack

 drivers/pwm/pwm-atmel.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index a61a30fa8b7e..f497f84771f0 100644
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

