Return-Path: <linux-pwm+bounces-5265-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F04AA6AD50
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 19:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8588A3973
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 18:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF15226D1C;
	Thu, 20 Mar 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUl4L619"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2581E8339;
	Thu, 20 Mar 2025 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496685; cv=none; b=SUOXmGHhtHo8DU4FyM8AkKmqvetZraCnK85C7OR7hsrVMwkQgQiumkcxfPxWrTSdDXehODCJVK8LPSimr/Z6OJQXNt37So5/aw5Cm+DKxs+PXrRXxakqtetOHPqyAVauBDfMRVLNnGdCeilV8/YaXHfpaqhAfWNVtWhaRraSGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496685; c=relaxed/simple;
	bh=LNK5ZuKqewXSGZxY17pDQuTqA2GLdapswMLlbaqtkJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz3A2rryqcD2kDSd0R0x0dDyxXZPEtRn8upwg5y2wTRt1YHGqIBL3sGgemnrMnbgvm+ot2eA1Idn+SwTYMy1uQt8NLgJAoOxPyv1zWot4us4FAADKVX+5/mX5L0QTT6ndEtsrGisjXcXGIV3fCExuqDpYHaeDIT120rVh9n4e9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUl4L619; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso6711755e9.0;
        Thu, 20 Mar 2025 11:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496681; x=1743101481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J/y0l6cjlflqIfSRDuuK0o0ZmJyO03ninpd8AjWAei4=;
        b=YUl4L619elQgcQQZ9laDajjwvDpaGYNzcKtJMOsvZaapBmd+PH/dWyC0Po4lOC3RAq
         120NX0Hy8+HqzuDUwaPK3A3YuNh9a3VoEaeZlocZUlcPN0A+X/FkGmoEO3eTfvyesmNB
         SAmDzFgVMJQAa8sBVWVuivGFZGLxEgdtmEdWQDzKNn6u3zyltZBE5+eouMk7SXpMgzQy
         nrl+S+ipWMUbuG5PnOKWP619GecL/mnJN61AxyPM9iHWBN6sI2x8XeAg17890y52Bjtm
         yJTxRqYz86GNrHnCJRrq/6HKENTyYp6RIN8D/thjPAXHAKrvN000+0WT5iucmezRV1x4
         EzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496681; x=1743101481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/y0l6cjlflqIfSRDuuK0o0ZmJyO03ninpd8AjWAei4=;
        b=OT/WI49Qd9/LCi8eLA3wtUVDnDn3ShjnrKC5qUANEwJv+vO6Lzq5YxqaDr0fjrvvUN
         dvGHD6sn+tt5pc8fn7PBjQQbhAej2yeSGWyulHbE9ihW0prjLEKF+Mz7pHApBzg3l8jZ
         liQfmcG+tef11bNmdYKImVB4txSIpbhIsactpbcKcW9kcfmrpID+sKjLIlcUOT+Cw919
         ofH/0DvjB141ITCtPsmCD2t8DK/nlp4GfneSw5ltcMdel2s63yrC0krBpMLsigHHfFJk
         Gy73l0jUYIbAbvGBUP16K2TT1z3RnFrFd8PBa0y3TjcFBPFsC7rCw/SIMi020hKoqqBu
         eT0A==
X-Forwarded-Encrypted: i=1; AJvYcCWvbZEjb5yoWJbRUPTba+zRlxqnYarohu/qsq1SScM6UCuHlH0FO6EWSkIS8pi60H8yD+WIRi70G6wk@vger.kernel.org, AJvYcCXC6Hp2KacZADJ5FwWNjZSiB3wji3+cqaeZUz4BPswP3K+kXx3FwysaE6ftdCqHHFvPg7xdXkmJcoi1@vger.kernel.org, AJvYcCXpRDTyx2oeoa190+Ww8EVpepMgJOMyWheyBtAPYEXV5ZGqG2xHcwuwSyifZ0guTd/kpuWaXK1BduPi6UBw@vger.kernel.org
X-Gm-Message-State: AOJu0YzqK0/NqlvA3Zv7kVdT9rGesPvFfSHhMebIvbLTlBEoUUPZCh1M
	CL7uYZTn19aRAKnBpfwbcNsM1vpUK9mFSUHbcV+7sh/XjaqrFRfV
X-Gm-Gg: ASbGncvK/+j4JI620qz1w+0fAkW/aGlUglUH7T2kMFzvrWHz1O03azVidnLGAMhZbg6
	NWkLLdWxdU9qSgoY+Z6apsQ2GnsfHl9tYVsuf3nOmkoZUiE8dAIee+cAjrHVRrveJ4tFgVvrNV/
	AXHgWqeULbd18rx+weAeSW8CIMt38Y4IuPkQM/kci7PpslaYw4Pu1xGTkv0G7khV4wDOXSfvlYJ
	7QVB/Ssy/THsyuE4l46Tj4oNt3TE0+onZQgMhm12B1h7dlDZiXNJ3N3MO3gWYb5cNo/7wZd7MOS
	coQl59IEzgtZtJMyQpdfz/zFOXbGdpG4FyKAPc+Qe/tI1Twh8tjgVw==
X-Google-Smtp-Source: AGHT+IE42Ioi8SWMo3tZzwnZBBbrbBT/f6C562nIPPqdgSGiL95d/A5gYDobQljSNZro9grRD5dG6w==
X-Received: by 2002:a05:6000:2cf:b0:38d:cf33:31d6 with SMTP id ffacd0b85a97d-3997f8f5a1cmr524106f8f.3.1742496680949;
        Thu, 20 Mar 2025 11:51:20 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:624:3d00:1ebe:eb51:3a97:3b47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a5b66sm324335f8f.40.2025.03.20.11.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:51:20 -0700 (PDT)
Date: Thu, 20 Mar 2025 19:51:18 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20250320185118.GA352940@legfed1>
References: <20250110073755.29541-1-dima.fedrau@gmail.com>
 <20250110073755.29541-3-dima.fedrau@gmail.com>
 <lzmsvwzidng7f6ybbfkusauohjya2rlyqrpprjc63y6pczo774@hklfplsgb3un>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lzmsvwzidng7f6ybbfkusauohjya2rlyqrpprjc63y6pczo774@hklfplsgb3un>

Hi Uwe,

Am Wed, Mar 19, 2025 at 04:37:43PM +0100 schrieb Uwe Kleine-König:

[...]

> > +#define MC33XS2410_PWM_CTRL1			0x05
> > +/* x in { 1 ... 4 } */
> 
> s/x/chan/
>
Will fix it.

> > +#define MC33XS2410_PWM_CTRL1_POL_INV(chan)	BIT((chan) + 1)
> > +
> > +#define MC33XS2410_PWM_CTRL3			0x07
> > +/* x in { 1 ... 4 } */
> > +#define MC33XS2410_PWM_CTRL3_EN(chan)		BIT(4 + (chan) - 1)
> > +
> > +/* x in { 1 ... 4 } */
> > +#define MC33XS2410_PWM_FREQ(chan)		(0x08 + (chan) - 1)
> > +#define MC33XS2410_PWM_FREQ_STEP		GENMASK(7, 6)
> > +#define MC33XS2410_PWM_FREQ_COUNT		GENMASK(5, 0)
> > +
> > +/* x in { 1 ... 4 } */
> > +#define MC33XS2410_PWM_DC(chan)			(0x0c + (chan) - 1)
> > +
> > +#define MC33XS2410_WDT				0x14
> > +
> > +#define MC33XS2410_PWM_MIN_PERIOD		488282
> > +/* x in { 0 ... 3 } */
> 
> s/x/step/
>
Will fix it.

[...]

> > +static u8 mc33xs2410_pwm_get_freq(u64 period)
> > +{
> > +	u8 step, count;
> > +
> > +	/*
> > +	 * Check which step is appropriate for the given period, starting with
> > +	 * the highest frequency(lowest period). Higher frequencies are
> > +	 * represented with better resolution by the device. Therefore favor
> > +	 * frequency range with the better resolution to minimize error
> > +	 * introduced by the frequency steps.
> 
> This is hard to understand as the argument is presented in several
> steps:
> 	algo starts with high step values (that's not in the comment,
> 		you have to take that from the switch statement)
> 	high step represents high freq = low period
> 	high freq yield better resolution
> 	better resolution is what is favoured.
> 
> After investing some time to reunderstand the rational here
> I suggest:
> 
> 	/*
> 	 * Check which step [0 .. 3] is appropriate for the given
> 	 * period. The period ranges for the different step values
> 	 * overlap. Prefer big step values as these allow more
> 	 * finegrained duty cycle selection.
> 	 */
> 
I think this is way better then before. But did you mean:
Prefer big step values as these allow more finegrained "periods" then
"duty cylces" ?

[...]

> > +
> > +	/*
> > +	 * steps:
> > +	 *   - 0 = 0.5Hz
> > +	 *   - 1 = 2Hz
> > +	 *   - 2 = 8Hz
> > +	 *   - 3 = 32Hz
> > +	 * frequency = (code + 1) x steps.
> > +	 *
> > +	 * To avoid losing precision in case steps value is zero, scale the
> > +	 * steps value for now by two and keep it in mind when calculating the
> > +	 * period that the frequency had been doubled.
> > +	 */
> > +	doubled_steps = 1 << (FIELD_GET(MC33XS2410_PWM_FREQ_STEP, reg) * 2);
> > +	code = FIELD_GET(MC33XS2410_PWM_FREQ_COUNT, reg);
> > +	freq = (code + 1) * doubled_steps;
> 
> doubled_freq?
> 
Will change to doubled_freq.

> > +	/* Convert frequency to period, considering the doubled frequency. */
> > +	return DIV_ROUND_UP(2 * NSEC_PER_SEC, freq);
> > +}
> > +
> > +static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				const struct pwm_state *state)
> > +{
> > +	struct spi_device *spi = pwmchip_get_drvdata(chip);
> > +	u8 reg[4] = {
> > +			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
> > +			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
> > +			MC33XS2410_PWM_CTRL1,
> > +			MC33XS2410_PWM_CTRL3
> > +		    };
> > +	u64 period, duty_cycle;
> > +	int ret, rel_dc;
> > +	u16 rd_val[2];
> > +	u8 wr_val[4];
> > +	u8 mask;
> > +
> > +	period = min(state->period, MC33XS2410_PWM_MAX_PERIOD(0));
> > +	if (period < MC33XS2410_PWM_MIN_PERIOD)
> > +		return -EINVAL;
> > +
> > +	ret = mc33xs2410_read_regs(spi, &reg[2], MC33XS2410_FRAME_IN_DATA_RD, rd_val, 2);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* frequency */
> > +	wr_val[0] = mc33xs2410_pwm_get_freq(period);
> > +	/* Continue calculations with the possibly truncated period */
> > +	period = mc33xs2410_pwm_get_period(wr_val[0]);
> > +
> > +	/* duty cycle */
> > +	duty_cycle = min(period, state->duty_cycle);
> > +	rel_dc = div64_u64(duty_cycle * 256, period) - 1;
> > +	if (rel_dc < 0)
> > +		wr_val[1] = 0;
> > +	else
> > +		wr_val[1] = rel_dc;
> > +
> > +	/* polarity */
> > +	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm + 1);
> > +	wr_val[2] = (state->polarity == PWM_POLARITY_INVERSED) ?
> > +		    (rd_val[0] | mask) : (rd_val[0] & ~mask);
> > +
> > +	/*
> > +	 * As the hardware cannot generate a 0% relative duty cycle but emits a
> > +	 * constant low signal when disabled, also disable in the duty_cycle = 0
> > +	 * case.
> > +	 */
> > +	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm + 1);
> > +	wr_val[3] = (state->enabled && rel_dc >= 0) ? (rd_val[1] | mask) :
> > +						      (rd_val[1] & ~mask);
> 
> This is wrong for inversed polarity I think.

Thanks for finding this. Yes, it is for the case when duty_cycle=0 and
polarity=PWM_POLARITY_INVERSED. The device should then output a constant
high signal. This could be done by:
enabled=1
duty_cycle=100%
polarity=normal

Just tested it, it works. What do you think ?

> 
> > +	return mc33xs2410_write_regs(spi, reg, wr_val, 4);
> > +}
> > +
> > [..]
> > +static int mc33xs2410_probe(struct spi_device *spi)
> > +{
> > +	struct device *dev = &spi->dev;
> > +	struct pwm_chip *chip;
> > +	int ret;
> > +
> > +	chip = devm_pwmchip_alloc(dev, 4, 0);
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +
> > +	spi->bits_per_word = 16;
> > +	spi->mode |= SPI_CS_WORD;
> > +	ret = spi_setup(spi);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	pwmchip_set_drvdata(chip, spi);
> > +	chip->ops = &mc33xs2410_pwm_ops;
> > +	ret = mc33xs2410_reset(dev);
> 
> What does this reset? Does it change the output signal if the bootloader
> already setup the hardware? The answer to that has to go into a comment.
> (And if it interupts the output, better skip the reset part.)
> 
If reset of the device is asserted on probe it deasserts the reset and
makes the device available. On the other hand if it is already setup by
the bootloader the reset will clear all registers to default values which
means that the output signal will change. The reset gpio is optional, so
the user can decide wether to use it or not. Both usecases are
supported. I will add an comment, but will keep the reset handling.

Best regards,
Dimitri Fedrau


