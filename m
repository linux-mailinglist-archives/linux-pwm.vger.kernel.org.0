Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F27A756653
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jul 2023 16:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGQO2I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Jul 2023 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjGQO2E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Jul 2023 10:28:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F7DE4F
        for <linux-pwm@vger.kernel.org>; Mon, 17 Jul 2023 07:28:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLPCb-0003bC-SL; Mon, 17 Jul 2023 16:27:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLPCa-0009vu-S8; Mon, 17 Jul 2023 16:27:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLPCa-005cIf-5a; Mon, 17 Jul 2023 16:27:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] gpio: mvebu: Make use of devm_pwmchip_add
Date:   Mon, 17 Jul 2023 16:27:43 +0200
Message-Id: <20230717142743.2555739-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ejT5aQfyA6pTJ5H2R38jzRs4Yj8LSNb3pnMNxNOdQXA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBktU/cZJijdnTRp4/hOtMpOlsUGVrnLTOM0CRqU RPmgdC3RFWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLVP3AAKCRCPgPtYfRL+ TioqB/9KNmCU+lO7rs8CcBvE1XEZZtttTPSQSkCXa5kt9mJxFeOhkcrRevOx2HEDjZqc4rQkFWJ tmafWkI0rZ6xg+AWUBFTQA2O10NVi6XuZ1EOQD27AIw3VrcpyUNDiI8vnQMPOOrAAG2wvNST92a Ir7KGEnE5HztL8rqkUhww5ZyzqGI7B4t3sMKv4MwDKhybJJCPK+fYMSYaKzmshx/751KnPVHlWL 1ct/VwDs2aTDqzd6GbSrRt4llCai+iLws6DXf2K3ugHNLHKHJdya3uSR4SdkgmujPR0Ovm7pmkV nUi9B6B9kuxFr/kYcX/xNuMLgwc0+M5CuLdl4TG3DlPQgovP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This allows to get rid of a call to pwmchip_remove() in the error path. There
is no .remove function for this driver, so this change fixes a resource leak
when a gpio-mvebu device is unbound.

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

Note that irq_domain_remove() also isn't called so there is another
resource leak introduced by 812d47889a8e ("gpio/mvebu: Use
irq_domain_add_linear")

 drivers/gpio/gpio-mvebu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a68f682aec01..a35958e7adf6 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -874,7 +874,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 
 	spin_lock_init(&mvpwm->lock);
 
-	return pwmchip_add(&mvpwm->chip);
+	return devm_pwmchip_add(dev, &mvpwm->chip);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -1243,8 +1243,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	if (!mvchip->domain) {
 		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
 			mvchip->chip.label);
-		err = -ENODEV;
-		goto err_pwm;
+		return -ENODEV;
 	}
 
 	err = irq_alloc_domain_generic_chips(
@@ -1296,9 +1295,6 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 
 err_domain:
 	irq_domain_remove(mvchip->domain);
-err_pwm:
-	pwmchip_remove(&mvchip->mvpwm->chip);
-
 	return err;
 }
 

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2

