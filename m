Return-Path: <linux-pwm+bounces-6907-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28CB14C54
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 12:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08A318A18BC
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6FC28BA87;
	Tue, 29 Jul 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z0Mwb1NP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7928AB07
	for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785401; cv=none; b=rEKo/+0Ab40FPFTHD4yixAQfCdWpsO1M9nmV2S38iQdWMijobiFiLE1laNfD/+txUxDCydk8zyhEAIO8Y+xD8EQ2SC471JoLw4k4S+5IJErv4LUdIgwsvpxoZ6YnmTJblpZQKWQOgTmr/7wd7yIh1RJkWKFBpsA1lPc7dv28IAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785401; c=relaxed/simple;
	bh=vbJJ56VU7p92Dn6IGl4obLt5d57ZoN9r6yd+NE7p+Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bF8r/qt1NcKtXs1FBfhRBZ/pjOfRAIFggwAOWFnWr7f1XavsxsB4F6IC3M89XudCHTfIFl9a571MtUCHTbphq5WM7Ly6J2JRbGaHNxjF/N8KatU+HnAom1tO8vHrWY1qQiNTPYqSMlKVwYX1xgwFur+r6BbTCWqnMCKZeRlBfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z0Mwb1NP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso1053429f8f.0
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753785396; x=1754390196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILZsmFm+KaxI485jnWnzugD9ziJLMIRNNh5UIMPlOzk=;
        b=z0Mwb1NP26m1ooTa/067jD3gtvhVsjtYJWNZ42Lh5RxFAgSLeNaKWgS7soTwz9FyKl
         U8zh5hU1kJequWxvHtN8BxVyhywsFxE0+le2aw4h41jEPb+I54AIBtlnvlpFlTgOu8Sv
         5nLA9O54B9HZVdGJepNzwKWZ9iWRDrej66ReK674vsRp9AFLjwoGkMeQQhxZD0LNa907
         kxGfJo3UcOxXvr5jCoEOZoVifLuig/26+a1fO1pvLbyevYCeB5JQC8Sasua6arFuiM9z
         FJL890w42oLDePUhGZnh7tOKmTO/rwj/ItS8K7qX7OmroJWWJBulXzEvrLsXTwTfgVWH
         vbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785396; x=1754390196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILZsmFm+KaxI485jnWnzugD9ziJLMIRNNh5UIMPlOzk=;
        b=VLjCyw1kzg5MKHESoxdvzoneRZh9BbOGz3XtcdDaIfZ/28vuYiESKQ12uHYJHwD1Zr
         vzpT68wS9VdnLaGrZdpl/XpvZMIZN0IVsqGVIlcxOGF1S71F6m4v0vApvUgLJptuMFVd
         hJAw9aUeWaIATG4K7HxRjSu/DmpXHMs29QSrmzkvuUZQe/THavfTdgLMzgYuVm2X7WRO
         5qFgvOrmaqoAu+iGQWaV6Jnx+EkFFObMTt2iXbKsst+TP/34jkTJYCfxjCjJ8MVdrvQT
         z7/FE9zMKYDaRKQRNqX6OZHq0vL23R/i7JjJ8bdOszDTWOMD5KSJGjYjteg5uDweSrnD
         g61A==
X-Gm-Message-State: AOJu0YzErJLQje5A8THtLpNL1zZ7zlFJR36c+E8XVJ3wU61zHIVfmRmq
	B9HahuqIAtqoGvaODXplfp5n1z0wOgP2CtYAeZKFsXc2H6TLxGmeqEzU3FLMBUjVu47OXe7FPM5
	O0KKE
X-Gm-Gg: ASbGncvIu+gfE3dh+ypvBfPovxPla+a3+v57EFJ7loVWizv3P56lWH/jFmfS0/ILXXu
	zc2bB7MuYwWwMpSjJF8TKX41D83SRQYwKwjWyM9S7D4WqhCCJi3Faf/d5FXlBNGoRC448WyvH+Q
	nJwTxG0A3D0Q9HX3MmL6samypFhPfx013wcOrRo9jg4s7yz2BgQg9zgkX9kT1MOQ7bd/uRKW7vx
	0295SVed2TCVQb3IMFW+A9Le9wpfRhmlKttZExzmcX8QU0g3A7+pwb/k5KDKJxF78JI6LG34eqj
	brNBnYfw1n6Thxq8Eiy0iHuotWDbZ8Qs16VZDTf4y9GIMf873I7Y5L/wLl9kNfsrOx+BUCnLj7k
	JvZgrCJU/o1P6eyOsnfSfdG7QPPqn8LSxMUwD2jUlsA9NTNn97+0ujnn6kmcAht9C+An5FmwFLL
	A=
X-Google-Smtp-Source: AGHT+IFa/CFDIaAaH9tN7MNxbpnS3kOcobWhqvyDzNhQqLICbSJo5bNe1bjRQG5+K8fTlTpOov4j+A==
X-Received: by 2002:a05:6000:18aa:b0:3b7:9233:ebb with SMTP id ffacd0b85a97d-3b79233114cmr965649f8f.6.1753785396364;
        Tue, 29 Jul 2025 03:36:36 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778f0c866sm11498851f8f.55.2025.07.29.03.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:36:35 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Jander <david@protonic.nl>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] pwm: pca9685: Drop GPIO support
Date: Tue, 29 Jul 2025 12:36:03 +0200
Message-ID:  <d975376fce9640c90ddc868e3722adeb83fff279.1753784092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
References: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6256; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vbJJ56VU7p92Dn6IGl4obLt5d57ZoN9r6yd+NE7p+Ik=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoiKQb9SqfmS4RnreDDX1ciLqZhHV8R1R8o0k2V 160jncMWAqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIikGwAKCRCPgPtYfRL+ TlnBCAC6Wopoy4dP5sNZ2aYzStnFhX1+7F9Z9If3RETL7v5qT880/SgjSEYL4J+84zyMtvZHMuj BzZAQvuHlFtGSeXUga8wIuws/aa7sUHGgqJae+l6CeF08Ph5NLsvP5n78J23gHo+qZ6VT2bCtq9 q/saNiFraYFglZSj5kMGfOPtwGb9WIgGPc4R/hM+8pbFQn7ScexGUjUva42fa3sV5dOPlciVrw5 poaRGbL5Tyk1pe+jazRTfXDscUN3XVlDEGxTpQEd45vELVXA80ZhaQAv/7N11NfqCpUJUm8SU88 7ZMp1cxNvJZHq6nyaPabI5UXDkwDYd90yw4HNx6rFbVudXE6
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The functionality will be restored after the driver is converted to the
waveform API as the pwm core optionally provides a gpio chip for all
pwm chips that support the waveform API.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-pca9685.c | 156 --------------------------------------
 1 file changed, 156 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 536a3e15a254..3f04defd3718 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -26,7 +26,6 @@
  * that is enabled is allowed to change the prescale register.
  * PWM channels requested afterwards must use a period that results in the same
  * prescale setting as the one set by the first requested channel.
- * GPIOs do not count as enabled PWMs as they are not using the prescaler.
  */
 
 #define PCA9685_MODE1		0x00
@@ -80,10 +79,6 @@ struct pca9685 {
 	struct regmap *regmap;
 	struct mutex lock;
 	DECLARE_BITMAP(pwms_enabled, PCA9685_MAXCHAN + 1);
-#if IS_ENABLED(CONFIG_GPIOLIB)
-	struct gpio_chip gpio;
-	DECLARE_BITMAP(pwms_inuse, PCA9685_MAXCHAN + 1);
-#endif
 };
 
 static inline struct pca9685 *to_pca(struct pwm_chip *chip)
@@ -217,147 +212,6 @@ static unsigned int pca9685_pwm_get_duty(struct pwm_chip *chip, int channel)
 	return (off - on) & (PCA9685_COUNTER_RANGE - 1);
 }
 
-#if IS_ENABLED(CONFIG_GPIOLIB)
-static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
-{
-	bool is_inuse;
-
-	mutex_lock(&pca->lock);
-	if (pwm_idx >= PCA9685_MAXCHAN) {
-		/*
-		 * "All LEDs" channel:
-		 * pretend already in use if any of the PWMs are requested
-		 */
-		if (!bitmap_empty(pca->pwms_inuse, PCA9685_MAXCHAN)) {
-			is_inuse = true;
-			goto out;
-		}
-	} else {
-		/*
-		 * Regular channel:
-		 * pretend already in use if the "all LEDs" channel is requested
-		 */
-		if (test_bit(PCA9685_MAXCHAN, pca->pwms_inuse)) {
-			is_inuse = true;
-			goto out;
-		}
-	}
-	is_inuse = test_and_set_bit(pwm_idx, pca->pwms_inuse);
-out:
-	mutex_unlock(&pca->lock);
-	return is_inuse;
-}
-
-static void pca9685_pwm_clear_inuse(struct pca9685 *pca, int pwm_idx)
-{
-	mutex_lock(&pca->lock);
-	clear_bit(pwm_idx, pca->pwms_inuse);
-	mutex_unlock(&pca->lock);
-}
-
-static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
-{
-	struct pwm_chip *chip = gpiochip_get_data(gpio);
-	struct pca9685 *pca = to_pca(chip);
-
-	if (pca9685_pwm_test_and_set_inuse(pca, offset))
-		return -EBUSY;
-	pm_runtime_get_sync(pwmchip_parent(chip));
-	return 0;
-}
-
-static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
-{
-	struct pwm_chip *chip = gpiochip_get_data(gpio);
-
-	return pca9685_pwm_get_duty(chip, offset) != 0;
-}
-
-static int pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
-				int value)
-{
-	struct pwm_chip *chip = gpiochip_get_data(gpio);
-
-	pca9685_pwm_set_duty(chip, offset, value ? PCA9685_COUNTER_RANGE : 0);
-
-	return 0;
-}
-
-static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
-{
-	struct pwm_chip *chip = gpiochip_get_data(gpio);
-	struct pca9685 *pca = to_pca(chip);
-
-	pca9685_pwm_set_duty(chip, offset, 0);
-	pm_runtime_put(pwmchip_parent(chip));
-	pca9685_pwm_clear_inuse(pca, offset);
-}
-
-static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
-					  unsigned int offset)
-{
-	/* Always out */
-	return GPIO_LINE_DIRECTION_OUT;
-}
-
-static int pca9685_pwm_gpio_direction_input(struct gpio_chip *gpio,
-					    unsigned int offset)
-{
-	return -EINVAL;
-}
-
-static int pca9685_pwm_gpio_direction_output(struct gpio_chip *gpio,
-					     unsigned int offset, int value)
-{
-	pca9685_pwm_gpio_set(gpio, offset, value);
-
-	return 0;
-}
-
-/*
- * The PCA9685 has a bit for turning the PWM output full off or on. Some
- * boards like Intel Galileo actually uses these as normal GPIOs so we
- * expose a GPIO chip here which can exclusively take over the underlying
- * PWM channel.
- */
-static int pca9685_pwm_gpio_probe(struct pwm_chip *chip)
-{
-	struct pca9685 *pca = to_pca(chip);
-	struct device *dev = pwmchip_parent(chip);
-
-	pca->gpio.label = dev_name(dev);
-	pca->gpio.parent = dev;
-	pca->gpio.request = pca9685_pwm_gpio_request;
-	pca->gpio.free = pca9685_pwm_gpio_free;
-	pca->gpio.get_direction = pca9685_pwm_gpio_get_direction;
-	pca->gpio.direction_input = pca9685_pwm_gpio_direction_input;
-	pca->gpio.direction_output = pca9685_pwm_gpio_direction_output;
-	pca->gpio.get = pca9685_pwm_gpio_get;
-	pca->gpio.set_rv = pca9685_pwm_gpio_set;
-	pca->gpio.base = -1;
-	pca->gpio.ngpio = PCA9685_MAXCHAN;
-	pca->gpio.can_sleep = true;
-
-	return devm_gpiochip_add_data(dev, &pca->gpio, chip);
-}
-#else
-static inline bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca,
-						  int pwm_idx)
-{
-	return false;
-}
-
-static inline void
-pca9685_pwm_clear_inuse(struct pca9685 *pca, int pwm_idx)
-{
-}
-
-static inline int pca9685_pwm_gpio_probe(struct pwm_chip *chip)
-{
-	return 0;
-}
-#endif
-
 static void pca9685_set_sleep_mode(struct pwm_chip *chip, bool enable)
 {
 	struct device *dev = pwmchip_parent(chip);
@@ -487,9 +341,6 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
 
-	if (pca9685_pwm_test_and_set_inuse(pca, pwm->hwpwm))
-		return -EBUSY;
-
 	if (pwm->hwpwm < PCA9685_MAXCHAN) {
 		/* PWMs - except the "all LEDs" channel - default to enabled */
 		mutex_lock(&pca->lock);
@@ -511,7 +362,6 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_unlock(&pca->lock);
 
 	pm_runtime_put(pwmchip_parent(chip));
-	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
 }
 
 static const struct pwm_ops pca9685_pwm_ops = {
@@ -615,12 +465,6 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = pca9685_pwm_gpio_probe(chip);
-	if (ret < 0) {
-		pwmchip_remove(chip);
-		return ret;
-	}
-
 	pm_runtime_enable(&client->dev);
 
 	if (pm_runtime_enabled(&client->dev)) {
-- 
2.50.0


