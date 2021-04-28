Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26A236D479
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Apr 2021 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbhD1JGg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Apr 2021 05:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbhD1JGP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Apr 2021 05:06:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33234C061574
        for <linux-pwm@vger.kernel.org>; Wed, 28 Apr 2021 02:05:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lbg8P-0004xd-A7; Wed, 28 Apr 2021 11:05:29 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lbg8O-0006Ew-03; Wed, 28 Apr 2021 11:05:28 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 2/3] pwm: spear: Free resources only after pwmchip_remove()
Date:   Wed, 28 Apr 2021 11:05:25 +0200
Message-Id: <20210428090526.29016-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210428090526.29016-1-u.kleine-koenig@pengutronix.de>
References: <20210428090526.29016-1-u.kleine-koenig@pengutronix.de>
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

Before pwmchip_remove() returns the PWM is expected to be functional. So
remove the pwmchip before disabling the clocks. The check for
pwmchip_remove()'s return value is dropped as this function returns
effectively always 0 and returning an error in a remove callback is
useless anyhow (as the device core ignores it and drops devm allocated
resources).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-spear.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index 6879b49581b3..05a19e70d570 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -229,9 +229,12 @@ static int spear_pwm_remove(struct platform_device *pdev)
 {
 	struct spear_pwm_chip *pc = platform_get_drvdata(pdev);
 
+	pwmchip_remove(&pc->chip);
+
 	/* clk was prepared in probe, hence unprepare it here */
 	clk_unprepare(pc->clk);
-	return pwmchip_remove(&pc->chip);
+
+	return 0;
 }
 
 static const struct of_device_id spear_pwm_of_match[] = {
-- 
2.30.2

