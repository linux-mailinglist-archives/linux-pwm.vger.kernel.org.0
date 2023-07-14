Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9013E7543FE
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjGNU4g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 16:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbjGNU4f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 16:56:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929A31BD
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 13:56:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq4-000843-Cu; Fri, 14 Jul 2023 22:56:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq3-00EQSL-MQ; Fri, 14 Jul 2023 22:56:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq2-004u3l-JY; Fri, 14 Jul 2023 22:56:30 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 01/10] pwm: Use a consistent name for pwm_chip pointers in the core
Date:   Fri, 14 Jul 2023 22:56:14 +0200
Message-Id: <20230714205623.2496590-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4227; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mEWA9Jkb0Bf8N5tqYx1h6r7HN1WqhQMQeQ2SizptQls=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksbZnbiuWExRPNeRnQGXXd5iNHnc8pc+CGFDjL Qm3M/nRaqeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLG2ZwAKCRCPgPtYfRL+ TsUmB/0Sd7lidZRoRipLxDEJUgrRT9ccSkgSDTQfXviDzzvFm95i8FM97yoqNz2DXCe9Vp5HETD HTbTjrtK14xH/nS8AQOyoU1mdYxNK18hXmng1Tnp/Ot+6K0GwwFl7pMUVt4uNuGG7unXYxvhgaD 79z5go3lPyRiaZzC6QiRvNtKoc7QWSUXXFgdOqaS7zSrmPnfWpwxUq1/uw/HbNShm1bAQPC1ple 4yAEb4wRVQRJrRLB1CdGPCi8zTopEJQkCMEaklmS/Q0kb5VYB5N4sALP1AmfunhQACFCLERCvHv YLnHpmtT0b8W2Vjq/LF6qQLlo9JdafnJbM5gOvfh+vDd2+fN
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Most variables of type struct pwm_chip * are named "chip", there are
only three outliers called "pc". Change these three to "chip", too, for
consistency.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 28 ++++++++++++++--------------
 include/linux/pwm.h |  6 +++---
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3dacceaef4a9..8c798753c016 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -127,28 +127,28 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 }
 
 struct pwm_device *
-of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
+of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
-	if (pc->of_pwm_n_cells < 2)
+	if (chip->of_pwm_n_cells < 2)
 		return ERR_PTR(-EINVAL);
 
 	/* flags in the third cell are optional */
 	if (args->args_count < 2)
 		return ERR_PTR(-EINVAL);
 
-	if (args->args[0] >= pc->npwm)
+	if (args->args[0] >= chip->npwm)
 		return ERR_PTR(-EINVAL);
 
-	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
+	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
 	if (IS_ERR(pwm))
 		return pwm;
 
 	pwm->args.period = args->args[1];
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
-	if (pc->of_pwm_n_cells >= 3) {
+	if (chip->of_pwm_n_cells >= 3) {
 		if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
 			pwm->args.polarity = PWM_POLARITY_INVERSED;
 	}
@@ -158,18 +158,18 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
 
 struct pwm_device *
-of_pwm_single_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
+of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
-	if (pc->of_pwm_n_cells < 1)
+	if (chip->of_pwm_n_cells < 1)
 		return ERR_PTR(-EINVAL);
 
 	/* validate that one cell is specified, optionally with flags */
 	if (args->args_count != 1 && args->args_count != 2)
 		return ERR_PTR(-EINVAL);
 
-	pwm = pwm_request_from_chip(pc, 0, NULL);
+	pwm = pwm_request_from_chip(chip, 0, NULL);
 	if (IS_ERR(pwm))
 		return pwm;
 
@@ -692,7 +692,7 @@ static struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
 	struct pwm_device *pwm = NULL;
 	struct of_phandle_args args;
 	struct device_link *dl;
-	struct pwm_chip *pc;
+	struct pwm_chip *chip;
 	int index = 0;
 	int err;
 
@@ -709,16 +709,16 @@ static struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
 		return ERR_PTR(err);
 	}
 
-	pc = fwnode_to_pwmchip(of_fwnode_handle(args.np));
-	if (IS_ERR(pc)) {
-		if (PTR_ERR(pc) != -EPROBE_DEFER)
+	chip = fwnode_to_pwmchip(of_fwnode_handle(args.np));
+	if (IS_ERR(chip)) {
+		if (PTR_ERR(chip) != -EPROBE_DEFER)
 			pr_err("%s(): PWM chip not found\n", __func__);
 
-		pwm = ERR_CAST(pc);
+		pwm = ERR_CAST(chip);
 		goto put;
 	}
 
-	pwm = pc->of_xlate(pc, &args);
+	pwm = chip->of_xlate(chip, &args);
 	if (IS_ERR(pwm))
 		goto put;
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 04ae1d9073a7..d2f9f690a9c1 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -298,7 +298,7 @@ struct pwm_chip {
 	int base;
 	unsigned int npwm;
 
-	struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
+	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
 					const struct of_phandle_args *args);
 	unsigned int of_pwm_n_cells;
 
@@ -395,9 +395,9 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 					 unsigned int index,
 					 const char *label);
 
-struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
+struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *chip,
 		const struct of_phandle_args *args);
-struct pwm_device *of_pwm_single_xlate(struct pwm_chip *pc,
+struct pwm_device *of_pwm_single_xlate(struct pwm_chip *chip,
 				       const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
-- 
2.39.2

