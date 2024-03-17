Return-Path: <linux-pwm+bounces-1788-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593E187DD00
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 11:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09751F213AC
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D991AACA;
	Sun, 17 Mar 2024 10:41:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F0B17BDC
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710672061; cv=none; b=K9Ww4lPtRixlfv/Ea9YMtYZ2kLEdp4mfY6Lg8qA3a9+OgfYLdgrfTQ6Mx/dXpMn2W8xZx+Zck7XfNTYEgVND5mgqA2wb7L5rwwxQqgkQIeE8cGAwHLTSRHLj4PM7kqDjG34S/Cg+LW8p9kntZkTyPIvYYMbqGOgFNgHwKone3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710672061; c=relaxed/simple;
	bh=SRArxgvCSMBbLBhvIJ8xwHGMsZfXMHqnaORgT2fsEvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+UVBfZ7xEVrB5p10WdzyVM/sW+HqYN1iBFCYqDtgPNxtT5Du2blmdE2xGt4bS1WfY5tEchCBNDL80olPJQRba7asXWmVYIwo5OYsK3OLqa+F2MjPprc1+DyEKnYRCA1k6JWru9kLFOucuxCPiLaAoED1njPreaCWb8vdsLDU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwf-0002Ct-8k; Sun, 17 Mar 2024 11:40:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-006rg6-Si; Sun, 17 Mar 2024 11:40:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-007aDN-2d;
	Sun, 17 Mar 2024 11:40:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH 7/8] pwm: Add more locking
Date: Sun, 17 Mar 2024 11:40:38 +0100
Message-ID:  <e36c1a44096cbd7e9cb693f2300ac12ed1b2f79d.1710670958.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7649; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=SRArxgvCSMBbLBhvIJ8xwHGMsZfXMHqnaORgT2fsEvY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl9sioMde4RK4cw0wiP+pw4SMsWkkTfdjJ+ctSh Xbdr7iV08WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfbIqAAKCRCPgPtYfRL+ Tvf2B/0WAHVyhYTMclWsex1T+ap0b47/ZdmVdDtyfK3c0tBjBYgsLgUsjn5P5VKQYbXawU+Fvrs bSwUD4rWqe3b23Vram9ojVLKC+QbkbZlwXzZi6PxZKGguYlVpZp/gbCrArychAsQDvLTtwFpSaT GL8gHlPbUxB9YErt+ulB8bvUJuZdesz6NjqrEnzLKUtCX/JZHRQzxOk1BbZZaIzFFvwxIl1b57f BtlWt8d8XKBDSSQDFg6yr/Q0/du80fyeI94Ict61BgGzMLHSOvWvrYPSZ70cgpkQiUENOea6IR3 5iO9TA1q2C7oTljPc8WDKeFtJZFWF9AJSjnQFyZ9sULMA3fF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This ensures that a pwm_chip that has no corresponding driver isn't used
and that a driver doesn't go away while a callback is still running.

In the presence of device links this isn't necessary yet (so this is no
fix) but for pwm character device support this is needed.

To not serialize all pwm_apply_state() calls, this introduces a per chip
lock. An additional complication is that for atomic chips a mutex cannot
be used (as pwm_apply_atomic() must not sleem) and a spinlock cannot be
held while calling an operation for a sleeping chip. So depending on the
chip being atomic or not a spinlock or a mutex is used.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 98 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/pwm.h | 13 ++++++
 2 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 09ff6ef0b634..2e08fcfbe138 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -29,6 +29,22 @@ static DEFINE_MUTEX(pwm_lock);
 
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
 static void pwm_apply_debug(struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -183,6 +199,7 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	int err;
+	struct pwm_chip *chip = pwm->chip;
 
 	/*
 	 * Some lowlevel driver's implementations of .apply() make use of
@@ -193,7 +210,13 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 	 */
 	might_sleep();
 
-	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
+	pwmchip_lock(chip);
+	if (!chip->operational) {
+		pwmchip_unlock(chip);
+		return -ENODEV;
+	}
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
 		/*
 		 * Catch any drivers that have been marked as atomic but
 		 * that will sleep anyway.
@@ -205,6 +228,8 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 		err = __pwm_apply(pwm, state);
 	}
 
+	pwmchip_unlock(chip);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
@@ -291,16 +316,26 @@ EXPORT_SYMBOL_GPL(pwm_adjust_config);
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout)
 {
+	struct pwm_chip *chip;
 	int err;
 
-	if (!pwm || !pwm->chip->ops)
+	if (!pwm || !(chip = pwm->chip)->ops)
 		return -EINVAL;
 
-	if (!pwm->chip->ops->capture)
+	if (!chip->ops->capture)
 		return -ENOSYS;
 
 	mutex_lock(&pwm_lock);
-	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
+
+	pwmchip_lock(chip);
+
+	if (chip->operational)
+		err = chip->ops->capture(pwm->chip, pwm, result, timeout);
+	else
+		err = -ENODEV;
+
+	pwmchip_unlock(chip);
+
 	mutex_unlock(&pwm_lock);
 
 	return err;
@@ -340,6 +375,14 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
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
 
@@ -368,7 +411,12 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		 */
 		struct pwm_state state = { 0, };
 
+		pwmchip_lock(chip);
+
 		err = ops->get_state(chip, pwm, &state);
+
+		pwmchip_unlock(chip);
+
 		trace_pwm_get(pwm, &state, err);
 
 		if (!err)
@@ -997,6 +1045,7 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
+	chip->operational = false;
 
 	pwmchip_dev = &chip->dev;
 	device_initialize(pwmchip_dev);
@@ -1102,6 +1151,11 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
+	if (chip->atomic)
+		spin_lock_init(&chip->atomic_lock);
+	else
+		mutex_init(&chip->nonatomic_lock);
+
 	mutex_lock(&pwm_lock);
 
 	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
@@ -1115,6 +1169,10 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
+	pwmchip_lock(chip);
+	chip->operational = true;
+	pwmchip_unlock(chip);
+
 	ret = device_add(&chip->dev);
 	if (ret)
 		goto err_device_add;
@@ -1124,6 +1182,10 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	return 0;
 
 err_device_add:
+	pwmchip_lock(chip);
+	chip->operational = false;
+	pwmchip_unlock(chip);
+
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_remove(chip);
 
@@ -1145,12 +1207,27 @@ EXPORT_SYMBOL_GPL(__pwmchip_add);
 void pwmchip_remove(struct pwm_chip *chip)
 {
 	pwmchip_sysfs_unexport(chip);
+	unsigned int i;
+
+	mutex_lock(&pwm_lock);
+
+	pwmchip_lock(chip);
+	chip->operational = false;
+	pwmchip_unlock(chip);
+
+	for (i = 0; i < chip->npwm; ++i) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
+			dev_alert(&chip->dev, "Freeing requested PWM #%u\n", i);
+			if (pwm->chip->ops->free)
+				pwm->chip->ops->free(pwm->chip, pwm);
+		}
+	}
 
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_remove(chip);
 
-	mutex_lock(&pwm_lock);
-
 	idr_remove(&pwm_chips, chip->id);
 
 	mutex_unlock(&pwm_lock);
@@ -1532,12 +1609,17 @@ void pwm_put(struct pwm_device *pwm)
 
 	mutex_lock(&pwm_lock);
 
-	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
+	/*
+	 * If the chip isn't operational, PWMF_REQUESTED was already cleared. So
+	 * don't warn in this case. This can only happen if a consumer called
+	 * pwm_put() twice.
+	 */
+	if (chip->operational && !test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
 		pr_warn("PWM device already freed\n");
 		goto out;
 	}
 
-	if (chip->ops->free)
+	if (chip->operational && chip->ops->free)
 		pwm->chip->ops->free(pwm->chip, pwm);
 
 	pwm->label = NULL;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 60b92c2c75ef..9c84e0ba81a4 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -274,6 +274,9 @@ struct pwm_ops {
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @atomic: can the driver's ->apply() be called in atomic context
  * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate this chip
+ * @operational: signals if the chip can be used (or is already deregistered)
+ * @nonatomic_lock: mutex for nonatomic chips
+ * @atomic_lock: mutex for atomic chips
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
@@ -289,6 +292,16 @@ struct pwm_chip {
 
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


