Return-Path: <linux-pwm+bounces-6892-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A0B12131
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0A81CC6185
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B624418D;
	Fri, 25 Jul 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NP1xlP9V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BDF24677E
	for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458356; cv=none; b=WqsGpKMgt/TGvlR8x6gaRqwLV3QB4H32Q9Mb12qUwlreb0cqnPAF867sEEcJN+tpAtHFax7z6At+GJOomw7A+6zdGxHeGKqgZfRno8cc0e6qLi8khUi4zPQBg9PVhtL9lavXZt8b/v469plNXTNxeNB+1nRQIfiEGlefL3WCh+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458356; c=relaxed/simple;
	bh=JVTMa1u9uKOzTEr4zF5qVt0q2p6fcHsxcxX+/IcWAvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgjbpyoYBYcJvpG6LlKUxnfR3pom49pTLF3wDuyqcuql+Ji6rW5wtlk8hybvFpR53uXaZ10TCEKSl5Z4JuLhVKYJgN3FKIBmmzByG9qNJPqhnW3gGTamizUml+DLNCtirIzuYJOHx4uZ01PRtc+8oaSE2UrrG0aAZ0/I9HXNsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NP1xlP9V; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-455b00339c8so16038565e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753458352; x=1754063152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naH0zBfJIyOjDeXHISo3GWSZjSEthCAmEqnzdT+LFjw=;
        b=NP1xlP9VduDJ4U8yYqwZhUGR6J93vSwuo8Z3xH/YAZYEjXai3b7msXvzOMC9nHMkRm
         KnYHJoG5dhpe/hgQoF857DXLGNQM7lS2rJObkQWGSKbbf3fja4eVdmmE+p4gPHswOz3H
         LKDzoB/bUECwALLoVDBJ9Duqs3mKZWmbfLW54P9XaCox75yrpnmZ3Yyopy9jDGGoIzza
         s6SS+MAim1JXue/WaiMXUcOlGLfNdPhkJIrj8tG2s8NEukmJDEM1UQ5aRgB8sDwx7X0N
         WVQ3hEzW5AfRKFK9Ol1r2hiUOFI03Do/0ejItp8cEjeU8M0Nn04QGCTK4rnIdYwfp95W
         Sgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458352; x=1754063152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naH0zBfJIyOjDeXHISo3GWSZjSEthCAmEqnzdT+LFjw=;
        b=J33coHe/oI1qvu+0Q0bYHuln7vsPEYHLXJpFWaV7gYe31TqEVoI9d/nA4fMrtS2h+u
         N4fgaYj9CK9Pl1dCcGW7Bxolv2knb+BRMYPcnp1wEGNacYG613Hir7oeU+yLxLokUb24
         GHhz19nynLXYFd/xDQ3gB3rQL5/UM7lo1b+zx7tG64NTroHAmeXRVZ/KG4BNY66MGzbn
         df71GrMqNpqUzVW0ymvl24vdVQdAoRgzQcs6cI1iqGsEGo+ay9iTep513lz1T0u+7WZp
         cbmABuGI1ywVV1pqIesETe61BOAECQY3ScBVEcOixrLeNMJ7sBDDvsJReEm8DO2wp72K
         ybZA==
X-Gm-Message-State: AOJu0YxYUBqyKpBG1aWCX5jNE9Jasa9nXuQJcYFvf4F2lxp2Y7O7NvyC
	VQcbVIm6L3SbjVxkXG/RiPDTcLT3fVTHEJI7c7Xp2f2XeZz2V8r2hLoIhpaL26+g60A=
X-Gm-Gg: ASbGncuAWHK3OGA1fDWUcSlw7jaA0rwBCYjXE6riQKiV0yud2klvFP7TkX6ZKODCm1L
	zx9UlxLkV4FETseyXF32V9GDzq1NLk5JmSW+afM5SdYToRx3k8PZUkrotoam3Vd8iBduxU6Y5Pk
	oNQlxx6eHCV48QHHoTVjMQMsp47RW5CRRht7Y0qNFUJbrvidvSX7VlQ/5cjTGg9ITwfV8di/r16
	76KfT6dCKKyFGXCYYeOMmk/ibJoJbFFtdd4Mf35mwCAgR+TTmBXmUhq5HZjap7wfyEb0hNvw+/C
	yIWfSgvMexAIkQwteqKR8v+lu6XfTo5BQRtCpRusDzjmlOC2dljuw8dL8s1j7UvxYqp2mUkZXBV
	pNqk/+Ch/2VY8px+1KsgUtpnaq+JVYqpBpdNxqyGS/h4Nv2xlV4vcDFqBw5Cltyey
X-Google-Smtp-Source: AGHT+IEu8ytExD33oY8pDlifvvoC9Uw4+3MTOanmfCvAAGoz6TXxb9utudI1/HDDkQ0BFNyvOatJtw==
X-Received: by 2002:a05:600c:4f87:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-4587644278emr27146735e9.17.1753458352317;
        Fri, 25 Jul 2025 08:45:52 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778f0c2d8sm217740f8f.59.2025.07.25.08.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:45:51 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 8/8] pwm: mediatek: Convert to waveform API
Date: Fri, 25 Jul 2025 17:45:12 +0200
Message-ID: <20250725154506.2610172-18-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11070; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=JVTMa1u9uKOzTEr4zF5qVt0q2p6fcHsxcxX+/IcWAvo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBog6aYnbWwK1WCYiQ3Y4ZhcAgzh73Cq5IQthP54 ezkCFDJX8aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIOmmAAKCRCPgPtYfRL+ TrWIB/sEWcWCZgK8EaNr/3uB1XUq1mHUFi+V7SaMzsEzr1JKVcFnK2jxMwaqdEXxjIUdyXgD9vg CVmN9Eef0UqFsuxVNRLcZBr9w9+MBTqiir6tGQTZGGvIaKMeyh0KMCV9cTr1OVebd/GkdvCZpKm O+cbD4n+KNf1CmTrWn+gHQQI/wWJ9juV8j661yZa0tq8zVffwLg/wNzz3+9sZnDVfoeF/PrAwgc altyxw0AIrqWYmAtCUxc71+w3SJp76MsIojD+BNLU2DCbyragZ6m0To8/2tMflJDfjJY2+x4Skn 5Ezd9DKCvtxxidp/BN+H0sqI/92AN0k6Zk5zTYKsAvgj6itR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Implement the new waveform callbacks which makes the usage of this
hardware more flexible and allows to use it via the pwm character
device.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 283 +++++++++++++++++++++----------------
 1 file changed, 164 insertions(+), 119 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index e3db54995f7b..8ad289b06352 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -135,50 +135,53 @@ static inline u32 pwm_mediatek_readl(struct pwm_mediatek_chip *chip,
 		     num * chip->soc->chanreg_width + offset);
 }
 
-static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-
-	value = readl(pc->regs);
-	value |= BIT(pwm->hwpwm);
-	writel(value, pc->regs);
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
-}
-
-static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			       u64 duty_ns, u64 period_ns)
+struct pwm_mediatek_waveform {
+	u32 enable;
+	u32 con;
+	u32 width;
+	u32 thres;
+};
+
+static int pwm_mediatek_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *pwm,
+					    const struct pwm_waveform *wf, void *_wfhw)
 {
+	struct pwm_mediatek_waveform *wfhw = _wfhw;
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
 	u32 clkdiv, enable;
-	u32 reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
 	u64 cnt_period, cnt_duty;
 	unsigned long clk_rate;
-	int ret;
+	int ret = 0;
 
-	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
-	if (ret < 0)
-		return ret;
+	if (wf->period_length_ns == 0) {
+		*wfhw = (typeof(*wfhw)){
+			.con = 0,
+		};
+
+		return 0;
+	}
+
+	if (!pc->clk_pwms[pwm->hwpwm].rate) {
+		struct clk *clk = pc->clk_pwms[pwm->hwpwm].clk;
+
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return ret;
+
+		pc->clk_pwms[pwm->hwpwm].rate = clk_get_rate(clk);
+
+		clk_disable_unprepare(clk);
+
+		if (pc->clk_pwms[pwm->hwpwm].rate == 0 ||
+		    pc->clk_pwms[pwm->hwpwm].rate > 1000000000)
+			return -EINVAL;
+	}
 
 	clk_rate = pc->clk_pwms[pwm->hwpwm].rate;
 
-	/* Make sure we use the bus clock and not the 26MHz clock */
-	if (pc->soc->pwm_ck_26m_sel_reg)
-		writel(0, pc->regs + pc->soc->pwm_ck_26m_sel_reg);
-
-	cnt_period = mul_u64_u64_div_u64(period_ns, clk_rate, NSEC_PER_SEC);
+	cnt_period = mul_u64_u64_div_u64(wf->period_length_ns, clk_rate, NSEC_PER_SEC);
 	if (cnt_period == 0) {
-		ret = -ERANGE;
-		goto out;
+		cnt_period = 1;
+		ret = 1;
 	}
 
 	if (cnt_period > FIELD_MAX(PWMDWIDTH_PERIOD) + 1) {
@@ -193,7 +196,7 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		clkdiv = 0;
 	}
 
-	cnt_duty = mul_u64_u64_div_u64(duty_ns, clk_rate, NSEC_PER_SEC) >> clkdiv;
+	cnt_duty = mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_SEC) >> clkdiv;
 	if (cnt_duty > cnt_period)
 		cnt_duty = cnt_period;
 
@@ -206,123 +209,165 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	cnt_period -= 1;
 
-	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld @%lu -> CON: %x, PERIOD: %llx, DUTY: %llx\n",
-		pwm->hwpwm, duty_ns, period_ns, clk_rate, clkdiv, cnt_period, cnt_duty);
+	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld @%lu -> ENABLE: %x, CON: %x, PERIOD: %llx, DUTY: %llx\n",
+		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, clk_rate,
+		enable, clkdiv, cnt_period, cnt_duty);
 
-	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
-		/*
-		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
-		 * from the other PWMs on MT7623.
-		 */
-		reg_width = PWM45DWIDTH_FIXUP;
-		reg_thres = PWM45THRES_FIXUP;
-	}
-
-	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
-
-	if (enable) {
-		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
-		pwm_mediatek_enable(chip, pwm);
-	} else {
-		pwm_mediatek_disable(chip, pwm);
-	}
-
-	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
+	*wfhw = (typeof(*wfhw)){
+		.enable = enable,
+		.con = clkdiv,
+		.width = cnt_period,
+		.thres = cnt_duty,
+	};
 
 	return ret;
 }
 
-static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			      const struct pwm_state *state)
+static int pwm_mediatek_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+					      const void *_wfhw, struct pwm_waveform *wf)
 {
+	const struct pwm_mediatek_waveform *wfhw = _wfhw;
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	int err;
+	u32 clkdiv, cnt_period, cnt_duty;
+	unsigned long clk_rate;
 
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EINVAL;
+	/*
+	 * When _wfhw was populated, the clock was on, so .rate is
+	 * already set appropriately.
+	 */
+	clk_rate = pc->clk_pwms[pwm->hwpwm].rate;
 
-	if (!state->enabled) {
-		if (pwm->state.enabled) {
-			pwm_mediatek_disable(chip, pwm);
-			pwm_mediatek_clk_disable(pc, pwm->hwpwm);
-		}
+	clkdiv = FIELD_GET(PWMCON_CLKDIV, wfhw->con);
+	cnt_period = FIELD_GET(PWMDWIDTH_PERIOD, wfhw->width);
+	cnt_duty = FIELD_GET(PWMTHRES_DUTY, wfhw->thres);
 
-		return 0;
-	}
+	/*
+	 * cnt_period is a 13 bit value, NSEC_PER_SEC is 30 bits wide
+	 * and clkdiv is less than 8, so the multiplication doesn't
+	 * overflow an u64.
+	 */
+	*wf = (typeof(*wf)){
+		.period_length_ns =
+			DIV_ROUND_UP_ULL((u64)(cnt_period + 1) * NSEC_PER_SEC << clkdiv, clk_rate),
+		.duty_length_ns =
+			wfhw->enable ?
+			DIV_ROUND_UP_ULL((u64)(cnt_duty + 1) * NSEC_PER_SEC << clkdiv, clk_rate) : 0,
+		.duty_offset_ns = 0,
+	};
+	dev_dbg(&chip->dev, "pwm#%u: ENABLE: %x, CLKDIV: %x, PERIOD: %x, DUTY: %x @%lu -> %lld/%lld\n",
+		pwm->hwpwm, wfhw->enable, clkdiv, cnt_period, cnt_duty, clk_rate,
+		wf->duty_length_ns, wf->period_length_ns);
 
-	err = pwm_mediatek_config(chip, pwm, state->duty_cycle, state->period);
-	if (err)
-		return err;
-
-	if (!pwm->state.enabled) {
-		err = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
-		if (err < 0)
-			return err;
-	}
-
-	return err;
+	return 0;
 }
 
-static int pwm_mediatek_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-				  struct pwm_state *state)
+static int pwm_mediatek_read_waveform(struct pwm_chip *chip,
+				      struct pwm_device *pwm, void *_wfhw)
 {
+	struct pwm_mediatek_waveform *wfhw = _wfhw;
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	int ret;
-	u32 enable;
+	u32 enable, clkdiv, cnt_period, cnt_duty;
 	u32 reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
-
-	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
-		/*
-		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
-		 * from the other PWMs on MT7623.
-		 */
-		reg_width = PWM45DWIDTH_FIXUP;
-		reg_thres = PWM45THRES_FIXUP;
-	}
+	int ret;
 
 	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
 	if (ret < 0)
 		return ret;
 
 	enable = readl(pc->regs);
-	if (enable & BIT(pwm->hwpwm)) {
-		u32 clkdiv, cnt_period, cnt_duty;
-		unsigned long clk_rate;
-
-		clk_rate = pc->clk_pwms[pwm->hwpwm].rate;
-
-		state->enabled = true;
-		state->polarity = PWM_POLARITY_NORMAL;
-
-		clkdiv = FIELD_GET(PWMCON_CLKDIV,
-				   pwm_mediatek_readl(pc, pwm->hwpwm, PWMCON));
-		cnt_period = FIELD_GET(PWMDWIDTH_PERIOD,
-				       pwm_mediatek_readl(pc, pwm->hwpwm, reg_width));
-		cnt_duty = FIELD_GET(PWMTHRES_DUTY,
-				     pwm_mediatek_readl(pc, pwm->hwpwm, reg_thres));
 
+	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
 		/*
-		 * cnt_period is a 13 bit value, NSEC_PER_SEC is 30 bits wide
-		 * and clkdiv is less than 8, so the multiplication doesn't
-		 * overflow an u64.
+		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
+		 * from the other PWMs on MT7623.
 		 */
-		state->period =
-			DIV_ROUND_UP_ULL((u64)cnt_period * NSEC_PER_SEC << clkdiv, clk_rate);
-		state->duty_cycle =
-			DIV_ROUND_UP_ULL((u64)cnt_duty * NSEC_PER_SEC << clkdiv, clk_rate);
-	} else {
-		state->enabled = false;
+		reg_width = PWM45DWIDTH_FIXUP;
+		reg_thres = PWM45THRES_FIXUP;
 	}
 
+	clkdiv = FIELD_GET(PWMCON_CLKDIV, pwm_mediatek_readl(pc, pwm->hwpwm, PWMCON));
+	cnt_period = FIELD_GET(PWMDWIDTH_PERIOD, pwm_mediatek_readl(pc, pwm->hwpwm, reg_width));
+	cnt_duty = FIELD_GET(PWMTHRES_DUTY, pwm_mediatek_readl(pc, pwm->hwpwm, reg_thres));
+
+	*wfhw = (typeof(*wfhw)){
+		.enable = enable & BIT(pwm->hwpwm),
+		.con = BIT(15) | clkdiv,
+		.width = cnt_period,
+		.thres = cnt_duty,
+	};
+
+	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
+
+	return ret;
+}
+
+static int pwm_mediatek_write_waveform(struct pwm_chip *chip,
+				       struct pwm_device *pwm, const void *_wfhw)
+{
+	const struct pwm_mediatek_waveform *wfhw = _wfhw;
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 ctrl;
+	int ret;
+
+	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
+	if (ret < 0)
+		return ret;
+
+	ctrl = readl(pc->regs);
+
+	if (wfhw->con & BIT(15)) {
+		u32 reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
+
+		if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
+			/*
+			 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
+			 * from the other PWMs on MT7623.
+			 */
+			reg_width = PWM45DWIDTH_FIXUP;
+			reg_thres = PWM45THRES_FIXUP;
+		}
+
+		if (!(ctrl & BIT(pwm->hwpwm))) {
+			ctrl |= BIT(pwm->hwpwm);
+			writel(ctrl, pc->regs);
+
+			/*
+			 * The clks are already on, just increasing the usage
+			 * counter doesn't fail.
+			 */
+			ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
+			if (unlikely(ret < 0))
+				goto out;
+		}
+
+		/* Make sure we use the bus clock and not the 26MHz clock */
+		if (pc->soc->pwm_ck_26m_sel_reg)
+			writel(0, pc->regs + pc->soc->pwm_ck_26m_sel_reg);
+
+		pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, wfhw->con);
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, wfhw->width);
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, wfhw->thres);
+	} else {
+		if (ctrl & BIT(pwm->hwpwm)) {
+			ctrl &= ~BIT(pwm->hwpwm);
+			writel(ctrl, pc->regs);
+
+			pwm_mediatek_clk_disable(pc, pwm->hwpwm);
+		}
+	}
+
+out:
 	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
 
 	return ret;
 }
 
 static const struct pwm_ops pwm_mediatek_ops = {
-	.apply = pwm_mediatek_apply,
-	.get_state = pwm_mediatek_get_state,
+	.sizeof_wfhw = sizeof(struct pwm_mediatek_waveform),
+	.round_waveform_tohw = pwm_mediatek_round_waveform_tohw,
+	.round_waveform_fromhw = pwm_mediatek_round_waveform_fromhw,
+	.read_waveform = pwm_mediatek_read_waveform,
+	.write_waveform = pwm_mediatek_write_waveform,
 };
 
 static int pwm_mediatek_init_used_clks(struct pwm_mediatek_chip *pc)
-- 
2.50.0


