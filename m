Return-Path: <linux-pwm+bounces-6604-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E5AEE767
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 21:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693371BC25DA
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 19:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FDF72633;
	Mon, 30 Jun 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwUjFbpE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E628BAA9;
	Mon, 30 Jun 2025 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311429; cv=none; b=GEqNjgZlbdofph7L0Kw+r/Na45OAPLsMG2SyNT4dNhcC3Gm2DaLstzDsp2rjsEcu8sBP7OglpQfJGKYF+btWpnhkuLdhZk8mOqK1pJjXMUd2db/y0t5c4OkN0IVs8KYFNlB2YHmpEF6JIBEkwIOsYL1IM899lFNUOlIRSKwD7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311429; c=relaxed/simple;
	bh=KKnL2hcuRLvXN0J5tw3IRUslOYtD+F1HfFc6qFrPm7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqK0/6+7dNqDVdeZzdP+8pk7/MxwMf+IwoD7iqvn/jtMPm7mYyiUmTVr+TJGlWFpYIbDXQhCkk2uT9SUdqd1pw9au2Y6/r1oxRvhjQNpgdNabA4WAlDrY/+RpquyFmlgM3wInB6sPsZ9Gr+8GIEYI6jEVYrp7Y6om//140Cm9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwUjFbpE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235e1d710d8so55450755ad.1;
        Mon, 30 Jun 2025 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751311427; x=1751916227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XtWJHqmOjkLHebYYqyBdum+VUcVW4TQrPasKfh/VA9g=;
        b=FwUjFbpE5wbGbM3lsqp7z+mHNV+V08QU5fO/TpJjMbo+xwUS3VQCkxzyiPcHMQIJWv
         5eOjPT/uAAWtE4CVZLu51mwmwAyTxJQ88lDhrTMORn/TTIyWbozDjUO8CjCmdBMMkimQ
         OOPKnfG91pDgww0d1c6QgqUePsDkLu9Gin7roPl6laUNKF3aPlJH9lhMghLBaK6tbqS8
         rBDM2DnvaWgTeaLsVYwNakI2RmY2E8TCeZ92QQUVqX5IwWZAmRoLvvJRA+9sAsvAYxEk
         PBNPdUhps7hG+LZ5sDXWMqRPJYe+F8yzKhDisJkBXIj0kqjBNkm+Vy9oGxhBF7O6Yygq
         VWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311427; x=1751916227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtWJHqmOjkLHebYYqyBdum+VUcVW4TQrPasKfh/VA9g=;
        b=NbI1TMWrwvIH5jumpT34N7FxAQ9MEt9R6TwUM+qugy9KZqsm6E8GnuoH76JJ4BYsbB
         fjTOwEG1Vb3Kbzd6J6k1+KcfhGqCME6jwdjHaZBrK1wOc6rRxviPVLMg+OclEKSFrQnb
         z3nEh773qNvwOFP2NnO76gwnQFE1zCdmkO5LLKoBpU0Rm2+zfBLlVG//36qtD7bbEcV5
         FcWgg79/fysiDtQIU6k2KiNh4/+Fu1NylO3jm0X/tIoXmmckZjHk36LBpKAqEpUZsv3+
         LiRnCh325kObGCdvtwLxZWMJUo3LPYPTQTiqeWjQ63fawwyErS3LuauV2NZY6dvlwzHg
         +ZTg==
X-Forwarded-Encrypted: i=1; AJvYcCWBbEEAoDuK5iJR1UqUF1m/T1HdtoZFpZ62bSiqehKAhJibJqvbkuX3pSg3I9lYJEPa5qyvXe2l3ZusNg==@vger.kernel.org, AJvYcCX1PTri6yVHraYJjsys7h9ixNXx74ipITOsaeRu64iJW9RSGLOD9kQOgRoQ9fGyQADkr6ee31qJIUL6@vger.kernel.org
X-Gm-Message-State: AOJu0YylBcm4k9u4IPBTEn8nlZPgfS36bu1/XFNIbpu+PZzs1w50nGDJ
	PrzW/VXLnG6ejCV6E4QOHxcjZIhhUkJV51nVbacM/Ga+9feQTG0sk0mob7l/rQ==
X-Gm-Gg: ASbGncvQ4LpwgYCeayuvAC4xbPFGMho1qTGwIGNQ0NuVDJQa0ejwkoA7sMkI9sKUiKk
	DMOQbq/UNwLaZXK+ooAOF+sivBGTrKhgYjDNSwsYxW5xhTC+HttfWvfe3uCC0MK978sWI+226Qs
	W8puFIbekVmiop5ZkgVoYQB5QWdHzNQ+FZKtA+z9Onymx9z8H4gVX2LRWBAL/rqHs5ON5m4sgFp
	cfCL4QzaRpj//Tea+x/6rHlLE+w/qhNuARAhLzzdunyx9556Rku+wAntUIkNHMq4jKr774y+tGw
	mYWI4a7c9PzaPefFDGkBjIApnhAdU/jzVN/Z5qaz5xPnfSYbaJvzYuQF4k6qmxmLBsZzQc96
X-Google-Smtp-Source: AGHT+IFGv822h0ivFgslh3hBAUhvdzugJ2qutXbNudnp6f/QqFwKeDnR5I1xpI/Hj15xosuY6hE1Cg==
X-Received: by 2002:a17:902:ce11:b0:235:5a9:976f with SMTP id d9443c01a7336-23ac462451bmr267116405ad.24.1751311426624;
        Mon, 30 Jun 2025 12:23:46 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c92b:c666:1f8:990e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f24c7sm86546415ad.82.2025.06.30.12.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:23:46 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:23:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] Input: max77693 - Convert to atomic pwm operation
Message-ID: <w3tkxxkqr2kmri3bz5m34dzw3hfvkqou3zbww7kwjdg72o7kla@ty777ynf26qr>
References: <20250630103851.2069952-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630103851.2069952-2-u.kleine-koenig@baylibre.com>

Hi Uwe,

On Mon, Jun 30, 2025 at 12:38:50PM +0200, Uwe Kleine-König wrote:
> @@ -167,17 +150,22 @@ static int max77693_haptic_lowsys(struct max77693_haptic *haptic, bool enable)
>  static void max77693_haptic_enable(struct max77693_haptic *haptic)
>  {
>  	int error;
> +	struct pwm_state state;
>  
> -	if (haptic->enabled)
> -		return;
> +	pwm_init_state(haptic->pwm_dev, &state);
> +	state.duty_cycle = (state.period + haptic->pwm_duty) / 2;
> +	state.enabled = true;
>  
> -	error = pwm_enable(haptic->pwm_dev);
> +	error = pwm_apply_might_sleep(haptic->pwm_dev, &state);
>  	if (error) {
>  		dev_err(haptic->dev,
>  			"failed to enable haptic pwm device: %d\n", error);
>  		return;
>  	}
>  
> +	if (haptic->enabled)
> +		return;
> +
>  	error = max77693_haptic_lowsys(haptic, true);
>  	if (error)
>  		goto err_enable_lowsys;

I do not quite like that max77693_haptic_enable() now has split brain:
there is part of it that does update unconditionally and part that is
protected by the "enabled" flag. How about we keep max77693_haptic_set_duty_cycle() but make max77693_haptic_play_work() 
a bit smarter, like in the version below:


Input: max77693 - convert to atomic pwm operation

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

The driver called pwm_config() and pwm_enable() separately. Today both
are wrappers for pwm_apply_might_sleep() and it's more effective to call
this function directly and only once. Also don't configure the
duty_cycle and period if the next operation is to disable the PWM so
configure the PWM in max77693_haptic_enable().

With the direct use of pwm_apply_might_sleep() the need to call
pwm_apply_args() in .probe() is now gone, too, so drop this one.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://lore.kernel.org/r/20250630103851.2069952-2-u.kleine-koenig@baylibre.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/max77693-haptic.c |   41 +++++++++++++++-------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 1dfd7b95a4ce..5d45680d74a4 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -68,15 +68,16 @@ struct max77693_haptic {
 
 static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
 {
-	struct pwm_args pargs;
-	int delta;
+	struct pwm_state state;
 	int error;
 
-	pwm_get_args(haptic->pwm_dev, &pargs);
-	delta = (pargs.period + haptic->pwm_duty) / 2;
-	error = pwm_config(haptic->pwm_dev, delta, pargs.period);
+	pwm_init_state(haptic->pwm_dev, &state);
+	state.duty_cycle = (state.period + haptic->pwm_duty) / 2;
+
+	error = pwm_apply_might_sleep(haptic->pwm_dev, &state);
 	if (error) {
-		dev_err(haptic->dev, "failed to configure pwm: %d\n", error);
+		dev_err(haptic->dev,
+			"failed to set pwm duty cycle: %d\n", error);
 		return error;
 	}
 
@@ -166,12 +167,17 @@ static int max77693_haptic_lowsys(struct max77693_haptic *haptic, bool enable)
 
 static void max77693_haptic_enable(struct max77693_haptic *haptic)
 {
+	struct pwm_state state;
 	int error;
 
 	if (haptic->enabled)
 		return;
 
-	error = pwm_enable(haptic->pwm_dev);
+	pwm_init_state(haptic->pwm_dev, &state);
+	state.duty_cycle = (state.period + haptic->pwm_duty) / 2;
+	state.enabled = true;
+
+	error = pwm_apply_might_sleep(haptic->pwm_dev, &state);
 	if (error) {
 		dev_err(haptic->dev,
 			"failed to enable haptic pwm device: %d\n", error);
@@ -224,18 +230,13 @@ static void max77693_haptic_play_work(struct work_struct *work)
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
 
-	if (haptic->magnitude)
-		max77693_haptic_enable(haptic);
-	else
+	if (!haptic->magnitude)
 		max77693_haptic_disable(haptic);
+	else if (haptic->enabled)
+		max77693_haptic_set_duty_cycle(haptic);
+	else
+		max77693_haptic_enable(haptic);
 }
 
 static int max77693_haptic_play_effect(struct input_dev *dev, void *data,
@@ -340,12 +341,6 @@ static int max77693_haptic_probe(struct platform_device *pdev)
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

-- 
Dmitry

