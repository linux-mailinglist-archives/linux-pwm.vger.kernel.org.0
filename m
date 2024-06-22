Return-Path: <linux-pwm+bounces-2589-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037959135D1
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jun 2024 21:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B1F1C21AC8
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Jun 2024 19:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D83EA9A;
	Sat, 22 Jun 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iwH+mqwh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCA3F9ED;
	Sat, 22 Jun 2024 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719083716; cv=none; b=rSaOBADFYZmFA8eM3aOvat37v3s3zwyLxyWUsSIJ5RV/YeRKyx6XJB9Z19sLr4CXSCTf4K4b4K1R/V/gjAKetXhBavVmzGhLsBG5jiYJDn0SMJNrnAQNxRW6iXWTnYybWKX7G1GPhFVsWFqgsHyyqfueU7ZLdXTRcAueOV3Buok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719083716; c=relaxed/simple;
	bh=OJ2V+euWEoULrwT0p80XI95Wpv9koSUoqxifq6pJL/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b90zs2NUc0dwAXx7DierpfeCOZuxZy/BS58sOJiKWwYddqEYZSqM+FoT+ggrZ54w1GWKa/4uoTgt4W/bDuomoMGG+ZtiLkBgF8swY6x/ksrUdPWfStFJahO9cxAY7mMHupOAm9mKzSYrGHYOD2dRgn9FaejDripXrLp88CXnUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iwH+mqwh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so3540282a12.1;
        Sat, 22 Jun 2024 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1719083712; x=1719688512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4ES69WkrFwdTGbyOiRVnj6dzOkk/bTtElKaUx+1C50=;
        b=iwH+mqwhkP0lp2AGcx92oBM0AYcrhQpW+41xpHnfM+lVdZ43RTmMoJRGOL5cd+JVea
         Ls7yx20zbtOiOkjPVaLvOfwNDtXHfMKNRK0AxqLbyuqhoNV6pDrQyF1NccWR4VlbHEyt
         N0uIIqOljiYuVFGz8Bfjca21C6yP9DBBbYlqXn9hSelBVCSz7yMnG9nLWGeZkf1pqWmM
         crlYa9n92oiCMfgn7vimIY00m89tuRwJ+mgxboDGkQpESkPOachGgdIwRYpG3ZOV19V+
         WZAAWEAdkrAyyuB5xCTjA649tYl26kRaR4XgCyZC7OFmWaugpmsbX34bb48dFPc5NJhO
         TePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719083712; x=1719688512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4ES69WkrFwdTGbyOiRVnj6dzOkk/bTtElKaUx+1C50=;
        b=m4PetbF7yeu6VWNB2WKUDCSwDmjiFJ2FzXEEEKhsEenQYqnJPHOCnDCv78b/i0UVBr
         GZtNS/OiXX7vnWj3mMR+BHae4+2yBAdV3tsI7YJdIokB7uyIin1sewejxZyvGWAIzbmb
         7XWBKkc+sQFXmZuHgzwQmq6wblVSdvqBN1eERowNKSQRRVZ4quuGrkEhShL6t2STcaue
         KY9V1lMmduWyjxK62JqjNRC6395vSkG/zfPn7XRmzabdhThm79726TF2XergxsiQnRzG
         vWpczsUpCWsYaivkERO9LZHATqiSvk4RgtbU39XJXQTnSPq/U/gCpWQfF0hvn46lRCmA
         y1TQ==
X-Gm-Message-State: AOJu0YwdowSqgEa64Z8Am/NWh5uKeCeW/ofhwy3HQhHAEeU3fefalPkb
	XrnkGInOTLo67hLxgCUyAvHepnRygoyPEohJGWLbJ+PqOIyT5nwQIFBz0A==
X-Google-Smtp-Source: AGHT+IE/aEN5405thMB9Jw9q+JW3MzuP6923th5rkZqO4lxXaZ8una7/1mQfiCk+GTc1xmis2hGt9w==
X-Received: by 2002:a50:aada:0:b0:57d:397:d0b7 with SMTP id 4fb4d7f45d1cf-57d4bdd0ac8mr401987a12.37.1719083711872;
        Sat, 22 Jun 2024 12:15:11 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b8d-b000-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b8d:b000::e63])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57d3048b923sm2726508a12.55.2024.06.22.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 12:15:11 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [RFC PATCH v2] regulator: pwm-regulator: Make assumptions about disabled PWM consistent
Date: Sat, 22 Jun 2024 21:15:04 +0200
Message-ID: <20240622191504.38374-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Generally it's not known how a disabled PWM behaves. However if the
bootloader hands over a disabled PWM that drives a regulator and it's
claimed the regulator is enabled, then the most likely assumption is
that the PWM emits the inactive level. This is represented by duty_cycle
= 0 even for .polarity == PWM_POLARITY_INVERSED.

Change the implementation to always use duty_cycle = 0, regardless of
the polarity. Also update the code so it keeps a copy of the pwm_state
around. Both of these changes result in the fact that the logic from
pwm_regulator_init_boot_on() is much less complex and can be simplified
to a point where the whole function is not needed anymore.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes from v1 [0] (which was sent by Uwe):
- keep the struct pwm_state around to prevent a regression on Meson8b
  Odroid-C1 boards where just calling pwm_enable() without adjusting
  the duty_cycle to 0 would hang the board
- I'm actively looking for input on the commit description and
  suggestions whether/why Fixes tags should be applied


[0] https://lore.kernel.org/lkml/CAFBinCB+S1wOpD-fCbcTORqXSV00Sd7-1GHUKY+rO859_dkhOA@mail.gmail.com/T/


 drivers/regulator/pwm-regulator.c | 119 ++++++++++++++----------------
 1 file changed, 55 insertions(+), 64 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 7434b6b22d32..5ea354a0654a 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -41,6 +41,8 @@ struct pwm_regulator_data {
 
 	/* Enable GPIO */
 	struct gpio_desc *enb_gpio;
+
+	struct pwm_state pwm_state;
 };
 
 struct pwm_voltages {
@@ -48,18 +50,33 @@ struct pwm_voltages {
 	unsigned int dutycycle;
 };
 
+static int pwm_regulator_apply_state(struct regulator_dev *rdev,
+				     struct pwm_state *new_state)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pwm_apply_might_sleep(drvdata->pwm, new_state);
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret);
+		return ret;
+	}
+
+	drvdata->pwm_state = *new_state;
+
+	return 0;
+}
+
 /*
  * Voltage table call-backs
  */
 static void pwm_regulator_init_state(struct regulator_dev *rdev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
-	struct pwm_state pwm_state;
 	unsigned int dutycycle;
 	int i;
 
-	pwm_get_state(drvdata->pwm, &pwm_state);
-	dutycycle = pwm_get_relative_duty_cycle(&pwm_state, 100);
+	dutycycle = pwm_get_relative_duty_cycle(&drvdata->pwm_state, 100);
 
 	for (i = 0; i < rdev->desc->n_voltages; i++) {
 		if (dutycycle == drvdata->duty_cycle_table[i].dutycycle) {
@@ -83,18 +100,15 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
 					 unsigned selector)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
-	struct pwm_state pstate;
+	struct pwm_state pstate = drvdata->pwm_state;
 	int ret;
 
-	pwm_init_state(drvdata->pwm, &pstate);
 	pwm_set_relative_duty_cycle(&pstate,
 			drvdata->duty_cycle_table[selector].dutycycle, 100);
 
-	ret = pwm_apply_might_sleep(drvdata->pwm, &pstate);
-	if (ret) {
-		dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret);
+	ret = pwm_regulator_apply_state(rdev, &pstate);
+	if (ret)
 		return ret;
-	}
 
 	drvdata->state = selector;
 
@@ -115,17 +129,26 @@ static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 static int pwm_regulator_enable(struct regulator_dev *dev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+	struct pwm_state pstate = drvdata->pwm_state;
 
 	gpiod_set_value_cansleep(drvdata->enb_gpio, 1);
 
-	return pwm_enable(drvdata->pwm);
+	pstate.enabled = true;
+
+	return pwm_regulator_apply_state(dev, &pstate);
 }
 
 static int pwm_regulator_disable(struct regulator_dev *dev)
 {
 	struct pwm_regulator_data *drvdata = rdev_get_drvdata(dev);
+	struct pwm_state pstate = drvdata->pwm_state;
+	int ret;
+
+	pstate.enabled = false;
 
-	pwm_disable(drvdata->pwm);
+	ret = pwm_regulator_apply_state(dev, &pstate);
+	if (ret)
+		return ret;
 
 	gpiod_set_value_cansleep(drvdata->enb_gpio, 0);
 
@@ -139,7 +162,7 @@ static int pwm_regulator_is_enabled(struct regulator_dev *dev)
 	if (drvdata->enb_gpio && !gpiod_get_value_cansleep(drvdata->enb_gpio))
 		return false;
 
-	return pwm_is_enabled(drvdata->pwm);
+	return drvdata->pwm_state.enabled;
 }
 
 static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
@@ -151,20 +174,10 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 	int min_uV = rdev->constraints->min_uV;
 	int max_uV = rdev->constraints->max_uV;
 	int diff_uV = max_uV - min_uV;
-	struct pwm_state pstate;
 	unsigned int diff_duty;
 	unsigned int voltage;
 
-	pwm_get_state(drvdata->pwm, &pstate);
-
-	if (!pstate.enabled) {
-		if (pstate.polarity == PWM_POLARITY_INVERSED)
-			pstate.duty_cycle = pstate.period;
-		else
-			pstate.duty_cycle = 0;
-	}
-
-	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+	voltage = pwm_get_relative_duty_cycle(&drvdata->pwm_state, duty_unit);
 	if (voltage < min(max_uV_duty, min_uV_duty) ||
 	    voltage > max(max_uV_duty, min_uV_duty))
 		return -ENOTRECOVERABLE;
@@ -195,15 +208,12 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 	unsigned int min_uV_duty = drvdata->continuous.min_uV_dutycycle;
 	unsigned int max_uV_duty = drvdata->continuous.max_uV_dutycycle;
 	unsigned int duty_unit = drvdata->continuous.dutycycle_unit;
+	struct pwm_state pstate = drvdata->pwm_state;
 	int min_uV = rdev->constraints->min_uV;
 	int max_uV = rdev->constraints->max_uV;
 	int diff_uV = max_uV - min_uV;
-	struct pwm_state pstate;
 	unsigned int diff_duty;
 	unsigned int dutycycle;
-	int ret;
-
-	pwm_init_state(drvdata->pwm, &pstate);
 
 	/*
 	 * The dutycycle for min_uV might be greater than the one for max_uV.
@@ -226,13 +236,7 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
 
 	pwm_set_relative_duty_cycle(&pstate, dutycycle, duty_unit);
 
-	ret = pwm_apply_might_sleep(drvdata->pwm, &pstate);
-	if (ret) {
-		dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return pwm_regulator_apply_state(rdev, &pstate);
 }
 
 static const struct regulator_ops pwm_regulator_voltage_table_ops = {
@@ -321,32 +325,6 @@ static int pwm_regulator_init_continuous(struct platform_device *pdev,
 	return 0;
 }
 
-static int pwm_regulator_init_boot_on(struct platform_device *pdev,
-				      struct pwm_regulator_data *drvdata,
-				      const struct regulator_init_data *init_data)
-{
-	struct pwm_state pstate;
-
-	if (!init_data->constraints.boot_on || drvdata->enb_gpio)
-		return 0;
-
-	pwm_get_state(drvdata->pwm, &pstate);
-	if (pstate.enabled)
-		return 0;
-
-	/*
-	 * Update the duty cycle so the output does not change
-	 * when the regulator core enables the regulator (and
-	 * thus the PWM channel).
-	 */
-	if (pstate.polarity == PWM_POLARITY_INVERSED)
-		pstate.duty_cycle = pstate.period;
-	else
-		pstate.duty_cycle = 0;
-
-	return pwm_apply_might_sleep(drvdata->pwm, &pstate);
-}
-
 static int pwm_regulator_probe(struct platform_device *pdev)
 {
 	const struct regulator_init_data *init_data;
@@ -404,10 +382,23 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = pwm_regulator_init_boot_on(pdev, drvdata, init_data);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "Failed to apply boot_on settings\n");
+	pwm_init_state(drvdata->pwm, &drvdata->pwm_state);
+
+	if (init_data->constraints.boot_on && !drvdata->enb_gpio &&
+	    !drvdata->pwm_state.enabled)
+		/*
+		* In general it's unknown what the output of a disabled PWM is.
+		* The only sane assumption here is it emits the inactive level
+		* which corresponds to duty_cycle = 0 (independent of the
+		* polarity).
+		*
+		* Update the duty cycle so the output does not change when the
+		* regulator core enables the regulator (and thus the PWM
+		* channel) and there's no change to the duty cycle because the
+		* voltage that is achieved with a disabled PWM is already the
+		* desired one.
+		*/
+		drvdata->pwm_state.duty_cycle = 0;
 
 	regulator = devm_regulator_register(&pdev->dev,
 					    &drvdata->desc, &config);
-- 
2.45.2


