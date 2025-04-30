Return-Path: <linux-pwm+bounces-5787-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9844AA4A70
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 13:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B213A9EED
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BB25B1C6;
	Wed, 30 Apr 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QPHQsRNg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3C25A343
	for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014190; cv=none; b=TNrPaVKju0Zhw2xIwgMBSx5KAGOMewxP3H42R5/5++sxiYgW2w86b3vI1bFZYt3wo1A9Ri9BIBBVDBnSCDekZF68lyUtlq67md4b8rfLztLqrsxa13M9yrDt29MtDy+AIA8UvmqilNBmkDoFOiBktBlrvrObaTtxMWAh6ekBc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014190; c=relaxed/simple;
	bh=cqvKQHdAO2SdKfRDdtiMA0uxReCOqHxryeY4lOytsDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7WwUR42+CA/xgnPkF+szOBzUIX1kKykKG2tyflpHI/B5M4bNHibYYCR8q5LR+61HuG0rnB56llhvVizvNDbmWzTOMFdR1bnW7WbK14L9NNhmfdGAEc3+kx88VrAVZad6K2L53o2iauip07DoYUFuW8i8rRUBimLZpgZVHXm4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QPHQsRNg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so64745095e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 30 Apr 2025 04:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746014187; x=1746618987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmGLOEXfezbIO4+3KuQiv1vH3EfZhxIl0cjhvPP2kMk=;
        b=QPHQsRNg/5lKYGth7X5tnVJ8Pz738sPrBWivyR+lU6NrcILR8jc+2vmjgxs04xBbDV
         vx+c0J0vBCSq1euu/oTzHYi2PDX7aRT0sjHdd5VTLY2s+SmOR+McRoaLZD/+EYfJAapq
         ENHqK2dFqLAVvVRhLH6RbQu8GVex0G6zSpvAn/AOHCfdc36YADVaWJesFsLibYHq1gHg
         3dKJgQic9KIHFyRhmi1STP3gK+kf9Cb3ZdWB2TprabhIas937dHZdX2oTwcug/0dKOA8
         YnKfOZQigz0U1XTBaFKSYCg9lcSYWJl7Q6lowpmluzKwrWLWZn4om+IKZcnG5aiwMZxZ
         VPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746014187; x=1746618987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmGLOEXfezbIO4+3KuQiv1vH3EfZhxIl0cjhvPP2kMk=;
        b=IlCmMieWYEYYUm4SoN3vLX55j3fUkOJZXF0XzYPZO7cgeesgNawsCsHP98OUJis4AW
         CzB/PjfYnKTwFsl6g8TznKk3C2w4lBDGAMDt/Mcl4A/YAzz0S0abUZP1f7HrdWe0X2e7
         2X12D45YeBsCf2PLp95gOAevQRRXkC4ruBPc6TN2zbrg8tcZYVy5VMZJdXmWL2mi7SWB
         HYphYlr9Li49KOBdldLWz4DSm67Thrl/A69DNTUfcjVeCXqHKQNz0wg2JArLpvvHJiS5
         8iHd5J9f4rZNINzDBQJIPoYNjjCXqNgzUXNWUfBP4w6pM9z1PLn3izTBlixv80HYiaSa
         vYfg==
X-Gm-Message-State: AOJu0YyhG+2Ksm/Vi3hM2l25fqtrnY7Az84z+FTjc7hL0rEwyUn107l9
	Z1UYvKG6mQBdbRTNJT1Haw2Ua5NZilxTJ7NsFIEcQPYgycqyjSfDGyQHOsBssp1N/rql4KhDwm6
	7
X-Gm-Gg: ASbGnctqz+c9mJ1CxeH+kaj/O9egNoTJrnfuw4W8A9xPfjIIfSl2hCAS72fC2EwPnOh
	tTPVf2PBVCfskIgQFejrnN6r64gPbl90j2ZVTnz3Ec3yXufQF9Fuo0SLI40GkDQHno5EwKNSJYa
	qSum2LyThrGytEDtVTJcHuNVBJc78VGsfkhWaKKJ96Y/Mor7gz+MHwqJg0VlkFnA05DPhyRqEmR
	YeTSWHDWaquf/VGRSFu12LCla1L18ZYt8ZEdOtH2bBQUEoarB/2jd8YRaipJvEe3PkZyBzzyAHL
	F0HqPBWBeBj/KiBVV5e9Rf9wEQvIQEYtE/DvjxUeGFGtRG76BXHUlHNHYVptdL/g00NhuQ6qW5B
	HtEIYF463xj6q1jvAZg==
X-Google-Smtp-Source: AGHT+IEq81+UUX91nuldUGV4F0sX+gzDsrOqf3/ocm8GPyNEKZSiVCgcAXj3r97AqrRNHEpumkNoFA==
X-Received: by 2002:a05:600c:c0cb:b0:441:b4b9:4965 with SMTP id 5b1f17b1804b1-441b4b949c7mr6786535e9.11.1746014186752;
        Wed, 30 Apr 2025 04:56:26 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2b97262sm23063255e9.4.2025.04.30.04.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 04:56:26 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] pwm: Add support for pwmchip devices for faster and easier userspace access
Date: Wed, 30 Apr 2025 13:56:01 +0200
Message-ID:  <ad4a4e49ae3f8ea81e23cac1ac12b338c3bf5c5b.1746010245.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
References: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12756; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=cqvKQHdAO2SdKfRDdtiMA0uxReCOqHxryeY4lOytsDY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoEg/aLHzVbBej5fyrPNooBdntT4CFFEQuGad25 pSgiOmKxtWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaBIP2gAKCRCPgPtYfRL+ TrV3B/0Zo3Kn5C9MWrDqOj8ZGcWihAWGWXvxVh1tsV8BY/esIPoV4XqU4nGVqLpqTW9YsfLMO5a QhY6Lq7qQOS1c9gWcwxpZ3dQK7/ZlrAZzlXRrRObc0YW5dX+r9rvGPexp6q7kGDGAknzx2NxPXU CnjQUNEo+kyPGJYalm2aYCsd/2819+SX8sPE/uajz1j9pYEFFdSvOBW4x+JOs/i1vfsgrRwve0w jMbwDqW8Xdfxn52zdLzrC8AqwVq4VMx/KqFhxtNEPZMq4CtBZKTPwn3WYlKaChjGIpLSEHESy9Q dyiEMNWGFdcR1C5QzANiTnF9qOoS01J3DdVdS5Ad1Wzz/z+T
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With this change each pwmchip defining the new-style waveform callbacks
can be accessed from userspace via a character device. Compared to the
sysfs-API this is faster and allows to pass the whole configuration in a
single ioctl allowing atomic application and thus reducing glitches.

On an STM32MP13 I see:

	root@DistroKit:~ time pwmtestperf
	real	0m 1.27s
	user	0m 0.02s
	sys	0m 1.21s
	root@DistroKit:~ rm /dev/pwmchip0
	root@DistroKit:~ time pwmtestperf
	real	0m 3.61s
	user	0m 0.27s
	sys	0m 3.26s

pwmtestperf does essentially:

	for i in 0 .. 50000:
		pwm_set_waveform(duty_length_ns=i, period_length_ns=50000, duty_offset_ns=0)

and in the presence of /dev/pwmchip0 is uses the ioctls introduced here,
without that device it uses /sys/class/pwm/pwmchip0.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c       | 322 +++++++++++++++++++++++++++++++++++++--
 include/linux/pwm.h      |   3 +
 include/uapi/linux/pwm.h |  53 +++++++
 3 files changed, 363 insertions(+), 15 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4d842c692194..b86f06ab2a32 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -23,9 +23,13 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#include <uapi/linux/pwm.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
+#define PWM_MINOR_COUNT 256
+
 /* protects access to pwm_chips */
 static DEFINE_MUTEX(pwm_lock);
 
@@ -2007,20 +2011,9 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 }
 EXPORT_SYMBOL_GPL(pwm_get);
 
-/**
- * pwm_put() - release a PWM device
- * @pwm: PWM device
- */
-void pwm_put(struct pwm_device *pwm)
+static void __pwm_put(struct pwm_device *pwm)
 {
-	struct pwm_chip *chip;
-
-	if (!pwm)
-		return;
-
-	chip = pwm->chip;
-
-	guard(mutex)(&pwm_lock);
+	struct pwm_chip *chip = pwm->chip;
 
 	/*
 	 * Trigger a warning if a consumer called pwm_put() twice.
@@ -2041,6 +2034,20 @@ void pwm_put(struct pwm_device *pwm)
 
 	module_put(chip->owner);
 }
+
+/**
+ * pwm_put() - release a PWM device
+ * @pwm: PWM device
+ */
+void pwm_put(struct pwm_device *pwm)
+{
+	if (!pwm)
+		return;
+
+	guard(mutex)(&pwm_lock);
+
+	__pwm_put(pwm);
+}
 EXPORT_SYMBOL_GPL(pwm_put);
 
 static void devm_pwm_release(void *pwm)
@@ -2110,6 +2117,274 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_fwnode_pwm_get);
 
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
+		struct pwm_device *pwm = cdata->pwm[i];
+
+		if (pwm) {
+			const char *label = pwm->label;
+
+			pwm_put(cdata->pwm[i]);
+			kfree(label);
+		}
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
+		const char *label;
+		int ret;
+
+		label = kasprintf(GFP_KERNEL, "pwm-cdev (pid=%d)", current->pid);
+		if (!label)
+			return -ENOMEM;
+
+		ret = pwm_device_request(pwm, label);
+		if (ret < 0) {
+			kfree(label);
+			return ret;
+		}
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
+		const char *label = pwm->label;
+
+		__pwm_put(pwm);
+
+		kfree(label);
+
+		cdata->pwm[hwpwm] = NULL;
+	}
+
+	return 0;
+}
+
+static struct pwm_device *pwm_cdev_get_requested_pwm(struct pwm_cdev_data *cdata,
+						     u32 hwpwm)
+{
+	struct pwm_chip *chip = cdata->chip;
+
+	if (hwpwm >= chip->npwm)
+		return ERR_PTR(-EINVAL);
+
+	if (cdata->pwm[hwpwm])
+		return cdata->pwm[hwpwm];
+
+	return ERR_PTR(-EINVAL);
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
+			unsigned int hwpwm = arg;
+
+			return pwm_cdev_request(cdata, hwpwm);
+		}
+
+	case PWM_IOCTL_FREE:
+		{
+			unsigned int hwpwm = arg;
+
+			return pwm_cdev_free(cdata, hwpwm);
+		}
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
+			pwm = pwm_cdev_get_requested_pwm(cdata, cwf.hwpwm);
+			if (IS_ERR(pwm))
+				return PTR_ERR(pwm);
+
+			wf = (struct pwm_waveform) {
+				.period_length_ns = cwf.period_length_ns,
+				.duty_length_ns = cwf.duty_length_ns,
+				.duty_offset_ns = cwf.duty_offset_ns,
+			};
+
+			ret = pwm_round_waveform_might_sleep(pwm, &wf);
+			if (ret < 0)
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
+			if (cwf.__pad != 0)
+				return -EINVAL;
+
+			pwm = pwm_cdev_get_requested_pwm(cdata, cwf.hwpwm);
+			if (IS_ERR(pwm))
+				return PTR_ERR(pwm);
+
+			ret = pwm_get_waveform_might_sleep(pwm, &wf);
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
+
+			if (cwf.__pad != 0)
+				return -EINVAL;
+
+			wf = (struct pwm_waveform){
+				.period_length_ns = cwf.period_length_ns,
+				.duty_length_ns = cwf.duty_length_ns,
+				.duty_offset_ns = cwf.duty_offset_ns,
+			};
+
+			if (!pwm_wf_valid(&wf))
+				return -EINVAL;
+
+			pwm = pwm_cdev_get_requested_pwm(cdata, cwf.hwpwm);
+			if (IS_ERR(pwm))
+				return PTR_ERR(pwm);
+
+			ret = pwm_set_waveform_might_sleep(pwm, &wf,
+							   cmd == PWM_IOCTL_SETEXACTWF);
+
+			/*
+			 * If userspace cares about rounding deviations it has
+			 * to check the values anyhow, so simplify handling for
+			 * them and don't signal uprounding. This matches the
+			 * behaviour of PWM_IOCTL_ROUNDWF which also returns 0
+			 * in that case.
+			 */
+			if (ret == 1)
+				ret = 0;
+
+			return ret;
+		}
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
+	.unlocked_ioctl = pwm_cdev_ioctl,
+};
+
+static dev_t pwm_devt;
+
 /**
  * __pwmchip_add() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -2162,7 +2437,17 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	scoped_guard(pwmchip, chip)
 		chip->operational = true;
 
-	ret = device_add(&chip->dev);
+	if (chip->ops->write_waveform) {
+		if (chip->id < PWM_MINOR_COUNT)
+			chip->dev.devt = MKDEV(MAJOR(pwm_devt), chip->id);
+		else
+			dev_warn(&chip->dev, "chip id too high to create a chardev\n");
+	}
+
+	cdev_init(&chip->cdev, &pwm_cdev_fileops);
+	chip->cdev.owner = owner;
+
+	ret = cdev_device_add(&chip->cdev, &chip->dev);
 	if (ret)
 		goto err_device_add;
 
@@ -2213,7 +2498,7 @@ void pwmchip_remove(struct pwm_chip *chip)
 		idr_remove(&pwm_chips, chip->id);
 	}
 
-	device_del(&chip->dev);
+	cdev_device_del(&chip->cdev, &chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -2357,9 +2642,16 @@ static int __init pwm_init(void)
 {
 	int ret;
 
+	ret = alloc_chrdev_region(&pwm_devt, 0, PWM_MINOR_COUNT, "pwm");
+	if (ret) {
+		pr_err("Failed to initialize chrdev region for PWM usage\n");
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
index 63a17d2b4ec8..2492c91452f9 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
@@ -311,6 +312,7 @@ struct pwm_ops {
 /**
  * struct pwm_chip - abstract a PWM controller
  * @dev: device providing the PWMs
+ * @cdev: &struct cdev for this device
  * @ops: callbacks for this PWM controller
  * @owner: module providing this chip
  * @id: unique number of this PWM chip
@@ -325,6 +327,7 @@ struct pwm_ops {
  */
 struct pwm_chip {
 	struct device dev;
+	struct cdev cdev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	unsigned int id;
diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
new file mode 100644
index 000000000000..182d59cc07ee
--- /dev/null
+++ b/include/uapi/linux/pwm.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+
+#ifndef _UAPI_PWM_H_
+#define _UAPI_PWM_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct pwmchip_waveform - Describe a PWM waveform for a pwm_chip's PWM channel
+ * @hwpwm: per-chip relative index of the PWM device
+ * @__pad: padding, must be zero
+ * @period_length_ns: duration of the repeating period.
+ *    A value of 0 represents a disabled PWM.
+ * @duty_length_ns: duration of the active part in each period
+ * @duty_offset_ns: offset of the rising edge from a period's start
+ */
+struct pwmchip_waveform {
+	__u32 hwpwm;
+	__u32 __pad;
+	__u64 period_length_ns;
+	__u64 duty_length_ns;
+	__u64 duty_offset_ns;
+};
+
+/* Reserves the passed hwpwm for exclusive control. */
+#define PWM_IOCTL_REQUEST	_IO(0x75, 1)
+
+/* counter part to PWM_IOCTL_REQUEST */
+#define PWM_IOCTL_FREE		_IO(0x75, 2)
+
+/*
+ * Modifies the passed wf according to hardware constraints. All parameters are
+ * rounded down to the next possible value, unless there is no such value, then
+ * values are rounded up. Note that zero isn't considered for rounding down
+ * period_length_ns.
+ */
+#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
+
+/* Get the currently implemented waveform */
+#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
+
+/* Like PWM_IOCTL_ROUNDWF + PWM_IOCTL_SETEXACTWF in one go. */
+#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
+
+/*
+ * Program the PWM to emit exactly the passed waveform, subject only to rounding
+ * down each value less than 1 ns. Returns 0 on success, -EDOM if the waveform
+ * cannot be implemented exactly, or other negative error codes.
+ */
+#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
+
+#endif /* _UAPI_PWM_H_ */
-- 
2.47.2


