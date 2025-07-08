Return-Path: <linux-pwm+bounces-6787-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CCFAFD52B
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DC0481AAE
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FDB2E5B3C;
	Tue,  8 Jul 2025 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R0JuGPTG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30411F9E8
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995158; cv=none; b=E2FuNQPSqOsi5SgJfij4oMEo4Rb8vLw3SWF0N2MA/7otLYoG+rRDYeuT+kO2u4uDSN+kkYswAyVN7/rlkdfTU5ffqhf81W8MFoUabBoCk0MpNoWnbWHtlTcjoBGz+DOacqqGbsdTTzP5GUtQgwwXMbofSYK1JQC4hn5ojlkYi+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995158; c=relaxed/simple;
	bh=gInSbyerMY5QiR6IcP2Kx8q4XKMVjYKeQFViDJERSPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCojyqxTHNKRI21j4Xpto2e5/xmrdux0OEJ7z+vEkDx91POPSrDoEk03W93Q+eOVEAY0BgBuffhvM1Yq9LT88dJVGSn3bsbWhrQLSQ7qv9oJPsp4MfZzZKs4KHlPB1QGUfbvwcuJYyqXR0WHX46U5GfMGB/GTfECw4j0sThmZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R0JuGPTG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso992965866b.2
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995154; x=1752599954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vy4Q5haFsYAqjA0+y4VjNlU3TUnjPrupOzMl88Fq3mg=;
        b=R0JuGPTGZsvLN9mEYMJwY9/m5b4SOrppLGw2LT9JiDL/mG0HmjxV3baF0wbAHNPdRH
         e2ovHe2i010RY+kNLDZrAadjxT9YX6ixIjvIR2aK7GvOYTH+jSh08evayvjHxyTU3Ulz
         vP6JQP0Yi5/kcGotUaKT0AhnvqMbrwqylHJgDeodkVLSOP11e69ruuJlJIVhfPvguhAg
         eJyHePGmMoHMGiPy9W6+tW/KWUU7v5EdFYMxpGvOvX7a/xk8tYY9GWbcNPeHcWAH79xl
         oGEp8/cL8e0Al7wlCz83rOKrM63+DzbAAsJjJqisxpzg0sljs3RzbUobbxvrvw2fM1LL
         JFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995154; x=1752599954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy4Q5haFsYAqjA0+y4VjNlU3TUnjPrupOzMl88Fq3mg=;
        b=RxLGbf6mQ4P0UVt9gmPZ5teoX6NLjKNCMg7ZXWIgK+igo3sfg0T1xNNHitLw+ZvxgH
         bORfrmcJQsUnxzXum1CPCsGrwaritNgN6nh6iGX136+qeRy/wdii35dLrh6IEW228nIq
         Lq3kS6gBaqu2bTv7sCUyd6RZbCS0SEHF60HaNYPw0S9zY5uO1ZVmz57yf21fuU8CZNnq
         EfmMILq0Qe8JShPBAVNrgBKNEzDWbRHiBMfptKpZtqfd9CJ+o2YawwHvG/FMGmAVWXvQ
         yPV0HOmNHUExP4ETI3ZgoaX1HgXSRTo1tylDifDcI7R9CPA4mcMuT9eO/ldpnvyWyqzT
         M9IA==
X-Gm-Message-State: AOJu0YwbyL+f4bnOKHQf32jWHu1/kB1z1qH5nQlEmoaXanZ3dU7WBYwZ
	i77iCFamlvHrFOKhNUXjttOqlXlaALzSc8mMPJaqpB0SAlXwhr5+3pp5xnmN+SaSWQc=
X-Gm-Gg: ASbGncuGKp6A+Ui0V13Jd3RX74Q47vrM3RqrnSM4qCygiyTLWCv8H2NqTaFbCyXhtwb
	Lx0cuJc3sQguZmdyIOefgPMQNp3X9RFr024WUNmfE77XrwQQzMs8Vr11hdwholO/waVUpYhB0Od
	2tJVNOU9Q89BQUMzEfw9742hvbrKaASw7viTuCUIt9NUs5PopZWbruFe/Z0nHP31BomnM+I/hU1
	e8+yJmmKNjyAl5U8QXXf7Aa7U2xNH4QpkffTNTCrAHnHiZ+E2jCN4Od+Pv6WLKvptNxEgfHg+t2
	aAb5zRbF6A27DTN/8p8qip1VkAqWwRYZVZDJ6pd2k8087/iQh0CrJCKHXsXKyD6SOWyo4lrOMeA
	PnWH6oKJNlaTfqfzJwA231siK003mTQTQdZNXv24=
X-Google-Smtp-Source: AGHT+IGZXNtMTO7EOjafG1ARt6E30CW0hAiH+W0FNZW7yFLiedXmHnmVViRT+pX+e838RCwyysqZvw==
X-Received: by 2002:a17:907:9407:b0:ae0:c441:d54b with SMTP id a640c23a62f3a-ae3fe5964f3mr1545247766b.9.1751995154448;
        Tue, 08 Jul 2025 10:19:14 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60fcb0c790dsm7507963a12.37.2025.07.08.10.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:19:14 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 8/8] pwm: mediatek: Convert to waveform API
Date: Tue,  8 Jul 2025 19:18:38 +0200
Message-ID:  <a638f074ef24c46035fa1563ab6b4350ebc89580.1751994509.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
References: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11131; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=gInSbyerMY5QiR6IcP2Kx8q4XKMVjYKeQFViDJERSPA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVL+zi6STXwyZMQQHRlNRIa4pn43y9axH37Oq Ktbk4RBY4KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1S/gAKCRCPgPtYfRL+ TswMB/4hOFFOJaOXkphUMe5VuixTXt+9AYNmqEhHcvf7aCX13rKL9kIigKXvUFkcJyvHSnsom27 Ygq/Rs/RA36WCoTIz/T3jNGBanIz6JHNFQaJ23tTTXb4WaogyB5kgqP1FllpUAr/TVup3qTjD0f PY+7w5NnJfG1aJClM4uUlwRZSu4hR/c+kVZYMkKGMX7pa9A7sxmfKD7OjCkKusnnjboErPJ/q1q mE1B+K7a9TClBrmE3sjxHk5tdLgRoOouaCtN7qiijtnNvTEwaczMtts1Lg2hBlsYxiXHKuq2qNa 9oGi31eByVFONn9lIIEoyWzGxbbDpWBBnbsK8EYUeBNDV14r
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Implement the new waveform callbacks which makes the usage of this
hardware more flexible and allows to use it via the pwm character
device.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 287 ++++++++++++++++++++++---------------
 1 file changed, 173 insertions(+), 114 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index c48d46124059..43bdd1fe3de0 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -135,29 +135,51 @@ static inline u32 pwm_mediatek_readl(struct pwm_mediatek_chip *chip,
 		     num * chip->soc->chanreg_width + offset);
 }
 
-static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			       u64 duty_ns, u64 period_ns)
+struct pwm_mediatek_waveform {
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
 	u32 clkdiv;
-	u32 reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
 	u64 cnt_period, cnt_duty;
 	unsigned long clk_rate;
 	int ret;
 
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
 	if (cnt_period == 0)
-		return -ERANGE;
+		cnt_period = 1;
 
 	if (cnt_period > FIELD_MAX(PWMDWIDTH_PERIOD)) {
 		if (cnt_period >= (FIELD_MAX(PWMDWIDTH_PERIOD) << FIELD_MAX(PWMCON_CLKDIV))) {
@@ -171,102 +193,76 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		clkdiv = 0;
 	}
 
-	cnt_duty = mul_u64_u64_div_u64(duty_ns, clk_rate, NSEC_PER_SEC) >> clkdiv;
+	cnt_duty = mul_u64_u64_div_u64(wf->duty_length_ns, clk_rate, NSEC_PER_SEC) >> clkdiv;
 	if (cnt_duty > cnt_period)
 		cnt_duty = cnt_period;
 
 	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld @%lu -> CLKDIV: %x, PERIOD: %llx, DUTY: %llx\n",
-		pwm->hwpwm, duty_ns, period_ns, clk_rate, clkdiv, cnt_period, cnt_duty);
+		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, clk_rate,
+		clkdiv, cnt_period, cnt_duty);
 
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
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
-
-	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
-
-	return ret;
-}
-
-static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-	int ret;
-
-	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
-	if (ret < 0)
-		return ret;
-
-	value = readl(pc->regs);
-	value |= BIT(pwm->hwpwm);
-	writel(value, pc->regs);
+	*wfhw = (typeof(*wfhw)){
+		.con = BIT(15) | clkdiv,
+		.width = cnt_period,
+		.thres = cnt_duty,
+	};
 
 	return 0;
 }
 
-static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int pwm_mediatek_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+					      const void *_wfhw, struct pwm_waveform *wf)
 {
+	const struct pwm_mediatek_waveform *wfhw = _wfhw;
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
+	int ret = 0;
 
-	value = readl(pc->regs);
-	value &= ~BIT(pwm->hwpwm);
-	writel(value, pc->regs);
+	if (wfhw->con & BIT(15)) {
+		u32 clkdiv, cnt_period, cnt_duty;
+		unsigned long clk_rate;
 
-	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
-}
-
-static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			      const struct pwm_state *state)
-{
-	int err;
-
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EINVAL;
-
-	if (!state->enabled) {
-		if (pwm->state.enabled)
-			pwm_mediatek_disable(chip, pwm);
-
-		return 0;
-	}
-
-	err = pwm_mediatek_config(chip, pwm, state->duty_cycle, state->period);
-	if (err)
-		return err;
-
-	if (!pwm->state.enabled)
-		err = pwm_mediatek_enable(chip, pwm);
-
-	return err;
-}
-
-static int pwm_mediatek_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-				  struct pwm_state *state)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	int ret;
-	u32 enable;
-	u32 reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
-
-	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
 		/*
-		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
-		 * from the other PWMs on MT7623.
+		 * When _wfhw was populated, the clock was on, so .rate is
+		 * already set appropriately.
 		 */
-		reg_width = PWM45DWIDTH_FIXUP;
-		reg_thres = PWM45THRES_FIXUP;
+		clk_rate = pc->clk_pwms[pwm->hwpwm].rate;
+
+		clkdiv = FIELD_GET(PWMCON_CLKDIV, wfhw->con);
+		cnt_period = FIELD_GET(PWMDWIDTH_PERIOD, wfhw->width);
+		cnt_duty = FIELD_GET(PWMTHRES_DUTY, wfhw->thres);
+
+		/*
+		 * cnt_period is a 13 bit value, NSEC_PER_SEC is 30 bits wide
+		 * and clkdiv is less than 8, so the multiplication doesn't
+		 * overflow an u64.
+		 */
+		*wf = (typeof(*wf)){
+			.period_length_ns =
+				DIV_ROUND_UP_ULL((u64)cnt_period * NSEC_PER_SEC << clkdiv, clk_rate),
+			.duty_length_ns =
+				DIV_ROUND_UP_ULL((u64)cnt_duty * NSEC_PER_SEC << clkdiv, clk_rate),
+			.duty_offset_ns = 0,
+		};
+		dev_dbg(&chip->dev, "pwm#%u: CLKDIV: %x, PERIOD: %x, DUTY: %x @%lu -> %lld/%lld\n",
+			pwm->hwpwm, clkdiv, cnt_period, cnt_duty, clk_rate,
+			wf->duty_length_ns, wf->period_length_ns);
+	} else {
+		*wf = (typeof(*wf)){
+			.period_length_ns = 0,
+		};
 	}
 
+	return ret;
+}
+
+static int pwm_mediatek_read_waveform(struct pwm_chip *chip,
+				      struct pwm_device *pwm, void *_wfhw)
+{
+	struct pwm_mediatek_waveform *wfhw = _wfhw;
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 enable;
+	int ret;
+
 	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
 	if (ret < 0)
 		return ret;
@@ -274,31 +270,30 @@ static int pwm_mediatek_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	enable = readl(pc->regs);
 	if (enable & BIT(pwm->hwpwm)) {
 		u32 clkdiv, cnt_period, cnt_duty;
-		unsigned long clk_rate;
+		u32 reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
 
-		clk_rate = pc->clk_pwms[pwm->hwpwm].rate;
+		if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
+			/*
+			 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
+			 * from the other PWMs on MT7623.
+			 */
+			reg_width = PWM45DWIDTH_FIXUP;
+			reg_thres = PWM45THRES_FIXUP;
+		}
 
-		state->enabled = true;
-		state->polarity = PWM_POLARITY_NORMAL;
+		clkdiv = FIELD_GET(PWMCON_CLKDIV, pwm_mediatek_readl(pc, pwm->hwpwm, PWMCON));
+		cnt_period = FIELD_GET(PWMDWIDTH_PERIOD, pwm_mediatek_readl(pc, pwm->hwpwm, reg_width));
+		cnt_duty = FIELD_GET(PWMTHRES_DUTY, pwm_mediatek_readl(pc, pwm->hwpwm, reg_thres));
 
-		clkdiv = FIELD_GET(PWMCON_CLKDIV,
-				   pwm_mediatek_readl(pc, pwm->hwpwm, PWMCON));
-		cnt_period = FIELD_GET(PWMDWIDTH_PERIOD,
-				       pwm_mediatek_readl(pc, pwm->hwpwm, reg_width));
-		cnt_duty = FIELD_GET(PWMTHRES_DUTY,
-				     pwm_mediatek_readl(pc, pwm->hwpwm, reg_thres));
-
-		/*
-		 * cnt_period is a 13 bit value, NSEC_PER_SEC is 30 bits wide
-		 * and clkdiv is less than 8, so the multiplication doesn't
-		 * overflow an u64.
-		 */
-		state->period =
-			DIV_ROUND_UP_ULL((u64)cnt_period * NSEC_PER_SEC << clkdiv, clk_rate);
-		state->duty_cycle =
-			DIV_ROUND_UP_ULL((u64)cnt_duty * NSEC_PER_SEC << clkdiv, clk_rate);
+		*wfhw = (typeof(*wfhw)){
+			.con = BIT(15) | clkdiv,
+			.width = cnt_period,
+			.thres = cnt_duty,
+		};
 	} else {
-		state->enabled = false;
+		*wfhw = (typeof(*wfhw)){
+			.con = 0,
+		};
 	}
 
 	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
@@ -306,9 +301,73 @@ static int pwm_mediatek_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
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
+	pwm_mediatek_clk_disable(pc, pwm->hwpwm);
+
+	return ret;
+}
+
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
2.49.0


