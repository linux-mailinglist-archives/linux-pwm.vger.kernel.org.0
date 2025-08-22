Return-Path: <linux-pwm+bounces-7139-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83AB30DB6
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 06:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314DA5E32A8
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 04:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D921CC43;
	Fri, 22 Aug 2025 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/4xclFI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BF5393DE4;
	Fri, 22 Aug 2025 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838252; cv=none; b=ciIzSH6tnwQ/LPoMz93ONYhCyrAhsg7UBZCIf5mIZbzekGjuPfXGkFW2NDIA92wMA9Wpcpopp3nutLiE3yJ36c9CY9toqM6ap+w2PTlpASMWWjUQfQz29PNZ+vjhMTxgajpAhd8fQXXglHruVEgqgM3ApTx9fB4d4coCh1GaSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838252; c=relaxed/simple;
	bh=zR0oPRgCcgTcsPlwpyKevv31Rp/4hbCPNx1k7iMrywY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pliq+avkARi2OE0H64o1Hmktzz2koyKxqNibkZMVKSYyLCb7Sqdgdtul4USJwVBtbllOveZDaC2EgTckhPLACjFhHYNPWTz/rNx1hVXl/FOADKT+/v/+8M5fCl2X/iyLESoBfX/tauu7zD027X74iDjYIBePxH25MjJT6T+zSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/4xclFI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24633f57e0bso3009805ad.0;
        Thu, 21 Aug 2025 21:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755838250; x=1756443050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh4ZbXwoDi6AidXi+OCVuKBbmmBo2hC/qqNlSDjrfRM=;
        b=L/4xclFI6X6L5KAle3EJ7k7MD4yF0ZbEz4FY3Co6zFFJFCek9yisk3u/Oh7PWyztxU
         Bxoae+eV+1W+N2DhSCCfj71I3m09LICLg963qT9ioThgQZbJDRtkzjuxs2CTTLC3u2Ar
         cTlzxLhSfy2cBkLiPS7fAL4ikM8boHh5vX1jTUyqkQS4HrSZ65TGOatQZH7K0KK1ofVL
         kpqEAgH0jSb5gaPDWPeJVjJML6hlk4gqTKnfDEajQfqejIXguU6ZDeyBzk2kP1jl1Mwo
         6+gI7JjYs8Wyjmga6kLM2SDwARvNBCeie8U6SOiQ+OBm+sZo+OS3tHiqWVz2Kkc1PENU
         S1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755838250; x=1756443050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xh4ZbXwoDi6AidXi+OCVuKBbmmBo2hC/qqNlSDjrfRM=;
        b=VMHEMN4Z3bkkM0wHLB91d26n/2RqRp8Xay7+LlxmaulsZzQgCkaNlTe4Wb1Wk/Nqfw
         tht13+ZP2h4U9VGNBg0ThEe7q6DFli2giBRXC5ZmbkyU4XTJErU5iw58XQAP0EhcY1VL
         GWQd0zIzM/HV3+FUBVnRl6Lb9TPyYO4IGaVpHTM+GP9IMyMRVavFiYaPUGQwxBvITw2z
         ONDVsdG03AbzlYZ1sH0BcMzU2cckYtwZi+bai9Zp/c+6jhezSAhrbQiekobtQa1vm6eA
         Ydp/C/TmGfvA9YAR2Ym3PvWP3C1QV5EJibhJSnLLjJfnbhfhLTpeCTix+aQ5AeqzizBA
         rqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3mGku+P+6k4+2f8LEYlMjxbGGKpqRpHvyGyTRZ+6GRqdfPfHl32UvAsqwh7czxrWCR06ft7pgKxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAl7cV8Z3JjltgQLOPIQoq3DLGzvsUrXhQrPR5E3I9MYrQUlxz
	X7Li0TzYY6nZmyxXQH0ThgGuTMbJK4gc/P52q+uw8lfM2qg715+eqOkPbs/klHI2
X-Gm-Gg: ASbGncs/kWDyq2n1HVq6poRuDAumTNMp8iSvMm84BHH6ShaU0uORSMxCle+X2a9RMaC
	TMGlgdEoil5fH4gFYH2J9r755JMo/9i6QwuGiYQTMyjCdVu6aHabYARLLtyQkcnL5je8ommPIoy
	43uoM4K6JDOr7G8PCy6bzEiUgok49jJf5KlrnuMR/v7oc0pBRUBRiJk9B+QOLNJ5dej66Qpq9Tc
	kezFRXwyEzeHSxt013yHxJZ4IYZdyah2xfDAl4TFH59zerriG64HCaCNPvyJiS9dOBFdAGa6rmX
	NabUVy9IT2XcIpHty8HPjZz4LdkLt7NlY/XFcQ3KVtweG+loiMuPckgXz1VDio6ccSD2ICKGwUi
	f74Lv/e76vrEVNEpF/inFUtMtqPLAS+TPDauQDMzBK4C84fs=
X-Google-Smtp-Source: AGHT+IGO9T3Eu5a206tFjYcWqu0e7gMccekYDC3igNpgVFidxxbk3q5wXv7fXJKXKL8iUalL3t+ZhQ==
X-Received: by 2002:a17:902:f547:b0:245:f536:b454 with SMTP id d9443c01a7336-2462ee80ed1mr29780525ad.26.1755838250457;
        Thu, 21 Aug 2025 21:50:50 -0700 (PDT)
Received: from paradiselost.local (lohr.com.br. [187.58.145.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245f0d86c05sm64350575ad.93.2025.08.21.21.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:50:49 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v5 5/6] pwm: tiehrpwm: account for active channels at probe
Date: Fri, 22 Aug 2025 01:50:05 -0300
Message-ID: <20250822045005.4127-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822044806.4103-1-rafael.v.volkmer@gmail.com>
References: <20250822044806.4103-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle already-running eHRPWM channels at probe. Detect active A/B from
AQCTL(A/B) when not software-forced in AQCSFRC, take one
pm_runtime_get_sync() per active channel, and enable tbclk only if at
least one is active. Keep PM refcounts and clocks consistent with the
hardware state.

Before: active hardware could miss runtime PM gets and clk enable.
After: PM/clk state matches active channels observed at probe.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 55 +++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 1dae3b8b5..a801912be 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -121,6 +121,9 @@
 
 #define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
 
+#define PWM_CHA			0
+#define PWM_CHB			1
+
 struct ehrpwm_context {
 	u16 tbctl;
 	u16 tbprd;
@@ -582,13 +585,31 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	struct ehrpwm_pwm_chip *pc;
 	struct pwm_chip *chip;
 	struct clk *clk;
-	int ret;
+	int ret, ch_idx, ch_disable;
+
+	u16 aqcsfrc_reg, aqctla_reg, aqctlb_reg;
+
+	bool enabled_ch[NUM_PWM_CHANNEL] = { false, false };
 
 	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_ehrpwm_pwm_chip(chip);
 
+	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pc->mmio_base))
+		return PTR_ERR(pc->mmio_base);
+
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
@@ -608,10 +629,6 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 	chip->ops = &ehrpwm_pwm_ops;
 
-	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pc->mmio_base))
-		return PTR_ERR(pc->mmio_base);
-
 	/* Acquire tbclk for Time Base EHRPWM submodule */
 	pc->tbclk = devm_clk_get(&pdev->dev, "tbclk");
 	if (IS_ERR(pc->tbclk))
@@ -623,17 +640,43 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
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
+				return ret;
+			}
+		}
+	}
 
 	return 0;
 
+err_disable_tbclk:
+	if (enabled_ch[PWM_CHA] || enabled_ch[PWM_CHB])
+		clk_disable(pc->tbclk);
 err_clk_unprepare:
 	clk_unprepare(pc->tbclk);
 
-- 
2.43.0


