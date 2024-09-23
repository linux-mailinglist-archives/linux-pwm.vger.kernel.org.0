Return-Path: <linux-pwm+bounces-3343-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF52897EC44
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 15:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D58B2174C
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333411993B2;
	Mon, 23 Sep 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="06z6kjcb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029119885B
	for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098179; cv=none; b=bmKCkczQSYpVKH1fv+kpwZYgbbq0q8yuuY+pJ35UL1Cqnz5+p7XNNiK1XaCHLnIdQz/7Cm0wQCyhX1E76Whg6f70S6p+4gbSbRm9J/DZPw/l/pbjOC0JoX1OdmXGJyW2JqLie9iev+SkTYcx8C0pyb1gfodSvX2M+tOcmwR0egk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098179; c=relaxed/simple;
	bh=PIlI0UmNRrYKGc5KbDiPJBWc794VCGV5arLLwmFKVEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC8uHFFRhAy/edUGPPP9hna6GuV4U3CFM/vxYfO4dAifcYbs9ez1ZNnh0csHsHELgAY4d34wWzH/7Y24aqbY+OaAYJbaEkfxctuT94qZX+p+0WzsJN6/jpjRkoW+m/C3tmm3adALwIVMnksgruOPw/P/bXWNr79ixUSmaCXCOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=06z6kjcb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9a23fc16fso487654185a.2
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727098175; x=1727702975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgZ9ZtUhT91YBlCk1Zw2BNWkJD3AqzMMo+b8z6k21Oc=;
        b=06z6kjcbThQa2vglN9jBv8HeYNxG++bXebXCMBvV3ZjTHO4NAVrQjE5HD/V8Uj3MBT
         EdW+JxAI3Q1cJzZ+uNmJtKI5ZlsNsFdFY2ATgAXuIZtOvFEW56G1v/WqXIfvVTc1zd7v
         BDWXM3+OYlhfSK+TzQQ2rayCaOV7i8KrvHfRXP7XUI5RS5gkUChzO+mgJQEtHGRbJKoV
         k3YRyWL04bFCpzcT4aQe5jDpl+EFITRURxCGnplRo+b/eKY9qYrUpPRX+h6YiPh+S6yH
         PBB+eJqBwVipO8DxOHC62wQvZKWSSYyo2KwyO4DF8rYOWno0bQ4RRrwU7GfspkPwKa1M
         hkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098175; x=1727702975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgZ9ZtUhT91YBlCk1Zw2BNWkJD3AqzMMo+b8z6k21Oc=;
        b=TTE61c/wD0bgaGmHOUsUv2Z/KLSIf5n8yQ8O0p5M1XKFlUGNKlFf/7oedrWj1BP/BA
         WTnLkWmkEhdQr66Koy5XLrFsHUDK12TkVDWG8Cgh9vu4iiCzdbOmZAwsMRKmhaT8X4lY
         aZ+VFS+W/owXhGNAdxdIgPbyWDmHpdztPjok5fPJyIs5+edmFudZpAtD1yWV10dIN7xs
         qmD5j1sFpEJk2/+MHCSInD+PRaB6avSV4WBvq21qH7DbU2TLUV8uKqqomuzT+DLmMio/
         kIo4hhrGMGAG/GSFDHAMwtygKPE2TpIIkiEavFI8oYCsCB2IeK+Z5AcKLFbkaO4CZPzb
         2LJg==
X-Forwarded-Encrypted: i=1; AJvYcCUmDsHc6YX/Uijea0Bg7yft9YbuwXy2GZHwE7UsVV/MgUOl+REhAq8ygBnS2xJM709NBLPFFUsAaTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+Za76H2TJZdAxHPnsY7abcIEjpPQby34zkHX/IblBhbO+zjN
	9WRrn9jcnFwI4oZBRGdqtTnIeNC4zTa4fKZiCjroSF9UlmGvCIyrKr/rRDKnIks=
X-Google-Smtp-Source: AGHT+IGSs4yyzZboQPx53Vcqd7vRFsbt3fP/n9w6h+ttcSlzHQCJ6DKMZp03H/AhF8BVd/kU6aNIfA==
X-Received: by 2002:a05:620a:298e:b0:7a9:c146:a9e9 with SMTP id af79cd13be357-7acb80b5070mr1952426685a.15.1727098174541;
        Mon, 23 Sep 2024 06:29:34 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08eb9ffsm483673285a.128.2024.09.23.06.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 06:29:34 -0700 (PDT)
Message-ID: <d92554f5-e285-4653-af42-781a5ff20058@baylibre.com>
Date: Mon, 23 Sep 2024 09:29:33 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] pwm: New abstraction for PWM waveforms
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Kent Gibson <warthog618@gmail.com>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <df0faa33bf9e7c9e2e5eab8d31bbf61e861bd401.1726819463.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <df0faa33bf9e7c9e2e5eab8d31bbf61e861bd401.1726819463.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-09-20 04:57, Uwe Kleine-König wrote:
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
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/pwm/core.c  | 234 ++++++++++++++++++++++++++++++++++++++++----
>   include/linux/pwm.h |  36 +++++++
>   2 files changed, 249 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 5a095eb46b54..e3e26aafa461 100644
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
> +		 * implementations of .get_state() depend on this
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
> @@ -435,7 +619,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>   		}
>   	}
>   
> -	if (ops->get_state) {
> +	if (ops->read_waveform || ops->get_state) {
>   		/*
>   		 * Zero-initialize state because most drivers are unaware of
>   		 * .usage_power. The other members of state are supposed to be
> @@ -445,11 +629,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
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
> @@ -1136,12 +1316,24 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
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
> index 3ea73e075abe..d8cfe1c9b19d 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -49,6 +49,31 @@ enum {
>   	PWMF_EXPORTED = 1,
>   };
>   
> +/**
> + * struct pwm_waveform - description of a PWM waveform
> + * @period_length_ns: PWM period
> + * @duty_length_ns: PWM duty cycle
> + * @duty_offset_ns: offset of the rising edge from the period's start
> + *
> + * This is a representation of a PWM waveform alternative to struct pwm_state
> + * below. It's more expressive than struct pwm_state as it contains a
> + * duty_offset_ns and so can represent offsets other than zero (with .polarity =
> + * PWM_POLARITY_NORMAL) and period - duty_cycle (.polarity =
> + * PWM_POLARITY_INVERSED).
> + *
> + * Note there is no explicit bool for enabled. A "disabled" PWM is represented
> + * by .period_length_ns = 0. Note further that the behaviour of a "disabled" PWM
> + * is undefined. Depending on the hardware's capabilities it might drive the
> + * active or inactive level, go high-z or even continue to toggle.
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

