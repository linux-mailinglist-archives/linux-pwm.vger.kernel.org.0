Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC92D134E
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Dec 2020 15:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLGOOJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 09:14:09 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:58618 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgLGOOI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 09:14:08 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 1BE3FA9D828; Mon,  7 Dec 2020 15:13:27 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Johannes Pointner <h4nn35.work@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] pwm: imx27: fix overflow for bigger periods
Date:   Mon,  7 Dec 2020 15:13:24 +0100
Message-Id: <20201207141324.25945-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The second parameter of do_div is an u32 and NSEC_PER_SEC * prescale
overflows this for bigger periods. Assuming the usual pwm input clk rate
of 66 MHz this happens starting at requested period > 606060 ns.

Splitting the division into two operations doesn't loose any precision.
It doesn't need to be feared that c / NSEC_PER_SEC doesn't fit into the
unsigned long variable "duty_cycles" because in this case the assignment
above to period_cycles would already have been overflowing as
period >= duty_cycle and then the calculation is moot anyhow.

Fixes: aef1a3799b5c ("pwm: imx27: Fix rounding behavior")
Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Hello,

for a similar patch I said "that looses more precision than I thought at
first", but I think this was wrong. And if it looses precision the same
applies to the calculation of period_cycles which uses the same
operations.

I'm a bit at doubt how urgent this patch is. The regression was
introduced in 5.8-rc1.

Best regards
Uwe

 drivers/pwm/pwm-imx27.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index c50d453552bd..86bcafd23e4f 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -235,8 +235,9 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	period_cycles /= prescale;
 	c = clkrate * state->duty_cycle;
-	do_div(c, NSEC_PER_SEC * prescale);
+	do_div(c, NSEC_PER_SEC);
 	duty_cycles = c;
+	duty_cycles /= prescale;
 
 	/*
 	 * according to imx pwm RM, the real period value should be PERIOD
-- 
2.29.2

