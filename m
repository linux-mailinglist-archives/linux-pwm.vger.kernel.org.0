Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4BA3BEC2B
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhGGQbe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGGQbe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2926C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APr-0004Dz-De; Wed, 07 Jul 2021 18:28:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APq-0002cb-Qc; Wed, 07 Jul 2021 18:28:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APj-0006IU-IK; Wed, 07 Jul 2021 18:28:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 19/47] pwm: jz4740: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:07 +0200
Message-Id: <20210707162835.1772882-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
References: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This allows to drop the platform_driver's remove function. This is the
only user of driver data so this can go away, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 990e7904c7f1..23dc1fb770e2 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -245,16 +245,7 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	jz4740->chip.ops = &jz4740_pwm_ops;
 	jz4740->chip.npwm = info->num_pwms;
 
-	platform_set_drvdata(pdev, jz4740);
-
-	return pwmchip_add(&jz4740->chip);
-}
-
-static int jz4740_pwm_remove(struct platform_device *pdev)
-{
-	struct jz4740_pwm_chip *jz4740 = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&jz4740->chip);
+	return devm_pwmchip_add(dev, &jz4740->chip);
 }
 
 static const struct soc_info __maybe_unused jz4740_soc_info = {
@@ -280,7 +271,6 @@ static struct platform_driver jz4740_pwm_driver = {
 		.of_match_table = of_match_ptr(jz4740_pwm_dt_ids),
 	},
 	.probe = jz4740_pwm_probe,
-	.remove = jz4740_pwm_remove,
 };
 module_platform_driver(jz4740_pwm_driver);
 
-- 
2.30.2

