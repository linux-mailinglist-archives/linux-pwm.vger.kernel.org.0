Return-Path: <linux-pwm+bounces-1477-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E585469F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD39B2376A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD09112E7D;
	Wed, 14 Feb 2024 09:54:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C41101E3
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904450; cv=none; b=EUSXOOOsUEvpthbh33HEaFdrEYdGcV0mJ/RbXFl6LlKZipbF76jzMQsd5qmRENDgcr2DEYglsNBXfH70abvgIGELO+iEzZkNMPBPkYPCQxELGuU31NsBEGA75XGxeye6OFMiAcjelqgKPScGdIMm1fej8mTq1wkjMHpRHpfo2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904450; c=relaxed/simple;
	bh=gvGaIoNh07dX2YrQhqH9ersUt34Lq4YpvKfMtJrRrO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mU2umEYl8SaTYDBEf6UvRQQ+TBWRTCXCK5DvOqbs8R0M4bKfgB1d0Ere4PUW+S5OuOuAz3cjEjKMZbAeg+UotCPCh4WbeeLNU2ysTQKzXCp8+sXnal3Hfu0iJmegOUSWg84oIZ9PvZ37nuqRFEVUXYaHSIDrnTveLTlkLfJJeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfB-0006LN-4b; Wed, 14 Feb 2024 10:34:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-000fIx-Qh; Wed, 14 Feb 2024 10:34:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-004YAp-2Q;
	Wed, 14 Feb 2024 10:34:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 163/164] pwm: Ensure the memory backing a PWM chip isn't freed while used
Date: Wed, 14 Feb 2024 10:33:30 +0100
Message-ID:  <d99c1f56e1bf6247348356f3372a5a2d6ac28e97.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9387; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gvGaIoNh07dX2YrQhqH9ersUt34Lq4YpvKfMtJrRrO0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIkFZLkPR++NkkeMkwKlwT47xPEraTiP5OJ/S CwYFzDW7xeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyJBQAKCRCPgPtYfRL+ TiboB/9QC9J4glMo6YLIdduIjIdcO73yLE99OyolxA0p4WV/WT7YmxYbM5rG+88nuplEtNlPXbu 171AFMZJY4FTdfhcxtKahGVvIfd6ONsYSZbRUxoUamUOO0K2ZS6ckdmzmYrtTDamvwIfOvvsMm4 +7alDjJkBsTs4IjhKhQFyRiFON5Vnk3CqyjhYQ1QbhJ9cLCera4IIQZk6W+BiH/0W6xT59/TNW3 A/sOLPAaFu1gUCWQrQiNBjCqPRbevWDsJ5BrficNrRoHxCzWD0c5GGus2Cm/Z9ihes5dkc6fWYZ RU6541vMF+0uBUkwB57x4hu9MIyfYLUWKhkLcFKac9wlu6Gt
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The memory allocated to hold a struct pwm_chip is tied now to the struct
device that is added to struct pwm_chip. This way it's only freed when
the last reference is dropped.

Currently this isn't required yet as device links make sure that a
consumer is gone before the PWM chip goes away. However there are plans
to introduce character device support for PWM chips and with that in
place it can happen that a reference to a pwm_chip is held with its
driver going away.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig  |  4 ----
 drivers/pwm/Makefile |  3 +--
 drivers/pwm/core.c   | 57 +++++++++++++++++++++++++++++++++++---------
 drivers/pwm/sysfs.c  | 45 +++++++---------------------------
 include/linux/pwm.h  | 17 ++++---------
 5 files changed, 59 insertions(+), 67 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..1dd7921194f5 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -29,10 +29,6 @@ menuconfig PWM
 
 if PWM
 
-config PWM_SYSFS
-	bool
-	default y if SYSFS
-
 config PWM_DEBUG
 	bool "PWM lowlevel drivers additional checks and debug messages"
 	depends on DEBUG_KERNEL
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..2aaaf92a7035 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PWM)		+= core.o
-obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
+obj-$(CONFIG_PWM)		+= core.o sysfs.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c8303da06b62..9c9ed51d8600 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -340,13 +340,13 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	if (test_bit(PWMF_REQUESTED, &pwm->flags))
 		return -EBUSY;
 
-	if (!try_module_get(chip->owner))
+	if (!get_device(&chip->dev))
 		return -ENODEV;
 
 	if (ops->request) {
 		err = ops->request(chip, pwm);
 		if (err) {
-			module_put(chip->owner);
+			put_device(&chip->dev);
 			return err;
 		}
 	}
@@ -464,13 +464,21 @@ static void *pwmchip_priv(struct pwm_chip *chip)
 /* This is the counterpart to pwmchip_alloc */
 void pwmchip_put(struct pwm_chip *chip)
 {
-	kfree(chip);
+	put_device(&chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_put);
 
+static void pwmchip_release(struct device *dev)
+{
+	struct pwm_chip *chip = container_of(dev, struct pwm_chip, dev);
+
+	kfree(chip);
+}
+
 struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
 {
 	struct pwm_chip *chip;
+	struct device *dev;
 	size_t alloc_size;
 	unsigned int i;
 
@@ -480,7 +488,13 @@ struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned int npwm, size_t
 	if (!chip)
 		return ERR_PTR(-ENOMEM);
 
-	chip->dev = parent;
+	dev = &chip->dev;
+
+	device_initialize(dev);
+	dev->class = &pwm_class;
+	dev->parent = parent;
+	dev->release = pwmchip_release;
+
 	chip->npwm = npwm;
 	chip->uses_pwmchip_alloc = true;
 
@@ -582,25 +596,42 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 		return -EINVAL;
 
 	chip->owner = owner;
+	if (!try_module_get(owner))
+		return -EINVAL;
 
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
+
+	if (IS_ENABLED(CONFIG_OF))
+		of_pwmchip_remove(chip);
+
+	idr_remove(&pwm_chips, chip->id);
+err_idr_alloc:
+
+	mutex_unlock(&pwm_lock);
+	module_put(owner);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__pwmchip_add);
 
@@ -622,6 +653,10 @@ void pwmchip_remove(struct pwm_chip *chip)
 	idr_remove(&pwm_chips, chip->id);
 
 	mutex_unlock(&pwm_lock);
+
+	module_put(chip->owner);
+
+	device_del(&chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -1006,7 +1041,7 @@ void pwm_put(struct pwm_device *pwm)
 
 	pwm->label = NULL;
 
-	module_put(pwm->chip->owner);
+	put_device(&pwm->chip->dev);
 out:
 	mutex_unlock(&pwm_lock);
 }
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 3f434a771fb5..5fd518772aa1 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -311,7 +311,7 @@ static ssize_t export_store(struct device *parent,
 			    struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 	struct pwm_device *pwm;
 	unsigned int hwpwm;
 	int ret;
@@ -339,7 +339,7 @@ static ssize_t unexport_store(struct device *parent,
 			      struct device_attribute *attr,
 			      const char *buf, size_t len)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 	unsigned int hwpwm;
 	int ret;
 
@@ -359,7 +359,7 @@ static DEVICE_ATTR_WO(unexport);
 static ssize_t npwm_show(struct device *parent, struct device_attribute *attr,
 			 char *buf)
 {
-	const struct pwm_chip *chip = dev_get_drvdata(parent);
+	const struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 
 	return sysfs_emit(buf, "%u\n", chip->npwm);
 }
@@ -411,7 +411,7 @@ static int pwm_class_apply_state(struct pwm_export *export,
 
 static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 	unsigned int i;
 	int ret = 0;
 
@@ -442,7 +442,7 @@ static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 
 static int pwm_class_suspend(struct device *parent)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 	unsigned int i;
 	int ret = 0;
 
@@ -483,59 +483,30 @@ static int pwm_class_suspend(struct device *parent)
 
 static int pwm_class_resume(struct device *parent)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = container_of(parent, struct pwm_chip, dev);
 
 	return pwm_class_resume_npwm(parent, chip->npwm);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_class_resume);
 
-static struct class pwm_class = {
+struct class pwm_class = {
 	.name = "pwm",
 	.dev_groups = pwm_chip_groups,
 	.pm = pm_sleep_ptr(&pwm_class_pm_ops),
 };
 
-static int pwmchip_sysfs_match(struct device *parent, const void *data)
-{
-	return dev_get_drvdata(parent) == data;
-}
-
-void pwmchip_sysfs_export(struct pwm_chip *chip)
-{
-	struct device *parent;
-
-	/*
-	 * If device_create() fails the pwm_chip is still usable by
-	 * the kernel it's just not exported.
-	 */
-	parent = device_create(&pwm_class, pwmchip_parent(chip), MKDEV(0, 0), chip,
-			       "pwmchip%d", chip->id);
-	if (IS_ERR(parent)) {
-		dev_warn(pwmchip_parent(chip),
-			 "device_create failed for pwm_chip sysfs export\n");
-	}
-}
-
 void pwmchip_sysfs_unexport(struct pwm_chip *chip)
 {
-	struct device *parent;
+	struct device *parent = &chip->dev;
 	unsigned int i;
 
-	parent = class_find_device(&pwm_class, NULL, chip,
-				   pwmchip_sysfs_match);
-	if (!parent)
-		return;
-
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (test_bit(PWMF_EXPORTED, &pwm->flags))
 			pwm_unexport_child(parent, pwm);
 	}
-
-	put_device(parent);
-	device_unregister(parent);
 }
 
 static int __init pwm_sysfs_init(void)
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index fbd8f5db938a..8c801085462c 100644
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
@@ -630,17 +631,7 @@ static inline void pwm_remove_table(struct pwm_lookup *table, size_t num)
 }
 #endif
 
-#ifdef CONFIG_PWM_SYSFS
-void pwmchip_sysfs_export(struct pwm_chip *chip);
+extern struct class pwm_class;
 void pwmchip_sysfs_unexport(struct pwm_chip *chip);
-#else
-static inline void pwmchip_sysfs_export(struct pwm_chip *chip)
-{
-}
-
-static inline void pwmchip_sysfs_unexport(struct pwm_chip *chip)
-{
-}
-#endif /* CONFIG_PWM_SYSFS */
 
 #endif /* __LINUX_PWM_H */
-- 
2.43.0


