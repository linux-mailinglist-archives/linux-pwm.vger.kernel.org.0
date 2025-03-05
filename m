Return-Path: <linux-pwm+bounces-5096-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54459A4FAC8
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 10:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81743ACEE9
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 09:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E832066EF;
	Wed,  5 Mar 2025 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DxAEFKvg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179842063D1;
	Wed,  5 Mar 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168453; cv=none; b=FgeDacs35fW5KCkSNE5OheoiSUPNP55jlgZJ4CU2VXdIjI3cXvIiXxYxCOqNggwya6TZSEVIPn8lo8/z2n3AvBZXTb3Ca4+bt3lfLhtfH8SMr7p2kZQSQZXMufMPyT4z3UMAFrtDEuRWInz9GLA4J2D34xPoGab3O/q/1v2rZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168453; c=relaxed/simple;
	bh=Tk+vNXgV7x32I9U0Pq9nSLP0JeM0+PJS9QtWMSGvr84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyfhXljE1bKuk4oYAzD33A+UimmZUgZaF8+ArG/eE/gi0CmacdfRfE+Sid0LpVneRzkG3N8m42ZRzfA1pCuID/Z/1gtF6rCpV3oYq0evK9HlIPpt256A2P2mFc0avUvwYKBqMsjZkM5CLHbD0xPmLv/p8WuY+TWyvr1irRv6090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DxAEFKvg; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52597bf7011098;
	Wed, 5 Mar 2025 10:53:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NFmaPbBCj78i+Eq0pfuk7qL4k2/hx5EKHhr/p17PtjI=; b=DxAEFKvg3Ql1GHg5
	r6O1Cf272RbqTdSPzHrZBRjs6F4y4CwU9/WZ8aVB/xVzsWCH0TAMni4spwnb7pb5
	7vsMCXZ7s6LroAoVXmGuJ3BWdoQX+7D+EoPEgqMDjnBJAw2ZkOAG/QrS+FYY3eKp
	sOnUKSHgvjDE4sz7eQmAeFCByB6cpH0RSmma31wvZuiKkVzv4cxzhOm1Nk78tadS
	TxnIF9VoxdDFRm1wbNqgB3Xuu/ZxMr1CszbIeMpraHs5u5DzM73YgwhUyqXrQDhx
	mEizQPfwmUqjM0ruBH9tws1/JHotmarDs5yXCIm6PNKf1yWctcmHadsvmDLKt3Lx
	T8K5fg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 455wbht7y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 10:53:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AAE1F40088;
	Wed,  5 Mar 2025 10:52:46 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node6.st.com [10.75.129.135])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ECFD85A8C93;
	Wed,  5 Mar 2025 10:49:54 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE6.st.com
 (10.75.129.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 10:49:54 +0100
Received: from localhost (10.48.86.222) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 10:49:54 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jic23@kernel.org>, <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <wbg@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v3 5/8] pwm: stm32-lp: add support for stm32mp25
Date: Wed, 5 Mar 2025 10:49:32 +0100
Message-ID: <20250305094935.595667-6-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
References: <20250305094935.595667-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-05_01,2024-11-22_01

Add support for STM32MP25 SoC. A new compatible has been added to the
dt-bindings. It represents handle new features, registers and bits
diversity.
It isn't used currently in the driver, as matching is done by retrieving
MFD parent data.

New dedicated capture/compare channels has been added: e.g. a new compare
register for channel 2. Some controls (polarity / cc channel enable) are
handled in CCMR register on this new variant (instead of wavepol bit).

So, Low-power timer can now have up to two PWM outputs. Use device data
from the MFD parent to configure the number of PWM channels e.g. 'npwm'.

Update current get_state() and apply() ops to support either:
- one PWM channel (as on older revision, or LPTIM5 on STM32MP25)
- two PWM channels (e.g. LPTIM1/2/3/4 on STM32MP25 that has the full
  feature set)
Introduce new routines to manage common prescaler, reload register and
global enable bit.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in V2:
- rely on fallback compatible as no specific .data is associated to the
  driver. Matching is achieved by using MFD parent data.
- renamed registers/bits defintions
---
 drivers/pwm/pwm-stm32-lp.c | 219 ++++++++++++++++++++++++++++++++-----
 1 file changed, 193 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 5832dce8ed9d..4789eafb8bac 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -20,6 +20,7 @@
 struct stm32_pwm_lp {
 	struct clk *clk;
 	struct regmap *regmap;
+	unsigned int num_cc_chans;
 };
 
 static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
@@ -30,13 +31,101 @@ static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
 /* STM32 Low-Power Timer is preceded by a configurable power-of-2 prescaler */
 #define STM32_LPTIM_MAX_PRESCALER	128
 
+static int stm32_pwm_lp_update_allowed(struct stm32_pwm_lp *priv, int channel)
+{
+	int ret;
+	u32 ccmr1;
+	unsigned long ccmr;
+
+	/* Only one PWM on this LPTIMER: enable, prescaler and reload value can be changed */
+	if (!priv->num_cc_chans)
+		return true;
+
+	ret = regmap_read(priv->regmap, STM32_LPTIM_CCMR1, &ccmr1);
+	if (ret)
+		return ret;
+	ccmr = ccmr1 & (STM32_LPTIM_CC1E | STM32_LPTIM_CC2E);
+
+	/* More than one channel enabled: enable, prescaler or ARR value can't be changed */
+	if (bitmap_weight(&ccmr, sizeof(u32) * BITS_PER_BYTE) > 1)
+		return false;
+
+	/*
+	 * Only one channel is enabled (or none): check status on the other channel, to
+	 * report if enable, prescaler or ARR value can be changed.
+	 */
+	if (channel)
+		return !(ccmr1 & STM32_LPTIM_CC1E);
+	else
+		return !(ccmr1 & STM32_LPTIM_CC2E);
+}
+
+static int stm32_pwm_lp_compare_channel_apply(struct stm32_pwm_lp *priv, int channel,
+					      bool enable, enum pwm_polarity polarity)
+{
+	u32 ccmr1, val, mask;
+	bool reenable;
+	int ret;
+
+	/* No dedicated CC channel: nothing to do */
+	if (!priv->num_cc_chans)
+		return 0;
+
+	ret = regmap_read(priv->regmap, STM32_LPTIM_CCMR1, &ccmr1);
+	if (ret)
+		return ret;
+
+	if (channel) {
+		/* Must disable CC channel (CCxE) to modify polarity (CCxP), then re-enable */
+		reenable = (enable && FIELD_GET(STM32_LPTIM_CC2E, ccmr1)) &&
+			(polarity != FIELD_GET(STM32_LPTIM_CC2P, ccmr1));
+
+		mask = STM32_LPTIM_CC2SEL | STM32_LPTIM_CC2E | STM32_LPTIM_CC2P;
+		val = FIELD_PREP(STM32_LPTIM_CC2P, polarity);
+		val |= FIELD_PREP(STM32_LPTIM_CC2E, enable);
+	} else {
+		reenable = (enable && FIELD_GET(STM32_LPTIM_CC1E, ccmr1)) &&
+			(polarity != FIELD_GET(STM32_LPTIM_CC1P, ccmr1));
+
+		mask = STM32_LPTIM_CC1SEL | STM32_LPTIM_CC1E | STM32_LPTIM_CC1P;
+		val = FIELD_PREP(STM32_LPTIM_CC1P, polarity);
+		val |= FIELD_PREP(STM32_LPTIM_CC1E, enable);
+	}
+
+	if (reenable) {
+		u32 cfgr, presc;
+		unsigned long rate;
+		unsigned int delay_us;
+
+		ret = regmap_update_bits(priv->regmap, STM32_LPTIM_CCMR1,
+					 channel ? STM32_LPTIM_CC2E : STM32_LPTIM_CC1E, 0);
+		if (ret)
+			return ret;
+		/*
+		 * After a write to the LPTIM_CCMRx register, a new write operation can only be
+		 * performed after a delay of at least (PRESC × 3) clock cycles
+		 */
+		ret = regmap_read(priv->regmap, STM32_LPTIM_CFGR, &cfgr);
+		if (ret)
+			return ret;
+		presc = FIELD_GET(STM32_LPTIM_PRESC, cfgr);
+		rate = clk_get_rate(priv->clk) >> presc;
+		if (!rate)
+			return -EINVAL;
+		delay_us = 3 * DIV_ROUND_UP(USEC_PER_SEC, rate);
+		usleep_range(delay_us, delay_us * 2);
+	}
+
+	return regmap_update_bits(priv->regmap, STM32_LPTIM_CCMR1, mask, val);
+}
+
 static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const struct pwm_state *state)
 {
 	struct stm32_pwm_lp *priv = to_stm32_pwm_lp(chip);
 	unsigned long long prd, div, dty;
 	struct pwm_state cstate;
-	u32 val, mask, cfgr, presc = 0;
+	u32 arr, val, mask, cfgr, presc = 0;
 	bool reenable;
 	int ret;
 
@@ -45,10 +134,28 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (!state->enabled) {
 		if (cstate.enabled) {
-			/* Disable LP timer */
-			ret = regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
+			/* Disable CC channel if any */
+			ret = stm32_pwm_lp_compare_channel_apply(priv, pwm->hwpwm, false,
+								 state->polarity);
 			if (ret)
 				return ret;
+			ret = regmap_write(priv->regmap, pwm->hwpwm ?
+					   STM32_LPTIM_CCR2 : STM32_LPTIM_CMP, 0);
+			if (ret)
+				return ret;
+
+			/* Check if the timer can be disabled */
+			ret = stm32_pwm_lp_update_allowed(priv, pwm->hwpwm);
+			if (ret < 0)
+				return ret;
+
+			if (ret) {
+				/* Disable LP timer */
+				ret = regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
+				if (ret)
+					return ret;
+			}
+
 			/* disable clock to PWM counter */
 			clk_disable(priv->clk);
 		}
@@ -79,6 +186,23 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	dty = prd * state->duty_cycle;
 	do_div(dty, state->period);
 
+	ret = regmap_read(priv->regmap, STM32_LPTIM_CFGR, &cfgr);
+	if (ret)
+		return ret;
+
+	/*
+	 * When there are several channels, they share the same prescaler and reload value.
+	 * Check if this can be changed, or the values are the same for all channels.
+	 */
+	if (!stm32_pwm_lp_update_allowed(priv, pwm->hwpwm)) {
+		ret = regmap_read(priv->regmap, STM32_LPTIM_ARR, &arr);
+		if (ret)
+			return ret;
+
+		if ((FIELD_GET(STM32_LPTIM_PRESC, cfgr) != presc) || (arr != prd - 1))
+			return -EBUSY;
+	}
+
 	if (!cstate.enabled) {
 		/* enable clock to drive PWM counter */
 		ret = clk_enable(priv->clk);
@@ -86,15 +210,20 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			return ret;
 	}
 
-	ret = regmap_read(priv->regmap, STM32_LPTIM_CFGR, &cfgr);
-	if (ret)
-		goto err;
-
 	if ((FIELD_GET(STM32_LPTIM_PRESC, cfgr) != presc) ||
-	    (FIELD_GET(STM32_LPTIM_WAVPOL, cfgr) != state->polarity)) {
+	    ((FIELD_GET(STM32_LPTIM_WAVPOL, cfgr) != state->polarity) && !priv->num_cc_chans)) {
 		val = FIELD_PREP(STM32_LPTIM_PRESC, presc);
-		val |= FIELD_PREP(STM32_LPTIM_WAVPOL, state->polarity);
-		mask = STM32_LPTIM_PRESC | STM32_LPTIM_WAVPOL;
+		mask = STM32_LPTIM_PRESC;
+
+		if (!priv->num_cc_chans) {
+			/*
+			 * WAVPOL bit is only available when no capature compare channel is used,
+			 * e.g. on LPTIMER instances that have only one output channel. CCMR1 is
+			 * used otherwise.
+			 */
+			val |= FIELD_PREP(STM32_LPTIM_WAVPOL, state->polarity);
+			mask |= STM32_LPTIM_WAVPOL;
+		}
 
 		/* Must disable LP timer to modify CFGR */
 		reenable = true;
@@ -120,20 +249,27 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret)
 		goto err;
 
-	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, prd - (1 + dty));
+	/* Write CMP/CCRx register and ensure it's been properly written */
+	ret = regmap_write(priv->regmap, pwm->hwpwm ? STM32_LPTIM_CCR2 : STM32_LPTIM_CMP,
+			   prd - (1 + dty));
 	if (ret)
 		goto err;
 
-	/* ensure CMP & ARR registers are properly written */
-	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
+	/* ensure ARR and CMP/CCRx registers are properly written */
+	ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val, pwm->hwpwm ?
+				       (val & STM32_LPTIM_CMP2_ARROK) == STM32_LPTIM_CMP2_ARROK :
 				       (val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK,
 				       100, 1000);
 	if (ret) {
 		dev_err(pwmchip_parent(chip), "ARR/CMP registers write issue\n");
 		goto err;
 	}
-	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
-			   STM32_LPTIM_CMPOKCF_ARROKCF);
+	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR, pwm->hwpwm ?
+			   STM32_LPTIM_CMP2OKCF_ARROKCF : STM32_LPTIM_CMPOKCF_ARROKCF);
+	if (ret)
+		goto err;
+
+	ret = stm32_pwm_lp_compare_channel_apply(priv, pwm->hwpwm, true, state->polarity);
 	if (ret)
 		goto err;
 
@@ -161,11 +297,22 @@ static int stm32_pwm_lp_get_state(struct pwm_chip *chip,
 {
 	struct stm32_pwm_lp *priv = to_stm32_pwm_lp(chip);
 	unsigned long rate = clk_get_rate(priv->clk);
-	u32 val, presc, prd;
+	u32 val, presc, prd, ccmr1;
+	bool enabled;
 	u64 tmp;
 
 	regmap_read(priv->regmap, STM32_LPTIM_CR, &val);
-	state->enabled = !!FIELD_GET(STM32_LPTIM_ENABLE, val);
+	enabled = !!FIELD_GET(STM32_LPTIM_ENABLE, val);
+	if (priv->num_cc_chans) {
+		/* There's a CC chan, need to also check if it's enabled */
+		regmap_read(priv->regmap, STM32_LPTIM_CCMR1, &ccmr1);
+		if (pwm->hwpwm)
+			enabled &= !!FIELD_GET(STM32_LPTIM_CC2E, ccmr1);
+		else
+			enabled &= !!FIELD_GET(STM32_LPTIM_CC1E, ccmr1);
+	}
+	state->enabled = enabled;
+
 	/* Keep PWM counter clock refcount in sync with PWM initial state */
 	if (state->enabled) {
 		int ret = clk_enable(priv->clk);
@@ -176,14 +323,21 @@ static int stm32_pwm_lp_get_state(struct pwm_chip *chip,
 
 	regmap_read(priv->regmap, STM32_LPTIM_CFGR, &val);
 	presc = FIELD_GET(STM32_LPTIM_PRESC, val);
-	state->polarity = FIELD_GET(STM32_LPTIM_WAVPOL, val);
+	if (priv->num_cc_chans) {
+		if (pwm->hwpwm)
+			state->polarity = FIELD_GET(STM32_LPTIM_CC2P, ccmr1);
+		else
+			state->polarity = FIELD_GET(STM32_LPTIM_CC1P, ccmr1);
+	} else {
+		state->polarity = FIELD_GET(STM32_LPTIM_WAVPOL, val);
+	}
 
 	regmap_read(priv->regmap, STM32_LPTIM_ARR, &prd);
 	tmp = prd + 1;
 	tmp = (tmp << presc) * NSEC_PER_SEC;
 	state->period = DIV_ROUND_CLOSEST_ULL(tmp, rate);
 
-	regmap_read(priv->regmap, STM32_LPTIM_CMP, &val);
+	regmap_read(priv->regmap, pwm->hwpwm ? STM32_LPTIM_CCR2 : STM32_LPTIM_CMP, &val);
 	tmp = prd - val;
 	tmp = (tmp << presc) * NSEC_PER_SEC;
 	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
@@ -201,15 +355,25 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct stm32_pwm_lp *priv;
 	struct pwm_chip *chip;
+	unsigned int npwm;
 	int ret;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (!ddata->num_cc_chans) {
+		/* No dedicated CC channel, so there's only one PWM channel */
+		npwm = 1;
+	} else {
+		/* There are dedicated CC channels, each with one PWM output */
+		npwm = ddata->num_cc_chans;
+	}
+
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*priv));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	priv = to_stm32_pwm_lp(chip);
 
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
+	priv->num_cc_chans = ddata->num_cc_chans;
 	chip->ops = &stm32_pwm_lp_ops;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
@@ -225,12 +389,15 @@ static int stm32_pwm_lp_suspend(struct device *dev)
 {
 	struct pwm_chip *chip = dev_get_drvdata(dev);
 	struct pwm_state state;
-
-	pwm_get_state(&chip->pwms[0], &state);
-	if (state.enabled) {
-		dev_err(dev, "The consumer didn't stop us (%s)\n",
-			chip->pwms[0].label);
-		return -EBUSY;
+	unsigned int i;
+
+	for (i = 0; i < chip->npwm; i++) {
+		pwm_get_state(&chip->pwms[i], &state);
+		if (state.enabled) {
+			dev_err(dev, "The consumer didn't stop us (%s)\n",
+				chip->pwms[i].label);
+			return -EBUSY;
+		}
 	}
 
 	return pinctrl_pm_select_sleep_state(dev);
-- 
2.25.1


