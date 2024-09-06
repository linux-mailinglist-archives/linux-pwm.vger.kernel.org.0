Return-Path: <linux-pwm+bounces-3132-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015B696F885
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BA21F219B3
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E41D1F60;
	Fri,  6 Sep 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m/JmY9wN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6981D2F65
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637420; cv=none; b=OGZWYuPCOqBmuhngoO0YFJ/kzRkMEGaq9dsESn9PwaniIkKfva57ndqRmvHFHJgqm+gdPYRb4S4TeBz86MQbXU8QuG/B16VIThz7X130ipOtGhSx/JiqSrlhAcabxSQ96rlOizXSea4mtN6S+pxC+9SAZLCMij3gIknalc63N8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637420; c=relaxed/simple;
	bh=1+UgVgx1qhTzZi1feD5wI2qQhA+Jv6DPEStkH5+XFrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS7X4LlnEkIwPNmKBjFPIf9Vyv2T6ygAQAdVdt1dEdbeEN69ysfaJgGFFmkhzq8o7UDrxAM5LK2Ug8LMKNKryexeMRJM3hN0cpp+hQwQsZfZK5hfCpfZBHcNaM9C2VZcZNC5/PNFZg3dIpuR/L+19G4HgJ6PKSVP48FjKw7/H40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=m/JmY9wN; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso30561501fa.2
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725637416; x=1726242216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n2RMN+I4vtbcBYZHpZs5IMjkfWDjfHruPM54Nwp9ac=;
        b=m/JmY9wNtz5TnBWn/WXcP4M9BnwDc87GJds4Lh1HfYVjDZrILFqAMAU4nklyYNGXfk
         deQ24ngzkON3wlEymd+gsqtKYWqPaa6zPB/9KKhT0Iyks/5yNSMIM+KrDyNOvuQu/EbY
         F/xbRhr8SfpBPZGhBpbT5xLEDmwBzKel+/5zc0lAdY0dGu9dvC8qmAME3NbFU2er4Mc7
         Z55puyck+BpImK7PuYoBwgLNem8gLRL8H83Am9cAgFSRi6hV7Z2zVwJGCuU+9JBDaVtm
         JI2K7MvLyvJvciRZ3HYRp3JDxByBRwJ0TynqdG7g4uL9/dp9OGLmSdCBuM+bQxTUwr9+
         KA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637416; x=1726242216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1n2RMN+I4vtbcBYZHpZs5IMjkfWDjfHruPM54Nwp9ac=;
        b=bEEpnNmZGN4jaidZ2uQ8htttSny1jSw0yojhVbkGfvu2RjuW21jHBRNmueMQsvoyVL
         5QxgM68N2omC0d6QazSqD+KSuBPHpFOsaPuNW0KG00wZztrY1WcSYtRuz0aoY9/LRYwI
         CScTVrG04kHYnS5rwHllowty+nNK+fRmiSrfw9fShxAhhMNF1gzbNU41j750NUbSQ3yq
         LWGR0D5t0eZK1RmKP0tei4a65Q3X5Wtp5P2FN+O2Hc8mxyb5DcF9en3czeQssodsNzeY
         pk+MeXZOIzX6EP4TI1BjhIXSQfWUgD6/gPVg/sbmNN8FYONgGqjgojXOMQ/VcWVxKMYn
         WCIQ==
X-Gm-Message-State: AOJu0Yxbrb1EXxKh88dHzFsAE6Fd9qJdGUiDDmZPYbCrScT3ZcmksJB1
	ipvOTuKDSkv9KPpVLtscroGTccq4ybFVCIHjoZG7w5/CdIwXdi+ZOMV0u68LlndTgh+bjZNmEHY
	9
X-Google-Smtp-Source: AGHT+IHemKvQNjyT1+8YgL5GlSf/otEShvBYKHpKN5d6yUNvqC3fYz8IKTYWkjR9rP5lzjhzmA7+GQ==
X-Received: by 2002:a2e:4c19:0:b0:2f2:a1f1:39ed with SMTP id 38308e7fff4ca-2f6108af59dmr165597561fa.48.1725637416353;
        Fri, 06 Sep 2024 08:43:36 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a7c504701sm182670966b.25.2024.09.06.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:43:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Kent Gibson <warthog618@gmail.com>,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 4/7] pwm: Add support for pwmchip devices for faster and easier userspace access
Date: Fri,  6 Sep 2024 17:43:00 +0200
Message-ID:  <00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9480; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=1+UgVgx1qhTzZi1feD5wI2qQhA+Jv6DPEStkH5+XFrA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm2yMMqDfWx53KdTyD/qaH7tdF983jVEB8nlVbh nws3NJW/BGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZtsjDAAKCRCPgPtYfRL+ ToNcB/9JufIAH2XKE9tsl2Yj6eVC98/Tgl45+Ijx7thfBZwYo7kTEjZjloMe0zOjFTKt67Ck1n7 LOiWJO/o6AzaXuMjgwrRywZPO92tL2vChssDGkJrgjfLNmjihUSm/YVDFSod57gznqmomeybEF0 /Md+YY2OGw19ZRA0r3BiWSmt/fbJwzxqE56zLBrrwn/k2dG+oZUckx3McYujr27mnPjSpBkvhKa hv5A2rEU4z/Zhazn+sw4SqRvUssmW4iSruXTIeM993YBfPmBDY5x7BVIr0fL6ZSoKi0yCcipvHP B6upyVV4joui06gV5DtiAvyRVUYGc+Ghu6BR8gjDNpWoIBMI
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With this change each pwmchip defining the new-style waveform callbacks
can be accessed from userspace via a character device. Compared to the
sysfs-API this is faster (on a stm32mp157 applying a new configuration
takes approx 25% only) and allows to pass the whole configuration in a
single ioctl allowing atomic application.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c       | 267 ++++++++++++++++++++++++++++++++++++++-
 include/linux/pwm.h      |   3 +
 include/uapi/linux/pwm.h |  24 ++++
 3 files changed, 292 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c7f39f9f4bcf..16615a4673ef 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -23,6 +23,8 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#include <uapi/linux/pwm.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
@@ -1594,6 +1596,254 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
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
@@ -1646,7 +1896,13 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
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
 
@@ -1697,7 +1953,7 @@ void pwmchip_remove(struct pwm_chip *chip)
 		idr_remove(&pwm_chips, chip->id);
 	}
 
-	device_del(&chip->dev);
+	cdev_device_del(&chip->cdev, &chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -2241,9 +2497,16 @@ static int __init pwm_init(void)
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
index 000000000000..ed127a80afbf
--- /dev/null
+++ b/include/uapi/linux/pwm.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+
+#ifndef _UAPI_PWM_H_
+#define _UAPI_PWM_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+struct pwmchip_waveform {
+	__u32 hwpwm;
+	__u32 __pad; /* padding, must be zero */
+	__u64 period_length_ns;
+	__u64 duty_length_ns;
+	__u64 duty_offset_ns;
+};
+
+#define PWM_IOCTL_REQUEST	_IOW(0x75, 1, unsigned int)
+#define PWM_IOCTL_FREE		_IOW(0x75, 2, unsigned int)
+#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
+#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
+#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
+#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
+
+#endif /* _UAPI_PWM_H_ */
-- 
2.45.2


