Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312ED2D704
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2019 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfE2Hw4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 May 2019 03:52:56 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:28844 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbfE2Hw4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 May 2019 03:52:56 -0400
X-IronPort-AV: E=Sophos;i="5.60,526,1549897200"; 
   d="scan'208";a="17264017"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 May 2019 16:52:52 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A79D34003EA5;
        Wed, 29 May 2019 16:52:52 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 4/4] pwm: rcar: Remove suspend/resume support
Date:   Wed, 29 May 2019 16:48:02 +0900
Message-Id: <1559116082-9851-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1559116082-9851-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

According to the Documentation/pwm.txt, all PWM consumers should
implement power management instead of the PWM driver. So, this
patch removes suspend/resume support.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index cfe7dd1..5b2b8ec 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -254,50 +254,11 @@ static const struct of_device_id rcar_pwm_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
 
-#ifdef CONFIG_PM_SLEEP
-static struct pwm_device *rcar_pwm_dev_to_pwm_dev(struct device *dev)
-{
-	struct rcar_pwm_chip *rcar_pwm = dev_get_drvdata(dev);
-	struct pwm_chip *chip = &rcar_pwm->chip;
-
-	return &chip->pwms[0];
-}
-
-static int rcar_pwm_suspend(struct device *dev)
-{
-	struct pwm_device *pwm = rcar_pwm_dev_to_pwm_dev(dev);
-
-	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
-		return 0;
-
-	pm_runtime_put(dev);
-
-	return 0;
-}
-
-static int rcar_pwm_resume(struct device *dev)
-{
-	struct pwm_device *pwm = rcar_pwm_dev_to_pwm_dev(dev);
-	struct pwm_state state;
-
-	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
-		return 0;
-
-	pm_runtime_get_sync(dev);
-
-	pwm_get_state(pwm, &state);
-
-	return rcar_pwm_apply(pwm->chip, pwm, &state);
-}
-#endif /* CONFIG_PM_SLEEP */
-static SIMPLE_DEV_PM_OPS(rcar_pwm_pm_ops, rcar_pwm_suspend, rcar_pwm_resume);
-
 static struct platform_driver rcar_pwm_driver = {
 	.probe = rcar_pwm_probe,
 	.remove = rcar_pwm_remove,
 	.driver = {
 		.name = "pwm-rcar",
-		.pm	= &rcar_pwm_pm_ops,
 		.of_match_table = of_match_ptr(rcar_pwm_of_table),
 	}
 };
-- 
2.7.4

