Return-Path: <linux-pwm+bounces-3138-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B296FA26
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 19:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8197F1F23F13
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999041D2F57;
	Fri,  6 Sep 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X/r7bOZS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF51D6DA0
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645042; cv=none; b=PAlEkGr6FSyQEk5E09SuvJkJb5nrJmHkI6y7tDbHiieHla8nexhvLQIlvQINnjROk+GEFhsJWOWmeDO8s9MtpMtO15NzkBA9qbyDtlRwG0DrOHQhhzBsRkixplvh0RD3QPQUjGT/nYVk/UpnKW1Bxzb4EUHx+6HOFWg1QVemk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645042; c=relaxed/simple;
	bh=CYGQ3+nRBd2ms3LETqwoleQfFX2roqdewyqHSby0EPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rD4hZ7A6Eppoqwa8Y+MIRF4gsazU2jurX6tuz1SkovDMgwQ28MBHn4cZve55ztR07ah1VOdQc1zsDF4lXahXr/N4NEph422U4l02Sq5eOa3M1tYoj1TU23bdNqbQfXpOr/TbWbMwyO8qahIx1xq5wqQODnjqk0RsKjlAUppcmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X/r7bOZS; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1a9b40f6b3so2483401276.1
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725645038; x=1726249838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qB79PvO1IBLjzxeEQsljACnQE3gu/UHHOtrkdJGZtxQ=;
        b=X/r7bOZSTTQpnEvmkrcE92CMAZZSW3t4S7Y7kGBtV7emtdxC+oAYTkul6AbU0+adky
         lJ3007mYXcVYg4BicescUiCB8C/8nOm3dfslDFXzQgSyWxkVV1Eui4PNP3XXjVyGcvrZ
         7xknuwQ8G+1e3kqpkcXlK1XjZOOUOl45abh+O+4y/vz3Lsau3o8UriKV259OFqyIyNSi
         tSd9yNTC0Za9fUZL6heLYIuPETNtxeTzufXsFwWGp/cJ/ZzeSnXLdYGiaCYyzrgxFCEt
         6VBJudadppjdjvgEL+RIhP8cilNUI+aKd+yaJD2j0HqCVYpGlklo31w3QVLumjbWL8a1
         ipIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725645038; x=1726249838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qB79PvO1IBLjzxeEQsljACnQE3gu/UHHOtrkdJGZtxQ=;
        b=t9V4NEZ7R9/ec1OBUilrPUT+fUd8AtxgMwoVWZhuA2Ko5ziZPzbxbp1n/0kg6uIr/m
         GrKfZiPcsbzj/D4jhTZ++dlWJxJg9mypGL+glk6hB3n+mIYukLMlhXLIoByseIpQnw6c
         U0+Jic6FGczjh3P/78btvOXVgmwLJwCMS4Ern4XIjxcXLrGlMLBNCLsAkoWHCKx6na4q
         Q5dMKqokp4gjNjptGTB4SEwQYupX/d6wgXt/u+G5eNVJdPbd7C+1KpgCRSIy0QKPcBh+
         7g5X67AYVMb7Vg2bUW/13BF3qsQnc/quEEOaSmDEOObWRvrbrYVjw7iXAupENptW+6qe
         GXmw==
X-Forwarded-Encrypted: i=1; AJvYcCVNhK0mpFvBiil18EXvF3qbBEH/9abLk4OtHhgsnvCTUTWuHsf2u+P98dFSz9dXnzUAUG/VMJS/I84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1yoKTkkpSa1Y0IR72+Wnk61ONju3Z90I24A09S7dDaeSw/0ss
	NvawsmOJfLOmSyMWHacmAz5K1Y9z/nIdKf6KW8zWcFe1Fg26UptI1+1IdKPAWBw=
X-Google-Smtp-Source: AGHT+IHdKCrfvFlLt+0MjCR2fo8VNh9MdIy9pWDXNa86xJLSz5epbHZkBxEJpu3Nhc+ghhXVoXzqVg==
X-Received: by 2002:a05:6902:c06:b0:e1a:8857:96dd with SMTP id 3f1490d57ef6-e1d3489d80bmr4566183276.31.1725645037974;
        Fri, 06 Sep 2024 10:50:37 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201e42a5sm18572056d6.36.2024.09.06.10.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 10:50:37 -0700 (PDT)
Message-ID: <231db3b3-866c-4d6a-89e6-31eeeaf56e58@baylibre.com>
Date: Fri, 6 Sep 2024 13:50:36 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] pwm: New abstraction for PWM waveforms
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Kent Gibson <warthog618@gmail.com>, David Lechner <dlechner@baylibre.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <88d66bf04e90c21bde1b48baba9bf23446b7e701.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <88d66bf04e90c21bde1b48baba9bf23446b7e701.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-09-06 11:42, Uwe Kleine-König wrote:
> Up to now the configuration of a PWM setting is described exclusively by
> a struct pwm_state which contains information about period, duty_cycle,
> polarity and if the PWM is enabled. (There is another member usage_power
> which doesn't completely fit into pwm_state, I ignore it here for
> simplicity.)
>
> Instead of a polarity the new abstraction has a member duty_offset_ns
> that defines when the rising edge happens after the period start. This
> is more general, as with a pwm_state the rising edge can only happen at
> the period's start or such that the falling edge is at the end of the
> period (i.e. duty_offset_ns == 0 or duty_offset_ns == period_length_ns -
> duty_length_ns).
>
> A disabled PWM is modeled by .period_length_ns = 0. In my eyes this is a
> nice usage of that otherwise unusable setting, as it doesn't define
> anything about the future which matches the fact that consumers should
> consider the state of the output as undefined and it's just there to say
> "No further requirements about the output, you can save some power.".
>
> Further I renamed period and duty_cycle to period_length_ns and
> duty_length_ns. In the past there was confusion from time to time about
> duty_cycle being measured in nanoseconds because people expected a
> percentage of period instead. With "length_ns" as suffix the semantic
> should be more obvious to people unfamiliar with the pwm subsystem.
> period is renamed to period_length_ns for consistency.
>
> The API for consumers doesn't change yet, but lowlevel drivers can
> implement callbacks that work with pwm_waveforms instead of pwm_states.
> A new thing about these callbacks is that the calculation of hardware
> settings needed to implement a certain waveform is separated from
> actually writing these settings. The motivation for that is that this
> allows a consumer to query the hardware capabilities without actually
> modifying the hardware state.
>
> The rounding rules that are expected to be implemented in the
> round_waveform_tohw() are: First pick the biggest possible period not
> bigger than wf->period_length_ns. For that period pick the biggest
> possible duty setting not bigger than wf->duty_length_ns. Third pick the
> biggest possible offset not bigger than wf->duty_offset_ns. If the
> requested period is too small for the hardware, it's expected that a
> setting with the minimal period and duty_length_ns = duty_offset_ns = 0
> is returned and this fact is signaled by a return value of 1.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/pwm/core.c  | 234 ++++++++++++++++++++++++++++++++++++++++----
>   include/linux/pwm.h |  36 +++++++
>   2 files changed, 249 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 9752eb446879..a5aec732e2a4 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -49,6 +49,102 @@ static void pwmchip_unlock(struct pwm_chip *chip)
>   
>   DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
>   
> +static void pwm_wf2state(const struct pwm_waveform *wf, struct pwm_state *state)
> +{
> +	if (wf->period_length_ns) {
> +		if (wf->duty_length_ns + wf->duty_offset_ns < wf->period_length_ns)
> +			*state = (struct pwm_state){
> +				.enabled = true,
> +				.polarity = PWM_POLARITY_NORMAL,
> +				.period = wf->period_length_ns,
> +				.duty_cycle = wf->duty_length_ns,
> +			};
> +		else
> +			*state = (struct pwm_state){
> +				.enabled = true,
> +				.polarity = PWM_POLARITY_INVERSED,
> +				.period = wf->period_length_ns,
> +				.duty_cycle = wf->period_length_ns - wf->duty_length_ns,
> +			};
> +	} else {
> +		*state = (struct pwm_state){
> +			.enabled = false,
> +		};
> +	}
> +}
> +
> +static void pwm_state2wf(const struct pwm_state *state, struct pwm_waveform *wf)
> +{
> +	if (state->enabled) {
> +		if (state->polarity == PWM_POLARITY_NORMAL)
> +			*wf = (struct pwm_waveform){
> +				.period_length_ns = state->period,
> +				.duty_length_ns = state->duty_cycle,
> +				.duty_offset_ns = 0,
> +			};
> +		else
> +			*wf = (struct pwm_waveform){
> +				.period_length_ns = state->period,
> +				.duty_length_ns = state->period - state->duty_cycle,
> +				.duty_offset_ns = state->duty_cycle,
> +			};
> +	} else {
> +		*wf = (struct pwm_waveform){
> +			.period_length_ns = 0,
> +		};
> +	}
> +}
> +
> +static int pwm_check_rounding(const struct pwm_waveform *wf,
> +			      const struct pwm_waveform *wf_rounded)
> +{
> +	if (!wf->period_length_ns)
> +		return 0;
> +
> +	if (wf->period_length_ns < wf_rounded->period_length_ns)
> +		return 1;
> +
> +	if (wf->duty_length_ns < wf_rounded->duty_length_ns)
> +		return 1;
> +
> +	if (wf->duty_offset_ns < wf_rounded->duty_offset_ns)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int __pwm_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *pwm,
> +				     const struct pwm_waveform *wf, void *wfhw)
> +{
> +	const struct pwm_ops *ops = chip->ops;
> +
> +	return ops->round_waveform_tohw(chip, pwm, wf, wfhw);
> +}
> +
> +static int __pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
> +				       const void *wfhw, struct pwm_waveform *wf)
> +{
> +	const struct pwm_ops *ops = chip->ops;
> +
> +	return ops->round_waveform_fromhw(chip, pwm, wfhw, wf);
> +}
> +
> +static int __pwm_read_waveform(struct pwm_chip *chip, struct pwm_device *pwm, void *wfhw)
> +{
> +	const struct pwm_ops *ops = chip->ops;
> +
> +	return ops->read_waveform(chip, pwm, wfhw);
> +}
> +
> +static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, const void *wfhw)
> +{
> +	const struct pwm_ops *ops = chip->ops;
> +
> +	return ops->write_waveform(chip, pwm, wfhw);
> +}
> +
> +#define WFHWSIZE 20
> +
>   static void pwm_apply_debug(struct pwm_device *pwm,
>   			    const struct pwm_state *state)
>   {
> @@ -182,6 +278,7 @@ static bool pwm_state_valid(const struct pwm_state *state)
>   static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
>   {
>   	struct pwm_chip *chip;
> +	const struct pwm_ops *ops;
>   	int err;
>   
>   	if (!pwm || !state)
> @@ -205,6 +302,7 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
>   	}
>   
>   	chip = pwm->chip;
> +	ops = chip->ops;
>   
>   	if (state->period == pwm->state.period &&
>   	    state->duty_cycle == pwm->state.duty_cycle &&
> @@ -213,18 +311,69 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
>   	    state->usage_power == pwm->state.usage_power)
>   		return 0;
>   
> -	err = chip->ops->apply(chip, pwm, state);
> -	trace_pwm_apply(pwm, state, err);
> -	if (err)
> -		return err;
> +	if (ops->write_waveform) {
> +		struct pwm_waveform wf;
> +		char wfhw[WFHWSIZE];
>   
> -	pwm->state = *state;
> +		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
>   
> -	/*
> -	 * only do this after pwm->state was applied as some
> -	 * implementations of .get_state depend on this
> -	 */
> -	pwm_apply_debug(pwm, state);
> +		pwm_state2wf(state, &wf);
> +
> +		/*
> +		 * The rounding is wrong here for states with inverted polarity.
> +		 * While .apply() rounds down duty_cycle (which represents the
> +		 * time from the start of the period to the inner edge),
> +		 * .round_waveform_tohw() rounds down the time the PWM is high.
> +		 * Can be fixed if the need arises, until reported otherwise
> +		 * let's assume that consumers don't care.
> +		 */
> +
> +		err = __pwm_round_waveform_tohw(chip, pwm, &wf, &wfhw);
> +		if (err) {
> +			if (err > 0)
> +				/*
> +				 * This signals an invalid request, typically
> +				 * the requested period (or duty_offset) is
> +				 * smaller than possible with the hardware.
> +				 */
> +				return -EINVAL;
> +
> +			return err;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_PWM_DEBUG)) {
> +			struct pwm_waveform wf_rounded;
> +
> +			err = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
> +			if (err)
> +				return err;
> +
> +			if (pwm_check_rounding(&wf, &wf_rounded))
> +				dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
> +					wf.duty_length_ns, wf.period_length_ns, wf.duty_offset_ns,
> +					wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns);
> +		}
> +
> +		err = __pwm_write_waveform(chip, pwm, &wfhw);
> +		if (err)
> +			return err;
> +
> +		pwm->state = *state;
> +
> +	} else {
> +		err = ops->apply(chip, pwm, state);
> +		trace_pwm_apply(pwm, state, err);
> +		if (err)
> +			return err;
> +
> +		pwm->state = *state;
> +
> +		/*
> +		 * only do this after pwm->state was applied as some
> +		 * implementations of .get_state depend on this
> +		 */
> +		pwm_apply_debug(pwm, state);
> +	}
>   
>   	return 0;
>   }
> @@ -292,6 +441,41 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
>   }
>   EXPORT_SYMBOL_GPL(pwm_apply_atomic);
>   
> +static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
> +{
> +	struct pwm_chip *chip = pwm->chip;
> +	const struct pwm_ops *ops = chip->ops;
> +	int ret = -EOPNOTSUPP;
> +
> +	if (ops->read_waveform) {
> +		char wfhw[WFHWSIZE];
> +		struct pwm_waveform wf;
> +
> +		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
> +
> +		scoped_guard(pwmchip, chip) {
> +
> +			ret = __pwm_read_waveform(chip, pwm, &wfhw);
> +			if (ret)
> +				return ret;
> +
> +			ret = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		pwm_wf2state(&wf, state);
> +
> +	} else if (ops->get_state) {
> +		scoped_guard(pwmchip, chip)
> +			ret = ops->get_state(chip, pwm, state);
> +
> +		trace_pwm_get(pwm, state, ret);
> +	}
> +
> +	return ret;
> +}
> +
>   /**
>    * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
>    * @pwm: PWM device
> @@ -430,7 +614,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>   		}
>   	}
>   
> -	if (ops->get_state) {
> +	if (ops->read_waveform || ops->get_state) {
>   		/*
>   		 * Zero-initialize state because most drivers are unaware of
>   		 * .usage_power. The other members of state are supposed to be
> @@ -440,11 +624,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>   		 */
>   		struct pwm_state state = { 0, };
>   
> -		scoped_guard(pwmchip, chip)
> -			err = ops->get_state(chip, pwm, &state);
> -
> -		trace_pwm_get(pwm, &state, err);
> -
> +		err = pwm_get_state_hw(pwm, &state);
>   		if (!err)
>   			pwm->state = state;
>   
> @@ -1131,12 +1311,24 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
>   {
>   	const struct pwm_ops *ops = chip->ops;
>   
> -	if (!ops->apply)
> -		return false;
> +	if (ops->write_waveform) {
> +		if (!ops->round_waveform_tohw ||
> +		    !ops->round_waveform_fromhw ||
> +		    !ops->write_waveform)
> +			return false;
>   
> -	if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
> -		dev_warn(pwmchip_parent(chip),
> -			 "Please implement the .get_state() callback\n");
> +		if (WFHWSIZE < ops->sizeof_wfhw) {
> +			dev_warn(pwmchip_parent(chip), "WFHWSIZE < %zu\n", ops->sizeof_wfhw);
> +			return false;
> +		}
> +	} else {
> +		if (!ops->apply)
> +			return false;
> +
> +		if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
> +			dev_warn(pwmchip_parent(chip),
> +				 "Please implement the .get_state() callback\n");
> +	}
>   
>   	return true;
>   }
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 3ea73e075abe..6a26a5210dab 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -49,6 +49,31 @@ enum {
>   	PWMF_EXPORTED = 1,
>   };
>   
> +/*
> + * struct pwm_waveform - description of a PWM waveform
> + * @period_length_ns: PWM period
> + * @duty_length_ns: PWM duty cycle
> + * @duty_offset_ns: offset of the rising edge from the period's start
> + *
> + * This is a representation of a PWM waveform alternative to struct pwm_state
> + * below. It's more expressive than struct pwm_state as it contains a
> + * duty_offset_ns and so can represent offsets other than $period - $duty_cycle
> + * which is done using .polarity = PWM_POLARITY_INVERSED. Note there is no
> + * explicit bool for enabled. A "disabled" PWM is represented by
> + * .period_length_ns = 0.
> + *
> + * Note that the behaviour of a "disabled" PWM is undefined. Depending on the
> + * hardware's capabilities it might drive the active or inactive level, go
> + * high-z or even continue to toggle.
> + *
> + * The unit for all three members is nanoseconds.
> + */
> +struct pwm_waveform {
> +	u64 period_length_ns;
> +	u64 duty_length_ns;
> +	u64 duty_offset_ns;
> +};
> +
>   /*
>    * struct pwm_state - state of a PWM channel
>    * @period: PWM period (in nanoseconds)
> @@ -259,6 +284,17 @@ struct pwm_ops {
>   	void (*free)(struct pwm_chip *chip, struct pwm_device *pwm);
>   	int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,
>   		       struct pwm_capture *result, unsigned long timeout);
> +
> +	size_t sizeof_wfhw;
> +	int (*round_waveform_tohw)(struct pwm_chip *chip, struct pwm_device *pwm,
> +				   const struct pwm_waveform *wf, void *wfhw);
> +	int (*round_waveform_fromhw)(struct pwm_chip *chip, struct pwm_device *pwm,
> +				     const void *wfhw, struct pwm_waveform *wf);
> +	int (*read_waveform)(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    void *wfhw);
> +	int (*write_waveform)(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      const void *wfhw);
> +
>   	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
>   		     const struct pwm_state *state);
>   	int (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,

