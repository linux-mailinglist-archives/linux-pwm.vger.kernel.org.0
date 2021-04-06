Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5CD35596D
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346553AbhDFQnp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbhDFQnm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 12:43:42 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE2C06174A;
        Tue,  6 Apr 2021 09:43:34 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 0BB3BC6B19E;
        Tue,  6 Apr 2021 18:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617727413;
        bh=xqQD0/lOi/rZHdcAzLBmtbxzS06ML0IpAzpSqNIcug0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QUM/Z+/n79L/8705eRG8U+kAT4tdwofZziHRGhU9BFjbRfgXVO5ESpiJ2T4np1n3P
         6CKgeBDvoDKNaxTG1a6MwLK4YPvILLXlUYzhOUSsTo9xZVJYjvxjbYk3pD+hSPFUi2
         tYcLiibcDlVJqQpvJVcpxWoYm1DJrO+js2QH288A=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v7 3/8] pwm: pca9685: Improve runtime PM behavior
Date:   Tue,  6 Apr 2021 18:41:35 +0200
Message-Id: <20210406164140.81423-3-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
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
Changes since v6:
- Improved !CONFIG_PM handling (wake it up without putting it to sleep
  first)

 drivers/pwm/pwm-pca9685.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index d4474c5ff96f..0bcec04b138a 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -474,13 +474,18 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	/* The chip comes out of power-up in the active state */
-	pm_runtime_set_active(&client->dev);
-	/*
-	 * Enable will put the chip into suspend, which is what we
-	 * want as all outputs are disabled at this point
-	 */
-	pm_runtime_enable(&client->dev);
+	if (IS_ENABLED(CONFIG_PM)) {
+		/*
+		 * The chip comes out of power-up in the sleep state,
+		 * but force it to sleep in case it was woken up before
+		 */
+		pca9685_set_sleep_mode(pca, true);
+		pm_runtime_set_suspended(&client->dev);
+		pm_runtime_enable(&client->dev);
+	} else {
+		/* Wake the chip up on non-PM environments */
+		pca9685_set_sleep_mode(pca, false);
+	}
 
 	return 0;
 }
@@ -493,7 +498,14 @@ static int pca9685_pwm_remove(struct i2c_client *client)
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

