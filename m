Return-Path: <linux-pwm+bounces-3345-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDD697EC46
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 15:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773471F20FBB
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEEF199384;
	Mon, 23 Sep 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oV3ViCol"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59819885B
	for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098199; cv=none; b=Ty15y+iWZrVKj9x5CvtBZvV4Fg/Vo4tOvHnp59rwhSLl/5b50cnU3olMjQD8HSxTbYQE1pnZKwZXcPiG3QMqXRhwFHMFhbF1BT1P2GyAS/KaBPzQxZpiayzzJ0hpWynoYHy11VWr5nD3Ygvyay51jI/dCPgd/BioMyPU/v1pS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098199; c=relaxed/simple;
	bh=8bFF4zc2yPmEppw+5wTwY9/VdAyqs0yHY6WnNmgq0sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fhlfnq6efDbcJGXQxcDatVhp93fbkisKOuC/mHo240/2Q559OQvmh++vGNLQ73LXbsPWqvm7xpZC+EcL6qgvVuV1e9TsiACRn2ILNcI+2vNlOSca/Qm2UEWIF1Vyvouh8W2FEbL8Gm3J6u83+1IyD/jsMMY7HIxuPmJriYl1yU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oV3ViCol; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7acb0499ffeso423387885a.1
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727098196; x=1727702996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ru4Z00N0tL+nu0poTAheEU+UV+Qlt8Lij9wI0aftecU=;
        b=oV3ViColSp0QCNShNZRaiuu7jkBpOGYy4mcJETDJzCCMTmHfyqhcyr3tKR9y6x48+d
         r3tiNgzVgB6kFPzUB5CL8D2pg8F5NAgFGjIiej+kR1zWWmxpoAHOb37yQMIxuS+sNe4C
         gW+XMOiqaFd9MreAM3iLeFSBZPlMa5poyr1M8oYqPS6/s/6Ww/rKPwZMF5KZAekC1IL6
         jdqdISFo+y/u44sOX3ihfjlLukee+Ctvtg/yeIjbUUkR5wGOH1OACv5A99BnW/DauXyp
         VlCOx5Ur0RhgNGzpH6tIu3rGqN6ngXeSglwtLN2OeQwTsC9ym+JCGsiOM+fsfSbSMp3s
         3mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098196; x=1727702996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru4Z00N0tL+nu0poTAheEU+UV+Qlt8Lij9wI0aftecU=;
        b=Ni76L4XgusngwCw2jorBNIUP658SkGa0BOFR2VUQbV2MISs4N/VBRUr3P7WsgKTyrL
         kSR1DP0bgiknF9tEsKbz1QLpeCYVlOVDxMIm8HAehA48ZrpB/Xix1+sdqjOmfln5bDHg
         ynBa86ya23hE76uymkomu9WBNraQqVKDrRCpiXnIK5sOj4wB2IFcpqTZ+1ao29wijU1+
         rWOh+qNjRBEFiEp7ZMR9yyvTjRUN68k588LOKmhRRBtb5addPPKgA6MOqkiZZzdLcIgD
         YE/3vGcvyShiesUb3DU/Vm0BOVEGVnVA/Oa3Y7rdOAn4rib/6P/wLntw5OWdgbXCv1uC
         Fw+A==
X-Forwarded-Encrypted: i=1; AJvYcCVVHlDEaTZodk/njsTN6NwUbo4bEsIBaUxzeolvJcBvVWNGz1uJQdACI2Gx0ZM9d9QOmYJk5KcCp8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLGKJeMowx2E5NLTNLo0fsqb6xh8OyuwGnhYXAWOjc8nzf4bY
	unINEFO3mPTPKfD8OchWCmxOy1+n/5cYYc2BrsPAi8eiN9MoicC+5lmCOQlmLJ4=
X-Google-Smtp-Source: AGHT+IFWZvfqc6XF+IanAjnL1Ax78O3V/gAHxkSsY6ba6uOMK/6Tqb9w7NzTPcY9JbkPk17/9y6AMQ==
X-Received: by 2002:a05:620a:298e:b0:7ac:a93b:9fa6 with SMTP id af79cd13be357-7acb8d99333mr1779029885a.30.1727098195635;
        Mon, 23 Sep 2024 06:29:55 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08da805sm484227985a.116.2024.09.23.06.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 06:29:55 -0700 (PDT)
Message-ID: <837e623d-029b-4232-962c-6fb0ba75ca95@baylibre.com>
Date: Mon, 23 Sep 2024 09:29:54 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] pwm: axi-pwmgen: Implementation of the waveform
 callbacks
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Kent Gibson
 <warthog618@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <922277f07b1d1fb9c9cd915b1ec3fdeec888a916.1726819463.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <922277f07b1d1fb9c9cd915b1ec3fdeec888a916.1726819463.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-09-20 04:58, Uwe Kleine-König wrote:
> Convert the axi-pwmgen driver to use the new callbacks for hardware
> programming.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/pwm/pwm-axi-pwmgen.c | 154 ++++++++++++++++++++++++-----------
>   1 file changed, 108 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index b5477659ba18..39d184417c7c 100644
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
> @@ -53,81 +54,142 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
>   	.max_register = 0xFC,
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
> +	if (wf->period_length_ns == 0) {
> +		*wfhw = (struct axi_pwmgen_waveform){
> +			.period_cnt = 0,
> +			.duty_cycle_cnt = 0,
> +			.duty_offset_cnt = 0,
> +		};
> +	} else {
> +		/* With ddata->clk_rate_hz < NSEC_PER_SEC this won't overflow. */
> +		wfhw->period_cnt = min_t(u64,
> +					 mul_u64_u32_div(wf->period_length_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
> +					 U32_MAX);
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
> +			wfhw->duty_cycle_cnt = min_t(u64,
> +						     mul_u64_u32_div(wf->duty_length_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
> +						     U32_MAX);
> +			wfhw->duty_offset_cnt = min_t(u64,
> +						      mul_u64_u32_div(wf->duty_offset_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
> +						      U32_MAX);
> +		}
> +	}
> +
> +	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] @%lu -> PERIOD: %08x, DUTY: %08x, OFFSET: %08x\n",
> +		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
> +		ddata->clk_rate_hz, wfhw->period_cnt, wfhw->duty_cycle_cnt, wfhw->duty_offset_cnt);
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
> +	wf->period_length_ns = DIV64_U64_ROUND_UP((u64)wfhw->period_cnt * NSEC_PER_SEC,
> +					ddata->clk_rate_hz);
> +
> +	wf->duty_length_ns = DIV64_U64_ROUND_UP((u64)wfhw->duty_cycle_cnt * NSEC_PER_SEC,
> +					    ddata->clk_rate_hz);
> +
> +	wf->duty_offset_ns = DIV64_U64_ROUND_UP((u64)wfhw->duty_offset_cnt * NSEC_PER_SEC,
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

