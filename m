Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC72DB5DA
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Dec 2020 22:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgLOV2t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Dec 2020 16:28:49 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:54778 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgLOV2N (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Dec 2020 16:28:13 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 8B414C727E0;
        Tue, 15 Dec 2020 22:27:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1608067648;
        bh=LxJvhwlUf9lRUgb/k0fnj/AV++LyinyiB1CxyKFrzr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfAsdYFZv58AHJqoWc1wfwsA49WCN3pPl1+pC+8TKjuj4URm5WPjb/sS2V0aYyiEA
         ZWFAoFWd/2CbpLWSoWLACE9Ez7D/VOeL7IicfMu83THFBoGzXXd3TZRExa0OmiNch1
         /WbYz9y2OQvtdlDzUvFOeYkn+c+sGOU9X5x4zbL0=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v5 3/7] pwm: pca9685: Improve runtime PM behavior
Date:   Tue, 15 Dec 2020 22:22:24 +0100
Message-Id: <20201215212228.185517-3-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
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
index b3398963c0ff..7b14447f3c05 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -467,14 +467,19 @@ static int pca9685_pwm_probe(struct i2c_client *client,
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
 
@@ -486,7 +491,14 @@ static int pca9685_pwm_remove(struct i2c_client *client)
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
2.29.2

