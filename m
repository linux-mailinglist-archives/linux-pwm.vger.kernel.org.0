Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDCF3AB055
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Jun 2021 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhFQJyO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Jun 2021 05:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhFQJyN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Jun 2021 05:54:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8267FC061574
        for <linux-pwm@vger.kernel.org>; Thu, 17 Jun 2021 02:52:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogm-0007OM-C6; Thu, 17 Jun 2021 11:51:56 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ltogl-0005N9-OR; Thu, 17 Jun 2021 11:51:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v1 1/6] pwm: tegra: Drop an if block with an always false condition
Date:   Thu, 17 Jun 2021 11:51:40 +0200
Message-Id: <20210617095145.163694-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
References: <20210617095145.163694-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=uKDpcaVAHsanbiMJOlBuB+k9djUzMNhqIvK24vQAz1A=; m=OVcTr4I9TtT8s+hw4T3RDRk7oFCvh3jXNeFG7aWFDT0=; p=csjapj2Ma+nRbzrWywX4bK9jxkuXpr6aRloVWA61ntA=; g=c42834cfa6a35dc85b8e8adbab59488eba522b6f
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDLGuwACgkQwfwUeK3K7AmIDwf/arM SKseuOwnHX3z1XvrTBRX2o5LH//HQiQJSdBlxZgEV9d2YA+CCk14iqYZhE6XU8RNvyfacGPjb7K6Y 70FYwfnNsyI09eZNXqEeFRHCANVaypyPrJxGA/3h0Us0uUDA6mN6MO62IhMm62DOye7+Ii9JZcOme 5orA3k+L8/oktMCXIHTgTJnaZJ7S3QfNKWCSwB3ISji4DhXYAn0BQAaFkdIPcEUzTwZkYuhExaMoR 1vvg/59l9Zyoh1XEYGyMmO7uuhRHVCM6YN+6uQIZLoDu4jTLM4svDir9gjQzLsE8bMxEzwP6kaUIJ kS/k7dSgqfUSOrjwOXmA9aeYrYPIXCg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

tegra_pwm_remove() is only called after tegra_pwm_probe() successfully
completed. In this case platform_set_drvdata() was called with a
non-NULL value and so platform_get_drvdata(pdev) cannot return NULL.

Returning an error code from a platform_driver's remove function is
ignored anyway, so it's a good thing this exit path is gone.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index c529a170bcdd..fa025795198b 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -303,9 +303,6 @@ static int tegra_pwm_remove(struct platform_device *pdev)
 	unsigned int i;
 	int err;
 
-	if (WARN_ON(!pc))
-		return -ENODEV;
-
 	err = clk_prepare_enable(pc->clk);
 	if (err < 0)
 		return err;
-- 
2.30.2

