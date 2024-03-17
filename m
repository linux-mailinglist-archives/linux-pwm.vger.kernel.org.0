Return-Path: <linux-pwm+bounces-1786-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A7C87DCFE
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 11:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5823E1C2090E
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 10:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078481A29A;
	Sun, 17 Mar 2024 10:41:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F118036
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710672059; cv=none; b=lkXruAWXLOaWHULomS9U1QiCyiCzPACmYfEzFt6c0IrgfjSND10meNkOOQhOQbbxWDBUv2vgvPz1+i/UEYND5AFNODpH1x3VC/uLs3ibSZ9TwXWeiN6s1I7hVDOAGq1JKQdnY8ialjgITDT7XgOfr5p8+ZeraicB8KZKWDqonl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710672059; c=relaxed/simple;
	bh=XIQhBcGFSseNZ1x0G2g7RyvYMWHIQ919DZb84w5GG3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tE21WxMvluKn1m53GXLUR3m/nQOMtlYBOcrmnSRzza4szSzW/XaWdJElZfc9dezRi5TZ72PIhdNlvy1xF3ve5emJkjcbueTjd50NVPrpwQkp6xlc9eigP5GNjvBgL/cxB2Yli+mr04IUqAT+5dPNaHlsB4xLBq5Mo+MuE7yiohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwf-0002D5-IF; Sun, 17 Mar 2024 11:40:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwf-006rgA-4Y; Sun, 17 Mar 2024 11:40:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwf-007aDR-0D;
	Sun, 17 Mar 2024 11:40:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH 8/8] pwm: Add support for pwmchip devices for faster and easier userspace access
Date: Sun, 17 Mar 2024 11:40:39 +0100
Message-ID:  <8d3acfc431ecd431d6cced032dcb58ad2579474c.1710670958.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10498; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=XIQhBcGFSseNZ1x0G2g7RyvYMWHIQ919DZb84w5GG3k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl9sipUfhgk9FBVk/ykCJ/Wu654cxfz1j+3Fao3 bp9Me+kFOKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfbIqQAKCRCPgPtYfRL+ TvwGB/9YNWek99MJ6MI774v9H3hSpdKANP1iB6omnGjX8bh8AR73EmLiorOpPG4Da6dpZFDpzpk IuQqmzCa4szSYoW3ZSjLDECpXq478OFCUzTrbco+3plr75SWhAK6y/JCwoqRP2AxbfowxBEVYK5 tmJ+NMzv8Pjcd/r7iPK88uwv6qUQWhCj4uBC7SMMnCcEE/yrknFQWtMKy7gpsXIsBfbZyV2B5Jx fLUWMhre9zB5oiMAtagR9i59IwoCovOlifUTAKOoaFmKHg+cPZcx7a08WejWa5LWgG2Zu0kUdum oSyBzn9u45ta1lWPcRTMmJpSWlxKOIMd7VQBHZikKiRr9s8E
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

With this change each pwmchip can be accessed from userspace via a
character device. Compared to the sysfs-API this is faster (on a
stm32mp157 applying a new configuration takes approx 25% only) and
allows to pass the whole configuration in a single ioctl.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c       | 310 +++++++++++++++++++++++++++++++++++++--
 include/linux/pwm.h      |   2 +
 include/uapi/linux/pwm.h |  23 +++
 3 files changed, 322 insertions(+), 13 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2e08fcfbe138..7f41ab087b98 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -21,6 +21,8 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#include <uapi/linux/pwm.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
@@ -249,6 +251,25 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
 }
 EXPORT_SYMBOL_GPL(pwm_apply_atomic);
 
+static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
+{
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
+	int ret = -EOPNOTSUPP;
+
+	if (ops->get_state) {
+		pwmchip_lock(chip);
+
+		ret = ops->get_state(chip, pwm, state);
+
+		pwmchip_unlock(chip);
+
+		trace_pwm_get(pwm, state, ret);
+	}
+
+	return ret;
+}
+
 /**
  * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
  * @pwm: PWM device
@@ -411,14 +432,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		 */
 		struct pwm_state state = { 0, };
 
-		pwmchip_lock(chip);
-
-		err = ops->get_state(chip, pwm, &state);
-
-		pwmchip_unlock(chip);
-
-		trace_pwm_get(pwm, &state, err);
-
+		err = pwm_get_state_hw(pwm, &state);
 		if (!err)
 			pwm->state = state;
 
@@ -1120,6 +1134,250 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
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
+		ret = -ENODEV;
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
+		}
+		break;
+
+	case PWM_IOCTL_GET:
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
+			ret = pwm_get_state_hw(pwm, &state);
+			if (ret)
+				goto out_unlock;
+
+			if (state.enabled) {
+				cstate.period = state.period;
+				if (state.polarity == PWM_POLARITY_NORMAL) {
+					cstate.duty_offset = 0;
+					cstate.duty_cycle = state.duty_cycle;
+				} else {
+					cstate.duty_offset = state.duty_cycle;
+					cstate.duty_cycle = state.period - state.duty_cycle;
+				}
+			} else {
+				cstate.period = 0;
+				cstate.duty_cycle = 0;
+				cstate.duty_offset = 0;
+			}
+			ret = copy_to_user((struct pwmchip_state __user *)arg, &cstate, sizeof(cstate));
+		}
+		break;
+
+	case PWM_IOCTL_APPLY:
+		{
+			struct pwmchip_state cstate;
+			struct pwm_state state = { };
+			struct pwm_device *pwm;
+
+			ret = copy_from_user(&cstate, (struct pwmchip_state __user *)arg, sizeof(cstate));
+			if (ret)
+				goto out_unlock;
+
+			if (cstate.period > 0 &&
+			    (cstate.duty_cycle > cstate.period ||
+			     cstate.duty_offset >= cstate.period)) {
+				ret = -EINVAL;
+				goto out_unlock;
+			}
+
+			/*
+			 * While the API provides a duty_offset member
+			 * to describe (among others) also inversed
+			 * polarity wave forms, the translation into the
+			 * traditional representation with a (binary) polarity
+			 * isn't trivial because the lowlevel drivers round
+			 * duty_cycle down when applying a setting and so in the
+			 * representation with duty_offset the rounding is
+			 * inconsistent. I have no idea what's the best way to
+			 * fix that, so to not commit to a solution yet, just
+			 * refuse requests with .duty_offset that would yield
+			 * inversed polarity for now.
+			 */
+			if (cstate.duty_cycle < cstate.period &&
+			    cstate.duty_offset + cstate.duty_cycle >= cstate.period) {
+				ret = -EINVAL;
+				goto out_unlock;
+			}
+
+			ret = pwm_cdev_request(cdata, cstate.hwpwm);
+			if (ret)
+				goto out_unlock;
+
+			pwm = cdata->pwm[cstate.hwpwm];
+
+			if (cstate.period > 0) {
+				state.enabled = true;
+				state.period = cstate.period;
+				state.polarity = PWM_POLARITY_NORMAL;
+				state.duty_cycle = cstate.duty_cycle;
+			} else {
+				state.enabled = false;
+			}
+
+			ret = pwm_apply_might_sleep(pwm, &state);
+		}
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
+static dev_t pwm_devt;
+
 /**
  * __pwmchip_add() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -1173,7 +1431,13 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	chip->operational = true;
 	pwmchip_unlock(chip);
 
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
 
@@ -1232,7 +1496,7 @@ void pwmchip_remove(struct pwm_chip *chip)
 
 	mutex_unlock(&pwm_lock);
 
-	device_del(&chip->dev);
+	cdev_device_del(&chip->cdev, &chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -1785,9 +2049,29 @@ DEFINE_SEQ_ATTRIBUTE(pwm_debugfs);
 
 static int __init pwm_init(void)
 {
-	if (IS_ENABLED(CONFIG_DEBUG_FS))
-		debugfs_create_file("pwm", 0444, NULL, NULL, &pwm_debugfs_fops);
+	struct dentry *pwm_debugfs = NULL;
+	int ret;
 
-	return class_register(&pwm_class);
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		pwm_debugfs = debugfs_create_file("pwm", 0444, NULL, NULL,
+						  &pwm_debugfs_fops);
+
+	ret = alloc_chrdev_region(&pwm_devt, 0, 256, "pwm");
+	if (ret) {
+		pr_warn("Failed to initialize chrdev region for PWM usage\n");
+		goto err_alloc_chrdev;
+	}
+
+	ret = class_register(&pwm_class);
+	if (ret) {
+		pr_warn("Failed to initialize PWM class\n");
+
+		unregister_chrdev_region(pwm_devt, 256);
+err_alloc_chrdev:
+
+		debugfs_remove(pwm_debugfs);
+	}
+
+	return ret;
 }
 subsys_initcall(pwm_init);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 9c84e0ba81a4..d5fed23b48f0 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
@@ -281,6 +282,7 @@ struct pwm_ops {
  */
 struct pwm_chip {
 	struct device dev;
+	struct cdev cdev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	unsigned int id;
diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
new file mode 100644
index 000000000000..ca765bfaa68d
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
+	unsigned int hwpwm;
+	__u64 period;
+	__u64 duty_cycle;
+	__u64 duty_offset;
+};
+
+#define PWM_IOCTL_GET_NUM_PWMS	_IO(0x75, 0)
+#define PWM_IOCTL_REQUEST	_IOW(0x75, 1, unsigned int)
+#define PWM_IOCTL_FREE		_IOW(0x75, 2, unsigned int)
+/* reserve nr = 3 for rounding */
+#define PWM_IOCTL_GET		_IOWR(0x75, 4, struct pwmchip_state)
+#define PWM_IOCTL_APPLY		_IOW(0x75, 5, struct pwmchip_state)
+
+#endif /* _UAPI_PWM_H_ */
-- 
2.43.0


