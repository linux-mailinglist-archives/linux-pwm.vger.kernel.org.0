Return-Path: <linux-pwm+bounces-2733-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE592A8C9
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 20:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6B61C20D41
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0B1474A8;
	Mon,  8 Jul 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ASi/Y0kU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBAE14900B
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462365; cv=none; b=Yb8v+Cqfrdbwgv9lhbodkRkOtmeadkHDaYEEDtgjb+W03U58X6v8NC6zBXi6z1HWiWvTpm602shGjYr5xYNWKwQ67W7eTs+LVkjpmRdSBrF7h1NNzOaE24Wj45hsuv0KRJUg1vA9TEESia/2iSFeRUj4fLgkLJLcVNu0I4ub188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462365; c=relaxed/simple;
	bh=LLZ7Ti1TigAd8HUn9S7JhvHH6S7fZD3IAZskXfwiCPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDiEtV74XFSEY8OujtMy0fYApxHF983fbaOGgrOvsn1awdg9V7WimgioFyb5vseGerRidaNiSDEa+7/ftJcukIOCfUCNRYb6pv/3N7v33XR7DHlVOEF2IOaFNYbrwgEJ5rv99vydb1B2vM6nKYXRsM3ZkAtXSGl6qpm+aE6Cpr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ASi/Y0kU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79ef7edb08cso197419585a.2
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720462361; x=1721067161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3G5qiLTz4GfxsQWXnyyKEO74FPVBN5CQVLTrxKUlZ8c=;
        b=ASi/Y0kUaqCH+COe8eYNJQe+F4Z3Pktf7v/yPNIsRcMAOjscEofPciXiS7AxSzxkRh
         chlhKvB8D7UOtYWGkvMPgwEnVwL45oI2L2IACEezwKepSqzYVLL70HQ7BPXVBMRMZE8n
         EKWybiBvunmxElhZ+Qb2wjrSrvoTWLumFoYJrpgkfJJ/TQzVzGu4fZgCzkTQdZMIoGjw
         xAFSdg0AotG3EOs/6VT/gS1viDTCQDu8yZTGsH0MjJeeHgYGL0ahW5DWJH87exL+F0lY
         8lxSXhpJVwUfLFA0U7JhxjfcFBy3cvVe9Ou4Hr3dvYPvBp5mnIocWkuPRyYT+FBmPYx5
         FLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462361; x=1721067161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3G5qiLTz4GfxsQWXnyyKEO74FPVBN5CQVLTrxKUlZ8c=;
        b=NEca7TUjeBuHP9fq328JNa07Top24kG7RJXxNjxSkqqVNhBAAw1iNbiWUThH6+0b4b
         34+4rLfqnvrhC8hXW6Gm0S79lnUpB+ReTz0V+n/f1g8bqa2f9pzJoRG+m8RZXq1suhAU
         KH8+WFQCAdiRsmne68n8A0+pHdbj7mX+7n8Y52Z/OEF3mGJ5ZUmNUEEaR79tncDOZjOx
         fihw6mgK8FnswEJy4YLknw8WW1dzmWFSaGIiP0nFDJs7/VO+YPchR96kMkPlF5kFAzWi
         WIxTrfeVMZL7MEYqJzl/QRQvbnYJfeSsPpehZCivUO26gRBGKltE9DmFzMFInGRJPxQ0
         rxTg==
X-Forwarded-Encrypted: i=1; AJvYcCW0pQF9VSIJQ7RrZaxckXbwDu/qXc5yKBTzyauJCGYn/BC0PDv6DpuZ02h4m7zvLvAnqFlkU/7Cqt1F91E1hkmJs0KSgez/e6Js
X-Gm-Message-State: AOJu0YxEKVID2w3Upedm8DF0bMW4ejhZb2nCepejKKtphiybWYkW8OGv
	Nb+9RGEas4v8X8/LFjy+e4H8NzedjqmlWQ4qskPmPfAQT+87E6osog74jWTlAPk=
X-Google-Smtp-Source: AGHT+IECidL59sLd8x/QJ3E8fZupF/kgcvMgjhdsW/TTF5RhSUT71BAG89DXeL/GZMetTQRzZsrkVw==
X-Received: by 2002:a05:620a:4407:b0:79d:8042:cd01 with SMTP id af79cd13be357-79f19a35d98mr32814085a.7.1720462361351;
        Mon, 08 Jul 2024 11:12:41 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1908ae97sm14557385a.98.2024.07.08.11.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 11:12:41 -0700 (PDT)
Message-ID: <12c87440-0b54-4c98-a4a8-7ee46f19c5aa@baylibre.com>
Date: Mon, 8 Jul 2024 14:12:40 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] pwm: New abstraction for PWM waveforms
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
 <6f7deef208bf25baad7daa8ff35621fb68e7aeb4.1720435656.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <6f7deef208bf25baad7daa8ff35621fb68e7aeb4.1720435656.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-07-08 6:52 a.m., Uwe Kleine-König wrote:
> Up to now the configuration of a PWM setting is decribed exclusively by
> a struct pwm_state which contains information about period, duty_cycle,
> polarity and if the PWM is enabled. (There is another member usage_power
> which doesn't completely fit into pwm_state, I ignore it here for
> simplicity.)
>
> Instead of a polarity the new abstraction has a member duty_offset that
> defines when the rising edge happens after the period start. This is
> more general, as with a pwm_state the rising edge can only happen at the
> period's start or such that the falling edge is at the end of the period
> (i.e. duty_offset == 0 or duty_offset == period_lengh - duty_length).
>
> A disabled PWM is modeled by .period_length = 0. In my eyes this is a
> nice usage of that otherwise unusable setting, as it doesn't define
> anything about the future which matches the fact that consumers should
> consider the state of the output as undefined and it's just there to say
> "No further requirements about the output, you can save some power.".
>
> Further I renamed period and duty_cycle to period_length and
> duty_length. In the past there was confusion from time to time about
> duty_cycle being measured in nanoseconds because people expected a
> percentage of period instead. With "length" as suffix the semantic
> should be more obvious to people unfamiliar with the pwm subsystem.
> period is renamed period_length for consistency.
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
> bigger than wf->period_length. For that period pick the biggest possible
> duty setting not bigger than wf->duty_length. Third pick the biggest
> possible offset not bigger than wf->duty_offset. If the requested period
> is too small for the hardware, it's expected that a setting with the
> minimal period and duty_length = duty_offset = 0 is returned and this
> fact is signaled by a return value of 1.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/pwm/core.c  | 194 +++++++++++++++++++++++++++++++++++++++-----
>   include/linux/pwm.h |  35 ++++++++
>   2 files changed, 208 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index c31e12e76495..8e68481a7b33 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -49,6 +49,72 @@ static void pwmchip_unlock(struct pwm_chip *chip)
>   
>   DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
>   
> +static void pwm_wf2state(const struct pwm_waveform *wf, struct pwm_state *state)
> +{
> +	if (wf->period_length) {
> +		if (wf->duty_length + wf->duty_offset < wf->period_length)
> +			*state = (struct pwm_state){
> +				.enabled = true,
> +				.polarity = PWM_POLARITY_NORMAL,
> +				.period = wf->period_length,
> +				.duty_cycle = wf->duty_length,
> +			};
> +		else
> +			*state = (struct pwm_state){
> +				.enabled = true,
> +				.polarity = PWM_POLARITY_INVERSED,
> +				.period = wf->period_length,
> +				.duty_cycle = wf->period_length - wf->duty_length,
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
> +				.period_length = state->period,
> +				.duty_length = state->duty_cycle,
> +				.duty_offset = 0,
> +			};
> +		else
> +			*wf = (struct pwm_waveform){
> +				.period_length = state->period,
> +				.duty_length = state->period - state->duty_cycle,
> +				.duty_offset = state->duty_cycle,
> +			};
> +	} else {
> +		*wf = (struct pwm_waveform){
> +			.period_length = 0,
> +		};
> +	}
> +}
> +
> +static int pwm_check_rounding(const struct pwm_waveform *wf,
> +			      const struct pwm_waveform *wf_rounded)
> +{
> +	if (!wf->period_length)
> +		return 0;
> +
> +	if (wf->period_length < wf_rounded->period_length)
> +		return 1;
> +
> +	if (wf->duty_length < wf_rounded->duty_length)
> +		return 1;
> +
> +	if (wf->duty_offset < wf_rounded->duty_offset)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +#define WFHWSIZE 20
> +
>   static void pwm_apply_debug(struct pwm_device *pwm,
>   			    const struct pwm_state *state)
>   {
> @@ -182,6 +248,7 @@ static bool pwm_state_valid(const struct pwm_state *state)
>   static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
>   {
>   	struct pwm_chip *chip;
> +	const struct pwm_ops *ops;
>   	int err;
>   
>   	if (!pwm || !state)
> @@ -205,6 +272,7 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
>   	}
>   
>   	chip = pwm->chip;
> +	ops = chip->ops;
>   
>   	if (state->period == pwm->state.period &&
>   	    state->duty_cycle == pwm->state.duty_cycle &&
> @@ -213,18 +281,59 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
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
> +		 * XXX The rounding is wrong here for states with inverted
> +		 * polarity. While .apply() rounds down duty_cycle (which
> +		 * represents the time from the start of the period to the inner
> +		 * edge), .round_waveform_tohw() rounds down the time the PWM is
> +		 * high.
> +		 */
> +
> +		err = ops->round_waveform_tohw(chip, pwm, &wf, &wfhw);
> +		if (err)
> +			return err;
> +
> +		if (IS_ENABLED(PWM_DEBUG)) {
> +			struct pwm_waveform wf_rounded;
> +
> +			err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
> +			if (err)
> +				return err;
> +
> +			if (pwm_check_rounding(&wf, &wf_rounded))
> +				dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
> +					wf.duty_length, wf.period_length, wf.duty_offset,
> +					wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
> +		}
> +
> +		err = ops->write_waveform(chip, pwm, &wfhw);
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
> @@ -292,6 +401,41 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
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
> +			ret = ops->read_waveform(chip, pwm, &wfhw);
> +			if (ret)
> +				return ret;
> +
> +			ret = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf);
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
> @@ -433,7 +577,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>   		}
>   	}
>   
> -	if (ops->get_state) {
> +	if (ops->read_waveform || ops->get_state) {
>   		/*
>   		 * Zero-initialize state because most drivers are unaware of
>   		 * .usage_power. The other members of state are supposed to be
> @@ -443,11 +587,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
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
> @@ -1134,12 +1274,24 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
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
> index 5176dfebfbfd..b5dff2a99038 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -49,6 +49,30 @@ enum {
>   	PWMF_EXPORTED = 1,
>   };
>   
> +/*
> + * struct pwm_waveform - description of a PWM waveform
> + * @period_length: PWM period
> + * @duty_length: PWM duty cycle
> + * @duty_offset: offset of the rising edge from the period's start
> + *
> + * This is a representation of a PWM waveform alternative to struct pwm_state
> + * below. It's more expressive than struct pwm_state as it contains a
> + * duty_offset and so can represent offsets other than $period - $duty_cycle
> + * which is done using .polarity = PWM_POLARITY_INVERSED. Note there is no
> + * explicit bool for enabled. A "disabled" PWM is represented by .period = 0.
> + *
> + * Note that the behaviour of a "disabled" PWM is undefined. Depending on the
> + * hardware's capabilities it might drive the active or inactive level, go
> + * high-z or even continue to toggle.
> + *
> + * The unit for all three members is nanoseconds.
> + */
> +struct pwm_waveform {
> +	u64 period_length;
> +	u64 duty_length;
> +	u64 duty_offset;
> +};
> +
>   /*
>    * struct pwm_state - state of a PWM channel
>    * @period: PWM period (in nanoseconds)
> @@ -259,6 +283,17 @@ struct pwm_ops {
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

