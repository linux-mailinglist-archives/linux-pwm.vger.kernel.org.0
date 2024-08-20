Return-Path: <linux-pwm+bounces-3050-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349F958AB7
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800211F24BCC
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B30318E361;
	Tue, 20 Aug 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zo8keidg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3117C8F48
	for <linux-pwm@vger.kernel.org>; Tue, 20 Aug 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166407; cv=none; b=P5BNm1h+Uxm4H5JqT7VXuSylbp/XNL0qBKUhRPHiwWPu/p2gHkCWSDk7ONDlrG/B4085lGYPi7ZCFratOhoMCSx0B+uJlblajsNoEV5jbxlV54/+ebpdd09dra6mDxXLg+nnJzc2fj56bDRjhose9k7/uzjl69pNsRpGwh1OF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166407; c=relaxed/simple;
	bh=Mcpd4gN6/2e2zexyItdzQ04Xrj7xOrPCVE2OMlckeAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Up2zJIrGEDxo1Ce7mEONkLBOfdO2aPPqk6DQnHYqD7A4TA7SI8smx2Jy04m9s1+J3XbVulYmi8Jklp9jCzduXfKBropikssp70+TXCdZgBWHT05UB39kUDUgMclTD+AajNCU0Oig9HR1HTLi+PZXpNe4FHUDxsyZ5QWG9yXdte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zo8keidg; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf747371ecso23666196d6.3
        for <linux-pwm@vger.kernel.org>; Tue, 20 Aug 2024 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724166403; x=1724771203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9zynFSarmpMIk8IBhGM1MAoOHM8MSDknYVCHLy30uw=;
        b=zo8keidgIH8ylnLKE+8IGeXi6Jhn0MQBtVGnRCWgZYhQC7WdEZzDxrngp92It54v+T
         OHlgJQJl+e2x7jUTsy+BUG3tJfoosgVvDnJ80j/nbJ80I6UOyrNd0W/hr1IVHugMRFwS
         J5tjwEGDS2v1DBufzuFAFH4z09BH30Mfd1OpRu91ypX671VUrvS6ZUk3r43XhIlDgSzD
         rBSs2xoZTleTRfaaQXrnME9/+ClXEd63qJUMLbMKm+oavtvbBxKTrWmKUoMOTX/nUpE8
         o5RuIzSb8q+D9ERseuci0GLTMJydT7yd8CdPfTwVVRMDed8zwqUI175ERydJVfBva3i6
         +v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724166403; x=1724771203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9zynFSarmpMIk8IBhGM1MAoOHM8MSDknYVCHLy30uw=;
        b=a3nvMHE/TGJjO+x9VS0qz7YtsdEBNJOSTisW4CaOwP/vqAVOsi/x5fwAsnoqwIa546
         e0n/tc3ZPw2t1TFnEobC3J56y/QcDh1dv0/mWQ/GC1kskQ0h7A3jY/avE1wmTYMdTS96
         9N3cSC1ZYasbRETiEiQ9akNciQ+pdtmE6A/LZXiqsqL5lYVURlEfoID3R8w3cmeas4wj
         nInzE8dKkGNG/F37/w6hlvDT6i2tfkFTE1jj4EaLt8HbXK+iGnaOcYsFuJNPQkQ6nTJI
         9ZD1ekNRgBAWMkdmfPnFlAmpEFNv/M/gbngsvn5MrnDt8A1vcKbRQLxK6nY5r5LsQMXf
         Ef5g==
X-Forwarded-Encrypted: i=1; AJvYcCWRpAxsyMo/HlNIyW8yb8IU9ngoAwoXR4bMdk2dudj36eUVUa0g1ai42vKh2Qfj5qPOx2cG2azBiGp6n9aDs53aK6Cb2a+A+PVx
X-Gm-Message-State: AOJu0YygKxMnCQdH/wgre9H38BHfqnR8ElKNqcWaDrmWA0f8nmwPsJjo
	kAqs1iD/M0fdX29R6nYsunXvXvBlpM27s1TON8FLCStSaFeZWyKLujlLQRNiJywzOHCHBoafRa6
	u3sI=
X-Google-Smtp-Source: AGHT+IHwtac0bft0mAOTDY+vkcxIjzam4rWZI3vWDp9YQ+S7k54+dqZ+TbAIVCCWLZy8lBkIullksw==
X-Received: by 2002:a05:6214:459c:b0:6b5:da10:4edf with SMTP id 6a1803df08f44-6bf7cd99672mr197160806d6.13.1724166402451;
        Tue, 20 Aug 2024 08:06:42 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6feed2a9sm52913336d6.111.2024.08.20.08.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 08:06:42 -0700 (PDT)
Message-ID: <4230e4ba-d8d2-4f53-9d1d-4a4325c72c8c@baylibre.com>
Date: Tue, 20 Aug 2024 11:06:41 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] pwm: Provide new consumer API functions for
 waveforms
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
 <015a5fbd5cf449bcb2d8fdf2305d7b6bf7109844.1722261050.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <015a5fbd5cf449bcb2d8fdf2305d7b6bf7109844.1722261050.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-07-29 10:34 a.m., Uwe Kleine-König wrote:
> Provide API functions for consumers to work with waveforms.
>
> Note that one relevant difference between pwm_get_state() and
> pwm_get_waveform*() is that the latter yields the actually configured
> hardware state, while the former yields the last state passed to
> pwm_apply*() and so doesn't account for hardware specific rounding.

Hi,

kernel test robot caught an issue with a pwm function while testing my 
iio driver: 
https://lore.kernel.org/linux-iio/20240819-ad7625_r1-v3-0-75d5217c76b5@baylibre.com/T/#m7b3118821c416240e0309a8c2bbc5c51ba4b0823

Looks like an issue with static inline versions of the consumer 
functions not being present after the #else in pwm.h?

>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>   drivers/pwm/core.c  | 201 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pwm.h |   6 +-
>   2 files changed, 206 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index a8a0c12fef83..41e620944375 100644
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
> +	 * from the corner case .duty_offset_ns = 0 + .period_length_ns = 0.
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
> @@ -145,6 +192,160 @@ static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, c
>   
>   #define WFHWSIZE 20
>   
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
> +	ret_fromhw = __pwm_round_waveform_fromhw(chip, pwm, wfhw, wf);
> +	if (ret_fromhw < 0)
> +		return ret_fromhw;
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) &&
> +	    ret_tohw == 0 && pwm_check_rounding(&wf_req, wf))
> +		dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
> +			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns,
> +			wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
> +
> +	return ret_tohw;
> +}
> +
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
> index 6a26a5210dab..40cef0bc0de7 100644
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

