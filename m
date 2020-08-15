Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34DF2452BA
	for <lists+linux-pwm@lfdr.de>; Sat, 15 Aug 2020 23:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgHOVym (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 15 Aug 2020 17:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgHOVwd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 15 Aug 2020 17:52:33 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Aug 2020 09:37:04 PDT
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58909C0A3BEA
        for <linux-pwm@vger.kernel.org>; Sat, 15 Aug 2020 09:37:04 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4BTQmt2DWMzKmXD;
        Sat, 15 Aug 2020 18:31:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 9VhQ0SUOjLAD; Sat, 15 Aug 2020 18:31:38 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
Cc:     ed.blake@sondrel.com, linux-pwm@vger.kernel.org, wigyori@uid0.hu,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] pwm: img: Fix null pointer access in probe
Date:   Sat, 15 Aug 2020 18:31:15 +0200
Message-Id: <20200815163115.11376-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: **
X-Rspamd-Score: 1.84 / 15.00 / 15.00
X-Rspamd-Queue-Id: 0E2B31816
X-Rspamd-UID: bfd695
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

dev_get_drvdata() is called in img_pwm_runtime_resume() before the
driver data is set.
When pm_runtime_enabled() returns false in img_pwm_probe() it calls
img_pwm_runtime_resume() which results in a null pointer access.

This patch fixes the problem by setting the driver data earlier in the
img_pwm_probe() function.

Fixes: e690ae526216 ("pwm: img: Add runtime PM")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/pwm/pwm-img.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 599a0f66a384..11831e885e1b 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -277,6 +277,8 @@ static int img_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pwm->pwm_clk);
 	}
 
+	platform_set_drvdata(pdev, pwm);
+
 	pm_runtime_set_autosuspend_delay(&pdev->dev, IMG_PWM_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -313,7 +315,6 @@ static int img_pwm_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	platform_set_drvdata(pdev, pwm);
 	return 0;
 
 err_suspend:
@@ -322,6 +323,7 @@ static int img_pwm_probe(struct platform_device *pdev)
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	platform_set_drvdata(pdev, NULL);
 	return ret;
 }
 
-- 
2.20.1

