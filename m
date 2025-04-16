Return-Path: <linux-pwm+bounces-5529-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337CBA8B5D3
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 11:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0951905AD2
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B3D2356B7;
	Wed, 16 Apr 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="blUwJZhY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6C22A4FC
	for <linux-pwm@vger.kernel.org>; Wed, 16 Apr 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796619; cv=none; b=WKz0qCDPar1WEx7AZol39oNb1u2O1pSuCbjlxYe5cvVvcxPp3dOrVNGFUVD+9RS/QYcNtDFjOrAJKQIdmQ2mw+xzLyT1DtE3i/AMLM+QWcfdWRGDKkLBp4Qr9ihnzTD0ku5Fuko4FwUMQrWwHZ+mVLybnU6GIhEoD76r0/2ymTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796619; c=relaxed/simple;
	bh=Q49LlS76mWLHtQ3wHw/33L3bXOGBz3gKzqmorggHTRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CF9uZw6ZUFrgWa6GOX4A0SD6ZPst7g0ugRQCw36teiI/a4rMu08azgFmzoBTXjk7zTSTv5k8sTwY6UOZv6hFIHQVoDQHCile1y/NPGTZTf37DVWf5cJckG4k764dO8taXcKWl7cEZG2LRpWTYRZ9Hi04A/3AX4rk35I3M6Y1lLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=blUwJZhY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so70643865e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 16 Apr 2025 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744796614; x=1745401414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqvJVyPIMifp+L9Jbkyovbd4b4uf12bZJj7r8aFXPxY=;
        b=blUwJZhYp7ZU3r7eBvtFPGuy6hn9FpwdmR54zbqdGAu26JMYIJaxXgHnJaXMUW/EPe
         A+d6vGh7cf3qk3oWPi+tTau/wjuanMe1tsiU8g/UmIcRD+zmob0dfanPy3gOtOKtbknH
         xi5Nk0JpWfwqY6/EeUTuZPF++P3k0ymyJ3l6Ka5EyoU3DDnxgGnuDc4yqO4XeEkhRjpm
         eQmXEIcYLMm2B4vLY7D+4CULHBn3N5dMqTHgoFZ1AIX+l5A80AtBYGgAtqn2AcpjD4ak
         0oCxVxMRMg7M52hGDqeZ87dpoD53IPmYCDR28zkK2ZuqyQVV/g7W4LllL8mv/W+Pkj4w
         C0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744796614; x=1745401414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqvJVyPIMifp+L9Jbkyovbd4b4uf12bZJj7r8aFXPxY=;
        b=SxKqCAYVCaT0mEV1S9CYBUM7i+qfT/YCnL7jyeKpAmkzCsOBqQ0utwtrlLsTJisS2L
         F99LJliKaxWzUkzXNMtZzUNCh6oSC6OyIpO3uag4aJ9fgvIHyD5KZsrSIhkVk1XjXlj5
         b7Rjdd40yndr5rreJs7tmy43EYgAxSw96jd5h05HuG9ySn8Db6pT8N619nkpcep9Pf40
         qcbn8rMUgPjF1zpthNvurKcOXRPgG/MQ0q/6+QgIzYSm/Ykpzn1/a6W6T1zwRyJuWRz7
         7zMvqn9d6LklkiC7XBD7Eukg+yeERHpZ10odf77UL54IsudJeLxcvOUIp9VQnVwH0FNq
         Ninw==
X-Gm-Message-State: AOJu0YwxEwYUbwP/7eX0qULT8YE0PQcSwxaBbOeVtv5O712m2hecPnnO
	xIRF5txY9ckg3d3zs6HqRosDqhNUAsnzMWCZoJogeWz3S0sQltUN88TvLMVThF0v6SsMYbkM1sa
	2K3A=
X-Gm-Gg: ASbGnctEMALCRgaiV/f6Dj+jKQIh+9C16wK8WQNj4FkwVXRqRokscoEBVfn0vCZLjbx
	TK8qmkC1XdQ1OEeZb1E3i/uFoZqHqX8zQf1UPh7JdMSo1NX5ys9oefYALmwmcijeq0MBwAhBRlo
	hYbeHy0/GTMyCta5jE+gYpCtSjUAi+ZQ2Jq+9waSgujrCtT8CTHsPFmBVZL7SImZNPKNmoe0yog
	Rfs//t3zkFc8eOdyYgGl7v9P429ag76jumfx8wnuo1blR7XJcNyzvwWm45E5yJUnlk/QlAuXr34
	ZFEGCZ7To5px+Tu4cnJwhPLTokTGvyHt0z5PQHiIUuhnPybFm03Z0LSwq1bdnUUPsBPvCZCGexQ
	iBf+ovcI=
X-Google-Smtp-Source: AGHT+IF9VOTbI8rewLsrEIse8WGwEqSVS1VVUWxxEF1JCIjPCuXUwb+2q8TEsZh9/rAoaHWj8fPQkQ==
X-Received: by 2002:a05:6000:40c7:b0:398:fd9b:b935 with SMTP id ffacd0b85a97d-39ee5b9ff8fmr1150338f8f.53.1744796613718;
        Wed, 16 Apr 2025 02:43:33 -0700 (PDT)
Received: from localhost (p200300f65f13aa0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:aa04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39eaf4457a6sm16839825f8f.98.2025.04.16.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:43:33 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7] pwm: Add support for pwmchip devices for faster and easier userspace access
Date: Wed, 16 Apr 2025 11:43:16 +0200
Message-ID: <20250416094316.2494767-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13682; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Q49LlS76mWLHtQ3wHw/33L3bXOGBz3gKzqmorggHTRk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn/3u0CCHIxGfO9EHFKqLWqzg6zvMYGUjwED7NY beQMRJODWGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ/97tAAKCRCPgPtYfRL+ TgQ8B/99hpFbKIXmdUK4W8qQ4vLMH6UboKaLUaUuNRPMyvAj+aEtfJ/lSoW1f0/3ji8h47VqVdn +WurP9NyB9d6CHSSJqbgICKAKigoC7+5LWEMhzUBA4dF5R/wpLRxkW+4N3LddCuel/edtqU64Du KMVtWtUEVkOtGHLDJsdVmCBsfAktRlvycVClw4smhv4qv2N7T2dBHg66mirvTJB43dne1eMcjEZ Sv+XGeXt4hSetfyfJd0uCvP8C0vcU9l5iuuAqWl3aAu+efXMxtCiOCwA4GGzSJ7MbVsrlvnU0+7 5hju2DIYVZdHH41eQ1R5N3amlAu+2xdKduoK84mfpBj3xrIS
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
Changes since v6
(https://lore.kernel.org/linux-pwm/cover.1744120697.git.ukleinek@kernel.org/):
 - Trivially rebase to current pwm/for-next
 - Improve error handling and reporting for too high pwmchip ids
 - Plug a memory leak
 - Drop unneeded breaks in ioctl function
 - Documentation updates
 - Update commit log with recent performance measurement
 - After some thinking and internal discussion with David, let
   PWM_IOCTL_SETEXACTWF return 1 instead of a negative errno when the
   exact waveform cannot be implemented. The motivation is that this
   situation should be reliably distinguishable from other errors.

Thanks to David for his feedback.

Best regards
Uwe

 drivers/pwm/core.c       | 324 +++++++++++++++++++++++++++++++++++++--
 include/linux/pwm.h      |   3 +
 include/uapi/linux/pwm.h |  53 +++++++
 3 files changed, 365 insertions(+), 15 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index cec325bdffa5..780f401fe380 100644
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
 
@@ -1960,20 +1964,9 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
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
@@ -1994,6 +1987,20 @@ void pwm_put(struct pwm_device *pwm)
 
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
@@ -2063,6 +2070,276 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
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
+			 * For PWM_IOCTL_SETEXACTWF the return value might be 1
+			 * to signal failure in a way that is distinguishable
+			 * from other errors.
+			 */
+			if (cmd == PWM_IOCTL_SETROUNDEDWF && ret == 1)
+				return 0;
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
@@ -2115,7 +2392,17 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
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
 
@@ -2166,7 +2453,7 @@ void pwmchip_remove(struct pwm_chip *chip)
 		idr_remove(&pwm_chips, chip->id);
 	}
 
-	device_del(&chip->dev);
+	cdev_device_del(&chip->cdev, &chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -2310,9 +2597,16 @@ static int __init pwm_init(void)
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
index bf0469b2201d..d8817afe95dc 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_PWM_H
 #define __LINUX_PWM_H
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
@@ -309,6 +310,7 @@ struct pwm_ops {
 /**
  * struct pwm_chip - abstract a PWM controller
  * @dev: device providing the PWMs
+ * @cdev: &struct cdev for this device
  * @ops: callbacks for this PWM controller
  * @owner: module providing this chip
  * @id: unique number of this PWM chip
@@ -323,6 +325,7 @@ struct pwm_ops {
  */
 struct pwm_chip {
 	struct device dev;
+	struct cdev cdev;
 	const struct pwm_ops *ops;
 	struct module *owner;
 	unsigned int id;
diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
new file mode 100644
index 000000000000..1c3dc7a32e2e
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
+ * down each value less than 1 ns. Returns 0 on success, 1 if the waveform
+ * cannot be implemented exactly, or other negative error codes.
+ */
+#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
+
+#endif /* _UAPI_PWM_H_ */

base-commit: bde5547f2e87e6c71db79dc41e56aff3061e39a9
-- 
2.47.2

