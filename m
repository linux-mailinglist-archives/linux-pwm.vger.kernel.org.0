Return-Path: <linux-pwm+bounces-2726-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F2292A090
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EFC1F20EFF
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D5C78285;
	Mon,  8 Jul 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mjK4tF+8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01493770ED
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435987; cv=none; b=DKVwNKrOf2CqKRw4WBXQs9B39ZwO6+vEeLRHif0zQ6oWBLQNjXAJiI3sXsDGYpSU15aD3vQiF16xfuU/BE8bfJcbDgLGVB5idhgcDCxMg33+rqXaDTgjbi9PW8fM78lgr6LsXnjdDs3/rKptzZHT7x2qf+jluH3hfqe+VgLllT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435987; c=relaxed/simple;
	bh=yhsRxTmP+cPE+8kUf176lTv2yrrTFVO2vxSx26zHd0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OL+ZhWG6uIJXc+ixaC8PO9SCDIwHivW+FuiDPmQHiGujGppp+LNjp0zGuyirJAQFsFrwh6h7D/sN9/lGpPKa3wup6dG0IQkyUxeu5DqGMb2lb9krCEH1qaHG9kKiXs6m6nmN8NmKPL1yU+Q5hhznDwATb/LRQM7pzTxHm95eLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mjK4tF+8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so3888711e87.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720435983; x=1721040783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzQ12MBO5tx4hCgekxUxY/qWko2QtfYvPcuwIh1kocA=;
        b=mjK4tF+8OSYzVuXsqIyTy4KqGXvOf+QDZ/1cb2wbq9Fg2Rm6mu/PKeD+Dj9onVp6BP
         PYbZWCcQPIh0cIOefzu7uRgQa8lQoPc96VIIQ5Z5TdIDyr3q6iE4Ijb/TJnjjPuiCSay
         dhqVpNuEPen54gdz/z3OLUqJnP6WsdCVGmnzBZLv+9ExK9Kmrp+YITypzuQaZvS4rwoy
         c13m/qbejIXuxqwh/AoxOruUiSLmjtZweTs/DuF73IDmpklyNIbqV1msx/PwYcKXgMk2
         4DyJ7RG4SKq9fwNQKFtCEbhmK3yxiNfMmP8iQuwPAhHBu5qynMyQf4/ejMylD4EqqO26
         cm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435983; x=1721040783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzQ12MBO5tx4hCgekxUxY/qWko2QtfYvPcuwIh1kocA=;
        b=Jeed6dFl1p+84Q/ynY1c/9B9FMCzZZ13E1vY0phVgb/I7kmtnn+wSpmSdNYuI3CVXF
         yCT4mo6RJP7ou3qbLnrYh000IMZJScAjfLTQ9CDneB5rK84SYew2SYLdKjafzSHJl12R
         NQuh+zJToWs2m6qziVHaMP0Uk84zyBDWNK5yE+TQa+SnKS0XUBWJj9OxQKHXKYtdUIwh
         cJ5cKM3BX24oV+KmAqpsnwKcn4EW2U8LkZL9IQE11Bclb4RCzikimj6FfQNQc8yjhx/s
         /FuxkofKfBitiH9puB6hbis5afWmXsPE6yhkka97M+SIx999WhLMZgirbnlk93AsDh+M
         5vJA==
X-Gm-Message-State: AOJu0YwlzJC4TbnWBzoKXXhUuMHEFJcZOXkCL1MiENMe5mVXpgsL1lNc
	7zd6Gw6CODxa6NDUr6er1jH/YZWaQlYzULYbHfk7eFH6Dda6wdO//bmRMlKzjun9OB+7MGTZ0Qt
	I
X-Google-Smtp-Source: AGHT+IHYHbku7YKCTGpHkQcjNl3Wy4XpBMGPUhc+THoxMvdm6tXgsUYD9cCVpSLXZH0OO8CQc1kJSQ==
X-Received: by 2002:a05:6512:312a:b0:52c:ccb4:ec70 with SMTP id 2adb3069b0e04-52ea0632f20mr7976815e87.22.1720435983217;
        Mon, 08 Jul 2024 03:53:03 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca5casm161986155e9.32.2024.07.08.03.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:53:02 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] pwm: stm32: Implementation of the waveform callbacks
Date: Mon,  8 Jul 2024 12:52:32 +0200
Message-ID:  <69eb4b894ec82a0d53bc14450006a977d82551ec.1720435656.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=17011; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=yhsRxTmP+cPE+8kUf176lTv2yrrTFVO2vxSx26zHd0I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmi8T68q3i4AsqKv/3eD7+PVUgJ1AuvSqy1csHu PUxhL7FqsGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZovE+gAKCRCPgPtYfRL+ TnmxB/48DbmWoYO+leRSz4W37BtI4ysuXyR392jO9nkgRve/c9SnkG3uBLhg/6QE7spnYoYbe0M KPJeGj09jNTwvCcgbISAZvMNyXPkGUgE2JsuLlVKXGCqG1VET81iKxdlGFxFU0xq7VuLvUTfbTB 7VIAsOEXTvRjUz0Le9XvPqijxpbO0i+C3A7/dU8wvTLPnaU0LZLv5RsOjmQHue9A1BCwa79jmtN huhmVxha7Swm270SkzMaSjPNK3buIzx8no5wXG29nuZBFw86qWDWhbUByM1wEap5NPNWiy9azjc pz/3FFzKMMprILwMegbBznAx5C8xxK9cb0BscThbWYiT1iKa
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Convert the stm32 pwm driver to use the new callbacks for hardware
programming.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 605 +++++++++++++++++++++++++---------------
 1 file changed, 384 insertions(+), 221 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index fd754a99cf2e..4dedfabce63b 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -51,6 +51,384 @@ static u32 active_channels(struct stm32_pwm *dev)
 	return ccer & TIM_CCER_CCXE;
 }
 
+struct stm32_pwm_waveform {
+	u32 ccer;
+	u32 psc;
+	u32 arr;
+	u32 ccr;
+};
+
+static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 const struct pwm_waveform *wf,
+					 void *_wfhw)
+{
+	struct stm32_pwm_waveform *wfhw = _wfhw;
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	unsigned int ch = pwm->hwpwm;
+	unsigned long rate;
+	u64 ccr, duty;
+	int ret;
+
+	if (wf->period_length == 0) {
+		*wfhw = (struct stm32_pwm_waveform){
+			.ccer = 0,
+		};
+
+		return 0;
+	}
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	wfhw->ccer = TIM_CCER_CCxE(ch + 1);
+	if (priv->have_complementary_output)
+		wfhw->ccer = TIM_CCER_CCxNE(ch);
+
+	rate = clk_get_rate(priv->clk);
+
+	if (active_channels(priv) & ~(1 << ch * 4)) {
+		u64 arr;
+
+		/*
+		 * Other channels are already enabled, so the configured PSC and
+		 * ARR must be used for this channel, too.
+		 */
+		ret = regmap_read(priv->regmap, TIM_PSC, &wfhw->psc);
+		if (ret)
+			goto out;
+
+		ret = regmap_read(priv->regmap, TIM_ARR, &wfhw->arr);
+		if (ret)
+			goto out;
+
+		/*
+		 * calculate the best value for ARR for the given PSC, refuse if
+		 * the resulting period gets bigger than the requested one.
+		 */
+		arr = mul_u64_u64_div_u64(wf->period_length, rate,
+					  (u64)NSEC_PER_SEC * (wfhw->psc + 1));
+		if (arr <= wfhw->arr) {
+			/*
+			 * requested period is small than the currently
+			 * configured and unchangable period, report back the smallest
+			 * possible period, i.e. the current state; Initialize
+			 * ccr to anything valid.
+			 */
+			wfhw->ccr = 0;
+			ret = 1;
+			goto out;
+		}
+
+	} else {
+		/*
+		 * .probe() asserted that clk_get_rate() is not bigger than 1 GHz, so
+		 * the calculations here won't overflow.
+		 * First we need to find the minimal value for prescaler such that
+		 *
+		 *        period_ns * clkrate
+		 *   ------------------------------ < max_arr + 1
+		 *   NSEC_PER_SEC * (prescaler + 1)
+		 *
+		 * This equation is equivalent to
+		 *
+		 *        period_ns * clkrate
+		 *   ---------------------------- < prescaler + 1
+		 *   NSEC_PER_SEC * (max_arr + 1)
+		 *
+		 * Using integer division and knowing that the right hand side is
+		 * integer, this is further equivalent to
+		 *
+		 *   (period_ns * clkrate) // (NSEC_PER_SEC * (max_arr + 1)) ≤ prescaler
+		 */
+		u64 psc = mul_u64_u64_div_u64(wf->period_length, rate,
+					      (u64)NSEC_PER_SEC * ((u64)priv->max_arr + 1));
+		u64 arr;
+
+		wfhw->psc = min_t(u64, psc, MAX_TIM_PSC);
+
+		arr = mul_u64_u64_div_u64(wf->period_length, rate,
+					  (u64)NSEC_PER_SEC * (wfhw->psc + 1));
+		if (!arr) {
+			/*
+			 * requested period is too small, report back the smallest
+			 * possible period, i.e. ARR = 0. The only valid CCR
+			 * value is then zero, too.
+			 */
+			wfhw->arr = 0;
+			wfhw->ccr = 0;
+			ret = 1;
+			goto out;
+		}
+
+		/*
+		 * ARR is limited intentionally to values less than
+		 * priv->max_arr to allow 100% duty cycle.
+		 */
+		wfhw->arr = min_t(u64, arr, priv->max_arr) - 1;
+	}
+
+	duty = mul_u64_u64_div_u64(wf->duty_length, rate,
+				   (u64)NSEC_PER_SEC * (wfhw->psc + 1));
+	duty = min_t(u64, duty, wfhw->arr + 1);
+
+	if (wf->duty_length && wf->duty_offset &&
+	    wf->duty_length + wf->duty_offset >= wf->period_length) {
+		wfhw->ccer |= TIM_CCER_CCxP(ch + 1);
+		if (priv->have_complementary_output)
+			wfhw->ccer |= TIM_CCER_CCxNP(ch + 1);
+
+		ccr = wfhw->arr + 1 - duty;
+	} else {
+		ccr = duty;
+	}
+
+	wfhw->ccr = min_t(u64, ccr, wfhw->arr + 1);
+
+	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x\n",
+		pwm->hwpwm, wf->duty_length, wf->period_length, wf->duty_offset,
+		rate, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr);
+
+out:
+	clk_disable(priv->clk);
+
+	return ret;
+}
+
+/*
+ * This should be moved to lib/math/div64.c. Currently there are some changes
+ * pending to mul_u64_u64_div_u64. Uwe will care for that when the dust settles.
+ */
+static u64 stm32_pwm_mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c)
+{
+	u64 res = mul_u64_u64_div_u64(a, b, c);
+	/* Those multiplications might overflow but it doesn't matter */
+	u64 rem = a * b - c * res;
+
+	if (rem)
+		res += 1;
+
+	return res;
+}
+
+static int stm32_pwm_round_waveform_fromhw(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const void *_wfhw,
+					   struct pwm_waveform *wf)
+{
+	const struct stm32_pwm_waveform *wfhw = _wfhw;
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	unsigned int ch = pwm->hwpwm;
+
+	if (wfhw->ccer & TIM_CCER_CCxE(ch + 1)) {
+		unsigned long rate = clk_get_rate(priv->clk);
+		u64 ccr_ns;
+
+		/* The result doesn't overflow for rate >= 15259 */
+		wf->period_length = stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1), NSEC_PER_SEC, rate);
+
+		ccr_ns = stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * wfhw->ccr, NSEC_PER_SEC, rate);
+
+		if (wfhw->ccer & TIM_CCER_CCxP(ch + 1)) {
+			wf->duty_length =
+				stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1 - wfhw->ccr),
+								      NSEC_PER_SEC, rate);
+
+			wf->duty_offset = ccr_ns;
+		} else {
+			wf->duty_length = ccr_ns;
+			wf->duty_offset = 0;
+		}
+	} else {
+		*wf = (struct pwm_waveform){
+			.period_length = 0,
+		};
+	}
+
+	return 0;
+}
+
+static int stm32_pwm_read_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     void *_wfhw)
+{
+	struct stm32_pwm_waveform *wfhw = _wfhw;
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	unsigned int ch = pwm->hwpwm;
+	int ret;
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, TIM_CCER, &wfhw->ccer);
+	if (ret)
+		goto out;
+
+	if (wfhw->ccer & TIM_CCER_CCxE(ch + 1)) {
+		ret = regmap_read(priv->regmap, TIM_PSC, &wfhw->psc);
+		if (ret)
+			goto out;
+
+		ret = regmap_read(priv->regmap, TIM_ARR, &wfhw->arr);
+		if (ret)
+			goto out;
+
+		if (wfhw->arr == U32_MAX)
+			wfhw->arr -= 1;
+
+		ret = regmap_read(priv->regmap, TIM_CCRx(ch + 1), &wfhw->ccr);
+		if (ret)
+			goto out;
+
+		if (wfhw->ccr > wfhw->arr + 1)
+			wfhw->ccr = wfhw->arr + 1;
+	}
+
+out:
+	clk_disable(priv->clk);
+
+	return ret;
+}
+
+static int stm32_pwm_write_waveform(struct pwm_chip *chip,
+				      struct pwm_device *pwm,
+				      const void *_wfhw)
+{
+	const struct stm32_pwm_waveform *wfhw = _wfhw;
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	unsigned int ch = pwm->hwpwm;
+	int ret;
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	if (wfhw->ccer & TIM_CCER_CCxE(ch + 1)) {
+		u32 ccer, mask;
+		unsigned shift;
+		u32 ccmr;
+
+		ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
+		if (ret)
+			goto out;
+
+		/* If there are other channels enabled, don't update PSC and ARR */
+		if (ccer & ~TIM_CCER_CCxE(ch + 1) & TIM_CCER_CCXE) {
+			u32 psc, arr;
+
+			ret = regmap_read(priv->regmap, TIM_PSC, &psc);
+			if (ret)
+				goto out;
+
+			if (psc != wfhw->psc) {
+				ret = -EBUSY;
+				goto out;
+			}
+
+			regmap_read(priv->regmap, TIM_ARR, &arr);
+			if (ret)
+				goto out;
+
+			if (arr != wfhw->arr) {
+				ret = -EBUSY;
+				goto out;
+			}
+		} else {
+			ret = regmap_write(priv->regmap, TIM_PSC, wfhw->psc);
+			if (ret)
+				goto out;
+
+			ret = regmap_write(priv->regmap, TIM_ARR, wfhw->arr);
+			if (ret)
+				goto out;
+
+			ret = regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
+			if (ret)
+				goto out;
+
+		}
+
+		/* set polarity */
+		mask = TIM_CCER_CCxP(ch + 1) | TIM_CCER_CCxNP(ch + 1);
+		ret = regmap_update_bits(priv->regmap, TIM_CCER, mask, wfhw->ccer);
+		if (ret)
+			goto out;
+
+		ret = regmap_write(priv->regmap, TIM_CCRx(ch + 1), wfhw->ccr);
+		if (ret)
+			goto out;
+
+		/* Configure output mode */
+		shift = (ch & 0x1) * CCMR_CHANNEL_SHIFT;
+		ccmr = (TIM_CCMR_PE | TIM_CCMR_M1) << shift;
+		mask = CCMR_CHANNEL_MASK << shift;
+
+		if (ch < 2)
+			ret = regmap_update_bits(priv->regmap, TIM_CCMR1, mask, ccmr);
+		else
+			ret = regmap_update_bits(priv->regmap, TIM_CCMR2, mask, ccmr);
+		if (ret)
+			goto out;
+
+		ret = regmap_set_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE);
+		if (ret)
+			goto out;
+
+		if (!(ccer & TIM_CCER_CCxE(ch + 1))) {
+			mask = TIM_CCER_CCxE(ch + 1) | TIM_CCER_CCxNE(ch + 1);
+
+			ret = clk_enable(priv->clk);
+			if (ret)
+				goto out;
+
+			ccer = (ccer & ~mask) | (wfhw->ccer & mask);
+			regmap_write(priv->regmap, TIM_CCER, ccer);
+
+			/* Make sure that registers are updated */
+			regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
+
+			/* Enable controller */
+			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
+		}
+
+	} else {
+		/* disable channel */
+		u32 mask, ccer;
+
+		mask = TIM_CCER_CCxE(ch + 1);
+		if (priv->have_complementary_output)
+			mask |= TIM_CCER_CCxNE(ch + 1);
+
+		ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
+		if (ret)
+			goto out;
+
+		if (ccer & mask) {
+			ccer = ccer & ~mask;
+
+			ret = regmap_write(priv->regmap, TIM_CCER, ccer);
+			if (ret)
+				goto out;
+
+			if (!(ccer & TIM_CCER_CCXE)) {
+				/* When all channels are disabled, we can disable the controller */
+				ret = regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
+				if (ret)
+					goto out;
+			}
+
+			clk_disable(priv->clk);
+		}
+	}
+
+out:
+	clk_disable(priv->clk);
+
+	return ret;
+}
+
 #define TIM_CCER_CC12P (TIM_CCER_CC1P | TIM_CCER_CC2P)
 #define TIM_CCER_CC12E (TIM_CCER_CC1E | TIM_CCER_CC2E)
 #define TIM_CCER_CC34P (TIM_CCER_CC3P | TIM_CCER_CC4P)
@@ -308,228 +686,13 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
-static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
-			    u64 duty_ns, u64 period_ns)
-{
-	unsigned long long prd, dty;
-	unsigned long long prescaler;
-	u32 ccmr, mask, shift;
-
-	/*
-	 * .probe() asserted that clk_get_rate() is not bigger than 1 GHz, so
-	 * the calculations here won't overflow.
-	 * First we need to find the minimal value for prescaler such that
-	 *
-	 *        period_ns * clkrate
-	 *   ------------------------------ < max_arr + 1
-	 *   NSEC_PER_SEC * (prescaler + 1)
-	 *
-	 * This equation is equivalent to
-	 *
-	 *        period_ns * clkrate
-	 *   ---------------------------- < prescaler + 1
-	 *   NSEC_PER_SEC * (max_arr + 1)
-	 *
-	 * Using integer division and knowing that the right hand side is
-	 * integer, this is further equivalent to
-	 *
-	 *   (period_ns * clkrate) // (NSEC_PER_SEC * (max_arr + 1)) ≤ prescaler
-	 */
-
-	prescaler = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
-					(u64)NSEC_PER_SEC * ((u64)priv->max_arr + 1));
-	if (prescaler > MAX_TIM_PSC)
-		return -EINVAL;
-
-	prd = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
-				  (u64)NSEC_PER_SEC * (prescaler + 1));
-	if (!prd)
-		return -EINVAL;
-
-	/*
-	 * All channels share the same prescaler and counter so when two
-	 * channels are active at the same time we can't change them
-	 */
-	if (active_channels(priv) & ~(1 << ch * 4)) {
-		u32 psc, arr;
-
-		regmap_read(priv->regmap, TIM_PSC, &psc);
-		regmap_read(priv->regmap, TIM_ARR, &arr);
-
-		if ((psc != prescaler) || (arr != prd - 1))
-			return -EBUSY;
-	}
-
-	regmap_write(priv->regmap, TIM_PSC, prescaler);
-	regmap_write(priv->regmap, TIM_ARR, prd - 1);
-	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
-
-	/* Calculate the duty cycles */
-	dty = mul_u64_u64_div_u64(duty_ns, clk_get_rate(priv->clk),
-				  (u64)NSEC_PER_SEC * (prescaler + 1));
-
-	regmap_write(priv->regmap, TIM_CCRx(ch + 1), dty);
-
-	/* Configure output mode */
-	shift = (ch & 0x1) * CCMR_CHANNEL_SHIFT;
-	ccmr = (TIM_CCMR_PE | TIM_CCMR_M1) << shift;
-	mask = CCMR_CHANNEL_MASK << shift;
-
-	if (ch < 2)
-		regmap_update_bits(priv->regmap, TIM_CCMR1, mask, ccmr);
-	else
-		regmap_update_bits(priv->regmap, TIM_CCMR2, mask, ccmr);
-
-	regmap_set_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE);
-
-	return 0;
-}
-
-static int stm32_pwm_set_polarity(struct stm32_pwm *priv, unsigned int ch,
-				  enum pwm_polarity polarity)
-{
-	u32 mask;
-
-	mask = TIM_CCER_CCxP(ch + 1);
-	if (priv->have_complementary_output)
-		mask |= TIM_CCER_CCxNP(ch + 1);
-
-	regmap_update_bits(priv->regmap, TIM_CCER, mask,
-			   polarity == PWM_POLARITY_NORMAL ? 0 : mask);
-
-	return 0;
-}
-
-static int stm32_pwm_enable(struct stm32_pwm *priv, unsigned int ch)
-{
-	u32 mask;
-	int ret;
-
-	ret = clk_enable(priv->clk);
-	if (ret)
-		return ret;
-
-	/* Enable channel */
-	mask = TIM_CCER_CCxE(ch + 1);
-	if (priv->have_complementary_output)
-		mask |= TIM_CCER_CCxNE(ch);
-
-	regmap_set_bits(priv->regmap, TIM_CCER, mask);
-
-	/* Make sure that registers are updated */
-	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
-
-	/* Enable controller */
-	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
-
-	return 0;
-}
-
-static void stm32_pwm_disable(struct stm32_pwm *priv, unsigned int ch)
-{
-	u32 mask;
-
-	/* Disable channel */
-	mask = TIM_CCER_CCxE(ch + 1);
-	if (priv->have_complementary_output)
-		mask |= TIM_CCER_CCxNE(ch + 1);
-
-	regmap_clear_bits(priv->regmap, TIM_CCER, mask);
-
-	/* When all channels are disabled, we can disable the controller */
-	if (!active_channels(priv))
-		regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
-
-	clk_disable(priv->clk);
-}
-
-static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			   const struct pwm_state *state)
-{
-	bool enabled;
-	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
-	int ret;
-
-	enabled = pwm->state.enabled;
-
-	if (!state->enabled) {
-		if (enabled)
-			stm32_pwm_disable(priv, pwm->hwpwm);
-		return 0;
-	}
-
-	if (state->polarity != pwm->state.polarity)
-		stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
-
-	ret = stm32_pwm_config(priv, pwm->hwpwm,
-			       state->duty_cycle, state->period);
-	if (ret)
-		return ret;
-
-	if (!enabled && state->enabled)
-		ret = stm32_pwm_enable(priv, pwm->hwpwm);
-
-	return ret;
-}
-
-static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
-				  const struct pwm_state *state)
-{
-	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
-	int ret;
-
-	/* protect common prescaler for all active channels */
-	mutex_lock(&priv->lock);
-	ret = stm32_pwm_apply(chip, pwm, state);
-	mutex_unlock(&priv->lock);
-
-	return ret;
-}
-
-static int stm32_pwm_get_state(struct pwm_chip *chip,
-			       struct pwm_device *pwm, struct pwm_state *state)
-{
-	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
-	int ch = pwm->hwpwm;
-	unsigned long rate;
-	u32 ccer, psc, arr, ccr;
-	u64 dty, prd;
-	int ret;
-
-	mutex_lock(&priv->lock);
-
-	ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
-	if (ret)
-		goto out;
-
-	state->enabled = ccer & TIM_CCER_CCxE(ch + 1);
-	state->polarity = (ccer & TIM_CCER_CCxP(ch + 1)) ?
-			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
-	ret = regmap_read(priv->regmap, TIM_PSC, &psc);
-	if (ret)
-		goto out;
-	ret = regmap_read(priv->regmap, TIM_ARR, &arr);
-	if (ret)
-		goto out;
-	ret = regmap_read(priv->regmap, TIM_CCRx(ch + 1), &ccr);
-	if (ret)
-		goto out;
-
-	rate = clk_get_rate(priv->clk);
-
-	prd = (u64)NSEC_PER_SEC * (psc + 1) * (arr + 1);
-	state->period = DIV_ROUND_UP_ULL(prd, rate);
-	dty = (u64)NSEC_PER_SEC * (psc + 1) * ccr;
-	state->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
-
-out:
-	mutex_unlock(&priv->lock);
-	return ret;
-}
-
 static const struct pwm_ops stm32pwm_ops = {
-	.apply = stm32_pwm_apply_locked,
-	.get_state = stm32_pwm_get_state,
+	.sizeof_wfhw = sizeof(struct stm32_pwm_waveform),
+	.round_waveform_tohw = stm32_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = stm32_pwm_round_waveform_fromhw,
+	.read_waveform = stm32_pwm_read_waveform,
+	.write_waveform = stm32_pwm_write_waveform,
+
 	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
 };
 
-- 
2.43.0


