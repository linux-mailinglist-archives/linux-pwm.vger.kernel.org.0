Return-Path: <linux-pwm+bounces-3137-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D6696FA12
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 19:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECBC284D05
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 17:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEA91D6C42;
	Fri,  6 Sep 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UzS/qHh1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBCF7F477
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644672; cv=none; b=paSOjX7Gqvz2eWtGCz63icQaT2RLG5ZfGD1TDIkAMO0BXSRHlUDz50TgXY4ETEvZ2FthCpCJIjNVPq29IvWLspGnrkmx5vbmk6hqHldTv3EnuruwHoNOtWrbf1OVrGutsWTe/828+3hoVHf8fD4rA8A3g8ReWWYsDkylIDQyDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644672; c=relaxed/simple;
	bh=PN8ZLb9Tp3bXSRF4ZxFj3TE93zPs9t236TbRbzKYgMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohd3KeD8m9pyz0XxyVV0qSGsNA3uUkKd3P1JGcSfL+w7+uoECBo0fE1/stgvizLrG5L+K/NrB6uMP+j96wTugtTbClkdOXp6AA4vO7tBLE9DB9zBTIInHuygtdSrUPUOkxuepfIgT0Pz079jR/9xVOl1qkVoRU89cDs8rV5WSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UzS/qHh1; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-846c588fa63so632176241.1
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725644668; x=1726249468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aESFdYY00NXS6lFAdHujLBcrfXXKBZ792L0tv1/Etdc=;
        b=UzS/qHh1AqQxEz1e81bqHsxTie3vlnzNTlK+kNc8OWX2RVCDBJNRl4RCkxvVnRS5qQ
         K1cRs0sZ3VLLF5xYzNYpEfTbEUS9fm9WdTodaPrsWte7kEyuJAeuPck2a/z4HN+wjRao
         rX2/iw40Xuof+z5VAqMPGyFIXjrzUkKJT2EbGAeVxPIlx0B6SeRAdec01v/+Dv8bU6DH
         1Gr2Y3n7zul24irs1sqbR02zftA7/rhtNfkQUu7lwcufhlh64dpmkeiTeQQ3ZzVNHpCp
         cC9KPMwou1kklYVaUppJ9FbiREmmuq+4/74kx7jTqqU7qhx110QYY7L2OOqaV8+9a3va
         NUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725644668; x=1726249468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aESFdYY00NXS6lFAdHujLBcrfXXKBZ792L0tv1/Etdc=;
        b=VizzayniERXG8PNlUVwi6/3Kdh15tjcIzz/eWGXV9iGcypePwbQfo6s2uxTq0qbnd4
         RUZhqoRyoa/QieLoiLQSKv9CToCm6Lwjw0BtOYVe4oNGcSyfJSVCvupLKWpL3+2Y0ew6
         xYa2SBVkBvH8PL+IFBRHUMcSzRKWSCPW2SliH2Gl6xT+Ny42UfrIGSHPVHlYzs0y5LDp
         4qngi3seU1Aw1qnfwFwzpgn8dbDnRtJmYEcSInmMhdaO6lqIlr8KhhgbmDi2vsTBZrn0
         neqrMPyF7IiRmK/xP9IDs93lmAlzrPDc3Rl/vhjkq/+8zjKwYk8kmtY6OkVH3WiX0Uki
         hLFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSZjvImI5tNCdtx8by9KEUKywOAVJw6cpyvXjPP/T6R+EljF/CMA+R8RdA3SapR/Y/BQqTZpA9Sbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOc8+ShGxbZNzy5lMcVdm4N/SU+bPNepkUNCOLWxqkTFUQJ29O
	eSTOMVjz4OshuQUHDtgqYZN7UVO7Rgiev//6jDSLnNaAF6h6LLKHC/Yf1jngPw8=
X-Google-Smtp-Source: AGHT+IFlY1bjBTuxOKnE6PpL7ksbf6Jfj4KGa2c/n66YgTfSwnenp5gzBrB7uk3VNxUXeQHK5f+wzw==
X-Received: by 2002:a05:6122:1796:b0:4f3:828:7a47 with SMTP id 71dfb90a1353d-50207c6ad67mr3944062e0c.6.1725644667807;
        Fri, 06 Sep 2024 10:44:27 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4581add3a5esm3050601cf.74.2024.09.06.10.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 10:44:27 -0700 (PDT)
Message-ID: <9dfb0978-1a68-4199-bb77-0fe565cea8b9@baylibre.com>
Date: Fri, 6 Sep 2024 13:44:25 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] pwm: axi-pwmgen: Implementation of the waveform
 callbacks
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Kent Gibson <warthog618@gmail.com>, David Lechner <dlechner@baylibre.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <3b0a91f10da46caf5ef24b943b3cf6f056b9776c.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <3b0a91f10da46caf5ef24b943b3cf6f056b9776c.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-09-06 11:43, Uwe Kleine-König wrote:
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
> index 3ad60edf20a5..14c3274b551b 100644
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
> @@ -54,81 +55,142 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
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

