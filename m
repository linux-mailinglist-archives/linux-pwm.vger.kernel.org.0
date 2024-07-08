Return-Path: <linux-pwm+bounces-2723-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570BF92A08B
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 12:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8201F21887
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627187603A;
	Mon,  8 Jul 2024 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TCm9txWG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0977F2F
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435983; cv=none; b=iOnSV3hw5/CY6ueWHpNBXYxLpD4hGvTcJ34MKL5phLb5/vQMDmVYf42vd19PQ/UzM7T1qIHAKy9NAClBHw7E3q2mucQHcYf34vA9+s53ookWyZA7yw9iLhTOkw+kIR5Vmtc/x6xSdSZGOPTGGsSc+zRjxOobNS/m85O4aweq19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435983; c=relaxed/simple;
	bh=vAjtirpm0fIC21TuPksPdz4VyyIIfSUSAw59/NpCLGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxLdsVAjiTEm7zy5CYMkzqcR3WTnqKbN9FJlMQok83tlq+xbCGxdYp6mbZ9bp6B7+p1ebI3Tf3a1vbauJ4IL8Secu9MCGpVoQoHGMxDOS1O/Xq78GscQrJHg6llpCs7SeN91RW8tNR82YgOgmHBwIb+fyrRbBfRDPh3j338FegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TCm9txWG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3678aa359b7so2977709f8f.1
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720435979; x=1721040779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftNW5xrF5gjDjc1qKCd9tZDdz/xw5+OkVsLhAu2Y8rA=;
        b=TCm9txWGPX5E8xEwRSoWxCcVY/xXb3oOm/YaSaFf6wXilEWNoQZWVjcmQHev5XtMBZ
         1E9tjsSg54YYx0bzWshGYHkH0bdjtbIOcChflKDQciOoWgmosd7qtBpgtS845io5ZX5O
         pfkuzHi30Eifp+x3rRQoyNAtg1qPtQQ5waxWds8kDNKyFaGC+DXFcza2zcxgJ3cS5gxo
         5JOEVubnHStgXMZwqlsT8zHbnxT5FJ1AG5rMgYjr4gftoLyZ+2rzvpXXMrk6SFBwu+mO
         dZKrrbJN9GuSavef7w/Rwk8ISu5EFPVKym7BXCOldeDXWNuNlXn7gG2swDxg+OnGWIhF
         q3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435979; x=1721040779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftNW5xrF5gjDjc1qKCd9tZDdz/xw5+OkVsLhAu2Y8rA=;
        b=S9k4JFQiEP2SuSl9JnfY+ZQUw2CP2TFZZ9dxn68iHhLof3B+5PEbpSes9VPelyQTHR
         RcsBSL3QTNoUQOp3Kn4qh0JXiLiMAx1om5Y7x88HZMJnMLczkF6F9+Dt8S9OlapgMnE8
         5JAfsXCnrQuKa//N6Rphzm6Mk8MsCJLTwG+/3eUSjF4eKXwHgW1eCRmyH9wPI8K6f+rQ
         thEItH5VDBLKmVRJfFOm1xluz/06XzCpqxOPIuGrRejfCxPzySM0VmDDZ76nYnyoe1ek
         C9cDc9Ye1WHDj8AYHcScrY4op7BDHkPvJNcdSHmx39sdcQSkpXprfnoNytZJxKJqXF70
         Yo1A==
X-Gm-Message-State: AOJu0Yz3TkA75NQO8SHSAIPnUVAjPRg0IwSA3L3w46nZBl8ISSWtiSw3
	wj3qVOTmATqvhUA7syOJOcd0gOGmE+tneSnXy3mLDZmfWflewjFvsyR16WYWRGNU3a8Ozc36IQ1
	E
X-Google-Smtp-Source: AGHT+IFjKas8N0vNhEYaQxxRYkLsUWuOCvxDEnBDHd3zdWj/viRvhm3KFNWeDkAz8Lw0fYD+lyoxng==
X-Received: by 2002:a5d:4392:0:b0:360:9d2a:fe05 with SMTP id ffacd0b85a97d-3679f6f0ddbmr10710412f8f.13.1720435979527;
        Mon, 08 Jul 2024 03:52:59 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a1540508sm9991544f8f.66.2024.07.08.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:52:59 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 3/6] pwm: Add support for pwmchip devices for faster and easier userspace access
Date: Mon,  8 Jul 2024 12:52:29 +0200
Message-ID:  <7490e64bbe12e2046d92716dadef7070881592e6.1720435656.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13207; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vAjtirpm0fIC21TuPksPdz4VyyIIfSUSAw59/NpCLGQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmi8TzwQ6faZpE8fGJzI3j3caTxRf4iPUJ2LcJW 4zeeZfNe1OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZovE8wAKCRCPgPtYfRL+ TjlWCAC7frr3EErxOamfX96tlEoZ7LSteRaollnbO0DO5d/9+e7YwgnYMGtA4Z/1qTcFS5+0++7 tBQANYLqZsiQhEONGctgUb7z+YF15zMynPVPNjiaDvu/nxwdx06+mQi5jzWRuGm84fEy/rzR9io kI2mL/GPrjk8VYSxBD5VuCMEFxlacZo7DRku53WS6dDTLjWNBpOLyDzNVUjOFNT/jzqdnyT3srK Sz9Gql7xkdTGpZ6SIXUxmdK7vPaU/OpzlxX4Qv7jKZGlhyyQ0tH7pdhFWMXFUKI1UTRSoak7Iic YMNF8PRqaz/L4xScS9czgDIx2kCR9aFIyTI79dY/TWCxVsUA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With this change each pwmchip can be accessed from userspace via a
character device. Compared to the sysfs-API this is faster (on a
stm32mp157 applying a new configuration takes approx 25% only) and
allows to pass the whole configuration in a single ioctl allowing atomic
application.

Thanks to Randy Dunlap for pointing out a missing kernel-doc
description.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c       | 367 +++++++++++++++++++++++++++++++++++++--
 include/linux/pwm.h      |   3 +
 include/uapi/linux/pwm.h |  24 +++
 3 files changed, 379 insertions(+), 15 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 8e68481a7b33..d64c033c4cb2 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -23,6 +23,8 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#include <uapi/linux/pwm.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/pwm.h>
 
@@ -95,6 +97,29 @@ static void pwm_state2wf(const struct pwm_state *state, struct pwm_waveform *wf)
 	}
 }
 
+static int pwmwfcmp(const struct pwm_waveform *a, const struct pwm_waveform *b)
+{
+	if (a->period_length > b->period_length)
+		return 1;
+
+	if (a->period_length < b->period_length)
+		return -1;
+
+	if (a->duty_length > b->duty_length)
+		return 1;
+
+	if (a->duty_length < b->duty_length)
+		return -1;
+
+	if (a->duty_offset > b->duty_offset)
+		return 1;
+
+	if (a->duty_offset < b->duty_offset)
+		return -1;
+
+	return 0;
+}
+
 static int pwm_check_rounding(const struct pwm_waveform *wf,
 			      const struct pwm_waveform *wf_rounded)
 {
@@ -115,6 +140,127 @@ static int pwm_check_rounding(const struct pwm_waveform *wf,
 
 #define WFHWSIZE 20
 
+static int pwm_get_waveform(struct pwm_device *pwm,
+			    struct pwm_waveform *wf)
+{
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
+	char wfhw[WFHWSIZE];
+	int err;
+
+	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
+	err = ops->read_waveform(chip, pwm, &wfhw);
+	if (err)
+		return err;
+
+	return ops->round_waveform_fromhw(chip, pwm, &wfhw, wf);
+}
+
+/* Called with the pwmchip lock held */
+static int __pwm_set_waveform(struct pwm_device *pwm,
+			      const struct pwm_waveform *wf,
+			      bool exact)
+{
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
+	char wfhw[WFHWSIZE];
+	struct pwm_waveform wf_rounded;
+	int err;
+
+	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+
+	if (wf->period_length &&
+	    (wf->duty_length > wf->period_length ||
+	     wf->duty_offset >= wf->period_length))
+		return -EINVAL;
+
+	err = ops->round_waveform_tohw(chip, pwm, wf, &wfhw);
+	if (err)
+		return err;
+
+	if ((IS_ENABLED(CONFIG_PWM_DEBUG) || exact) && wf->period_length) {
+		err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
+		if (err)
+			return err;
+
+		if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm_check_rounding(wf, &wf_rounded))
+			dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
+				wf->duty_length, wf->period_length, wf->duty_offset,
+				wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
+
+		if (exact && pwmwfcmp(wf, &wf_rounded)) {
+			dev_dbg(&chip->dev, "Requested no rounding, but %llu/%llu [+%llu] -> %llu/%llu [+%llu]\n",
+				wf->duty_length, wf->period_length, wf->duty_offset,
+				wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
+
+			return 1;
+		}
+	}
+
+	err = ops->write_waveform(chip, pwm, &wfhw);
+	if (err)
+		return err;
+
+	/* update .state */
+	pwm_wf2state(wf, &pwm->state);
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ops->read_waveform && wf->period_length) {
+		struct pwm_waveform wf_set;
+
+		err = ops->read_waveform(chip, pwm, &wfhw);
+		if (err)
+			/* maybe ignore? */
+			return err;
+
+		err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_set);
+		if (err)
+			/* maybe ignore? */
+			return err;
+
+		if (pwmwfcmp(&wf_set, &wf_rounded) != 0)
+			dev_err(&chip->dev,
+				"Unexpected setting: requested %llu/%llu [+%llu], expected %llu/%llu [+%llu], set %llu/%llu [+%llu]\n",
+				wf->duty_length, wf->period_length, wf->duty_offset,
+				wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset,
+				wf_set.duty_length, wf_set.period_length, wf_set.duty_offset);
+	}
+	return 0;
+}
+
+static int pwm_set_waveform_might_sleep(struct pwm_device *pwm,
+					struct pwm_waveform *wf, bool exact)
+{
+	struct pwm_chip *chip = pwm->chip;
+	int err;
+
+	might_sleep();
+
+	guard(pwmchip)(chip);
+
+        if (!chip->operational)
+                return -ENODEV;
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
+		/*
+		 * Catch any drivers that have been marked as atomic but
+		 * that will sleep anyway.
+		 */
+		non_block_start();
+		err = __pwm_set_waveform(pwm, wf, exact);
+		non_block_end();
+	} else {
+		err = __pwm_set_waveform(pwm, wf, exact);
+	}
+
+	return err;
+}
+
 static void pwm_apply_debug(struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -301,19 +447,6 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 		if (err)
 			return err;
 
-		if (IS_ENABLED(PWM_DEBUG)) {
-			struct pwm_waveform wf_rounded;
-
-			err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
-			if (err)
-				return err;
-
-			if (pwm_check_rounding(&wf, &wf_rounded))
-				dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
-					wf.duty_length, wf.period_length, wf.duty_offset,
-					wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
-		}
-
 		err = ops->write_waveform(chip, pwm, &wfhw);
 		if (err)
 			return err;
@@ -1296,6 +1429,197 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
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
+
+	case PWM_IOCTL_GETWF:
+		{
+			struct pwmchip_waveform cwf;
+			struct pwm_waveform wf;
+			struct pwm_device *pwm;
+
+			ret = copy_from_user(&cwf, (struct pwmchip_waveform __user *)arg, sizeof(cwf));
+			if (ret)
+				return -EFAULT;
+
+			ret = pwm_cdev_request(cdata, cwf.hwpwm);
+			if (ret)
+				return ret;
+
+			pwm = cdata->pwm[cwf.hwpwm];
+
+			ret = pwm_get_waveform(pwm, &wf);
+			if (ret)
+				return ret;
+
+			cwf.period_length = wf.period_length;
+			cwf.duty_length = wf.duty_length;
+			cwf.duty_offset = wf.duty_offset;
+
+			return copy_to_user((struct pwmchip_waveform __user *)arg, &cwf, sizeof(cwf));
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
+			ret = copy_from_user(&cwf, (struct pwmchip_waveform __user *)arg, sizeof(cwf));
+			if (ret)
+				return -EFAULT;
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
+			return pwm_set_waveform_might_sleep(pwm, &wf, cmd == PWM_IOCTL_SETEXACTWF);
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
@@ -1348,7 +1672,13 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
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
 
@@ -1399,7 +1729,7 @@ void pwmchip_remove(struct pwm_chip *chip)
 		idr_remove(&pwm_chips, chip->id);
 	}
 
-	device_del(&chip->dev);
+	cdev_device_del(&chip->cdev, &chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
@@ -1943,9 +2273,16 @@ static int __init pwm_init(void)
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
index b5dff2a99038..3e503a28f5f7 100644
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
index 000000000000..1ecf2e033b62
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
+	unsigned int hwpwm;
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


