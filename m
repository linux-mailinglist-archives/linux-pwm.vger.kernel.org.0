Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9EB7C72C0
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379535AbjJLQbN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379604AbjJLQbA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E20DA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-0004wQ-HG; Thu, 12 Oct 2023 18:30:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-001C7J-4X; Thu, 12 Oct 2023 18:30:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-00F5OF-Rk; Thu, 12 Oct 2023 18:30:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 032/109] pwm: tiecap: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:29:00 +0200
Message-ID: <20231012162827.1002444-143-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2823; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LN2OB9VE1UFtmFrUcdoFrTELX0rps2a9IGhLaL5RIOY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7RlvQjH4uv3j3iGICoC1VpsWgWqxbd5vil6 HY5ytPAtZuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge0QAKCRCPgPtYfRL+ TholB/kBZvuHmpiOAtW5CcfZAQoQg948elKm/D1ynHiIAoSn1m/J2izWmj2cjdXnRWR5V10JbmY h6aIRFHcLwqTrwBoIOzCv2EEAMD1WcHCikGJLojRtt0g3O8Vm6MLiEN2V8PNw6s75bBmJtdhmYh TPGwsomiu6trg3bsxgZyZ17eCaYEIq4Sx/wy0b2OUVi3baIIVk5bzc8P9uvZ7MiiTmgZrl7GOei V0xcVvsxqCFMXzN8nhbmwuhk9LHuifWzsbWzc15dNZqVnFkg9WtlKptqKCNpNaFQzpn/f0bUUIK mBGH1jW8o7tZ5vmWHnVDrwf7OMBEDWy7zgoxGBP76OLZThsi
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 11e3549cf103..d54b24c6b2ec 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -70,7 +70,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		duty_cycles = (u32)c;
 	}
 
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -100,7 +100,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		writew(value, pc->mmio_base + ECCTL2);
 	}
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
 	u16 value;
 
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -124,7 +124,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writew(value, pc->mmio_base + ECCTL2);
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -135,7 +135,7 @@ static int ecap_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u16 value;
 
 	/* Leave clock enabled on enabling PWM */
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/*
 	 * Enable 'Free run Time stamp counter mode' to start counter
@@ -162,7 +162,7 @@ static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	writew(value, pc->mmio_base + ECCTL2);
 
 	/* Disable clock on PWM disable */
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 }
 
 static int ecap_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -272,11 +272,11 @@ static void ecap_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static void ecap_pwm_save_context(struct ecap_pwm_chip *pc)
 {
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(&pc->chip));
 	pc->ctx.ecctl2 = readw(pc->mmio_base + ECCTL2);
 	pc->ctx.cap4 = readl(pc->mmio_base + CAP4);
 	pc->ctx.cap3 = readl(pc->mmio_base + CAP3);
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(&pc->chip));
 }
 
 static void ecap_pwm_restore_context(struct ecap_pwm_chip *pc)
-- 
2.42.0

