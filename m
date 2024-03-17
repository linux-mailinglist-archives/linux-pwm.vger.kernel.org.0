Return-Path: <linux-pwm+bounces-1787-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD287DCFF
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 11:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596501F211F7
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158E1AAC4;
	Sun, 17 Mar 2024 10:41:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4071175BE
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710672060; cv=none; b=Fb++RchK0FCzLFuZ01Mc+k1la7OUHse9GoZjrt5jAgKl/WZFaN1f5fc37Snaa/Np65PFiBtHVThvNlDgKjUSWNfIbDNIE/jpG/AvCFv7nPXhf5Zaf8KE0j+fKTPY6EwEleF5knA+SHJk/CT2FbZUDE0TEfmpDFvwgF8E9IXS+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710672060; c=relaxed/simple;
	bh=Y7cFDWk+83LiHRNcXArwFOV/LWX1CTxKF95qpPlkxPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5Bxw4/gO72BVbwvI/X+aBw+PVvIpFKjhSgkwaVs1hZl9RVNF6HVYAfsEz9q1c8Bq8XRgn0ckYgMUy0w0YoEsK9RsYcz9Wyhpmu1DH0sNbxvTOoaWtdl7NJlH+gDt3o7/x/U0xqln7xsIXS+uXSp8kg0gfqFMRz8p41iOX0gXdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-00029u-4L; Sun, 17 Mar 2024 11:40:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwd-006rfq-OI; Sun, 17 Mar 2024 11:40:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwd-007aD7-2B;
	Sun, 17 Mar 2024 11:40:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH 3/8] pwm: Move contents of sysfs.c into core.c
Date: Sun, 17 Mar 2024 11:40:34 +0100
Message-ID:  <9e2d39a5280d7dda5bfc6682a8aef510148635b2.1710670958.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=30435; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Y7cFDWk+83LiHRNcXArwFOV/LWX1CTxKF95qpPlkxPw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl9sikFu4J30Atn53mfJ/nfHOxHu63skirkXl7i A3oW9Y7cQWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfbIpAAKCRCPgPtYfRL+ TvZzCACC/OKhxsvtoGZL6qqJuA8LgGsaSCQdB9lpAKKobntUlXSyX9IXhfmcTk8vni6Bh7qAhiq s7cKlxJNedHbqjzt4qCzA/CLDZtyLPZMZBYSGoEVRHP/RjlI8LRxrP8bIPoWkvNaslOjJ+gMXu/ 8WMv9G6Yw711HPpseSK07/wCuIwonIQ9LfdfaFSxqbSDuMIsZ8Fh18uo9w+ZvWkwxnTsQNW43jU rqHVZkDczhWtZh2DxVZUn0R5BpPph/l1IKZ8X+XEpK4z3UFBCFVHjZn0+2sAoJVigVVWk+YMR2B EQvgBuAApSNebN3reYjtWPfbxqZW0+fKfJav4q7n5OxwXEb3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

With the upcoming restructuring having all in a single file simplifies
things a bit. The relevant and somewhat visible changes are:

 - Some dropped prototypes from include/linux/pwm.h that were only
   necessary that core.c has a declaration of the symbols defined in
   sysfs.c. The respective functions are static now.

 - The pwm class now also exists if CONFIG_SYSFS isn't enabled. Having
   CONFIG_SYSFS is not very relevant today, but even without it the
   class and device stuff still provides lifetime tracking.

 - Both files had an initcall, these are merged into a single one now.
   Instead of a big #ifdef block for CONFIG_DEBUG_FS, a single
   if (IS_ENABLED(CONFIG_DEBUG_FS)) is used now. This increases compile
   coverage a bit and is a tad nicer on the eyes.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig  |   4 -
 drivers/pwm/Makefile |   1 -
 drivers/pwm/core.c   | 540 +++++++++++++++++++++++++++++++++++++++++-
 drivers/pwm/sysfs.c  | 550 -------------------------------------------
 include/linux/pwm.h  |  13 -
 5 files changed, 534 insertions(+), 574 deletions(-)
 delete mode 100644 drivers/pwm/sysfs.c

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
index c5ec9e168ee7..90913519f11a 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PWM)		+= core.o
-obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index fe83333c466a..69af8123455a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -454,6 +454,535 @@ of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
 }
 EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
 
+struct pwm_export {
+	struct device pwm_dev;
+	struct pwm_device *pwm;
+	struct mutex lock;
+	struct pwm_state suspend;
+};
+
+static inline struct pwm_chip *pwmchip_from_dev(struct device *pwmchip_dev)
+{
+	return dev_get_drvdata(pwmchip_dev);
+}
+
+static inline struct pwm_export *pwmexport_from_dev(struct device *pwm_dev)
+{
+	return container_of(pwm_dev, struct pwm_export, pwm_dev);
+}
+
+static inline struct pwm_device *pwm_from_dev(struct device *pwm_dev)
+{
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
+
+	return export->pwm;
+}
+
+static ssize_t period_show(struct device *pwm_dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return sysfs_emit(buf, "%llu\n", state.period);
+}
+
+static ssize_t period_store(struct device *pwm_dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t size)
+{
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.period = val;
+	ret = pwm_apply_might_sleep(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
+static ssize_t duty_cycle_show(struct device *pwm_dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return sysfs_emit(buf, "%llu\n", state.duty_cycle);
+}
+
+static ssize_t duty_cycle_store(struct device *pwm_dev,
+				struct device_attribute *attr,
+				const char *buf, size_t size)
+{
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.duty_cycle = val;
+	ret = pwm_apply_might_sleep(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
+static ssize_t enable_show(struct device *pwm_dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return sysfs_emit(buf, "%d\n", state.enabled);
+}
+
+static ssize_t enable_store(struct device *pwm_dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t size)
+{
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&export->lock);
+
+	pwm_get_state(pwm, &state);
+
+	switch (val) {
+	case 0:
+		state.enabled = false;
+		break;
+	case 1:
+		state.enabled = true;
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = pwm_apply_might_sleep(pwm, &state);
+
+unlock:
+	mutex_unlock(&export->lock);
+	return ret ? : size;
+}
+
+static ssize_t polarity_show(struct device *pwm_dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
+	const char *polarity = "unknown";
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	switch (state.polarity) {
+	case PWM_POLARITY_NORMAL:
+		polarity = "normal";
+		break;
+
+	case PWM_POLARITY_INVERSED:
+		polarity = "inversed";
+		break;
+	}
+
+	return sysfs_emit(buf, "%s\n", polarity);
+}
+
+static ssize_t polarity_store(struct device *pwm_dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
+	struct pwm_device *pwm = export->pwm;
+	enum pwm_polarity polarity;
+	struct pwm_state state;
+	int ret;
+
+	if (sysfs_streq(buf, "normal"))
+		polarity = PWM_POLARITY_NORMAL;
+	else if (sysfs_streq(buf, "inversed"))
+		polarity = PWM_POLARITY_INVERSED;
+	else
+		return -EINVAL;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	state.polarity = polarity;
+	ret = pwm_apply_might_sleep(pwm, &state);
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
+static ssize_t capture_show(struct device *pwm_dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct pwm_device *pwm = pwm_from_dev(pwm_dev);
+	struct pwm_capture result;
+	int ret;
+
+	ret = pwm_capture(pwm, &result, jiffies_to_msecs(HZ));
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u %u\n", result.period, result.duty_cycle);
+}
+
+static DEVICE_ATTR_RW(period);
+static DEVICE_ATTR_RW(duty_cycle);
+static DEVICE_ATTR_RW(enable);
+static DEVICE_ATTR_RW(polarity);
+static DEVICE_ATTR_RO(capture);
+
+static struct attribute *pwm_attrs[] = {
+	&dev_attr_period.attr,
+	&dev_attr_duty_cycle.attr,
+	&dev_attr_enable.attr,
+	&dev_attr_polarity.attr,
+	&dev_attr_capture.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(pwm);
+
+static void pwm_export_release(struct device *pwm_dev)
+{
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
+
+	kfree(export);
+}
+
+static int pwm_export_child(struct device *pwmchip_dev, struct pwm_device *pwm)
+{
+	struct pwm_export *export;
+	char *pwm_prop[2];
+	int ret;
+
+	if (test_and_set_bit(PWMF_EXPORTED, &pwm->flags))
+		return -EBUSY;
+
+	export = kzalloc(sizeof(*export), GFP_KERNEL);
+	if (!export) {
+		clear_bit(PWMF_EXPORTED, &pwm->flags);
+		return -ENOMEM;
+	}
+
+	export->pwm = pwm;
+	mutex_init(&export->lock);
+
+	export->pwm_dev.release = pwm_export_release;
+	export->pwm_dev.parent = pwmchip_dev;
+	export->pwm_dev.devt = MKDEV(0, 0);
+	export->pwm_dev.groups = pwm_groups;
+	dev_set_name(&export->pwm_dev, "pwm%u", pwm->hwpwm);
+
+	ret = device_register(&export->pwm_dev);
+	if (ret) {
+		clear_bit(PWMF_EXPORTED, &pwm->flags);
+		put_device(&export->pwm_dev);
+		export = NULL;
+		return ret;
+	}
+	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=pwm%u", pwm->hwpwm);
+	pwm_prop[1] = NULL;
+	kobject_uevent_env(&pwmchip_dev->kobj, KOBJ_CHANGE, pwm_prop);
+	kfree(pwm_prop[0]);
+
+	return 0;
+}
+
+static int pwm_unexport_match(struct device *pwm_dev, void *data)
+{
+	return pwm_from_dev(pwm_dev) == data;
+}
+
+static int pwm_unexport_child(struct device *pwmchip_dev, struct pwm_device *pwm)
+{
+	struct device *pwm_dev;
+	char *pwm_prop[2];
+
+	if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
+		return -ENODEV;
+
+	pwm_dev = device_find_child(pwmchip_dev, pwm, pwm_unexport_match);
+	if (!pwm_dev)
+		return -ENODEV;
+
+	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=pwm%u", pwm->hwpwm);
+	pwm_prop[1] = NULL;
+	kobject_uevent_env(&pwmchip_dev->kobj, KOBJ_CHANGE, pwm_prop);
+	kfree(pwm_prop[0]);
+
+	/* for device_find_child() */
+	put_device(pwm_dev);
+	device_unregister(pwm_dev);
+	pwm_put(pwm);
+
+	return 0;
+}
+
+static ssize_t export_store(struct device *pwmchip_dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t len)
+{
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
+	struct pwm_device *pwm;
+	unsigned int hwpwm;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &hwpwm);
+	if (ret < 0)
+		return ret;
+
+	if (hwpwm >= chip->npwm)
+		return -ENODEV;
+
+	pwm = pwm_request_from_chip(chip, hwpwm, "sysfs");
+	if (IS_ERR(pwm))
+		return PTR_ERR(pwm);
+
+	ret = pwm_export_child(pwmchip_dev, pwm);
+	if (ret < 0)
+		pwm_put(pwm);
+
+	return ret ? : len;
+}
+static DEVICE_ATTR_WO(export);
+
+static ssize_t unexport_store(struct device *pwmchip_dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t len)
+{
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
+	unsigned int hwpwm;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &hwpwm);
+	if (ret < 0)
+		return ret;
+
+	if (hwpwm >= chip->npwm)
+		return -ENODEV;
+
+	ret = pwm_unexport_child(pwmchip_dev, &chip->pwms[hwpwm]);
+
+	return ret ? : len;
+}
+static DEVICE_ATTR_WO(unexport);
+
+static ssize_t npwm_show(struct device *pwmchip_dev, struct device_attribute *attr,
+			 char *buf)
+{
+	const struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
+
+	return sysfs_emit(buf, "%u\n", chip->npwm);
+}
+static DEVICE_ATTR_RO(npwm);
+
+static struct attribute *pwm_chip_attrs[] = {
+	&dev_attr_export.attr,
+	&dev_attr_unexport.attr,
+	&dev_attr_npwm.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(pwm_chip);
+
+/* takes export->lock on success */
+static struct pwm_export *pwm_class_get_state(struct device *pwmchip_dev,
+					      struct pwm_device *pwm,
+					      struct pwm_state *state)
+{
+	struct device *pwm_dev;
+	struct pwm_export *export;
+
+	if (!test_bit(PWMF_EXPORTED, &pwm->flags))
+		return NULL;
+
+	pwm_dev = device_find_child(pwmchip_dev, pwm, pwm_unexport_match);
+	if (!pwm_dev)
+		return NULL;
+
+	export = pwmexport_from_dev(pwm_dev);
+	put_device(pwm_dev);	/* for device_find_child() */
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, state);
+
+	return export;
+}
+
+static int pwm_class_apply_state(struct pwm_export *export,
+				 struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	int ret = pwm_apply_might_sleep(pwm, state);
+
+	/* release lock taken in pwm_class_get_state */
+	mutex_unlock(&export->lock);
+
+	return ret;
+}
+
+static int pwm_class_resume_npwm(struct device *pwmchip_dev, unsigned int npwm)
+{
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+		struct pwm_state state;
+		struct pwm_export *export;
+
+		export = pwm_class_get_state(pwmchip_dev, pwm, &state);
+		if (!export)
+			continue;
+
+		/* If pwmchip was not enabled before suspend, do nothing. */
+		if (!export->suspend.enabled) {
+			/* release lock taken in pwm_class_get_state */
+			mutex_unlock(&export->lock);
+			continue;
+		}
+
+		state.enabled = export->suspend.enabled;
+		ret = pwm_class_apply_state(export, pwm, &state);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+
+static int pwm_class_suspend(struct device *pwmchip_dev)
+{
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+		struct pwm_state state;
+		struct pwm_export *export;
+
+		export = pwm_class_get_state(pwmchip_dev, pwm, &state);
+		if (!export)
+			continue;
+
+		/*
+		 * If pwmchip was not enabled before suspend, save
+		 * state for resume time and do nothing else.
+		 */
+		export->suspend = state;
+		if (!state.enabled) {
+			/* release lock taken in pwm_class_get_state */
+			mutex_unlock(&export->lock);
+			continue;
+		}
+
+		state.enabled = false;
+		ret = pwm_class_apply_state(export, pwm, &state);
+		if (ret < 0) {
+			/*
+			 * roll back the PWM devices that were disabled by
+			 * this suspend function.
+			 */
+			pwm_class_resume_npwm(pwmchip_dev, i);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int pwm_class_resume(struct device *pwmchip_dev)
+{
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
+
+	return pwm_class_resume_npwm(pwmchip_dev, chip->npwm);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_class_resume);
+
+static struct class pwm_class = {
+	.name = "pwm",
+	.dev_groups = pwm_chip_groups,
+	.pm = pm_sleep_ptr(&pwm_class_pm_ops),
+};
+
+static int pwmchip_sysfs_match(struct device *pwmchip_dev, const void *data)
+{
+	return pwmchip_from_dev(pwmchip_dev) == data;
+}
+
+static void pwmchip_sysfs_export(struct pwm_chip *chip)
+{
+	struct device *pwmchip_dev;
+
+	/*
+	 * If device_create() fails the pwm_chip is still usable by
+	 * the kernel it's just not exported.
+	 */
+	pwmchip_dev = device_create(&pwm_class, pwmchip_parent(chip), MKDEV(0, 0), chip,
+			       "pwmchip%d", chip->id);
+	if (IS_ERR(pwmchip_dev)) {
+		dev_warn(pwmchip_parent(chip),
+			 "device_create failed for pwm_chip sysfs export\n");
+	}
+}
+
+static void pwmchip_sysfs_unexport(struct pwm_chip *chip)
+{
+	struct device *pwmchip_dev;
+	unsigned int i;
+
+	pwmchip_dev = class_find_device(&pwm_class, NULL, chip,
+					pwmchip_sysfs_match);
+	if (!pwmchip_dev)
+		return;
+
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		if (test_bit(PWMF_EXPORTED, &pwm->flags))
+			pwm_unexport_child(pwmchip_dev, pwm);
+	}
+
+	put_device(pwmchip_dev);
+	device_unregister(pwmchip_dev);
+}
+
 #define PWMCHIP_ALIGN ARCH_DMA_MINALIGN
 
 static void *pwmchip_priv(struct pwm_chip *chip)
@@ -1086,7 +1615,6 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_fwnode_pwm_get);
 
-#ifdef CONFIG_DEBUG_FS
 static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 {
 	unsigned int i;
@@ -1171,11 +1699,11 @@ static const struct seq_operations pwm_debugfs_sops = {
 
 DEFINE_SEQ_ATTRIBUTE(pwm_debugfs);
 
-static int __init pwm_debugfs_init(void)
+static int __init pwm_init(void)
 {
-	debugfs_create_file("pwm", 0444, NULL, NULL, &pwm_debugfs_fops);
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		debugfs_create_file("pwm", 0444, NULL, NULL, &pwm_debugfs_fops);
 
-	return 0;
+	return class_register(&pwm_class);
 }
-subsys_initcall(pwm_debugfs_init);
-#endif /* CONFIG_DEBUG_FS */
+subsys_initcall(pwm_init);
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
deleted file mode 100644
index 1a1b1f6dd98f..000000000000
--- a/drivers/pwm/sysfs.c
+++ /dev/null
@@ -1,550 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * A simple sysfs interface for the generic PWM framework
- *
- * Copyright (C) 2013 H Hartley Sweeten <hsweeten@visionengravers.com>
- *
- * Based on previous work by Lars Poeschel <poeschel@lemonage.de>
- */
-
-#include <linux/device.h>
-#include <linux/mutex.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/kdev_t.h>
-#include <linux/pwm.h>
-
-struct pwm_export {
-	struct device pwm_dev;
-	struct pwm_device *pwm;
-	struct mutex lock;
-	struct pwm_state suspend;
-};
-
-static inline struct pwm_chip *pwmchip_from_dev(struct device *pwmchip_dev)
-{
-	return dev_get_drvdata(pwmchip_dev);
-}
-
-static inline struct pwm_export *pwmexport_from_dev(struct device *pwm_dev)
-{
-	return container_of(pwm_dev, struct pwm_export, pwm_dev);
-}
-
-static inline struct pwm_device *pwm_from_dev(struct device *pwm_dev)
-{
-	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
-
-	return export->pwm;
-}
-
-static ssize_t period_show(struct device *pwm_dev,
-			   struct device_attribute *attr,
-			   char *buf)
-{
-	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
-	struct pwm_state state;
-
-	pwm_get_state(pwm, &state);
-
-	return sysfs_emit(buf, "%llu\n", state.period);
-}
-
-static ssize_t period_store(struct device *pwm_dev,
-			    struct device_attribute *attr,
-			    const char *buf, size_t size)
-{
-	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
-	struct pwm_device *pwm = export->pwm;
-	struct pwm_state state;
-	u64 val;
-	int ret;
-
-	ret = kstrtou64(buf, 0, &val);
-	if (ret)
-		return ret;
-
-	mutex_lock(&export->lock);
-	pwm_get_state(pwm, &state);
-	state.period = val;
-	ret = pwm_apply_might_sleep(pwm, &state);
-	mutex_unlock(&export->lock);
-
-	return ret ? : size;
-}
-
-static ssize_t duty_cycle_show(struct device *pwm_dev,
-			       struct device_attribute *attr,
-			       char *buf)
-{
-	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
-	struct pwm_state state;
-
-	pwm_get_state(pwm, &state);
-
-	return sysfs_emit(buf, "%llu\n", state.duty_cycle);
-}
-
-static ssize_t duty_cycle_store(struct device *pwm_dev,
-				struct device_attribute *attr,
-				const char *buf, size_t size)
-{
-	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
-	struct pwm_device *pwm = export->pwm;
-	struct pwm_state state;
-	u64 val;
-	int ret;
-
-	ret = kstrtou64(buf, 0, &val);
-	if (ret)
-		return ret;
-
-	mutex_lock(&export->lock);
-	pwm_get_state(pwm, &state);
-	state.duty_cycle = val;
-	ret = pwm_apply_might_sleep(pwm, &state);
-	mutex_unlock(&export->lock);
-
-	return ret ? : size;
-}
-
-static ssize_t enable_show(struct device *pwm_dev,
-			   struct device_attribute *attr,
-			   char *buf)
-{
-	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
-	struct pwm_state state;
-
-	pwm_get_state(pwm, &state);
-
-	return sysfs_emit(buf, "%d\n", state.enabled);
-}
-
-static ssize_t enable_store(struct device *pwm_dev,
-			    struct device_attribute *attr,
-			    const char *buf, size_t size)
-{
-	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
-	struct pwm_device *pwm = export->pwm;
-	struct pwm_state state;
-	int val, ret;
-
-	ret = kstrtoint(buf, 0, &val);
-	if (ret)
-		return ret;
-
-	mutex_lock(&export->lock);
-
-	pwm_get_state(pwm, &state);
-
-	switch (val) {
-	case 0:
-		state.enabled = false;
-		break;
-	case 1:
-		state.enabled = true;
-		break;
-	default:
-		ret = -EINVAL;
-		goto unlock;
-	}
-
-	ret = pwm_apply_might_sleep(pwm, &state);
-
-unlock:
-	mutex_unlock(&export->lock);
-	return ret ? : size;
-}
-
-static ssize_t polarity_show(struct device *pwm_dev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
-	const char *polarity = "unknown";
-	struct pwm_state state;
-
-	pwm_get_state(pwm, &state);
-
-	switch (state.polarity) {
-	case PWM_POLARITY_NORMAL:
-		polarity = "normal";
-		break;
-
-	case PWM_POLARITY_INVERSED:
-		polarity = "inversed";
-		break;
-	}
-
-	return sysfs_emit(buf, "%s\n", polarity);
-}
-
-static ssize_t polarity_store(struct device *pwm_dev,
-			      struct device_attribute *attr,
-			      const char *buf, size_t size)
-{
-	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
-	struct pwm_device *pwm = export->pwm;
-	enum pwm_polarity polarity;
-	struct pwm_state state;
-	int ret;
-
-	if (sysfs_streq(buf, "normal"))
-		polarity = PWM_POLARITY_NORMAL;
-	else if (sysfs_streq(buf, "inversed"))
-		polarity = PWM_POLARITY_INVERSED;
-	else
-		return -EINVAL;
-
-	mutex_lock(&export->lock);
-	pwm_get_state(pwm, &state);
-	state.polarity = polarity;
-	ret = pwm_apply_might_sleep(pwm, &state);
-	mutex_unlock(&export->lock);
-
-	return ret ? : size;
-}
-
-static ssize_t capture_show(struct device *pwm_dev,
-			    struct device_attribute *attr,
-			    char *buf)
-{
-	struct pwm_device *pwm = pwm_from_dev(pwm_dev);
-	struct pwm_capture result;
-	int ret;
-
-	ret = pwm_capture(pwm, &result, jiffies_to_msecs(HZ));
-	if (ret)
-		return ret;
-
-	return sysfs_emit(buf, "%u %u\n", result.period, result.duty_cycle);
-}
-
-static DEVICE_ATTR_RW(period);
-static DEVICE_ATTR_RW(duty_cycle);
-static DEVICE_ATTR_RW(enable);
-static DEVICE_ATTR_RW(polarity);
-static DEVICE_ATTR_RO(capture);
-
-static struct attribute *pwm_attrs[] = {
-	&dev_attr_period.attr,
-	&dev_attr_duty_cycle.attr,
-	&dev_attr_enable.attr,
-	&dev_attr_polarity.attr,
-	&dev_attr_capture.attr,
-	NULL
-};
-ATTRIBUTE_GROUPS(pwm);
-
-static void pwm_export_release(struct device *pwm_dev)
-{
-	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
-
-	kfree(export);
-}
-
-static int pwm_export_child(struct device *pwmchip_dev, struct pwm_device *pwm)
-{
-	struct pwm_export *export;
-	char *pwm_prop[2];
-	int ret;
-
-	if (test_and_set_bit(PWMF_EXPORTED, &pwm->flags))
-		return -EBUSY;
-
-	export = kzalloc(sizeof(*export), GFP_KERNEL);
-	if (!export) {
-		clear_bit(PWMF_EXPORTED, &pwm->flags);
-		return -ENOMEM;
-	}
-
-	export->pwm = pwm;
-	mutex_init(&export->lock);
-
-	export->pwm_dev.release = pwm_export_release;
-	export->pwm_dev.parent = pwmchip_dev;
-	export->pwm_dev.devt = MKDEV(0, 0);
-	export->pwm_dev.groups = pwm_groups;
-	dev_set_name(&export->pwm_dev, "pwm%u", pwm->hwpwm);
-
-	ret = device_register(&export->pwm_dev);
-	if (ret) {
-		clear_bit(PWMF_EXPORTED, &pwm->flags);
-		put_device(&export->pwm_dev);
-		export = NULL;
-		return ret;
-	}
-	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=pwm%u", pwm->hwpwm);
-	pwm_prop[1] = NULL;
-	kobject_uevent_env(&pwmchip_dev->kobj, KOBJ_CHANGE, pwm_prop);
-	kfree(pwm_prop[0]);
-
-	return 0;
-}
-
-static int pwm_unexport_match(struct device *pwm_dev, void *data)
-{
-	return pwm_from_dev(pwm_dev) == data;
-}
-
-static int pwm_unexport_child(struct device *pwmchip_dev, struct pwm_device *pwm)
-{
-	struct device *pwm_dev;
-	char *pwm_prop[2];
-
-	if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
-		return -ENODEV;
-
-	pwm_dev = device_find_child(pwmchip_dev, pwm, pwm_unexport_match);
-	if (!pwm_dev)
-		return -ENODEV;
-
-	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=pwm%u", pwm->hwpwm);
-	pwm_prop[1] = NULL;
-	kobject_uevent_env(&pwmchip_dev->kobj, KOBJ_CHANGE, pwm_prop);
-	kfree(pwm_prop[0]);
-
-	/* for device_find_child() */
-	put_device(pwm_dev);
-	device_unregister(pwm_dev);
-	pwm_put(pwm);
-
-	return 0;
-}
-
-static ssize_t export_store(struct device *pwmchip_dev,
-			    struct device_attribute *attr,
-			    const char *buf, size_t len)
-{
-	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
-	struct pwm_device *pwm;
-	unsigned int hwpwm;
-	int ret;
-
-	ret = kstrtouint(buf, 0, &hwpwm);
-	if (ret < 0)
-		return ret;
-
-	if (hwpwm >= chip->npwm)
-		return -ENODEV;
-
-	pwm = pwm_request_from_chip(chip, hwpwm, "sysfs");
-	if (IS_ERR(pwm))
-		return PTR_ERR(pwm);
-
-	ret = pwm_export_child(pwmchip_dev, pwm);
-	if (ret < 0)
-		pwm_put(pwm);
-
-	return ret ? : len;
-}
-static DEVICE_ATTR_WO(export);
-
-static ssize_t unexport_store(struct device *pwmchip_dev,
-			      struct device_attribute *attr,
-			      const char *buf, size_t len)
-{
-	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
-	unsigned int hwpwm;
-	int ret;
-
-	ret = kstrtouint(buf, 0, &hwpwm);
-	if (ret < 0)
-		return ret;
-
-	if (hwpwm >= chip->npwm)
-		return -ENODEV;
-
-	ret = pwm_unexport_child(pwmchip_dev, &chip->pwms[hwpwm]);
-
-	return ret ? : len;
-}
-static DEVICE_ATTR_WO(unexport);
-
-static ssize_t npwm_show(struct device *pwmchip_dev, struct device_attribute *attr,
-			 char *buf)
-{
-	const struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
-
-	return sysfs_emit(buf, "%u\n", chip->npwm);
-}
-static DEVICE_ATTR_RO(npwm);
-
-static struct attribute *pwm_chip_attrs[] = {
-	&dev_attr_export.attr,
-	&dev_attr_unexport.attr,
-	&dev_attr_npwm.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(pwm_chip);
-
-/* takes export->lock on success */
-static struct pwm_export *pwm_class_get_state(struct device *pwmchip_dev,
-					      struct pwm_device *pwm,
-					      struct pwm_state *state)
-{
-	struct device *pwm_dev;
-	struct pwm_export *export;
-
-	if (!test_bit(PWMF_EXPORTED, &pwm->flags))
-		return NULL;
-
-	pwm_dev = device_find_child(pwmchip_dev, pwm, pwm_unexport_match);
-	if (!pwm_dev)
-		return NULL;
-
-	export = pwmexport_from_dev(pwm_dev);
-	put_device(pwm_dev);	/* for device_find_child() */
-
-	mutex_lock(&export->lock);
-	pwm_get_state(pwm, state);
-
-	return export;
-}
-
-static int pwm_class_apply_state(struct pwm_export *export,
-				 struct pwm_device *pwm,
-				 struct pwm_state *state)
-{
-	int ret = pwm_apply_might_sleep(pwm, state);
-
-	/* release lock taken in pwm_class_get_state */
-	mutex_unlock(&export->lock);
-
-	return ret;
-}
-
-static int pwm_class_resume_npwm(struct device *pwmchip_dev, unsigned int npwm)
-{
-	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
-	unsigned int i;
-	int ret = 0;
-
-	for (i = 0; i < npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
-		struct pwm_state state;
-		struct pwm_export *export;
-
-		export = pwm_class_get_state(pwmchip_dev, pwm, &state);
-		if (!export)
-			continue;
-
-		/* If pwmchip was not enabled before suspend, do nothing. */
-		if (!export->suspend.enabled) {
-			/* release lock taken in pwm_class_get_state */
-			mutex_unlock(&export->lock);
-			continue;
-		}
-
-		state.enabled = export->suspend.enabled;
-		ret = pwm_class_apply_state(export, pwm, &state);
-		if (ret < 0)
-			break;
-	}
-
-	return ret;
-}
-
-static int pwm_class_suspend(struct device *pwmchip_dev)
-{
-	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
-	unsigned int i;
-	int ret = 0;
-
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
-		struct pwm_state state;
-		struct pwm_export *export;
-
-		export = pwm_class_get_state(pwmchip_dev, pwm, &state);
-		if (!export)
-			continue;
-
-		/*
-		 * If pwmchip was not enabled before suspend, save
-		 * state for resume time and do nothing else.
-		 */
-		export->suspend = state;
-		if (!state.enabled) {
-			/* release lock taken in pwm_class_get_state */
-			mutex_unlock(&export->lock);
-			continue;
-		}
-
-		state.enabled = false;
-		ret = pwm_class_apply_state(export, pwm, &state);
-		if (ret < 0) {
-			/*
-			 * roll back the PWM devices that were disabled by
-			 * this suspend function.
-			 */
-			pwm_class_resume_npwm(pwmchip_dev, i);
-			break;
-		}
-	}
-
-	return ret;
-}
-
-static int pwm_class_resume(struct device *pwmchip_dev)
-{
-	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
-
-	return pwm_class_resume_npwm(pwmchip_dev, chip->npwm);
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_class_resume);
-
-static struct class pwm_class = {
-	.name = "pwm",
-	.dev_groups = pwm_chip_groups,
-	.pm = pm_sleep_ptr(&pwm_class_pm_ops),
-};
-
-static int pwmchip_sysfs_match(struct device *pwmchip_dev, const void *data)
-{
-	return pwmchip_from_dev(pwmchip_dev) == data;
-}
-
-void pwmchip_sysfs_export(struct pwm_chip *chip)
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
-void pwmchip_sysfs_unexport(struct pwm_chip *chip)
-{
-	struct device *pwmchip_dev;
-	unsigned int i;
-
-	pwmchip_dev = class_find_device(&pwm_class, NULL, chip,
-				   pwmchip_sysfs_match);
-	if (!pwmchip_dev)
-		return;
-
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
-
-		if (test_bit(PWMF_EXPORTED, &pwm->flags))
-			pwm_unexport_child(pwmchip_dev, pwm);
-	}
-
-	put_device(pwmchip_dev);
-	device_unregister(pwmchip_dev);
-}
-
-static int __init pwm_sysfs_init(void)
-{
-	return class_register(&pwm_class);
-}
-subsys_initcall(pwm_sysfs_init);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 94a642a88817..17e45d8413ed 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -630,17 +630,4 @@ static inline void pwm_remove_table(struct pwm_lookup *table, size_t num)
 }
 #endif
 
-#ifdef CONFIG_PWM_SYSFS
-void pwmchip_sysfs_export(struct pwm_chip *chip);
-void pwmchip_sysfs_unexport(struct pwm_chip *chip);
-#else
-static inline void pwmchip_sysfs_export(struct pwm_chip *chip)
-{
-}
-
-static inline void pwmchip_sysfs_unexport(struct pwm_chip *chip)
-{
-}
-#endif /* CONFIG_PWM_SYSFS */
-
 #endif /* __LINUX_PWM_H */
-- 
2.43.0


