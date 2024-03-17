Return-Path: <linux-pwm+bounces-1781-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C5587DCF9
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 11:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508301F210D9
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3121804F;
	Sun, 17 Mar 2024 10:40:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4039FC1D
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710672058; cv=none; b=CATK5BsDm4J0uHAjezI5Wwh9RiCFJXFbwPDgyYlm4D5wlipc8IckhAnUlnt1qkB079dfXNnYrnLjD6qm8Id4CW0QGyFiIMiiBM1sQCmEsthyOsCmqldiJ0vthYmo07VTbl+1/QQ/SIMqoLxlAGOYXoROLPrAEGemvDGbEpMXx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710672058; c=relaxed/simple;
	bh=ecrKnQqP7MtSgNfrT9L0IAwzGkjuaVrT5pyArLi9Hh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvJJRxyvGoHNXvxZt/VcPGj1MM0PBy0x2WX4I64dsOqKgkE19yRWbwZlFz4DYsPqJV0KiVx60aCHiLyr4ILfeBZPLD7uruwLrt/ufXlxf/PTf5duEfnijZpgkVmrATtLje7HyGJU0BkoT31a5RybgGa6l4gc9j91kstUSiGwEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwd-00029e-Ql; Sun, 17 Mar 2024 11:40:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwd-006rfl-EJ; Sun, 17 Mar 2024 11:40:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwd-007aD3-1C;
	Sun, 17 Mar 2024 11:40:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH 2/8] pwm: Give some sysfs related variables and functions better names
Date: Sun, 17 Mar 2024 11:40:33 +0100
Message-ID:  <9cc05aceeae2f06ecb850bccb15ba821e768c183.1710670958.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15732; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ecrKnQqP7MtSgNfrT9L0IAwzGkjuaVrT5pyArLi9Hh0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl9siihqTFXet0h6qeE57jF5x5zj4bHPdt0chNv WdOA52EgmKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfbIogAKCRCPgPtYfRL+ TlHZCACQaNtzfXo+wHKrvVY9e0W50AmQxRHUgj1nbCfrbs7uu0YV7hp++QnLXKv38U+cVAyHQdg FrSGNk5HvxAjejIluHMoxoHtwyILBCIkdnFg0Am+CCxtrUniR7Gp3dKH+6fzOAeBtlT2gDAS0Xh RBzXhzVTU7JwxZWzr7c0ShMZAscTXgxZEeQEPy/PiCQZb6n4Cjz099iIRJBu/iSdnAYOYJRB7ey QWtHCbi+uRtvRVtSNQJw+2ktsPQk94ZbviCYcWBfomCC+7lO76vViL4C4n5Q2HamDBljZqhUPX1 wdQLm7dNUabZhcsS4mIqruvCTfescHmdUEyGclkkEqK2FmJk
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The code handling the sysfs API uses "child" and "parent" to refer to
the devices corresponding to a struct pwm or a struct pwm_chip
respectively.

Other parts of the pwm core use "parent" to refer to the parent device of
a struct pwm_chip.

So rename "child" to "pwm_dev" and "parent" to "pwmchip_dev" which
better explains the semantic. Also two functions are changed to match
the new names:

        child_to_pwm_export() -> pwmexport_from_dev()
        child_to_pwm_device() -> pwm_from_dev()

(which have the additional advantage to start with "pwm" which gives the
right scope). Additionally introduce a wrapper for dev_get_drvdata() to
convert a pwmchip_dev to the respective pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/sysfs.c | 161 +++++++++++++++++++++++---------------------
 1 file changed, 83 insertions(+), 78 deletions(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 3f434a771fb5..1a1b1f6dd98f 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -15,29 +15,34 @@
 #include <linux/pwm.h>
 
 struct pwm_export {
-	struct device child;
+	struct device pwm_dev;
 	struct pwm_device *pwm;
 	struct mutex lock;
 	struct pwm_state suspend;
 };
 
-static struct pwm_export *child_to_pwm_export(struct device *child)
+static inline struct pwm_chip *pwmchip_from_dev(struct device *pwmchip_dev)
 {
-	return container_of(child, struct pwm_export, child);
+	return dev_get_drvdata(pwmchip_dev);
 }
 
-static struct pwm_device *child_to_pwm_device(struct device *child)
+static inline struct pwm_export *pwmexport_from_dev(struct device *pwm_dev)
 {
-	struct pwm_export *export = child_to_pwm_export(child);
+	return container_of(pwm_dev, struct pwm_export, pwm_dev);
+}
+
+static inline struct pwm_device *pwm_from_dev(struct device *pwm_dev)
+{
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
 
 	return export->pwm;
 }
 
-static ssize_t period_show(struct device *child,
+static ssize_t period_show(struct device *pwm_dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	const struct pwm_device *pwm = child_to_pwm_device(child);
+	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
 	struct pwm_state state;
 
 	pwm_get_state(pwm, &state);
@@ -45,11 +50,11 @@ static ssize_t period_show(struct device *child,
 	return sysfs_emit(buf, "%llu\n", state.period);
 }
 
-static ssize_t period_store(struct device *child,
+static ssize_t period_store(struct device *pwm_dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
-	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
 	struct pwm_device *pwm = export->pwm;
 	struct pwm_state state;
 	u64 val;
@@ -68,11 +73,11 @@ static ssize_t period_store(struct device *child,
 	return ret ? : size;
 }
 
-static ssize_t duty_cycle_show(struct device *child,
+static ssize_t duty_cycle_show(struct device *pwm_dev,
 			       struct device_attribute *attr,
 			       char *buf)
 {
-	const struct pwm_device *pwm = child_to_pwm_device(child);
+	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
 	struct pwm_state state;
 
 	pwm_get_state(pwm, &state);
@@ -80,11 +85,11 @@ static ssize_t duty_cycle_show(struct device *child,
 	return sysfs_emit(buf, "%llu\n", state.duty_cycle);
 }
 
-static ssize_t duty_cycle_store(struct device *child,
+static ssize_t duty_cycle_store(struct device *pwm_dev,
 				struct device_attribute *attr,
 				const char *buf, size_t size)
 {
-	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
 	struct pwm_device *pwm = export->pwm;
 	struct pwm_state state;
 	u64 val;
@@ -103,11 +108,11 @@ static ssize_t duty_cycle_store(struct device *child,
 	return ret ? : size;
 }
 
-static ssize_t enable_show(struct device *child,
+static ssize_t enable_show(struct device *pwm_dev,
 			   struct device_attribute *attr,
 			   char *buf)
 {
-	const struct pwm_device *pwm = child_to_pwm_device(child);
+	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
 	struct pwm_state state;
 
 	pwm_get_state(pwm, &state);
@@ -115,11 +120,11 @@ static ssize_t enable_show(struct device *child,
 	return sysfs_emit(buf, "%d\n", state.enabled);
 }
 
-static ssize_t enable_store(struct device *child,
+static ssize_t enable_store(struct device *pwm_dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
-	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
 	struct pwm_device *pwm = export->pwm;
 	struct pwm_state state;
 	int val, ret;
@@ -151,11 +156,11 @@ static ssize_t enable_store(struct device *child,
 	return ret ? : size;
 }
 
-static ssize_t polarity_show(struct device *child,
+static ssize_t polarity_show(struct device *pwm_dev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	const struct pwm_device *pwm = child_to_pwm_device(child);
+	const struct pwm_device *pwm = pwm_from_dev(pwm_dev);
 	const char *polarity = "unknown";
 	struct pwm_state state;
 
@@ -174,11 +179,11 @@ static ssize_t polarity_show(struct device *child,
 	return sysfs_emit(buf, "%s\n", polarity);
 }
 
-static ssize_t polarity_store(struct device *child,
+static ssize_t polarity_store(struct device *pwm_dev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t size)
 {
-	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
 	struct pwm_device *pwm = export->pwm;
 	enum pwm_polarity polarity;
 	struct pwm_state state;
@@ -200,11 +205,11 @@ static ssize_t polarity_store(struct device *child,
 	return ret ? : size;
 }
 
-static ssize_t capture_show(struct device *child,
+static ssize_t capture_show(struct device *pwm_dev,
 			    struct device_attribute *attr,
 			    char *buf)
 {
-	struct pwm_device *pwm = child_to_pwm_device(child);
+	struct pwm_device *pwm = pwm_from_dev(pwm_dev);
 	struct pwm_capture result;
 	int ret;
 
@@ -231,14 +236,14 @@ static struct attribute *pwm_attrs[] = {
 };
 ATTRIBUTE_GROUPS(pwm);
 
-static void pwm_export_release(struct device *child)
+static void pwm_export_release(struct device *pwm_dev)
 {
-	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_export *export = pwmexport_from_dev(pwm_dev);
 
 	kfree(export);
 }
 
-static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
+static int pwm_export_child(struct device *pwmchip_dev, struct pwm_device *pwm)
 {
 	struct pwm_export *export;
 	char *pwm_prop[2];
@@ -256,62 +261,62 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	export->pwm = pwm;
 	mutex_init(&export->lock);
 
-	export->child.release = pwm_export_release;
-	export->child.parent = parent;
-	export->child.devt = MKDEV(0, 0);
-	export->child.groups = pwm_groups;
-	dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
+	export->pwm_dev.release = pwm_export_release;
+	export->pwm_dev.parent = pwmchip_dev;
+	export->pwm_dev.devt = MKDEV(0, 0);
+	export->pwm_dev.groups = pwm_groups;
+	dev_set_name(&export->pwm_dev, "pwm%u", pwm->hwpwm);
 
-	ret = device_register(&export->child);
+	ret = device_register(&export->pwm_dev);
 	if (ret) {
 		clear_bit(PWMF_EXPORTED, &pwm->flags);
-		put_device(&export->child);
+		put_device(&export->pwm_dev);
 		export = NULL;
 		return ret;
 	}
 	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=pwm%u", pwm->hwpwm);
 	pwm_prop[1] = NULL;
-	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
+	kobject_uevent_env(&pwmchip_dev->kobj, KOBJ_CHANGE, pwm_prop);
 	kfree(pwm_prop[0]);
 
 	return 0;
 }
 
-static int pwm_unexport_match(struct device *child, void *data)
+static int pwm_unexport_match(struct device *pwm_dev, void *data)
 {
-	return child_to_pwm_device(child) == data;
+	return pwm_from_dev(pwm_dev) == data;
 }
 
-static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
+static int pwm_unexport_child(struct device *pwmchip_dev, struct pwm_device *pwm)
 {
-	struct device *child;
+	struct device *pwm_dev;
 	char *pwm_prop[2];
 
 	if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
 		return -ENODEV;
 
-	child = device_find_child(parent, pwm, pwm_unexport_match);
-	if (!child)
+	pwm_dev = device_find_child(pwmchip_dev, pwm, pwm_unexport_match);
+	if (!pwm_dev)
 		return -ENODEV;
 
 	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=pwm%u", pwm->hwpwm);
 	pwm_prop[1] = NULL;
-	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
+	kobject_uevent_env(&pwmchip_dev->kobj, KOBJ_CHANGE, pwm_prop);
 	kfree(pwm_prop[0]);
 
 	/* for device_find_child() */
-	put_device(child);
-	device_unregister(child);
+	put_device(pwm_dev);
+	device_unregister(pwm_dev);
 	pwm_put(pwm);
 
 	return 0;
 }
 
-static ssize_t export_store(struct device *parent,
+static ssize_t export_store(struct device *pwmchip_dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
 	struct pwm_device *pwm;
 	unsigned int hwpwm;
 	int ret;
@@ -327,7 +332,7 @@ static ssize_t export_store(struct device *parent,
 	if (IS_ERR(pwm))
 		return PTR_ERR(pwm);
 
-	ret = pwm_export_child(parent, pwm);
+	ret = pwm_export_child(pwmchip_dev, pwm);
 	if (ret < 0)
 		pwm_put(pwm);
 
@@ -335,11 +340,11 @@ static ssize_t export_store(struct device *parent,
 }
 static DEVICE_ATTR_WO(export);
 
-static ssize_t unexport_store(struct device *parent,
+static ssize_t unexport_store(struct device *pwmchip_dev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t len)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
 	unsigned int hwpwm;
 	int ret;
 
@@ -350,16 +355,16 @@ static ssize_t unexport_store(struct device *parent,
 	if (hwpwm >= chip->npwm)
 		return -ENODEV;
 
-	ret = pwm_unexport_child(parent, &chip->pwms[hwpwm]);
+	ret = pwm_unexport_child(pwmchip_dev, &chip->pwms[hwpwm]);
 
 	return ret ? : len;
 }
 static DEVICE_ATTR_WO(unexport);
 
-static ssize_t npwm_show(struct device *parent, struct device_attribute *attr,
+static ssize_t npwm_show(struct device *pwmchip_dev, struct device_attribute *attr,
 			 char *buf)
 {
-	const struct pwm_chip *chip = dev_get_drvdata(parent);
+	const struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
 
 	return sysfs_emit(buf, "%u\n", chip->npwm);
 }
@@ -374,22 +379,22 @@ static struct attribute *pwm_chip_attrs[] = {
 ATTRIBUTE_GROUPS(pwm_chip);
 
 /* takes export->lock on success */
-static struct pwm_export *pwm_class_get_state(struct device *parent,
+static struct pwm_export *pwm_class_get_state(struct device *pwmchip_dev,
 					      struct pwm_device *pwm,
 					      struct pwm_state *state)
 {
-	struct device *child;
+	struct device *pwm_dev;
 	struct pwm_export *export;
 
 	if (!test_bit(PWMF_EXPORTED, &pwm->flags))
 		return NULL;
 
-	child = device_find_child(parent, pwm, pwm_unexport_match);
-	if (!child)
+	pwm_dev = device_find_child(pwmchip_dev, pwm, pwm_unexport_match);
+	if (!pwm_dev)
 		return NULL;
 
-	export = child_to_pwm_export(child);
-	put_device(child);	/* for device_find_child() */
+	export = pwmexport_from_dev(pwm_dev);
+	put_device(pwm_dev);	/* for device_find_child() */
 
 	mutex_lock(&export->lock);
 	pwm_get_state(pwm, state);
@@ -409,9 +414,9 @@ static int pwm_class_apply_state(struct pwm_export *export,
 	return ret;
 }
 
-static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
+static int pwm_class_resume_npwm(struct device *pwmchip_dev, unsigned int npwm)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
 	unsigned int i;
 	int ret = 0;
 
@@ -420,7 +425,7 @@ static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 		struct pwm_state state;
 		struct pwm_export *export;
 
-		export = pwm_class_get_state(parent, pwm, &state);
+		export = pwm_class_get_state(pwmchip_dev, pwm, &state);
 		if (!export)
 			continue;
 
@@ -440,9 +445,9 @@ static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 	return ret;
 }
 
-static int pwm_class_suspend(struct device *parent)
+static int pwm_class_suspend(struct device *pwmchip_dev)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
 	unsigned int i;
 	int ret = 0;
 
@@ -451,7 +456,7 @@ static int pwm_class_suspend(struct device *parent)
 		struct pwm_state state;
 		struct pwm_export *export;
 
-		export = pwm_class_get_state(parent, pwm, &state);
+		export = pwm_class_get_state(pwmchip_dev, pwm, &state);
 		if (!export)
 			continue;
 
@@ -473,7 +478,7 @@ static int pwm_class_suspend(struct device *parent)
 			 * roll back the PWM devices that were disabled by
 			 * this suspend function.
 			 */
-			pwm_class_resume_npwm(parent, i);
+			pwm_class_resume_npwm(pwmchip_dev, i);
 			break;
 		}
 	}
@@ -481,11 +486,11 @@ static int pwm_class_suspend(struct device *parent)
 	return ret;
 }
 
-static int pwm_class_resume(struct device *parent)
+static int pwm_class_resume(struct device *pwmchip_dev)
 {
-	struct pwm_chip *chip = dev_get_drvdata(parent);
+	struct pwm_chip *chip = pwmchip_from_dev(pwmchip_dev);
 
-	return pwm_class_resume_npwm(parent, chip->npwm);
+	return pwm_class_resume_npwm(pwmchip_dev, chip->npwm);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_class_resume);
@@ -496,22 +501,22 @@ static struct class pwm_class = {
 	.pm = pm_sleep_ptr(&pwm_class_pm_ops),
 };
 
-static int pwmchip_sysfs_match(struct device *parent, const void *data)
+static int pwmchip_sysfs_match(struct device *pwmchip_dev, const void *data)
 {
-	return dev_get_drvdata(parent) == data;
+	return pwmchip_from_dev(pwmchip_dev) == data;
 }
 
 void pwmchip_sysfs_export(struct pwm_chip *chip)
 {
-	struct device *parent;
+	struct device *pwmchip_dev;
 
 	/*
 	 * If device_create() fails the pwm_chip is still usable by
 	 * the kernel it's just not exported.
 	 */
-	parent = device_create(&pwm_class, pwmchip_parent(chip), MKDEV(0, 0), chip,
+	pwmchip_dev = device_create(&pwm_class, pwmchip_parent(chip), MKDEV(0, 0), chip,
 			       "pwmchip%d", chip->id);
-	if (IS_ERR(parent)) {
+	if (IS_ERR(pwmchip_dev)) {
 		dev_warn(pwmchip_parent(chip),
 			 "device_create failed for pwm_chip sysfs export\n");
 	}
@@ -519,23 +524,23 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
 
 void pwmchip_sysfs_unexport(struct pwm_chip *chip)
 {
-	struct device *parent;
+	struct device *pwmchip_dev;
 	unsigned int i;
 
-	parent = class_find_device(&pwm_class, NULL, chip,
+	pwmchip_dev = class_find_device(&pwm_class, NULL, chip,
 				   pwmchip_sysfs_match);
-	if (!parent)
+	if (!pwmchip_dev)
 		return;
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (test_bit(PWMF_EXPORTED, &pwm->flags))
-			pwm_unexport_child(parent, pwm);
+			pwm_unexport_child(pwmchip_dev, pwm);
 	}
 
-	put_device(parent);
-	device_unregister(parent);
+	put_device(pwmchip_dev);
+	device_unregister(pwmchip_dev);
 }
 
 static int __init pwm_sysfs_init(void)
-- 
2.43.0


