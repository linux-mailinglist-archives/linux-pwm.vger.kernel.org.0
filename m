Return-Path: <linux-pwm+bounces-2398-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D77901FFC
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C231F21101
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107214F9D5;
	Mon, 10 Jun 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rjhO9hqx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9361714F9D1
	for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016384; cv=none; b=CFwJUzM392NO+Ur7X7N/wKJdAhEmkWc6noW1nnu3CHCvgW+c3ACnFGlZ+vibSzIcaMUINdOopSI2EFMM/RMlj5gANgrnp1DpwhNHmBGqE/tiazvtEkIDkfZo4BjxqZayWTPPEoCOwOSgqGUTMQ/nva8kb0+6dEwTRyCFYCt4/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016384; c=relaxed/simple;
	bh=74n1Zibr4fPkE6scCimdQ1VXXNPZn1aItHzIJ17piqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CITSSKpyj1TnykX+CzaUpR9WZ44DlMyscD87HCqnjkDnujZdMjWTEm+oLOxy8euH5vqFganXaFMuMF1Aul+W3H80EpTDaG0dlYdzBsh3CmmdyMiXW0CR5XP4ftBFBrHRJzS6hEk3FfFy6FLWiy3pmbXtzYrYvtmQnyLRrJbcRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rjhO9hqx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so1696159a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718016379; x=1718621179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/XlZMzh78GMHOD1gDwKx1xR6KaRV34mJ3eqV2qIma2k=;
        b=rjhO9hqx4OZdYQcKcV1KqUJwCtM2krBGypULAQ/QepJLk2fiUNRQN1JMpBwxMhZDGW
         5btqBWhEFNshhUUEwXQqxxaRXq49cT4Me0U++bKIdj85CaQ7V9jw+u0PyGmnDkR73bqr
         DqdM60dClWqf8c+R3xg2muKfbIUqj6se3+wlhqAoRSx1iquN22Xbj243Q1/+tDH+IFCC
         uMfNVBSaldV4HbLwPTpH55PtnBbXWGy6duYXfwZiFSxCPmo5LEyLZmf+fbiat0bU37l7
         JtEY2M0Usw1L4ZiT/571eOatcf02E+vZD9PCpnVyagsIdmZZBgIWfPsTfdvGQEZboBcP
         dGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718016379; x=1718621179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XlZMzh78GMHOD1gDwKx1xR6KaRV34mJ3eqV2qIma2k=;
        b=HaUFg/iVUrdZsyhTa2MX+FHHy7cMZYnrZ0f/mukND+7WGISj1wmD8sAx5n23a0+LXY
         kQM2jMPR+PHaFaEQOVxt6VYIEfW6dHrPkdOlpW/Hp7j654azthQB79kWKLqlby6Auq/J
         MU2Z2kCAZL1/XlRDE4DZxdSjA5deFjCljs11FMjRFUP0g3dGm5PsHPLRaaLihFk4nvSY
         IneRpaydZSEvRO7l2ci9UEjXQAjnRmvvZ/AQLRYrA3LmnOSb2yUnSzrnuY4Ykwv8Nb/X
         ws6rSqV7XVXOZBitP75wY3vJ2Sh/z5YNM3lIURVQmIpnAgO0QBMGF2tR6ELuPZhvOa27
         DmdA==
X-Forwarded-Encrypted: i=1; AJvYcCXLTtaOXQep2I+8S2UYyNMyhWaVaWre3G4SjWsc765nGyKcrK1/toR0w9x1x4UQMbLUuuhYGQAGvRek6EhHOiWjydkzoo2tuDgv
X-Gm-Message-State: AOJu0YxTJjZXmA/1C6il4C2fzPvRi0C1K+uvcfrEZCFq2w/092EonFTP
	QDAV6rXU+oFvOpfscSj7or/0+8r5CLVdT31HWx5Yegnr7nWQw0+0Hqe0gtobOeY=
X-Google-Smtp-Source: AGHT+IGvGQ6OvV2IAPt4qY854+RjVirsCYZ4KGXh5XrklREl+PiXnz7K4O/IsCKgGY3ZFb+KVLT+pQ==
X-Received: by 2002:a17:906:eea:b0:a62:fc9d:6fec with SMTP id a640c23a62f3a-a6cd74bf905mr556338366b.34.1718016378782;
        Mon, 10 Jun 2024 03:46:18 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f08204ba1sm309996566b.105.2024.06.10.03.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:46:18 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [RFC PATCH] regulator: pwm-regulator: Make assumptions about disabled PWM consistent
Date: Mon, 10 Jun 2024 12:46:00 +0200
Message-ID: <20240610104600.458308-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=74n1Zibr4fPkE6scCimdQ1VXXNPZn1aItHzIJ17piqM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmZtloVvG9ndchYWd7fvEXizTIhME1/yc0Ep8Ys E5Ns8dEVw+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmbZaAAKCRCPgPtYfRL+ TnT0B/9KAwtSY/bi7poMsPG7y3w5zMqCMPkH+Upgu/g8HQRJZkTlNiwNrnGAko16TU9vkorDMzj Qt5J/psei9zapGrbxi/IUCwQssVNuT9sZEIy5x16+ADhJCW7mvZmgFk4WyqvfAd8lhc6BSfUa30 kJKjUJHpyWL6KS1zgWTKv2+LwJ3pElylE14w5V2SP03lRmpBAcJglCD11mXWL5MiUWVJzuh+KIZ EEg6XTnb3j9jdrUejaMk588dAgd/XUDu80ZqGuVu371UCz8JbgLSyBCs04IJbjZ74v8Ic0b+m01 5xcwndLp6kKs8hDYNhQ/cbYBo/1+pR07ciO0TkIB5x6fyC8S
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Generally it's not known how a disabled PWM behaves. However if the
bootloader hands over a disabled PWM that drives a regulator and it's
claimed the regulator is enabled, then the most likely assumption is
that the PWM emits the inactive level. This is represented by duty_cycle
= 0 even for .polarity == PWM_POLARITY_INVERSED.

Put that assumption in a dedicated function, document that it relies on
an assumption and use that in both functions pwm_regulator_init_state()
and pwm_regulator_get_voltage().

With that pwm_regulator_init_boot_on() can be dropped, as it's only
purpose is to make pwm_get_state() return a configuration that results
in emitting constantly the inactive level if the PWM is off.

Fixes: 6a7d11efd691 ("regulator: pwm-regulator: Calculate the output voltage for disabled PWMs")
Fixes: b3cbdcc19181 ("regulator: pwm-regulator: Manage boot-on with disabled PWM channels")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is my suggestion to fix the concerns I expressed in
https://lore.kernel.org/all/hf24mrplr76xtziztkqiscowkh2f3vmceuarecqcwnr6udggs6@uiof2rvvqq5v/
.

It's only compile tested as I don't have a machine with a pwm-regulator.
So getting test feedback before applying it would be great.

Best regards
Uwe

 drivers/regulator/pwm-regulator.c | 68 +++++++++++--------------------
 1 file changed, 23 insertions(+), 45 deletions(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 7434b6b22d32..648a53b67a2f 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -48,18 +48,37 @@ struct pwm_voltages {
 	unsigned int dutycycle;
 };
 
+static unsigned int pwm_regulator_get_relative_dutycyle(struct regulator_dev *rdev,
+							unsigned int scale)
+{
+	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
+	struct pwm_state pwm_state;
+
+	pwm_get_state(drvdata->pwm, &pwm_state);
+
+	if (!pwm_state.enabled) {
+		/*
+		 * In general it's unknown what the output of a disabled PWM is.
+		 * The only sane assumption here is it emits the inactive level
+		 * which corresponds to duty_cycle = 0 (independent of the
+		 * polarity).
+		 */
+		return 0;
+	}
+
+	return pwm_get_relative_duty_cycle(&pwm_state, scale);
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
+	dutycycle = pwm_regulator_get_relative_dutycyle(rdev, 100);
 
 	for (i = 0; i < rdev->desc->n_voltages; i++) {
 		if (dutycycle == drvdata->duty_cycle_table[i].dutycycle) {
@@ -151,20 +170,10 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
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
+	voltage = pwm_regulator_get_relative_dutycyle(rdev, duty_unit);
 	if (voltage < min(max_uV_duty, min_uV_duty) ||
 	    voltage > max(max_uV_duty, min_uV_duty))
 		return -ENOTRECOVERABLE;
@@ -321,32 +330,6 @@ static int pwm_regulator_init_continuous(struct platform_device *pdev,
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
@@ -404,11 +387,6 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = pwm_regulator_init_boot_on(pdev, drvdata, init_data);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "Failed to apply boot_on settings\n");
-
 	regulator = devm_regulator_register(&pdev->dev,
 					    &drvdata->desc, &config);
 	if (IS_ERR(regulator)) {

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.43.0


