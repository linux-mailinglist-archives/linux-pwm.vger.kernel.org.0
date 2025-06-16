Return-Path: <linux-pwm+bounces-6387-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCEBADBB15
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 22:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605E4175272
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F0D288C86;
	Mon, 16 Jun 2025 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyqEOfoS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761E28982C;
	Mon, 16 Jun 2025 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105467; cv=none; b=PwO+fXYkss2pfAzAU76fGkHWwWIYvY96FovKxAN3UJOUBsle0W5iLXEMOqBUaw8aG8+DXFFVAadW+hJz//QeiIJmdZJgc3y0gCcvbV95942XyYkH3CL6B4loIyjj8rRJk65yLFGfAkMntKZMmZ7m8P3gJTGtkLBK5KLRumXm2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105467; c=relaxed/simple;
	bh=6Esc4J8to219dcsAtOCleQr442ZHStZ5bocuqNWPKFw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/yeBCWemYmaFNmFkDgWIlRIe6nhOzWv9n/Lhqj8s7obsH+7c0fAYWqrf5BcQ8I2R8jnzoPi+ZOpjvU2m9uvr4aAz9EwQd7NA4WkvrSjFR7i0x3Fvdwna7bGgZM8mMCjPKsvsCDhLKKquvx5FUIANZUEqr3/dvt3Fk9zdyFgmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyqEOfoS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so28983555e9.1;
        Mon, 16 Jun 2025 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750105464; x=1750710264; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=scR+ZU84kS64gXrNnn2CNbIE67dh7vB7vmOSGXS1BSk=;
        b=PyqEOfoS2NltPYaDgwzBGVLPRYqlfpHghRmmXccFony5t1IGh//6MlgylQlAl4GTN0
         j6j59AlbZGtvccncujEspa5ofDKT2gwcE2WM3SQGsF+AfHumhzQHF48/VUrLBBfMXHo7
         QKJV9b0Rw15AwP+KSTyfb53udwENlfhKXmgnaS6ga4XHaqziHPwlwr35Sn0zQRSalSnB
         WkQmVjaJz0PWfkAoSUb2uAMiLo/nrRSC3U8JkfDXWZkKF9NUhhp9eS1xG7crhYmDk2Zv
         vblie7pVec/0JUfIylIwy+z2Aaj7nHdjo7C1sPG3Cf3uVZTEZGQUCdMwTL4IYODjnQDI
         uoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105464; x=1750710264;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scR+ZU84kS64gXrNnn2CNbIE67dh7vB7vmOSGXS1BSk=;
        b=MptxXHoAhhG9mL46qc7zKPT446LnwT3sfFLBm3BJhVl9mjjvZaTmFXx2RBVf7XsKVg
         FFUyGtDwY/LdsfbemSe36LekCXOwpcB9sMMzRmpiO478IRI98Ab8mK3beynZyR++5piq
         BiNw30gaIJVeOg4rh51R2/xYseH118lTaG9W0Aiyt5PurVTq2Ruz3bTrVZq4V7mSfvjI
         akRN9HH7UNM0kWxemyt9it566FvE/OfLg/Wwask5pzf5uwb4aXpJOVIUumrV/HMGaeKf
         qFgi5XbOTPEASeOgK1H7qdmyTtfbE8t/6MpQJpfKfLZKhacpBRvtp2eaReCnvhZXFkxQ
         DRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxiYPVBP5pKOcd8jmiocUR4NvEA7fI0FGSzrVjJRTz2TVoYZbffyviCuEXgJ8BzG4PjuXrJFVgy10=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+maSOYMKnFDLKy+GjFwvZU7STd0b3L8w+gQj67Wtw3Av5Z4M
	AxOxx46BDgu2RD2pa1+8zh6JtiI6tsGinnh9+ByewKVNCewqhxrARmRA
X-Gm-Gg: ASbGncsagf1wQmuXGPxttgWbs38aZEcaKIGjLWmCYUrQbzXT5xaPhkFT9RPkvEB2x6S
	kjw25q6pXvXF00X3LaPL8tIFed9VO6HgBged87wfKMYyXxEvkO8paEsmqroTg1uI0krBaGamTrR
	XLSw25MQNuSTcfCGOSJSj4jflyEOOs4SJhIlR2evunAJE24n7HEW6l0za2lCAoUQVT/L5oinvpu
	oEDC79H/Qowj28DMZiXQtYsfkOABSsLrrRS5fnLXb2HabPt6e9m+GoFi9kcFGmaxRqlNaF7KQ68
	QRQftww5J/uAlJ4qup7fsjZmdYV9vyOyg1QfyfHB4kpdHRlkvZXknPAYSlHgKR/8q5siWjtr91x
	AroUOBixm78wk5QLwaCxLR4Ki0auJ
X-Google-Smtp-Source: AGHT+IH+yIXOH+LoOgdTx+ADk1QaxIb1PBt53HMHmGhWR7P8CLDDkITIcgD2IwB1H2HEiVceNsgL2A==
X-Received: by 2002:a05:600c:8b38:b0:450:cd25:e69c with SMTP id 5b1f17b1804b1-4533caa67c9mr81436855e9.21.1750105463791;
        Mon, 16 Jun 2025 13:24:23 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b5bfefsm11681968f8f.88.2025.06.16.13.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 13:24:23 -0700 (PDT)
Message-ID: <68507d77.050a0220.3cdb49.76dc@mx.google.com>
X-Google-Original-Message-ID: <aFB9drVh4dB7FEjg@Ansuel-XPS.>
Date: Mon, 16 Jun 2025 22:24:22 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v13] pwm: airoha: Add support for EN7581 SoC
References: <20250509223653.8800-1-ansuelsmth@gmail.com>
 <ndntz3ttiosqmduyg5lur6m2rdsg7zbiyrkxjhzknml5bprd4r@76wu76ddp4uj>
 <68416753.050a0220.1b2d45.505c@mx.google.com>
 <2nm7l3dsrg3xdzc3zrwfdvcmkiphfxils6yp6njvngvkzmedjd@bxgn2erlp7k4>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2nm7l3dsrg3xdzc3zrwfdvcmkiphfxils6yp6njvngvkzmedjd@bxgn2erlp7k4>

On Fri, Jun 06, 2025 at 08:33:36AM +0200, Uwe Kleine-König wrote:
> Hello Christian,
> 
> On Thu, Jun 05, 2025 at 11:45:52AM +0200, Christian Marangi wrote:
> > On Tue, Jun 03, 2025 at 06:57:36PM +0200, Uwe Kleine-König wrote:
> > > [....]
> > > It took me a while to come up with that, and it's completely untested.
> > >
> > 
> > Mhhh it looks quite confusing. Also just to understand and looking at
> > the PWM core, we should search for the bucket that is both closer to the
> > requested duty and the requested period correct? In v12 I was with the
> > idea that only period had to be closer.
> 
> The objective is as follows:
> 
> Pick the maximal possible period that isn't bigger than the requested
> period. For that period pick the maximal duty_cycle that isn't bigger
> than the requested duty_cycle. (For the waveform callbacks the algorithm
> is slightly different.)
> 
> > Anyway do you think this alternative version can work? I applied a more
> > simple logic.
> > 
> > static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
> > 				    u64 period_ns)
> > {
> > 	unsigned long best_bucket_diff = ULONG_MAX;
> > 	int i, best = -ENOENT, unused = -ENOENT;
> > 
> > 	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {
> > 		struct airoha_pwm_bucket *bucket = &pc->buckets[i];
> > 		unsigned long duty_diff, period_diff, bucket_diff;
> > 		u64 bucket_period_ns = bucket->period_ns;
> > 		u64 bucket_duty_ns = bucket->duty_ns;
> > 		u32 duty_ticks, duty_ticks_bucket;
> > 
> > 		/* If found, save an unused bucket to return it later */
> > 		if (!bucket->used && unused == -ENOENT) {
> 
> You should drop the check for `unused == -ENOENT` here as with
> !bucket->used bucket_period_ns and bucket_duty_ns are not values that
> you should work with.
>

The unused == -ENOENT was there as without it we will always use the
last unused bucket instead of stopping at the first. Doesn't change
anything tho just taste. But you are probably right about the wrong
values.

> > 			unused = i;
> > 			continue;
> > 		}
> > 
> > 		/* We found a matching bucket, exit early */
> > 		if (duty_ns == bucket_duty_ns &&
> > 		    period_ns == bucket_period_ns)
> > 		    	return i;
> > 
> > 		/*
> > 		 * Unlike duty cycle zero, which can be handled by
> > 		 * disabling PWM, a generator is needed for full duty
> > 		 * cycle but it can be reused regardless of period
> > 		 */
> > 		duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
> > 		duty_ticks_bucket = airoha_pwm_get_duty_ticks_from_ns(bucket_period_ns,
> > 								      bucket_duty_ns);
> > 		if (duty_ticks == AIROHA_PWM_DUTY_FULL &&
> > 		    duty_ticks_bucket == AIROHA_PWM_DUTY_FULL)
> > 			return i;
> > 
> > 		/*
> > 		 * With an unused bucket available, skip searching for
> > 		 * a bucket to recycle (closer to the requested period/duty)
> > 		 */
> > 		if (unused != -ENOENT)
> > 			continue;
> > 
> > 		/* Ignore bucket with invalid configs */
> > 		if (bucket_period_ns > period_ns ||
> > 		    bucket_duty_ns > duty_ns)
> > 			continue;
> > 
> > 		/*
> > 		 * Search for a bucket closer to the requested period/duty
> > 		 * following this logic:
> > 		 *  1. Calculate the bucket period diff from the requested period
> > 		 *  2. Calculate the duty period diff from the requested duty
> > 		 *  3. Sum the 2 diff
> > 		 *  4. Search for the bucket that have the minor diff across all
> > 		 *     buckets.
> > 		 */
> > 		period_diff = period_ns - bucket_period_ns;
> > 		duty_diff = duty_ns - bucket_duty_ns;
> > 		bucket_diff = period_diff + duty_diff;
> > 
> > 		/* Save the best found bucket as we test each one */
> > 		if (bucket_diff < best_bucket_diff) {
> > 			best_bucket_diff = bucket_diff;
> > 			best = i;
> > 		}
> > 	}
> 
> This is the wrong metric. If the request has period = 1000 and
> duty_cycle = 500 the possibility
> 
> 	period = 999
> 	duty_cycle = 1
> 
> is considered preferable to
> 
> 	period = 998
> 	duty_cycle = 500
> 
> (strange as this might seem). But the condition I used can indeed be
> simplified to
> 
> 	if (bucket_period_ns > pc->buckets[best].period_ns ||
> 	    (bucket_period_ns == pc->buckets[best].period_ns &&
> 	     bucket_duty_ns > pc->buckets[best].duty_ns)
> 		best = i;
> 
> as we already know that bucket_period_ns <= period_ns and
> bucket_duty_ns <= duty_ns.
> 

I just sent v14 with a variant of this. I tested it and seems to work
correctly.

> > > > +static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
> > > > +					u64 duty_ns, u64 period_ns,
> > > > +					unsigned int hwpwm)
> > > > +{
> > > > +	int bucket;
> > > > +
> > > > +	/*
> > > > +	 * Search for a bucket that already satisfy duty and period
> > > > +	 * or an unused one.
> > > > +	 * If not found, -ENOENT is returned.
> > > > +	 */
> > > > +	bucket = airoha_pwm_get_generator(pc, duty_ns, period_ns);
> > > > +	if (bucket < 0)
> > > > +		return bucket;
> > > > +
> > > > +	airoha_pwm_release_bucket_config(pc, hwpwm);
> > > > +	pc->buckets[bucket].used |= BIT_ULL(hwpwm);
> > > > +	pc->buckets[bucket].period_ns = period_ns;
> > > > +	pc->buckets[bucket].duty_ns = duty_ns;
> > > 
> > > pc->buckets[bucket].period_ns and pc->buckets[bucket].duty_ns should
> > > only get assigned if pc->buckets[bucket].used == 0.
> > > 
> > 
> > Yesp micro optimization but I changed the logic.
> 
> No, that's not a micro optimisation. If you reuse a bucket you're not
> supposed to change the configuration of another output.
> 

You are right. It all worked with the assumption that we always had
consistent duty and period but it's fragile. Better safe than sorry.

> > > > +	/*
> > > > +	 * Period goes at 4ns step, normalize it to check if we can
> > > > +	 * share a generator.
> > > > +	 */
> > > > +	period_ns = rounddown(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> > > 
> > > Do the same for duty_ns?
> > > 
> > 
> > Duty is in % so we really can't round it. Am I wrong?
> 
> Well, in airoha_pwm_config you do:
> 
> 	if (duty_ns == bucket_duty_ns &&
> 	    period_ns == bucket_period_ns)
> 		return i;
> 
> so better make sure that duty_ns is a value that can be realized.
> 

In v14 I applied a normalization also for duty. Wrong value for duty can
be used that would stop from reusing a bucket so yes it's required.

Hope v14 is THE ONE :D and thanks a lot for the feedback/review.

-- 
	Ansuel

