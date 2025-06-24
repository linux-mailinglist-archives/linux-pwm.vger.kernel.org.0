Return-Path: <linux-pwm+bounces-6513-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028E6AE6E6F
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0A37A6620
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7146D2288CB;
	Tue, 24 Jun 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cnASd3x/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C5298984
	for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788989; cv=none; b=uG3z3KgOarwK8V1cXtBmCZLPLWdHgit+PXBV8qhevxs4zTs2GVQv1/DjEgbSvzXZhDS5SINeG1Tt9NXFZU6w6s6KrZ6zhwVbJrlE3hIeQOskk02BcrRqZm+D0C548dsKIDJfYqOaPDiKMdOcX+7FFkYT/nET66PwcC5cMcGlu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788989; c=relaxed/simple;
	bh=xC2ytKR7W2mUQhNrG10XPD2vHXAclFC4syCEUGBqRis=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZgkLggNl/aQJIeR42vp22DPhfjF/AcBfKfxJEwYUecw29bKKrSFFME+R7yqoLzvM7HKTCBt5sdfzYsnzsR5oAZl3t7WDA0eKF9BNXol+QwS1094OKmPk4YpurXbeMAztv/PHFlXDhMJwbE13Bo4e+qeZ2OGvhkQw1xPp0RKpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cnASd3x/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso11818300a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750788985; x=1751393785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMMovs9T576whs0wP5MINT7ed5tXXRyFPK2px8I+/Iw=;
        b=cnASd3x/ZG1T5dvyTq7qQhwcxIl10hRNU2SE0sjQr7XwsYkIW4BUoahiNfx/YW2Ewv
         h635tnjFKKRBQr5P5xc5XXBy1N7nrtf2WiWd9bX5WUUoMX3+bBPjPi8OWh925KeVny/8
         SgIsagU7bxfYWcSE2PWNlci13QByJQJDNs27WBHK8E/IjumNQpH2om/k6YvliYSX/6Eq
         eLlaim0bDlI9Kelmb1cdGOO3LbeLUllT0KD3np9LYqNDRdhSY5Ir0JjIBmPo5pC3shuE
         0l+yfu2PkHBX1ni9RAn46u/WIMtWR4Daxev5ssJ0bncVM9azyeaOF3qZ0g+WXD6fo/LO
         vQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788985; x=1751393785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMMovs9T576whs0wP5MINT7ed5tXXRyFPK2px8I+/Iw=;
        b=gmySY2zze7DophKtmhAV29lpL9kL+NAFsvG6uOJNj0MNCOa+270vq29pkHqlLbEMhE
         VeBhl4I/v1Cq+zg8c/MyEgZ/sncP1tu1pWhX5iovAPVEBCoLW50RfvvqY6klokfn+MOR
         dO0G6tGC4tVGwlZjPS/B2T0daHCVjz+FKN9JL+qaDkvL+nYUkxPZvLg8uN7mIJXNscxq
         nNXHxh9QSUZIoV4SHKNZtJXdfMDisWzo63jUgzvl4+c4J6Qp/dqh8jQa0pie5Z+asQBx
         ijRU5ZVv74azBCx2DmxkNK0IHH0oz4y5iyurLw8FjOqlWF7epLv4nEbzK0nzslBI86RN
         ASGw==
X-Gm-Message-State: AOJu0Yw1+phyXsdwHAiKnyTWYB/I3/yjuAJWBlICg+XiwSCdO4GSWTWi
	RSnjaAKJkNdGyaQ62LV50Z1nF6vTNiIBUvnoMr8MaHLDIB3ikWJRO5clghTu4fYC0BZHDKqulSE
	CqZ1e
X-Gm-Gg: ASbGncvaPWWVnsacJl/FlGn8TG8X6rCE62f0A1uQSqjJZsT2qICilXRxe+EoYGxFpvj
	1RTjP6cr9P8cQg7KEUmMLdRBoNhF4pDYOlbVYBSHwqVULodI70WWyFeJiytRELz/GVdMaxf+UJS
	Ht9uSqVo4Fro8DPitgMx6zZr1ejKN44KnxKARvy/SyOxZMi8f0TJJ8i8DnPG/0hHTKM8MLhljlI
	6yD/Xw0pipdIlKvlebo0r6cSSp3b556EtaFcpRUj4yJPVfT/PpUegtvKdnLOSjtJ5oe4bTv1nz+
	f/Xjx2bm1b1V6TfcLx8v8F4tT2i0HUGc2Ne28PYtxGeaauOdBaOIBNVkOFsi1471Vx0=
X-Google-Smtp-Source: AGHT+IGb/3/XGuoXxS8wnUQjaHKWnuZMHAptoqhn0B1sYtE4eGamGXXaaQwkHIhcrYsBmAHhmpxBaA==
X-Received: by 2002:a05:6402:5189:b0:607:eda0:1697 with SMTP id 4fb4d7f45d1cf-60a1cd2f86bmr16167275a12.10.1750788984873;
        Tue, 24 Jun 2025 11:16:24 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c2f1b1ffbsm1319702a12.19.2025.06.24.11.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 11:16:24 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 3/8] pwm: fsl-ftm: Drop driver local locking
Date: Tue, 24 Jun 2025 20:15:39 +0200
Message-ID:  <6b72104e5e1823170c7c9664189cc0f2ca5c2347.1750788649.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
References: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3766; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=xC2ytKR7W2mUQhNrG10XPD2vHXAclFC4syCEUGBqRis=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoWutUaRkr9oL/3EW4pluDVhDmPj4YDv4d83Udz 3gqK23kCm6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaFrrVAAKCRCPgPtYfRL+ Tjf5B/wIIFtJudMEaCjUhCEEGiqddrXuGUI1j8wgbRhQwzE5oLbc60jB8iCAMWt+9nMkt6FZ9Sd DZchR+ubjgtj6lYs55m2ioL9dHGv86tLelty2oe0ik8PzJ5dmcmWvr+380bZjfNId2GNb0eVfPp tBj3Asfd3Rx3xy7jqghXp6bO4sboPCuKfcfEx30Szm7x2LNkYT40Tm2HK52VG5gZ7zIm9JBqRcq C1MX5ix4fuGfXXgL4luIMC2ImURt19Ao9ZHkKuAH9XSi+a8FrpSApvnq98tqigwtxoBP8ukFXeP qBSbQSUzoPIcqGa5b5v++bZTOXod0hEk5U7rXWMWOCxhQm5V
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The pwm core serializes calls to .apply(), so the driver local lock isn't
needed for that. It only has the effect to serialize .apply() with
.request() and .free() for a different PWM, and .request() and .free
against each other. But given that .request and .free() only do a single
regmap operation under the lock and regmap itself serializes register
accesses, it might happen without the lock that the calls are interleaved
now, but affecting different PWMs, so nothing bad can happen.

So the mutex has no effect and can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index c45a5fca4cbb..6683931872fc 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -10,7 +10,6 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -40,7 +39,6 @@ struct fsl_pwm_periodcfg {
 };
 
 struct fsl_pwm_chip {
-	struct mutex lock;
 	struct regmap *regmap;
 
 	/* This value is valid iff a pwm is running */
@@ -89,11 +87,8 @@ static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
 	ret = clk_prepare_enable(fpc->ipg_clk);
-	if (!ret && fpc->soc->has_enable_bits) {
-		mutex_lock(&fpc->lock);
+	if (!ret && fpc->soc->has_enable_bits)
 		regmap_set_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16));
-		mutex_unlock(&fpc->lock);
-	}
 
 	return ret;
 }
@@ -102,11 +97,8 @@ static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 
-	if (fpc->soc->has_enable_bits) {
-		mutex_lock(&fpc->lock);
+	if (fpc->soc->has_enable_bits)
 		regmap_clear_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16));
-		mutex_unlock(&fpc->lock);
-	}
 
 	clk_disable_unprepare(fpc->ipg_clk);
 }
@@ -304,7 +296,7 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	struct pwm_state *oldstate = &pwm->state;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * oldstate to newstate : action
@@ -315,8 +307,6 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * disabled to enabled : update settings + enable
 	 */
 
-	mutex_lock(&fpc->lock);
-
 	if (!newstate->enabled) {
 		if (oldstate->enabled) {
 			regmap_set_bits(fpc->regmap, FTM_OUTMASK,
@@ -325,30 +315,28 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
 		}
 
-		goto end_mutex;
+		return 0;
 	}
 
 	ret = fsl_pwm_apply_config(chip, pwm, newstate);
 	if (ret)
-		goto end_mutex;
+		return ret;
 
 	/* check if need to enable */
 	if (!oldstate->enabled) {
 		ret = clk_prepare_enable(fpc->clk[fpc->period.clk_select]);
 		if (ret)
-			goto end_mutex;
+			return ret;
 
 		ret = clk_prepare_enable(fpc->clk[FSL_PWM_CLK_CNTEN]);
 		if (ret) {
 			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
-			goto end_mutex;
+			return ret;
 		}
 
 		regmap_clear_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm));
 	}
 
-end_mutex:
-	mutex_unlock(&fpc->lock);
 	return ret;
 }
 
@@ -408,8 +396,6 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	fpc = to_fsl_chip(chip);
 
-	mutex_init(&fpc->lock);
-
 	fpc->soc = of_device_get_match_data(&pdev->dev);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.49.0


