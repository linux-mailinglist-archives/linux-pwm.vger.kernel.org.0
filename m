Return-Path: <linux-pwm+bounces-7346-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD36B966B2
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Sep 2025 16:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67BA3AEE67
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Sep 2025 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8125FA1D;
	Tue, 23 Sep 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij+NF/sf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A172417D9
	for <linux-pwm@vger.kernel.org>; Tue, 23 Sep 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638735; cv=none; b=J6pZAsLV8HDV9xLbt9cHJNtKYqxO8jgbcdfo4Amp4Jy9fOp3BKGkXTbyXO39oCL/B9A+tQR5kfIuXwyoqCQ2EVAOYkaJDAyWAj5Pmx//XV1hsViNTEEjOIU6lvF9g1+URIhy/rz1Te2XlyKLpIfO2AGrvDkBarcV8xFhKENBxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638735; c=relaxed/simple;
	bh=OjsLrF0BpyixmbNmZqRDeZM8/Q9vuOqtCut1I2w6tGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajwSVTA6E71nOl7EMEdvURFd46MJxMXznVo4CvcCaE9FLhBv8hFmfiQa0HofkHyDpZv3k/1c9WrS9FF+wiNO1Fzi1n+oCb3sKzkA3XeO/Zszg1S3yVQY7jYr7McfnvJ/z7v5gUTNebc8NIateWJsKDO77oHgY2/38w7SXFfXLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij+NF/sf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-468973c184bso23424985e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 23 Sep 2025 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758638731; x=1759243531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPc1khGgtKoM3FlGkfqU+I3xy6hkWBPtPzJJrRqEf2k=;
        b=ij+NF/sfiWk+1ENFruXrQ4KJ+jnBN03VRNgTXIMFy/ZU631B99ithKyI4JJxy4SZIS
         XpVYQzQwzle/VEceSbLb8br9OdVh+7boYfCgapNaLysQLcUJkk29g3S6cZo1ZdhAoYoT
         yaSnG4BxqLNHoIKgjaP05sYrfQRE3Y9/oWJCjcwriZSzldtZe7k1PIUjQxIhG+RK/opW
         QrVBBAih3nSgVUCFalIvsTQebfOfao6h0EwBM0tyPjLue9k6TLuf9v8b+aT4uKzcrCgS
         vHXcGk+t5uaOkbyBQlpDhA6HoxYUWFLe7IplM6uZV/fFmjhxkAqrDI4OWWkUJwDxJEAz
         5wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638731; x=1759243531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPc1khGgtKoM3FlGkfqU+I3xy6hkWBPtPzJJrRqEf2k=;
        b=O2lRqSaewWq9nZ5wrk2I+4Rf328Q1+2MoyV7hVZ3qw/O7SAAFt+nLz4tV3NDWxwIz6
         o5Nj/Ri+elPGAr8oZMet6YVS0tQQZXgobkuNBruoKfDULj6mmhPq0b6XvESDjmrUjVrq
         gcnLArgavW5DgdDu4NjVVMOcV+ib0tCaUra1no7LlDTAAW5AfyQJtutT2Qkau2YPHio+
         Ztyj4jkMmfAjb1Iwj+GRkB4X3cV7WdOAGBze2LXbNzm6h7pziaH75nv/OJIFAvK9lkHo
         B6WyBP6tgzUe1oGhQN9V00Ohr+9urXKYzQc2+lsmiMeKTb6pUSTGIRVfYZDozjTy+Yzd
         BPDw==
X-Forwarded-Encrypted: i=1; AJvYcCWRbOjZJfw9KKK/eE5x+oDcg8/p8gAKrX4MjTEPeWob3mSIpPw44eoVUjj+4LJGGX8MmT8MxaUB8tY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BhLTvrZzcgW+2vwPp+YSBwRGkUO8pc8h4R2yJL4MR7SPUGSv
	pjmCHUOf0gNXuvfl/vWZiGW3WcM/TH2rp1I+8Qndrpz77/gq9EUvXiHn
X-Gm-Gg: ASbGncs5nZAeh+qmuIeriQhzLvp03QHAHKZoA1JmKgK8AD57ic6/8qrwedfTHvFtUSU
	1nBGK3gveEUpaqU4E7IDjefBniVJUBr3HogXJqPjY81dSJxz2vVNh6KnXyTTH2wxwoEzX1stTYA
	0gBPIbJLlxjD6bUTMaUQAE7B+929nbeJ2w7ZHcZSS5INZ07OcPhbmNihfM3ZRyer75OYJQWABUg
	7MxUrE1llCtzKbiNa2laohQ8V9n3sDsrQDeT14SC0s7K1s5Gv5HfCAlk7nVEe/+0CwLqXmSWK3c
	SYnILHyhcKwT6VURBaBvz1kLZLbZkYkt/CpnzblWuAPeDNBCLKISG/cRStD486XX+arirgRFPgG
	Xljh/hvF60QrK5/MtMEpHNTjFD7F21HD5HCdNe806UdOoXgGaeSz2v62Hln/CnaYUixPDXoJN+6
	y3UQ==
X-Google-Smtp-Source: AGHT+IHw/moOQQdjQkyrnN2ABVgFGjJsARhjpZqCkhFnEqOLp4++U1HM/kmTdYY+jb+YZL8vgz1o9g==
X-Received: by 2002:a05:600c:8b0d:b0:46e:2330:e959 with SMTP id 5b1f17b1804b1-46e2330ea71mr14864405e9.37.1758638730981;
        Tue, 23 Sep 2025 07:45:30 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm238940435e9.1.2025.09.23.07.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:45:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Date: Tue, 23 Sep 2025 15:45:10 +0100
Message-ID: <20250923144524.191892-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

On RZ/G3E using PSCI, s2ram powers down the SoC. Add suspend/resume
callbacks for save/restore GPT context.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 118 +++++++++++++++++++++++++++++++-----
 1 file changed, 102 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 087bc3c0778c..abf8dae52b91 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -101,14 +101,26 @@ struct rzg2l_gpt_info {
 	u8 prescale_pow_of_two_mult_factor;
 };
 
+struct rzg2l_gpt_cache {
+	u32 gtpr;
+	u32 gtccr[2];
+	u32 gtcr;
+	u32 gtior;
+};
+
 struct rzg2l_gpt_chip {
 	void __iomem *mmio;
 	struct mutex lock; /* lock to protect shared channel resources */
 	const struct rzg2l_gpt_info *info;
+	struct clk *clk;
+	struct clk *bus_clk;
+	struct reset_control *rst;
+	struct reset_control *rst_s;
 	unsigned long rate_khz;
 	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
+	struct rzg2l_gpt_cache hw_cache[RZG2L_MAX_HW_CHANNELS];
 };
 
 /* This represents a hardware configuration for one channel */
@@ -465,10 +477,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt;
 	struct device *dev = &pdev->dev;
-	struct reset_control *rstc;
 	struct pwm_chip *chip;
 	unsigned long rate;
-	struct clk *clk;
 	int ret;
 
 	chip = devm_pwmchip_alloc(dev, RZG2L_MAX_PWM_CHANNELS, sizeof(*rzg2l_gpt));
@@ -482,27 +492,29 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 
 	rzg2l_gpt->info = of_device_get_match_data(dev);
 
-	rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
-	if (IS_ERR(rstc))
-		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
+	rzg2l_gpt->rst = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(rzg2l_gpt->rst))
+		return dev_err_probe(dev, PTR_ERR(rzg2l_gpt->rst),
+				     "Cannot deassert reset control\n");
 
-	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, "rst_s");
-	if (IS_ERR(rstc))
-		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert rst_s reset\n");
+	rzg2l_gpt->rst_s = devm_reset_control_get_optional_exclusive_deasserted(dev, "rst_s");
+	if (IS_ERR(rzg2l_gpt->rst_s))
+		return dev_err_probe(dev, PTR_ERR(rzg2l_gpt->rst_s),
+				     "Cannot deassert rst_s reset\n");
 
-	clk = devm_clk_get_optional_enabled(dev, "bus");
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get bus clock\n");
+	rzg2l_gpt->bus_clk = devm_clk_get_optional_enabled(dev, "bus");
+	if (IS_ERR(rzg2l_gpt->bus_clk))
+		return dev_err_probe(dev, PTR_ERR(rzg2l_gpt->bus_clk), "Cannot get bus clock\n");
 
-	clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get clock\n");
+	rzg2l_gpt->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(rzg2l_gpt->clk))
+		return dev_err_probe(dev, PTR_ERR(rzg2l_gpt->clk), "Cannot get clock\n");
 
-	ret = devm_clk_rate_exclusive_get(dev, clk);
+	ret = devm_clk_rate_exclusive_get(dev, rzg2l_gpt->clk);
 	if (ret)
 		return ret;
 
-	rate = clk_get_rate(clk);
+	rate = clk_get_rate(rzg2l_gpt->clk);
 	if (!rate)
 		return dev_err_probe(dev, -EINVAL, "The gpt clk rate is 0");
 
@@ -529,9 +541,80 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
 
+	platform_set_drvdata(pdev, chip);
+
 	return 0;
 }
 
+static int rzg2l_gpt_suspend(struct device *dev)
+{
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	unsigned int i;
+
+	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
+		if (!rzg2l_gpt->channel_enable_count[i])
+			continue;
+
+		rzg2l_gpt->hw_cache[i].gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(i));
+		rzg2l_gpt->hw_cache[i].gtccr[0] = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(i, 0));
+		rzg2l_gpt->hw_cache[i].gtccr[1] = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(i, 1));
+		rzg2l_gpt->hw_cache[i].gtcr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(i));
+		rzg2l_gpt->hw_cache[i].gtior = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTIOR(i));
+	}
+
+	clk_disable_unprepare(rzg2l_gpt->clk);
+	clk_disable_unprepare(rzg2l_gpt->bus_clk);
+	reset_control_assert(rzg2l_gpt->rst_s);
+	reset_control_assert(rzg2l_gpt->rst);
+
+	return 0;
+}
+
+static int rzg2l_gpt_resume(struct device *dev)
+{
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	unsigned int i;
+	int ret;
+
+	ret = reset_control_deassert(rzg2l_gpt->rst);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(rzg2l_gpt->rst_s);
+	if (ret)
+		goto fail_reset;
+
+	ret = clk_prepare_enable(rzg2l_gpt->bus_clk);
+	if (ret)
+		goto fail_reset_all;
+
+	ret = clk_prepare_enable(rzg2l_gpt->clk);
+	if (ret)
+		goto fail_bus_clk;
+
+	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
+		if (!rzg2l_gpt->channel_enable_count[i])
+			continue;
+
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(i), rzg2l_gpt->hw_cache[i].gtpr);
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 0), rzg2l_gpt->hw_cache[i].gtccr[0]);
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 1), rzg2l_gpt->hw_cache[i].gtccr[1]);
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCR(i), rzg2l_gpt->hw_cache[i].gtcr);
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTIOR(i), rzg2l_gpt->hw_cache[i].gtior);
+	}
+
+	return 0;
+fail_bus_clk:
+	clk_disable_unprepare(rzg2l_gpt->bus_clk);
+fail_reset_all:
+	reset_control_assert(rzg2l_gpt->rst_s);
+fail_reset:
+	reset_control_assert(rzg2l_gpt->rst);
+	return ret;
+}
+
 static const struct rzg2l_gpt_info rzg3e_data = {
 	.calculate_prescale = rzg3e_gpt_calculate_prescale,
 	.gtcr_tpcs_mask = GENMASK(26, 23),
@@ -551,10 +634,13 @@ static const struct of_device_id rzg2l_gpt_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
 
+static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_gpt_pm_ops, rzg2l_gpt_suspend, rzg2l_gpt_resume);
+
 static struct platform_driver rzg2l_gpt_driver = {
 	.driver = {
 		.name = "pwm-rzg2l-gpt",
 		.of_match_table = rzg2l_gpt_of_table,
+		.pm = pm_sleep_ptr(&rzg2l_gpt_pm_ops),
 	},
 	.probe = rzg2l_gpt_probe,
 };
-- 
2.43.0


