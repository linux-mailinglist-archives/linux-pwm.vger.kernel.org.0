Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A23BEC36
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhGGQbm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhGGQbl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EFFC06175F
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:29:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APz-0004dn-97; Wed, 07 Jul 2021 18:28:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APy-0002dw-Oa; Wed, 07 Jul 2021 18:28:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APj-0006IO-8T; Wed, 07 Jul 2021 18:28:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 17/47] pwm: intel-lgm: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:05 +0200
Message-Id: <20210707162835.1772882-18-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-intel-lgm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
index 015f5eba09a1..b66c35074087 100644
--- a/drivers/pwm/pwm-intel-lgm.c
+++ b/drivers/pwm/pwm-intel-lgm.c
@@ -176,8 +176,6 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, pc);
-
 	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
@@ -210,20 +208,13 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 
 	lgm_pwm_init(pc);
 
-	ret = pwmchip_add(&pc->chip);
+	ret = devm_pwmchip_add(dev, &pc->chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
 
 	return 0;
 }
 
-static int lgm_pwm_remove(struct platform_device *pdev)
-{
-	struct lgm_pwm_chip *pc = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&pc->chip);
-}
-
 static const struct of_device_id lgm_pwm_of_match[] = {
 	{ .compatible = "intel,lgm-pwm" },
 	{ }
@@ -236,7 +227,6 @@ static struct platform_driver lgm_pwm_driver = {
 		.of_match_table = lgm_pwm_of_match,
 	},
 	.probe = lgm_pwm_probe,
-	.remove = lgm_pwm_remove,
 };
 module_platform_driver(lgm_pwm_driver);
 
-- 
2.30.2

