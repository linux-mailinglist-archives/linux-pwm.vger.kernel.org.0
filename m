Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6A7C7315
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379542AbjJLQdC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379515AbjJLQc7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:32:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC01DA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:32:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycJ-0000go-Fo; Thu, 12 Oct 2023 18:32:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycJ-001CCJ-3F; Thu, 12 Oct 2023 18:32:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-00F5Vi-QW; Thu, 12 Oct 2023 18:32:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 106/109] pwm: Ensure a struct pwm has the same lifetime as its pwm_chip
Date:   Thu, 12 Oct 2023 18:32:35 +0200
Message-ID: <20231012163227.1004288-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3258; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MABZi+1MYJnTpQpdKmuRiKlf6KgSHQKwxsBkKGZgPKQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB+k/5sSjkwhZKLflrkQMcSpgwvAMu7vpCvMt fq1dGjXxPuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfpAAKCRCPgPtYfRL+ Tj0ACACQ2J4K3rwYcdwXpXeoLpT8O70gK/iyXpcjM07UYPfJJMMMLXjPXIRWhms0JFsX5K3GreX 5V3eZiPjGfzQXiK+Z++1MtxDeX3NFZv89avFtkBftHJkdMYG4eO9Oj4ley9Z544mcGe5ewgU1OJ TBmsRpVTm3bAOYDtNz7MzI4kXS43T09RojdRexu+7j/Y+wde/E3ebeS0qePuInPNIp8lbdiRg0W LZITyMhRXClxj3xH/8DxMfcn43bXWn3B95H/65Kl2sO3CIknneadoX+FxXQDV4IV9jdIdn1R+us bCn2JiXmv8NJ4Q9Byl96afx8QqVxIscPvgHwZG4vKbd1grCp
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

It's required to not free the memory underlying a requested PWM
while a consumer still has a reference to it. While currently a pwm_chip
doesn't life long enough in all cases, linking the struct pwm to the
pwm_chip results in the right lifetime as soon as the pwmchip is living
long enough. This happens with the following commits.

Note this is a breaking change for all pwm drivers that don't use
pwmchip_alloc().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 26 ++++++++++----------------
 include/linux/pwm.h |  2 +-
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e342a1d200fd..ab9eec80824e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -198,7 +198,7 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 
 void *pwmchip_priv(struct pwm_chip *chip)
 {
-	return (void *)chip + sizeof(*chip);
+	return (void *)chip + struct_size(chip, pwms, chip->npwm);
 }
 EXPORT_SYMBOL_GPL(pwmchip_priv);
 
@@ -206,8 +206,9 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 {
 	struct pwm_chip *chip;
 	size_t alloc_size;
+	unsigned int i;
 
-	alloc_size = size_add(sizeof(*chip), sizeof_priv);
+	alloc_size = size_add(struct_size(chip, pwms, npwm), sizeof_priv);
 
 	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
 	if (!chip)
@@ -217,6 +218,13 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
 
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		pwm->chip = chip;
+		pwm->hwpwm = i;
+	}
+
 	return chip;
 }
 EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
@@ -234,7 +242,6 @@ EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
 	int ret;
-	unsigned i;
 
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
 		return -EINVAL;
@@ -253,26 +260,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
-	if (!chip->pwms)
-		return -ENOMEM;
-
 	mutex_lock(&pwm_lock);
 
 	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		mutex_unlock(&pwm_lock);
-		kfree(chip->pwms);
 		return ret;
 	}
 
 	chip->id = ret;
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
-
-		pwm->chip = chip;
-		pwm->hwpwm = i;
-	}
 
 	mutex_unlock(&pwm_lock);
 
@@ -303,8 +299,6 @@ void pwmchip_remove(struct pwm_chip *chip)
 	idr_remove(&pwm_chips, chip->id);
 
 	mutex_unlock(&pwm_lock);
-
-	kfree(chip->pwms);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index aba86b7341e4..b9e0b9480c2c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -302,7 +302,7 @@ struct pwm_chip {
 
 	/* only used internally by the PWM framework */
 	bool uses_pwmchip_alloc;
-	struct pwm_device *pwms;
+	struct pwm_device pwms[] __counted_by(npwm);
 };
 
 static inline struct device *pwmchip_parent(struct pwm_chip *chip)
-- 
2.42.0

