Return-Path: <linux-pwm+bounces-3304-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BA097D338
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 11:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3402EB23258
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7878113AA3F;
	Fri, 20 Sep 2024 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OS5hM2Bn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4413C69E
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822732; cv=none; b=oB877+JylgWZY5qEk0KxU0pwpvwPX1f5aylPAYjfOnkWs7EzdV3TdXGZhyNyiKR72n5c+Vlwm0meo5yeBCMDU50eXMZXYNgPD8sE3iCVV/MoHUz8ds4zHNt9HIctjaAL/WittUrzSYMe8KxCatZi/qx3oTTSMsXBi26bnoZNtdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822732; c=relaxed/simple;
	bh=Pt0gGq5PqUYKMJVbZTZGrF1lXLaJKbMjz12HL+NgmpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwiqnMuVgr/tO7boWgMhWiOo/N3qxBJhgokZTvYdjPoxSWtpXUFaAATZRYXkUZzfGbgYZR/s6Jkb5bflRLq3Ab25pZrihOqCTgPV8tcanJxWFVZR3vDt78E2jsgl6xy1eZ1VN58lHU7ZO49TBQ9PYohgDmGArKJTZ435iYofmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OS5hM2Bn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso16287705e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726822728; x=1727427528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRYFIX4QNA1UrKn7Y+CTn9YbiEsF2DJR8AyC9fr371A=;
        b=OS5hM2BnuB0/YaOpCLy/SfMFhUCK8effZPK9ySKU4K3U3pEhb0WQLmDJcLHVGsgPsZ
         8zo9/eQlATQJIDRcyntiAY8o1YJYVIJIHPXUiRGHYY+ovdhEtQ7lWmnk7cGIi9ORFiOV
         MV0au6sZpwtDRwvkYFK13JmmCEf3pf7GYBEeU6+RatPz+BK3s7mcHfbHSV5XYqtdeHTW
         W3BGTZe3UJXnnFmlztOZZdp/y3USulsVA4DErmN2Bw+RAQVNVqGv6pRZHbZyh7ZeEf7b
         yH08eu99oZ6eFbgVx8lObBErimdk/oBZNlkZTim/jq09Ko0AG4UnD8R+2rcBWB2VQ7ea
         hSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726822728; x=1727427528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRYFIX4QNA1UrKn7Y+CTn9YbiEsF2DJR8AyC9fr371A=;
        b=WNRsC2HHO95X53YBrCM/S6Ddv7p0b+tESjLke70hXAvc14JvpmA+gy30AJe/oMcKTx
         cTQdvKAf5jEMiQY95Wp+XsmzWrSVNY9M+4U49V2tICBCm8CZU5Vnkk087qwPX0mHyc10
         2DRrfX6gKnB6TO3woiKEgM5TDgEVKWddCm4jjnpB9dGKGXAHq33UoGHBJJKCtHwcvKZ9
         NKnLtceR0xE3oKZZhEBxpS7UKYVYjU2xpQ74bopil096vxEMcWbsuSQYJyNu4oPsCnWR
         MGADIfiYzU2n6iK+lEmmVPH/lvFZmRe72QkdfUmwMAbt5Uci+txIJQJI6fMHbSONjCe1
         ICUQ==
X-Gm-Message-State: AOJu0YzR1qGSk7i5KGn9s6tdETuoewdvFvnmAiTQJaXVl8vLJnDLXyP3
	cAgTkC5Wo5GdN/myyDRyzrkkEEzDRLnTf/rs55a0uvae97OBVRlpDNSDhm+oyEmGeAxHPxSRO6n
	S
X-Google-Smtp-Source: AGHT+IHgss2TTzbJSnRe+z3u6lOXm9dOvhSHzvfDZ4w9a9nr6VZRVMftMwLfPcmmi2xeISHkjY8jUg==
X-Received: by 2002:a05:600c:358b:b0:42c:b1e1:a45b with SMTP id 5b1f17b1804b1-42e7c16ed53mr12779775e9.19.1726822727996;
        Fri, 20 Sep 2024 01:58:47 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e754a6d46sm44247015e9.36.2024.09.20.01.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:58:46 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 6/8] pwm: stm32: Implementation of the waveform callbacks
Date: Fri, 20 Sep 2024 10:58:02 +0200
Message-ID:  <332d4f736d8360038d03f109c013441c655eea23.1726819463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=17361; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Pt0gGq5PqUYKMJVbZTZGrF1lXLaJKbMjz12HL+NgmpE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm7TkkjaFdly+FWEFMq+p7KM5CxkHAVSu4QZw/Q 4VVeQPZBsKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZu05JAAKCRCPgPtYfRL+ TgcMB/9ph0ze1nTTLt/8ZEG2/ErhswCZB1v6dq6MA9/BqURZygtPMHJ1SwMRZRHF/FMXHPJBRad PwXniMlcitUe2lzzoexbGvZqqdHioi/JFiM2m0qotHiIVc+RAJOeB1Dwk+richo66HYg6y1ntm3 6kLPb7XeI6yO7xagSYeHFCw6YRj+Mrxe0gw97BbFCmGvEXfS6Xy7lhPT0W7+PpFh4EbyltNtMRa UtZVGdmHDY5PAqCiM48lkOu4kDqAf24EQ19iczaUuXM+9OYVc+jmbFuwGjwbJXQQmezIEvuKkYc 0MC1p3A1Dzt3Yup2SmJ6+FSbmJ2d6ry5pClvPga0I6ygzLBQ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Convert the stm32 pwm driver to use the new callbacks for hardware
programming.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 612 +++++++++++++++++++++++++---------------
 1 file changed, 391 insertions(+), 221 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index eb24054f9729..d2c1085aee74 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -51,6 +51,391 @@ static u32 active_channels(struct stm32_pwm *dev)
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
+	if (wf->period_length_ns == 0) {
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
+		wfhw->ccer = TIM_CCER_CCxNE(ch + 1);
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
+		arr = mul_u64_u64_div_u64(wf->period_length_ns, rate,
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
+		u64 psc = mul_u64_u64_div_u64(wf->period_length_ns, rate,
+					      (u64)NSEC_PER_SEC * ((u64)priv->max_arr + 1));
+		u64 arr;
+
+		wfhw->psc = min_t(u64, psc, MAX_TIM_PSC);
+
+		arr = mul_u64_u64_div_u64(wf->period_length_ns, rate,
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
+	duty = mul_u64_u64_div_u64(wf->duty_length_ns, rate,
+				   (u64)NSEC_PER_SEC * (wfhw->psc + 1));
+	duty = min_t(u64, duty, wfhw->arr + 1);
+
+	if (wf->duty_length_ns && wf->duty_offset_ns &&
+	    wf->duty_length_ns + wf->duty_offset_ns >= wf->period_length_ns) {
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
+		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
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
+		wf->period_length_ns = stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1),
+									     NSEC_PER_SEC, rate);
+
+		ccr_ns = stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * wfhw->ccr,
+							       NSEC_PER_SEC, rate);
+
+		if (wfhw->ccer & TIM_CCER_CCxP(ch + 1)) {
+			wf->duty_length_ns =
+				stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1 - wfhw->ccr),
+								      NSEC_PER_SEC, rate);
+
+			wf->duty_offset_ns = ccr_ns;
+		} else {
+			wf->duty_length_ns = ccr_ns;
+			wf->duty_offset_ns = 0;
+		}
+
+		dev_dbg(&chip->dev, "pwm#%u: CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x @%lu -> %lld/%lld [+%lld]\n",
+			pwm->hwpwm, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr, rate,
+			wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
+
+	} else {
+		*wf = (struct pwm_waveform){
+			.period_length_ns = 0,
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
+		unsigned int shift;
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
@@ -308,228 +693,13 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
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
-		mask |= TIM_CCER_CCxNE(ch + 1);
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
2.45.2


