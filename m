Return-Path: <linux-pwm+bounces-1783-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16787DCFB
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 11:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FBE281646
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922518E1E;
	Sun, 17 Mar 2024 10:40:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955117C6C
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710672058; cv=none; b=qBbKIQtazfPDvQZHrfV5XZFm7HFnUNjZ/Pl4IJBu/VUpYYvdeoh/j3//hpetLKm9ARwZaI+CnP1/N8sXPl1tfWLptgkav5w66GrBXRzVuycXQjEFzxd17Bk0bUnsqDEICCBRb0XXQUxACRtjfomMhhrYvrr3q4/nUYX1ZILmpHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710672058; c=relaxed/simple;
	bh=qbJuAHZyQheRtvP059N2MdmW/hDHxJTXih/8OSBANZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVHz0KlOG+V6Y+wYCOJUoZbBC9mcaWpTAb5aYvMMNYtilT2kE2b8R9VRrCfAYktg6JUegiEPXyqdIs7y167HIThRrL6drwzYOGrhhtoqz1ipKu0/vojsMEFsJE0D5J3HY5b/Etjic2oYU6TlWJzfC498ol9lH0Zdu9HWt7tZVLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-0002AH-MO; Sun, 17 Mar 2024 11:40:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-006rfy-A0; Sun, 17 Mar 2024 11:40:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-007aDF-0k;
	Sun, 17 Mar 2024 11:40:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH 5/8] pwm: Add a struct device to struct pwm_chip
Date: Sun, 17 Mar 2024 11:40:36 +0100
Message-ID:  <35c65ea7f6de789a568ff39d7b6b4ce80de4b7dc.1710670958.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6116; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=qbJuAHZyQheRtvP059N2MdmW/hDHxJTXih/8OSBANZs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl9simH2G9np3xf/QEfi9S3n6vfBzfdNYxJA2ac NLY6DId2B6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfbIpgAKCRCPgPtYfRL+ TnUGCACheKkwqLqi55taJ6JW5Dsiy6hG2HIUEIxmRVo2CO4lhN/KFKOJwmqiLskO8luTOjANYF2 J7Zh+Co/mrrWijLAMQ+l9EGhzPeC4v20IHwvEyNriiSw4gs69IMRNIJCENZeNiKP2hcQL8lYtZn KsOQpLGsExvMr8p6h/FdPrEr7ImCE7H/Ob/D/g/8mg65E6Hj5CUWq5Y1UV9APt9DNDBqOG2Cq0x yeLMgnV5I6hD5m7God/CqlqWFncjZeDAa2mBfh6fwWCVb4pxDZuluCj5TY4H/vsnueszCM0Kp/c JtxMKZNqw7DxJyloYSB/HNUYHz4RpoCupcM0JC8vUMdeaZTQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This replaces the formerly dynamically allocated struct device. This
allows to additionally use it to track the lifetime of the struct
pwm_chip. Otherwise the new struct device provides the same sysfs API as
was provided by the dynamic device before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 93 +++++++++++++++++++++++++--------------------
 include/linux/pwm.h |  5 ++-
 2 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 8ed4c93cd0ce..09ff6ef0b634 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -343,9 +343,16 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	if (!try_module_get(chip->owner))
 		return -ENODEV;
 
+	if (!get_device(&chip->dev)) {
+		err = -ENODEV;
+		goto err_get_device;
+	}
+
 	if (ops->request) {
 		err = ops->request(chip, pwm);
 		if (err) {
+			put_device(&chip->dev);
+err_get_device:
 			module_put(chip->owner);
 			return err;
 		}
@@ -463,7 +470,7 @@ struct pwm_export {
 
 static inline struct pwm_chip *pwmchip_from_dev(struct device *pwmchip_dev)
 {
-	return dev_get_drvdata(pwmchip_dev);
+	return container_of(pwmchip_dev, struct pwm_chip, dev);
 }
 
 static inline struct pwm_export *pwmexport_from_dev(struct device *pwm_dev)
@@ -941,46 +948,16 @@ static struct class pwm_class = {
 	.pm = pm_sleep_ptr(&pwm_class_pm_ops),
 };
 
-static int pwmchip_sysfs_match(struct device *pwmchip_dev, const void *data)
-{
-	return pwmchip_from_dev(pwmchip_dev) == data;
-}
-
-static void pwmchip_sysfs_export(struct pwm_chip *chip)
-{
-	struct device *pwmchip_dev;
-
-	/*
-	 * If device_create() fails the pwm_chip is still usable by
-	 * the kernel it's just not exported.
-	 */
-	pwmchip_dev = device_create(&pwm_class, pwmchip_parent(chip), MKDEV(0, 0), chip,
-			       "pwmchip%d", chip->id);
-	if (IS_ERR(pwmchip_dev)) {
-		dev_warn(pwmchip_parent(chip),
-			 "device_create failed for pwm_chip sysfs export\n");
-	}
-}
-
 static void pwmchip_sysfs_unexport(struct pwm_chip *chip)
 {
-	struct device *pwmchip_dev;
 	unsigned int i;
 
-	pwmchip_dev = class_find_device(&pwm_class, NULL, chip,
-					pwmchip_sysfs_match);
-	if (!pwmchip_dev)
-		return;
-
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (test_bit(PWMF_EXPORTED, &pwm->flags))
-			pwm_unexport_child(pwmchip_dev, pwm);
+			pwm_unexport_child(&chip->dev, pwm);
 	}
-
-	put_device(pwmchip_dev);
-	device_unregister(pwmchip_dev);
 }
 
 #define PWMCHIP_ALIGN ARCH_DMA_MINALIGN
@@ -993,13 +970,21 @@ static void *pwmchip_priv(struct pwm_chip *chip)
 /* This is the counterpart to pwmchip_alloc() */
 void pwmchip_put(struct pwm_chip *chip)
 {
-	kfree(chip);
+	put_device(&chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_put);
 
+static void pwmchip_release(struct device *pwmchip_dev)
+{
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
+
+	kfree(chip);
+}
+
 struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
 {
 	struct pwm_chip *chip;
+	struct device *pwmchip_dev;
 	size_t alloc_size;
 	unsigned int i;
 
@@ -1010,10 +995,15 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 	if (!chip)
 		return ERR_PTR(-ENOMEM);
 
-	chip->dev = parent;
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
 
+	pwmchip_dev = &chip->dev;
+	device_initialize(pwmchip_dev);
+	pwmchip_dev->class = &pwm_class;
+	pwmchip_dev->parent = parent;
+	pwmchip_dev->release = pwmchip_release;
+
 	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
 
 	for (i = 0; i < chip->npwm; i++) {
@@ -1115,21 +1105,34 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	mutex_lock(&pwm_lock);
 
 	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
-	if (ret < 0) {
-		mutex_unlock(&pwm_lock);
-		return ret;
-	}
+	if (ret < 0)
+		goto err_idr_alloc;
 
 	chip->id = ret;
 
-	mutex_unlock(&pwm_lock);
+	dev_set_name(&chip->dev, "pwmchip%u", chip->id);
 
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
-	pwmchip_sysfs_export(chip);
+	ret = device_add(&chip->dev);
+	if (ret)
+		goto err_device_add;
+
+	mutex_unlock(&pwm_lock);
 
 	return 0;
+
+err_device_add:
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_remove(chip);
+
+	idr_remove(&pwm_chips, chip->id);
+err_idr_alloc:
+
+	mutex_unlock(&pwm_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__pwmchip_add);
 
@@ -1151,6 +1154,8 @@ void pwmchip_remove(struct pwm_chip *chip)
 	idr_remove(&pwm_chips, chip->id);
 
 	mutex_unlock(&pwm_lock);
+
+	device_del(&chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -1520,6 +1525,8 @@ EXPORT_SYMBOL_GPL(pwm_get);
  */
 void pwm_put(struct pwm_device *pwm)
 {
+	struct pwm_chip *chip = pwm->chip;
+
 	if (!pwm)
 		return;
 
@@ -1530,12 +1537,14 @@ void pwm_put(struct pwm_device *pwm)
 		goto out;
 	}
 
-	if (pwm->chip->ops->free)
+	if (chip->ops->free)
 		pwm->chip->ops->free(pwm->chip, pwm);
 
 	pwm->label = NULL;
 
-	module_put(pwm->chip->owner);
+	put_device(&chip->dev);
+
+	module_put(chip->owner);
 out:
 	mutex_unlock(&pwm_lock);
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 78b9061572ff..495e23761f34 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -277,7 +278,7 @@ struct pwm_ops {
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
-	struct device *dev;
+	struct device dev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	unsigned int id;
@@ -295,7 +296,7 @@ struct pwm_chip {
 
 static inline struct device *pwmchip_parent(const struct pwm_chip *chip)
 {
-	return chip->dev;
+	return chip->dev.parent;
 }
 
 static inline void *pwmchip_get_drvdata(struct pwm_chip *chip)
-- 
2.43.0


