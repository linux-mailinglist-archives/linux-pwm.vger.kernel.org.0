Return-Path: <linux-pwm+bounces-1044-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D3C83C21A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FE1290E7D
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B8376E1;
	Thu, 25 Jan 2024 12:11:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE93A27E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184666; cv=none; b=IUNE3ek970ZqEEMvkueaZT/ihfgMlB3+q3+2gVTQdbhA+JO78vtoavqucCc7/slkAX6wYD5ZF+jmhjyfcCNtH3aw7Abyc0vbCSybiieEAGS7A3nl3CYVL2+zL2+lEBEYbh686bjtZOi0+kLELFiH0GArtRKPZKJPDbOTdBh/HMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184666; c=relaxed/simple;
	bh=KDACP3otuvkjxPiXIvobejwnOTU4smwS5d46KXgg3Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1WyyjkIF8lKRz58y2NUALqUZw8s630p332c078l/34w2dSEBM1TlN7+1uGl7sjCmiv6xxh+0/C6sEu5D8FE4bdH+bcwGVJ0J6l2s+FF3Du5/0XWZS38a31WixBAsX2f25tU8EQqxeUuNxRyEoxXxmMQPoaVfHF5H0s4pGBafiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZS-0004hN-PD; Thu, 25 Jan 2024 13:11:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZR-002HVt-L5; Thu, 25 Jan 2024 13:11:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZR-007n5b-1r;
	Thu, 25 Jan 2024 13:11:01 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 111/111] WIP: pwm: Add support for pwmchip devices for faster and easier userspace access
Date: Thu, 25 Jan 2024 13:10:13 +0100
Message-ID:  <99071b3f4b9bb663bc5b8cab93ea8bbd1690a9c4.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9460; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=KDACP3otuvkjxPiXIvobejwnOTU4smwS5d46KXgg3Bc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRN/nusit/JBHXf+i1c5PaBvyai+NmSaOkp8V0xWQXVJ pLyV6w6GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZiI9kL2/15r6j49dWuraptQ JhgzeZ7RpDuOT7K2R91w0j7FFt4kcIPBJLYgdZ+YEuvNh779/ExvXD/x/C/x0rfJMdsvEMg6ZUe x/o8rnf1M7K/SvPek5Fg6vTNjy59d47PwyDbG7hyL3+u0p0xbL971/kE8n435MsGFwm6NzjLZNz bMO3P+7u2CVGOOvXGxfLxHvzI2zhbiNpos/zYtWeTC1hMW1TFaXHnRqQGlX725WrpeCEdpdC0OW 9hSrrdKK9Ri188Q98LNnw+zf5ArMG1Z+XyeyvW3Gr6GfcGWiy/FrzevvX1sf8pFBrkeVeV32isi PMvvebps9VGuEZNcUPblp67x3JaQv+ty+ef0/l5xJQIA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Todo:
 - implement PWM_IOCTL_GET ioctls
 - drop debug output
 - maybe merge core.c and sysfs.c (separate commit?)

Not-yet-signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c       | 231 ++++++++++++++++++++++++++++++++++++---
 drivers/pwm/sysfs.c      |  19 +++-
 include/linux/pwm.h      |   3 +
 include/uapi/linux/pwm.h |  23 ++++
 4 files changed, 260 insertions(+), 16 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a22055b06988..fe2ef1bab820 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -21,6 +21,8 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#include <uapi/linux/pwm.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
@@ -135,21 +137,13 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 	}
 }
 
-/**
- * __pwm_apply() - atomically apply a new state to a PWM device
- * @pwm: PWM device
- * @state: new state to apply
- */
-static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
+static int __pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
 {
-	struct pwm_chip *chip;
 	int err;
 
-	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
-		return -EINVAL;
-
-	chip = pwm->chip;
+	if (!chip->operational)
+		return -ENXIO;
 
 	if (state->period == pwm->state.period &&
 	    state->duty_cycle == pwm->state.duty_cycle &&
@@ -174,6 +168,27 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 	return 0;
 }
 
+/**
+ * __pwm_apply() - atomically apply a new state to a PWM device
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	struct pwm_chip *chip;
+	int err = 0;
+
+	if (!pwm || !state || !state->period ||
+	    state->duty_cycle > state->period)
+		return -EINVAL;
+
+	chip = pwm->chip;
+
+	err = __pwm_apply_locked(chip, pwm, state);
+
+	return err;
+}
+
 /**
  * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
  * Cannot be used in atomic context.
@@ -409,7 +424,6 @@ struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 }
 EXPORT_SYMBOL_GPL(pwm_request_from_chip);
 
-
 struct pwm_device *
 of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *args)
 {
@@ -556,6 +570,187 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 	return true;
 }
 
+struct pwm_cdev_data {
+	struct pwm_chip *chip;
+	struct pwm_device *pwm[];
+};
+
+static int pwm_cdev_open(struct inode *inode, struct file *file)
+{
+	struct pwm_chip *chip = container_of(inode->i_cdev, struct pwm_chip, cdev);
+	struct pwm_cdev_data *cdata;
+	int ret;
+
+	pr_info("%s:%d\n", __func__, __LINE__);
+	mutex_lock(&pwm_lock);
+
+	if (!chip->operational) {
+		ret = -ENXIO;
+		goto out_unlock;
+	}
+
+	cdata = kzalloc(struct_size(cdata, pwm, chip->npwm), GFP_KERNEL);
+	if (!cdata) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	cdata->chip = chip;
+
+	file->private_data = cdata;
+
+	ret = nonseekable_open(inode, file);
+
+out_unlock:
+	mutex_unlock(&pwm_lock);
+
+	return ret;
+}
+
+static int pwm_cdev_release(struct inode *inode, struct file *file)
+{
+	struct pwm_cdev_data *cdata = file->private_data;
+	unsigned int i;
+
+	for (i = 0; i < cdata->chip->npwm; ++i) {
+		if (cdata->pwm[i])
+			pwm_put(cdata->pwm[i]);
+	}
+	kfree(cdata);
+
+	return 0;
+}
+
+static int pwm_cdev_request(struct pwm_cdev_data *cdata, unsigned int hwpwm)
+{
+	struct pwm_chip *chip = cdata->chip;
+
+	if (hwpwm >= chip->npwm)
+		return -EINVAL;
+
+	if (!cdata->pwm[hwpwm]) {
+		struct pwm_device *pwm = &chip->pwms[hwpwm];
+		int ret;
+
+		ret = pwm_device_request(pwm, "pwm-cdev");
+		if (ret < 0)
+			return ret;
+
+		cdata->pwm[hwpwm] = pwm;
+	}
+
+	return 0;
+}
+
+static int pwm_cdev_free(struct pwm_cdev_data *cdata, unsigned int hwpwm)
+{
+	struct pwm_chip *chip = cdata->chip;
+
+	if (hwpwm >= chip->npwm)
+		return -EINVAL;
+
+	if (cdata->pwm[hwpwm]) {
+		struct pwm_device *pwm = cdata->pwm[hwpwm];
+
+		pwm_put(pwm);
+
+		cdata->pwm[hwpwm] = NULL;
+	}
+
+	return 0;
+}
+
+static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret = 0;
+	struct pwm_cdev_data *cdata = file->private_data;
+	struct pwm_chip *chip = cdata->chip;
+
+	mutex_lock(&pwm_lock);
+
+	if (!chip->operational) {
+		ret = -ENXIO;
+		goto out_unlock;
+	}
+
+	switch (cmd) {
+	case PWM_IOCTL_GET_NUM_PWMS:
+		ret = chip->npwm;
+		break;
+
+	case PWM_IOCTL_REQUEST:
+		{
+			unsigned int hwpwm;
+
+			ret = get_user(hwpwm, (unsigned int __user *)arg);
+			if (ret)
+				goto out_unlock;
+
+			ret = pwm_cdev_request(cdata, hwpwm);
+		}
+		break;
+
+	case PWM_IOCTL_FREE:
+		{
+			unsigned int hwpwm;
+
+			ret = get_user(hwpwm, (unsigned int __user *)arg);
+			if (ret)
+				goto out_unlock;
+
+			ret = pwm_cdev_free(cdata, hwpwm);
+
+		}
+		break;
+
+	case PWM_IOCTL_APPLY:
+		{
+			struct pwmchip_state cstate;
+			struct pwm_state state;
+			struct pwm_device *pwm;
+
+			ret = copy_from_user(&cstate, (struct pwmchip_state __user *)arg, sizeof(cstate));
+			if (ret)
+				goto out_unlock;
+
+			ret = pwm_cdev_request(cdata, cstate.hwpwm);
+			if (ret)
+				goto out_unlock;
+
+			pwm = cdata->pwm[cstate.hwpwm];
+
+			state.period = cstate.period;
+			state.duty_cycle = cstate.duty_cycle;
+			if (cstate.duty_offset >= cstate.period - cstate.duty_cycle)
+				state.polarity = PWM_POLARITY_INVERSED;
+			else
+				state.polarity = PWM_POLARITY_NORMAL;
+			state.enabled = cstate.period > 0;
+
+			ret = __pwm_apply_locked(chip, pwm, &state);
+	        }
+		break;
+
+	default:
+		ret = -ENOTTY;
+		break;
+	}
+out_unlock:
+	mutex_unlock(&pwm_lock);
+
+	return ret;
+}
+
+static const struct file_operations pwm_cdev_fileops = {
+	.open = pwm_cdev_open,
+	.release = pwm_cdev_release,
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.unlocked_ioctl = pwm_cdev_ioctl,
+};
+
+extern dev_t pwm_devt;
+
 /**
  * __pwmchip_add() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -602,7 +797,13 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
-	ret = device_add(&chip->dev);
+	if (chip->id < 256)
+		chip->dev.devt = MKDEV(MAJOR(pwm_devt), chip->id);
+
+	cdev_init(&chip->cdev, &pwm_cdev_fileops);
+	chip->cdev.owner = owner;
+
+	ret = cdev_device_add(&chip->cdev, &chip->dev);
 	if (ret)
 		goto err_device_add;
 
@@ -646,7 +847,7 @@ void pwmchip_remove(struct pwm_chip *chip)
 
 	module_put(chip->owner);
 
-	device_del(&chip->dev);
+	cdev_device_del(&chip->cdev, &chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 5fd518772aa1..7342ddb1f96f 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -509,8 +510,24 @@ void pwmchip_sysfs_unexport(struct pwm_chip *chip)
 	}
 }
 
+dev_t pwm_devt;
+
 static int __init pwm_sysfs_init(void)
 {
-	return class_register(&pwm_class);
+	int ret;
+
+	ret = alloc_chrdev_region(&pwm_devt, 0, 256, "pwm");
+	if (ret) {
+		pr_warn("Failed to initialize chrdev region for PWM usage\n");
+		return ret;
+	}
+
+	ret = class_register(&pwm_class);
+	if (ret) {
+		pr_warn("Failed to register PWM class\n");
+		unregister_chrdev_region(pwm_devt, 256);
+	}
+
+	return ret;
 }
 subsys_initcall(pwm_sysfs_init);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 7012adf80a2e..33aeb181f0d5 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
@@ -278,6 +279,7 @@ struct pwm_ops {
  */
 struct pwm_chip {
 	struct device dev;
+	struct cdev cdev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	unsigned int id;
@@ -288,6 +290,7 @@ struct pwm_chip {
 	bool atomic;
 
 	/* only used internally by the PWM framework */
+	bool operational;
 	bool uses_pwmchip_alloc;
 	struct pwm_device pwms[] __counted_by(npwm);
 };
diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
new file mode 100644
index 000000000000..22f1bf8df54d
--- /dev/null
+++ b/include/uapi/linux/pwm.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+
+#ifndef _UAPI_PWM_H_
+#define _UAPI_PWM_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+struct pwmchip_state {
+	/* Make alignment arch-independant */
+	unsigned int hwpwm;
+	__u64 period;
+	__u64 duty_cycle;
+	__u64 duty_offset;
+};
+
+#define PWM_IOCTL_GET_NUM_PWMS	_IO(0x75, 0)
+#define PWM_IOCTL_REQUEST	_IOW(0x75, 1, unsigned int)
+#define PWM_IOCTL_FREE		_IOW(0x75, 2, unsigned int)
+#define PWM_IOCTL_APPLY		_IOW(0x75, 3, struct pwmchip_state)
+#define PWM_IOCTL_GET		_IOWR(0x75, 4, struct pwmchip_state)
+
+#endif /* _UAPI_PWM_H_ */
-- 
2.43.0


