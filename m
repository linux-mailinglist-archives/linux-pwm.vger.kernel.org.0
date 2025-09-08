Return-Path: <linux-pwm+bounces-7261-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9946B498B3
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Sep 2025 20:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4BA4E2CD8
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Sep 2025 18:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890631C594;
	Mon,  8 Sep 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V89bI/C+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18731C57D;
	Mon,  8 Sep 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357326; cv=none; b=Dqe9mId4ytreE0mdIUh4GWxtzDs2d96C6OI4ClO3dos0HiM9lnnGsY3bR2X8WchFbr6iWox9YTzoh8LJ0gvAksxHezRBXe89BstIezgoVzWz9ogMYJFH8m7S+QKVDVlRnsMKqdwGmisVxQFyfzuIyVV7lUFqzqIyYQwONE4Oh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357326; c=relaxed/simple;
	bh=jZJKtwe4+fsS6RKHrvj+/VjDOrfQq4Wswh5Qzv8OmAw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXf8TadPD7bLHS8MkZdXDTRk0omvvf4tOXb8XIhz6SbFnzrXVm1J2JOwO/jwYKaR7pVJWKYkn+dwn0BLwdHRzkDirPzvT2vg68iuaBRsTCM3bhqs4WT66N0xnk5KyxpuiL6TBukJC3LzAYm4lRNy9iDze+xktBmNkszsxtohoqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V89bI/C+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45de2b517a3so16492645e9.3;
        Mon, 08 Sep 2025 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757357322; x=1757962122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dvz+5Xz8/A2Bwbne1Kgam2pwwdqdS2QtFpy2XB/cFFU=;
        b=V89bI/C+Lx7knPtjBvJCH0A6gLmFVvITY8fpZtTJDSeV2XOvFO0KQKHaO0t3/4EPFL
         1BrJtbfJeuYx73wx9uyIGNpHk/qCzM8faAi5oBWiaP+7Z2ykxYGg84AzGldg9LPjhlq3
         YDq79gqWEJVIL7SxqX3PYHj+4JzKTTAsFoCY52bn0FC7b/8VzFaZeSbXEcqPU3fdIqfa
         rrgkkqR+XguEkIC40b6xEoGEGkRVaKOZxxCtp4OYCfvi0Np4D4bRDiBTd62F2M5B94o/
         G3UavmUDZ/3jVfyC0crlDUn68IH9PS8RBUj4Z/HwCjkrPHqNngXgkRQzcV1QJI4H98sG
         I3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357322; x=1757962122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvz+5Xz8/A2Bwbne1Kgam2pwwdqdS2QtFpy2XB/cFFU=;
        b=CgoYUuo7LI2w0XzyZqzdRG4+5lEn5y+dSkVB0amyZKqY0QLtpDQYkdZKtmxiNSu847
         QP9eddRPL9ienZ5xFvCmxFuHi7sjfg6oXBoTfOYNKXObHMlkRqKiYnwK13vhKidvyaxf
         R20biZLb2tm03Rqx6jec1q5+Yn4kwcw544wylpRPJsihkKWukLHhFXhnREkf+5FaRSbV
         subbHLA8ww7t5qjAsJRB0JIoi+sainGy6gf9o4gRLMVQPftrrI4ztxBJNeuwHQ4FaO5P
         0ajBofs2R4N/oukfi1UOhXGxuS2+9TzuirDJT+UFn00QFAllTqeH+SXnY6RXhVl9H8Qc
         zdHw==
X-Forwarded-Encrypted: i=1; AJvYcCVLF+FkgUPQv2fIBmTLtqCXJUNG7Bq1Sqd1VdiZIzszL2nOsl3TSnQpB5afKtu49b0ziZfY8cjjZwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GtYstbg40ETrbbD93xwvPxOizpM3v+uxh/Ys96+9gw6eD6vX
	or7h6OpoXrqZPVBq8vSJHKSow/5huODMEoC5H3E0rbSwYRhZOZ6kXB8HPvhiAg==
X-Gm-Gg: ASbGncvbvEQtVnrx+FxK8h0YpDZaG2DwJrcBluMJ4YQrK9qX3JmzAqWsiK4yp3g9Y9C
	SAAQAB0WeS+WfepOc8TFKgq4WBD9lzAQ28EgsPFbRRPt7g2K3RZpOlw4pJYBWi9Qq2/1wL18cKA
	s1UJTKVuZ70Y1voMuYeTzgpsjJ+Zb4xcfxD+hJwFyYw54BOjxdoDD4hQahLz1DRwcDIeaYuy9q4
	9exXlI9NWaJrmb+TLxRjtV+ae+XgDSE69IuRMXb0HmtldFnpFaqo9hOh9C4HvXT2hGvH3yrtv60
	OrBT0Aar1j/ukBNteWj+L8GIN9VTMiyxtqZkEgNK0N8vJsr4yGPftzI31LrK026OMsn52+n7Y34
	R1G/obf7SWxP0y/iKVdDuuBLOHL4BHuzAL3NeutrzPVSEW2ihRSNoDlEHn6/dJE+ukbiEDw==
X-Google-Smtp-Source: AGHT+IFGy+QF4H2ZqGG74UzGkELPe9Oad43keJ6NxZmsbTC+VMGiv2FCEGjXUHnb2DO2+wHxe6DoIA==
X-Received: by 2002:a05:600c:c1c8:10b0:45d:ec9d:5fc3 with SMTP id 5b1f17b1804b1-45dec9d6013mr5588595e9.18.1757357322389;
        Mon, 08 Sep 2025 11:48:42 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb61377a7sm249864735e9.13.2025.09.08.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:48:41 -0700 (PDT)
Message-ID: <68bf2509.050a0220.702b3.c003@mx.google.com>
X-Google-Original-Message-ID: <aL8lBqn0easEvKPS@Ansuel-XPS.>
Date: Mon, 8 Sep 2025 20:48:38 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v23] pwm: airoha: Add support for EN7581 SoC
References: <20250708145053.798-1-ansuelsmth@gmail.com>
 <xsblhw36y3corxx3pxe6223auirrsqr3efovfnrm5lbo4xy3lf@wf3ytlivzv6g>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xsblhw36y3corxx3pxe6223auirrsqr3efovfnrm5lbo4xy3lf@wf3ytlivzv6g>

On Fri, Aug 01, 2025 at 11:15:41AM +0200, Uwe Kleine-König wrote:
> Hello Christian,
> 
> On Tue, Jul 08, 2025 at 04:50:52PM +0200, Christian Marangi wrote:
> > +static u32 airoha_pwm_get_period_ticks_from_ns(u32 period_ns)
> > +{
> > +	return period_ns / AIROHA_PWM_PERIOD_TICK_NS;
> > +}
> > +
> > +static u32 airoha_pwm_get_duty_ticks_from_ns(u32 period_ns, u32 duty_ns)
> > +{
> > +	return mul_u64_u32_div(duty_ns, AIROHA_PWM_DUTY_FULL, period_ns);
> > +}
> > +
> > [...]
> > +static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    const struct pwm_state *state)
> > +{
> > [...]
> > +	/*
> > +	 * Period goes at 4ns step, normalize it to check if we can
> 
> 4 ms or 4 ns?
>

4ms you are right

> > +	 * share a generator.
> > +	 */
> > +	period_ns = rounddown(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> > +
> > +	/* Convert ns to ticks */
> > +	period_ticks = airoha_pwm_get_period_ticks_from_ns(period_ns);
> 
> Rounding down to the next multiple of 4ns isn't needed for
> airoha_pwm_get_period_ticks_from_ns() which is just a division by
> AIROHA_PWM_PERIOD_TICK_NS.
> 

Ok will drop.

> > +	duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
> 
> As duty_ticks depends on the selected period_ticks, I think the bucket
> selection algorithm is still wrong.
> 
> Consider a request to implement
> 
> 	period_ns = 256 ms
> 	duty_ns = 128 ms
> 
> which at first correctly results in
> 
> 	period_ticks = 64
> 	duty_ticks = 127
> 
> If however all buckets are used and we only find one with say 62 period
> ticks we get period_ns = 248 and with that duty_ticks should better be
> 131 and not 127.
> 

Hi Uwe,

sorry for checking this only now and maybe we need to catch this again.

Maybe we are getting confused here but itsn't this already handled by
the upper condition?

		/* Ignore bucket with invalid configs */
		if (bucket_period_ticks > period_ticks ||
		    bucket_duty_ticks > duty_ticks)
			continue;

		/*
		 * Search for a bucket closer to the requested period/duty
		 * that has the maximal possible period that isn't bigger
		 * than the requested period. For that period pick the maximal
		 * duty cycle that isn't bigger than the requested duty_cycle.
		 */
		if (bucket_period_ticks > best_period_ticks ||
		    (bucket_period_ticks == best_period_ticks &&
		     bucket_duty_ticks > best_duty_ticks)) {
			best_period_ticks = bucket_period_ticks;
			best_duty_ticks = bucket_duty_ticks;
			best = i;
		}

We first limit for a bucket that doesn't got over both period and duty
and then we search for period and best duty. This should account for
never exceeding a duty since both period and duty are precalculated for
the current bucket and even if duty depends on period, again it's
precalculated. Am I missing something?

> > +
> > +	return airoha_pwm_config(pc, pwm, period_ticks, duty_ticks);
> > +}
> 
> Best regards
> Uwe



-- 
	Ansuel

