Return-Path: <linux-pwm+bounces-6680-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A395AF03AC
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 21:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DCB17EDB0
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 19:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE05283FDC;
	Tue,  1 Jul 2025 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fndr8F9k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19127F72D;
	Tue,  1 Jul 2025 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397631; cv=none; b=iB+vaZnrlDmz9Krga74Hj97+j5OfsYaU8cykmg9clOF9JfdYvTxqgW4oInCLi73UsN/piW9D6qZ5mhLzsGf2EbxCcLUfbeeUTOB51RCYEgIfNjQEJKvvpXBBR62QF1isAu6EqirNLDd7N9LckEIjuNoivTF7//FsE2kV4TTQn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397631; c=relaxed/simple;
	bh=PI47XvcY2sSUCG3zRcGH/v/jHuKE2kM7Py3MKVxpDg8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2G/01m1O3Rj/6itdtRVji3QgssTnUL7lDvZ75Y5zK+PWsY9CV+V0EaSQE8mQjTPnT+y+rYiQH2ltsm3ovR6+FxoSA8OG6YVxnrYILC21CxNJOQ/78unFaf0h7wWwEmZVAx3Q0iWOQTXOGACbJR9zFjg4KYEHTLjl6WUHnTPI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fndr8F9k; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45363645a8eso42260155e9.1;
        Tue, 01 Jul 2025 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751397628; x=1752002428; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Z6TJIuiP5Vfg+Ial9s2h6Ucwo4uUFWMeZAOroEalhw=;
        b=Fndr8F9kfwigJ7oecbGeTFEwyx3mTux2XihB2191iKrny6DMKZ+bd6gBB8WpV3qxVF
         O83rXYXk98dv85yNgI8vF4A13TRKASoGiYlRfNE/JMowH/pdZaFat8IoaTEvWb4wIl3c
         KXyP4lPuwmSJgoLT0g0xQbRs7aaxcXHkMCWEzJDuXKGooIXwfceDeX33ETyG+72H+QkH
         RUKlvKyLNA6y4GCrtb4d1tQhV0dP2ExMwagdH2Vuesi8P4Qi2OX5dK3lit6keis1Oxrp
         m3vNH8fIUWjvMVAkAKWczY+dEPSsjqdnCMbFbSlCD1D//zWg+FdYBawHMCW3Ysr4MACo
         kxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751397628; x=1752002428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z6TJIuiP5Vfg+Ial9s2h6Ucwo4uUFWMeZAOroEalhw=;
        b=e7ykvInkn8O5LDNn60WBQ2zYH/3eiak4P6pFDyrkvLATnLDlIGIwjv4I7pei8jJbch
         OMl95wOLs13MvG/u7wLYd9YjT9oTNuRbAVbClVyl/ETR4Lwqw+s26bKMZ07wfCBqtmv4
         m/okTudkJBehbffPZoiIyVcGT70iFIOA4O/DMkAttsbiQm020oesweB3+eKGLNlWmM0q
         357nLIfYeI5KoXEH7Ztlpnoh3qsmex84qM0oPOBxWtEpZE3HyF07NZd6oeCqn7yt5pde
         mLUs4UV+jfxWlUfh+p+Cs1CpNws8pkigzFpizwb450Dv5STfAT9PwQFBISWAW/Ae62SQ
         zIIw==
X-Forwarded-Encrypted: i=1; AJvYcCVn6BzyjRhr9sUQA7bpMg7Kzvep3qWhWScL49Fmv4qc2KDxBAeeuHuqNRSE9JRNWgPhIkMVa0yPCvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmqQboMzm0VNsj7WJG/nncItdfEXnISQ/4VqRTnd9RRznoHOD
	ryhoh8dsK4Iw8QL4UEgzuRqhxBqS7yo21TuvfjV9/gdznr+1F3yEO/5z22C3Aw==
X-Gm-Gg: ASbGnctmmehG5ZeCX8CYWqEH3cwm96HVnztf+Bokr1PO7pv+QxAu9FLDoAX++51sW5G
	dkyBJm20yI5cgBdBqpGHD+3kkAuBrcZ2MnbWqYr+7l4CRQZyHSSh/GPuEJQwVhGhf30CtG4c/ji
	yoFoD8TXw13FqfwJ0jDdUbGy4qdC39h7PksUW55P04pWYcDceAWXq1emUV+X55vrtWZg7TqoGji
	alvjsGz6+ChlXlQvHUM48DL0iiI2/+Y18NXReCGLuwafr8+PdgU0/dZflj6SIsw6rLcolwGPzSf
	9JRV+sXh9VClfuWvawy/9y7muwWOCmevvyPHgOCyNQbG4iJQiWmha+KVLXms+nHvtc7pQhnqtAo
	v8O9Efj62YARBfLie46wfyYbXvNN6qqBrUA==
X-Google-Smtp-Source: AGHT+IGNJN6WUGUWGiaUABhD2MzDX20ma5IAat/9d8UKbAMYX8Mq9N1l1NTweTa7IqYdB/VZWc8PMg==
X-Received: by 2002:a05:600c:c109:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-454a39d574bmr89945e9.4.1751397627547;
        Tue, 01 Jul 2025 12:20:27 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-46-252-169.retail.telecomitalia.it. [79.46.252.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a8048sm179169185e9.9.2025.07.01.12.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 12:20:27 -0700 (PDT)
Message-ID: <686434fb.050a0220.efc3e.909b@mx.google.com>
X-Google-Original-Message-ID: <aGQ0-H-lVL99unFL@Ansuel-XPS.>
Date: Tue, 1 Jul 2025 21:20:24 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v19] pwm: airoha: Add support for EN7581 SoC
References: <20250630114504.8308-1-ansuelsmth@gmail.com>
 <bwtk2nac2eo2jgf2lousguw7o34tzhz7mesdo3jfaf4gc3pri6@tff3h4f4274u>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bwtk2nac2eo2jgf2lousguw7o34tzhz7mesdo3jfaf4gc3pri6@tff3h4f4274u>

On Tue, Jul 01, 2025 at 09:40:03AM +0200, Uwe Kleine-König wrote:
> Hello Christian,
> 
> On Mon, Jun 30, 2025 at 01:44:39PM +0200, Christian Marangi wrote:
> > +struct airoha_pwm_bucket {
> > +	int used;
> > +	u32 period_ticks;
> > +	u32 duty_ticks;
> > +};
> > +
> > +struct airoha_pwm {
> > +	struct regmap *regmap;
> > +	/* Global mutex to protect bucket used counter */
> > +	struct mutex mutex;
> 
> I think you don't need that mutex. There is a chip lock already used by
> the core and that is held during .get_state() and .apply() serializing
> these calls (and more).
> 
> > +	DECLARE_BITMAP(initialized, AIROHA_PWM_MAX_CHANNELS);
> > +
> > +	struct airoha_pwm_bucket buckets[AIROHA_PWM_NUM_BUCKETS];
> > +
> > +	/* Cache bucket used by each pwm channel */
> > +	u8 channel_bucket[AIROHA_PWM_MAX_CHANNELS];
> > +};
> > [...]
> > +static int airoha_pwm_apply_bucket_config(struct airoha_pwm *pc, int bucket,
> > +					  u32 duty_ticks, u32 period_ticks)
> > +{
> > +	u32 mask, shift, val;
> > +	u64 offset;
> > +	int ret;
> > +
> > +	offset = bucket;
> > +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
> 
> Do you really need offset as a 64 bit variable? At least on 32 bit archs
> 
> 	offset = bucket / AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> 	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(bucket % AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
> 
> should be cheaper. Also can bucket better be an unsigned value (to make
> it obvious that no strange things happen with the division)?
>

No for this u32 is ok.

> > +	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> > +
> > +	/* Configure frequency divisor */
> > +	mask = AIROHA_PWM_WAVE_GEN_CYCLE << shift;
> > +	val = FIELD_PREP(AIROHA_PWM_WAVE_GEN_CYCLE, period_ticks) << shift;
> > +	ret = regmap_update_bits(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset),
> > +				 mask, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	offset = bucket;
> > +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
> > +	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> > +
> > +	/* Configure duty cycle */
> > +	mask = AIROHA_PWM_GPIO_FLASH_PRD_HIGH << shift;
> > +	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, duty_ticks) << shift;
> > +	ret = regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +				 mask, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mask = AIROHA_PWM_GPIO_FLASH_PRD_LOW << shift;
> > +	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_LOW,
> > +			 AIROHA_PWM_DUTY_FULL - duty_ticks) << shift;
> > +	return regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +				  mask, val);
> 
> Strange hardware, why do you have to configure both the high and the low
> relative duty? What happens if AIROHA_PWM_GPIO_FLASH_PRD_LOW +
> AIROHA_PWM_GPIO_FLASH_PRD_HIGH != AIROHA_PWM_DUTY_FULL?
> 

From documentation it gets rejected and configured bucket doesn't work.

> > +}
> > +
> > [...]
> > +static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
> > +	u32 period_ticks, duty_ticks;
> > +	u32 period_ns, duty_ns;
> > +
> > +	if (!state->enabled) {
> > +		airoha_pwm_disable(pc, pwm);
> > +		return 0;
> > +	}
> > +
> > +	/* Only normal polarity is supported */
> > +	if (state->polarity == PWM_POLARITY_INVERSED)
> > +		return -EINVAL;
> > +
> > +	/* Exit early if period is less than minimum supported */
> > +	if (state->period < AIROHA_PWM_PERIOD_TICK_NS)
> > +		return -EINVAL;
> > +
> > +	/* Clamp period to MAX supported value */
> > +	if (state->period > AIROHA_PWM_PERIOD_MAX_NS)
> > +		period_ns = AIROHA_PWM_PERIOD_MAX_NS;
> > +	else
> > +		period_ns = state->period;
> > +
> > +	/* Validate duty to configured period */
> > +	if (state->duty_cycle > period_ns)
> > +		duty_ns = period_ns;
> > +	else
> > +		duty_ns = state->duty_cycle;
> > +
> > +	/*
> > +	 * Period goes at 4ns step, normalize it to check if we can
> > +	 * share a generator.
> > +	 */
> > +	period_ns = rounddown(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> > +
> > +	/*
> > +	 * Duty is divided in 255 segment, normalize it to check if we
> > +	 * can share a generator.
> > +	 */
> > +	duty_ns = DIV_U64_ROUND_UP(duty_ns * AIROHA_PWM_DUTY_FULL,
> > +				   AIROHA_PWM_DUTY_FULL);
> 
> This looks bogus. This is just duty_ns = duty_ns, or what do I miss?
> Also duty_ns is an u32 and AIROHA_PWM_DUTY_FULL an int, so there is no
> need for a 64 bit division.
> 

duty_ns * 255 goes beyond max u32.

225000000000.

Some revision ago it was asked to round also the duty_ns. And this is
really to round_up duty in 255 segment.

Consider that this have the ROUND_UP part that is different than doing
simple stuff like "duty * 255/255"

Hope we can solve these 2 problem since I think it's the last changes.

> > +	/* Convert ns to ticks */
> > +	period_ticks = airoha_pwm_get_period_ticks_from_ns(period_ns);
> > +	duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
> > +
> > +	return airoha_pwm_config(pc, pwm, period_ticks, duty_ticks);
> > +}
> 
> Best regards
> Uwe



-- 
	Ansuel

