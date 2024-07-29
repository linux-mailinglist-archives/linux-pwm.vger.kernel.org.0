Return-Path: <linux-pwm+bounces-2929-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D393F855
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 16:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180681F22BE3
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8730715B561;
	Mon, 29 Jul 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3YIdM1lB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4F15B546
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263723; cv=none; b=ixV2yBXBeKEN2YD2/8fK+gZZeQxgPnhEBEfB1qIysB94rExC9Ie+xvIZ0nbSUoWbi/TAuuMNDIdwgPPeTtTqPhs7wOYBzK89Gq+zMPWnQXj3lBf4bFV97MsMmI1TGE9SNZMS2UbCzAPK4XofvRPbSc1RpC/ksv9cH5U6JGjnrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263723; c=relaxed/simple;
	bh=rd3iGZlags0xCY2CaNWV3yMfgo7/ugpYl4/3RZTxNCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSmRNgd1qA46Zhfkv++sCAX8Jy5Z3Msg0dxcTJefguyt8nHT7vz6F5kPBJVYA1qj1BsjH8Qw2hvm2c2r3ogBiXiw5zMq1b9nNSOGZ2s9DiFETIl1mXo4yieJADl5NS4m2xDrqRFGlvQITT7BVlvzoXexjEemq3Za1eH03Gtrv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3YIdM1lB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428119da952so17023235e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722263720; x=1722868520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2QznIvsNt9N3skUO5kcGaDAxTNGh853gMo3fAl40As=;
        b=3YIdM1lBu8RYZnW3Ejbs1XHZV9WeQ9zm/aNTGkmCXFvlkBD+8+iwJ+ypHx0yWGKWG+
         BGF9kIYuZRTqSpsXHCiSYnUAKIvDBo4kZ8P9vj2+s6UY6xr6rbAvtIeBbscwWnBUVBh3
         w88TIL1JCpB3LsnkKwefPSolR4n8/ep81SI9JUGEhDVNFgBw1xH76daO1c1IUFG4Rr3r
         xS2s3u3Hi0GOkZyot0N+jnGnGOF1tNTr5vLRsKrRszVx61SDHtRSulccqSHNjvFL+hCP
         WAmmpPyWjr2GsaJBQ3j4/C+ROBabnvf7i+PrtfTh8eZOrvUexwJhHIoxsxNfSQ10iePI
         mmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263720; x=1722868520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2QznIvsNt9N3skUO5kcGaDAxTNGh853gMo3fAl40As=;
        b=YN+uDrbGPQqS+X6hpIa6klDOARDyaLxAb01BRQgZqen8K1jH1FyllJabWLznqSxOlA
         tPECbUktL0G12+UAPooVUG2V66BsycF6WvK+Yngkr6qamwUCcTNBKJu0ksrYYVSJh/lw
         i6ZgHleekiAhmHHDZgNz0ovWtgBmZea5DUVCtHJUenFzbtudOfOUVommJe58I4nxJhs6
         JP89a8RRM7tRCyD8tly4/sXkORl3b18CT4Jm/EtAR7ksruLHvqBDdO35y2a5w9ORFgg2
         52WFZkHOHgftGEHlhRJ5y5WOw/Pz5eMUY3mU7gNdomL0/xhuUFoOUo9Yt0yd0aNCuz3M
         Uyzw==
X-Gm-Message-State: AOJu0YxjK6A/u7j4R1ufG8Zbf9cZola6F8OH63ZrzNyv0VsZAkp+zTW+
	k3+lIhdQr4/D9Lol4grzN32scb6v/6yAo/5soffPqhar6DSqsPbQEb0tpORqTJ5hE/asdHOSIx0
	2
X-Google-Smtp-Source: AGHT+IG+iyVvwEXIl6cK3wbWccWykjy0xrJGHpaxtzblwflZ0pF7T7Dwgeyzb9tzUtmEq3va3SMCRg==
X-Received: by 2002:a05:600c:1c83:b0:426:622d:9e6b with SMTP id 5b1f17b1804b1-42811dd79fbmr51440925e9.23.1722263719843;
        Mon, 29 Jul 2024 07:35:19 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:59dd:510e:47d0:643f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280f027411sm119125305e9.33.2024.07.29.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:35:19 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v3 7/8] pwm: axi-pwmgen: Implementation of the waveform callbacks
Date: Mon, 29 Jul 2024 16:34:23 +0200
Message-ID:  <0ad43a94b89f8a298217dbbd376abd802dd98cbd.1722261050.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6920; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=rd3iGZlags0xCY2CaNWV3yMfgo7/ugpYl4/3RZTxNCI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmp6h+hX8q65hCZu2tXobl1AaTDedrIOh2BsKm6 sU6Hsh739SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZqeofgAKCRCPgPtYfRL+ TjGVB/96QmoAevMluMZVbXC//fL41UpOzdrv74lNmayoz7gOv+TRx1Yn/feVlxAYTliH26Y2EQA cSjdOdMbVGg3XeN4DlYTqopDsfaEk4xT08S+4KcUCs26uXRDYL1CTU/Zyre8Vt61a8tB2eE102I KpQH6JAJ8qM6jRUgvvYy5nhRkPu5jktFjhmWKLGjd4hg2Is+k9UboXVXsp73yBb6LKTKffg74nA pnJQuOIqqXYnn9LK0NPMjdmzcGjuFMZxG7u9mhsvNrohaer1UJI+nc80fwIZo89LPtgP18kcDDN lD/1Z1nNiDXisCaLXD5okmpxW/AUh1rqN1A/uNviTrJPP8n2
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Convert the axi-pwmgen driver to use the new callbacks for hardware
programming.

Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 154 ++++++++++++++++++++++++-----------
 1 file changed, 108 insertions(+), 46 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 3ad60edf20a5..14c3274b551b 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/io.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
@@ -54,81 +55,142 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 	.max_register = 0xFC,
 };
 
-static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			    const struct pwm_state *state)
+/* This represents a hardware configuration for one channel */
+struct axi_pwmgen_waveform {
+	u32 period_cnt;
+	u32 duty_cycle_cnt;
+	u32 duty_offset_cnt;
+};
+
+static int axi_pwmgen_round_waveform_tohw(struct pwm_chip *chip,
+					  struct pwm_device *pwm,
+					  const struct pwm_waveform *wf,
+					  void *_wfhw)
 {
+	struct axi_pwmgen_waveform *wfhw = _wfhw;
+	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
+
+	if (wf->period_length_ns == 0) {
+		*wfhw = (struct axi_pwmgen_waveform){
+			.period_cnt = 0,
+			.duty_cycle_cnt = 0,
+			.duty_offset_cnt = 0,
+		};
+	} else {
+		/* With ddata->clk_rate_hz < NSEC_PER_SEC this won't overflow. */
+		wfhw->period_cnt = min_t(u64,
+					 mul_u64_u32_div(wf->period_length_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
+					 U32_MAX);
+
+		if (wfhw->period_cnt == 0) {
+			/*
+			 * The specified period is too short for the hardware.
+			 * Let's round .duty_cycle down to 0 to get a (somewhat)
+			 * valid result.
+			 */
+			wfhw->period_cnt = 1;
+			wfhw->duty_cycle_cnt = 0;
+			wfhw->duty_offset_cnt = 0;
+		} else {
+			wfhw->duty_cycle_cnt = min_t(u64,
+						     mul_u64_u32_div(wf->duty_length_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
+						     U32_MAX);
+			wfhw->duty_offset_cnt = min_t(u64,
+						      mul_u64_u32_div(wf->duty_offset_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
+						      U32_MAX);
+		}
+	}
+
+	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> PERIOD: %08x, DUTY: %08x, OFFSET: %08x\n",
+		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
+		ddata->clk_rate_hz, wfhw->period_cnt, wfhw->duty_cycle_cnt, wfhw->duty_offset_cnt);
+
+	return 0;
+}
+
+static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+					     const void *_wfhw, struct pwm_waveform *wf)
+{
+	const struct axi_pwmgen_waveform *wfhw = _wfhw;
+	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
+
+	wf->period_length_ns = DIV64_U64_ROUND_UP((u64)wfhw->period_cnt * NSEC_PER_SEC,
+					ddata->clk_rate_hz);
+
+	wf->duty_length_ns = DIV64_U64_ROUND_UP((u64)wfhw->duty_cycle_cnt * NSEC_PER_SEC,
+					    ddata->clk_rate_hz);
+
+	wf->duty_offset_ns = DIV64_U64_ROUND_UP((u64)wfhw->duty_offset_cnt * NSEC_PER_SEC,
+					     ddata->clk_rate_hz);
+
+	return 0;
+}
+
+static int axi_pwmgen_write_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     const void *_wfhw)
+{
+	const struct axi_pwmgen_waveform *wfhw = _wfhw;
 	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
-	unsigned int ch = pwm->hwpwm;
 	struct regmap *regmap = ddata->regmap;
-	u64 period_cnt, duty_cnt;
+	unsigned int ch = pwm->hwpwm;
 	int ret;
 
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EINVAL;
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), wfhw->period_cnt);
+	if (ret)
+		return ret;
 
-	if (state->enabled) {
-		period_cnt = mul_u64_u64_div_u64(state->period, ddata->clk_rate_hz, NSEC_PER_SEC);
-		if (period_cnt > UINT_MAX)
-			period_cnt = UINT_MAX;
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), wfhw->duty_cycle_cnt);
+	if (ret)
+		return ret;
 
-		if (period_cnt == 0)
-			return -EINVAL;
-
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
-		if (ret)
-			return ret;
-
-		duty_cnt = mul_u64_u64_div_u64(state->duty_cycle, ddata->clk_rate_hz, NSEC_PER_SEC);
-		if (duty_cnt > UINT_MAX)
-			duty_cnt = UINT_MAX;
-
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
-		if (ret)
-			return ret;
-	} else {
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
-		if (ret)
-			return ret;
-
-		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
-		if (ret)
-			return ret;
-	}
+	ret = regmap_write(regmap, AXI_PWMGEN_CHX_OFFSET(ch), wfhw->duty_offset_cnt);
+	if (ret)
+		return ret;
 
 	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
 }
 
-static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-				struct pwm_state *state)
+static int axi_pwmgen_read_waveform(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    void *_wfhw)
 {
+	struct axi_pwmgen_waveform *wfhw = _wfhw;
 	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
 	struct regmap *regmap = ddata->regmap;
 	unsigned int ch = pwm->hwpwm;
-	u32 cnt;
 	int ret;
 
-	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &wfhw->period_cnt);
 	if (ret)
 		return ret;
 
-	state->enabled = cnt != 0;
-
-	state->period = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
-
-	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &wfhw->duty_cycle_cnt);
 	if (ret)
 		return ret;
 
-	state->duty_cycle = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_OFFSET(ch), &wfhw->duty_offset_cnt);
+	if (ret)
+		return ret;
 
-	state->polarity = PWM_POLARITY_NORMAL;
+	if (wfhw->duty_cycle_cnt > wfhw->period_cnt)
+		wfhw->duty_cycle_cnt = wfhw->period_cnt;
+
+	/* XXX: is this the actual behaviour of the hardware? */
+	if (wfhw->duty_offset_cnt >= wfhw->period_cnt) {
+		wfhw->duty_cycle_cnt = 0;
+		wfhw->duty_offset_cnt = 0;
+	}
 
 	return 0;
 }
 
 static const struct pwm_ops axi_pwmgen_pwm_ops = {
-	.apply = axi_pwmgen_apply,
-	.get_state = axi_pwmgen_get_state,
+	.sizeof_wfhw = sizeof(struct axi_pwmgen_waveform),
+	.round_waveform_tohw = axi_pwmgen_round_waveform_tohw,
+	.round_waveform_fromhw = axi_pwmgen_round_waveform_fromhw,
+	.read_waveform = axi_pwmgen_read_waveform,
+	.write_waveform = axi_pwmgen_write_waveform,
 };
 
 static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
-- 
2.43.0


