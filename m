Return-Path: <linux-pwm+bounces-3299-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F96E97D333
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9401B23052
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A1E13E8A5;
	Fri, 20 Sep 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pdqUJAiX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D997913C69E
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822723; cv=none; b=t0khET/bT8EEZYqNk88qVPSW+p8i62IVTSdQx25yrFEOYRg0p2ijl/0n9W6Dc6RrjWfVszX2Ji/MElZCQpkvkoV4P2EZyV14wEKFP3JeARYu0/Ed1K/Mcanw3grQVM/Ynh7GwMa+A4ilHOglmD+RfWiqPf6IoQpdbYqRFShcYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822723; c=relaxed/simple;
	bh=4E7C/c16nPTWJ4yxI3dGk9whZMyFDX/e+y1tHecZPlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPrGBCwbYJtg8oP0XnKO2p18frDNA1nG7nE5Iaqha8iJzjhpLUqvVaqGvFUCfrwUZ2feUdT71IoDlOAGcW0plygMwkXeZP5gIYEILQNIJGotCQg39amWWdksxbgSsa08to20Vz8ioA32gc7X19EdAza7AZILGVQMKVOSsp9bBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pdqUJAiX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374b25263a3so1103694f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726822716; x=1727427516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzvc37VHVg04V+452CxRFErObOFJfPxlf2jP4P/FDos=;
        b=pdqUJAiXrqE0HDLQviUfozWVxOztTDCKc5kjDqr9sFWcFCK2J0NBH9rRaT7xvWaIgi
         ZX5qr3g6/uutH9LdqFZCPA0XdkJNOzTf1P/K49Ti7Qe9jth5QE9UFogajazeTw2JO4Bh
         udP4+Pm3IGC4suRoSn7ziePzSzXGVEnb5ElKb2AT99wLJap/VM4fSbhwveV+hhPrBncW
         rKzuXCN6GuR0zu0QvMm1Ctod969uqIlOeczib077MXGAB9ly1QaRWMNYU9gKs5y2m0F/
         lPuczX1WvSbdIsY0DmGvFUq8N2veCjMWxWzyn2ioagciFEBCW3w28eQDwFJL82C9YT03
         c+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726822716; x=1727427516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzvc37VHVg04V+452CxRFErObOFJfPxlf2jP4P/FDos=;
        b=VvDsxpquAlK/jYK8ziAV56NonhgyU20YwqJPgkFTT2dumEkZ9f8/6R/uNtQKy/fCSQ
         J+CIIR+b/dwxn8lQ103kmrhivBGpxpYg6hJLGWDKZp1U9h+CnTRcGf44kDozuG4BLYkq
         MTqOXWpoYM0wVdYHl9vQ8+ZTyg0KpC2esm6v7STyiOKKEVQERga6OaJei9my64XREyZO
         mZrzfPev6W8S6NyoXAQV7QxSqei/y+RGQaSp5sRZhd2uJ79OXwXeUlXXG8n9T+fTTbOQ
         VnCOp2NO6E+B59BnKany1o81673AOydELqjSGRj7GTPBVgU1AZcutnFRBv+XrAM0T2GW
         Zl5Q==
X-Gm-Message-State: AOJu0Yw39vrR4hTi2e/RyNIdgawqu9pKpKErfo4xRZZsDLDvDddl82xj
	ve79QGjpk5kYyfJMcRbws8RrrBg1yAa8ZV9uIpaD6fMWk9qYWmSSrWMU3bUBMvCfo/8WW7ps6U/
	R
X-Google-Smtp-Source: AGHT+IFe1BsyAwY76UmSJ9u2dEJcJrub3L2uKG9nUG7Ft5KzahD4NbXDtui14MxBHp2UhzQEuSX4+g==
X-Received: by 2002:a5d:4483:0:b0:374:c0c9:d171 with SMTP id ffacd0b85a97d-37a4223e133mr1137682f8f.1.1726822716002;
        Fri, 20 Sep 2024 01:58:36 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e8388sm17088698f8f.32.2024.09.20.01.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:58:35 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v5 1/8] pwm: Add more locking
Date: Fri, 20 Sep 2024 10:57:57 +0200
Message-ID:  <026aa891c8270a11723a1ba7e4256f456f7e1e86.1726819463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8069; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4E7C/c16nPTWJ4yxI3dGk9whZMyFDX/e+y1tHecZPlg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm7TkY27vYFmiIn8r7Sxoz2Fa+gOFPaVx3SGkkO tj03sGKtG+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZu05GAAKCRCPgPtYfRL+ ThHXB/9fvHfRm2opZ/yPbuxv2JEgNhjIyGwKxwhppIvzklGdE8aknS5tsZPDx1zdl/efdYGgTA4 78qCAVg2gIIKoE7yxtZJuTFjyg8QZbWQEkmkJweEHcOCIMLJ/RyROB3CzzOpqYIW2zugVYFjlxe AjSgnEo2oxOQ7trMAOWfYGGZAhELl0SWDnqNSNmrZdF17XiEQd0pP18t5n3VwSFcYnuYwVkxcO/ lyPcJ8HMGI/3ZDifCrprFz5s/1oNTV6XH6g6pGkt3wOt9uPd5oCCrFSPTjVE5SDqLQNmI+cL0MS qj1NXP5CrJr4AOviczfqRJPQHyKDvfPeP82hIrvNme9uD991
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This ensures that a pwm_chip that has no corresponding driver isn't used
and that a driver doesn't go away while a callback is still running.

In the presence of device links this isn't necessary yet (so this is no
fix) but for pwm character device support this is needed.

To not serialize all pwm_apply_state() calls, this introduces a per chip
lock. An additional complication is that for atomic chips a mutex cannot
be used (as pwm_apply_atomic() must not sleep) and a spinlock cannot be
held while calling an operation for a sleeping chip. So depending on the
chip being atomic or not a spinlock or a mutex is used.

An additional change implemented here is that on driver remove the
.free() callback is called for each requested pwm_device. This is the
right time because later (e.g. when the consumer calls pwm_put()) the
free function is (maybe) not available any more.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c  | 100 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/pwm.h |  13 ++++++
 2 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6e752e148b98..5a095eb46b54 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -31,6 +31,24 @@ static DEFINE_MUTEX(pwm_lock);
 
 static DEFINE_IDR(pwm_chips);
 
+static void pwmchip_lock(struct pwm_chip *chip)
+{
+	if (chip->atomic)
+		spin_lock(&chip->atomic_lock);
+	else
+		mutex_lock(&chip->nonatomic_lock);
+}
+
+static void pwmchip_unlock(struct pwm_chip *chip)
+{
+	if (chip->atomic)
+		spin_unlock(&chip->atomic_lock);
+	else
+		mutex_unlock(&chip->nonatomic_lock);
+}
+
+DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
+
 static void pwm_apply_debug(struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -220,6 +238,7 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	int err;
+	struct pwm_chip *chip = pwm->chip;
 
 	/*
 	 * Some lowlevel driver's implementations of .apply() make use of
@@ -230,7 +249,12 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 	 */
 	might_sleep();
 
-	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
 		/*
 		 * Catch any drivers that have been marked as atomic but
 		 * that will sleep anyway.
@@ -254,9 +278,16 @@ EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
  */
 int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
 {
-	WARN_ONCE(!pwm->chip->atomic,
+	struct pwm_chip *chip = pwm->chip;
+
+	WARN_ONCE(!chip->atomic,
 		  "sleeping PWM driver used in atomic context\n");
 
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
 	return __pwm_apply(pwm, state);
 }
 EXPORT_SYMBOL_GPL(pwm_apply_atomic);
@@ -334,8 +365,18 @@ static int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 	if (!ops->capture)
 		return -ENOSYS;
 
+	/*
+	 * Holding the pwm_lock is probably not needed. If you use pwm_capture()
+	 * and you're interested to speed it up, please convince yourself it's
+	 * really not needed, test and then suggest a patch on the mailing list.
+	 */
 	guard(mutex)(&pwm_lock);
 
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
 	return ops->capture(chip, pwm, result, timeout);
 }
 
@@ -368,6 +409,14 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	if (test_bit(PWMF_REQUESTED, &pwm->flags))
 		return -EBUSY;
 
+	/*
+	 * This function is called while holding pwm_lock. As .operational only
+	 * changes while holding this lock, checking it here without holding the
+	 * chip lock is fine.
+	 */
+	if (!chip->operational)
+		return -ENODEV;
+
 	if (!try_module_get(chip->owner))
 		return -ENODEV;
 
@@ -396,7 +445,9 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		 */
 		struct pwm_state state = { 0, };
 
-		err = ops->get_state(chip, pwm, &state);
+		scoped_guard(pwmchip, chip)
+			err = ops->get_state(chip, pwm, &state);
+
 		trace_pwm_get(pwm, &state, err);
 
 		if (!err)
@@ -1020,6 +1071,7 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
+	chip->operational = false;
 
 	pwmchip_dev = &chip->dev;
 	device_initialize(pwmchip_dev);
@@ -1125,6 +1177,11 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
+	if (chip->atomic)
+		spin_lock_init(&chip->atomic_lock);
+	else
+		mutex_init(&chip->nonatomic_lock);
+
 	guard(mutex)(&pwm_lock);
 
 	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
@@ -1138,6 +1195,9 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
+	scoped_guard(pwmchip, chip)
+		chip->operational = true;
+
 	ret = device_add(&chip->dev);
 	if (ret)
 		goto err_device_add;
@@ -1145,6 +1205,9 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	return 0;
 
 err_device_add:
+	scoped_guard(pwmchip, chip)
+		chip->operational = false;
+
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_remove(chip);
 
@@ -1164,11 +1227,27 @@ void pwmchip_remove(struct pwm_chip *chip)
 {
 	pwmchip_sysfs_unexport(chip);
 
-	if (IS_ENABLED(CONFIG_OF))
-		of_pwmchip_remove(chip);
+	scoped_guard(mutex, &pwm_lock) {
+		unsigned int i;
+
+		scoped_guard(pwmchip, chip)
+			chip->operational = false;
+
+		for (i = 0; i < chip->npwm; ++i) {
+			struct pwm_device *pwm = &chip->pwms[i];
+
+			if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
+				dev_warn(&chip->dev, "Freeing requested PWM #%u\n", i);
+				if (pwm->chip->ops->free)
+					pwm->chip->ops->free(pwm->chip, pwm);
+			}
+		}
+
+		if (IS_ENABLED(CONFIG_OF))
+			of_pwmchip_remove(chip);
 
-	scoped_guard(mutex, &pwm_lock)
 		idr_remove(&pwm_chips, chip->id);
+	}
 
 	device_del(&chip->dev);
 }
@@ -1538,12 +1617,17 @@ void pwm_put(struct pwm_device *pwm)
 
 	guard(mutex)(&pwm_lock);
 
-	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
+	/*
+	 * Trigger a warning if a consumer called pwm_put() twice.
+	 * If the chip isn't operational, PWMF_REQUESTED was already cleared in
+	 * pwmchip_remove(). So don't warn in this case.
+	 */
+	if (chip->operational && !test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
 		pr_warn("PWM device already freed\n");
 		return;
 	}
 
-	if (chip->ops->free)
+	if (chip->operational && chip->ops->free)
 		pwm->chip->ops->free(pwm->chip, pwm);
 
 	pwm->label = NULL;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 8acd60b53f58..3ea73e075abe 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -275,6 +275,9 @@ struct pwm_ops {
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @atomic: can the driver's ->apply() be called in atomic context
  * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate this chip
+ * @operational: signals if the chip can be used (or is already deregistered)
+ * @nonatomic_lock: mutex for nonatomic chips
+ * @atomic_lock: mutex for atomic chips
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
@@ -290,6 +293,16 @@ struct pwm_chip {
 
 	/* only used internally by the PWM framework */
 	bool uses_pwmchip_alloc;
+	bool operational;
+	union {
+		/*
+		 * depending on the chip being atomic or not either the mutex or
+		 * the spinlock is used. It protects .operational and
+		 * synchronizes the callbacks in .ops
+		 */
+		struct mutex nonatomic_lock;
+		spinlock_t atomic_lock;
+	};
 	struct pwm_device pwms[] __counted_by(npwm);
 };
 
-- 
2.45.2


