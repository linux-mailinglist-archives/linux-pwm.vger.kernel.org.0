Return-Path: <linux-pwm+bounces-2943-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4484A94297E
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2024 10:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57261F24EBD
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2024 08:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F21A8BEF;
	Wed, 31 Jul 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5X8WkFo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831C43169;
	Wed, 31 Jul 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415615; cv=none; b=klYFjHZFGVMowutDphpawHJrynRlB5B85ZYtoPx2UflqOrNg5LlPaBU7Ffv4QHJWI8RAjxr2nYKMIJHbKWcKLEtWblWmoPajoLOu5Kw3YD+n1RIt/FRdEKCLuwqiCvWDHyvAjK7dtUBkTmSJl72zYdQBpwuCylpq7HJuSebRUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415615; c=relaxed/simple;
	bh=EcLUai8puZv+oubCoR+USsYHTmJR8FRADIRjqIyMSqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phEYx0+YO+eYqiItxhXLX6VeIbe7PtgJHrM8+3mtRbOe5b+pvkehfNnaLszahSYUUEKP2bV0DgwcgDL4CeUB7k9Q8DhkgynYT+mu5Nb9oKvj6DwKna0unyEu4dkMifn4di/BTEjHN0VcJFjL65vAOrFJWOgUkBrpSDLZbMBM6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5X8WkFo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so8162629a12.2;
        Wed, 31 Jul 2024 01:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722415612; x=1723020412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fdoov56BhyXFrrpuPxNAzdSwKPOoGW7Wnv2Q1w89FEM=;
        b=G5X8WkFo1ixqcNrGC17Ikg8228+mlaD3G+EVQ2eQSNCUrUEF3ec2l6j10zooVPvqYr
         8S94yR+Wqrp/Odu5shPzKIf7AA/nC+D0oAyNtoARpgOhRjGoZqkQSNyYbFdy/lXPYaQY
         GW2UPk2eWt+ZkYGGP2MUSx9uASaxDxQR1IhdrqI+uGJuBunkrk9bwMPEziPH+yAoNY/G
         CXT0D4fRPmSMbXiEF4tQz5HNy+tJJMyreVHP92JS2K8VF4yIGPmpiFa7Q8+pt9zeed0h
         SyKxsxyLsTBmWcDxwERcx8Lu3RNQRRREjmT1I0Q2P2V31LgtpyQOD3gicOiAM5BWeCbW
         2FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722415612; x=1723020412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdoov56BhyXFrrpuPxNAzdSwKPOoGW7Wnv2Q1w89FEM=;
        b=CqwHMo3ynrWAY4noI3HYsUsW0DH5qpgBJiouc0so2g86h3WbHZOYrAGgS+/46VO6CS
         XHpqHw9YFMyWyyo5BmupUHZYLkeW1c1Bz6DGJynFMUEfzxHua9DMFwcsVwsFjSzPqJW5
         W+Smuyi+64l1LJed5KScJuXG1OyZOaxhfu4kWM/N8KsFa2l79NFfloQ5KPvRePKW7eT4
         4Wqv0BKRa3oe0AMGrQOwE0tTr+bSZlzXb6kt1Sjwgn0MKwWTBYVR0Qlq9q7sW4iYFCi9
         H24TWEF8VRUX27/HqOQ+CuTrjeFDiA/QMQkQQWTFcT2ILFdAR5JMlKahNbtuROktlaNR
         +0xA==
X-Forwarded-Encrypted: i=1; AJvYcCUY5sKZaTF72+RLkOL+Mu5bA/A62akOsQoJlmVG3f2EszUAI0uncnrkKSC3gBcY7hqaqkNSA3oMYMLOYtvqad0Wwqf17GA17FyEFTqzZXETRC6i/fGlYB25pkmLTyUPcO1H/mu+UsU9k5ECEBFvTuYp10rvKGc7Wjy/jmx/TWNHOB+6Gg==
X-Gm-Message-State: AOJu0YwzbrCVonc2//gCSfdbNZtjLcD93BZuuqCT1MlQ3RgffBGCPTep
	46rCXK5m/YtZ/Rp3pm0FoGXZWDoeuN8b38CAOySyQim+LtDn9XBuXLSqjnHP
X-Google-Smtp-Source: AGHT+IF1nPhIrXaIqS08sTpvKWy9YSO4UfeVVUfbu2iPgIg1qtLvq/pNU9HiR1jo7b849HypgQFuXg==
X-Received: by 2002:a17:907:7209:b0:a77:f2c5:84b3 with SMTP id a640c23a62f3a-a7d40057776mr934755866b.22.1722415611304;
        Wed, 31 Jul 2024 01:46:51 -0700 (PDT)
Received: from debian ([2a00:79c0:620:8300:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23094sm741718966b.5.2024.07.31.01.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 01:46:50 -0700 (PDT)
Date: Wed, 31 Jul 2024 10:46:48 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20240731084648.GA18584@debian>
References: <20240515112034.298116-1-dima.fedrau@gmail.com>
 <20240515112034.298116-3-dima.fedrau@gmail.com>
 <aczpsiqyh4qsbvnqhqdnvkj2j3fihkltafop5ajkxm57sehbx5@mn4vp7avpeac>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aczpsiqyh4qsbvnqhqdnvkj2j3fihkltafop5ajkxm57sehbx5@mn4vp7avpeac>

Am Mon, Jul 29, 2024 at 11:28:56PM +0200 schrieb Uwe Kleine-König:
Hi Uwe,

[...]

> > +static int mc33xs2410_xfer_regs(struct spi_device *spi, bool read, u8 *reg,
> > +				u16 *val, bool *ctrl, int len)
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
> 
> Huh, this is complicated. Isn't that covered by regmap somehow?
>

AFAIK it isn't supported. The main reason why regmap-spi doesn't work for
this device is that the device needs a CS change after transmitting 16
bits. This is not covered by regmap-spi. So I would end up implementing
reg_read, regmap_write should be fine in regmap-spi. Besides that if I
want to come as close as possible to an atomic configuration, which is not
possible, I would have to implement some bulk read/write operations and
end up with a similar implementation. I would stick to the current
implementation if you agree.

> > +}
> > +
> > [...]
> > +
> > +static u8 mc33xs2410_pwm_get_freq(u64 period)
> > +{
> > +	u8 step, count;
> > +
> > +	/*
> > +	 * Check if period is within the limits of each of the four frequency
> > +	 * ranges, starting with the highest frequency(lowest period). Higher
> > +	 * frequencies are represented with better resolution by the device.
> > +	 * Therefore favor frequency range with the better resolution to
> > +	 * minimize error introduced by the frequency steps.
> 
> I'm not a native English speaker, but I find that misleading. That
> period is in the "possible" range is already asserted by the caller. So
> the switch is about "Check which step is appropriate for the given
> period", right?
> 

Yes, you are right. Will fix it in the next version.

> > +	 */
> > +
> > +	switch (period) {
> > +	case MC33XS2410_MIN_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(3):
> > +		step = 3;
> > +		break;
> > +	case MC33XS2410_MAX_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(2):
> > +		step = 2;
> > +		break;
> > +	case MC33XS2410_MAX_PERIOD_STEP(2) + 1 ... MC33XS2410_MAX_PERIOD_STEP(1):
> > +		step = 1;
> > +		break;
> > +	case MC33XS2410_MAX_PERIOD_STEP(1) + 1 ... MC33XS2410_MAX_PERIOD_STEP(0):
> > +		step = 0;
> > +		break;
> > +	}
> > +
> > +	count = DIV_ROUND_UP(MC33XS2410_MAX_PERIOD_STEP(step), period) - 1;
> > +
> > +	return FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step) |
> > +	       FIELD_PREP(MC33XS2410_PWM_FREQ_COUNT_MASK, count);
> > +}
> > +
> > [...]
> > +
> > +static int mc33xs2410_pwm_get_relative_duty_cycle(u64 period, u64 duty_cycle)
> > +{
> > +	if (!period)
> > +		return 0;
> > +
> > +	duty_cycle *= 256;
> 
> This might overflow.
> 

How ? Max period and duty_cycle is checked by the caller and can be
maximum 2000000000, 2000000000 * 256 = 512000000000, fits in u64. Did I
miss anything ?

> > +	duty_cycle = DIV_ROUND_CLOSEST_ULL(duty_cycle, period);
> 
> round-closest is most probably wrong. Please test your driver with
> PWM_DEBUG enabled and increasing and decreasing series of duty_cycle and
> period.
>

Yes, I should probably round it down. But I tested with PWM_DEBUG enabled
and it gave me the best results so far. There are still few cases where
there are complaints. I try to fix it.

> > +
> > +	/* Device is not able to generate 0% duty cycle */
> > +	if (!duty_cycle)
> > +		return -ERANGE;
> 
> Given that the hardware emits a low level when disabled, please disable
> if duty_cycle = 0 is requested.
> 

Ok.

> > +	return duty_cycle - 1;
> > +}
> > +
> > [...]
> > +static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
> > +				    struct pwm_device *pwm,
> > +				    struct pwm_state *state)
> > +{
> > +	struct mc33xs2410_pwm *mc33xs2410 = to_pwm_mc33xs2410_chip(chip);
> > +	struct spi_device *spi = mc33xs2410->spi;
> > +	u8 reg[4] = {
> > +			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
> > +			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
> > +			MC33XS2410_PWM_CTRL1,
> > +			MC33XS2410_PWM_CTRL3,
> > +		    };
> > +	bool ctrl[4] = { true, true, true, true };
> > +	u16 val[4];
> > +	int ret;
> > +
> > +	ret = mc33xs2410_read_regs(spi, reg, ctrl, val, 4);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	state->period = mc33xs2410_pwm_get_period(val[0]);
> > +	pwm_set_relative_duty_cycle(state, val[1] + 1, 256);
> 
> pwm_set_relative_duty_cycle doesn't use the right rounding for
> .get_state().
> 

As mentioned above, will try to fix it.

> > +	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
> > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > +
> > +	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
> > +
> > +	return 0;
> > +}
> > +
> > [...]
> > +static int mc33xs2410_probe(struct spi_device *spi)
> > +{
> > [...]
> > +	/* Disable watchdog */
> > +	ret = mc33xs2410_write_reg(spi, MC33XS2410_WDT, 0x0);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Failed to disable watchdog\n");
> 
> Wouldn't the watchdog functionality better be handled by a dedicated
> watchdog driver? Disabling it here unconditionally looks wrong.
> 

Yes, would be better. I planned this after this patchset is accepted.
Without disabling the watchdog, the device is not able to operate. So I
would stick to it for now and come up with a patch later on.

> > +	/* Transition to normal mode */
> > +	ret = mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
> > +				    MC33XS2410_GLB_CTRL_MODE_MASK,
> > +				    MC33XS2410_GLB_CTRL_NORMAL_MODE);
> > [...]
> 
> Best regards
> Uwe

Best regards
Dimitri


