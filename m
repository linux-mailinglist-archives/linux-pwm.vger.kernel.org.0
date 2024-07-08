Return-Path: <linux-pwm+bounces-2731-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7CE92A8AD
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 20:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B68281B0E
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7BA14388F;
	Mon,  8 Jul 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pUoR+WbL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC03E26AC1
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462115; cv=none; b=uK+feDrz4c6GgefFjK193zrx9/bYP/zScDzIkTz6g+QX4oIVSe51TbulmLsYvI5oGBw5kQIxoKN3zNFGaI+YFuUevXCi1oUh5WmPaLUqiq2uNCDCxe43xlEi12XXYxPw3id6T5//DpVa4sVHyg9ZE0J0t804A+6yXSPUAmPe4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462115; c=relaxed/simple;
	bh=2vbhKFAO8Oq5p1ygQonwJTYPic6WmIEbRSxRnVcswR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkuXE8BzkAW3KaM4CRUTVIuBtdguaf27zfddllS18p59OA7zvQebTW7T4UGzOtwjadtu0l9dfQf/ITq75MvJIRnhzeSHrJUeu/ipcljxVItvWPBOjfqBtuOfMTjEbK1qqBbpn7PVeXsfiBAXBnmcncDgM8koE1t9YOLcP0SVFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pUoR+WbL; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b5f128b199so23017646d6.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720462111; x=1721066911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rVnJxc1tqgWcdZIzdsWGnl02Eqn6JG/k3Te0qhqkp9g=;
        b=pUoR+WbL/ultZmwKwIF80KV8j3OtHFOb0hjYymEeBepAweb68RFUTWAPkda8Pg2Jg2
         6XZH0JdP2Lf3YBYr9xWrra140FQMZWJNcEcum1HzVblzJ4WJAZHlrYUV+HNzeV8CMJD5
         bA8mO7AQximAvbe1OgwoZjz8jP0oFUJKqA/TfsiykzR2vzSRzH/Q4dhq0ghZmbOjhSDh
         N9N3VhSpAOAti4dVtp0Hcwx6GoshRskhL1GYIgAwgxvyMwpeeYQhnzTjBF7zebBasRN+
         U155/dMOKJKf1BWQR+oe8Rn3PauIvIINh/RE79NRvfEID0jclLWXLFJIz7guUUHOyk7e
         8tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462111; x=1721066911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVnJxc1tqgWcdZIzdsWGnl02Eqn6JG/k3Te0qhqkp9g=;
        b=Q0SWUHJjX/hJYWpRf7OvlJbzCahJrSrLTRGtULbXFpvXT8Pn01zbTMRFvPiQmi/l53
         kLawzrR2o5FNblTo3E4l5/9IwLeCm5rQ2hQLlHaLB6c9hDkVpMyWZbwZU7eL3dvbw9jw
         2/t9NhWZ0nVvYPEv4HQuizo3e+LQ4Wqg0yqPz2agh+H5Ph6jQnvRPIn29DcWQWw6Fh/6
         +iiLvfmvob00lNDPaKKdhyCy1iCgqqsIDSddaDGJQeEKA1jhTRDPyyt1HDzg0d1EHpoO
         +uLB3tlrAl19PBR29cZT42mXyJdYRJHiOoQwsEUcCZsbjMVjPnwJkWIebHWzvLxwie1u
         1pdg==
X-Forwarded-Encrypted: i=1; AJvYcCUTEEt5KfWhdrzIwPhNGAAVLtNzZT4tFQHZ7os06gnzq4RtcWRI+C3bVQsBsaoAjR+Aht62y3xHZzpfq9dQxdokjL5VKvKgMV3G
X-Gm-Message-State: AOJu0YxsrqT1w+BNgBZtbAitPtLE3r5kAv2mlTzLoE8sL64qc4IOqT6T
	viYm7HPzoXf+FdJ82bD3ZhZhcazhi+3RoHzz0ODNK6TfZmxNxAn8c6NUVSewwlUeSF+suLwM7dp
	p
X-Google-Smtp-Source: AGHT+IH3g6QR3pYMKYMQol6rkI9r0hRb+3Abohg7GFpOS25AD7muRVSWRBO2RXuxK6+bwtNGO4mghA==
X-Received: by 2002:a05:6214:2a83:b0:6b5:2838:efd7 with SMTP id 6a1803df08f44-6b61c1af515mr4866946d6.50.1720462110751;
        Mon, 08 Jul 2024 11:08:30 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4daasm1658346d6.18.2024.07.08.11.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 11:08:30 -0700 (PDT)
Message-ID: <a86fe0e0-5c41-4aa1-b93f-84a70a28cc5e@baylibre.com>
Date: Mon, 8 Jul 2024 14:08:29 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] pwm: axi-pwmgen: Implementation of the waveform
 callbacks
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
 <2c54a25eecc6f4745861568c49b98ca5b34a2f73.1720435656.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <2c54a25eecc6f4745861568c49b98ca5b34a2f73.1720435656.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-07-08 6:52 a.m., Uwe Kleine-König wrote:
> Convert the axi-pwmgen driver to use the new callbacks for hardware
> programming.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/pwm/pwm-axi-pwmgen.c | 148 ++++++++++++++++++++++++-----------
>   1 file changed, 102 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index aac4f395497b..757ae037d5d6 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -23,6 +23,7 @@
>   #include <linux/err.h>
>   #include <linux/fpga/adi-axi-common.h>
>   #include <linux/io.h>
> +#include <linux/minmax.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/pwm.h>
> @@ -53,81 +54,136 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
>   	.val_bits = 32,
>   };
>   
> -static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> -			    const struct pwm_state *state)
> +/* This represents a hardware configuration for one channel */
> +struct axi_pwmgen_waveform {
> +	u32 period_cnt;
> +	u32 duty_cycle_cnt;
> +	u32 duty_offset_cnt;
> +};
> +
> +static int axi_pwmgen_round_waveform_tohw(struct pwm_chip *chip,
> +					  struct pwm_device *pwm,
> +					  const struct pwm_waveform *wf,
> +					  void *_wfhw)
>   {
> +	struct axi_pwmgen_waveform *wfhw = _wfhw;
> +	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
> +
> +	if (wf->period_length == 0) {
> +		*wfhw = (struct axi_pwmgen_waveform){
> +			.period_cnt = 0,
> +			.duty_cycle_cnt = 0,
> +			.duty_offset_cnt = 0,
> +		};
> +	} else {
> +		/* With ddata->clk_rate_hz < NSEC_PER_SEC this won't overflow. */
> +		wfhw->period_cnt = min_t(u64, mul_u64_u32_div(wf->period_length, ddata->clk_rate_hz, NSEC_PER_SEC), U32_MAX);
> +
> +		if (wfhw->period_cnt == 0) {
> +			/*
> +			 * The specified period is too short for the hardware.
> +			 * Let's round .duty_cycle down to 0 to get a (somewhat)
> +			 * valid result.
> +			 */
> +			wfhw->period_cnt = 1;
> +			wfhw->duty_cycle_cnt = 0;
> +			wfhw->duty_offset_cnt = 0;
> +		} else {
> +			wfhw->duty_cycle_cnt = min_t(u64, mul_u64_u32_div(wf->duty_length, ddata->clk_rate_hz, NSEC_PER_SEC), U32_MAX);
> +			wfhw->duty_offset_cnt = min_t(u64, mul_u64_u32_div(wf->duty_offset, ddata->clk_rate_hz, NSEC_PER_SEC), U32_MAX);
> +		}
> +	}
> +
> +	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> PERIOD: %08x, DUTY: %08x, OFFSET: %08x\n",
> +		pwm->hwpwm, wf->duty_length, wf->period_length, wf->duty_offset,
> +                ddata->clk_rate_hz, wfhw->period_cnt, wfhw->duty_cycle_cnt, wfhw->duty_offset_cnt);
> +
> +	return 0;
> +}
> +
> +static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
> +					     const void *_wfhw, struct pwm_waveform *wf)
> +{
> +	const struct axi_pwmgen_waveform *wfhw = _wfhw;
> +	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
> +
> +	wf->period_length = DIV64_U64_ROUND_UP((u64)wfhw->period_cnt * NSEC_PER_SEC,
> +					ddata->clk_rate_hz);
> +
> +	wf->duty_length = DIV64_U64_ROUND_UP((u64)wfhw->duty_cycle_cnt * NSEC_PER_SEC,
> +					    ddata->clk_rate_hz);
> +
> +	wf->duty_offset = DIV64_U64_ROUND_UP((u64)wfhw->duty_offset_cnt * NSEC_PER_SEC,
> +					     ddata->clk_rate_hz);
> +
> +	return 0;
> +}
> +
> +static int axi_pwmgen_write_waveform(struct pwm_chip *chip,
> +				     struct pwm_device *pwm,
> +				     const void *_wfhw)
> +{
> +	const struct axi_pwmgen_waveform *wfhw = _wfhw;
>   	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
> -	unsigned int ch = pwm->hwpwm;
>   	struct regmap *regmap = ddata->regmap;
> -	u64 period_cnt, duty_cnt;
> +	unsigned int ch = pwm->hwpwm;
>   	int ret;
>   
> -	if (state->polarity != PWM_POLARITY_NORMAL)
> -		return -EINVAL;
> +	ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), wfhw->period_cnt);
> +	if (ret)
> +		return ret;
>   
> -	if (state->enabled) {
> -		period_cnt = mul_u64_u64_div_u64(state->period, ddata->clk_rate_hz, NSEC_PER_SEC);
> -		if (period_cnt > UINT_MAX)
> -			period_cnt = UINT_MAX;
> +	ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), wfhw->duty_cycle_cnt);
> +	if (ret)
> +		return ret;
>   
> -		if (period_cnt == 0)
> -			return -EINVAL;
> -
> -		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
> -		if (ret)
> -			return ret;
> -
> -		duty_cnt = mul_u64_u64_div_u64(state->duty_cycle, ddata->clk_rate_hz, NSEC_PER_SEC);
> -		if (duty_cnt > UINT_MAX)
> -			duty_cnt = UINT_MAX;
> -
> -		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
> -		if (ret)
> -			return ret;
> -	} else {
> -		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
> -		if (ret)
> -			return ret;
> -
> -		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = regmap_write(regmap, AXI_PWMGEN_CHX_OFFSET(ch), wfhw->duty_offset_cnt);
> +	if (ret)
> +		return ret;
>   
>   	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
>   }
>   
> -static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> -				struct pwm_state *state)
> +static int axi_pwmgen_read_waveform(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    void *_wfhw)
>   {
> +	struct axi_pwmgen_waveform *wfhw = _wfhw;
>   	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
>   	struct regmap *regmap = ddata->regmap;
>   	unsigned int ch = pwm->hwpwm;
> -	u32 cnt;
>   	int ret;
>   
> -	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
> +	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &wfhw->period_cnt);
>   	if (ret)
>   		return ret;
>   
> -	state->enabled = cnt != 0;
> -
> -	state->period = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
> -
> -	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
> +	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &wfhw->duty_cycle_cnt);
>   	if (ret)
>   		return ret;
>   
> -	state->duty_cycle = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
> +	ret = regmap_read(regmap, AXI_PWMGEN_CHX_OFFSET(ch), &wfhw->duty_offset_cnt);
> +	if (ret)
> +		return ret;
>   
> -	state->polarity = PWM_POLARITY_NORMAL;
> +	if (wfhw->duty_cycle_cnt > wfhw->period_cnt)
> +		wfhw->duty_cycle_cnt = wfhw->period_cnt;
> +
> +	/* XXX: is this the actual behaviour of the hardware? */
> +	if (wfhw->duty_offset_cnt >= wfhw->period_cnt) {
> +		wfhw->duty_cycle_cnt = 0;
> +		wfhw->duty_offset_cnt = 0;
> +	}
>   
>   	return 0;
>   }
>   
>   static const struct pwm_ops axi_pwmgen_pwm_ops = {
> -	.apply = axi_pwmgen_apply,
> -	.get_state = axi_pwmgen_get_state,
> +	.sizeof_wfhw = sizeof(struct axi_pwmgen_waveform),
> +	.round_waveform_tohw = axi_pwmgen_round_waveform_tohw,
> +	.round_waveform_fromhw = axi_pwmgen_round_waveform_fromhw,
> +	.read_waveform = axi_pwmgen_read_waveform,
> +	.write_waveform = axi_pwmgen_write_waveform,
>   };
>   
>   static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)

