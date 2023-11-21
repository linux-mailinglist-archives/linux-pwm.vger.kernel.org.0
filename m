Return-Path: <linux-pwm+bounces-103-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7EA7F2FBA
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3811C21907
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C93D985;
	Tue, 21 Nov 2023 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B96170C
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAf-0006k4-BA; Tue, 21 Nov 2023 14:52:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAe-00Ab3J-FA; Tue, 21 Nov 2023 14:52:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAe-004xiJ-63; Tue, 21 Nov 2023 14:52:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v3 108/108] WIP: pwm: Add support for pwmchip devices for faster and easier userspace access
Date: Tue, 21 Nov 2023 14:50:50 +0100
Message-ID: <20231121134901.208535-109-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9606; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=17JjVusaKF+9bvMgyIzzuOEeXO7VKPteLqKOPBF8qqc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLXD4w/xnbgfJUQ83KgqrjLGgSLTNKqRQYsDG RJCRebXnkSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1wwAKCRCPgPtYfRL+ TtSkB/4sA0Y0L7ETutvJyjPdO2yr0ra//xK4lSI6gCNFG7FliwsKhNlfYCKbFsx/Fz41RXiIdqR VKLW5qKzwLXFrZjYeqsfYlLpjq6Nu60tZCj777m03rn8XGzawW8m+xqDM73+mwFFARInDcrzFJ1 CVKVJxqAFoCJf7rc/AxYYYGaSUxNbUrBvJ5NJcw6tEjndRc0gHlwZzgFBYqPk+FuAsYqN+us31R tFY2xFA5PLRcdiNpD/BjSyU+aG8mfbOCblCLQokziWsLo6Og/5k7STfNliQH+mf2GQakexqtlGC DNeyIoHqYPSLdi/A7vtxkHb6YqlDCF8ai35O8I0xTtFPWBSc
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Todo:
 - reshuffle order of functions to get rid of forward decl of __pwm_apply_state
 - implement PWM_IOCTL_GET ioctls
 - drop debug output
 - maybe merge core.c and sysfs.c (separate commit?)

Not-yet-signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c       | 251 ++++++++++++++++++++++++++++++++++-----
 drivers/pwm/sysfs.c      |  19 ++-
 include/linux/pwm.h      |   2 +
 include/uapi/linux/pwm.h |  23 ++++
 4 files changed, 267 insertions(+), 28 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 8dbc79f7218c..465ed7c5a43c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -21,6 +21,8 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#include <uapi/linux/pwm.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
@@ -277,6 +279,189 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 }
 EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
 
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
+static int __pwm_apply_state(struct pwm_chip *chip, struct pwm_device *pwm, const struct pwm_state *state);
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
+			ret = __pwm_apply_state(chip, pwm, &state);
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
@@ -324,7 +509,13 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	mutex_init(&chip->lock);
 
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
 
@@ -387,7 +578,7 @@ void pwmchip_remove(struct pwm_chip *chip)
 
 	module_put(chip->owner);
 
-	device_del(&chip->dev);
+	cdev_device_del(&chip->cdev, &chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -548,6 +739,36 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	}
 }
 
+static int __pwm_apply_state(struct pwm_chip *chip, struct pwm_device *pwm, const struct pwm_state *state)
+{
+	int err;
+
+	if (!chip->operational)
+		return -ENXIO;
+
+	if (state->period == pwm->state.period &&
+	    state->duty_cycle == pwm->state.duty_cycle &&
+	    state->polarity == pwm->state.polarity &&
+	    state->enabled == pwm->state.enabled &&
+	    state->usage_power == pwm->state.usage_power)
+		return 0;
+
+	err = chip->ops->apply(chip, pwm, state);
+	trace_pwm_apply(pwm, state, err);
+	if (err)
+		return err;
+
+	pwm->state = *state;
+
+	/*
+	 * only do this after pwm->state was applied as some
+	 * implementations of .get_state depend on this
+	 */
+	pwm_apply_state_debug(pwm, state);
+
+	return err;
+}
+
 /**
  * pwm_apply_state() - atomically apply a new state to a PWM device
  * @pwm: PWM device
@@ -575,32 +796,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
 	pwmchip_lock(chip);
 
-	if (!chip->operational) {
-		err = -ENXIO;
-		goto out_unlock;
-	}
+	err = __pwm_apply_state(chip, pwm, state);
 
-	if (state->period == pwm->state.period &&
-	    state->duty_cycle == pwm->state.duty_cycle &&
-	    state->polarity == pwm->state.polarity &&
-	    state->enabled == pwm->state.enabled &&
-	    state->usage_power == pwm->state.usage_power)
-		goto out_unlock;
-
-	err = chip->ops->apply(chip, pwm, state);
-	trace_pwm_apply(pwm, state, err);
-	if (err)
-		goto out_unlock;
-
-	pwm->state = *state;
-
-	/*
-	 * only do this after pwm->state was applied as some
-	 * implementations of .get_state depend on this
-	 */
-	pwm_apply_state_debug(pwm, state);
-
-out_unlock:
 	pwmchip_unlock(chip);
 
 	return err;
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 3a438b29c777..e5bbff32b719 100644
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
index 4e81e8819f8c..79aaa3959da8 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
@@ -294,6 +295,7 @@ struct pwm_ops {
  */
 struct pwm_chip {
 	struct device dev;
+	struct cdev cdev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	unsigned int id;
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
2.42.0


