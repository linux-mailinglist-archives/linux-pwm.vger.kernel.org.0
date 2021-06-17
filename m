Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF43AB04B
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jun 2021 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhFQJyG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Jun 2021 05:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFQJyG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jun 2021 05:54:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932AFC06175F
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 02:51:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogm-0007ON-F8; Thu, 17 Jun 2021 11:51:56 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogm-0005NC-58; Thu, 17 Jun 2021 11:51:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v1 2/6] pwm: tegra: Don't modify HW state in .remove callback
Date:   Thu, 17 Jun 2021 11:51:41 +0200
Message-Id: <20210617095145.163694-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
References: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=VfNe3gbqrMem5BNF3ebmnCF+wpEJ/fe7/8w5PJ00mzw=; m=jAdnEpvPpypB04bqjHgRIkr/nmRRuAyHaMjPOVeVBMc=; p=FKLLGtGeXIi1RBG3ck8zZWVjW1Z2WmJoUrjGBZvf9pc=; g=00bce45b038e47dd975e5396dd32c5c70f6ee9a7
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDLGvEACgkQwfwUeK3K7AmZ3wf+NO/ OW3sXIpfMHZslpi2l3NXKntVlU4keJjtl3149SyoD1tVDjaouPtjnouU1AxgRCnFtY5pyQVbbL+kg pTr/0R2b2CVYDHAWqW68wrmefcWvaJCFSD31q0hi8LD15wU6rYeDTLn+1qSSspP7sB6hVjhf9lfcZ bSBiQoJlRVnnfpMV45hn0e+Ou4QZbvKDcBq6SpELzKWXa/jIeFR/oJ12brhNeNVp1bQ0rz/YvAbLE CeTISR3MBhDiSsAuHdCqTBDoDzJfSmQLbFiwxpsTiWQl0yflA9NbBdIwV7wp/9azF2SDMOq6ijBtO VHmeU/zVc5xVD5tvIRNJFBl9KxlqtDg==
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
 drivers/pwm/pwm-tegra.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index fa025795198b..a051cf43e7d7 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -300,25 +300,12 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 static int tegra_pwm_remove(struct platform_device *pdev)
 {
 	struct tegra_pwm_chip *pc = platform_get_drvdata(pdev);
-	unsigned int i;
 	int err;
 
 	err = clk_prepare_enable(pc->clk);
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < pc->chip.npwm; i++) {
-		struct pwm_device *pwm = &pc->chip.pwms[i];
-
-		if (!pwm_is_enabled(pwm))
-			if (clk_prepare_enable(pc->clk) < 0)
-				continue;
-
-		pwm_writel(pc, i, 0);
-
-		clk_disable_unprepare(pc->clk);
-	}
-
 	reset_control_assert(pc->rst);
 	clk_disable_unprepare(pc->clk);
 
-- 
2.30.2

