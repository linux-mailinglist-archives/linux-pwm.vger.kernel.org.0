Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3A3565F4
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 10:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhDGICh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 04:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbhDGICY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 04:02:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7146EC061756
        for <linux-pwm@vger.kernel.org>; Wed,  7 Apr 2021 01:02:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU38X-0002Jh-Gn; Wed, 07 Apr 2021 10:02:05 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU38W-0001y4-4t; Wed, 07 Apr 2021 10:02:04 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/3] pwm: Add a devm managed function to add pwm_chips
Date:   Wed,  7 Apr 2021 10:01:54 +0200
Message-Id: <20210407080155.55004-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407080155.55004-1-u.kleine-koenig@pengutronix.de>
References: <20210407080155.55004-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This potentially simplifies pwm lowlevel drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 19 +++++++++++++++++++
 include/linux/pwm.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a8eff4b3ee36..2ffceb69e00b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -383,6 +383,25 @@ int pwmchip_remove(struct pwm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
+static void devm_pwmchip_remove(void *data)
+{
+	struct pwm_chip *chip = data;
+
+	pwmchip_remove(chip);
+}
+
+int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip)
+{
+	int ret;
+
+	ret = pwmchip_add(chip);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pwmchip_remove, chip);
+}
+EXPORT_SYMBOL_GPL(devm_pwmchip_add);
+
 /**
  * pwm_request() - request a PWM device
  * @pwm: global PWM device index
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e4d84d4db293..00adafbbed9e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -396,6 +396,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 			      enum pwm_polarity polarity);
 int pwmchip_add(struct pwm_chip *chip);
 int pwmchip_remove(struct pwm_chip *chip);
+
+int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip);
+
 struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 					 unsigned int index,
 					 const char *label);
-- 
2.30.2

