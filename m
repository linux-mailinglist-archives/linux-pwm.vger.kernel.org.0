Return-Path: <linux-pwm+bounces-6879-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC7B112BF
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 23:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A43B1CE167A
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 21:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9548C1F4CAC;
	Thu, 24 Jul 2025 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jbwGdQox"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6861D63DF
	for <linux-pwm@vger.kernel.org>; Thu, 24 Jul 2025 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390857; cv=none; b=dkva+/8LiifTsB0lG5jsfV8bj6tss5niagc4Z/5d+GunRTKw452nwm38IrztkMtXyh/3Yi1WpNCLds+vptAu76fo0Vbn6pdEpnSvQetzdCQR1tFwovnbDJLhqPpmag/VsPujPat9EHCsVL+g3+LP6eX/+K7Z+gmezy8MQDGZG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390857; c=relaxed/simple;
	bh=u/COFpILtxMU50fQ37820EdrCCDB7Kx/tpvicZGMpUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AlCvsWtcMxQ2h41ipiAb/SrYvbtLHXgoDZguEsN3b/vupiQfR2GZMn2fSjxzbq0Cj5AB5d53emls9olkxXiqH0D2NrMLW74snEL0NCPrAp5LbhdeIO4X5t8T+Tlxgvh8lQi77SUjfXrgorc7xqT9vL+HqcfZc2QFquFlMNc9wds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jbwGdQox; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo2686697a12.3
        for <linux-pwm@vger.kernel.org>; Thu, 24 Jul 2025 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753390851; x=1753995651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xPCtqIfSr2XyV23/N7+gLkr99UKT0q7DSJYMRI6ogM=;
        b=jbwGdQoxOo9y3bYsyFzomjpZPT2tndhCZ1muLfRb0D1sJq2T1+FiKCXQyOStm0HuG4
         Jva4LowZCMru+6pDMP2SjuT0UN5Of/G8T0zmf5LWboSJmSp1WPJhA9G/zc7FnQUnzmgV
         RzO5EyLDA1r4wj8tNjY2Z2uddkWfPp4Bmwn/cvyFfIq42pnuSGT2+akxaGUI3MwxUv8h
         76jVoYKbQicR1RSxzQchSMcnr2k3ErsB9Tk87uing3nasLwKydEuk2IZZLijXSJLSlMJ
         nNk9pGkO5rKrnpGqoB/Q4sSw3vIkP9D7ec/ns4e/sBAz7nq8t0WhChhG1m0F34o7ObYr
         4Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753390851; x=1753995651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xPCtqIfSr2XyV23/N7+gLkr99UKT0q7DSJYMRI6ogM=;
        b=W6xeTu1JwGQ2f3hef/h70h5aLnhe2SSzIW2DtwxkY556c8vvC+T2VpDIlw7IBe+PyO
         fJXHGXghk42uyAuhas63+/xkAxtosLG10UOcSq7BhIIO8dTP9TWAFqxgSbX/LrtfqT+I
         EQ4SfmjJx1uECDlt5k+2BlFsTXiFFJJtzJVjN1lbNQWpsfp/PldvhlhJk5k2b3kMw6BH
         UR4o4+l7R/ALHIa/0+PP3Gyc2FcQvkNKnNKC3pQTPuwl+R0dfswmNfMcjh5t1xTiMIcY
         U+Ddhb8jGY0xhyHInwN3WObHWQS8uesYXpmPeXW4+3nzh1m74rD9a1j+QAifc0H3mr+O
         uvUg==
X-Gm-Message-State: AOJu0YyZ2+l9QCvE1RyNU3HZU+FS/KQhiyE67koJL+dg6ewqGCi7yAZn
	CLR6EegF4DfNN05a4MC3Xkl38YJ4Q5akuVF/G3s1Mhr7Qm5ACjfaqi4+sfdOkMZPVaQ=
X-Gm-Gg: ASbGncsAvw5Hh1j+E+SjM0+cOcW9JSjYwIdgFhuSlzNTMKIoxzPB3SlXxEKxIMqxA0c
	H53hjZxKW4OIr3hL9djb+oGJlsL4wXKyh8ej0QytIdf1sHNkWWGeVZYfTkhd/IsumavGCZjoPWp
	t1jIvjnPBMxDIALw+zegQr/IH6/piUEzaRi76G9CI76WTrJIEg8NAzOkuA8njyWPUh7yChZ0N1H
	uCTGZi3ghNtY97C9eIwhcEpnz4ABTw72MNWSyydHw8TPLTNR1I8cZylBFY7c3IKYrGhZxosYHsQ
	XzEOup1Q4eUTJEs5InwxM7KoAONCod2dH9i7SqJgTc7GisrzlWXxIfBfym1jl0uR1JZgHeaWNh9
	LlCMlkBvCtR7ZiJ5P0dhATDWTVLJi4JNB6WuF1g==
X-Google-Smtp-Source: AGHT+IEZuY7f15rGOKM3HvtvPUuX5++kJiRoaL2Bas2BgZ0IihvpCrXTSETkdjV6BlKAgBCSWD3W+w==
X-Received: by 2002:a17:906:fe4d:b0:ae3:7c8c:351d with SMTP id a640c23a62f3a-af2f927b043mr869343866b.56.1753390850866;
        Thu, 24 Jul 2025 14:00:50 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af47c496eefsm162080166b.25.2025.07.24.14.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 14:00:50 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	John Crispin <john@phrozen.org>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] pwm: mediatek: Fix duty and period setting
Date: Thu, 24 Jul 2025 23:00:42 +0200
Message-ID: <20250724210041.2513590-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4935; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=u/COFpILtxMU50fQ37820EdrCCDB7Kx/tpvicZGMpUo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBogp76/5Y3j1DqbR8NG5ev3MILN2GEJtJqSGxPz O65Ll6UeO6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIKe+gAKCRCPgPtYfRL+ TsMMCAChbXNFn4tXrA9yspNC+kYupFpxX9nJ95SXw8tY89vKB6FXN3nh4+lC/dbsWAMytRshg1n tkbrix3dxa6+EbEnr1sKuxYQq1L/3RGN1OiEJ35VDrbas5Oh+RwC7AkA7ZtHbHpPuBxRAIOVr3Z RI/QpZBtUc5NI9YbFN2e4fATy8n9Ls9gyMG5FeZjR1kyHmWUGZgjtWlbS/6Da+bUuu4vH05jjrf G5OkisJR5ycLuUCCImRbsiRHwb1/jstC3uo1grs0+Ce546YqSEjeJQLDGetkx9y1ZTtdSXjLg44 zHhQyFi7HJrgp8T0C+NG6sSIrzbuimU4/N+npSx/oabuxCNy
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The period generated by the hardware is

	(PWMDWIDTH + 1) << CLKDIV) / freq

according to my tests with a signal analyser and also the documentation.

The current algorithm doesn't consider the `+ 1` part and so configures
slightly too high periods. The same issue exists for the duty cycle
setting. So subtract 1 from both the register values for period and
duty cycle. If period is 0, bail out, if duty_cycle is 0, just disable
the PWM which results in a constant low output.

Note that clk handling is dropped from pwm_mediatek_{en,dis}able to
handle duty_cycle = 0, so the calls in pwm_mediatek_apply() have to be
modified to do clk handling, too.

Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

changes since (implicit) v1,
https://lore.kernel.org/linux-pwm/20250710163705.2095418-2-u.kleine-koenig@baylibre.com/:

 - Drop superflous parenthesis from commit log
 - To implement drop the enable register instead of bit 15 in the CON
   register, adapt commit log accordingly.

Best regards
Uwe

 drivers/pwm/pwm-mediatek.c | 76 ++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 6777c511622a..4460bbca2582 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -121,6 +121,26 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
 	writel(value, chip->regs + chip->soc->reg_offset[num] + offset);
 }
 
+static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value |= BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
+static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value &= ~BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -150,7 +170,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
-	while (cnt_period > 8191) {
+	if (!cnt_period)
+		return -EINVAL;
+
+	while (cnt_period > 8192) {
 		resolution *= 2;
 		clkdiv++;
 		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
@@ -173,9 +196,16 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
+
 	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
+	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period - 1);
+
+	if (cnt_duty) {
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty - 1);
+		pwm_mediatek_enable(chip, pwm);
+	} else {
+		pwm_mediatek_disable(chip, pwm);
+	}
 
 out:
 	pwm_mediatek_clk_disable(chip, pwm);
@@ -183,35 +213,6 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
-static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-	int ret;
-
-	ret = pwm_mediatek_clk_enable(chip, pwm);
-	if (ret < 0)
-		return ret;
-
-	value = readl(pc->regs);
-	value |= BIT(pwm->hwpwm);
-	writel(value, pc->regs);
-
-	return 0;
-}
-
-static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-
-	value = readl(pc->regs);
-	value &= ~BIT(pwm->hwpwm);
-	writel(value, pc->regs);
-
-	pwm_mediatek_clk_disable(chip, pwm);
-}
-
 static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const struct pwm_state *state)
 {
@@ -221,8 +222,10 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		if (pwm->state.enabled)
+		if (pwm->state.enabled) {
 			pwm_mediatek_disable(chip, pwm);
+			pwm_mediatek_clk_disable(chip, pwm);
+		}
 
 		return 0;
 	}
@@ -231,8 +234,11 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (err)
 		return err;
 
-	if (!pwm->state.enabled)
-		err = pwm_mediatek_enable(chip, pwm);
+	if (!pwm->state.enabled) {
+		err = pwm_mediatek_clk_enable(chip, pwm);
+		if (err < 0)
+			return err;
+	}
 
 	return err;
 }

base-commit: a02b105fe9f2b82cbd13b13a98c2b9ffae4a7c27
-- 
2.50.0


