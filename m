Return-Path: <linux-pwm+bounces-3344-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF0497EC45
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 15:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67971C20DD7
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 13:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9861993B2;
	Mon, 23 Sep 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fVS/NFvS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30A19885B
	for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098189; cv=none; b=WwAlaLssredgWMBOxsnwvLTCOo/9H1HbSR3+s8m1i4Shw142htCSj2KGTHX25Q0RXEpk4VqiBsLT1f0Z/OqYXmwSZIpq/YrLEXkyKvJds79kpeLl0ogx5TPdYyEXigF7Dk3J23VBfPYYgObB/Nl3EOewLKA5pvcBP4qiCmHfsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098189; c=relaxed/simple;
	bh=ZhnRmQP6Ni17rNustEbKVi8LgWarKuflxVPFT9zTcYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEig8Dv5Aq04yHkTYRSfRe0Liafa8CDSWP9jkMceWaZG1Qz7nivBrkNJmBxoE7wGSnauaus/aeKPLM1ZepUvLXaG/HXiRQz4lgbJ4c9j18qsGQmVXUx4tLPiX37KzfKenRTQcP7ZBVyc6xhN5Zl5rtEZzGEu+hj69xKkGiYMeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fVS/NFvS; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c3603292abso43308576d6.1
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727098185; x=1727702985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AetpStaPCTIs6IKh7B2qOUtHe0lTg/JxD+zmCPpQaMw=;
        b=fVS/NFvS4zMp9SUeQE7jCArdZm8igBVdrnMCOrAbej/+NTMF+9nYHJs7ZImFdLy9V2
         UBkW8T8BTQ418Cu+irvG0lYqJwNJg2GuuqBu+djmbzmXgF7ofVOWhO3A6VjSzlxVDorN
         /UrF3+LrDQBZHU1VESdxHh9qRFtXlE+lwDNdO6dh0pqF3ojDYaTmGAtfvHv/8vk0zw7s
         YqweRKYiok0s7+UExXkruEaGiFPZ2cr8Xmik4p7qVjrzbAWJJ7l2jOcEQbgKKtg02n0y
         nkvSbU3o1m7S7UGOi/GOvuzBoxJz9VHp004Ee5MiqGwAeZq90w1xbjWghPy2yDi82y6Z
         LWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098185; x=1727702985;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AetpStaPCTIs6IKh7B2qOUtHe0lTg/JxD+zmCPpQaMw=;
        b=BYp7rXClKK8WEZd6jBq6uiggKiFlhnWTFNceVyduZro3I9/cqHV+lwO9rDU+4NqJ2K
         B68poTOjGFHidt3kL5QeU7g8pRVc4EOf/bXXcnyJuIModnjr8DXaXClqK+jwz+CNVlR5
         O87/SNOc3lTxGFdVtUxEiJAFYPrP8VE4YCxqAL8Xrjp9hU8HB+Y1VNc731ZPkFXjqoS6
         dZetrrpm97MLB2J+tNM3O+OHssch//PjggjuyQCnTiwIOdwRAIeuycnodq3DZvcndcQV
         6NcTlxY7Ky6iYHCkG9F+0VjEfXBiUsh7MsxO+Y5EPh2v6/UkxSTLlZmatJFqchINuG62
         CpdA==
X-Forwarded-Encrypted: i=1; AJvYcCWB+sdhposxSb1IDEW6u01pHPYo8+5HUyAt0GGm+BcJloUtp/WCe0vZeiQE0KD9UWTujGkAwVEIkGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxO4d2liCLknqyO8oBceC4I9k5zZi63niFmrrGlU9+92q/wZQF
	Pi6lfYEj9EMV51NnoHtuzBym7V04RszArFx10xkAj2nGCTSxiV0QJB4JqR8UWqg=
X-Google-Smtp-Source: AGHT+IED7jr5e6H2/IXaveD5aH958y8fyp9CTmteY3dRJaCLIPvPoWnjGa3Bcv4KWq7NFlvNdVSIkw==
X-Received: by 2002:a05:6214:3199:b0:6c5:9888:ce23 with SMTP id 6a1803df08f44-6c7bc7db543mr183118426d6.36.1727098185142;
        Mon, 23 Sep 2024 06:29:45 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e588062sm47024616d6.146.2024.09.23.06.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 06:29:44 -0700 (PDT)
Message-ID: <343f4fa0-b30a-455a-b49a-f9083ccc1b8a@baylibre.com>
Date: Mon, 23 Sep 2024 09:29:43 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] pwm: Provide new consumer API functions for
 waveforms
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Kent Gibson <warthog618@gmail.com>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <6c97d27682853f603e18e9196043886dd671845d.1726819463.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <6c97d27682853f603e18e9196043886dd671845d.1726819463.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-09-20 04:57, Uwe Kleine-König wrote:
> Provide API functions for consumers to work with waveforms.
>
> Note that one relevant difference between pwm_get_state() and
> pwm_get_waveform*() is that the latter yields the actually configured
> hardware state, while the former yields the last state passed to
> pwm_apply*() and so doesn't account for hardware specific rounding.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/pwm/core.c  | 261 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pwm.h |   6 +-
>   2 files changed, 266 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index e3e26aafa461..1cefc6e9c10d 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -49,6 +49,30 @@ static void pwmchip_unlock(struct pwm_chip *chip)
>   
>   DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
>   
> +static bool pwm_wf_valid(const struct pwm_waveform *wf)
> +{
> +	/*
> +	 * For now restrict waveforms to period_length_ns <= S64_MAX to provide
> +	 * some space for future extensions. One possibility is to simplify
> +	 * representing waveforms with inverted polarity using negative values
> +	 * somehow.
> +	 */
> +	if (wf->period_length_ns > S64_MAX)
> +		return false;
> +
> +	if (wf->duty_length_ns > wf->period_length_ns)
> +		return false;
> +
> +	/*
> +	 * .duty_offset_ns is supposed to be smaller than .period_length_ns, apart
> +	 * from the corner case .duty_offset_ns == 0 && .period_length_ns == 0.
> +	 */
> +	if (wf->duty_offset_ns && wf->duty_offset_ns >= wf->period_length_ns)
> +		return false;
> +
> +	return true;
> +}
> +
>   static void pwm_wf2state(const struct pwm_waveform *wf, struct pwm_state *state)
>   {
>   	if (wf->period_length_ns) {
> @@ -95,6 +119,29 @@ static void pwm_state2wf(const struct pwm_state *state, struct pwm_waveform *wf)
>   	}
>   }
>   
> +static int pwmwfcmp(const struct pwm_waveform *a, const struct pwm_waveform *b)
> +{
> +	if (a->period_length_ns > b->period_length_ns)
> +		return 1;
> +
> +	if (a->period_length_ns < b->period_length_ns)
> +		return -1;
> +
> +	if (a->duty_length_ns > b->duty_length_ns)
> +		return 1;
> +
> +	if (a->duty_length_ns < b->duty_length_ns)
> +		return -1;
> +
> +	if (a->duty_offset_ns > b->duty_offset_ns)
> +		return 1;
> +
> +	if (a->duty_offset_ns < b->duty_offset_ns)
> +		return -1;
> +
> +	return 0;
> +}
> +
>   static int pwm_check_rounding(const struct pwm_waveform *wf,
>   			      const struct pwm_waveform *wf_rounded)
>   {
> @@ -145,6 +192,220 @@ static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, c
>   
>   #define WFHWSIZE 20
>   
> +/**
> + * pwm_round_waveform_might_sleep - Query hardware capabilities
> + * Cannot be used in atomic context.
> + * @pwm: PWM device
> + * @wf: waveform to round and output parameter
> + *
> + * Typically a given waveform cannot be implemented exactly by hardware, e.g.
> + * because hardware only supports coarse period resolution or no duty_offset.
> + * This function returns the actually implemented waveform if you pass wf to
> + * pwm_set_waveform_might_sleep now.
> + *
> + * Note however that the world doesn't stop turning when you call it, so when
> + * doing
> + *
> + * 	pwm_round_waveform_might_sleep(mypwm, &wf);
> + * 	pwm_set_waveform_might_sleep(mypwm, &wf, true);
> + *
> + * the latter might fail, e.g. because an input clock changed its rate between
> + * these two calls and the waveform determined by
> + * pwm_round_waveform_might_sleep() cannot be implemented any more.
> + *
> + * Returns 0 on success, 1 if there is no valid hardware configuration matching
> + * the input waveform under the PWM rounding rules or a negative errno.
> + */
> +int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf)
> +{
> +	struct pwm_chip *chip = pwm->chip;
> +	const struct pwm_ops *ops = chip->ops;
> +	struct pwm_waveform wf_req = *wf;
> +	char wfhw[WFHWSIZE];
> +	int ret_tohw, ret_fromhw;
> +
> +	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
> +
> +	if (!pwm_wf_valid(wf))
> +		return -EINVAL;
> +
> +	guard(pwmchip)(chip);
> +
> +	if (!chip->operational)
> +		return -ENODEV;
> +
> +	ret_tohw = __pwm_round_waveform_tohw(chip, pwm, wf, wfhw);
> +	if (ret_tohw < 0)
> +		return ret_tohw;
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ret_tohw > 1)
> +		dev_err(&chip->dev, "Unexpected return value from __pwm_round_waveform_tohw: requested %llu/%llu [+%llu], return value %d\n",
> +			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns, ret_tohw);
> +
> +	ret_fromhw = __pwm_round_waveform_fromhw(chip, pwm, wfhw, wf);
> +	if (ret_fromhw < 0)
> +		return ret_fromhw;
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ret_fromhw > 0)
> +		dev_err(&chip->dev, "Unexpected return value from __pwm_round_waveform_fromhw: requested %llu/%llu [+%llu], return value %d\n",
> +			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns, ret_tohw);
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) &&
> +	    ret_tohw == 0 && pwm_check_rounding(&wf_req, wf))
> +		dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
> +			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns,
> +			wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
> +
> +	return ret_tohw;
> +}
> +EXPORT_SYMBOL_GPL(pwm_round_waveform_might_sleep);
> +
> +/**
> + * pwm_get_waveform_might_sleep - Query hardware about current configuration
> + * Cannot be used in atomic context.
> + * @pwm: PWM device
> + * @wf: output parameter
> + *
> + * Stores the current configuration of the PWM in @wf. Note this is the
> + * equivalent of pwm_get_state_hw() (and not pwm_get_state()) for pwm_waveform.
> + */
> +int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf)
> +{
> +	struct pwm_chip *chip = pwm->chip;
> +	const struct pwm_ops *ops = chip->ops;
> +	char wfhw[WFHWSIZE];
> +	int err;
> +
> +	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
> +
> +	guard(pwmchip)(chip);
> +
> +	if (!chip->operational)
> +		return -ENODEV;
> +
> +	err = __pwm_read_waveform(chip, pwm, &wfhw);
> +	if (err)
> +		return err;
> +
> +	return __pwm_round_waveform_fromhw(chip, pwm, &wfhw, wf);
> +}
> +EXPORT_SYMBOL_GPL(pwm_get_waveform_might_sleep);
> +
> +/* Called with the pwmchip lock held */
> +static int __pwm_set_waveform(struct pwm_device *pwm,
> +			      const struct pwm_waveform *wf,
> +			      bool exact)
> +{
> +	struct pwm_chip *chip = pwm->chip;
> +	const struct pwm_ops *ops = chip->ops;
> +	char wfhw[WFHWSIZE];
> +	struct pwm_waveform wf_rounded;
> +	int err;
> +
> +	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
> +
> +	if (!pwm_wf_valid(wf))
> +		return -EINVAL;
> +
> +	err = __pwm_round_waveform_tohw(chip, pwm, wf, &wfhw);
> +	if (err)
> +		return err;
> +
> +	if ((IS_ENABLED(CONFIG_PWM_DEBUG) || exact) && wf->period_length_ns) {
> +		err = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
> +		if (err)
> +			return err;
> +
> +		if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm_check_rounding(wf, &wf_rounded))
> +			dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
> +				wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
> +				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns);
> +
> +		if (exact && pwmwfcmp(wf, &wf_rounded)) {
> +			dev_dbg(&chip->dev, "Requested no rounding, but %llu/%llu [+%llu] -> %llu/%llu [+%llu]\n",
> +				wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
> +				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns);
> +
> +			return 1;
> +		}
> +	}
> +
> +	err = __pwm_write_waveform(chip, pwm, &wfhw);
> +	if (err)
> +		return err;
> +
> +	/* update .state */
> +	pwm_wf2state(wf, &pwm->state);
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ops->read_waveform && wf->period_length_ns) {
> +		struct pwm_waveform wf_set;
> +
> +		err = __pwm_read_waveform(chip, pwm, &wfhw);
> +		if (err)
> +			/* maybe ignore? */
> +			return err;
> +
> +		err = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_set);
> +		if (err)
> +			/* maybe ignore? */
> +			return err;
> +
> +		if (pwmwfcmp(&wf_set, &wf_rounded) != 0)
> +			dev_err(&chip->dev,
> +				"Unexpected setting: requested %llu/%llu [+%llu], expected %llu/%llu [+%llu], set %llu/%llu [+%llu]\n",
> +				wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
> +				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns,
> +				wf_set.duty_length_ns, wf_set.period_length_ns, wf_set.duty_offset_ns);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * pwm_set_waveform_might_sleep - Apply a new waveform
> + * Cannot be used in atomic context.
> + * @pwm: PWM device
> + * @wf: The waveform to apply
> + * @exact: If true no rounding is allowed
> + *
> + * Typically a requested waveform cannot be implemented exactly, e.g. because
> + * you requested .period_length_ns = 100 ns, but the hardware can only set
> + * periods that are a multiple of 8.5 ns. With that hardware passing exact =
> + * true results in pwm_set_waveform_might_sleep() failing and returning 1. If
> + * exact = false you get a period of 93.5 ns (i.e. the biggest period not bigger
> + * than the requested value).
> + * Note that even with exact = true, some rounding by less than 1 is
> + * possible/needed. In the above example requesting .period_length_ns = 94 and
> + * exact = true, you get the hardware configured with period = 93.5 ns.
> + */
> +int pwm_set_waveform_might_sleep(struct pwm_device *pwm,
> +				 const struct pwm_waveform *wf, bool exact)
> +{
> +	struct pwm_chip *chip = pwm->chip;
> +	int err;
> +
> +	might_sleep();
> +
> +	guard(pwmchip)(chip);
> +
> +	if (!chip->operational)
> +		return -ENODEV;
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
> +		/*
> +		 * Catch any drivers that have been marked as atomic but
> +		 * that will sleep anyway.
> +		 */
> +		non_block_start();
> +		err = __pwm_set_waveform(pwm, wf, exact);
> +		non_block_end();
> +	} else {
> +		err = __pwm_set_waveform(pwm, wf, exact);
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(pwm_set_waveform_might_sleep);
> +
>   static void pwm_apply_debug(struct pwm_device *pwm,
>   			    const struct pwm_state *state)
>   {
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index d8cfe1c9b19d..c3d9ddeafa65 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -358,7 +358,11 @@ static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
>   }
>   
>   #if IS_ENABLED(CONFIG_PWM)
> -/* PWM user APIs */
> +
> +/* PWM consumer APIs */
> +int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
> +int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
> +int pwm_set_waveform_might_sleep(struct pwm_device *pwm, const struct pwm_waveform *wf, bool exact);
>   int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
>   int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
>   int pwm_adjust_config(struct pwm_device *pwm);

