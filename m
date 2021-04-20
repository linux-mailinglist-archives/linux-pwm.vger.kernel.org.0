Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53393655C5
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Apr 2021 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhDTJwO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Apr 2021 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhDTJwO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Apr 2021 05:52:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E7FC06138A
        for <linux-pwm@vger.kernel.org>; Tue, 20 Apr 2021 02:51:42 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lYn2T-0001iE-SM; Tue, 20 Apr 2021 11:51:25 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lYn2R-0000PH-GL; Tue, 20 Apr 2021 11:51:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: atmel: Fix duty cycle calculation in .get_state()
Date:   Tue, 20 Apr 2021 11:51:17 +0200
Message-Id: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The CDTY register contains the number of inactive cycles. .apply() does
this correctly, however .get_state() got this wrong.

Fixes: 651b510a74d4 ("pwm: atmel: Implement .get_state()")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index d49da708337f..ebaeb50dcfde 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -319,7 +319,7 @@ static void atmel_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		cdty = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 					  atmel_pwm->data->regs.duty);
-		tmp = (u64)cdty * NSEC_PER_SEC;
+		tmp = (u64)(cprd - cdty) * NSEC_PER_SEC;
 		tmp <<= pres;
 		state->duty_cycle = DIV64_U64_ROUND_UP(tmp, rate);
 
-- 
2.30.2

