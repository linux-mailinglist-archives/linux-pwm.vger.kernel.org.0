Return-Path: <linux-pwm+bounces-2721-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FD792A08A
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 12:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431621C20FC0
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 10:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131878276;
	Mon,  8 Jul 2024 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pihhcRLN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B578C7F
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435981; cv=none; b=YS4CawsbvXT/aTFT3PBD8fGa7SRg0699Is7tYaTlX00HMaNvN/rq7fQHUBpMB1ky4ki6jEsRLTiIzSuK09XRNb7on3OTDEuFHU/DakcBYvOt8RPHp24BCjYq+Syn43+l2IEVWzBlASEpzyiPhEzJKYsumzDCcKjnRtl/RGGt/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435981; c=relaxed/simple;
	bh=GGCCgLkO274+XDpQcgYgeQzKCK43CBf3srjmHwgoVz4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lq0o5e9SwMjCQlphohFUjuaYsYOCoRtyB6zCg+MlNJn1UnUEjEQohviE0k7qTZXOx9BjQcUFqMA+BFc3Ff8O/xSdW2raPLnUmgJvCh2pDFJWeCegfnI3WyaqXqXnzvXl/aDD4Wj+kZ3RhbSTG2Ar3cZGNmunz1ycq6ULyZcl5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pihhcRLN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367ab50a07aso1846381f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 03:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720435977; x=1721040777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENr9C6wqLScYtM/ACpfJbtdpg2MMvtMfkrf/bCmK5uo=;
        b=pihhcRLNHv5wlWg/h20sfFaLUJ/Builg2AfQ9dVKx7yEzy49ieN54yU4pRFfio6cmp
         7n1usQRmv/qSXvXWI0zCBXm/QH5oB/zE00+DbHNxzGD+3AEPBk7g+yjPI2dgcJfI6kuh
         bXZh8w6lYSiKRu+PF4oKgnZVW31nKgaOJq8yerNPp0/MTsHv658TCbYndhMjaeKLHIGO
         DOVFbDzBVz0ynAh7w9ZuCBw2eO3szgLmY52omFIXYQuQDSwWXaOCtc9XgWbcd6dQ027Y
         A11XRtCLKRZ6ykBH9xZLzt6IjTh4+BsHy6kzGRgLe/kGw7VCL2TLvcAvJ86OtFkKdt3+
         qkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435977; x=1721040777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENr9C6wqLScYtM/ACpfJbtdpg2MMvtMfkrf/bCmK5uo=;
        b=lRFrJb9ABk1bjCF6IjK9Rgsy42TZKhMtQATfuG7eg1MW6nJj4RoHKB1rv8vZdIyO0X
         MB3cmfLj0ciSpC/t1ydH8fQ6XVH5c7hBoIqq0/g4v6clEH35u9gUwAlJ55xXiuCf1w0F
         Qo0xKeCQ3sATfRjDuIJsLGp2f9+s705Jb5G494qBtjAEucKXDtjvRQeIoCjZ3XAuufVE
         qEuL4M1fykgCpe7zBYW3JZvlDKLtf6MEOtoAO3kwEGDAE3mhmHmd24h6sPKI6GkavzRs
         OJFSHsN8iWp759y3ZniZweMB9EbLoK1sJwNTTPoy1HfdVYaf7m58Q2FzszxvZnMDuONX
         3mXA==
X-Gm-Message-State: AOJu0YyqQzZGQV406VDhhQgypFhFE8RWPQQc0DEwfc37j1N9J2kDmJgT
	kIyfM4+tTE8Vzj5meu41djQGqxuYzrCPdI+Sic6d0y1bRKgn8wLmm33Nfo+Hm34kkzYin9QDJIZ
	i
X-Google-Smtp-Source: AGHT+IE3XZYNK/otDFabY0D3eQVUP+Cv9yOwc4qG8Hwmy+sRItsFqJrh3eAZzXttYUP89mj0NxUqJg==
X-Received: by 2002:a5d:5184:0:b0:367:8a2b:734e with SMTP id ffacd0b85a97d-3679dd15b85mr7272537f8f.12.1720435977086;
        Mon, 08 Jul 2024 03:52:57 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678e68a622sm14852116f8f.106.2024.07.08.03.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:52:56 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 1/6] pwm: Add more locking
Date: Mon,  8 Jul 2024 12:52:27 +0200
Message-ID:  <d8172fd493b074372bbc2ad1f4ac38023e3552b5.1720435656.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7925; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=GGCCgLkO274+XDpQcgYgeQzKCK43CBf3srjmHwgoVz4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmi8Tu9ZyBSyVaUpMvWXKbfRcG+ujGgzL1EVJbA qdZ9LATbnaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZovE7gAKCRCPgPtYfRL+ TvCbCACJXbnpg+uU7RDnForMsnpQWvQYxhNRLhgQPrACJD2tvZFsnsvK9LxSaRc1VYL1uNHSWu4 InW5q/nEa9bro6+gS/JmAMaZmhWCAYCynFdqfmVZIf8X0WB38Zb/t4gW0C9X1c6EzVO4kOlLsdi 7fy35XGWUMzrKmkLNHjUgLXnDKXMKRazny2BUPDrJ33B5niitJ4oQIzwvVMSmzY3kGCKiB/diGG 9B8Wnzaa+I/oi06kg0uDtFSU5ieloSnhGgWoSRts+6nxS18PwcvKgz5alHalYigPhRBmrvskAtB +72fYdLBUw+cs3ktFRJb2vTfAtTMLKvPzaq00t12iOzwVF94
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
 drivers/pwm/core.c  | 103 +++++++++++++++++++++++++++++++++++++++-----
 include/linux/pwm.h |  13 ++++++
 2 files changed, 105 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 8acbcf5b6673..c31e12e76495 100644
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
@@ -328,15 +359,22 @@ EXPORT_SYMBOL_GPL(pwm_adjust_config);
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout)
 {
-	if (!pwm || !pwm->chip->ops)
+	struct pwm_chip *chip;
+
+	if (!pwm || !(chip = pwm->chip)->ops)
 		return -EINVAL;
 
-	if (!pwm->chip->ops->capture)
+	if (!chip->ops->capture)
 		return -ENOSYS;
 
 	guard(mutex)(&pwm_lock);
 
-	return pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
+	return chip->ops->capture(pwm->chip, pwm, result, timeout);
 }
 EXPORT_SYMBOL_GPL(pwm_capture);
 
@@ -369,6 +407,14 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
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
 
@@ -397,7 +443,9 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		 */
 		struct pwm_state state = { 0, };
 
-		err = ops->get_state(chip, pwm, &state);
+		scoped_guard(pwmchip, chip)
+			err = ops->get_state(chip, pwm, &state);
+
 		trace_pwm_get(pwm, &state, err);
 
 		if (!err)
@@ -1021,6 +1069,7 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
+	chip->operational = false;
 
 	pwmchip_dev = &chip->dev;
 	device_initialize(pwmchip_dev);
@@ -1126,6 +1175,11 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
+	if (chip->atomic)
+		spin_lock_init(&chip->atomic_lock);
+	else
+		mutex_init(&chip->nonatomic_lock);
+
 	guard(mutex)(&pwm_lock);
 
 	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
@@ -1139,6 +1193,9 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
+	scoped_guard(pwmchip, chip)
+		chip->operational = true;
+
 	ret = device_add(&chip->dev);
 	if (ret)
 		goto err_device_add;
@@ -1146,6 +1203,9 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	return 0;
 
 err_device_add:
+	scoped_guard(pwmchip, chip)
+		chip->operational = false;
+
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_remove(chip);
 
@@ -1165,11 +1225,27 @@ void pwmchip_remove(struct pwm_chip *chip)
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
+				dev_alert(&chip->dev, "Freeing requested PWM #%u\n", i);
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
@@ -1539,12 +1615,17 @@ void pwm_put(struct pwm_device *pwm)
 
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
index f8c2dc12dbd3..5176dfebfbfd 100644
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
+		 * synchronizes calls to the .ops->apply and .ops->get_state()
+		 */
+		struct mutex nonatomic_lock;
+		struct spinlock atomic_lock;
+	};
 	struct pwm_device pwms[] __counted_by(npwm);
 };
 
-- 
2.43.0


