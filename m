Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A72734E795
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Mar 2021 14:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhC3MiU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Mar 2021 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhC3Mhs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Mar 2021 08:37:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BDAC061574
        for <linux-pwm@vger.kernel.org>; Tue, 30 Mar 2021 05:37:48 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lRDcw-0005AV-C2; Tue, 30 Mar 2021 14:37:46 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lRDcu-0003Kk-Gb; Tue, 30 Mar 2021 14:37:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: sti: Don't modify HW state in .remove callback
Date:   Tue, 30 Mar 2021 14:37:41 +0200
Message-Id: <20210330123742.190540-1-u.kleine-koenig@pengutronix.de>
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

A consumer is expected to disable a PWM before calling pwm_put(). And if
they didn't there is hopefully a good reason (or the consumer needs
fixing). Also if disabling an enabled PWM was the right thing to do,
this should better be done in the framework instead of in each low level
driver.

So drop the hardware modification from the .remove() callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index aa2b211d7ee3..3064b320df93 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -649,10 +649,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 static int sti_pwm_remove(struct platform_device *pdev)
 {
 	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
-	unsigned int i;
 
-	for (i = 0; i < pc->cdata->pwm_num_devs; i++)
-		pwm_disable(&pc->chip.pwms[i]);
 
 	clk_unprepare(pc->pwm_clk);
 	clk_unprepare(pc->cpt_clk);
-- 
2.30.2

