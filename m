Return-Path: <linux-pwm+bounces-2737-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4397492B39B
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2024 11:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C55B21D19
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2024 09:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15AF154BE0;
	Tue,  9 Jul 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LqCOV8PL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2879154BE8
	for <linux-pwm@vger.kernel.org>; Tue,  9 Jul 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516954; cv=none; b=PpuibKcyUIdN7St1K9yOCzyx4yDb5Zf2O5nYTaEKNQ/+ywwRl4h0bRGsBiT809MyitfrUVOx0pSWf/lxnbOimcJjLfF1jMV3HNEWWBFyR65AZmZUbF9ryPyR9uiFHGJ5VF3Sl9z8wbUQ08fu1U38wmJBjHpsi9swTbsFxTsnyGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516954; c=relaxed/simple;
	bh=L2ZslCkLR4UmS9dhyIDHvU1zQNZV4oQqupGRYQ7izc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IWTD8LUZ8sUt0UtMGCdKQQDI6ok8KMvOBNHexiLxAAvz7Fc0K1GTwzUVuYpp8+s1dCEaFY0XOtJfjzmMeDd1ybASR+NUWmggbcmJWaIWYNCTopPuTEdEmY6bPKqfTKa9xOXM3+VIXgUbzwTKU3Xd9vUz5GFPoa+ZP0rkRovjolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LqCOV8PL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266ea6a412so8929475e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jul 2024 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720516950; x=1721121750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+y4LCDnAAXXuarGv2yzEkakVU0kvPuo5/Bgu5L7r/I=;
        b=LqCOV8PLQbbRbwsHb9fiKRoV8OyVatPf2Nw8znFseaMcwPD1/pwzorOyeyONRleCM/
         w3qJ6vJq4sAsvO4kb4GPEyi01fW73KsGpDRGCs/HTb2YaHb50I3AxNqjqIfuVORva6q/
         zbSklPGP51FZTqZgnNdrYgeL+9k5YOW1FsiZe1bSVXQ0W5S9allvXbuSMwDZTkgUXcWb
         BbqrngyNrsTqHA3U6iTuMDYq94wJD4WzOK7T64kDbOrBCNonkgTYWesIqa/GAAxoAWTN
         yUXDwgjjtI1DtdaQRacQ7zSIzeuyBa4kDG3IXS2Alu57vb4ds3kRrTaNMKovqudYhI5S
         qEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720516950; x=1721121750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+y4LCDnAAXXuarGv2yzEkakVU0kvPuo5/Bgu5L7r/I=;
        b=X5D7HXI2oPQIX9ORZ9iZ05VHLIWSx/opsy6n6hnZEsy0BUEp9yqPBv2jZBVppDfpAN
         ZRGwhvi1+UDSIoCIgLDHIlX2nL5WvnHcAqMQwuagF6kcDHzR4zGLgzF2yFenPjtAsbkA
         nXS9bMa2NklEGjQxSxU5gfWyiKQIgoNYyyDh+KaulBu3+TC3UAdBAN8bzEg3/sqEHuDj
         +4p9GK8Bawu+rKrDd14qb1Zxe3g988sgj7JD5HrqvPAI8G/zY37pFlgioPgyzPfcWiph
         k2AcnjSr45dww6tsgCJ073GxMAQfeQSTi/R2oi1in2Bx8vSZJMfZqi5BcwDuNYsHYiEa
         8VPg==
X-Gm-Message-State: AOJu0YxkT3JjFcYKap1PPuIUI/GX0lvMQc3DrRaWgFQVzZDgz9ypG4Ov
	p6dBFMpDdM1CSVqU7VmE/ru1bzsY41eV6xJuOhxcoxKO8MCFdFQowdVDzTIPyGY=
X-Google-Smtp-Source: AGHT+IG1fAt3JlWpReh32TqukLAKUyyiz5kCUoY3HPT/7TJNqa4Kz+jjTnH3sGV6GaHJCRuFMNzZzQ==
X-Received: by 2002:a05:600c:4c8a:b0:426:6e93:4ad0 with SMTP id 5b1f17b1804b1-426707d7977mr13571995e9.17.1720516950204;
        Tue, 09 Jul 2024 02:22:30 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741624sm30874925e9.41.2024.07.09.02.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 02:22:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: atmel-tcb: Make private data variable naming consistent
Date: Tue,  9 Jul 2024 11:22:21 +0200
Message-ID: <20240709092221.47025-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6801; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=L2ZslCkLR4UmS9dhyIDHvU1zQNZV4oQqupGRYQ7izc8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmjQFNEmkm/PgmWgid0vUUok45iyvqxR5jzCsYL esRLilZTAOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZo0BTQAKCRCPgPtYfRL+ Tt8ECACjXyOITuoAE3Cchf8s+2WdkUPZPFIvTdI33TKBrcuJlw46ELxn8n5+0tllQIAv1YQay47 MtdYXYlAntMoPj3Gg1pbQM4K1YmBXmhoUnLg/CwpCmqyEatT4nC7+W5g9xr1qhiivLSZV2BgEwv KmYl2XpDtIrarZygIHTpyWtKQhpbGSDF1YlvqEQags3hRM00XUwIWMu6KBLDvA64n1xcNXu6INI LSf+PEey6tEDfmdPe/8hk6Em1YKeJr/M77AFZOHec5qAFBXl1TnW3100EKj6AIVvoFxUw9DHeiC WmJV89+jpEKRInyD9clkrvzIsSJbtwP8zkOvhYYuqjzYN8LL
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Currently the variables of type struct atmel_tcb_pwm_device
are named "tcbpwm", and variables of type atmel_tcb_pwm_chip are either
named "tcbpwm" (too!) or "tcbpwmc". Rename the chips with device name to
"tcbpwmc" to get a consistent naming.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-atmel-tcb.c | 90 ++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 528e54c5999d..9470811e195c 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -389,17 +389,17 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
 	const struct of_device_id *match;
-	struct atmel_tcb_pwm_chip *tcbpwm;
+	struct atmel_tcb_pwm_chip *tcbpwmc;
 	const struct atmel_tcb_config *config;
 	struct device_node *np = pdev->dev.of_node;
 	char clk_name[] = "t0_clk";
 	int err;
 	int channel;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, NPWM, sizeof(*tcbpwm));
+	chip = devm_pwmchip_alloc(&pdev->dev, NPWM, sizeof(*tcbpwmc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
-	tcbpwm = to_tcb_chip(chip);
+	tcbpwmc = to_tcb_chip(chip);
 
 	err = of_property_read_u32(np, "reg", &channel);
 	if (err < 0) {
@@ -409,20 +409,20 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	tcbpwm->regmap = syscon_node_to_regmap(np->parent);
-	if (IS_ERR(tcbpwm->regmap))
-		return PTR_ERR(tcbpwm->regmap);
+	tcbpwmc->regmap = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(tcbpwmc->regmap))
+		return PTR_ERR(tcbpwmc->regmap);
 
-	tcbpwm->slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
-	if (IS_ERR(tcbpwm->slow_clk))
-		return PTR_ERR(tcbpwm->slow_clk);
+	tcbpwmc->slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
+	if (IS_ERR(tcbpwmc->slow_clk))
+		return PTR_ERR(tcbpwmc->slow_clk);
 
 	clk_name[1] += channel;
-	tcbpwm->clk = of_clk_get_by_name(np->parent, clk_name);
-	if (IS_ERR(tcbpwm->clk))
-		tcbpwm->clk = of_clk_get_by_name(np->parent, "t0_clk");
-	if (IS_ERR(tcbpwm->clk)) {
-		err = PTR_ERR(tcbpwm->clk);
+	tcbpwmc->clk = of_clk_get_by_name(np->parent, clk_name);
+	if (IS_ERR(tcbpwmc->clk))
+		tcbpwmc->clk = of_clk_get_by_name(np->parent, "t0_clk");
+	if (IS_ERR(tcbpwmc->clk)) {
+		err = PTR_ERR(tcbpwmc->clk);
 		goto err_slow_clk;
 	}
 
@@ -430,22 +430,22 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	config = match->data;
 
 	if (config->has_gclk) {
-		tcbpwm->gclk = of_clk_get_by_name(np->parent, "gclk");
-		if (IS_ERR(tcbpwm->gclk)) {
-			err = PTR_ERR(tcbpwm->gclk);
+		tcbpwmc->gclk = of_clk_get_by_name(np->parent, "gclk");
+		if (IS_ERR(tcbpwmc->gclk)) {
+			err = PTR_ERR(tcbpwmc->gclk);
 			goto err_clk;
 		}
 	}
 
 	chip->ops = &atmel_tcb_pwm_ops;
-	tcbpwm->channel = channel;
-	tcbpwm->width = config->counter_width;
+	tcbpwmc->channel = channel;
+	tcbpwmc->width = config->counter_width;
 
-	err = clk_prepare_enable(tcbpwm->slow_clk);
+	err = clk_prepare_enable(tcbpwmc->slow_clk);
 	if (err)
 		goto err_gclk;
 
-	spin_lock_init(&tcbpwm->lock);
+	spin_lock_init(&tcbpwmc->lock);
 
 	err = pwmchip_add(chip);
 	if (err < 0)
@@ -456,16 +456,16 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_disable_clk:
-	clk_disable_unprepare(tcbpwm->slow_clk);
+	clk_disable_unprepare(tcbpwmc->slow_clk);
 
 err_gclk:
-	clk_put(tcbpwm->gclk);
+	clk_put(tcbpwmc->gclk);
 
 err_clk:
-	clk_put(tcbpwm->clk);
+	clk_put(tcbpwmc->clk);
 
 err_slow_clk:
-	clk_put(tcbpwm->slow_clk);
+	clk_put(tcbpwmc->slow_clk);
 
 	return err;
 }
@@ -473,14 +473,14 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 static void atmel_tcb_pwm_remove(struct platform_device *pdev)
 {
 	struct pwm_chip *chip = platform_get_drvdata(pdev);
-	struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
+	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 
 	pwmchip_remove(chip);
 
-	clk_disable_unprepare(tcbpwm->slow_clk);
-	clk_put(tcbpwm->gclk);
-	clk_put(tcbpwm->clk);
-	clk_put(tcbpwm->slow_clk);
+	clk_disable_unprepare(tcbpwmc->slow_clk);
+	clk_put(tcbpwmc->gclk);
+	clk_put(tcbpwmc->clk);
+	clk_put(tcbpwmc->slow_clk);
 }
 
 static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
@@ -492,14 +492,14 @@ MODULE_DEVICE_TABLE(of, atmel_tcb_pwm_dt_ids);
 static int atmel_tcb_pwm_suspend(struct device *dev)
 {
 	struct pwm_chip *chip = dev_get_drvdata(dev);
-	struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
-	struct atmel_tcb_channel *chan = &tcbpwm->bkup;
-	unsigned int channel = tcbpwm->channel;
+	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
+	struct atmel_tcb_channel *chan = &tcbpwmc->bkup;
+	unsigned int channel = tcbpwmc->channel;
 
-	regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, CMR), &chan->cmr);
-	regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, RA), &chan->ra);
-	regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, RB), &chan->rb);
-	regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, RC), &chan->rc);
+	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(channel, CMR), &chan->cmr);
+	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(channel, RA), &chan->ra);
+	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(channel, RB), &chan->rb);
+	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(channel, RC), &chan->rc);
 
 	return 0;
 }
@@ -507,17 +507,17 @@ static int atmel_tcb_pwm_suspend(struct device *dev)
 static int atmel_tcb_pwm_resume(struct device *dev)
 {
 	struct pwm_chip *chip = dev_get_drvdata(dev);
-	struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
-	struct atmel_tcb_channel *chan = &tcbpwm->bkup;
-	unsigned int channel = tcbpwm->channel;
+	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
+	struct atmel_tcb_channel *chan = &tcbpwmc->bkup;
+	unsigned int channel = tcbpwmc->channel;
 
-	regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, CMR), chan->cmr);
-	regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, RA), chan->ra);
-	regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, RB), chan->rb);
-	regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, RC), chan->rc);
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(channel, CMR), chan->cmr);
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(channel, RA), chan->ra);
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(channel, RB), chan->rb);
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(channel, RC), chan->rc);
 
 	if (chan->enabled)
-		regmap_write(tcbpwm->regmap,
+		regmap_write(tcbpwmc->regmap,
 			     ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
 			     ATMEL_TC_REG(channel, CCR));
 

base-commit: 120a528213b6693214e3cbc24a9c3052a4b1024b
-- 
2.43.0


