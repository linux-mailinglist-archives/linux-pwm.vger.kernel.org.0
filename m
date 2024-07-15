Return-Path: <linux-pwm+bounces-2804-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F49312E9
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 13:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15044B21BE8
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA3B184114;
	Mon, 15 Jul 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1RA1ZcQZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19213D8B1
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042211; cv=none; b=YT5nPbsHFudPoQOTAi73kb+m+1lwPECeW7fI+PLFZgkY0jd7z+Ulq2VCgpOsavhZo3QMtZZJ4rN6/3XxEw+MKfquMv/K07SbDiCd8Jsh4euX4+N1QxUMdcGa/c+2Ed7UWTaXMyQCemzFiCF+eQGxsDIoAkE1fd/XD9MUNiFHxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042211; c=relaxed/simple;
	bh=ycJRp5/PScpkPCWNKO6qxgAF59lZ2L28jrpRRETM+zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rk92J6DGp3z7ofqVuJ9KLmk4aENfH5n5Ax38erpRSHQLXqb8TwRXEVLm2ChJZB3dmA4zW7aLyQ0k1sYeuz+Pb3jl2l47ZKbpbsMeS4Cu3GENXuXqPbZ0Tq9blGexP0Zan9LrPzrkGDL5fVKaiXpxUqh2K/MeKLbyCH9Ht7Zixz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1RA1ZcQZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52e99060b41so4302826e87.2
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721042207; x=1721647007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuu/kq0Nu8n0uoQVcGgd2ltqZiN8C5kSkdmDpliIC7I=;
        b=1RA1ZcQZFTZH9ZVVZGzUpC+Jz6CcgxeWawGdzLlGQOSF6xKwtsoYa28A+CPt97+bc9
         eLghfDRwSjY9GX03SwM5Eh7iSzRvdilrXoEg8Bcrm5vQKdJat+Ed3Gh2mzzd90s8qLnn
         nSyit0mg3oGLrrNLMVRziPBK39cFRhlsuhTTn4l4CRvcWtVLMw4fKf0o9scZjKRiQoL+
         cxN5VRmg2lFd7XOSdBn3ykC2IARWqo2s0G5eeSA+KVgZ8cLn8dgE2rRcZm738XMzeK5D
         Zh3ZztqQYsSjn9XmUyb28ba8vu8hp8pKHvqP8iuRhmdYqPm4IIdpzJZp2E4Hudoimt/9
         yLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042207; x=1721647007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuu/kq0Nu8n0uoQVcGgd2ltqZiN8C5kSkdmDpliIC7I=;
        b=pUELQv7pU3PidFKrnyc8QmWVrVLFrfCtQNxOD6yVjRn/b9aD1wbEJdXy65Ce2kTSFr
         YrHcht+K4a0aX9/znEWCUGIh810ZBpjqpRZv7Kbxl84sueNQLLYZctLsVnScmiYjasV9
         FpyZU7ZlOoq12iD6Y/XsP5wxIYYjTvPLENlVyW3Mz2j41dHelSlKYkOeGGEvni0hTdx/
         PNCi9KU5u3dNkpKBeUauSwbBifVyZ+8CWquhXjEfvNYxnN8xUxeYbRa+WwcTfYpOUzEv
         pNpG179WOc/sjRfOWf/rkcgZHc7akPgLgQcqxei+bdBoV6IqUWFzluEHXZn9/aggewVN
         RpgQ==
X-Gm-Message-State: AOJu0Yw+tIkxS2L4A+u9DqmV8k+oQF/ULCdLurQkem0rLSCT8YuEHgXx
	NwxoYc4Sxd81v/JFGiUijAqA1ixEOA2v8vPeOAM2eUvoKOykcNCcVsdJwktgTUdZ/nnVWN3kDjK
	F
X-Google-Smtp-Source: AGHT+IGQz688IPZac1Wv3Q8hzRk19SJcOIHQYwJeYe8A9H0E14HNPDBbjmDNdP5VAiswztUpkamG7Q==
X-Received: by 2002:ac2:48b0:0:b0:52e:6ee4:5eaa with SMTP id 2adb3069b0e04-52eb99d16demr9497243e87.54.1721042207127;
        Mon, 15 Jul 2024 04:16:47 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23999csm118614435e9.8.2024.07.15.04.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:16:46 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 5/8] pwm: Add support for pwmchip devices for faster and easier userspace access
Date: Mon, 15 Jul 2024 13:16:10 +0200
Message-ID:  <7e50f9901d63c3aa27cdd02194f95b0ed79765f6.1721040875.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9502; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ycJRp5/PScpkPCWNKO6qxgAF59lZ2L28jrpRRETM+zc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmlQUDQWXpY97n4zUpezLIHSvZREZf1ZDY8+oXM PjFx6c65HqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZpUFAwAKCRCPgPtYfRL+ Tg6jB/9UpTvWzW6s3j2s38kOAmzSmt6OYcKeV3V443tV1coUBtHMamdJkC+PLalrMtnbjbz+vFh +6uiH7+TO/gnIIAdFKnMB8Jnz8mZoUR/1sbI7n2dW6BZ8bRnNXiavZE3ssQyDb5KDdcqDdnmPz3 hsRuU0RZTZa0wegkoei9tVd22W8gjowAAX94sVE8GkcY5KDfl88oo4dL/aIS92RheH+Gg1TjqYm 1i5r6r3CkxdLZ3VlE/P3jFVC+OyrdKMp+wALa0lWQCQHNTagFVzX00KxLu3IkGpCuNz1k4Nv1pe rQI07RPOr+4uteC2fUNINQp/LTmwRo8VTsYnsMnY8zT+bbQM
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With this change each pwmchip defining the new-style waveform callbacks
can be accessed from userspace via a character device. Compared to the
sysfs-API this is faster (on a stm32mp157 applying a new configuration
takes approx 25% only) and allows to pass the whole configuration in a
single ioctl allowing atomic application.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c       | 270 ++++++++++++++++++++++++++++++++++++++-
 include/linux/pwm.h      |   3 +
 include/uapi/linux/pwm.h |  25 ++++
 3 files changed, 296 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4dcb7ec4223f..918915563606 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -23,6 +23,8 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#include <uapi/linux/pwm.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
@@ -1525,6 +1527,257 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
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
+
+	guard(mutex)(&pwm_lock);
+
+	if (!chip->operational)
+		return -ENXIO;
+
+	cdata = kzalloc(struct_size(cdata, pwm, chip->npwm), GFP_KERNEL);
+	if (!cdata)
+		return -ENOMEM;
+
+	cdata->chip = chip;
+
+	file->private_data = cdata;
+
+	return nonseekable_open(inode, file);
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
+	guard(mutex)(&pwm_lock);
+
+	if (!chip->operational)
+		return -ENODEV;
+
+	switch (cmd) {
+	case PWM_IOCTL_GET_NUM_PWMS:
+		return chip->npwm;
+
+	case PWM_IOCTL_REQUEST:
+		{
+			unsigned int hwpwm;
+
+			ret = get_user(hwpwm, (unsigned int __user *)arg);
+			if (ret)
+				return ret;
+
+			return pwm_cdev_request(cdata, hwpwm);
+		}
+		break;
+
+	case PWM_IOCTL_FREE:
+		{
+			unsigned int hwpwm;
+
+			ret = get_user(hwpwm, (unsigned int __user *)arg);
+			if (ret)
+				return ret;
+
+			return pwm_cdev_free(cdata, hwpwm);
+		}
+		break;
+
+	case PWM_IOCTL_ROUNDWF:
+		{
+			struct pwmchip_waveform cwf;
+			struct pwm_waveform wf;
+			struct pwm_device *pwm;
+
+			ret = copy_from_user(&cwf,
+					     (struct pwmchip_waveform __user *)arg,
+					     sizeof(cwf));
+			if (ret)
+				return -EFAULT;
+
+			if (cwf.__pad != 0)
+				return -EINVAL;
+
+			ret = pwm_cdev_request(cdata, cwf.hwpwm);
+			if (ret)
+				return ret;
+
+			pwm = cdata->pwm[cwf.hwpwm];
+
+			wf = (struct pwm_waveform) {
+				.period_length = cwf.period_length,
+				.duty_length = cwf.duty_length,
+				.duty_offset = cwf.duty_offset,
+			};
+
+			ret = pwm_round_waveform_might_sleep(pwm, &wf);
+			if (ret)
+				return ret;
+
+			cwf = (struct pwmchip_waveform) {
+				.hwpwm = cwf.hwpwm,
+				.period_length = wf.period_length,
+				.duty_length = wf.duty_length,
+				.duty_offset = wf.duty_offset,
+			};
+
+			return copy_to_user((struct pwmchip_waveform __user *)arg,
+					    &cwf, sizeof(cwf));
+		}
+		break;
+
+	case PWM_IOCTL_GETWF:
+		{
+			struct pwmchip_waveform cwf;
+			struct pwm_waveform wf;
+			struct pwm_device *pwm;
+
+			ret = copy_from_user(&cwf,
+					     (struct pwmchip_waveform __user *)arg,
+					     sizeof(cwf));
+			if (ret)
+				return -EFAULT;
+
+			if (cwf.__pad != 0) {
+				pr_warn("huh\n");
+				return -EINVAL;
+			}
+
+			ret = pwm_cdev_request(cdata, cwf.hwpwm);
+			if (ret)
+				return ret;
+
+			pwm = cdata->pwm[cwf.hwpwm];
+
+			ret = pwm_get_waveform_might_sleep(pwm, &wf);
+			if (ret)
+				return ret;
+
+			cwf.period_length = wf.period_length;
+			cwf.duty_length = wf.duty_length;
+			cwf.duty_offset = wf.duty_offset;
+
+			return copy_to_user((struct pwmchip_waveform __user *)arg,
+					    &cwf, sizeof(cwf));
+		}
+		break;
+
+	case PWM_IOCTL_SETROUNDEDWF:
+	case PWM_IOCTL_SETEXACTWF:
+		{
+			struct pwmchip_waveform cwf;
+			struct pwm_waveform wf;
+			struct pwm_device *pwm;
+
+			ret = copy_from_user(&cwf,
+					     (struct pwmchip_waveform __user *)arg,
+					     sizeof(cwf));
+			if (ret)
+				return -EFAULT;
+			if (cwf.__pad != 0) {
+				pr_warn("huh\n");
+				return -EINVAL;
+			}
+
+			if (cwf.period_length > 0 &&
+			    (cwf.duty_length > cwf.period_length ||
+			     cwf.duty_offset >= cwf.period_length))
+				return -EINVAL;
+
+			ret = pwm_cdev_request(cdata, cwf.hwpwm);
+			if (ret)
+				return ret;
+
+			pwm = cdata->pwm[cwf.hwpwm];
+
+			wf = (struct pwm_waveform){
+				.period_length = cwf.period_length,
+				.duty_length = cwf.duty_length,
+				.duty_offset = cwf.duty_offset,
+			};
+
+			return pwm_set_waveform_might_sleep(pwm, &wf,
+							    cmd == PWM_IOCTL_SETEXACTWF);
+		}
+		break;
+
+	default:
+		return -ENOTTY;
+	}
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
@@ -1577,7 +1830,13 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	scoped_guard(pwmchip, chip)
 		chip->operational = true;
 
-	ret = device_add(&chip->dev);
+	if (chip->id < 256 && chip->ops->write_waveform)
+		chip->dev.devt = MKDEV(MAJOR(pwm_devt), chip->id);
+
+	cdev_init(&chip->cdev, &pwm_cdev_fileops);
+	chip->cdev.owner = owner;
+
+	ret = cdev_device_add(&chip->cdev, &chip->dev);
 	if (ret)
 		goto err_device_add;
 
@@ -1628,7 +1887,7 @@ void pwmchip_remove(struct pwm_chip *chip)
 		idr_remove(&pwm_chips, chip->id);
 	}
 
-	device_del(&chip->dev);
+	cdev_device_del(&chip->cdev, &chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -2172,9 +2431,16 @@ static int __init pwm_init(void)
 {
 	int ret;
 
+	ret = alloc_chrdev_region(&pwm_devt, 0, 256, "pwm");
+	if (ret) {
+		pr_warn("Failed to initialize chrdev region for PWM usage\n");
+		return ret;
+	}
+
 	ret = class_register(&pwm_class);
 	if (ret) {
 		pr_err("Failed to initialize PWM class (%pe)\n", ERR_PTR(ret));
+		unregister_chrdev_region(pwm_devt, 256);
 		return ret;
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 2d1f36a84f1e..fd100c27f109 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
@@ -303,6 +304,7 @@ struct pwm_ops {
 /**
  * struct pwm_chip - abstract a PWM controller
  * @dev: device providing the PWMs
+ * @cdev: &struct cdev for this device
  * @ops: callbacks for this PWM controller
  * @owner: module providing this chip
  * @id: unique number of this PWM chip
@@ -317,6 +319,7 @@ struct pwm_ops {
  */
 struct pwm_chip {
 	struct device dev;
+	struct cdev cdev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	unsigned int id;
diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
new file mode 100644
index 000000000000..5038dca7c84c
--- /dev/null
+++ b/include/uapi/linux/pwm.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+
+#ifndef _UAPI_PWM_H_
+#define _UAPI_PWM_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+struct pwmchip_waveform {
+	unsigned int hwpwm;
+	unsigned int __pad; /* padding, must be zero */
+	__u64 period_length;
+	__u64 duty_length;
+	__u64 duty_offset;
+};
+
+#define PWM_IOCTL_GET_NUM_PWMS	_IO(0x75, 0)
+#define PWM_IOCTL_REQUEST	_IOW(0x75, 1, unsigned int)
+#define PWM_IOCTL_FREE		_IOW(0x75, 2, unsigned int)
+#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
+#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
+#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
+#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
+
+#endif /* _UAPI_PWM_H_ */
-- 
2.43.0


