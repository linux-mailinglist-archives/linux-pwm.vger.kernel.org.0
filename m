Return-Path: <linux-pwm+bounces-6543-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92449AEB2FF
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 11:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6354C188AA18
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A8293468;
	Fri, 27 Jun 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7iMoMGX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2526C393;
	Fri, 27 Jun 2025 09:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016776; cv=none; b=rbC7gNPEQ51S3xWKyX/fMZ3ayUbuWXyD6Nbb08qQfWUtB8XdXcx5EkI2a1ZiZETAJmHm90OSV8+mlKOYmWWyow6l/bH6RCamYUpEobjXFUMuiyZsw3QfSwJMds+tYvGyjj3ccuDfYhGHo5yZcFM8jerZjMrayYdKDXtIAv3INmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016776; c=relaxed/simple;
	bh=KAPbXDbsTbRtLUSJtRih+t68mrh+mORwKv96JxsrrGs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNwwO3Qksn3MC8UjdbX2yoYDpTWBlYlNKxtTj2qkXGDignSFu9/Qc77qpBj4SR7Y8dVhjueJEW8+DhGKoLHsjHHGeOtHxMNgLxorlu135sW1LnCgnSgXI1a1yWc8VG7ggLjvEplLyWCqVNtgrv6DwMhs3zYXVNjvz7fQWabB3FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7iMoMGX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a54700a46eso993339f8f.1;
        Fri, 27 Jun 2025 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751016773; x=1751621573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHGbcG/vcFnWjGIjJ/Lfayx844s2gblNTlygOV5e6rY=;
        b=h7iMoMGXH8vHhKmy8V864Pd/ms7+l9E5Y7jAQL/R+2lfZta+25LHmEilbgJOjIIlJ/
         qEUr6NBhetyIkKQuDeGcA7Rv68xMSOKY6oqv0yofZJXxSGUXkOeVua2Sa+7H3I6ht+yG
         dukZJ+jeXahMriQFxL/TFnUghSScdsrmbjE79O74TR9ERZl2xq+/Mw7xhriVGonydw99
         9viLjROUHXdzVQcagBpfajOJDGks2QhCuhaeprss4nnHQDU83Wl2GTy0TvqxLDWlO4rx
         KM4seAPTwbWtgluGYxQv/UWsMRC1tOdi9ceGf7BxmIWuN7juoZ1948koVwQiktNdO4QW
         +VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751016773; x=1751621573;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHGbcG/vcFnWjGIjJ/Lfayx844s2gblNTlygOV5e6rY=;
        b=v1BfuM3/xCAeN4iqjbCJszqrgri1p9fUBJR3bi9FQz0ugZOUKT+ndFsfXF+Qr7jj/u
         cVrH7Cn19+s8ENC5BKFC1NNWUus0DizAjkgUuRkKeSWzz69lei+sOxo+mfm0tgdxdJGX
         Lo7TLon0o/Bz5IEt2mkIDtgtx7AJrhb44SpL9VL16yj8i2zwnbVx6V5tUCu/mFwv8f/E
         RBkVeuwJxxqYLLApUsoLLfBloO6aNcivktM6jTFuy1/gi0/MZWnhMGTYekFev87HxXO1
         p5mQghUWJjyeY5XYLwUFgDkdKvlpnuC8i7CV4OgS5Qy8Svc/PbyOnwyc5DxwKL6BwsEK
         4ZaA==
X-Forwarded-Encrypted: i=1; AJvYcCVsh78P7T+f7I0rqRD6O5vJoGSGgVmnM2kHLqepy7ZJQd0dVIa6J/6M2ldR8pDp9ufdEBA8luKwowsQ@vger.kernel.org, AJvYcCWBJ5wBqtrANvPEi7PaLVJyrVmAfHTsLBEnCB9fMUvyBW83UCPFT6gmhHXMXpdGLoVZfUIFOBDD8ijEm7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HbB1DY27Sg1XpgiPqqaEYdpZLHLwNQcBKbzzTG4vUsmzoUDq
	tILUk/dmiWT2X6HyimQ2T6JsA38rDO8OCrFRYNBaKTsnfP06x5xr9RcfLfbmfg==
X-Gm-Gg: ASbGnctZBbpzIi3xQDitZLGMzPbMeDltAcv77N7Qf95C+PyPLOMPekkg/Gm/2s3sl8R
	z5whWtNv66I0EfMW6OHejawX69JAuol0qUH6JE4DufNN3WPLUucWUs3pz41LtR/MsXFpemIVLWo
	Mp6nb3GWlavuU6RBQ2jSdCz6Txqr+fO2Tj1odBSXZiLq3JbqWBapzFR27UWqsfybP9iddxDekPr
	W9x5bEuW2ckGAGB5rMcUqC9z9SL5KVRezmQpaffZcuDa/XadWksyAzoN9cNGMNfbjGuW82hEzsu
	clSpTyXcasREKCEjXCazDRWPIPfOXPi+hlN2YiXfUt+45NHdMAwwo8Pfsh3Xj1ILVGJUsdpfz5c
	w2nE59u1GUlNkdCYssQ==
X-Google-Smtp-Source: AGHT+IHtGgW2tRSVkf3orsf3VAHLArXb++bdK4XS57AUO5KdAImNO+BadOSsFZILC8CvPR+AeW8olQ==
X-Received: by 2002:a5d:5f92:0:b0:3a5:39d8:57e4 with SMTP id ffacd0b85a97d-3a9002968a3mr2333232f8f.41.1751016772461;
        Fri, 27 Jun 2025 02:32:52 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e528a9sm2215225f8f.60.2025.06.27.02.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:32:52 -0700 (PDT)
Message-ID: <685e6544.5d0a0220.20cf55.9440@mx.google.com>
X-Google-Original-Message-ID: <aF5lPh3XoJLFC1sf@Ansuel-XPS.>
Date: Fri, 27 Jun 2025 11:32:46 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v18] pwm: airoha: Add support for EN7581 SoC
References: <20250626224805.9034-1-ansuelsmth@gmail.com>
 <aF5dHDr8yDSKlp5j@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF5dHDr8yDSKlp5j@smile.fi.intel.com>

On Fri, Jun 27, 2025 at 11:58:04AM +0300, Andy Shevchenko wrote:
> On Fri, Jun 27, 2025 at 12:47:53AM +0200, Christian Marangi wrote:
> > From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > 
> > Introduce driver for PWM module available on EN7581 SoC.
> 
> ...
> 
> > + * Copyright 2025 Markus Gothe <markus.gothe@genexis.eu>
> > + *		  Christian Marangi <ansuelsmth@gmail.com>
> 
> I'm not sure you can change the copyright line like this. I would rather expect
> 
>  * Copyright 2012 Markus Gothe <markus.gothe@genexis.eu>
>  * Copyright 2025 Christian Marangi <ansuelsmth@gmail.com>
> 
> (Sorry, I forgot the exact original year there, but you got the point)
> 
> ...
> 
> > +	/* Global mutex to protect bucket used refcount_t */
> > +	struct mutex mutex;
> 
> This makes a little sense. Either you use refcount_t (which is atomic) or
> use mutex + regular variable.
>

Using a regular variable I lose all the benefits of refcount_t with
underflow and other checks. 

> ...
> 
> > +	/*
> > +	 * It is necessary to explicitly shift out all zeros after muxing
> > +	 * to initialize the shift register before enabling PWM
> > +	 * mode because in PWM mode SIPO will not start shifting until
> > +	 * it needs to output a non-zero value (bit 31 of led_data
> > +	 * indicates shifting in progress and it must return to zero
> > +	 * before led_data can be written or PWM mode can be set)
> 
> Missing period at the end.
> 
> > +	 */
> 
> ...
> 
> > +static void airoha_pwm_disable(struct airoha_pwm *pc, struct pwm_device *pwm)
> > +{
> > +	/* Disable PWM and release the bucket */
> > +	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
> > +	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
> > +
> > +	clear_bit(pwm->hwpwm, pc->initialized);
> > +
> > +	/* If no SIPO is used, disable the shift register chip */
> > +	if (find_next_bit(pc->initialized, AIROHA_PWM_MAX_CHANNELS,
> > +			  AIROHA_PWM_NUM_GPIO) >= AIROHA_PWM_NUM_GPIO)
> 
> This can be rewritten as
> 
> 	if (!bitmap_read(pc->initialized, AIROHA_PWM_NUM_GPIO, AIROHA_PWM_NUM_SIPO))
> 
> (seems to me that the above code is buggy and has to have a check against the
>  full size of bitmap).
> 

Yes I'm confused by find_next_bit. Is the nbits part the rest of the bit
or the full size of the bitmap?

Google suggest it should be the full size of the bitmap but I wasn't so
sure. Anyway I will use bitmap_read since it seems more readable.

> > +		regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> > +				  AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
	Ansuel

