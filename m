Return-Path: <linux-pwm+bounces-7273-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC74B4ACCB
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 13:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD673ADF28
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D658931B800;
	Tue,  9 Sep 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGTf8WQ5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEECE2D191F;
	Tue,  9 Sep 2025 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418495; cv=none; b=dAaZfGm+cSK/0svC08mydOqDLfWTi5p+b/vsfqIs0peEMYzu0IO/nXJRXaoNGd/O/Vrxpx11VMa2UbMiOnnH23J4EBDVkFUrPCScB7IfGza8FsMtBfcgPvauqVvvFylKW8QSwCT/sgF9b09FeIXyQFzmap9e0YKPh1Qvi80QhHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418495; c=relaxed/simple;
	bh=rzY8CzEoW8TQGVo2f3RbSObqhKYCgt3vL8BBFuth4Xk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWdO99u3WKbJcn7phITqRVXEadgG0bA3oCbf048xw2s7M9CtnWHbvmPAnInimL0f85eYsmI5/A/ysL4hVd0nfBIgX72L8I3rGP8ognLEmNzUF9MvkDlvV2seovfkqLKMmQV6vqAQUbQi0l4+XWD8mIh2c8L+39GKNfxiJOIdqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGTf8WQ5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so10605675e9.1;
        Tue, 09 Sep 2025 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757418492; x=1758023292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IR8QKQd+hRcWkBpmStwu2GuDN9GaRi4Uq2xIr3fN6FM=;
        b=YGTf8WQ5i5UcKpULLpjrtw1yQHFIAVhsHpGlSihV9JJTMqB/PEs75QsfFSZtkqF/jv
         QzBZoyPFv+XjMizNCPzpc2VSJ0nOoXA+C6GS5SOL7+rTjxIwBXHMLHMZ7dY0VpDgbxpO
         O6kMCU87sBKI2d6nfP2ZI5vEybWs/sU3JsiWQYs8PNfzG47c4IDJWShZ4d0Dv/XjBkOk
         KdKTeml9KhBCuxxqvmQPCltXKUw2hslOQ9zf2oZEXg/1RCUGMiKfObclhteRwqpfsZHd
         O6LRa9SGwR8+sfwtSFcUPksOUMmGhvrSUI1YHl4fu/bAQeMiSVyTzFvhgVnN5UW6aQ/N
         28pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757418492; x=1758023292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IR8QKQd+hRcWkBpmStwu2GuDN9GaRi4Uq2xIr3fN6FM=;
        b=RlvpeiANfvelo75UBuQUUto+KVor8w8qDK+liLwt/bA5aDTklpB6ETA2jswA20jgzo
         /AhDRhWRjq2a52FEIWLLgv/SBo+UgSwMtMtmNnY9haWFlkvIq0OxcmItgdw+RaJI+uEZ
         L1N3TaQ2tMxmjk22KCXEjJIgKJuBG4lVUMcdNShJQgiqlu7osW4Pq8ztFmBPkTeCQWWY
         U/A66bCQ6GS+8A/VqIkC49ZxeWU2IpzOLiMdZhOXhGaSPD5mDZzMqUMfIHJXKH/KpILa
         9EYnWJmDSiNhN3tKkdIg9n/iPbeNLhRmg0S08K5UVEz65mrpCkwCXkq5PLXdYyV/H7eW
         PeCg==
X-Forwarded-Encrypted: i=1; AJvYcCU91JxbP5kQ+SfOgAFcSjFGkRlH4o1pnxOVkrjIdXTjY0dMCFMVfKdLMdc0zLwYFkk/tyCrOyuQkG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNsRu8XyeziuFmCnpKv8nhLyMhBJtjtul5uFVZJD8/ez72ABac
	NQkhpaSBDxmrb7qLyZtUfYKUH7jhUepxZ7I+m9KlHKlqRq4VbJE49ECSZJeO3A==
X-Gm-Gg: ASbGncv77Df9CPBkdnu8cPuebhgQ+aFFy22W8HJvVVZgdNcKzPyQSRVtZORsK+GvZh4
	ssXMGIfXs5EAkML9z6YyaDN0u23Tn5e8XIudo7NbWwfyrmplpn7ZR2PK+zCmxNpewR3z8BZ6+zx
	c7z8/kSefp4A9H6TzpiktJbhcTx6mgmMzFdJV4tlfJpCFI/OVg7qh7iF25obeW7Z+wtYJZoYE/h
	l13QEnKUoNpzxsU530gnrd0S9bAKxXL+UtHbSS990uLjqIzwl3/F5ikyk8Mq0YVzk+zXiBjJx83
	TSXk5W6THgI7vj8C5Uw7/bL2KadIvE1DcUTEh1NvT/pIasfE+YhI3sRakQSPIQcNCWG/8t5faO8
	meM88W+Cxss3NK9j2XiZn9xRbcDz8ASDRZNR5f89X/Fe9dy+p2pKJSceLfDrD9bYJ9AM8pg==
X-Google-Smtp-Source: AGHT+IErkTYNY9jV0PCrvNvm3BbSSU+yIb0sK3PBf74+b6LIHNZZD8jvnENwq5obK4AplgrtbLe7Ww==
X-Received: by 2002:a05:600c:4f47:b0:45b:76c6:cfb8 with SMTP id 5b1f17b1804b1-45df2cb7c7dmr11809205e9.9.1757418491694;
        Tue, 09 Sep 2025 04:48:11 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb61377a7sm281429755e9.13.2025.09.09.04.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:48:11 -0700 (PDT)
Message-ID: <68c013fb.050a0220.702b3.6a13@mx.google.com>
X-Google-Original-Message-ID: <aMAT-V7EScktmfNp@Ansuel-XPS.>
Date: Tue, 9 Sep 2025 13:48:09 +0200
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
 <68bf2509.050a0220.702b3.c003@mx.google.com>
 <o32quqohph6xq73f65izjocjdhv2ri4dld4tcmmmtisa632ucq@lpz4ewja3xtd>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o32quqohph6xq73f65izjocjdhv2ri4dld4tcmmmtisa632ucq@lpz4ewja3xtd>

On Tue, Sep 09, 2025 at 12:26:48PM +0200, Uwe Kleine-König wrote:
> Hello Christian,
> 
> On Mon, Sep 08, 2025 at 08:48:38PM +0200, Christian Marangi wrote:
> > On Fri, Aug 01, 2025 at 11:15:41AM +0200, Uwe Kleine-König wrote:
> > > On Tue, Jul 08, 2025 at 04:50:52PM +0200, Christian Marangi wrote:
> > > > +	duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
> > > 
> > > As duty_ticks depends on the selected period_ticks, I think the bucket
> > > selection algorithm is still wrong.
> > > 
> > > Consider a request to implement
> > > 
> > > 	period_ns = 256 ms
> > > 	duty_ns = 128 ms
> > > 
> > > which at first correctly results in
> > > 
> > > 	period_ticks = 64
> > > 	duty_ticks = 127
> > > 
> > > If however all buckets are used and we only find one with say 62 period
> > > ticks we get period_ns = 248 and with that duty_ticks should better be
> > > 131 and not 127.
> >
> > sorry for checking this only now and maybe we need to catch this again.
> 
> no need to be sorry here. Taking time for replies is fine for me.
> 
> > Maybe we are getting confused here but itsn't this already handled by
> > the upper condition?
> > 
> > 		/* Ignore bucket with invalid configs */
> > 		if (bucket_period_ticks > period_ticks ||
> > 		    bucket_duty_ticks > duty_ticks)
> > 			continue;
> > 
> > 		/*
> > 		 * Search for a bucket closer to the requested period/duty
> > 		 * that has the maximal possible period that isn't bigger
> > 		 * than the requested period. For that period pick the maximal
> > 		 * duty cycle that isn't bigger than the requested duty_cycle.
> > 		 */
> > 		if (bucket_period_ticks > best_period_ticks ||
> > 		    (bucket_period_ticks == best_period_ticks &&
> > 		     bucket_duty_ticks > best_duty_ticks)) {
> > 			best_period_ticks = bucket_period_ticks;
> > 			best_duty_ticks = bucket_duty_ticks;
> > 			best = i;
> > 		}
> > 
> > We first limit for a bucket that doesn't got over both period and duty
> > and then we search for period and best duty. This should account for
> > never exceeding a duty since both period and duty are precalculated for
> > the current bucket and even if duty depends on period, again it's
> > precalculated. Am I missing something?
> 
> Let me describe the issue in more detail:
> 
> The period length is configured in the AIROHA_PWM_WAVE_GEN_CYCLE
> register in multiples of 4 ms. The duty length is configured in the
> AIROHA_PWM_GPIO_FLASH_PRD_HIGH register in multiples of
> $period_length/255.
> 
> So if you calcultate the number of multiples you need for duty_ns = 128
> ms based on the assumption that period_ns = 256 ms the result becomes
> wrong when you are forced to switch to period_ns = 248.
> 
> So to implement a request for period = 256 ms (64 ticks) and duty_cycle
> = 128 ms (127.5 duty ticks) having the choice between the two buckets:
> 
>  a) period_ticks = 62; duty_ticks = 127
>     (period = 248 ms, duty_cycle = 123.51372549019608 ms)
>  b) period_ticks = 62; duty_ticks = 131
>     (period = 248 ms, duty_cycle = 127.40392156862744 ms)
> 
> b) is the better one despite 127 duty_ticks would be an exact match for
> period_ticks = 64. So the issue is that the "Ignore bucket with invalid
> configs" kicks out b). That's wrong because
> 
> 	bucket_duty_ticks > duty_ticks
> 
> doesn't imply
> 
> 	bucket_duty > duty
> 
> .
> 

Thanks for the quick feedback hope we can takle this quick so we can
have this finally merged.

I changed the logic to this. What do you think? (I introduced an helper
to calculate the ns from raw ticks)

	duty_ns = airoha_pwm_get_duty_ns_from_ticks(period_ticks, duty_ticks);

...

		/* Ignore bucket with invalid period */
		if (bucket_period_ticks > period_ticks)
			continue;

		/*
		 * Search for a bucket closer to the requested period
		 * that has the maximal possible period that isn't bigger
		 * than the requested period. For that period pick the maximal
		 * duty cycle that isn't bigger than the requested duty_cycle.
		 */
		if (bucket_period_ticks >= best_period_ticks) {
			bucket_duty_ns = airoha_pwm_get_duty_ns_from_ticks(bucket_period_ticks,
									   bucket_duty_ticks);

			/* Skip bucket that goes over the requested duty */
			if (bucket_duty_ns > duty_ns)
				continue;

			if (bucket_duty_ns > best_duty_ns) {
				best_period_ticks = bucket_period_ticks;
				best_duty_ns = bucket_duty_ns;
				best = i;
			}
		}

We first search the period and then we calculate the duty in NS and
calculate the duty for each bucket. Should comply with the fact that
duty depends on period right?

-- 
	Ansuel

