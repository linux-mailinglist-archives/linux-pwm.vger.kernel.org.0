Return-Path: <linux-pwm+bounces-6712-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B030AF7F8C
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 20:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2863848256C
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Jul 2025 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2022E8887;
	Thu,  3 Jul 2025 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBV1J61u"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CDE257440;
	Thu,  3 Jul 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566085; cv=none; b=lD9TuUY85PDDFB2dwOZ6W8uSE4AuafriPH1BcUGcmSkCmfl1sMUx0XXtUdApU13NQ8bj21SynOeKdaT6rBLGQQnNq5BNIlbCrIn3I0iRweGVk4njXpSEqxBUtSe+fI9ptnLd1Y2J5Tl6zi3eNVn2Ld7Sm67AX24J7MQbun0Yy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566085; c=relaxed/simple;
	bh=9bAuh6dWJdNdZ6d2BfBnvNZ6nPhKoTdR+nk5L+tyufg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek2+66NzWlWL9aOg85FY7sbiquKzd6FnkdzYCBxaniienZ5/K1tax/tSXdi7hb5ZmSYT1Hq2r1MVNhsWGc/Djlr1wnE9jDuQ8ZZ5Tg9wbhGyzwIAM1K6rWLABiAiNQXeF6gHAtf2FWv5O/UWP/hvQeuio+zY1IZxsy2X6av7rOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBV1J61u; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso44709f8f.2;
        Thu, 03 Jul 2025 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751566082; x=1752170882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1IiF0VA5p0YusEsyqW44/emZaG2dB9nyyMFB5VdiCkE=;
        b=SBV1J61u3eH323WOkIU0KQ8FAFCiYCZQ/dTy2Bl/AVqKyUfEib736KsR+fppi3qqeJ
         pONXhe0IzaBmMZKUq4MrZpYWuGgc1YPe6F9dmY7Pyt3K8lvYzR6bgekGtelWd8iqgPlH
         ghywmosUnLd33zhoHJ+dWWyVVaSE9uAQQVGW637E6Vif9fHMIINTI8cZnsxIMfJz6sk7
         w6WdLrLvaBL6oMm98tagz9ABsu6f15DZLvlWem2SDfv8Npj9q2r5Vd9T6NV159NjL7vi
         wle0zhsa7IIq16j2cYBuDwkYv84mwbC7/a1bQyf16yk1jacTKqFesoeWXeVHlFkOLDv2
         ywAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751566082; x=1752170882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IiF0VA5p0YusEsyqW44/emZaG2dB9nyyMFB5VdiCkE=;
        b=Yfamh/KRmQKVu+jzgOabu3WXX1jNA5pdDBm78WnkalJeJMaiSxnmAyfNzEhgswe4gP
         qjYVRoZjsQsHEvtOwhopfwJOAe959362ZYgJNlL+zwHWwN8gjXPYupHhfPd1Ss2d72kE
         mTDs1tCQ9pOiLuZnHKKpo7bynZ5Mi4x2BsiIdybcTzWYC+LW207qpxLziY8jPr+J1Miw
         fdCcxcZxbijKkzBIgh5eiMIQ73wIRN24Q7bWyCZKjE2/TDy/cFuA2bqnfoHokdBF+fpw
         vn8jGNMISveMG0f/b2xyqCzatucYx1Cvo4D61E6WN028EwDbknSuLHG6W5wEyYTqPVUv
         zp3w==
X-Forwarded-Encrypted: i=1; AJvYcCVEJKNrEZ1PPy7lWXOt2u/hH58iHcakp764+1BW/9MdO4fvNpngJu1WON8Zq746mJ0NEFFVKx8qC9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gVLXI9nRxLn8t5/fUw/4EHZjnVz5+qX6Xf/dpVZnVBadsv2i
	mNQjrk06/el9jpEKSZ2xlpcanKxZZorBKPrdKgYGuEZEn+JAvBk6v3MX
X-Gm-Gg: ASbGnct54QaKDdQMf0ZkEOt7GB2z6kRCEUEwgA2VJrvDphuXFNjg/eTX8OjMVsl4PZq
	AvtYZZncu+iHLy5YlDyprXBF/LZ1Cf66iwj9RTciwbFMy5C3sk1NQkpeUfHuwFDhcCPO52Uvo4H
	rEo+t6211kbGursTjHlLGjgTZpmWqxxrVLrd2EbopzLRuH+hGQ6YPBN2nDGBSLjfPWaA+CpPZOm
	RqnsGnWUxs8yKxWXileMDcaZlukb9q9Kif1Pr8fG7OgM5HK5+wt2i7RLbInOkOupOt4Z2eE37si
	kCagJUEFICpy7ULJWst33cap1nIySsduGAq4QcK/sbSYivy4m70iN++xrCLaHtUQGw9j6/2nvxw
	LJf/nT+DvorF5y2LRbgRNICRsirCVlhafHg==
X-Google-Smtp-Source: AGHT+IHPtpCI3kqVBSvghFQvo/CkKrax8KAwzVmFAG1q46Ldh8o2BsAP3fRlsHSTAVE8LD6WJRkjvQ==
X-Received: by 2002:a05:6000:4a0d:b0:3a0:b308:8427 with SMTP id ffacd0b85a97d-3b1ffbdf5c6mr6988500f8f.37.1751566081862;
        Thu, 03 Jul 2025 11:08:01 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-46-252-169.retail.telecomitalia.it. [79.46.252.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b9651dsm386691f8f.65.2025.07.03.11.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 11:08:01 -0700 (PDT)
Message-ID: <6866c701.5d0a0220.2823e.2772@mx.google.com>
X-Google-Original-Message-ID: <aGbG_ujOM-wOGNVl@Ansuel-XPS.>
Date: Thu, 3 Jul 2025 20:07:58 +0200
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
 <686434fb.050a0220.efc3e.909b@mx.google.com>
 <wntjec4p7nepuauucwqwgwcresphjikln7cqchep3vjocpuo6u@6hjpkwcbvx7d>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wntjec4p7nepuauucwqwgwcresphjikln7cqchep3vjocpuo6u@6hjpkwcbvx7d>

On Wed, Jul 02, 2025 at 08:01:05AM +0200, Uwe Kleine-König wrote:
> On Tue, Jul 01, 2025 at 09:20:24PM +0200, Christian Marangi wrote:
> > On Tue, Jul 01, 2025 at 09:40:03AM +0200, Uwe Kleine-König wrote:
> > > > +	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> > > > +
> > > > +	/* Configure frequency divisor */
> > > > +	mask = AIROHA_PWM_WAVE_GEN_CYCLE << shift;
> > > > +	val = FIELD_PREP(AIROHA_PWM_WAVE_GEN_CYCLE, period_ticks) << shift;
> > > > +	ret = regmap_update_bits(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset),
> > > > +				 mask, val);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	offset = bucket;
> > > > +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
> > > > +	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> > > > +
> > > > +	/* Configure duty cycle */
> > > > +	mask = AIROHA_PWM_GPIO_FLASH_PRD_HIGH << shift;
> > > > +	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, duty_ticks) << shift;
> > > > +	ret = regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > > > +				 mask, val);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	mask = AIROHA_PWM_GPIO_FLASH_PRD_LOW << shift;
> > > > +	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_LOW,
> > > > +			 AIROHA_PWM_DUTY_FULL - duty_ticks) << shift;
> > > > +	return regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > > > +				  mask, val);
> > > 
> > > Strange hardware, why do you have to configure both the high and the low
> > > relative duty? What happens if AIROHA_PWM_GPIO_FLASH_PRD_LOW +
> > > AIROHA_PWM_GPIO_FLASH_PRD_HIGH != AIROHA_PWM_DUTY_FULL?
> > 
> > From documentation it gets rejected and configured bucket doesn't work.
> 
> ok.
> 
> > > > [...]
> > > > +	/*
> > > > +	 * Duty is divided in 255 segment, normalize it to check if we
> > > > +	 * can share a generator.
> > > > +	 */
> > > > +	duty_ns = DIV_U64_ROUND_UP(duty_ns * AIROHA_PWM_DUTY_FULL,
> > > > +				   AIROHA_PWM_DUTY_FULL);
> > > 
> > > This looks bogus. This is just duty_ns = duty_ns, or what do I miss?
> > > Also duty_ns is an u32 and AIROHA_PWM_DUTY_FULL an int, so there is no
> > > need for a 64 bit division.
> > 
> > duty_ns * 255 goes beyond max u32.
> 
> In that case duty_ns * AIROHA_PWM_DUTY_FULL overflows to a smaller
> value. Just because the value then is used by DIV_U64_ROUND_UP doesn't
> fix the overflow. You need (u64)duty_ns * AIROHA_PWM_DUTY_FULL then.
> 
> > 225000000000.
> > 
> > Some revision ago it was asked to round also the duty_ns. And this is
> > really to round_up duty in 255 segment.
> 
> Yes, and I identified this as the code that intends to do that. Please
> double check this really works. I would claim you need:
> 
> 	duty_ns = DIV_ROUND_UP(duty_ns, AIROHA_PWM_DUTY_FULL) * AIROHA_PWM_DUTY_FULL;
> 
> here because no matter if you round up or down, dividing
> n * AIROHA_PWM_DUTY_FULL by AIROHA_PWM_DUTY_FULL yields n.
> 

Ok I made some test with a testing program to simulate various way to
normalize the value and yes you are right there is a problem here.

Also duty_ns = DIV_ROUND_UP(duty_ns, AIROHA_PWM_DUTY_FULL) *
AIROHA_PWM_DUTY_FULL; doesn't really fit here.

The solution I found is the following

DIV_U64_ROUND_UP(airoha_pwm_get_duty_ticks_from_ns(period, duty) * period, 255)

and airoha_pwm_get_duty_ticks_from_ns is (duty * 255 / period)

I also tested other viable way to reduce the redundant formula but the
main problem is that on big numbers (example when duty = period, too
many division error for integer division adds up (due to necessary
rounding) so we end up with not precise number that the tick actually
reflect or even goin beyond the period number (as duty must be <=
period)

But the thing is that since duty tick depends on period and now the
bucket base everything on the tick, I really feel normalizing duty is
not needed at all.

With the working normalize we would have 

duty_ns = DIV_U64_ROUND_UP(airoha_pwm_get_duty_ticks_from_ns(period, duty) * period, 255);

duty_tick = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns) 

With the normalization already done by
airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns).

What do you think?

-- 
	Ansuel

