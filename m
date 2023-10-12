Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC57C7318
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379554AbjJLQdE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347335AbjJLQdA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:33:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EC7CA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:32:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycK-0000jd-JO; Thu, 12 Oct 2023 18:32:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycJ-001CCV-S3; Thu, 12 Oct 2023 18:32:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycJ-00F5W0-Gm; Thu, 12 Oct 2023 18:32:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 109/109] WIP: pwm: Add support for pwmchip devices for faster and easier userspace access
Date:   Thu, 12 Oct 2023 18:32:38 +0200
Message-ID: <20231012163227.1004288-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8630; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LK1DJquumHCFJJK+jJvL52RwTtuGf7YMt/MQRWssyM4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB+nOEWIH/zxyir69akyOfFyzXKJm58GnDIk/ F+iZT5rtDqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfpwAKCRCPgPtYfRL+ TvPsB/wMt0kPMeV8+LQpeO0L9RA4EsIiWj6C9z590jkQ3lTU5DthcOSwxTKzco8lVL4wfvXZ6ia J6A2K+FUW3zpOWoDUbZlcc50KHJ3F4Kmep8+c7NhCQ+BgcezWtK+ezk4r5jp8+cH1aJFOdE9IWC Wk+r6W5HaEfMp5MO1jjfzSmEtSa8kgTNZsz4UZYWX9gEATzyzE/6+REUUek7TNKpkdSanaHg5lr pTaMEKPbTDBRzKxdZu6bkmuKVD2OOz0Kv9rmakVnmt+yR29N9F9HtezoYKUm7PK/K2cEBBrloEp sdOIR1A5CBuVbZVSi7omMr6fFk5YjptDkA+6OBEcoO3z1Kfx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Todo:
 - reshuffle order of functions to get rid of forward decl of __pwm_apply_state
 - implement remaining ioctls
 - drop debug output
 - maybe merge core.c and sysfs.c (separate commit?)
 - ensure opening /dev/pwmchipX takes a reference to the chip to keep it
   alive long enough.

Not-yet-signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c       | 198 ++++++++++++++++++++++++++++++++++-----
 drivers/pwm/sysfs.c      |  19 +++-
 include/linux/pwm.h      |   2 +
 include/uapi/linux/pwm.h |  23 +++++
 4 files changed, 215 insertions(+), 27 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 957d57e3d41d..914775ab9403 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -21,6 +21,8 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#include <uapi/linux/pwm.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
@@ -277,6 +279,136 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
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
+	case PWM_IOCTL_APPLY:
+		{
+			struct pwmchip_state cstate;
+			struct pwm_state state;
+			struct pwm_device *pwm;
+			ret = copy_from_user(&cstate, (struct pwmchip_state __user *)arg, sizeof(cstate));
+			if (ret)
+				goto out_unlock;
+
+			if (cstate.hwpwm >= chip->npwm) {
+				ret = -EINVAL;
+				goto out_unlock;
+			}
+
+			if (!cdata->pwm[cstate.hwpwm]) {
+				pwm = &chip->pwms[cstate.hwpwm];
+
+				/* XXX: maybe add the current->pid to the request label? */
+				ret = pwm_device_request(pwm, "pwm-cdev");
+				if (ret < 0)
+					goto out_unlock;
+
+				cdata->pwm[cstate.hwpwm] = pwm;
+			} else {
+				pwm = cdata->pwm[cstate.hwpwm];
+			}
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
@@ -324,7 +456,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	mutex_init(&chip->lock);
 
-	ret = device_add(&chip->dev);
+	if (chip->id < 256) {
+		chip->dev.devt = MKDEV(MAJOR(pwm_devt), chip->id);
+
+		cdev_init(&chip->cdev, &pwm_cdev_fileops);
+		chip->cdev.owner = owner;
+		ret = cdev_device_add(&chip->cdev, &chip->dev);
+	} else {
+		ret = device_add(&chip->dev);
+	}
 	if (ret)
 		goto err_device_add;
 
@@ -548,6 +688,36 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
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
@@ -575,32 +745,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
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
index 8e3e579deea2..83433effe4fb 100644
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
index 000000000000..ff017ba072f6
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
+#define PWM_IOCTL_REQUEST	_IO(0x75, 1)
+#define PWM_IOCTL_FREE		_IO(0x75, 2)
+#define PWM_IOCTL_APPLY		_IOW(0x75, 3, struct pwmchip_state)
+#define PWM_IOCTL_GET		_IOWR(0x75, 4, struct pwmchip_state)
+
+#endif /* _UAPI_PWM_H_ */
-- 
2.42.0

