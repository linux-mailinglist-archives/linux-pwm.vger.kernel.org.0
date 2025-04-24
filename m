Return-Path: <linux-pwm+bounces-5680-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4804BA99E1F
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 03:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF515A5196
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 01:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46EA1C700B;
	Thu, 24 Apr 2025 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjdg5Xn8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271341C7F;
	Thu, 24 Apr 2025 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745457920; cv=none; b=ScZqkWBo9kxHrph34jkFI39U2C40FydJXr8lKwx/Ay/jyHHKxHGVkmuxiZOhCAC7ci5Exyut21Uv/8zirlnwEeY1QAWdKpw2siXrRdziUWyEWXjbQqlxo89qwqZCEjyZISs9q1/BXG5xIMko+CMe4pxcdTR+lfIcuhLyoS9AOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745457920; c=relaxed/simple;
	bh=KVPIWLMbsRzdhWS/MzSM6OjFjPRyaTi+mNpqH0dKv1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4ptb0Wl3ueE9slBlp1EC8HUejWRI1taWN6g4uwpSMwuWpmcM5mwMKFELR//aVGcsBNbS0bBQa14cvXLWvRtHG2nep97qnJsg7MkERwVsUUPDlm/gb2C8SspA28/qp8zdK90KmFCbCVmwDg5w0TSqcADiSYhblOPZmXb5WLUIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjdg5Xn8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736c3e7b390so388051b3a.2;
        Wed, 23 Apr 2025 18:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745457916; x=1746062716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHhp31roZ+6LDh1o6IeC+4GGTrHD68JTiVVSEKfH8PU=;
        b=hjdg5Xn8sOCtQeEFKImTmKDZbsqd75nfW3FfcXRIrw1sUPAc0thxS+EsjA7/1y8Nq4
         vAARkB31A+npfzD4iCeoEXDH/vOZgoWHN4O46ngQJSwpKH48nC2lL+p/KFH7HbfEVEVs
         o4wvaMKfLvu26AbToXsjU4ix5J1wPXIuRhUUQwCeokO5DqQjX3Ft3b4qoC3AB1wYfNf2
         g4ZjoqKsGhIjeGTTuRTYSjgcfbVkXpMylypzRbmrcNWm/yTE+qmbFLfC+UroWCQleK0P
         F/0txrvfV7UptmUS4fGqDkeH/Njsnc8yGq6IlSSGjUcitKdaWosU6vM6No5oGEcsDja6
         3EQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745457916; x=1746062716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHhp31roZ+6LDh1o6IeC+4GGTrHD68JTiVVSEKfH8PU=;
        b=mat/UzH4e+KOTmYRYgpXnPGJ1rJMIYqhhM9mwU7Dkzw9GzYrFRHAca2P1inJLOxgdV
         F4ajWw290eAHD2CYgxO+HzlMRoPmcuDAgO+UUtxDh/lqqLUbn3tMKxaV0wpX0QSgZ6eV
         o7Ycs2RE4usDsPR9SIyl4rHXbAhuveLfuSk87z1KEgDEvbgQ5vYULlAzWAYfieLNkkJr
         /GvZWKsEX3/5jc4VjhBd6KsNmJSc1b78maiGh+OUEAvmAh/fPqod1AceX06EPAi8MEGM
         nr7S7QgOAqfI0h6PAqPY0RF2CQZODCKnuNhItt76cXZgdGgHcEWqc7eKdvhd5A46wzUW
         bGmw==
X-Forwarded-Encrypted: i=1; AJvYcCVlvRtc/D7JZMjDRmNIpP5HbyRAI/Wby2GJ7LHRA5tUeR4SwYA347dttCIjXd6EFO/ShhfLEtisLx1Zbzn8@vger.kernel.org, AJvYcCVmGqN6J9HIG8vmVcf43VkZCj3Q8t+8C2wWzkc+vedDl7oHEVZXORjnVSbmtWd+bXh8mXQ6POR6dXAB@vger.kernel.org, AJvYcCWBGOIH+0S+Kqdxgtgbi/27g2eVU92Se0zf3FE4WqXgB8RgnC5AWhQn4vdvgV3Zm7cDz9gznzDSguF8@vger.kernel.org
X-Gm-Message-State: AOJu0YxvF5MerZpM3YGp7U0q1fVtNFyP6Q21X28VUaIg8KqLcLOWqPDE
	yZ5sFo2vi3RtuuqQR0iQYnJugFkdlXBiQj3fEWJWSoD33QEVbmP5
X-Gm-Gg: ASbGncujBmsxKZZgEntkusRcWJVfbuhel/GpdkUa6ykqISbMeipnzuKnhBwH45u4npQ
	Xcgfu2SGhEjt1ccIhRofdDjLJf32G5E1CTRLF1q6tVJjjQw1s14RHQ6w7mWcwomfEoyWvLFI3Vy
	/ceoqONxonQ4M/sgajQqxuIlVvpbo5+0X5VMXRHQACscAMyZdTP2pxGhUWBoicWgueWFytLiRZa
	rqS6MWc+zKWrwETIduM/vBDNwMfi8Ud++FqPuk8fYI+OrLTAL4suzBvkZQCxDOdLwvFwUlHOZ8b
	lKYWSleAemVtRqzHEfXrzz90MP2EVlARurz2+ObPug==
X-Google-Smtp-Source: AGHT+IE2Y06oom0THOKytAAa5C8ft5qxXgEsFNfjUdq+LSQjNK7WQZeefRGGp10gDRSNC/JoSehfcQ==
X-Received: by 2002:a05:6a00:3a22:b0:736:32d2:aa93 with SMTP id d2e1a72fcca58-73e24cfa09amr1289896b3a.20.1745457915959;
        Wed, 23 Apr 2025 18:25:15 -0700 (PDT)
Received: from cu.. ([111.34.70.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a8cdsm231049b3a.115.2025.04.23.18.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 18:25:15 -0700 (PDT)
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
Subject: [PATCH v3 2/3] pwm: sophgo: reorganize the code structure
Date: Thu, 24 Apr 2025 09:23:27 +0800
Message-ID: <20250424012335.6246-3-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424012335.6246-1-looong.bin@gmail.com>
References: <20250424012335.6246-1-looong.bin@gmail.com>
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

