Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09958175F19
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Mar 2020 17:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgCBQFC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Mar 2020 11:05:02 -0500
Received: from foss.arm.com ([217.140.110.172]:34626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbgCBQFC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 2 Mar 2020 11:05:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B095C2F;
        Mon,  2 Mar 2020 08:05:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 303643F534;
        Mon,  2 Mar 2020 08:05:01 -0800 (PST)
Date:   Mon, 02 Mar 2020 16:04:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Applied "regulator: pwm: Don't warn on probe deferral" to the regulator tree
In-Reply-To:  <20200302141428.14119-1-jonathanh@nvidia.com>
Message-Id:  <applied-20200302141428.14119-1-jonathanh@nvidia.com>
X-Patchwork-Hint: ignore
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The patch

   regulator: pwm: Don't warn on probe deferral

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 0cd71b9a43ad80f4d9a8bfde6ec6db8daf447029 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jonathanh@nvidia.com>
Date: Mon, 2 Mar 2020 14:14:28 +0000
Subject: [PATCH] regulator: pwm: Don't warn on probe deferral

Deferred probe is an expected return value for devm_pwm_get(). Given
that the driver deals with it properly, rather than warn on probe
deferral, only output a message on probe deferral if debug level
prints are enabled.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20200302141428.14119-1-jonathanh@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pwm-regulator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index e74e11101fc1..638329bd0745 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -354,7 +354,11 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	drvdata->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(drvdata->pwm)) {
 		ret = PTR_ERR(drvdata->pwm);
-		dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(&pdev->dev,
+				"Failed to get PWM, deferring probe\n");
+		else
+			dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
 		return ret;
 	}
 
-- 
2.20.1

