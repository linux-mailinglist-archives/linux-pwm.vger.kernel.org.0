Return-Path: <linux-pwm+bounces-3051-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B915958BF9
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF261C20DB8
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5C195FD1;
	Tue, 20 Aug 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tcn2AZ9c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A773176
	for <linux-pwm@vger.kernel.org>; Tue, 20 Aug 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170259; cv=none; b=eQZBNxzRWXabtbxBmHoPPWEDlNYygcWzMtEa59bQgu8WzUqfad72w9yH+3JOipNyawbZogn897XEp6NyAsYTQ34HEdp6nh7+TlRuCco8rgrT0QQdxjUNi0G5Qzeb7ANvWEeK5MVl/V/CFFad6RiNTRSF8VfzY7iatHrv08AoqxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170259; c=relaxed/simple;
	bh=0oLWEGlt7Ed82jm0B4wK0jk1LLmfdSDskn8jYm14/Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oUeZIDovKk0v3JVcxIK5evXQbeNk4EH4ynOuFsGyygwyY9iM0NUY1wzA+U7uBWxbpz/4j1O7szDdSBf2Czy1i4D/hifORJGhUEHci/gGljAm+ClcM7dYowM52yU/fezOpPUNmanBENMyfrFsA2yD6XhisxdGIBZdxNp3h+wzkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tcn2AZ9c; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KCG7OR001966;
	Tue, 20 Aug 2024 18:10:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	uRTPY9h6Z7jXq/wjIwfLd6Sl5wL7GKW7jj95KhTFGIs=; b=tcn2AZ9cpgQyqFp0
	XGhja/qYCaxKmlkhjYjOezxbBFVH4GRu4lpXo+4lCWzZ8Eiq6lldavQgrn5A8M0V
	1Xpf+5F//9ObwIT5YyP8UxlOeD7GhJLaHgMkFZj5k7ZTOwHl9VBvvvWcliZzWno9
	hFioeUWSKojpxXEqZ/3c/S4MfCWorOE3Ork45baN2kLDT58En61kqScFQUb+R/qQ
	sIoD3QoGjkDMa3Q9dar2JkRbxOYs8vQeLq79BLISwWy8f7kXjIl0/c1642RRp3yX
	2fua6tA8d/LLpcLpbJWw544voP59wG0rcphmH2RNFO3Sc6bmnt8KOI1ICW/9MFr9
	lMwWfA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 414u0h8r5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 18:10:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 721444002D;
	Tue, 20 Aug 2024 18:10:28 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C77CC278F77;
	Tue, 20 Aug 2024 18:10:01 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 20 Aug
 2024 18:10:01 +0200
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 20 Aug
 2024 18:10:00 +0200
Message-ID: <3515a8f3-436e-4d14-9bac-dfe6aa869819@foss.st.com>
Date: Tue, 20 Aug 2024 18:09:59 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] pwm: stm32: Implementation of the waveform
 callbacks
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        <linux-pwm@vger.kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Trevor Gamblin
	<tgamblin@baylibre.com>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
 <b193c8d4bc8e188ad6b4b4ddb6f730308d7f1099.1722261050.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <b193c8d4bc8e188ad6b4b4ddb6f730308d7f1099.1722261050.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_11,2024-08-19_03,2024-05-17_01

On 7/29/24 16:34, Uwe Kleine-König wrote:
> Convert the stm32 pwm driver to use the new callbacks for hardware
> programming.

Hi Uwe,

Sorry it took me some time to start to have a look. I only had an
overview on the series, and this patch. I'd have some overall question
on the waveform support (on the delay offset).

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/pwm-stm32.c | 607 +++++++++++++++++++++++++---------------
>  1 file changed, 386 insertions(+), 221 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index fd754a99cf2e..846da265bbfe 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -51,6 +51,386 @@ static u32 active_channels(struct stm32_pwm *dev)
>  	return ccer & TIM_CCER_CCXE;
>  }
>  
> +struct stm32_pwm_waveform {
> +	u32 ccer;
> +	u32 psc;
> +	u32 arr;
> +	u32 ccr;
> +};
> +
> +static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const struct pwm_waveform *wf,
> +					 void *_wfhw)
> +{
> +	struct stm32_pwm_waveform *wfhw = _wfhw;
> +	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
> +	unsigned int ch = pwm->hwpwm;
> +	unsigned long rate;
> +	u64 ccr, duty;
> +	int ret;
> +
> +	if (wf->period_length_ns == 0) {
> +		*wfhw = (struct stm32_pwm_waveform){
> +			.ccer = 0,
> +		};
> +
> +		return 0;
> +	}
> +
> +	ret = clk_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	wfhw->ccer = TIM_CCER_CCxE(ch + 1);
> +	if (priv->have_complementary_output)
> +		wfhw->ccer = TIM_CCER_CCxNE(ch);

Need to use (ch + 1 here), and avoid overriding ccer when
have_complementary_output is true, e.g.

	if (priv->have_complementary_output)
		wfhw->ccer |= TIM_CCER_CCxNE(ch + 1);

> +
> +	rate = clk_get_rate(priv->clk);
> +
> +	if (active_channels(priv) & ~(1 << ch * 4)) {
> +		u64 arr;
> +
> +		/*
> +		 * Other channels are already enabled, so the configured PSC and
> +		 * ARR must be used for this channel, too.
> +		 */
> +		ret = regmap_read(priv->regmap, TIM_PSC, &wfhw->psc);
> +		if (ret)
> +			goto out;
> +
> +		ret = regmap_read(priv->regmap, TIM_ARR, &wfhw->arr);
> +		if (ret)
> +			goto out;
> +
> +		/*
> +		 * calculate the best value for ARR for the given PSC, refuse if
> +		 * the resulting period gets bigger than the requested one.
> +		 */
> +		arr = mul_u64_u64_div_u64(wf->period_length_ns, rate,
> +					  (u64)NSEC_PER_SEC * (wfhw->psc + 1));
> +		if (arr <= wfhw->arr) {
> +			/*
> +			 * requested period is small than the currently
> +			 * configured and unchangable period, report back the smallest
> +			 * possible period, i.e. the current state; Initialize
> +			 * ccr to anything valid.
> +			 */
> +			wfhw->ccr = 0;
> +			ret = 1;

I'm suprised, I'm more used to return negative error codes. This may
cascade up to the sysfs interface. Is there some possible side effect ?

I could see in your commit message in "pwm: New abstraction for PWM
waveforms" that "... this fact is signaled by a return value of 1".

Perhaps some define could be used, to better point that ?

> +			goto out;
> +		}
> +
> +	} else {
> +		/*
> +		 * .probe() asserted that clk_get_rate() is not bigger than 1 GHz, so
> +		 * the calculations here won't overflow.
> +		 * First we need to find the minimal value for prescaler such that
> +		 *
> +		 *        period_ns * clkrate
> +		 *   ------------------------------ < max_arr + 1
> +		 *   NSEC_PER_SEC * (prescaler + 1)
> +		 *
> +		 * This equation is equivalent to
> +		 *
> +		 *        period_ns * clkrate
> +		 *   ---------------------------- < prescaler + 1
> +		 *   NSEC_PER_SEC * (max_arr + 1)
> +		 *
> +		 * Using integer division and knowing that the right hand side is
> +		 * integer, this is further equivalent to
> +		 *
> +		 *   (period_ns * clkrate) // (NSEC_PER_SEC * (max_arr + 1)) ≤ prescaler
> +		 */
> +		u64 psc = mul_u64_u64_div_u64(wf->period_length_ns, rate,
> +					      (u64)NSEC_PER_SEC * ((u64)priv->max_arr + 1));
> +		u64 arr;
> +
> +		wfhw->psc = min_t(u64, psc, MAX_TIM_PSC);
> +
> +		arr = mul_u64_u64_div_u64(wf->period_length_ns, rate,
> +					  (u64)NSEC_PER_SEC * (wfhw->psc + 1));
> +		if (!arr) {
> +			/*
> +			 * requested period is too small, report back the smallest
> +			 * possible period, i.e. ARR = 0. The only valid CCR
> +			 * value is then zero, too.
> +			 */
> +			wfhw->arr = 0;
> +			wfhw->ccr = 0;
> +			ret = 1;

same questions here

> +			goto out;
> +		}
> +
> +		/*
> +		 * ARR is limited intentionally to values less than
> +		 * priv->max_arr to allow 100% duty cycle.
> +		 */
> +		wfhw->arr = min_t(u64, arr, priv->max_arr) - 1;
> +	}
> +
> +	duty = mul_u64_u64_div_u64(wf->duty_length_ns, rate,
> +				   (u64)NSEC_PER_SEC * (wfhw->psc + 1));
> +	duty = min_t(u64, duty, wfhw->arr + 1);
> +
> +	if (wf->duty_length_ns && wf->duty_offset_ns &&
> +	    wf->duty_length_ns + wf->duty_offset_ns >= wf->period_length_ns) {

The condition here (mixing && + >=) is rather hard to read, could it be
more readable ?

It's more clear when reading pwm_wf2state() and pwm_state2wf() the
condition for normal/inversed polarity rather looks like:

if (wf->period_length_ns) {
	if (wf->duty_length_ns + wf->duty_offset_ns < wf->period_length_ns)
	/* normal */
	else
	/* inversed */

BTW I notice small difference here: (wf->duty_length_ns &&
wf->duty_offset_ns)

Suggestion: could use some (new) helper function or macro from the pwm
core ? e.g. rather than implementing in the driver ?


> +		wfhw->ccer |= TIM_CCER_CCxP(ch + 1);
> +		if (priv->have_complementary_output)
> +			wfhw->ccer |= TIM_CCER_CCxNP(ch + 1);
> +
> +		ccr = wfhw->arr + 1 - duty;
> +	} else {
> +		ccr = duty;
> +	}
> +
> +	wfhw->ccr = min_t(u64, ccr, wfhw->arr + 1);
> +
> +	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> CCER: %08x, PSC: %08x, ARR: %08x, CCR: %08x\n",
> +		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
> +		rate, wfhw->ccer, wfhw->psc, wfhw->arr, wfhw->ccr);
> +
> +out:
> +	clk_disable(priv->clk);
> +
> +	return ret;
> +}
> +
> +/*
> + * This should be moved to lib/math/div64.c. Currently there are some changes
> + * pending to mul_u64_u64_div_u64. Uwe will care for that when the dust settles.
> + */
> +static u64 stm32_pwm_mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c)
> +{
> +	u64 res = mul_u64_u64_div_u64(a, b, c);
> +	/* Those multiplications might overflow but it doesn't matter */
> +	u64 rem = a * b - c * res;
> +
> +	if (rem)
> +		res += 1;
> +
> +	return res;
> +}
> +
> +static int stm32_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const void *_wfhw,
> +					   struct pwm_waveform *wf)
> +{
> +	const struct stm32_pwm_waveform *wfhw = _wfhw;
> +	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
> +	unsigned int ch = pwm->hwpwm;
> +
> +	if (wfhw->ccer & TIM_CCER_CCxE(ch + 1)) {
> +		unsigned long rate = clk_get_rate(priv->clk);
> +		u64 ccr_ns;
> +
> +		/* The result doesn't overflow for rate >= 15259 */
> +		wf->period_length_ns = stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1),
> +									     NSEC_PER_SEC, rate);
> +
> +		ccr_ns = stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * wfhw->ccr,
> +							       NSEC_PER_SEC, rate);
> +
> +		if (wfhw->ccer & TIM_CCER_CCxP(ch + 1)) {
> +			wf->duty_length_ns =
> +				stm32_pwm_mul_u64_u64_div_u64_roundup(((u64)wfhw->psc + 1) * (wfhw->arr + 1 - wfhw->ccr),
> +								      NSEC_PER_SEC, rate);
> +
> +			wf->duty_offset_ns = ccr_ns;
> +		} else {
> +			wf->duty_length_ns = ccr_ns;
> +			wf->duty_offset_ns = 0;
> +		}

Well, my main confusion is around duty_offset_ns. Indeed, it's right
here, that with PWM mode 1 (CCMR bit 5 and 6 set later on), only
possibilty is to have either 0, or the period - duty cycle as delay when
polarity is inversed.

I gave it a try (basic testing), but user doesn't get information when
setting a waveform (with a valid duty_offset_ns), but the hardware
doesn't necessarily apply it when writing the waveform ? What's your
advise / opinion ?



> +	} else {
> +		*wf = (struct pwm_waveform){
> +			.period_length_ns = 0,
> +		};
> +	}

Would be nice to add similar dev_dbg() as in
stm32_pwm_round_waveform_tohw().


Thanks for your patch,
Best Regards,
Fabrice

> +
> +	return 0;
> +}
> +
> +static int stm32_pwm_read_waveform(struct pwm_chip *chip,
> +				     struct pwm_device *pwm,
> +				     void *_wfhw)
> +{
> +	struct stm32_pwm_waveform *wfhw = _wfhw;
> +	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
> +	unsigned int ch = pwm->hwpwm;
> +	int ret;
> +
> +	ret = clk_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(priv->regmap, TIM_CCER, &wfhw->ccer);
> +	if (ret)
> +		goto out;
> +
> +	if (wfhw->ccer & TIM_CCER_CCxE(ch + 1)) {
> +		ret = regmap_read(priv->regmap, TIM_PSC, &wfhw->psc);
> +		if (ret)
> +			goto out;
> +
> +		ret = regmap_read(priv->regmap, TIM_ARR, &wfhw->arr);
> +		if (ret)
> +			goto out;
> +
> +		if (wfhw->arr == U32_MAX)
> +			wfhw->arr -= 1;
> +
> +		ret = regmap_read(priv->regmap, TIM_CCRx(ch + 1), &wfhw->ccr);
> +		if (ret)
> +			goto out;
> +
> +		if (wfhw->ccr > wfhw->arr + 1)
> +			wfhw->ccr = wfhw->arr + 1;
> +	}
> +
> +out:
> +	clk_disable(priv->clk);
> +
> +	return ret;
> +}
> +
> +static int stm32_pwm_write_waveform(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      const void *_wfhw)
> +{
> +	const struct stm32_pwm_waveform *wfhw = _wfhw;
> +	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
> +	unsigned int ch = pwm->hwpwm;
> +	int ret;
> +
> +	ret = clk_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	if (wfhw->ccer & TIM_CCER_CCxE(ch + 1)) {
> +		u32 ccer, mask;
> +		unsigned int shift;
> +		u32 ccmr;
> +
> +		ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
> +		if (ret)
> +			goto out;
> +
> +		/* If there are other channels enabled, don't update PSC and ARR */
> +		if (ccer & ~TIM_CCER_CCxE(ch + 1) & TIM_CCER_CCXE) {
> +			u32 psc, arr;
> +
> +			ret = regmap_read(priv->regmap, TIM_PSC, &psc);
> +			if (ret)
> +				goto out;
> +
> +			if (psc != wfhw->psc) {
> +				ret = -EBUSY;
> +				goto out;
> +			}
> +
> +			regmap_read(priv->regmap, TIM_ARR, &arr);
> +			if (ret)
> +				goto out;
> +
> +			if (arr != wfhw->arr) {
> +				ret = -EBUSY;
> +				goto out;
> +			}
> +		} else {
> +			ret = regmap_write(priv->regmap, TIM_PSC, wfhw->psc);
> +			if (ret)
> +				goto out;
> +
> +			ret = regmap_write(priv->regmap, TIM_ARR, wfhw->arr);
> +			if (ret)
> +				goto out;
> +
> +			ret = regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
> +			if (ret)
> +				goto out;
> +
> +		}
> +
> +		/* set polarity */
> +		mask = TIM_CCER_CCxP(ch + 1) | TIM_CCER_CCxNP(ch + 1);
> +		ret = regmap_update_bits(priv->regmap, TIM_CCER, mask, wfhw->ccer);
> +		if (ret)
> +			goto out;
> +
> +		ret = regmap_write(priv->regmap, TIM_CCRx(ch + 1), wfhw->ccr);
> +		if (ret)
> +			goto out;
> +
> +		/* Configure output mode */
> +		shift = (ch & 0x1) * CCMR_CHANNEL_SHIFT;
> +		ccmr = (TIM_CCMR_PE | TIM_CCMR_M1) << shift;
> +		mask = CCMR_CHANNEL_MASK << shift;
> +
> +		if (ch < 2)
> +			ret = regmap_update_bits(priv->regmap, TIM_CCMR1, mask, ccmr);
> +		else
> +			ret = regmap_update_bits(priv->regmap, TIM_CCMR2, mask, ccmr);
> +		if (ret)
> +			goto out;
> +
> +		ret = regmap_set_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE);
> +		if (ret)
> +			goto out;
> +
> +		if (!(ccer & TIM_CCER_CCxE(ch + 1))) {
> +			mask = TIM_CCER_CCxE(ch + 1) | TIM_CCER_CCxNE(ch + 1);
> +
> +			ret = clk_enable(priv->clk);
> +			if (ret)
> +				goto out;
> +
> +			ccer = (ccer & ~mask) | (wfhw->ccer & mask);
> +			regmap_write(priv->regmap, TIM_CCER, ccer);
> +
> +			/* Make sure that registers are updated */
> +			regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
> +
> +			/* Enable controller */
> +			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
> +		}
> +
> +	} else {
> +		/* disable channel */
> +		u32 mask, ccer;
> +
> +		mask = TIM_CCER_CCxE(ch + 1);
> +		if (priv->have_complementary_output)
> +			mask |= TIM_CCER_CCxNE(ch + 1);
> +
> +		ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
> +		if (ret)
> +			goto out;
> +
> +		if (ccer & mask) {
> +			ccer = ccer & ~mask;
> +
> +			ret = regmap_write(priv->regmap, TIM_CCER, ccer);
> +			if (ret)
> +				goto out;
> +
> +			if (!(ccer & TIM_CCER_CCXE)) {
> +				/* When all channels are disabled, we can disable the controller */
> +				ret = regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
> +				if (ret)
> +					goto out;
> +			}
> +
> +			clk_disable(priv->clk);
> +		}
> +	}
> +
> +out:
> +	clk_disable(priv->clk);
> +
> +	return ret;
> +}
> +
>  #define TIM_CCER_CC12P (TIM_CCER_CC1P | TIM_CCER_CC2P)
>  #define TIM_CCER_CC12E (TIM_CCER_CC1E | TIM_CCER_CC2E)
>  #define TIM_CCER_CC34P (TIM_CCER_CC3P | TIM_CCER_CC4P)
> @@ -308,228 +688,13 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
>  	return ret;
>  }
>  
> -static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
> -			    u64 duty_ns, u64 period_ns)
> -{
> -	unsigned long long prd, dty;
> -	unsigned long long prescaler;
> -	u32 ccmr, mask, shift;
> -
> -	/*
> -	 * .probe() asserted that clk_get_rate() is not bigger than 1 GHz, so
> -	 * the calculations here won't overflow.
> -	 * First we need to find the minimal value for prescaler such that
> -	 *
> -	 *        period_ns * clkrate
> -	 *   ------------------------------ < max_arr + 1
> -	 *   NSEC_PER_SEC * (prescaler + 1)
> -	 *
> -	 * This equation is equivalent to
> -	 *
> -	 *        period_ns * clkrate
> -	 *   ---------------------------- < prescaler + 1
> -	 *   NSEC_PER_SEC * (max_arr + 1)
> -	 *
> -	 * Using integer division and knowing that the right hand side is
> -	 * integer, this is further equivalent to
> -	 *
> -	 *   (period_ns * clkrate) // (NSEC_PER_SEC * (max_arr + 1)) ≤ prescaler
> -	 */
> -
> -	prescaler = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
> -					(u64)NSEC_PER_SEC * ((u64)priv->max_arr + 1));
> -	if (prescaler > MAX_TIM_PSC)
> -		return -EINVAL;
> -
> -	prd = mul_u64_u64_div_u64(period_ns, clk_get_rate(priv->clk),
> -				  (u64)NSEC_PER_SEC * (prescaler + 1));
> -	if (!prd)
> -		return -EINVAL;
> -
> -	/*
> -	 * All channels share the same prescaler and counter so when two
> -	 * channels are active at the same time we can't change them
> -	 */
> -	if (active_channels(priv) & ~(1 << ch * 4)) {
> -		u32 psc, arr;
> -
> -		regmap_read(priv->regmap, TIM_PSC, &psc);
> -		regmap_read(priv->regmap, TIM_ARR, &arr);
> -
> -		if ((psc != prescaler) || (arr != prd - 1))
> -			return -EBUSY;
> -	}
> -
> -	regmap_write(priv->regmap, TIM_PSC, prescaler);
> -	regmap_write(priv->regmap, TIM_ARR, prd - 1);
> -	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE);
> -
> -	/* Calculate the duty cycles */
> -	dty = mul_u64_u64_div_u64(duty_ns, clk_get_rate(priv->clk),
> -				  (u64)NSEC_PER_SEC * (prescaler + 1));
> -
> -	regmap_write(priv->regmap, TIM_CCRx(ch + 1), dty);
> -
> -	/* Configure output mode */
> -	shift = (ch & 0x1) * CCMR_CHANNEL_SHIFT;
> -	ccmr = (TIM_CCMR_PE | TIM_CCMR_M1) << shift;
> -	mask = CCMR_CHANNEL_MASK << shift;
> -
> -	if (ch < 2)
> -		regmap_update_bits(priv->regmap, TIM_CCMR1, mask, ccmr);
> -	else
> -		regmap_update_bits(priv->regmap, TIM_CCMR2, mask, ccmr);
> -
> -	regmap_set_bits(priv->regmap, TIM_BDTR, TIM_BDTR_MOE);
> -
> -	return 0;
> -}
> -
> -static int stm32_pwm_set_polarity(struct stm32_pwm *priv, unsigned int ch,
> -				  enum pwm_polarity polarity)
> -{
> -	u32 mask;
> -
> -	mask = TIM_CCER_CCxP(ch + 1);
> -	if (priv->have_complementary_output)
> -		mask |= TIM_CCER_CCxNP(ch + 1);
> -
> -	regmap_update_bits(priv->regmap, TIM_CCER, mask,
> -			   polarity == PWM_POLARITY_NORMAL ? 0 : mask);
> -
> -	return 0;
> -}
> -
> -static int stm32_pwm_enable(struct stm32_pwm *priv, unsigned int ch)
> -{
> -	u32 mask;
> -	int ret;
> -
> -	ret = clk_enable(priv->clk);
> -	if (ret)
> -		return ret;
> -
> -	/* Enable channel */
> -	mask = TIM_CCER_CCxE(ch + 1);
> -	if (priv->have_complementary_output)
> -		mask |= TIM_CCER_CCxNE(ch);
> -
> -	regmap_set_bits(priv->regmap, TIM_CCER, mask);
> -
> -	/* Make sure that registers are updated */
> -	regmap_set_bits(priv->regmap, TIM_EGR, TIM_EGR_UG);
> -
> -	/* Enable controller */
> -	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
> -
> -	return 0;
> -}
> -
> -static void stm32_pwm_disable(struct stm32_pwm *priv, unsigned int ch)
> -{
> -	u32 mask;
> -
> -	/* Disable channel */
> -	mask = TIM_CCER_CCxE(ch + 1);
> -	if (priv->have_complementary_output)
> -		mask |= TIM_CCER_CCxNE(ch + 1);
> -
> -	regmap_clear_bits(priv->regmap, TIM_CCER, mask);
> -
> -	/* When all channels are disabled, we can disable the controller */
> -	if (!active_channels(priv))
> -		regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
> -
> -	clk_disable(priv->clk);
> -}
> -
> -static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> -			   const struct pwm_state *state)
> -{
> -	bool enabled;
> -	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
> -	int ret;
> -
> -	enabled = pwm->state.enabled;
> -
> -	if (!state->enabled) {
> -		if (enabled)
> -			stm32_pwm_disable(priv, pwm->hwpwm);
> -		return 0;
> -	}
> -
> -	if (state->polarity != pwm->state.polarity)
> -		stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
> -
> -	ret = stm32_pwm_config(priv, pwm->hwpwm,
> -			       state->duty_cycle, state->period);
> -	if (ret)
> -		return ret;
> -
> -	if (!enabled && state->enabled)
> -		ret = stm32_pwm_enable(priv, pwm->hwpwm);
> -
> -	return ret;
> -}
> -
> -static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
> -				  const struct pwm_state *state)
> -{
> -	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
> -	int ret;
> -
> -	/* protect common prescaler for all active channels */
> -	mutex_lock(&priv->lock);
> -	ret = stm32_pwm_apply(chip, pwm, state);
> -	mutex_unlock(&priv->lock);
> -
> -	return ret;
> -}
> -
> -static int stm32_pwm_get_state(struct pwm_chip *chip,
> -			       struct pwm_device *pwm, struct pwm_state *state)
> -{
> -	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
> -	int ch = pwm->hwpwm;
> -	unsigned long rate;
> -	u32 ccer, psc, arr, ccr;
> -	u64 dty, prd;
> -	int ret;
> -
> -	mutex_lock(&priv->lock);
> -
> -	ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
> -	if (ret)
> -		goto out;
> -
> -	state->enabled = ccer & TIM_CCER_CCxE(ch + 1);
> -	state->polarity = (ccer & TIM_CCER_CCxP(ch + 1)) ?
> -			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> -	ret = regmap_read(priv->regmap, TIM_PSC, &psc);
> -	if (ret)
> -		goto out;
> -	ret = regmap_read(priv->regmap, TIM_ARR, &arr);
> -	if (ret)
> -		goto out;
> -	ret = regmap_read(priv->regmap, TIM_CCRx(ch + 1), &ccr);
> -	if (ret)
> -		goto out;
> -
> -	rate = clk_get_rate(priv->clk);
> -
> -	prd = (u64)NSEC_PER_SEC * (psc + 1) * (arr + 1);
> -	state->period = DIV_ROUND_UP_ULL(prd, rate);
> -	dty = (u64)NSEC_PER_SEC * (psc + 1) * ccr;
> -	state->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
> -
> -out:
> -	mutex_unlock(&priv->lock);
> -	return ret;
> -}
> -
>  static const struct pwm_ops stm32pwm_ops = {
> -	.apply = stm32_pwm_apply_locked,
> -	.get_state = stm32_pwm_get_state,
> +	.sizeof_wfhw = sizeof(struct stm32_pwm_waveform),
> +	.round_waveform_tohw = stm32_pwm_round_waveform_tohw,
> +	.round_waveform_fromhw = stm32_pwm_round_waveform_fromhw,
> +	.read_waveform = stm32_pwm_read_waveform,
> +	.write_waveform = stm32_pwm_write_waveform,
> +
>  	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
>  };
>  

