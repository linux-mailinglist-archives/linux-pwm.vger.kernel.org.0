Return-Path: <linux-pwm+bounces-948-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E997683C1B1
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115601C2259E
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BAA44368;
	Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6D36122
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184646; cv=none; b=J1jR8VuT305mM/foaor+N3HHjCJjdNxQR7Wh8vgRbRRe6yiXKd0dGE8NvMm7sIDJyyoxvt+lXP1n0SXdUg5KYh5ujIxmkuOBdn3OeYYkkagu2pgknkD9esXqUCGqdQ0LfAS5EDw4bi26bzX9+0jgGBt2pNgVq2eqdXI2k0ne/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184646; c=relaxed/simple;
	bh=7tDaD4CecxF28S1Gp28VV/OASo0T1rpBvmxWTJfwuDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2n7RsBPYUZ3h58/F4qByjmYLBYVEN5C7Qd/hXMH+D6dHjsJryQ86yHqNqMdarpxB0GKzFPrjJlhYJTbQQS7/JKpSrFJS8pQMaawzu23SjCx7hzQE4R/b/axyFV1f9VCo/GzOOsshf7ndLsOpGUJ0CDszQJRC3dHsDLWjNB+sT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-0003Zi-1L; Thu, 25 Jan 2024 13:10:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ6-002HOx-L6; Thu, 25 Jan 2024 13:10:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ6-007myJ-1s;
	Thu, 25 Jan 2024 13:10:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 004/111] pwm: ab8500: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:26 +0100
Message-ID:  <385fd6cbf5ee2fbbc603bff941b648e8d952d399.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3155; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=7tDaD4CecxF28S1Gp28VV/OASo0T1rpBvmxWTJfwuDk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRN/nZeOw7xcecnBjF90bUSEDIs/bg2Sbvcc/pW+aCq0 NkL82M6GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZiIRC/7fxcTZzOnN4+czwTt 8mu/lbDj2bSLnez9rLbbdt0oD1lbWBOmd0ok8nVuR6vSnxLVFW02X3bKPdxystBhc8ON2/EP9c/ pWtRG5Je01b4N4m9NsVsvsfdt5M/kXr84y9qb87jSE1SaFmYcS9y/+ePS1qLQWj/DwA/SGfyq5V pTD4QencDsqvnt9NklX85qcl3WfKJlaXGtd9Pz+lo5Z762XFZz3avn825O7XyluGvRBOONuXI+D x1UbMLei55l1qlc4dZx2rLOzNfized3lcntm36t2LW2/5gcc4b/h183OPSeOBzz0Ha9sGhTj4lA 8b2A7o5Ixwd6qyqW/1LgiVr39Edq47pzoleNu9eanM4BAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 670d33daea84..719e4ccf1800 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -92,12 +92,12 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * when disabled.
 	 */
 	if (!state->enabled || duty_steps == 0) {
-		ret = abx500_mask_and_set_register_interruptible(chip->dev,
+		ret = abx500_mask_and_set_register_interruptible(pwmchip_parent(chip),
 					AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 					1 << ab8500->hwid, 0);
 
 		if (ret < 0)
-			dev_err(chip->dev, "%s: Failed to disable PWM, Error %d\n",
+			dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM, Error %d\n",
 								pwm->label, ret);
 		return ret;
 	}
@@ -115,22 +115,22 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	reg = AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2);
 
-	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_set_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 			reg, lower_val);
 	if (ret < 0)
 		return ret;
 
-	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_set_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 			(reg + 1), higher_val);
 	if (ret < 0)
 		return ret;
 
 	/* enable */
-	ret = abx500_mask_and_set_register_interruptible(chip->dev,
+	ret = abx500_mask_and_set_register_interruptible(pwmchip_parent(chip),
 				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 				1 << ab8500->hwid, 1 << ab8500->hwid);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM, Error %d\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM, Error %d\n",
 							pwm->label, ret);
 
 	return ret;
@@ -144,7 +144,7 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ab8500_pwm_chip *ab8500 = ab8500_pwm_from_chip(chip);
 	unsigned int div, duty_steps;
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL7_REG,
 						&ctrl7);
 	if (ret)
@@ -157,13 +157,13 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2),
 						&lower_val);
 	if (ret)
 		return ret;
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL2_REG + (ab8500->hwid * 2),
 						&higher_val);
 	if (ret)
-- 
2.43.0


