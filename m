Return-Path: <linux-pwm+bounces-2801-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5A39312E6
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647331F23B60
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0951F608;
	Mon, 15 Jul 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qdxj4El6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E731891CE
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042208; cv=none; b=f1ZWfSe52hIjJ7r6q0d41zp91azgRPJ+cXv0+jPak0dBiAacLnTiycsn2KoeZ2feotdMnKVrJbWpUShbztDif5NzgvjpgBoC+wP3OSUvmnk+2on9V6eyeFV3fWOYWniAjIkeAyA1lam5S0IiAXqRXAt1JcmW6vNrPPIu+0bJXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042208; c=relaxed/simple;
	bh=bgzS4IPkVSmHMBWHMjNvigVRx9MdUEpSsfvHOCQ+QCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDpfOGzyQHTefO8oNbTk9oaxkh31H2RdkGKj0GNtENfmqFngdSTXf33EFxlSbIMevLyetRXV4WO0/yuxYHPtCu/cZX7CpLBqW3tinRWktIFW3F5qL4QpEhSNsovCAk2ffQQxwVyfd23VlT+eN3gDS2gSeXS/Bxw/tCGAlTIuWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qdxj4El6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266f535e82so27791075e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721042203; x=1721647003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDo3Ku2LLwg04hfqv5GGAQW4ZY8SLokHD9V2gdC04g8=;
        b=Qdxj4El6SPoHpK+wzkvys7lBy6hxhR7h8Z2Wqe69ZfC2+0hhdqwPK5zAMsSaL+1ALE
         iG7L4UH/ukajFZQIowzrVSAAqMV43md7Y9lH7vJiGEtOxsgpa3Fu6sONtwRDggqBhna3
         UW5Gfp/nm3wQ5/meyuHyaYxP5apolUTfxWMJzIZDKRLp+a4daO05Zrp8/fx7FvaYbrx8
         kkvptazOolkoFLYXYSF256XQdv+pRa1IHxADHhBWg77CMSh0HMCOcfOI8gjDD1hWQ7U+
         hruUwRv6EIelpbOAd/TXnzkE0E4jxLka44LKnzQRPdnjOCVCyESKGsJrPk9Pj9mfluDx
         grNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042203; x=1721647003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDo3Ku2LLwg04hfqv5GGAQW4ZY8SLokHD9V2gdC04g8=;
        b=t1oyentFfygAspBfkro+Vqs+t+RA382GxdkBK5OuzT04pSCXbZVW++DKeg5Kq6xDv0
         A8/jwsNsrqyTFSy8ku/CIWOPbtPjgltpB9KhUG3Nle7IdAq9XYcSXgfJ9sQRpb336iuH
         DfMW7TtaDo2yees/MzC5G/n4KiCA09445I9Bn2Tbdm72fLZ2pgShyIbmqUX1RH1XC1+N
         BBaytkCKML1uDaYvd/NmsNq2KeAbY6ECnePDKf9KuG0l83mowv6Uy1HaLthJ/Vd/faef
         t4Kg21eyxi4p8kZwEwjjI4ysJ52GvDuh5NgKNxfHAT/GgL848FkzNafVFjXOF21S1wEJ
         G6Sg==
X-Gm-Message-State: AOJu0Yz09aE+ywKKChLrukKxC84fHwBZLz9ejhlrmIHR5qRZiyanybVu
	Vmcg2y/4SGz/4F5quiBaAJLLAyyycPI4mIK326LIxHqfEkf3Gn2nJfk2Q1DoLj0MHfkyROEH+0P
	R
X-Google-Smtp-Source: AGHT+IGYCn2mnWyEChjk8GadOvbrCy3O4aqQiJ8c6N0bzWOCN2cX7Q2Bv2CdLCmEXcBtYDUAs6UqtQ==
X-Received: by 2002:a05:600c:3b17:b0:427:abed:3602 with SMTP id 5b1f17b1804b1-427abed3735mr24747575e9.24.1721042203247;
        Mon, 15 Jul 2024 04:16:43 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e77488sm83859695e9.9.2024.07.15.04.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:16:42 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 2/8] pwm: Add more locking
Date: Mon, 15 Jul 2024 13:16:07 +0200
Message-ID:  <54ae3f1b9b8f07a84fa1a1c9a5ca2b815cea3b20.1721040875.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7540; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=bgzS4IPkVSmHMBWHMjNvigVRx9MdUEpSsfvHOCQ+QCo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmlQT8gbmAoUe5blzoQb88nkEexTYb+OPDe0eAx 3hkgMmvs2iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZpUE/AAKCRCPgPtYfRL+ TgjMB/9l8ku5TgHA+boHND62/SNKG5nKieAqLsYAyREnNbrlk483gdp8Mwt5Qx+w+z/b+ndUrRi 3Jh4/yfjV/gAhgKdEKTQMFxjk7Xu1iyH5VQgnH4eLWe3f4v/aSsJBugmwaPlHObHrs0xeG39NzR C/QPJ/Rtc8q4dLdAwBCD+2WcZdgJm0gv5nl/DxC62m0pNWn67NykIk7bBSJNnIgCqK29x9pZXoq rAvCzfYoPxTyvN/CuygY3YcjNEqAJc6zygGe2IrRJJk1TjUxFIu2oASBnXzsGsqM7FpB6IpTQCS V+yOI2kJqsE+T2tb1ozUlWlsZsE3igz0K+yqRBi7SKEAuqwi
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
index 6e752e148b98..b97e2ea0691d 100644
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
index 8acd60b53f58..464054a45e57 100644
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


