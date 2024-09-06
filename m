Return-Path: <linux-pwm+bounces-3129-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57096F882
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC02FB217D3
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10C61D2F67;
	Fri,  6 Sep 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MTupz23O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9A1D2F61
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637415; cv=none; b=IxDXUH5ISfdRL575p5aEkAD5tp7bNOpUaNXzAqyKE/Jt8hXI64e2yWb77fAABcUhykF7d1Z7vhOt3s0jl/PbnVsXqzSHQLw5X8+sf6FJm9Lvr7RDBjdePkgYZFNXOxA5t7DSBkeST+t86RQ2dnnWD2/AD7j7r/l4NEvNd7+aAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637415; c=relaxed/simple;
	bh=Xtxhq8p6IxS/gupz8f0hD1RxNE1TttBHcsxrgSeRr0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnQqKfU4LUwGXfNCoyDPfwf2H9n2PMgVFUO51DaXJpPiFm2m5rmYOPuV+lz1fP7oWAcN4Y9Xmer447CFtHDk/XAGeFlKZjoU94K0bdUETe06RlJp8HEISx/llutu4+AR1NnPxKm61nEZp2l1A7JWvrPLnioAkcC9H/7fqTq935Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MTupz23O; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53653ff0251so2363322e87.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725637411; x=1726242211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2Hi/NsJKeRpEgZEhDEd3COIWkodgKEK8BzTe9KYDiU=;
        b=MTupz23ObRqgTXxS7VSuUfMsQF/fdjioApfljvzzuchkI0LUzCA72+hWjhaDJBrt/W
         xK2dVWr2UquONniS6oSKMmZsoIkHszuFcijFEMyBE18m5i72DkkmxPcMSixL6KSezCmU
         RDFlh3RK0tslIRSwZD1ITk/CTw/PNtHII5Qwi3PdrBKb6sG5S0ylD5LEv6pP+Y1BggIJ
         SNcrLh3MDS8irElTSb/iZt0ZTRyZkBhQ/GFpuhq5SuME/ATt8c9N1kYlYzQ6DFL+jPiK
         1jeA96Pdk6P+OrYOD8FKKyia/yHdGAr5BTDU50JfrxBnJR2Zt5EuWNBz+GtXRTTjbe98
         6j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637411; x=1726242211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2Hi/NsJKeRpEgZEhDEd3COIWkodgKEK8BzTe9KYDiU=;
        b=X1f2RVEpKEJ5SLl893gXXtYjhbjRtPgjkCwusgSxdN76PV8lW2CoCZ9Gp2V8i46nDO
         Wb7ROAz74+UYS6yjApAWwEh32QstwzchKGskvA3+uPE4cwbGopg8+BcnTKLeNYC0VZy4
         EhwuH7WRT8wWUtjaQdKKA7zeCKRICF7E9Z5u88fqPj3FgrlEcwTz9TbMuNgdj5dLmxKk
         6eJ5PaAx+YwtFNoOCYGV8c7Yh/6DdF450WNsE0J1dVSh3ODDhW4mNrvrc0rA+87PgoeY
         Bbob4RMNGEj8bHYoTYnemXXHLhxz3AOVq0jvlTEjzHwknGwAdRW2mzIOJ9DZfoRHJdaN
         NgMA==
X-Gm-Message-State: AOJu0YxlYpUhUwL6BHEoSUayh5aoOqgQgK8dG1vlZtx1Svjoo/rF0lbJ
	9rXrOJcCQFmX5Z3xrTg9HMrDblsp6nAu10kYKtoYDW0Wrj4ay8lX7aACp208UsLzaxmi7hMkwT1
	F
X-Google-Smtp-Source: AGHT+IEEDpgfecW7+VfEl3soU2eIhQzW8p9ZP576rz9pD/uyD9gWOR9XlVjY4PjiRf+u1tqwhhlUIw==
X-Received: by 2002:a05:6512:12c1:b0:52e:9382:a36 with SMTP id 2adb3069b0e04-536587b902bmr1896765e87.30.1725637410882;
        Fri, 06 Sep 2024 08:43:30 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62045832sm289634266b.75.2024.09.06.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:43:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Kent Gibson <warthog618@gmail.com>,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 1/7] pwm: Add more locking
Date: Fri,  6 Sep 2024 17:42:57 +0200
Message-ID:  <a519af534a6670fdb0c3ee9c2aa80106c35ff489.1725635013.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7509; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Xtxhq8p6IxS/gupz8f0hD1RxNE1TttBHcsxrgSeRr0U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm2yMEZuWPC1D+md0bTZu6tnpBlQ0mzz5on55LB EzwRObJnuOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZtsjBAAKCRCPgPtYfRL+ TtJECACDhf+8JHFCCHDHahq8G6Tjgz1HsrUSVXFsXly4aF6ftO5yJ0bk6ga14shzED6ws9LFM73 zMtl3MlpeRtuzL5cn839Pl1pk6gaAkjxncy4MWDBxKciUk2EZ06c8o260D3ippfn0SB/sBRgWFK 6JZbH4UXfbRO6iqz3VTiiUDLio/0xc3rKpspdOEtqX7EDgHqRrljZgmWh9pEEgr/xZOr3D1eEMK UMn/clT3n4Y/x3XO86ml+1Q98y9i3kS81xYhr7bkGAnIoGrInLYaVuKhqpkUNBFv2UGtF6OflZU B7u93NH8qYB2ISAUikX+3u+Xz7GaAp8DGAMLSDRcRyItNpWn
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
2.45.2


