Return-Path: <linux-pwm+bounces-1355-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8968545A8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD621F2E08C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1461B18EAF;
	Wed, 14 Feb 2024 09:34:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDB18045
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903270; cv=none; b=nahxzNTjcceqsOODti1XJDXAAIZU3HnrIk52wLvlygyCnIZlKjXRb5f0FTCj/vJA9VbP/SkhuDzO4PysDRaEDrWmm234wjq8uFXL8nd2/zeOK/7DFcXftqjc7E73KsdFbh8YRd9nvO/LS98IVOqRN2yk/wLGXadDkaigDDg+wtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903270; c=relaxed/simple;
	bh=+LrONjxGFb9I2uGHvT1bKOWS8UxS153xkpBFSv15STU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gb54B6+pmLRdMwJ0AFqat41wKwiRe9EvD2VCGoVAxznManhjinlqkpuzRUH20f3E5OiP4jAEGiINh0F818U2mwGoi0NQQEGhAo8qcSkT9BGPF4rVroQCxuuSv5hXpJ/9E8JSINhC8SWc4e0quNmvF4uVFhJ0w5sQpAiZ3YnVR2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-0004eD-8e; Wed, 14 Feb 2024 10:34:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-000fB2-Kq; Wed, 14 Feb 2024 10:34:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-004Y2D-1p;
	Wed, 14 Feb 2024 10:34:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 037/164] pwm: fsl-ftm: Change prototype of a helper to prepare further changes
Date: Wed, 14 Feb 2024 10:31:24 +0100
Message-ID:  <5f0e88afe25d6a218032891a34f963980814b760.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1925; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+LrONjxGFb9I2uGHvT1bKOWS8UxS153xkpBFSv15STU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIh0/iU9mFQ8uWZa4hyrI8mATDbVT0Y7hIxpJ jrlHaxyXE6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIdAAKCRCPgPtYfRL+ TrqtB/9SyGffjI87/0v8Lh04wN63oXxQrEnVwIcOcfrylJgFwC/Hf/VofRA16Q/EugFqlKagkPj GrKQ+bEGe8YXpQL2blaV+o8sbLSSY9R0Ek8QExtk2Fw+voxRXaF3yn4TzvoBsEfI+8RVoPUSvFD po/bmybAfFC7Cqq/FPBh+BQrs53jo1TRY8NnFTfFbkJif3XeMl2uq8o/gLhaA64wTzEqt9j5CCQ A94W1YjpoWplSBtJLoI6wbvKxT5UCv+jdRW9ebi1nNfmaGrGpwsa5FgK+IlMEWyBHTe5M32ylCV 8/aKMngKYDwi+9gMOkCJQ+DBG5NCBUOlWqL/otSgyBIWS62d
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will make it harder to
determine the pwm_chip from a given fsl_pwm_chip. To just not have to
do that, rework fsl_pwm_apply_config() to take a pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index d1b6d1aa4773..5792c6ca449f 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -221,10 +221,11 @@ static bool fsl_pwm_is_other_pwm_enabled(struct fsl_pwm_chip *fpc,
 		return false;
 }
 
-static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
+static int fsl_pwm_apply_config(struct pwm_chip *chip,
 				struct pwm_device *pwm,
 				const struct pwm_state *newstate)
 {
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	unsigned int duty;
 	u32 reg_polarity;
 
@@ -232,7 +233,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	bool do_write_period = false;
 
 	if (!fsl_pwm_calculate_period(fpc, newstate->period, &periodcfg)) {
-		dev_err(fpc->chip.dev, "failed to calculate new period\n");
+		dev_err(chip->dev, "failed to calculate new period\n");
 		return -EINVAL;
 	}
 
@@ -246,7 +247,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	 */
 	else if (!fsl_pwm_periodcfg_are_equal(&fpc->period, &periodcfg)) {
 		if (fsl_pwm_is_other_pwm_enabled(fpc, pwm)) {
-			dev_err(fpc->chip.dev,
+			dev_err(chip->dev,
 				"Cannot change period for PWM %u, disable other PWMs first\n",
 				pwm->hwpwm);
 			return -EBUSY;
@@ -322,7 +323,7 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		goto end_mutex;
 	}
 
-	ret = fsl_pwm_apply_config(fpc, pwm, newstate);
+	ret = fsl_pwm_apply_config(chip, pwm, newstate);
 	if (ret)
 		goto end_mutex;
 
-- 
2.43.0


