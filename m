Return-Path: <linux-pwm+bounces-6577-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7697AED8E6
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 11:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1EB16E28C
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A00C23D2BD;
	Mon, 30 Jun 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VhNqzNDr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF32459F2
	for <linux-pwm@vger.kernel.org>; Mon, 30 Jun 2025 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751276251; cv=none; b=eIZYxmN9WsesVEUOwfNo5IpId5wOH5DRYJwHQO6Bq/W0wD+brtstfregoT10qdjOgJVlFZZSUpMz8AyNefoktNuVAZdJCTxxafwZ5oQXHD+ppyWq8TgLMk5SkeetmkYLAmjyp22jyOJY3JQwKJucKtKgWbPRy+wojtAo3eRQ8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751276251; c=relaxed/simple;
	bh=GnfLzsdPfQ2VHV8UMkZ2FvFVLNH8ELi6SNM5xx1OHiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oiCG/wAKX+iHrPh7J37Qyg874hC7mhF0KJ2wdK89l8Mr4zONyIHBH+KpQQ5W+jQGkgg2z0DNMDo5lBB+g+4+/UyPqohUm1a5XeuPkf3gcCAX3vk9/HW/ImH+I6kqT2naUd4jz4h5h9mdDZVP8Pwn3vM7tvbaPU7W2bLivFqbWVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VhNqzNDr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4537fdec39fso4766635e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 30 Jun 2025 02:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751276246; x=1751881046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gUrNdDVU77c9uw4mJM2RJELk7rgZTpadQl39/qaYr4k=;
        b=VhNqzNDrowA5HQ7XqL1sjW4x/f0fgTnpRA6mjqyxIb6Kx0PqcgDI0hnW7E8TUVA7uT
         H4Qn6V4/tG2Z1vEb8sMn1XoxsetoULXLLkiZuJdxe8QlsOizxUEuHEhAJqquUSeJuNZM
         B7nCiwYJt/xu7BnDh8seaM9Ju7naItYWS3ckjFj7eg3x1FWtULofmLpO6CBF0tHbzGed
         p6NpYP29OZDloiGYEszvKxK4vPl7DbBoz7xx4W/pIo9CRMP/MfRYU8bJvIiL5Ijc6adk
         eiV5PZ+Gdgnsyzpm94nuB0YjQZvReLjdeN6EtKFk5oOXxmzOkQXaXpRwnKab7ICbVfNb
         lypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751276246; x=1751881046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUrNdDVU77c9uw4mJM2RJELk7rgZTpadQl39/qaYr4k=;
        b=bP1x8vOGvndiwpEy9ekQspbhqPZ49E0e2jNtEQ11eQ/SvGvfmM8uzK3FjkQ8xUADq3
         DA8MpI/fnVR5NOrY+6j5EOQVt6L9aEIMCWIrs0dv1/icPkVathp6igS2CEv0lqEUadtS
         7HjJiMQJAj0z6HaJ06pG9oi7kHWbE25Oo15hNb178XVXBbwRUmUFX0uw6T3NMDZ5nUQ9
         CUPnDK6fmA69f4vXrceZv8Nndi6RSKzq9HnSHawXMPA8eKgUZKqMdKy7x7+DYmgyzCdJ
         hJpIIBPNQQbtmO/LrwEnhA6MSpeqaDXblTST8oA+geOIiJv1BeZvvQ3Sq0v/ugkIkkx1
         wCMg==
X-Forwarded-Encrypted: i=1; AJvYcCWaBMZJe/aBtT3Fo4FdgFHHUg/aLA6hgxhtEc4DDS71we3wDpkiEUvlJBRmbPjYlzfK1xJdVyfoAbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+BZDsUp+7Pa6AVJ7SqfW/idSe5JR6QhJNBzIUC8TeNwU1z8f
	98k+74ay4itYPsZcR2aiPJJjl7Vf6LXtIHcudX/P6expeKoouRqWlZUspuCNELCvJRETCpzAIuq
	p9DQl
X-Gm-Gg: ASbGncvVGt6dHHzA/KliIGRH+jZuI8LSxv8QZDMmx9jN9W4rtRMM5fy+JZNQRILaQTf
	coKGbpj3MHyD/GYv/5zmanWIhh4rMCeGhKi9amPlhccQWdvEjXUFJEneuQ3UHKYmB+0YL4M9Oqs
	fDs8bVvuTz4EvJ3U1reFcb9simoxSPFa7Avw+eceB2Y01n6g8JacZNMqzmTiCqpBRfHggFJ6/tY
	os/GRbtPZoPk6C2Jn3TkTXgPHt4V9lGqQKn43IRjB3XJl6GSHVMCpamz8901bUC7Vyf9qiqmINe
	kSWCWJ23cxt0PlACmpJ2xx+2iAdGGPOXaYb+sDJ8LUfuZzq+VLg0tBkPV8IrzHvHY2tC18qDWL2
	eWqyrwX1LN27sf++LABVKiYPq8pka
X-Google-Smtp-Source: AGHT+IFBxWCjZ6a4yiGuV3Ap6A1SD/3fbRo9FBv1t8LTT4S614TTr0mdjKuAeIYjUe/jM3Uo1hzqGQ==
X-Received: by 2002:a05:600c:4750:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-4538ee30effmr148411035e9.3.1751276246017;
        Mon, 30 Jun 2025 02:37:26 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538a406ab6sm131054585e9.30.2025.06.30.02.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 02:37:25 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v2] Input: max8997_haptic - Optimize PWM configuration
Date: Mon, 30 Jun 2025 11:37:17 +0200
Message-ID: <20250630093718.2062359-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5601; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=GnfLzsdPfQ2VHV8UMkZ2FvFVLNH8ELi6SNM5xx1OHiY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoYlrOagWcyyC4zVhjFV5jfvaWu/eZAgVghg6z+ q3bXG7SfTSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaGJazgAKCRCPgPtYfRL+ TqjdCACH8KqudfEX4kHE+DFXBYTfCBHP3OQFCRbHX3E1kZGB0conIQObEg5W3Ui14u2LbKgVe0c TW04U4aZa1oQu70pTUEzIOO75QCYwralGktrJcHwIiqS0xzWK3+ueIKOw5WaJx8t2lgTNZD5DGA ZUmjrPDIdI7i6CKa/VHGZTal/waeQX0y2SDSTrrnFHWTqCMDJGHWAxMIyKLrP2FnngSysLmadsn BIAgSr2mkKMBhDOtp6tXBlli1EhgQvoQqN6JS1n86s9f/KYesfwsNxWaCXwqe74gqcBkFgjMgV8 uTGhsK6HGjTSyUxIw8br94zkke7T3c+j2EOE1QVKXAFa/u+9
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Both pwm_config() and pwm_enable() are wrappers around
pwm_apply_might_sleep(). Instead of calling this function twice only
call it once without an intermediate step.

Setup the PWM in max8997_haptic_enable() only where it was enabled
historically. max8997_haptic_set_duty_cycle() is renamed accordingly to
make it clear this function is only about the internal setup now.
pwm_config() was called earlier back then, but that call has no effect
on the hardware when the PWM is disabled, so delaying this configuration
doesn't make a difference.

As pwm_apply_might_sleep() is used now defining the whole state of the
PWM, the call to pwm_apply_args() in .probe() can be dropped now, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

changes since (implicit) v1, available at
https://lore.kernel.org/linux-input/20250623112742.1372312-2-u.kleine-koenig@baylibre.com

 - keep enabling the PWM only after the regulator is also enabled
 - add a comment describing the reason for that, making it possible that
   someone with access to the device and/or documenation easily notices
   this cleanup (if it's possible)
 - rename max8997_haptic_set_duty_cycle() ->
   max8997_haptic_set_internal_duty_cycle() and make it return void.
 - trivially rebase to a newer next tag
 - drop pwm_apply_args()

The driving motivation is to get rid of pwm_config(). This driver is one
of the remaining two users of this function.

 drivers/input/misc/max8997_haptic.c | 98 +++++++++++++++--------------
 1 file changed, 50 insertions(+), 48 deletions(-)

diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index f97f341ee0bb..033225cae818 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -53,40 +53,35 @@ struct max8997_haptic {
 	unsigned int pattern_signal_period;
 };
 
-static int max8997_haptic_set_duty_cycle(struct max8997_haptic *chip)
+static void max8997_haptic_set_internal_duty_cycle(struct max8997_haptic *chip)
 {
-	int ret = 0;
+	u8 duty_index = 0;
 
-	if (chip->mode == MAX8997_EXTERNAL_MODE) {
-		unsigned int duty = chip->pwm_period * chip->level / 100;
-		ret = pwm_config(chip->pwm, duty, chip->pwm_period);
-	} else {
-		u8 duty_index = 0;
+	if (chip->mode == MAX8997_EXTERNAL_MODE)
+		return;
 
-		duty_index = DIV_ROUND_UP(chip->level * 64, 100);
+	duty_index = DIV_ROUND_UP(chip->level * 64, 100);
 
-		switch (chip->internal_mode_pattern) {
-		case 0:
-			max8997_write_reg(chip->client,
-				MAX8997_HAPTIC_REG_SIGPWMDC1, duty_index);
-			break;
-		case 1:
-			max8997_write_reg(chip->client,
-				MAX8997_HAPTIC_REG_SIGPWMDC2, duty_index);
-			break;
-		case 2:
-			max8997_write_reg(chip->client,
-				MAX8997_HAPTIC_REG_SIGPWMDC3, duty_index);
-			break;
-		case 3:
-			max8997_write_reg(chip->client,
-				MAX8997_HAPTIC_REG_SIGPWMDC4, duty_index);
-			break;
-		default:
-			break;
-		}
+	switch (chip->internal_mode_pattern) {
+	case 0:
+		max8997_write_reg(chip->client,
+			MAX8997_HAPTIC_REG_SIGPWMDC1, duty_index);
+		break;
+	case 1:
+		max8997_write_reg(chip->client,
+			MAX8997_HAPTIC_REG_SIGPWMDC2, duty_index);
+		break;
+	case 2:
+		max8997_write_reg(chip->client,
+			MAX8997_HAPTIC_REG_SIGPWMDC3, duty_index);
+		break;
+	case 3:
+		max8997_write_reg(chip->client,
+			MAX8997_HAPTIC_REG_SIGPWMDC4, duty_index);
+		break;
+	default:
+		break;
 	}
-	return ret;
 }
 
 static void max8997_haptic_configure(struct max8997_haptic *chip)
@@ -155,11 +150,7 @@ static void max8997_haptic_enable(struct max8997_haptic *chip)
 
 	guard(mutex)(&chip->mutex);
 
-	error = max8997_haptic_set_duty_cycle(chip);
-	if (error) {
-		dev_err(chip->dev, "set_pwm_cycle failed, error: %d\n", error);
-		return;
-	}
+	max8997_haptic_set_internal_duty_cycle(chip);
 
 	if (!chip->enabled) {
 		error = regulator_enable(chip->regulator);
@@ -168,16 +159,32 @@ static void max8997_haptic_enable(struct max8997_haptic *chip)
 			return;
 		}
 		max8997_haptic_configure(chip);
-		if (chip->mode == MAX8997_EXTERNAL_MODE) {
-			error = pwm_enable(chip->pwm);
-			if (error) {
-				dev_err(chip->dev, "Failed to enable PWM\n");
-				regulator_disable(chip->regulator);
-				return;
-			}
-		}
-		chip->enabled = true;
 	}
+
+	/*
+	 * It would be more straight forward to configure the external PWM
+	 * earlier i.e. when the internal duty_cycle is setup in internal mode.
+	 * But historically this is done only after the regulator was enabled
+	 * and max8997_haptic_configure() set the enable bit in
+	 * MAX8997_HAPTIC_REG_CONF2. So better keep it this way.
+	 */
+	if (chip->mode == MAX8997_EXTERNAL_MODE) {
+		struct pwm_state state;
+
+		pwm_init_state(chip->pwm, &state);
+		state.period = chip->pwm_period;
+		state.duty_cycle = chip->pwm_period * chip->level / 100;
+		state.enabled = true;
+
+		error = pwm_apply_might_sleep(chip->pwm, &state);
+		if (error) {
+			dev_err(chip->dev, "Failed to enable PWM\n");
+			regulator_disable(chip->regulator);
+			return;
+		}
+	}
+
+	chip->enabled = true;
 }
 
 static void max8997_haptic_disable(struct max8997_haptic *chip)
@@ -282,11 +289,6 @@ static int max8997_haptic_probe(struct platform_device *pdev)
 			goto err_free_mem;
 		}
 
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(chip->pwm);
 		break;
 
 	default:

base-commit: 1343433ed38923a21425c602e92120a1f1db5f7a
-- 
2.49.0

