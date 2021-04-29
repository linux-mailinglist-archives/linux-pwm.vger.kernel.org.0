Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4444936EB62
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhD2NdX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 09:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhD2NdX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 09:33:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B3DC06138B
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 06:32:36 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lc6mO-0004pS-PO; Thu, 29 Apr 2021 15:32:32 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lc6mM-0004se-Pr; Thu, 29 Apr 2021 15:32:30 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Vaibhav Bedia <vaibhav.bedia@ti.com>,
        Avinash Philip <avinashphilip@ti.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH] pwm: tiecap: Drop .free() callback
Date:   Thu, 29 Apr 2021 15:32:18 +0200
Message-Id: <20210429133218.66971-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

ecap_pwm_free is only called when a consumer releases the PWM (using
pwm_put() or pwm_free()). The consumer is expected to disable the PWM
before doing that. It's not clear if a warning about that is justified, but
if it is this is independent of the actual driver and can better be done in
the core. Also if there is a good reason it's wrong to disable the hardware
and so the call to pm_runtime_put_sync() should be dropped. Moreover there
is no matching pwm_runtime_get call and so the runtime usage counter might
become negative.

Fixes: 8e0cb05b3b75 ("pwm: pwm-tiecap: PWM driver support for ECAP APWM")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index b9a17ab0c202..134f0db28870 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -168,16 +168,7 @@ static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	pm_runtime_put_sync(pc->chip.dev);
 }
 
-static void ecap_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	if (pwm_is_enabled(pwm)) {
-		dev_warn(chip->dev, "Removing PWM device without disabling\n");
-		pm_runtime_put_sync(chip->dev);
-	}
-}
-
 static const struct pwm_ops ecap_pwm_ops = {
-	.free = ecap_pwm_free,
 	.config = ecap_pwm_config,
 	.set_polarity = ecap_pwm_set_polarity,
 	.enable = ecap_pwm_enable,

base-commit: a6efb35019d00f483a0e5f188747723371d659fe
-- 
2.30.2

