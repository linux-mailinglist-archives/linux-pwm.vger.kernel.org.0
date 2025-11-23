Return-Path: <linux-pwm+bounces-7683-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460FC7E9C1
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 00:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF7E1344CF4
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 23:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB512FF69;
	Sun, 23 Nov 2025 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfkwOaNP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5E15E8B
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940841; cv=none; b=aZo+XY8fWvdaUs7BGXzfFbtC7iJanuSpsDXX2CeRZyXZkNLhac4oBG/d+6vez8UA9RAHsN5JcKb0+BpQDcU15ywAmb59gnTTNe02wY6GOgzcOuSbgiwwAbCFuEWQqNXnCD6o9kl75gmWVK1P41ItgPEcUYJMc68ej++ADREjoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940841; c=relaxed/simple;
	bh=iI/UzSXipXfe24j5ZIwP4aZNqmE0tbzsYwLtG+dw3H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZVAgxyS6phozMDV6Cao0JbFCiN64lzEusm/QFlQN9GcFw0xEg8PwcorvzKej9Ah2NgCNCAf9zBItRTKn6XobVBHZcA+62/g0fkVKYPkPKZdAbykgpupnIwV+0KBA1lCrMvFAy9ZBBFaoOFPOG0nez+FNSIzzqWnIHF+LxCLpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfkwOaNP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc0e6d91222so3356779a12.2
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 15:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940839; x=1764545639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ROCmV+AwPU/0W3OW5Sl9mTvJtTUzV6s8Q7227sNi9I=;
        b=LfkwOaNPbczzCtK3s+GYfN2vO0thhfjRDdBGJXYFB347hy3HPitUIRI81dTGl2Gqjg
         XWtLio/+zXarAX6fcZppseTesw5cT96lkdjicj9BnmXBXg5bUS93UMY4DBQNgRDRFBJb
         7Aj41Y+wYRmksuEVm0sWQ7ubuQQFll4XbadV/LJ14XF3+QILoHE8bzL53/9E/Cq+056P
         rVr3vCa4G3YioEJqfb0rZsh2eCfOCocccmq3JMBwdh2KnPMIcVvXktgB1YyPbRZUg3Uw
         ttj0643WgQLi7whnaPabLdTeGPEop5sRedLaO7NyhuJNpN/OynfLB/RnQ183Nkw46OTW
         yA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940839; x=1764545639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ROCmV+AwPU/0W3OW5Sl9mTvJtTUzV6s8Q7227sNi9I=;
        b=LsLACYiWOJpRahitYjjEW/Nw4bkmNv52l1Dw9V7P17V6ZlhR/Wk7+Ut8zxrWi4oQzQ
         mozkzRv2TTgek43CWILGv4ngbXSkIAkRBkvAk+SG+oAR/Hrz9p8znHCGFBcoTZ8ViSJj
         d0v8GfmyqmcVEoGQT1Zo/gB8UPNEIeY1UcUXkdU4TdHCTNkTwYawGIZXkZcLopFZ/+9L
         3g4EbFAZast9vbEKAgD4J3d0kqWV7542fQ2u4rylJsjfiy/BwochbMBh6LE++4bgvWpE
         f+SMva6V24lAnNy67UBljOHug1mLa9GT6dABTP9EbVjwBXzseIXEJsDxbzur2fFoauSx
         4Fjg==
X-Forwarded-Encrypted: i=1; AJvYcCXIhddkbNpZDPKzrQC6BqxIYRxUlJyPbG4EjofF3BEi8gFM94XcpzMtYqRN8kmbFmCROJ70f2ZgJNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YydsA+Nyq7eIJ8bAkUYG7HMGkm5/PjjPmKG2CyILX1Kbx1nXXZn
	IWHgj0XqUM1+H9K/bc6h4Wpv+63JgNiQuNNsfAKKC8CdCAeQfs06g98ZVAu1QQ==
X-Gm-Gg: ASbGnctcNEtte28OowPeAyfaaMyuZaCeHjzmtkD/4+Hcgk56B3pxMuAOsQTL+Nuvy20
	4WmENnkaxUvaIUA3uhoh0GbwMuFr4KTjRU6Ub9b8Ii9f8vNHuL93DBRncvGuja/+73lZ3u/xkXq
	KTXDw3JkwlPY9ZPXC4Ah7r5iV7c8DM917oxBAdLvP4xwCbXMImGSuRVTRhP2275WDEc7fLTYURx
	0qM6+17xg99S2H2Z4HBK/h5n+WBMDPgak9Gi168tVpL52bQOwUkHJVEDxTxL8sJG4WSpPSNdS7h
	3OAFrlBRyfwdFbuHkhBsn2nPGahV1D7qNx3y9BQONtq2RpguInNVMzx4T61NmdY2XTsjwOCppfS
	rB8W0d4ZXYMH15ARsCRtLkO0YIxNico0Lj2FP2fw4sn/EMYY6rkR+/j1Bj1J6l1x6ArOmD/HUTm
	f3pzWjw8ILIfrf/cFiE5pLv0Z3aWBrvGJfoebQLPPOUrtSX66/3OKPow==
X-Google-Smtp-Source: AGHT+IEAa2rMrvXcwz/4xJsVFyvI/gB3zi+0m0yfEBFVhgQrk7lnBETDWtMzu/1u+dc9inxC36vZ9A==
X-Received: by 2002:a05:7301:da0a:b0:2a4:6c43:b0c9 with SMTP id 5a478bee46e88-2a7192d9e84mr3233527eec.30.1763940839350;
        Sun, 23 Nov 2025 15:33:59 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc5e3750sm41858139eec.6.2025.11.23.15.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:33:58 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v6 5/6] pwm: tiehrpwm: handle already-running channels at probe
Date: Sun, 23 Nov 2025 20:33:49 -0300
Message-ID: <20251123233349.2122-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251123233151.2103-1-rafael.v.volkmer@gmail.com>
References: <20251123233151.2103-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detect active A/B outputs from AQCTL(A/B) when they are not
software-forced in AQCSFRC, take one pm_runtime_get_sync() per active
channel, and enable tbclk only if at least one channel is active. This
keeps runtime PM usage counts and tbclk state consistent with the
actual hardware configuration.

Before, an eHRPWM instance left running by firmware or the bootloader
could have no runtime PM reference and no tbclk enable, leaving the
driver out of sync with hardware. After this change, PM and clock
state match the active channels observed at probe.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 64 +++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index cc525626b2f9..1a9be36fc7b2 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -554,13 +554,35 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	struct ehrpwm_pwm_chip *pc;
 	struct pwm_chip *chip;
 	struct clk *clk;
-	int ret;
+	int ret, ch_idx, ch_disable;
+	u16 aqcsfrc_reg, aqctla_reg, aqctlb_reg;
+	bool enabled_ch[NUM_PWM_CHANNEL] = { false, false };
 
 	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_ehrpwm_pwm_chip(chip);
 
+	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pc->mmio_base))
+		return PTR_ERR(pc->mmio_base);
+
+	/*
+	 * Best-effort snapshot of AQCSFRC/AQCTLx before touching clocks or
+	 * runtime PM. If the eHRPWM block is power-gated or its clock is
+	 * disabled these registers are expected to read as 0, which we
+	 * interpret as "channel not configured / disabled".
+	 */
+	aqcsfrc_reg = readw(pc->mmio_base + AQCSFRC);
+	aqctla_reg = readw(pc->mmio_base + AQCTLA);
+	aqctlb_reg = readw(pc->mmio_base + AQCTLB);
+
+	if (aqctla_reg != 0 && !FIELD_GET(AQCSFRC_CSFA_MASK, aqcsfrc_reg))
+		enabled_ch[PWM_CHA] = true;
+
+	if (aqctlb_reg != 0 && !FIELD_GET(AQCSFRC_CSFB_MASK, aqcsfrc_reg))
+		enabled_ch[PWM_CHB] = true;
+
 	clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
 		if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
@@ -580,10 +602,6 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 	chip->ops = &ehrpwm_pwm_ops;
 
-	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pc->mmio_base))
-		return PTR_ERR(pc->mmio_base);
-
 	/* Acquire tbclk for Time Base EHRPWM submodule */
 	pc->tbclk = devm_clk_get(&pdev->dev, "tbclk");
 	if (IS_ERR(pc->tbclk))
@@ -595,17 +613,49 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (enabled_ch[PWM_CHA] || enabled_ch[PWM_CHB]) {
+		ret = clk_enable(pc->tbclk);
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "clk_enable(tbclk) failed\n");
+			goto err_clk_unprepare;
+		}
+	}
+
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto err_clk_unprepare;
+		goto err_disable_tbclk;
 	}
 
 	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
-	return 0;
+	/*
+	 * Treat channels that were configured and not software-forced at probe
+	 * time as "pre-enabled": take a runtime PM reference so the eHRPWM block
+	 * stays powered while such channels exist. Consumers still get/put PM
+	 * on top of this bias via pwm_enable()/pwm_disable().
+	 */
+	for (ch_idx = 0; ch_idx < NUM_PWM_CHANNEL; ch_idx++) {
+		if (enabled_ch[ch_idx]) {
+			ret = pm_runtime_get_sync(&pdev->dev);
+			if (ret < 0) {
+				for (ch_disable = 0; ch_disable <= ch_idx; ch_disable++) {
+					if (enabled_ch[ch_disable])
+						pm_runtime_put_noidle(&pdev->dev);
+				}
+
+				pwmchip_remove(chip);
+				pm_runtime_disable(&pdev->dev);
+				goto err_disable_tbclk;
+			}
+		}
+	}
 
+	return 0;
+err_disable_tbclk:
+	if (enabled_ch[PWM_CHA] || enabled_ch[PWM_CHB])
+		clk_disable(pc->tbclk);
 err_clk_unprepare:
 	clk_unprepare(pc->tbclk);
 
-- 
2.43.0


