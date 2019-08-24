Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D229B958
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 02:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfHXALF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Aug 2019 20:11:05 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:56656 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHXALF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Aug 2019 20:11:05 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 3431277D4BE; Sat, 24 Aug 2019 02:11:03 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 6/6] pwm: atmel: implement .get_state()
Date:   Sat, 24 Aug 2019 02:10:41 +0200
Message-Id: <20190824001041.11007-7-uwe@kleine-koenig.org>
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

This function reads back the configured parameters from the hardware. As
.apply rounds down (mostly) I'm rounding up in .get_state() to achieve
that applying a state just read from hardware is a no-op.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
New in v2

 drivers/pwm/pwm-atmel.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 152c2b7dd6df..f788501ab6ca 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -295,8 +295,47 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static void atmel_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
+	u32 sr, cmr;
+
+	sr = atmel_pwm_readl(atmel_pwm, PWM_SR);
+	cmr = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
+
+	if (sr & (1 << pwm->hwpwm)) {
+		unsigned long rate = clk_get_rate(atmel_pwm->clk);
+		u32 cdty, cprd, pres; 
+		u64 tmp;
+
+		pres = cmr & PWM_CMR_CPRE_MSK;
+
+		cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, atmel_pwm->data->regs.period);
+		tmp = (u64)cprd * NSEC_PER_SEC;
+		tmp <<= pres;
+		state->period = DIV64_U64_ROUND_UP(tmp, rate);
+
+		cdty = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, atmel_pwm->data->regs.duty);
+		tmp = (u64)cdty * NSEC_PER_SEC;
+		tmp <<= pres;
+		state->duty_cycle = DIV64_U64_ROUND_UP(tmp, rate);
+
+		state->enabled = true;
+	} else {
+		state->enabled = false;
+	}
+
+	if (cmr & PWM_CMR_CPOL)
+		state->polarity = PWM_POLARITY_INVERSED;
+	else
+		state->polarity = PWM_POLARITY_NORMAL;
+
+}
+
 static const struct pwm_ops atmel_pwm_ops = {
 	.apply = atmel_pwm_apply,
+	.get_state = atmel_pwm_get_state,
 	.owner = THIS_MODULE,
 };
 
-- 
2.20.1

