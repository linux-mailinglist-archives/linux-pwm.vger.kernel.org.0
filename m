Return-Path: <linux-pwm+bounces-2927-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F6F93F853
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 16:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537E8283B07
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B8E15B149;
	Mon, 29 Jul 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kY15xT+f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F61155A58
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263719; cv=none; b=qF85bcD/gw1d6DsTnqz0MwnkrazQc1hXsfTEn42aunIZ/1SVom4SDaHzHCVhqG486OykT73qswP2tE9XVULzB2jQnefZsva/2caaU4CI1R5cZJLgg17CMpJodE+2zvx9fX72FWKaDuSwS6U+mzO1JLQD50rFrfboQzH5am6MyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263719; c=relaxed/simple;
	bh=eUKbTxtMbAkHYGH1VEMDL0Jsu864b5EiqYXZz5qf1Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSX5LxiURPNKvKw1WYNRPfuj1NLeTJoPia9UD1FzPxn95AE1B+WO8OQ4PAQkT6Rs4fBAMuCgi+7YJdZfLPiJKdFM0mJ6GNAKLkCzPNIBelJZJGAND6/5ARmjDhNkOe9HHf43zYbahMs1LELmooLl360nw6YzD+TbSxtTlz/t4LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kY15xT+f; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428178fc07eso14730925e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722263715; x=1722868515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC73j++Su3zvm0+6kORe9wxatcZtt1vWWK6NmsrDrjM=;
        b=kY15xT+fYJWDA2t/smN5W55ceBpVWpE6v5YQ8DXnpHJtwRJj7bC/25X5hYM+j+oRGv
         s0wAf/L0EUYftlyKAlhFOrqWFSopfjsY6nfezzA4Np2h65EnZn1ba47jteBq7x0j8Bxm
         hmYBKDKORyFsMoHJQ8lxsZxvT642+FKQSTimpFvgDV6hKyC7zJTFhwr0yb27rlOb+pve
         6Oit1t1wDiRvM7KUVz3Ctd5v253lfA1G0BNVedKHx/m4rRHs3CKS+hZFrCAd6/QHKzqp
         0JwldjHw6dc5uHg6o3xQR6LbVR35umlNl5ijs827f7+9d0ycVZ3DS6IQIAdVJBHdgigc
         Lcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263715; x=1722868515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GC73j++Su3zvm0+6kORe9wxatcZtt1vWWK6NmsrDrjM=;
        b=L1oN3fAxbTGEhL9YCTxEGS1GP8zXscIv2BPtsVCtd4c1/I9mJm4A7Jc7gnawFkJAuP
         ruUeRdJNrUxjMYuk3zE2+/r1ePzPAJmZxyjKbSBa5drx80EuAZKYiJ7crTeJj3ec4vmf
         crzu/LNB6j0N00atC20Uz0dNaOJ07yvf4s6Lg4zt2qav/I7iD2vrtPXIyeM86jCIj6Vz
         NdNxU0vtzuFyre6hDI2awHr87mmpXDc9Sxuh8t55BcuaC13tni0pZ+jEZ3XYH5A8iStZ
         FUgp6F2VUlKAH181s9VWGzoy11F4rIJcwDUzzT2rEa1ERPNW7Tjjh5Xwk/JnduQDCHJC
         knYQ==
X-Gm-Message-State: AOJu0YzsmS97cFfWGAjehctNzfl//QC9syoY6yBIkNJ3H9JTgC5dlhnL
	S5PBbe9qC+RKsDDk+uyAjvG5mYSOHKbfQTZAR5gKOZeNf4n94h9HNSVJK96bb+Wt5rxTKSonv32
	P
X-Google-Smtp-Source: AGHT+IHgZC0PpiIuqgeg7cEtk9nWyi7qjTzgsvc4CbfqdtXoKLRkiBQ4VJUu/X5xC4EbFopCfhbVZg==
X-Received: by 2002:a05:600c:1c0a:b0:427:9dad:17df with SMTP id 5b1f17b1804b1-42811d89a06mr45793835e9.12.1722263715417;
        Mon, 29 Jul 2024 07:35:15 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:59dd:510e:47d0:643f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280ca10aa6sm129554865e9.26.2024.07.29.07.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:35:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v3 5/8] pwm: Add support for pwmchip devices for faster and easier userspace access
Date: Mon, 29 Jul 2024 16:34:21 +0200
Message-ID:  <e61728fdc9e3c80c4cf6961883754095b604a399.1722261050.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9598; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=eUKbTxtMbAkHYGH1VEMDL0Jsu864b5EiqYXZz5qf1Po=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmp6h53uAVBleB5DRIoVvTfqwbYPxBquuXaDyoW B2f47bwGRSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZqeoeQAKCRCPgPtYfRL+ Tu8cB/0dNui8488TfsRc0fwTagRv5GI54qDoeXt+CfGnoPWhWY/hSouFdHHaF8MoayJHowIeh7Z 7W++ZxpoeUiWlvvTOVgZuphLraMb+1sYvDXfpvMmW+Ngv3pgRYl1e4H+SA3afk68r1cC0BB6+Lb eoLQOQ4M0djR0UasNNIWQLgtA2GzraKhv/SX59WVRY3MBb+Bjv6O+koi6wFzMSFe2SbJL6WQTu+ qp1jfBW+e7H/ExfHASBWJ9VkGubDXHlMrI5UeHhd3n1bHS4ZotJ26ExgNe75fCdqMcsj3BnqgMq EUS+x15cD/SSb775t5MI2gHkN4LCw/m7RhYoWG1pX2fV4DPK
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
index 41e620944375..888cd4f51c6e 100644
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
+				.period_length_ns = cwf.period_length_ns,
+				.duty_length_ns = cwf.duty_length_ns,
+				.duty_offset_ns = cwf.duty_offset_ns,
+			};
+
+			ret = pwm_round_waveform_might_sleep(pwm, &wf);
+			if (ret)
+				return ret;
+
+			cwf = (struct pwmchip_waveform) {
+				.hwpwm = cwf.hwpwm,
+				.period_length_ns = wf.period_length_ns,
+				.duty_length_ns = wf.duty_length_ns,
+				.duty_offset_ns = wf.duty_offset_ns,
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
+			cwf.period_length_ns = wf.period_length_ns;
+			cwf.duty_length_ns = wf.duty_length_ns;
+			cwf.duty_offset_ns = wf.duty_offset_ns;
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
+			if (cwf.period_length_ns > 0 &&
+			    (cwf.duty_length_ns > cwf.period_length_ns ||
+			     cwf.duty_offset_ns >= cwf.period_length_ns))
+				return -EINVAL;
+
+			ret = pwm_cdev_request(cdata, cwf.hwpwm);
+			if (ret)
+				return ret;
+
+			pwm = cdata->pwm[cwf.hwpwm];
+
+			wf = (struct pwm_waveform){
+				.period_length_ns = cwf.period_length_ns,
+				.duty_length_ns = cwf.duty_length_ns,
+				.duty_offset_ns = cwf.duty_offset_ns,
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
index 40cef0bc0de7..b12ca9531e32 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
@@ -304,6 +305,7 @@ struct pwm_ops {
 /**
  * struct pwm_chip - abstract a PWM controller
  * @dev: device providing the PWMs
+ * @cdev: &struct cdev for this device
  * @ops: callbacks for this PWM controller
  * @owner: module providing this chip
  * @id: unique number of this PWM chip
@@ -318,6 +320,7 @@ struct pwm_ops {
  */
 struct pwm_chip {
 	struct device dev;
+	struct cdev cdev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	unsigned int id;
diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
new file mode 100644
index 000000000000..c89ba3e3def8
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
+	__u64 period_length_ns;
+	__u64 duty_length_ns;
+	__u64 duty_offset_ns;
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


