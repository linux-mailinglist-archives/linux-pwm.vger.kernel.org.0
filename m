Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A436B4F6
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Apr 2021 16:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhDZOen (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Apr 2021 10:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbhDZOem (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Apr 2021 10:34:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47979C061574
        for <linux-pwm@vger.kernel.org>; Mon, 26 Apr 2021 07:34:01 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb2JD-0004JH-C9; Mon, 26 Apr 2021 16:33:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb2JD-0006LT-1c; Mon, 26 Apr 2021 16:33:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: spear: Free resources only after pwmchip_remove()
Date:   Mon, 26 Apr 2021 16:33:53 +0200
Message-Id: <20210426143353.2828160-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210426143353.2828160-1-u.kleine-koenig@pengutronix.de>
References: <20210426143353.2828160-1-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-spear.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index 6879b49581b3..3a4e52182251 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -229,9 +229,10 @@ static int spear_pwm_remove(struct platform_device *pdev)
 {
 	struct spear_pwm_chip *pc = platform_get_drvdata(pdev);
 
+	pwmchip_remove(&pc->chip);
+
 	/* clk was prepared in probe, hence unprepare it here */
 	clk_unprepare(pc->clk);
-	return pwmchip_remove(&pc->chip);
 }
 
 static const struct of_device_id spear_pwm_of_match[] = {
-- 
2.30.2

