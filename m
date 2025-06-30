Return-Path: <linux-pwm+bounces-6580-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2FAEDA03
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 12:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2788717232A
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AFC2475CD;
	Mon, 30 Jun 2025 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1P0BXyGk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F12245000
	for <linux-pwm@vger.kernel.org>; Mon, 30 Jun 2025 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279942; cv=none; b=jouWQybUTNXhP4XxP3RkqCrPl7R+C4GGcM27dNNHvfJxbaSTHSaldPjPJ2xEbtfjTfVvUrvAcxLvAfHIsNBVpX/4H3zojQz57DktK92ao4WQjhJqFq23umAnUWjnPQyTx6NT3xa3ccNwd/QhwvDabmPgzt4iqjpJPD9UqR7mu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279942; c=relaxed/simple;
	bh=k+KdiBc/mn9/dxOM7/q9Js58Njn0x+1gGICxsNrcqqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V3pPWbk1vrLRqySi+ddAMGM619SH200nU03dduOAu1WKsHLlixvY5aONDjT2dRhDGjMCcAk21eR3fgGmRoVKETkMSNxVw9V2e4OG89efdvcIyx5AMhiR7l2sFpAGVY6x0/alf3H+7wBasOJBILl+zlyjptM9BuR6eqmMdMbd6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1P0BXyGk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4531e146a24so24542665e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 30 Jun 2025 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751279938; x=1751884738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pKPFv0V+pZESiVXTlV4K0nr8wRpUOdISl/cJt2AvE7Q=;
        b=1P0BXyGk9pvxXdPXD/cgN6WGvwPgb1y9/rLoh/CSwa07yf32lif4LelGJG0F/zLsh9
         p3jOwoG9dBq/Tfu7sEpIhK2sUF/Whpuy13SaJHTxF/r7dVT7Q8cMZvo0ABBqqdcJs57Q
         zBGqDbjMZSD9S+/URKnaeecuSTTevVKXiFkBXg8030+TrdkncLubm385pEuRk1A++s/s
         4/0mOkdfDLXrr3ZhH6jnEVBByd/0g1Dm62pG4x7SWeejN7dv3W+r8dYHhYooyFwuFIsI
         D9IMjao1YomcwGFA3gaDX3bXUBp/8rEqpxReDB0SFt9ArMb8FhjFZqTdTL8c5/PZ8bAZ
         cx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751279938; x=1751884738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKPFv0V+pZESiVXTlV4K0nr8wRpUOdISl/cJt2AvE7Q=;
        b=PCrOJ/wza197qrgeOGzyKpmprR+qJcfkHAHLjAYRUFNSSJa03MGyoOnXMIDxKQVN5u
         gIrs8DcwYVmgiw3am7Gd5EIgfqjcwvu4XWJc0bvWVYEEBzTphqOrYbxCkJ+Z8+8E/CTE
         5pU23N5CX63NN9UWh8nESEZWkkj7GAs6+dTFTmQI/0jvLjUHE3EYHS9DbO7GFQu4vUlg
         yg7ECuu0SuzNgYz9Y6eUPWUY9/u0w6W/UjnUQTX5MZDL8oQ1fJi2r18u32HiFpzWKv65
         97q44liYBEGRkp6IDQS4E+JUixit1VYZtOsVuxdQaTYM8kyJeZeEMq7WZl3WvopH8/ye
         AXFg==
X-Forwarded-Encrypted: i=1; AJvYcCUDIh7FQ/+NWYP/IJSCgltblrJcz3NbDC2ZMJJpgd6siuvf/ZpFcffdp04A+M3ooqV9aXD6PJjFBCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBMnb/obER1sxXysUK2nVxKYw9sb12Ugk6Po8+LZBcsfYNmG+
	GxsL7aKNPxGh+WRHTqjOeC8v/jvXNUbhlbAHt1SMUzTc+1sXa3Lh/t3mdAe/xCCyVH8=
X-Gm-Gg: ASbGncvw4S2/Mib+Dp5Lm2MyrJDYDcTcK5RU8Rmjm14PbOHo77gTfpA0zZzrvWpFeED
	vLosIAFTBzTHsjoR96jfjBO0fIVOvJCLF/KmdYWDTcPObnk/2JjPwZlZwXExTa2JsK6Vid0EbDe
	JTHcyEnP/osi2hhB5DqSwdFkF/Grs+cjmnUQP2jb62IfDdhAIIK/iabuddZe3luznDgWNySUitB
	yZYvWv6JXuLrGIrRzADVszfmSuqBXi6JjqiV6IqS50CC1uxJVevShya4OqaqA++tKJHwBdSGsUy
	j5qn+9Mi3GblY15hq2gxmjPLmR5cRYkTOCPzbkYSHoG716jesPpZEfrt3ms+5HChbbe/oQdOFQA
	Y9diGgXD+F7H1qUbJsNUKGFnxLCGE
X-Google-Smtp-Source: AGHT+IGQBOAh6OVZ+HZ1cI2mDIcxZrj9eqOdGnasJJmCHYG7j8eYyesoWgNtmAzeQUKiNeAqEUmQzQ==
X-Received: by 2002:a05:600c:530d:b0:442:ffa6:d07e with SMTP id 5b1f17b1804b1-4538ef33a85mr110955955e9.1.1751279938109;
        Mon, 30 Jun 2025 03:38:58 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453823ad247sm166168555e9.26.2025.06.30.03.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 03:38:57 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH] Input: max77693 - Convert to atomic pwm operation
Date: Mon, 30 Jun 2025 12:38:50 +0200
Message-ID: <20250630103851.2069952-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3333; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=k+KdiBc/mn9/dxOM7/q9Js58Njn0x+1gGICxsNrcqqE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoYmk7wPWiAi8LAdOScIKTkakQztMgFPRswZ5mv aVSRMnlKqKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaGJpOwAKCRCPgPtYfRL+ TgzDB/0Q1JenZXtZn1GQW0a9EQa1N/RXm0uzgSm2WwyvZcJZz9fsZKJ5kzw/Kg88EOC/GL/2FtW WaeqaKTlX0kE+S7+iuohPXSMztxveWxSNsQWLsykgzQNnDHlTDK80ZcgH2nUk+cZ3ZE9IkRqmaS JAnewZ8b+Hbkpw5lIZj2nORB7/Mp1gGtU7whdnMuCd704O/5kyM63odGBPFR1rfMM4B6W1sR4Lj 5l5273eE8SlecOmVZSdjbHIOdim7eivsQqqDDTM2DYpmdnfbfj/w7KsRopstaG+SpleFRijWv5z n2IsDWzczxkqj7SQWFw2naMOlwE/MFjRudx0VwaHHEA+z1Fg
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver called pwm_config() and pwm_enable() separately. Today both
are wrappers for pwm_apply_might_sleep() and it's more effective to call
this function directly and only once. Also don't configure the
duty_cycle and period if the next operation is to disable the PWM so
configure the PWM in max77693_haptic_enable().

With the direct use of pwm_apply_might_sleep() the need to call
pwm_apply_args() in .probe() is now gone, too, so drop this one.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

the motivation for this patch is getting rid of pwm_config(),
pwm_enable() and pwm_apply_args(). I plan to remove these once all
callers are fixed to use pwm_apply_might_sleep().

Best regards
Uwe

 drivers/input/misc/max77693-haptic.c | 41 ++++++----------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 1dfd7b95a4ce..ecb3e8d541c3 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -66,23 +66,6 @@ struct max77693_haptic {
 	struct work_struct work;
 };
 
-static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
-{
-	struct pwm_args pargs;
-	int delta;
-	int error;
-
-	pwm_get_args(haptic->pwm_dev, &pargs);
-	delta = (pargs.period + haptic->pwm_duty) / 2;
-	error = pwm_config(haptic->pwm_dev, delta, pargs.period);
-	if (error) {
-		dev_err(haptic->dev, "failed to configure pwm: %d\n", error);
-		return error;
-	}
-
-	return 0;
-}
-
 static int max77843_haptic_bias(struct max77693_haptic *haptic, bool on)
 {
 	int error;
@@ -167,17 +150,22 @@ static int max77693_haptic_lowsys(struct max77693_haptic *haptic, bool enable)
 static void max77693_haptic_enable(struct max77693_haptic *haptic)
 {
 	int error;
+	struct pwm_state state;
 
-	if (haptic->enabled)
-		return;
+	pwm_init_state(haptic->pwm_dev, &state);
+	state.duty_cycle = (state.period + haptic->pwm_duty) / 2;
+	state.enabled = true;
 
-	error = pwm_enable(haptic->pwm_dev);
+	error = pwm_apply_might_sleep(haptic->pwm_dev, &state);
 	if (error) {
 		dev_err(haptic->dev,
 			"failed to enable haptic pwm device: %d\n", error);
 		return;
 	}
 
+	if (haptic->enabled)
+		return;
+
 	error = max77693_haptic_lowsys(haptic, true);
 	if (error)
 		goto err_enable_lowsys;
@@ -224,13 +212,6 @@ static void max77693_haptic_play_work(struct work_struct *work)
 {
 	struct max77693_haptic *haptic =
 			container_of(work, struct max77693_haptic, work);
-	int error;
-
-	error = max77693_haptic_set_duty_cycle(haptic);
-	if (error) {
-		dev_err(haptic->dev, "failed to set duty cycle: %d\n", error);
-		return;
-	}
 
 	if (haptic->magnitude)
 		max77693_haptic_enable(haptic);
@@ -340,12 +321,6 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 		return PTR_ERR(haptic->pwm_dev);
 	}
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to the
-	 * atomic PWM API.
-	 */
-	pwm_apply_args(haptic->pwm_dev);
-
 	haptic->motor_reg = devm_regulator_get(&pdev->dev, "haptic");
 	if (IS_ERR(haptic->motor_reg)) {
 		dev_err(&pdev->dev, "failed to get regulator\n");

base-commit: 1343433ed38923a21425c602e92120a1f1db5f7a
-- 
2.49.0


