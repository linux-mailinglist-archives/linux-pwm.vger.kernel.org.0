Return-Path: <linux-pwm+bounces-5732-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC46A9E5CD
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 03:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16DF7AC5DC
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 01:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00691632DF;
	Mon, 28 Apr 2025 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inGTE+gz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1C14BF89;
	Mon, 28 Apr 2025 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804163; cv=none; b=hkQfrDzL78195P6hYJKZ5QGxQDF1XuEa+NblZO6xilFgYY2RLDHoxmRCdCERfdqMbx8qmAFa20KUVJvLWoOCueJwBbfRhWAYKCsCvNt5+16kpr50YYYst8QI7w5TEZ4m2TqoVV7bXfENMbjDvWLkQM5hx5esz0YiM52LBx+u26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804163; c=relaxed/simple;
	bh=KVPIWLMbsRzdhWS/MzSM6OjFjPRyaTi+mNpqH0dKv1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMP/nSO1qLr4HicrZQ+PlctQNAgTPpbsDLMTr88HEPvRAZHr6r55TPnTZtcPy6sHOKYIjXFddQvk+i3yKcGEe5YdK0JTBcme3x21OahexNhjjNcKr3qjmvqucbphFhs1YUyFRZNiRIouNkERDOuidctUlzkKS9omB4wVBwYhmkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inGTE+gz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3031354f134so3477189a91.3;
        Sun, 27 Apr 2025 18:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745804161; x=1746408961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHhp31roZ+6LDh1o6IeC+4GGTrHD68JTiVVSEKfH8PU=;
        b=inGTE+gzjFJghBN9J97osRjZYHMC/N/TU4/LOVsiK9sq5kREQGhspnkb7tFTsQER7y
         jWar8cUUrbXI9hQAdqSrgzuvEjqTyt4Y+aBNvviu1j7EMKik5AXtPtgny7HsFF1S6RQ8
         EMJojTMGXQP4KN7PyAefYhio9CVUEK9nwQS5Erg5V1cl7rGeF212s9MmaIm5P9Fv13Jz
         RZSyZb4qvEU7WVKcLHnmG4kDFMkA/0puqS5tTjx/JOxOilldPSUJpktJpBG+B0Oak0Yv
         KRlq5WWDZh3f8Ga4yfX5J0jofoyzZ3Z0WmqCE7059UlzFMtiNjcygmIGhLuXt6dHRqJD
         vBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745804161; x=1746408961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHhp31roZ+6LDh1o6IeC+4GGTrHD68JTiVVSEKfH8PU=;
        b=soo1dsEu9/jNi4tnIXVd2HGyRAziIMNB2y26J/T/+cyeB41RqUOttoDGV7B0nFRdCW
         rulIHBWABR7QRNspFIVxXYvk2CfpxN5lmMZxSXpcojBV/yLywcvjj+zBciHp19p2kbKA
         Exm0WQpibzzVRBaLG9REtewf30CtE09c/3+DZfmhGTliAkmjhOW1EWLBrmxmFTS0uanT
         47DZvQni4WkcOfPZ19+4wibOISBiTSI6+UZAKb5ev1oaJD59BpnE76l+AIShrQn8aQpM
         FPnpnwRtsuyZZZb1Im+OmmUI42XNX8l+/tPtCq3HL21Z1e1aLfN3EIuRusP2uIbPbkyN
         FCTg==
X-Forwarded-Encrypted: i=1; AJvYcCUjQpJQB0xGMIF2R4iW345TZL2LzqLxkAmummVls3WuX7eveAAtpbX2BKhEF2Xy/1GSGNALs8G32R1+wLsY@vger.kernel.org, AJvYcCV0nYkb/TyQOErYruu8YBJ5GjW9SFvMBWk4Jm9WIUBEgzAArZgVDwC9OTQSEeahNgPShx1bhJwMWIzf@vger.kernel.org, AJvYcCWDulecnZK6r/NSCElkj2aMGMG7psM4mY2Bag4V/dS1JVfWgd9zyeOJcSRjnab2N1EnyT6W6T9y9Afp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5u3haw0ZDY12JQeFObOmZj9LmCSCi9YoHYqr4ooWiOTDQHjDb
	yV87dqsu9kaHteQdHvdzwQTo3Zi5Ye+h4JVCO3ioawDzwJuRVERE
X-Gm-Gg: ASbGncvrCEZGKTPaygyuVNEj3szsCn83v8wqfrRzrTwM7UeEWfnoSKvR4h0YxXxhul4
	jFe+P+biGJQz4AnBTJ8ZAmoFct08f7dbi3NahhelFZb4Rd60cC823qj1ijuF6afWvirW2J3mIO6
	mZBZBHrquwGFHmcm8gwLFbyQKIk/eCllCG/2FFLLEko7DAc3P3m85w2311UpUWODZzr9iO+nTcT
	1RFwswG0Fz08Z81zOZTxNzND4IVXS2l6b49SO4UVFYI3tCa0BvMDneRa2ou/Pl+FiZSk0BM2bky
	bFN96m1j9Bhn
X-Google-Smtp-Source: AGHT+IEBUsVDhTbQCZ3hLDGrgjru+S6KyHLsCa0Or036h9tHeTodcy1s7CEeSmJmugTf+EVD8kpJyw==
X-Received: by 2002:a17:90a:d64b:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-309f7d87c12mr14363027a91.4.1745804161420;
        Sun, 27 Apr 2025 18:36:01 -0700 (PDT)
Received: from cu.. ([2001:da8:7001:11::460])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb26sm8508671a91.6.2025.04.27.18.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 18:36:00 -0700 (PDT)
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/3] pwm: sophgo: reorganize the code structure
Date: Mon, 28 Apr 2025 09:34:49 +0800
Message-ID: <20250428013501.6354-3-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428013501.6354-1-looong.bin@gmail.com>
References: <20250428013501.6354-1-looong.bin@gmail.com>
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
---
 drivers/pwm/pwm-sophgo-sg2042.c | 62 +++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
index ff4639d849ce..23a83843ba53 100644
--- a/drivers/pwm/pwm-sophgo-sg2042.c
+++ b/drivers/pwm/pwm-sophgo-sg2042.c
@@ -26,18 +26,6 @@
 #include <linux/pwm.h>
 #include <linux/reset.h>

-/*
- * Offset RegisterName
- * 0x0000 HLPERIOD0
- * 0x0004 PERIOD0
- * 0x0008 HLPERIOD1
- * 0x000C PERIOD1
- * 0x0010 HLPERIOD2
- * 0x0014 PERIOD2
- * 0x0018 HLPERIOD3
- * 0x001C PERIOD3
- * Four groups and every group is composed of HLPERIOD & PERIOD
- */
 #define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
 #define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)

@@ -53,6 +41,10 @@ struct sg2042_pwm_ddata {
 	unsigned long clk_rate_hz;
 };

+struct sg2042_chip_data {
+	const struct pwm_ops ops;
+};
+
 /*
  * period_ticks: PERIOD
  * hlperiod_ticks: HLPERIOD
@@ -66,21 +58,13 @@ static void pwm_sg2042_config(struct sg2042_pwm_ddata *ddata, unsigned int chan,
 	writel(hlperiod_ticks, base + SG2042_PWM_HLPERIOD(chan));
 }

-static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			    const struct pwm_state *state)
+static void pwm_set_dutycycle(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
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
@@ -92,6 +76,22 @@ static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	pwm_set_dutycycle(chip, pwm, state);

 	return 0;
 }
@@ -123,13 +123,16 @@ static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	{ .compatible = "sophgo,sg2042-pwm",
+	  .data = &sg2042_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
@@ -137,12 +140,17 @@ MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
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
@@ -170,7 +178,7 @@ static int pwm_sg2042_probe(struct platform_device *pdev)
 	if (IS_ERR(rst))
 		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");

-	chip->ops = &pwm_sg2042_ops;
+	chip->ops = &chip_data->ops;
 	chip->atomic = true;

 	ret = devm_pwmchip_add(dev, chip);
--
2.49.0

