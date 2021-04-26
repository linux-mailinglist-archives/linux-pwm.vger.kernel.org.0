Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC62A36B560
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Apr 2021 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhDZPEo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Apr 2021 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZPEn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Apr 2021 11:04:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03031C061574
        for <linux-pwm@vger.kernel.org>; Mon, 26 Apr 2021 08:04:01 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb2mE-0007g4-HF; Mon, 26 Apr 2021 17:03:58 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb2mB-0008NW-RB; Mon, 26 Apr 2021 17:03:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: visconti: Fix and simplify period calculation
Date:   Mon, 26 Apr 2021 17:03:50 +0200
Message-Id: <20210426150350.2829255-1-u.kleine-koenig@pengutronix.de>
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

With the original code a request for period = 65536000 ns and period =
32768000 ns yields the same register settings (which results in 32768000
ns) because the value for pwmc0 was miscalculated.

Also simplify using that fls(0) is 0.

Fixes: 721b595744f1 ("pwm: visconti: Add Toshiba Visconti SoC PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-visconti.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
index 46d903786366..af4e37d3e3a6 100644
--- a/drivers/pwm/pwm-visconti.c
+++ b/drivers/pwm/pwm-visconti.c
@@ -82,17 +82,14 @@ static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -ERANGE;
 
 	/*
-	 * PWMC controls a divider that divides the input clk by a
-	 * power of two between 1 and 8. As a smaller divider yields
-	 * higher precision, pick the smallest possible one.
+	 * PWMC controls a divider that divides the input clk by a power of two
+	 * between 1 and 8. As a smaller divider yields higher precision, pick
+	 * the smallest possible one. As period is at most 0xffff << 3, pwmc0 is
+	 * in the intended range [0..3].
 	 */
-	if (period > 0xffff) {
-		pwmc0 = ilog2(period >> 16);
-		if (WARN_ON(pwmc0 > 3))
-			return -EINVAL;
-	} else {
-		pwmc0 = 0;
-	}
+	pwmc0 = fls(period >> 16);
+	if (WARN_ON(pwmc0 > 3))
+		return -EINVAL;
 
 	period >>= pwmc0;
 	duty_cycle >>= pwmc0;
-- 
2.30.2

