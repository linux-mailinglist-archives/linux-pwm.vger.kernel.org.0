Return-Path: <linux-pwm+bounces-5585-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A769A9455B
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 21:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317BF7A3AEB
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF5F1519BF;
	Sat, 19 Apr 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICxk8hGL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF729D0E;
	Sat, 19 Apr 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745092741; cv=none; b=ecuaxLrBn2w6YREeAnwUiZchTQONDK4q2ysW17tr+1s0NvxLSSyluh/gnOiRBLlsuVqcVW7xQ1rm4T36MGyqW2dXoXc93k822ncbIGTapihLC0puv0Y3wuSNT39Od6BscDigK3rDrKuTBd7f62OlV4yWW7mp/Z18jcneX8XKx9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745092741; c=relaxed/simple;
	bh=kGSgzpvPUCQqEaqOJ7THNprY7qCkQbXWl59d177c2gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNOmkBT5acRIXof+CXeQ0prRHI/p4OCQ1U+co/I19VOSH5hgrgEz7urkrzv8j1Y5Ep7GDtFp44DwK87cHld1SkJ7fu2Ctb/PPxugHos86xzvlvP+TCuezUfJTpdXsTyHa0Q95+SNhyQVUVAf9MwlyGBT5PaeXpWZnSHXsHpYIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICxk8hGL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso3633164b3a.2;
        Sat, 19 Apr 2025 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745092739; x=1745697539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbaEjgdfu/mykUDUL3cU1smJ1vqTKghQosLItRyq4gY=;
        b=ICxk8hGLEUR9uU6gOwlh+6xhPEjxvVJkANr0WqafFZubmJsM6gMBRjbXILnQIBtSnW
         UmCu9YjQOoCeoqUcRCWnLbvwHw8ILdre9d3Ky1tYmKjq/O6CZ4vBRSLBBZlnX3iOUJID
         00MmqfiLl3NVmOhQ3kHbnvHRI646C0C9l0j7oJcsfSc1acjQJzZ1D+sD1XVI5VY0+Xzm
         jh6s8z2qO2b06zipsojNu1HXOWwD8pQGIC7GhoNVpuRW0wPm7XPyVN5+4pD230ws2aDc
         vJZrii1xFbY4J/EwzRQOTKI5b091yribS+Z3AOF9gV/gcztJnME7kt/3sgTP06gUJvgM
         eZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745092739; x=1745697539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbaEjgdfu/mykUDUL3cU1smJ1vqTKghQosLItRyq4gY=;
        b=VfATi0bIGkjJbz3bz2g8LeSbXVcbvQ4+c1QY040y30O89wUwsuVAu6EPY1r5OVRr87
         pQ50gnymta4hAzkx/vK1AK5/8mCd9JvyWGUTRpIRevgaTq745N+3yZbV8Kas2/Er1yXQ
         ed2KObmxq/AdWjCmQEsqN5engRSuwpvihi8KzlNqyh+br++hgC6IOnK4yUVq3mnk9hzn
         aAw8G3evhWPhmn/MvBgByNNjkCXPKDGkFqT/D8t2CdbstTxUP0FEGBbolOAhQnW04yb+
         vdXgeTZxZkoAxaN9D1ibvYKeiQjpRGwEjaii3g/vNqt93aLJdx4TOx8bh88TkuPRF8ML
         Yv5w==
X-Forwarded-Encrypted: i=1; AJvYcCUiuDjO/423BUN0+OzuoGD9UiaQIMx9hAMvzStL8yAuFnMsIlppceD3OzdGLeCIVNLxchog7UTnvkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwODOf9VbChiZubporEYYus1bYBAwB5bWSHPOEqoHfPBmO7PY2c
	DVzMckQSFMB5zcDbJ72RGFE64Qh62yV7PBo/dypUqempXl1jKbLa
X-Gm-Gg: ASbGncsrVMLtPfF71hNTisafJY8GrkzDsPCRswhQieQqqqq15uwcrkJYVEEKdgA7/gR
	PpjkJLqww7rIiBrzxNypk273q1jDBTEv8apd2b9rv+AshUv8Nd0o1DTtZfAWDU6lAx7eDw45GuE
	pNaeCXAq2atMr/cmP2X4Ivx/QuiNu/ahARYQUmOmsWsP3VBYFlp8EnXYkJ79LHwpqu3xapmyXI5
	IxGk/JFhcUiHu6QVGA24TUBBMUBxVPM88gxTyvRdvdZJXHcblwYmEVtBBvp+E2sDjyDT8aEVK3w
	l4/NB3K70IzzV760LPVVP6zOd68frxBYov/iks6KCPt5lUCxgb+x+5VsRyr1
X-Google-Smtp-Source: AGHT+IGqVwOBqxMrdDB+AkyWTGUwyFDKAVlW72ssAFKEbrQAlDP1cTYOSqpMV8ErXO2sVclYrtvcpQ==
X-Received: by 2002:a05:6a21:9101:b0:1f5:80eb:8481 with SMTP id adf61e73a8af0-203cbc2801bmr10487499637.13.1745092738671;
        Sat, 19 Apr 2025 12:58:58 -0700 (PDT)
Received: from localhost.localdomain ([177.10.12.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db1273edbsm3203195a12.8.2025.04.19.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 12:58:58 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v4 3/4] pwm: tiehrpwm: ensure clock and runtime PM are enabled if hardware is active
Date: Sat, 19 Apr 2025 16:58:30 -0300
Message-Id: <20250419195830.79053-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250419195555.78933-1-rafael.v.volkmer@gmail.com>
References: <20250419195555.78933-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During probe, if the hardware is already active, it is not guaranteed
that the clock is enabled. To address this, ehrpwm_pwm_probe() now
checks whether the PWM is enabled and ensures that the necessary
resources are initialized.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index cde331a73696..23530d53e177 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -583,15 +583,50 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ehrpwm_pwm_chip *pc;
+	struct pwm_device *pwm;
+	struct pwm_state state;
 	struct pwm_chip *chip;
 	struct clk *clk;
+	bool tbclk_enabled;
 	int ret;
 
+	u16 aqcsfrc_reg, aqctl_reg;
+
+	u8 csf_bits;
+
 	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	pc = to_ehrpwm_pwm_chip(chip);
 
+	pwm = &chip->pwms[0];
+
+	if (pwm->hwpwm == 0) {
+		aqcsfrc_reg = readw(pc->mmio_base + AQCSFRC);
+		csf_bits = FIELD_GET(AQCSFRC_CSFA_MASK, aqcsfrc_reg);
+		aqctl_reg = readw(pc->mmio_base + AQCTLA);
+	} else {
+		aqcsfrc_reg = readw(pc->mmio_base + AQCSFRC);
+		csf_bits = FIELD_GET(AQCSFRC_CSFB_MASK, aqcsfrc_reg);
+		aqctl_reg = readw(pc->mmio_base + AQCTLB);
+	}
+
+	if (csf_bits)
+		state.enabled = false;
+	else if (aqctl_reg)
+		state.enabled = true;
+	else
+		state.enabled = false;
+
+	if (state.enabled) {
+		ret = clk_enable(pc->tbclk);
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret, "clk_prepare_enable() failed");
+			goto err_pwmchip_remove;
+		}
+		tbclk_enabled = true;
+	}
+
 	clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
 		if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
@@ -626,6 +661,15 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (state.enabled) {
+		ret = pm_runtime_get_sync(&pdev->dev);
+		if (ret < 0) {
+			dev_err_probe(&pdev->dev, ret, "pm_runtime_get_sync() failed");
+			clk_disable_unprepare(pc->tbclk);
+			goto err_pwmchip_remove;
+			}
+	}
+
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
@@ -637,6 +681,8 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_pwmchip_remove:
+		pwmchip_remove(chip);
 err_clk_unprepare:
 	clk_unprepare(pc->tbclk);
 
-- 
2.25.1


