Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333163419F6
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Mar 2021 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCSK31 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Mar 2021 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCSK3C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Mar 2021 06:29:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D982C06175F
        for <linux-pwm@vger.kernel.org>; Fri, 19 Mar 2021 03:29:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNCNI-0003hq-CO; Fri, 19 Mar 2021 11:29:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNCNI-0001gO-2m; Fri, 19 Mar 2021 11:29:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 02/14] pwm: bcm-kona: Use pwmchip_add() instead of pwmchip_add_with_polarity()
Date:   Fri, 19 Mar 2021 11:28:40 +0100
Message-Id: <20210319102852.101209-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
References: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
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

From: Uwe Kleine-König <uwe@kleine-koenig.org>

The only side effect of this change is that pwm->state.polarity is
initialized to PWM_POLARITY_NORMAL instead of PWM_POLARITY_INVERSED.
However all other members of pwm->state are uninitialized and consumers
are expected to provide the right polarity (either by setting it explicitly
or by using a helper like pwm_init_state() that overwrites .polarity
anyhow with a value independent of the initial value).

The eventual goal is to remove pwmchip_add_with_polarity() and so simplify
the data flow in the PWM core.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Link: https://lore.kernel.org/r/20201207134556.25217-2-uwe@kleine-koenig.org
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 578b3621c97e..717b55677573 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -301,7 +301,7 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(kp->clk);
 
-	ret = pwmchip_add_with_polarity(&kp->chip, PWM_POLARITY_INVERSED);
+	ret = pwmchip_add(&kp->chip);
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 
-- 
2.30.1

