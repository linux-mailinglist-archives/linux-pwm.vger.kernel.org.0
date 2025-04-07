Return-Path: <linux-pwm+bounces-5367-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED95A7E8D6
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 19:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F8C189306B
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 17:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D49F211706;
	Mon,  7 Apr 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVA4nNxS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240EA2192F2;
	Mon,  7 Apr 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047601; cv=none; b=UK9yGi3TtmHiraV6qSN1pMsI9dHeFEUwKSgo6OCeRUQE+IoJvhTwJrkaJyuqq91JzoIRfC/Cztm5iTL8yoOXilJtxLv9YY4PNnB9kdmaMMl/DEEm8rLidUv6Ap8QlhKtIhFPORyvS4GUh5GiZODKnkFP0SsBHBNZyLOqfRXWcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047601; c=relaxed/simple;
	bh=X6qFXtDHDrF1k3G4ktPMX0+9tD2sBdjiNFdtBcntGks=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InZ03JKKgW44bGG0XpRO/NJjByhSn0Uxzqrvgir/2sfxnTfp7JsujN8dE1M1BHBdBXJ1in4bH0eSs6/vkHtbNgxYlnorK/iGVg1tiAqAqMzoKJtmtcr9sTCDcp74SXuocscZqOA5Nge8tFEx4OIAzWqmJoer3U9w5DAq7gi16Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVA4nNxS; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac3b12e8518so862821866b.0;
        Mon, 07 Apr 2025 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744047597; x=1744652397; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QT1Asq3DoI2ON9cBx7/5YHRV/dlNThx/+XtEWpdZgqQ=;
        b=KVA4nNxS+Wd7qQOpP/97TY8KHVNGZsMBU47lb4ilC8q9jgRk0sQVW9ckkAbBZQkQBK
         /vW8XXfqCpqPWFaUBSe18LnHYYVzz31FjO36U5CpXhmNrffsY3/nvd+Cj9BxCwIW1t3Y
         ERjbRFo79ze5Phvmp/EkHqv5tWj/f4to7a4CL3IrN/61NDmiIZvGYkl+9XYEECA+SY2x
         X7l00fXI/6LOMcaO4J2MlHO3pKSGc3P8fKSQC2M8wllhKNrz5gbM7RqZBWSnfv8kPWsl
         ExECgcjPCup1aQeyZyxCHZJRQfOzq5S9PphRenOsmIkOb4sgA2FW8FFles84Mu0Idzdt
         dN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744047597; x=1744652397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QT1Asq3DoI2ON9cBx7/5YHRV/dlNThx/+XtEWpdZgqQ=;
        b=HApa7+7IqeWplSyF3oR+7cUiWkJnT9Sp4R/xpv5N9cS/h3fE8rBkEr2NbsJx0ufLUp
         1q1FRKmSGkcjHT4nxftZjeF8NykvC+h3SAFq/o1NYNUAEDGRF6yjFU83jGKydK3pdEOB
         eJeGizke9zN2xuWPBxBWtKbRKuyZOUzKx4FAxkxLJBGHENKkt/q5WiFcIZ69mXTdhobP
         4yyKaGI2uMZ4hSYYrD1ppRSDqypDEa81hit0tehbmcL7x3qmAtjohS0QvSKnbQJYk1K4
         HuArU/omx64LcPIiepE82C0lG3WfKc9rJvvy5ixj11uHKaoyGigEcSVuVh9YBLvIgOTD
         YGhw==
X-Forwarded-Encrypted: i=1; AJvYcCWFCOdaek8q3zaXPAc6WSOcaUFo40uGHe8gXYt6iyzF7FNQ474zVnnbms6tp6RcgcO5HOYqgUmJKpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLJzWkq5yTcplW3Y0eutH0j7YfUTn7eRU7qMkmhGgxj4KMqah
	5wrSf3It0pefl2c6aNafZOmkSC3w+fUHVGRIbgHloEbQjhjtXPlS
X-Gm-Gg: ASbGnctuP1vsOTvyuUgb/wT6x2ONNCmGoXlGcOPELLvDfk0U2M4niTKWeqOGzXXlFjr
	APVtAcZsR/Br8flCI4HTgIH9E9e8x0mDMwxVGSF9VzrBP+sVRBy2uNNTCwIJLR5MnUR47109Kya
	DlzDakKAA8zuj35ucyOR44y/YYyzMutll5wIYxD4H0TmKNGpNw/9vyT5KHIyyNbbBPpvSO1gtn9
	KhnCM5rjake/u4LwSFntRZLk1B9gfFJvJy9mJId/G5V9yzrURC94vg5KHNW0uR9L7jMSNAv82lf
	yGJpeUD/0dLj76QaSrLO8F701iTU/FdDAgY31QMtPtswOP8a1kAWYHSY7ZhJtEB4ultoBCB00vx
	w
X-Google-Smtp-Source: AGHT+IFxTu4vVXk2NEzG3SwqibSUM58dt3tmTncHbGWWDA2f+C6iBc60YzmDyKmLOJnTixbBcI8T+Q==
X-Received: by 2002:a17:907:7e88:b0:ac6:bf3d:bf45 with SMTP id a640c23a62f3a-ac7d19671efmr1370297066b.36.1744047597026;
        Mon, 07 Apr 2025 10:39:57 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe9be51sm787772466b.50.2025.04.07.10.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 10:39:56 -0700 (PDT)
Message-ID: <67f40dec.170a0220.5cda5.994c@mx.google.com>
X-Google-Original-Message-ID: <Z_QN6sjphRFqtAPU@Ansuel-XPS.>
Date: Mon, 7 Apr 2025 19:39:54 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [RESEND PATCH v11] pwm: airoha: Add support for EN7581 SoC
References: <20250226002537.3752-1-ansuelsmth@gmail.com>
 <cdwttmqcvhetlf446gsaxsta76ojlqckxc253svho4xsm7qxhs@6otqm6yyuvfh>
 <67ee67f5.050a0220.38e02.5bc2@mx.google.com>
 <zwckkfd6mzzjxfpitojcmhokhjbtc4u3brf34pcu4phdlipf3z@uijstw7daze2>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zwckkfd6mzzjxfpitojcmhokhjbtc4u3brf34pcu4phdlipf3z@uijstw7daze2>

On Thu, Apr 03, 2025 at 05:01:46PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Apr 03, 2025 at 12:50:27PM +0200, Christian Marangi wrote:
> > On Thu, Apr 03, 2025 at 11:58:48AM +0200, Uwe Kleine-König wrote:
> > > > +	if (hwpwm >= AIROHA_PWM_NUM_GPIO)
> > > > +		offset -= AIROHA_PWM_NUM_GPIO;
> > > > +
> > > > +	/* One FLASH_MAP register handles 8 pins */
> > > > +	*shift = do_div(offset, AIROHA_PWM_PINS_PER_FLASH_MAP);
> > > > +	*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(*shift);
> > > > +
> > > > +	if (offset < AIROHA_PWM_NUM_GPIO)
> > > > +		*addr = AIROHA_PWM_REG_GPIO_FLASH_MAP(offset);
> > > > +	else
> > > > +		*addr = AIROHA_PWM_REG_SIPO_FLASH_MAP(offset);
> > > 
> > > A single if would be a bit more straight forward. Something like:
> > > 
> > > 	static void airoha_pwm_get_flash_map_addr_and_shift(unsigned int hwpwm,
> > > 							    unsigned int *addr, unsigned int *shift)
> > > 	{
> > > 		u64 offset = hwpwm;
> > > 	
> > > 		if (hwpwm >= AIROHA_PWM_NUM_GPIO) {
> > > 			unsigned sipohwpwm = hwpwm - AIROHA_PWM_NUM_GPIO;
> > > 
> > > 			*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(sipohwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP)
> > > 			*addr = AIROHA_PWM_REG_SIPO_FLASH_MAP(sipohwpwm);
> > > 		} else {
> > > 			*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP)
> > > 			*addr = AIROHA_PWM_REG_GPIO_FLASH_MAP(hwpwm);
> > > 		}
> > > 	}
> > > 
> > 
> > I think you missed the do_div that do side effect on offset. Also that
> > needs to be / AIROHA_PWM_PINS_PER_FLASH_MAP.
> 
> Ack. Luckily you got the idea anyhow. This double effect of do_div() is
> easy to miss, so getting rid of them sounds sensible.
> 
> > > > +		if (duty_ns == bucket->duty_ns &&
> > > > +		    period_ns == bucket->period_ns)
> > > > +			return i;
> > > 
> > > If period_ns == 4010 and bucket->period_ns == 4000 you're not
> > > considering *bucket even though it has the right period setting.
> > > (period_ns is the requested period and not the expected period actually
> > > implemented by HW, right?)
> > > 
> > 
> > Doesn't that requires a different generator? The value we store in the
> > bucket is the requested period yes.
> 
> No it doesn't. If I understood right the possible periods are: 4ms, 8ms,
> ..., so a request to do 4.01ms will be mapped to 4ms which allows to
> share the generator.
> 
> > > > +				  AIROHA_PWM_GPIO_FLASH_EN << shift);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	regmap_update_bits(pc->regmap, addr,
> > > > +			   AIROHA_PWM_GPIO_FLASH_SET_ID << shift,
> > > > +			   FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID, index) << shift);
> > > 
> > > Huh, I'd prefer:
> > > 
> > > 	regmap_update_bits(pc->regmap, addr,
> > > 			   AIROHA_PWM_GPIO_FLASH_SET_ID(hwpwm % 8)
> > > 			   FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID(hwpwm % 8), index));
> > > 
> > > (That probably doesn't work out of the box because of the
> > > __builtin_constant_p check on mask, so you might need a local
> > > alternative to FIELD_PREP without that check.)
> > 
> > Honestly it's not worth to introduce custom FIELD_PREP for this. Yes the
> > problem is that FIELD_PREP requires constant mask so hwpwm % 8 is
> > problematic. An old implementation had stuff in define but resulted in
> > very ugly and confusing define and macro. The shift and FIELD_PREP
> > permits a much cleaner description in the define part at the cost of
> > that additional << shift needed.
> > 
> > Hope you can understand why I think it's better to keep it this way.
> 
> OK, I can live with that.
> 
> > > > +	bucket = airoha_pwm_consume_generator(pc, duty_ns, period_ns,
> > > > +					      hwpwm);
> > > > +	if (bucket < 0)
> > > > +		return -EBUSY;
> > > > +
> > > > +	/*
> > > > +	 * For SIPO reinit is always needed to trigger the shift register chip
> > > > +	 * and apply the new flash configuration.
> > > 
> > > I don't understand that sentence. What is the shift register chip? What
> > > is a flash configuration?
> > > 
> > 
> > The SoC can have attached a shift register chip to supports multiple LEDs.
> > The handling of this chip and comunication is done internally to the SoC
> > and it's exposed to register with these additional register.
> > 
> > When such channel are used with an assumed shift register, to apply the
> > new configuration in airoha_pwm_config_flash_map(), the shift register
> > chip needs to be reinit to actually refresh the chip internal register
> > with the new "flash configuration" (aka the values for
> > AIROHA_PWM_GPIO_FLASH_SET_ID)
> > 
> > Will add more comments to this to make it more clear.
> 
> Sounds good.
> 
> > > > +	state->enabled = FIELD_GET(AIROHA_PWM_GPIO_FLASH_EN, val >> shift);
> > > > +	if (!state->enabled)
> > > > +		return 0;
> > > > +
> > > > +	state->polarity = PWM_POLARITY_NORMAL;
> > > > +
> > > > +	bucket = FIELD_GET(AIROHA_PWM_GPIO_FLASH_SET_ID, val >> shift);
> > > > +	state->period = pc->buckets[bucket].period_ns;
> > > 
> > > Does .period_ns hold the requested or the actual period? You should
> > > return the latter.
> > 
> > Problem is that putting .period_ns here cause error in the PWM_DEBUG
> > validations. This is caused by the conversion error of the various / and
> > * done to convert tick to ns. Also on applying the configuration we
> > already do all the validation to make sure the request value is the
> > expected one.
> 
> Then there is a bug somewhere. I wouldn't completely rule out it's in
> the PWM_DEBUG logic, but my bet is on your driver then.
>  
> > For the initial values, there is airoha_pwm_fill_bucket that read the
> > current PWM values at boot and fill the buckets with the current values.
> > 
> > This is the compromise I found to handle both pre-configured bucket and
> > also handle the division errors in the ns - tick conversion.
> > 
> > Hope this is acceptable, do you have hint on better handling this?
> 
> I'd wait for the next iteration of your patch and then take a deeper
> look in the maths involved. It should be possible to make PWM_DEBUG
> happy and still report the actual configuration.
> 

Hi Uwe,

I just sent v12. While making more test I notice something interesting
where the duty was off-by-1 in get_state in the PWM_DEBUG scenario.

That caused the idemponent error, I found the cause so now get_state
actually return the real values instead of the local one in the bucket!

I address everything else, hope v12 is the one!

-- 
	Ansuel

