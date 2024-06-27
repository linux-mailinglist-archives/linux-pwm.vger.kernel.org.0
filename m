Return-Path: <linux-pwm+bounces-2631-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF9F91B06D
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 22:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56FF285C8F
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 20:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8FD19DF95;
	Thu, 27 Jun 2024 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vFIz+r78"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2C19DF9F
	for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520316; cv=none; b=mSqpXJa/HJAnEA0J5eGoH5VpTCw7mOhdQeX9JkVnHxZDF8iGTj2yB5EnPIMg8jGyu9yOUrHVahRg0t/xVBbrCxI9rx14w+r8inw6HV2RWBTn3WCNxTAcBHG7BTIXURWfd9u6Xqnhx3ck/0k5CRT8StbBkFq+o8/cMXMZjkVn8FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520316; c=relaxed/simple;
	bh=d02hphWrJrCHawoPYU51u/NXvaw76GqFffbw3xDU2/Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j77TrKWASfe1zijSADAyJ5OKR4yJ3jmsyZn3AMVJB7xwbfPE7JbVSC/kQiWwKzn4H1Ks9C/94e/fr03qHry/12mLHyhzr+SzDL9facWym992Xw9ofCr9UKPKI46QvEvcNan/JOrTj5aI4zLXwl/VYTMI+sWSsJELtbEsvxrwp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vFIz+r78; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d07673185so2373856a12.1
        for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719520312; x=1720125112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N27wDeFiJEPltOwJpQlQbHkWAb2uHwpp+FWzUcCpUGU=;
        b=vFIz+r78rUdOOFSbk0ODewHAXUlMyWIfURUxyXCPq5c4ohh0Ezw0jjBAIF4I51I1HR
         IT8g2qPbD8Eya8cyciF82QZW6UyQ9jR9Rx95ghgsmg9gtShRwhn3RRMyBgjQ8T8yJzUk
         p+WfTl/7MLB6Wujgva34C9DO0vuw+HPBrRYbXBO5QvENqAEXEfe7I9flYZNBCNf2Quwa
         vAD0zpVPY0mnCe4RnCzYAZc//tbAzLB5WRkfay9679svUOv9acvTfLuQJqfWQ3qsZCnA
         TsMBgipHcQOlupkWqq+qrZsTsAiXUx4T7u650G8aQ/h2B8HgqFhDEK/qB3M92HO1eKYI
         k04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520312; x=1720125112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N27wDeFiJEPltOwJpQlQbHkWAb2uHwpp+FWzUcCpUGU=;
        b=NKhLCrmMzdKbuIhJukT4cPy/OyHScH6e88blAqp+aecp7Pt1cBRQY/nxxDGUSrc4tO
         YHg2cVzD0o5LGTi3GhxgRjt3fT+hPXNJVHKX4R4iWzko3MF2plaRgnpg0CvpODMhmRss
         zZQGrxFtBmymnQYvMo82CO0+UYec72Thn5cERWde/qH1J3yNsMygbfwyfvHbVaJdmowr
         Hw6L4pj8QEXyBFi+5oj2G7g+B3LXXkmPytW7b5DvT4QIyVxGtJnznU+il9B0QGTGmh+E
         vdes/7fhiHc/NAP0yqQCj45dElzBc+vxbvzuBrpIzgxuLdNPMb+KAoSKQDCj05PxgWNv
         UOqQ==
X-Gm-Message-State: AOJu0Yx65c+B7KSr6Bef61q2sVFjFuEudNtLsvL1lmvmMwphtFx4wYdv
	fJTg6bo9nEVS4paB6BxaAb04CxgNBLAlNCfVDdeFnmtRRDIuX/yxTG5eZHj9x0VnFHhG4tadXEQ
	QkT8=
X-Google-Smtp-Source: AGHT+IGGtLCp/F56UATVxopgRv8Y4uygtVb/OinpD5kIdqrQXcgycN5b+OqU38xDtS3Yc9jAit4uow==
X-Received: by 2002:a50:999e:0:b0:57c:fda3:b669 with SMTP id 4fb4d7f45d1cf-57d4a281dfbmr12268597a12.17.1719520311657;
        Thu, 27 Jun 2024 13:31:51 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614f3bbc3sm118894a12.82.2024.06.27.13.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:31:51 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 1/3] pwm: Use guards for pwm_lock instead of explicity mutex_lock + mutex_unlock
Date: Thu, 27 Jun 2024 22:31:19 +0200
Message-ID:  <2102fe8189bdf1f02ff3785b551a69be27a65af4.1719520143.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719520143.git.u.kleine-koenig@baylibre.com>
References: <cover.1719520143.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4066; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=d02hphWrJrCHawoPYU51u/NXvaw76GqFffbw3xDU2/Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmfcwkD62hiGUTHgCnJ0cl0Uq5hsG6sNHb/YZDf 3hmmb/6eoWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZn3MJAAKCRCPgPtYfRL+ TkhuB/9Ce+Dl/xPEHrjmtcMUZAFPIH9EV0ZAt+XE2UQFwUzUcBmkMv8cVkbCUVM99aqrnyhNWGs J5kNRFiG6NtUYPHEzvglUwovs2uhosR6JHntuyI8z9x1MA06h8IKQlD6kK1EuY3/K5mlYMOdXKw f5zGSZVtOz4zKVb142bVhm3NAxc+keh+ZxPUKy7tDdzhpVLXbnXul4tZav8Skh72LCRL9o88Tym IIopgLoKX79pq/rpdzglVEsU8BGoA2d3y8L5oOXYFJ7FTxJT3mEq+2IcH5cezDoSN6V3ceZRq4g 4aom+GDvcbP+EyYKwyLf3xdYgPw9RAS2/x9s7wnlAUGDUSXR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With the compiler caring for unlocking the mutex several functions can
be simplified. Benefit from that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 52 +++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5c1d20985148..58e868b56530 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -293,19 +293,15 @@ EXPORT_SYMBOL_GPL(pwm_adjust_config);
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout)
 {
-	int err;
-
 	if (!pwm || !pwm->chip->ops)
 		return -EINVAL;
 
 	if (!pwm->chip->ops->capture)
 		return -ENOSYS;
 
-	mutex_lock(&pwm_lock);
-	err = pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
-	mutex_unlock(&pwm_lock);
+	guard(mutex)(&pwm_lock);
 
-	return err;
+	return pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
 }
 EXPORT_SYMBOL_GPL(pwm_capture);
 
@@ -317,19 +313,15 @@ static struct pwm_chip *pwmchip_find_by_name(const char *name)
 	if (!name)
 		return NULL;
 
-	mutex_lock(&pwm_lock);
+	guard(mutex)(&pwm_lock);
 
 	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
 		const char *chip_name = dev_name(pwmchip_parent(chip));
 
-		if (chip_name && strcmp(chip_name, name) == 0) {
-			mutex_unlock(&pwm_lock);
+		if (chip_name && strcmp(chip_name, name) == 0)
 			return chip;
-		}
 	}
 
-	mutex_unlock(&pwm_lock);
-
 	return NULL;
 }
 
@@ -406,14 +398,14 @@ static struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 	if (!chip || index >= chip->npwm)
 		return ERR_PTR(-EINVAL);
 
-	mutex_lock(&pwm_lock);
+	guard(mutex)(&pwm_lock);
+
 	pwm = &chip->pwms[index];
 
 	err = pwm_device_request(pwm, label);
 	if (err < 0)
-		pwm = ERR_PTR(err);
+		return ERR_PTR(err);
 
-	mutex_unlock(&pwm_lock);
 	return pwm;
 }
 
@@ -1102,11 +1094,11 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
-	mutex_lock(&pwm_lock);
+	guard(mutex)(&pwm_lock);
 
 	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
 	if (ret < 0)
-		goto err_idr_alloc;
+		return ret;
 
 	chip->id = ret;
 
@@ -1119,8 +1111,6 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (ret)
 		goto err_device_add;
 
-	mutex_unlock(&pwm_lock);
-
 	return 0;
 
 err_device_add:
@@ -1128,9 +1118,6 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 		of_pwmchip_remove(chip);
 
 	idr_remove(&pwm_chips, chip->id);
-err_idr_alloc:
-
-	mutex_unlock(&pwm_lock);
 
 	return ret;
 }
@@ -1149,11 +1136,8 @@ void pwmchip_remove(struct pwm_chip *chip)
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_remove(chip);
 
-	mutex_lock(&pwm_lock);
-
-	idr_remove(&pwm_chips, chip->id);
-
-	mutex_unlock(&pwm_lock);
+	scoped_guard(mutex, &pwm_lock)
+		idr_remove(&pwm_chips, chip->id);
 
 	device_del(&chip->dev);
 }
@@ -1209,15 +1193,11 @@ static struct pwm_chip *fwnode_to_pwmchip(struct fwnode_handle *fwnode)
 	struct pwm_chip *chip;
 	unsigned long id, tmp;
 
-	mutex_lock(&pwm_lock);
+	guard(mutex)(&pwm_lock);
 
 	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id)
-		if (pwmchip_parent(chip) && device_match_fwnode(pwmchip_parent(chip), fwnode)) {
-			mutex_unlock(&pwm_lock);
+		if (pwmchip_parent(chip) && device_match_fwnode(pwmchip_parent(chip), fwnode))
 			return chip;
-		}
-
-	mutex_unlock(&pwm_lock);
 
 	return ERR_PTR(-EPROBE_DEFER);
 }
@@ -1532,11 +1512,11 @@ void pwm_put(struct pwm_device *pwm)
 
 	chip = pwm->chip;
 
-	mutex_lock(&pwm_lock);
+	guard(mutex)(&pwm_lock);
 
 	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
 		pr_warn("PWM device already freed\n");
-		goto out;
+		return;
 	}
 
 	if (chip->ops->free)
@@ -1547,8 +1527,6 @@ void pwm_put(struct pwm_device *pwm)
 	put_device(&chip->dev);
 
 	module_put(chip->owner);
-out:
-	mutex_unlock(&pwm_lock);
 }
 EXPORT_SYMBOL_GPL(pwm_put);
 
-- 
2.43.0


