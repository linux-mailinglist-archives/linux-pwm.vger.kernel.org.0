Return-Path: <linux-pwm+bounces-2924-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFC593F857
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 16:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1831B244E5
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4D15B113;
	Mon, 29 Jul 2024 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jpuhyiE2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983315ADB3
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263713; cv=none; b=EPKK3RgMUfxGnf2fOYkdM6IIuEVe1d1wNTsFtq4PkEgEWjx7Z6g46jGrryw/0wy96Uc5mnhL8iwIABWT5mx/BITLV18IsGrqFLqiDVN8ID+8ZRaGKTeZ/UrrWOnAfH04CefFPlNWtMBaE1/QFfXwSJKs2ROqP6iXRjeG8X7teKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263713; c=relaxed/simple;
	bh=AaJoUcIX++IpzzWW0vVTaUFC2VwCQNaZTXiOvVfE78k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRG6/MsXNTdqshpIWD8b5k3rWLCmEnpFOXaq9ZsvI8ghHGDsg2VZqhmQV2hSsnt94z6H3zQU8kPsVPNem9Jz2drW4xQ6+79cZp1Kuk1X/A0O02hLLhukz7G45Vhr1Mdmi6wx8A911bvlMHfrwbK9g5y1M+Lwji7Nl/qOTc9+jXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jpuhyiE2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428163f7635so15796195e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722263709; x=1722868509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwL3WwnYCVO/qW47jad+fDcEi3a3huqXh2bt+q3kgnQ=;
        b=jpuhyiE2/Lg7x46HwrYhMpdmK2KN/Sj0HDFsCZdI6OPxi1VORA/u1yB1TO4vtoe2d5
         9AUPkfQYtk38O8Hfx3vCM351jT24N7cUdSxZtUbB0zLEQ/bXLv66f9h7Gt064pxmkkko
         nVjkivP1v46QoPnY6yBLnC/1lDUSFoIyQT4URkIGp1LiMKS9Kh38QA4FSj7RbL1BarGE
         g9GPO3GJBNzRC2LstYgQB3pJjPbYm36JvIlygUcO8NwbzF1IdEBPjgP1KJwFNUFDdU1J
         tgU8lTdMGkV7CXJhVi9FtQp2z2wbPz7cSob7VdYwv78fIZBbYYrpGkU9MzU4W8XM+Bok
         UVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263709; x=1722868509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwL3WwnYCVO/qW47jad+fDcEi3a3huqXh2bt+q3kgnQ=;
        b=oGU6ZQ+aibim+XM0PzfIQQcpY++3gPA9GZWeIrODDd9IHOMKDEsJLiD0b0bEHtLsK9
         +Jsd/Zpia5B5hPNJVRGv2Efb1JfwadO+qcAfil0ENcEOqwBYgkZQAb/MVFLvu0WFRpsu
         0HyVvQAHVAJPEO7aGraElmnVWBQpvycZkVvtvc0gx25s/NnSSwi9nvCoFQXUGxJRdntA
         ChHQBkCDUUeXksD7w/7zTOj3gk4Sd1SlzMy4oC/J6U6Tb0KI7yXUz3G5F2z+oUJzlnrW
         a2J4/FWW3TLEXbttP4KTPAb9Ft69bdEWHNV/TvWVYSbQl9otVhEHrgKF8aixL3JAwT1y
         m/bA==
X-Gm-Message-State: AOJu0YwJWcgCk4jf0hyLGvGeY1yOWRUvg5otktRt0mliYHmdQIfrdrNf
	dXtdY6QBjWvnCt1AQZ31CLtQUS1lJOx65QHue8jUJfbQiMA7pObQHsg+yYf6Yep57wusuCPLZQc
	j
X-Google-Smtp-Source: AGHT+IEr/04vIox2C0s7ifJ3PZSh2WTD4CEHgyvvjae51EkLT7+/m5KvKDmgYZoPttdqPdVuEKbzNQ==
X-Received: by 2002:a05:600c:3ca9:b0:428:2e9:6573 with SMTP id 5b1f17b1804b1-42811d99617mr51411425e9.17.1722263709162;
        Mon, 29 Jul 2024 07:35:09 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:59dd:510e:47d0:643f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281e72c21esm27404265e9.40.2024.07.29.07.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:35:08 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v3 2/8] pwm: Add more locking
Date: Mon, 29 Jul 2024 16:34:18 +0200
Message-ID:  <32467e0cbf3563820e6e6494dd593921627d0764.1722261050.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7509; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=AaJoUcIX++IpzzWW0vVTaUFC2VwCQNaZTXiOvVfE78k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmp6hwn/lMVjtivuMwePiBxjETvSYuajDQPBxLC itcNrGViUmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZqeocAAKCRCPgPtYfRL+ ThonB/44mihxh2nj5cy8Bac8vSQY8i9BJSJTlb5fXrkfFMYnx2r7sSocPqRtuej+XFeuBKCWan1 GdaDDwlp8yqeTi5rZLRPtamFUJcL632nk2YXFsKnTZeHisRKzf1z36SZFY1r0bVyn3XNpwh2wJB oM9frzQJ0L7c8gHfvC5cjRpq1aBxftMfZYnIempATX3oYZFC1HigehMiGGCFRH1Voa7GQMzuWz+ yer8TLugYtUv4EKLewRhbLdh+/7cCbA90Omuj+b7zqJo6E9lNrgQWBXRN6CRgj1ocv5wxEIQm4P wMV9xOaRTAiP1ECIMvnKPrftv4vLPczr1h4VYY7EJllD/fXT
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c  | 95 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/pwm.h | 13 +++++++
 2 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6e752e148b98..9752eb446879 100644
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
@@ -336,6 +367,11 @@ static int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 
 	guard(mutex)(&pwm_lock);
 
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
 	return ops->capture(chip, pwm, result, timeout);
 }
 
@@ -368,6 +404,14 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
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
 
@@ -396,7 +440,9 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		 */
 		struct pwm_state state = { 0, };
 
-		err = ops->get_state(chip, pwm, &state);
+		scoped_guard(pwmchip, chip)
+			err = ops->get_state(chip, pwm, &state);
+
 		trace_pwm_get(pwm, &state, err);
 
 		if (!err)
@@ -1020,6 +1066,7 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
+	chip->operational = false;
 
 	pwmchip_dev = &chip->dev;
 	device_initialize(pwmchip_dev);
@@ -1125,6 +1172,11 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
+	if (chip->atomic)
+		spin_lock_init(&chip->atomic_lock);
+	else
+		mutex_init(&chip->nonatomic_lock);
+
 	guard(mutex)(&pwm_lock);
 
 	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
@@ -1138,6 +1190,9 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
+	scoped_guard(pwmchip, chip)
+		chip->operational = true;
+
 	ret = device_add(&chip->dev);
 	if (ret)
 		goto err_device_add;
@@ -1145,6 +1200,9 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	return 0;
 
 err_device_add:
+	scoped_guard(pwmchip, chip)
+		chip->operational = false;
+
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_remove(chip);
 
@@ -1164,11 +1222,27 @@ void pwmchip_remove(struct pwm_chip *chip)
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
@@ -1538,12 +1612,17 @@ void pwm_put(struct pwm_device *pwm)
 
 	guard(mutex)(&pwm_lock);
 
-	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
+	/*
+	 * If the chip isn't operational, PWMF_REQUESTED was already cleared. So
+	 * don't warn in this case. This can only happen if a consumer called
+	 * pwm_put() twice.
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
2.43.0


