Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811A734D0B1
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 14:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhC2M7A (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 08:59:00 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:55426 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhC2M6s (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Mar 2021 08:58:48 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id AF5ACC72850;
        Mon, 29 Mar 2021 14:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617022726;
        bh=PSIXRmFBk+PjMaRg1ORkwMJsQqVzAdiySDzsAjkJOnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XlIEkXaEvoBe2BZDkrK+X2JJ/XanhIAIbz6GaJ90EvnyessGdY6ZEzrDeNRjHPJ3w
         01TFniVcm8X1iSD2lN967IHMxWmiWo9c1PRovV5wUcRIInVJiuAO8VTZ+1YFFtfgbG
         FGULS2rVJvThF/XUkd3p7Jho+CD3U/BjIEhMifu4=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v6 3/7] pwm: pca9685: Improve runtime PM behavior
Date:   Mon, 29 Mar 2021 14:57:03 +0200
Message-Id: <20210329125707.182732-3-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The chip does not come out of POR in active state but in sleep state.
To be sure (in case the bootloader woke it up) we force it to sleep in
probe.

On kernels without CONFIG_PM, we wake the chip in .probe and put it to
sleep in .remove.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index fb026a25fb61..4d6684b90819 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -469,14 +469,19 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	/* The chip comes out of power-up in the active state */
-	pm_runtime_set_active(&client->dev);
 	/*
-	 * Enable will put the chip into suspend, which is what we
-	 * want as all outputs are disabled at this point
+	 * The chip comes out of power-up in the sleep state,
+	 * but force it to sleep in case it was woken up before
 	 */
+	pca9685_set_sleep_mode(pca, true);
+	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_enable(&client->dev);
 
+	if (!IS_ENABLED(CONFIG_PM)) {
+		/* Wake the chip up on non-PM environments */
+		pca9685_set_sleep_mode(pca, false);
+	}
+
 	return 0;
 }
 
@@ -488,7 +493,14 @@ static int pca9685_pwm_remove(struct i2c_client *client)
 	ret = pwmchip_remove(&pca->chip);
 	if (ret)
 		return ret;
+
 	pm_runtime_disable(&client->dev);
+
+	if (!IS_ENABLED(CONFIG_PM)) {
+		/* Put chip in sleep state on non-PM environments */
+		pca9685_set_sleep_mode(pca, true);
+	}
+
 	return 0;
 }
 
-- 
2.31.1

