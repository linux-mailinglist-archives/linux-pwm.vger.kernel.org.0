Return-Path: <linux-pwm+bounces-3773-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED829ACA95
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 14:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A601B22FAA
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E171ABEA9;
	Wed, 23 Oct 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyIFK84N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263DC130AF6;
	Wed, 23 Oct 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687950; cv=none; b=CHGRNF/QaNbol/ugao74estxv2QzgFUP3FCE6WOih6XxYmmho7puqXK4dAiApD6FPRPnPwIHuzoI4XkbZt6wSjlWixOlWXqw1TNvXr+vNsr0/Y3nZUZPHJspeojSRAFfOI9pMrcG3LXS240RxO6747ww5LMvy2lkOCUTocAcwF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687950; c=relaxed/simple;
	bh=YSIS8mQYy60AaGZUUcr3xR3JW3QP0FULhpa5XV284IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOv2Ry0PY4eJCpU+qPAPOVM22svzrCQrKkf7dEb8UWika9SEAonBMZWRziGuUd6bu/NamjPzX6uOLMy/JaAc88dHVhZmijEw0nq66jIFxyhBQBEsJKDBDjPFAY9GL+/mk8i5S+jbisKswRI9HNDkvma61V+jQTAbHqR8DgnptvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyIFK84N; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9abe139088so126864766b.1;
        Wed, 23 Oct 2024 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729687944; x=1730292744; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NAxDZcUfCng+DUNFyrC/AKwhSj/73MfKXpYFHi+RSAU=;
        b=FyIFK84N+yow8vyxiqZDYzQ+up2DdXp11D76bPUyCgY7HzSvhdyShTZLtMxQ6mGj8F
         9FINVqTULLuG2FgojtoWLE6EDPvtrgiLR9DtAiqm9THGJtKm+ibD1Hgzv3BW7qKrlgYK
         dUdnEY+RDoI0rzrC0wG4VpAnx/9fgntlyxwoervFC/vV2B5UVTuz5UxhB5etBDIIdi9C
         GcNwFqd1l8cqgzHUGTlELT56RyxqXAVWsqqeDtvDWuta5Gky1lUsl2JdXkM5kMaKx9rV
         SeFn8kV1zqbV1gsQQgW7WjX05fb0m5+99Baqni7ez7jGnf8tUPDWXwgDodyO5NY1YSLX
         MgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729687944; x=1730292744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAxDZcUfCng+DUNFyrC/AKwhSj/73MfKXpYFHi+RSAU=;
        b=gnprQpib22kp4F5jwgDNDvJqQRApzzK7GULNpUlsFLyj7efCJf3e7tJY+H4Ertuy7K
         0OldUdm4kIm+jOvTAoyCyQd4zVJFLoFoMZZsVlT3JUhqUNkLgrBd+qHwoxtVB2q+GVhR
         OU5y5BDr7PgVSRxzYqDuti2weo1tQIoRxQUrHXLkcbF81ZjZZhShJX+PIBYNy3QTvtQr
         rOik6XOsL5CG7aXSstG6uYhNGrMdowciXJ4Kq1Cpvx71CbsUONlPgfiW6YRRa14uxr6F
         Ve2eDhqhMHAVY8B0aSVNB06vkFpwEl6jNkwgFrmRG3ZNbCNyAFzYMhLSIM+GcWhT3s6v
         yB3g==
X-Forwarded-Encrypted: i=1; AJvYcCU1QQ3YDSzvh3Wx+Jp0faXePZCxVzE7iUwtSUIl3pPGx73e90h05VbxH57OosJa2OsVvlxUTrElTs4n@vger.kernel.org, AJvYcCUDLLJ6Xrs3U7MsFPrw/EAqR0BNTcLW/qOabDc4x7Ncr24YDvJFmzNaC9ub29ajM0tlX1Wn09+GDh+o@vger.kernel.org, AJvYcCUZLOcQgjtUNuhl9wERxRECBA26+ohvKADsBJbdYpJIZKTPtw16aX7UZj++dVdIkMR8aSyOqfBprRRFsBTt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3P8b6Az/1M7tEGvA2VvKojsFwnuHebzQipCaeKS5gbfgjGfzs
	vuyGaBUV0QgZJoiLz96hrRZXBiWxP9zhVwrGIlNKVEEI1LFO2pvx8uYl0QS1
X-Google-Smtp-Source: AGHT+IF5yk0HhZ+ETbtk4xhn2J5Q7HSseKucesx9u2mYjnY2Mo1aQgigJvj7xES/VmMZ+z5BYEXW+A==
X-Received: by 2002:a17:906:7308:b0:a99:fb10:1269 with SMTP id a640c23a62f3a-a9abf873267mr218973266b.17.1729687944005;
        Wed, 23 Oct 2024 05:52:24 -0700 (PDT)
Received: from debian ([2a00:79c0:624:c500:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91559a1csm475695566b.125.2024.10.23.05.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:52:23 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:52:21 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20241023125221.GA197308@debian>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
 <20240927125745.38367-3-dima.fedrau@gmail.com>
 <oppdnsda4tqjcpsb26j5ew62t4bkkmtxuu7e2fpinnazubk5ky@tmz76o5xdrlj>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oppdnsda4tqjcpsb26j5ew62t4bkkmtxuu7e2fpinnazubk5ky@tmz76o5xdrlj>

Hello Uwe,

Am Tue, Oct 22, 2024 at 09:54:50AM +0200 schrieb Uwe Kleine-König:

[...]
> > +
> > +#define MC33XS2410_MIN_PERIOD		488282
> > +#define MC33XS2410_MAX_PERIOD_STEP0	2000000000
> > +/* x in { 0 ... 3 } */
> > +#define MC33XS2410_MAX_PERIOD_STEP(x)	(MC33XS2410_MAX_PERIOD_STEP0 >> (2 * x))
> 
> Nitpick: These register definition become easier to parse for a human if
> you indent the RHS of register fields one tab further and add an empty
> line between the definitions for different registers.
> 

Adding an empty line seems reasonable to me but the additional tab doesn't
help me to improve readability.

> MC33XS2410_PWM_DC1 is only used once, I'd hard-code it into the
> definition of MC33XS2410_PWM_DC.
> 

Ok. Should I do the same for MC33XS2410_PWM_FREQ1 and
MC33XS2410_MAX_PERIOD_STEP0 ?

> The register fields [7:4] in MC33XS2410_PWM_CTRL3 are called PWM_ON4 ..
> PWM_ON1. So your x in { 0 ... 3 } is wrong. (Luckily, having some x
> range over { 0 ... 3 } and others orver { 1 ... 4 } is prone to error
> and confusion.)
> 

Will fix it. Should I do the same for MC33XS2410_PWM_CTRL1_POL_INV ?

> Also I'd drop all _MASK suffixes.
> 

Ok.

> For MC33XS2410_MAX_PERIOD_STEP maybe use a different variable name than
> for the others. For the register definitions the range is over hwpwm
> (which might be a good name there?), for MC33XS2410_MAX_PERIOD_STEP it's
> about MC33XS2410_PWM_FREQ_STEP.
> 

What about MC33XS2410_PWM_MAX_PERIOD(x) ?

> > +#define MC33XS2410_MAX_TRANSFERS	5
> > +#define MC33XS2410_WORD_LEN		2
> > +
> > +struct mc33xs2410_pwm {
> > +	struct spi_device *spi;
> > +};
> > +
> > +static inline struct mc33xs2410_pwm *mc33xs2410_from_chip(struct pwm_chip *chip)
> > +{
> > +	return pwmchip_get_drvdata(chip);
> > +}
> > +
> > +static int mc33xs2410_xfer_regs(struct spi_device *spi, bool read, u8 *reg,
> > +				u16 *val, bool *ctrl, int len)
> 
> Should len better be unsigned?
> 

I switch to unsigned.

> Unless I missed something all ctrl[x] are always identical. If so
> represent that by a single bool.
> 

Yes, they are identical. I added the crtl[x] to be able read from ctrl and
diag registers. I will change it so it is represented by a single bool, if
the feature is needed in the future I can still add it.

> > +{
> > +	struct spi_transfer t[MC33XS2410_MAX_TRANSFERS] = { { 0 } };
> > +	u8 tx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
> > +	u8 rx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
> > +	int i, ret, reg_i, val_i;
> > +
> > +	if (!len)
> > +		return 0;
> > +
> > +	if (read)
> > +		len++;
> > +
> > +	if (len > MC33XS2410_MAX_TRANSFERS)
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i < len; i++) {
> > +		reg_i = i * MC33XS2410_WORD_LEN;
> > +		val_i = reg_i + 1;
> > +		if (read) {
> > +			if (i < len - 1) {
> > +				tx[reg_i] = reg[i];
> > +				tx[val_i] = ctrl[i] ? MC33XS2410_RD_CTRL : 0;
> > +				t[i].tx_buf = &tx[reg_i];
> > +			}
> > +
> > +			if (i > 0)
> > +				t[i].rx_buf = &rx[reg_i - MC33XS2410_WORD_LEN];
> > +		} else {
> > +			tx[reg_i] = reg[i] | MC33XS2410_WR;
> > +			tx[val_i] = val[i];
> > +			t[i].tx_buf = &tx[reg_i];
> > +		}
> > +
> > +		t[i].len = MC33XS2410_WORD_LEN;
> > +		t[i].cs_change = 1;
> 
> Not sure if MC33XS2410_WORD_LEN really improves readability here.
> 

It is used throughout in the function and improves readability overall,
maybe not here but for consistency I would stick to it.

> Why is this done using $len transfers, wouldn't a single one do (and
> maybe be more performant and not rely on a spi controller that supports
> cs_change)?
> 

Without cs_change after every 16 bit, requests aren't processed by the
device. Reading/writing from/to device fails. The SPI controller therefore
must support cs_change. Single transfer is not possible because of the
cs_change after every 16bit.

> > +	}
> > +
> > +	t[len - 1].cs_change = 0;
> > +
> > +	ret = spi_sync_transfer(spi, &t[0], len);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (read) {
> > +		for (i = 0; i < len - 1; i++) {
> > +			reg_i = i * MC33XS2410_WORD_LEN;
> > +			val[i] = FIELD_GET(MC33XS2410_RD_DATA_MASK,
> > +					   get_unaligned_be16(&rx[reg_i]));
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > [...]
> > +static
> > +int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, u16 *val, bool ctrl)
> 
> My personal opinion: Better break the line in the argument list or not
> at all. Having a "static" on its own line looks ugly.
> 
Ok.

> > +{
> > +	return mc33xs2410_read_regs(spi, &reg, &ctrl, val, 1);
> > +}
> > [...]
> > +static u64 mc33xs2410_pwm_get_period(u8 reg)
> > +{
> > [...]
> > +	/* Convert frequency to period, considering the doubled frequency. */
> > +	return DIV_ROUND_UP((u32)(2 * NSEC_PER_SEC), freq);
> 
> That u32 cast isn't needed.
>
Will fix it.

> > +}
> > [...]
> > +static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				const struct pwm_state *state)
> > +{
> > [...]
> > +	/* frequency */
> > +	val[0] = mc33xs2410_pwm_get_freq(period);
> > +	/* Continue calculations with the possibly truncated period */
> > +	period = mc33xs2410_pwm_get_period(val[0]);
> > +
> > +	/* duty cycle */
> > +	duty_cycle = min(period, state->duty_cycle);
> > +	rel_dc = mc33xs2410_pwm_get_relative_duty_cycle(period, duty_cycle);
> > +	val[1] = rel_dc < 0 ? 0 : rel_dc;
> 
> Handling of the duty cycle is correct here, but misleading. I already
> added a comment here that using val[1] = 0 if rel_dc < 0 is wrong and
> just deleted it again after I saw (rel_dc >= 0) being used determining
> the value for MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm). An explicit if block
> would make this more obvious.
>

Will add an explicit if block, should I do the same for the value for
MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm) ?

> mc33xs2410_pwm_get_relative_duty_cycle() is simple enough and only used
> once that I'd unroll it here.
> 

You are right, will fix it.

> > +	/* polarity */
> > +	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
> > +	val[2] = (state->polarity == PWM_POLARITY_INVERSED) ?
> > +		 (val[2] | mask) : (val[2] & ~mask);
> > +
> > +	/* enable output */
> > +	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
> > +	val[3] = (state->enabled && rel_dc >= 0) ? (val[3] | mask) :
> > +						   (val[3] & ~mask);
> > +
> > +	return mc33xs2410_write_regs(spi, reg, val, 4);
> > +}
> > +
> > +static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
> > +				    struct pwm_device *pwm,
> > +				    struct pwm_state *state)
> > +{
> > [...]
> > +	state->period = mc33xs2410_pwm_get_period(val[0]);
> > +	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
> > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > +	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
> > +	mc33xs2410_pwm_set_relative_duty_cycle(state, val[1]);
> 
> No need to set state->duty_cycle = 0 if state->enabled is false. This is
> another function I suggest to unroll as it hides more than it abstracts.
> 

Function can be unrolled, but the check for state->enabled is needed. The
device is unable to generate a 0% duty cycle, so it is turned off to
generate a 0% duty cylce.

> > +	return 0;
> > +}
> > +
> > [...]
> > +static int mc33xs2410_probe(struct spi_device *spi)
> > +{
> > [...]
> > +	/* Transition to normal mode */
> > +	ret = mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
> > +				    MC33XS2410_GLB_CTRL_MODE,
> > +				    MC33XS2410_GLB_CTRL_MODE_NORMAL);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to transition to normal mode\n");
> 
> What is the effect of this register write if the PWM was already setup
> by the bootloader?
> 

When its setup is done in the bootloader and the watchdog is disabled in
the bootloader it shouldn't have any impact.

> > +
> > +	ret = devm_pwmchip_add(dev, chip);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
> > +
> > +	return 0;
> > +}
> 
> Best regards
> Uwe

Best regards
Dimitri

