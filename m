Return-Path: <linux-pwm+bounces-6162-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41C4AC66C9
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 12:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750904A268D
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B62427979C;
	Wed, 28 May 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gScjPPHt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A7212D7D;
	Wed, 28 May 2025 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427141; cv=none; b=duD6RzjMM5fI69Ob8Xp/JMu6L7TaEoy+FGlajPfV6QLp9TfAWgOY5cCncLtlvRyyzyKyPfkGogVc0yCn+PEicYzXJEbBOKjm8DUfyVbGnYipAsfyqYZgnsm2klEcNivgsWatf2fneuCiQF8ccw9GAuSgfV2FENbLfJ/5pyBFCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427141; c=relaxed/simple;
	bh=3fmT8a4w2c2UFK2NC819rGC2QieFNea0UjuWO8kZ5NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E27SKtJJw6PVYCd9dkd8vKpXj4paP7Il1elbzrwkP/vAvnTQDEBP8mUGkzw3heNaRTSimDqhjqu9GnNAlnUidSYIAJ7fWQMJfX7LiRL79ydXP+HqEWr9RUwR8dFqwBx3g8je/8ebKnp9FN9gfGalTHYQX/jLJFkgqg8qU82IY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gScjPPHt; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fab467aacdso14507086d6.2;
        Wed, 28 May 2025 03:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748427136; x=1749031936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZIuoUuOKk0C9c3zdfmp4xS8a8OdfkLmfezVI5NFdqE=;
        b=gScjPPHtrGqoyFYLau/Hi7HEXTpkRr+PMnzW8HDV0qanp+EysurOk3ZYEMf8JRJn8Z
         ScOo0UionNjl/r7JjzrV9zluiK3Eb66+eqy43rBmnHMOu29nZV3iwFx/fM6dzGUItERj
         XxJbmX3XXUGjBcIHx5fzY6gMj3Phk2r7eAGjl0h9+dpl7bBAuChP/lCjQ5+fs8tvMMCV
         /3dZa45ROXIXPWXzw9Djg0aK8Wz7IPZ3iniDVMcRzcUwOhVH7dntmrDdSxZvptpSB3Gi
         cd+Js7EWKG6QSGAyVQdVzbiWjGGv0X6RVhyxa48d77XPkvkDN3nAY2coxEZ7vpVC2oCx
         GKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748427136; x=1749031936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZIuoUuOKk0C9c3zdfmp4xS8a8OdfkLmfezVI5NFdqE=;
        b=o2KK67z/w6yuxVG4Eawev3QGSFpPFwdsUZeZaV/QKPLBVtYocGbvEVIw1bcKNyl8Kx
         oerWftag+LOvi2JwcCvzxUf/5sZ1TMOLndXYzM3n+bCqkIMR0lnf0rWNZTZ5HiKcV9ha
         sx7/WMegTAvSjM1d23ODYq6hY6jJVF8Pr2Y+tVoFXHhCmKogcdGFQAplcEWvflGBwZO4
         sdis2j1apATNSSarwR+++1jy4RuTy9ZGF+2S8YYzI8A70lJ/EDDPFsvEyvREQtMlcSTb
         j/zjVc0A/HhYYO+A79MSbt2evrAGTG+hKODQO6asgwO4AQk4wI0FeFjhR1Pl/KKPsA98
         Gjlw==
X-Forwarded-Encrypted: i=1; AJvYcCXZddciO7GE8V7vNmn1tKCvUFH4scVsNX5mVeR7etQzqrupfrlGyoRxHvo8VwMG1DEB1QhuYWWz1/dyNqPZ@vger.kernel.org, AJvYcCXfHx16Ey8TpwM94Z45fwEhZi7pE24vxGn3pPU0nrH9bM/h6PPq+FoCi4Y1e/amsRM49CY0gNAg4jtv@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDYdGVpoHL4lYQJqy8YtgUvurQwFoULaHN3pvv7SlpcLNfsi9
	NO96aZH9LxmCxatjcrdLuIX95vez7Q5sfWMGXBvsK81dm3wxuFtvx5tvWpfruQ==
X-Gm-Gg: ASbGncvCfnb42TyUUHTwEpcc4RXJlkwI2x2Kf5vdIq6/PhL5stNm1/iLp7AHJFPwbIJ
	9FP27c1lBmja7X50OL/rds9clj1bew3fj6sBQy1RtqvDx4VtUQ0BgeBptE86guEiHxEbuWQ9KZ0
	Cn1+gO5AjIGXRh6pi82DxE2KCEaW2iKnqz7gtn2ABkWnvY6oCbnEqglHylTpoqk75RQeEGPDN9a
	Gy1OpaaVmHo0GOXe85aNuUHztTuwmowbd3gV7lj5ou2igHgE7+2P/w6+qc2Ik+dwTlUc1Tes6Rw
	trVGiYuDaCJRCvG4568H454CaZTZjjj/RIKTDnSSlqqcdQ==
X-Google-Smtp-Source: AGHT+IFWPOwlvnziJrU1SXRbxNHI5NCoM7BJbMrItu4d5oRPG+SLE6qRrjKuSLB0YMT8eQPS4/wi0g==
X-Received: by 2002:a17:903:2403:b0:234:8a16:d62b with SMTP id d9443c01a7336-2348a16d6damr97040175ad.12.1748427125955;
        Wed, 28 May 2025 03:12:05 -0700 (PDT)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d358f118sm8453595ad.138.2025.05.28.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:12:05 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Longbin Li <looong.bin@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 2/3] pwm: sophgo: reorganize the code structure
Date: Wed, 28 May 2025 18:11:37 +0800
Message-ID: <20250528101139.28702-3-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528101139.28702-1-looong.bin@gmail.com>
References: <20250528101139.28702-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the driver logic can be used in both SG2042 and SG2044, it
will be better to reorganize the code structure.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
---
 drivers/pwm/pwm-sophgo-sg2042.c | 52 +++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
index ff4639d849ce..da1c75b9c8f5 100644
--- a/drivers/pwm/pwm-sophgo-sg2042.c
+++ b/drivers/pwm/pwm-sophgo-sg2042.c
@@ -53,6 +53,10 @@ struct sg2042_pwm_ddata {
 	unsigned long clk_rate_hz;
 };

+struct sg2042_chip_data {
+	const struct pwm_ops ops;
+};
+
 /*
  * period_ticks: PERIOD
  * hlperiod_ticks: HLPERIOD
@@ -66,21 +70,13 @@ static void pwm_sg2042_config(struct sg2042_pwm_ddata *ddata, unsigned int chan,
 	writel(hlperiod_ticks, base + SG2042_PWM_HLPERIOD(chan));
 }

-static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			    const struct pwm_state *state)
+static void pwm_sg2042_set_dutycycle(struct pwm_chip *chip, struct pwm_device *pwm,
+				     const struct pwm_state *state)
 {
 	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
 	u32 hlperiod_ticks;
 	u32 period_ticks;

-	if (state->polarity == PWM_POLARITY_INVERSED)
-		return -EINVAL;
-
-	if (!state->enabled) {
-		pwm_sg2042_config(ddata, pwm->hwpwm, 0, 0);
-		return 0;
-	}
-
 	/*
 	 * Duration of High level (duty_cycle) = HLPERIOD x Period_of_input_clk
 	 * Duration of One Cycle (period) = PERIOD x Period_of_input_clk
@@ -92,6 +88,22 @@ static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm->hwpwm, period_ticks, hlperiod_ticks);

 	pwm_sg2042_config(ddata, pwm->hwpwm, period_ticks, hlperiod_ticks);
+}
+
+static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		pwm_sg2042_config(ddata, pwm->hwpwm, 0, 0);
+		return 0;
+	}
+
+	pwm_sg2042_set_dutycycle(chip, pwm, state);

 	return 0;
 }
@@ -123,13 +135,18 @@ static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }

-static const struct pwm_ops pwm_sg2042_ops = {
-	.apply = pwm_sg2042_apply,
-	.get_state = pwm_sg2042_get_state,
+static const struct sg2042_chip_data sg2042_chip_data = {
+	.ops = {
+		.apply = pwm_sg2042_apply,
+		.get_state = pwm_sg2042_get_state,
+	}
 };

 static const struct of_device_id sg2042_pwm_ids[] = {
-	{ .compatible = "sophgo,sg2042-pwm" },
+	{
+		.compatible = "sophgo,sg2042-pwm",
+		.data = &sg2042_chip_data
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
@@ -137,12 +154,17 @@ MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
 static int pwm_sg2042_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const struct sg2042_chip_data *chip_data;
 	struct sg2042_pwm_ddata *ddata;
 	struct reset_control *rst;
 	struct pwm_chip *chip;
 	struct clk *clk;
 	int ret;

+	chip_data = device_get_match_data(dev);
+	if (!chip_data)
+		return -ENODEV;
+
 	chip = devm_pwmchip_alloc(dev, SG2042_PWM_CHANNELNUM, sizeof(*ddata));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
@@ -170,7 +192,7 @@ static int pwm_sg2042_probe(struct platform_device *pdev)
 	if (IS_ERR(rst))
 		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");

-	chip->ops = &pwm_sg2042_ops;
+	chip->ops = &chip_data->ops;
 	chip->atomic = true;

 	ret = devm_pwmchip_add(dev, chip);
--
2.49.0

