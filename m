Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8478536379C
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Apr 2021 22:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhDRU6V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Apr 2021 16:58:21 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:58894 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDRU6U (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Apr 2021 16:58:20 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 35B6EB6E149; Sun, 18 Apr 2021 22:57:51 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: atmel: Fix duty cycle calculation in .get_state()
Date:   Sun, 18 Apr 2021 22:57:47 +0200
Message-Id: <20210418205747.1488248-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The CDTY register contains the number of inactive cycles. .apply() does
this correctly, however .get_state got this wrong.

Fixes: 651b510a74d4 ("pwm: atmel: Implement .get_state()")
Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index d49da708337f..c30a0dac4b2d 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -319,7 +319,7 @@ static void atmel_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		cdty = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 					  atmel_pwm->data->regs.duty);
-		tmp = (u64)cdty * NSEC_PER_SEC;
+		tmp = (u64)(cdty - cprd) * NSEC_PER_SEC;
 		tmp <<= pres;
 		state->duty_cycle = DIV64_U64_ROUND_UP(tmp, rate);
 
-- 
2.30.2

