Return-Path: <linux-pwm+bounces-2806-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319049312EA
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 13:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C1FB2253A
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A616E877;
	Mon, 15 Jul 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FsaeGwLv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AD13D8B1
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042215; cv=none; b=ahH0NZWsnPAch0hZizbyDltew3SEQZfO0xOvvwAKgedDbZYqd61cEsk8PsQZns3bpf8OGgD2rZssZLRUBjmgmyIyMCyHB/QSpkDd/n2snxWYxPQkbdI98qQkSLIBgL2vVRNccFGFljqJhZPHspiz3Evx21TTuDAwFbxEkvrJ+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042215; c=relaxed/simple;
	bh=KKZP66vcljdRLWcuoVkqsX6ZTfq1jo7XEXXxOKKhBcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDDaCjvB4rnYoVFO4KX6o9NBXbP77clnC5dfaOSUM46jZpy9iblQWgY8AvXNQ4VRmvxDleZXi9wb+kLkr80F4LSAWehd0hVK1NpJh2wt0oY/vGhsAw0lHQCDmpe1Vy25ORimfaK1L6C46h0sUOKW/ZHhUfQLhq23xJZhdGbO5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FsaeGwLv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e9fe05354so5709007e87.1
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721042211; x=1721647011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0gLcOPQIZEYQ5ROztE95vFl+H+bfp8n52B/pAjaBgM=;
        b=FsaeGwLv4b9/cGH4VPX6bE60jg/trKkE2bgaQB3s2trzdhBIN7mpJtkI2O31awFTqZ
         vSHwuXlQhjqpFv+JW5WKqR1hFyd2BgNmBzhx9TMtrNJoL+XP02dfL/uc/CuJYfFiy9IQ
         bChXt1ypzEtZwTUUuyQJqRSNivJxBN0R3Jf3bvc+PVl/ull3pifT9NIDViESwkIPfw4S
         4glhdFIP005mC1eltPPx9mOaafIQk9KdFxn7wrjGQq3C3vJDRb1QxEXDFvE+NTgyAzDb
         5j4YB+vQcPyyV9TjiS9fxJfr5oCaAkP5zXTov/c0knO5hltcI407wHxI6aJY15Sa1OFw
         DIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042211; x=1721647011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0gLcOPQIZEYQ5ROztE95vFl+H+bfp8n52B/pAjaBgM=;
        b=KpcMtboIPB622qUGwa1794KfyFRD5LId8slFdi0ZiZ6w+Jh942nTPw3PK9JPXd6SVw
         6BOuajTK6ruR97X5sUIApjtYaYKrwBrnyXHBnDAn00lD5LokrkVE8uRjWlOeSLai2xU0
         cGwWGdUjCdlpAZoum6OYieM6tsIM7TY7xWRFM9lj630amvDshO8nGjVH+XowKnyB51sF
         N5cC6SBkokkc0YYoPNMcSbWns+xlTZkDDP9F/rzB/hGL5GFWUCG7izWyCwko6W6zZ6ef
         QPkk52SEl3XNTj8Xdf+UE14zlb/RCHaZ5j++qTmAHWCqNsaY216GDaKlbS9Zm6+5ImKO
         cE2g==
X-Forwarded-Encrypted: i=1; AJvYcCUNTpy1bV+rn1I7av4W/tlBskUCMBFyZmzkE59g6yWXfRUPD6WnIUbw4Pe/oocMjw+ojh022f/ojWgkD+lVOnTi1IWH65IGcWC6
X-Gm-Message-State: AOJu0YwELJQkKDHbVD1jCkIC/yDpTUAbu1lQTY5pcKDYhn0AgTYPAMgW
	62y4oiQF2b10SjpzJophUkhIpt6a7lzLofCXjaAWGFTrtHifrPXWZDgBx5z/c9k=
X-Google-Smtp-Source: AGHT+IGiKSqE0sB76jA5My62HWGSar5EU5EIOtOA2p9x0zHBW7PsKqT1Uqk0QeeoEqUR1MR54mtphw==
X-Received: by 2002:a19:9109:0:b0:52e:a721:497b with SMTP id 2adb3069b0e04-52eb99a19cemr10859109e87.38.1721042209689;
        Mon, 15 Jul 2024 04:16:49 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f276c52sm118193755e9.22.2024.07.15.04.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:16:49 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 7/8] pwm: axi-pwmgen: Implementation of the waveform callbacks
Date: Mon, 15 Jul 2024 13:16:12 +0200
Message-ID:  <1121f96fe20ac6e1b1d38fb5c42def3ad4308a73.1721040875.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6834; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KKZP66vcljdRLWcuoVkqsX6ZTfq1jo7XEXXxOKKhBcE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrSprBxu7lzTOWf3lBzuunbKw6hU33rPmUXOv/u9/n6Im /k+9N6/TkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmwhvFwbC7mj2bd3qL0mfD xoXHP0hN4ONWXaTltz1ce05do0KoYch6V41pzf1HsnTyzUK9atY/vtu340sE5yMXN+fDRts37eY S3Rj8UqHMVqXxlIlvlqhHj8qXnqnBe4suROZd4YvOWTfplo3N0ifvFWpWHOevu6Owe9H5w1caDz nPkDv+YGFn+pFn7hf1K6Tq7fKOqtorNJVPOHzpKWuQ11G5d572OnPPVJ3vmZr664qusXVRwvTTs znkIroCGDKqUsUDtJwixNfb/jmrLWT5xDOdadezSeobr3506/1v9WRW2sMq62Cmron/ZywP9Prv rjHDX1159eHaNM14/pinFi2cfszqaomdB5+pVz1M0GkBAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Convert the axi-pwmgen driver to use the new callbacks for hardware
programming.

Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 148 ++++++++++++++++++++++++-----------
 1 file changed, 102 insertions(+), 46 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 3ad60edf20a5..5b76ba31b77f 100644
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
@@ -54,81 +55,136 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
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
+	if (wf->period_length == 0) {
+		*wfhw = (struct axi_pwmgen_waveform){
+			.period_cnt = 0,
+			.duty_cycle_cnt = 0,
+			.duty_offset_cnt = 0,
+		};
+	} else {
+		/* With ddata->clk_rate_hz < NSEC_PER_SEC this won't overflow. */
+		wfhw->period_cnt = min_t(u64, mul_u64_u32_div(wf->period_length, ddata->clk_rate_hz, NSEC_PER_SEC), U32_MAX);
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
+			wfhw->duty_cycle_cnt = min_t(u64, mul_u64_u32_div(wf->duty_length, ddata->clk_rate_hz, NSEC_PER_SEC), U32_MAX);
+			wfhw->duty_offset_cnt = min_t(u64, mul_u64_u32_div(wf->duty_offset, ddata->clk_rate_hz, NSEC_PER_SEC), U32_MAX);
+		}
+	}
+
+	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> PERIOD: %08x, DUTY: %08x, OFFSET: %08x\n",
+		pwm->hwpwm, wf->duty_length, wf->period_length, wf->duty_offset,
+                ddata->clk_rate_hz, wfhw->period_cnt, wfhw->duty_cycle_cnt, wfhw->duty_offset_cnt);
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
+	wf->period_length = DIV64_U64_ROUND_UP((u64)wfhw->period_cnt * NSEC_PER_SEC,
+					ddata->clk_rate_hz);
+
+	wf->duty_length = DIV64_U64_ROUND_UP((u64)wfhw->duty_cycle_cnt * NSEC_PER_SEC,
+					    ddata->clk_rate_hz);
+
+	wf->duty_offset = DIV64_U64_ROUND_UP((u64)wfhw->duty_offset_cnt * NSEC_PER_SEC,
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


