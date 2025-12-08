Return-Path: <linux-pwm+bounces-7784-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C24CAD93A
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E4A2306B17B
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5287930F948;
	Mon,  8 Dec 2025 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeENbSih"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1B2E92D1
	for <linux-pwm@vger.kernel.org>; Mon,  8 Dec 2025 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207306; cv=none; b=ubTkAhDto/Ipu26DRvXawEVu0IODB/VIkNWAPcz3ic9WheXxj75jXT6sdwTxPNT53w6HeTabzX14NT5606PR4rsy+DtFvaPdA+h3a8rLcKijxQj3eeINqlsZ8qotvomVNxJ0RIQZd7qIHUHoQz9KnrBiiyNvngEqaV/+AUUcoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207306; c=relaxed/simple;
	bh=M3SL8PolX24n7yB2arA6GbGjS0d0mvu6DQZ2mMbXRrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgH74pzpQDnWGUNpbahdhVVbvyL4oLkCOnQ3zm0fqydXnWr3rfLHqQVVHioQkz+hzlSjAxaoUziqsSU3e7+VA9yL+Ax6sfWLHmk5y/kI3cXLa6nw4Dpp9cPAL4YUMCWXHKGhmGxr4do3zI7wPTsBZ/8s/jbySJ016PGcAQrsgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeENbSih; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso8073048a12.2
        for <linux-pwm@vger.kernel.org>; Mon, 08 Dec 2025 07:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765207301; x=1765812101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYadcy1JHm8Mv93vS93czQrJhCISZAfZkmHzpoqS4TU=;
        b=BeENbSihXRrp9hOhaoq7cS7agoCn/3e3QsqRPqC/1ZEesbPVQcPcemHuVrgrM5W24n
         NZoJbb5LWERKEyZgnkRRYypMuqLhC0IsEaGpAd9l/JKES9epA5FdfQ0ERI4cx9oNKBJH
         kB4AZxRR5FihIkkHTSXLLlmZvA7+WP2n/Bz7c5VLSRjMas6aC74mbc7PyVjyI3A+f77x
         HImQpt774+IIdudZN9CaKp1MDxvFrH3dC/aOCWHupECQxHS57A+3d1fATcT0ahyARTEM
         7JOjqUgdTV9ZLLx1XKeghId7tsBZ084tbrTBhSqGUGtciZ3B3SYetCtgNyMFf9FqQdHG
         PTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207301; x=1765812101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BYadcy1JHm8Mv93vS93czQrJhCISZAfZkmHzpoqS4TU=;
        b=k1jaFXh/BDXkFkWS8ubh04jCb3mhtHiIcali3N0ojCr6TyywjTMKQdzZ/6VvfwquFn
         7ufANBeda0ZMr+GuaO7W1geMCZxQTBodxuJRuJV4ENukBAQPV2BcUge2Z6HPyz7J8xjk
         j82SvKpz7dDfmc1o3/3omEECjFH1bvde4FEL6G3tcVpu35mpupOhr011kylNn3hz3yWJ
         GvR/89qr1dzJAG0iqoFIb8UMkGNtjUCRqqi8QzTZXYXzOcUadq1td/dSH/W/vbkkVvMP
         WDSEXu9zwQ7/UBCB+KTrO87+DjLxicusT4H+Q1Eu0DzoYaF6yDotw7obqh0KQwHx3Zum
         +oJA==
X-Forwarded-Encrypted: i=1; AJvYcCVU/DNd0+IUX1pa1QHClpetdTh6pm63DxP7K+bfCNmzSt8BnqqIAxJNAPtHcO1yejn3oAwP7kgHNRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhtWDfVBy/SdG9bJVfX9wm1xLEf0G7y2NAJJApMa1DPwNVAedo
	DlyFmqJ61atW9Odc0IA+9/CN/hxsLTtgBWUCbdj9YbsT2QAlA+LRU51w
X-Gm-Gg: ASbGncuzNGT2BdQI5OOCvcsK0jtiyDYWdCBdE73RLswIofT4P2BayeHtrfV6qcvyvb5
	dlGqiiW7OqEeBJM+v3WbMnc4af4IPohjB6q65V7QhfBERqe2RhYBvFKBb1A9YTITgbKqlQBUWOb
	z2jNWE2ObJyYsB5a78EbA6yGkxIwXTB5G2Cv/Yy8liPPTrnLwmTAX79IFybRcBTdIaf4yXfzbbY
	eJ+QyQDCeatco0LJawbBkIn9v1psrMJ1/YTNlzQNUoJQdvseYOg44RlJKybtbFglq5EGg2Y++pl
	hnjvMhKzqHSYxs5HGes0632lAGXdqdH7jtWN0ovw5evKkSLwq6/vpu8EoG2Pj0xUD/z02Pa1XFE
	lb84XWCab6SuBq3MXxgSEL8MO/wMmJVMR/Ayfz6/iWHtLKpRWf2zewKpdszF9EsRWnBZBU9aNmJ
	2uNq2YOkWxUY5BnPYMfXumXu7wt3u5YbipUEMizayHmc3YTrJctelqeZlUnBkNpcBv8NlEa0Kps
	iTyx4WcQT43JO4/
X-Google-Smtp-Source: AGHT+IFajoINpwBqXOy10Wn9OzjgBX7BwKqp9BWgU6u6VB/UL3dqVJGLcyrrYRTfzfsMfIhwr8gSPA==
X-Received: by 2002:a05:6402:2356:b0:640:f2cd:831 with SMTP id 4fb4d7f45d1cf-64919c1f900mr7242886a12.10.1765207300669;
        Mon, 08 Dec 2025 07:21:40 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b412deddsm11547484a12.31.2025.12.08.07.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:21:40 -0800 (PST)
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
Subject: [PATCH v4 7/9] pwm: rzg2l-gpt: Add suspend/resume support
Date: Mon,  8 Dec 2025 15:21:24 +0000
Message-ID: <20251208152133.269316-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
References: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
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
v3->v4:
 * Added error checks on suspend() and device set to operational state
   on failure().
v3:
 * New patch.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 132 +++++++++++++++++++++++++++++++-----
 1 file changed, 116 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 79ee59271d24..4eac35390c60 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -90,14 +90,26 @@ struct rzg2l_gpt_info {
 	u8 prescale_mult;
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
@@ -462,10 +474,8 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt;
 	struct device *dev = &pdev->dev;
-	struct reset_control *rstc;
 	struct pwm_chip *chip;
 	unsigned long rate;
-	struct clk *clk;
 	int ret;
 
 	chip = devm_pwmchip_alloc(dev, RZG2L_MAX_PWM_CHANNELS, sizeof(*rzg2l_gpt));
@@ -479,27 +489,29 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 
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
 
@@ -526,7 +538,92 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
 
+	platform_set_drvdata(pdev, chip);
+
+	return 0;
+}
+
+static int rzg2l_gpt_suspend(struct device *dev)
+{
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	unsigned int i;
+	int ret;
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
+	ret = reset_control_assert(rzg2l_gpt->rst_s);
+	if (ret)
+		goto fail_clk;
+
+	ret = reset_control_assert(rzg2l_gpt->rst);
+	if (ret)
+		goto fail_reset_s;
+
 	return 0;
+
+fail_reset_s:
+	reset_control_deassert(rzg2l_gpt->rst_s);
+fail_clk:
+	clk_prepare_enable(rzg2l_gpt->bus_clk);
+	clk_prepare_enable(rzg2l_gpt->clk);
+	return ret;
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
+
+fail_bus_clk:
+	clk_disable_unprepare(rzg2l_gpt->bus_clk);
+fail_reset_all:
+	reset_control_assert(rzg2l_gpt->rst_s);
+fail_reset:
+	reset_control_assert(rzg2l_gpt->rst);
+	return ret;
 }
 
 static const struct rzg2l_gpt_info rzg3e_data = {
@@ -548,10 +645,13 @@ static const struct of_device_id rzg2l_gpt_of_table[] = {
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


