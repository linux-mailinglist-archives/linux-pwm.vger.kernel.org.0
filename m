Return-Path: <linux-pwm+bounces-6539-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C1AEAA15
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 00:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EBB178546
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Jun 2025 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38F1917FB;
	Thu, 26 Jun 2025 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByFdqm0q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9EF15990C;
	Thu, 26 Jun 2025 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750978335; cv=none; b=qo6JncK+0DCvxuSWFzMQvLh2QGT8sDhty4JaldGNX5JEAEWkIOV9bsKSNrSV1YS/3izC+Z3TRbHjtf3t/RNwQGxomQY8sueXgumYjT/XoymIF3nZG+ehIKBfw/v8p0PJjgcLqjm8k9e10ggLnac2L2Q+Ekkur8Gb/Mr3Eoy9ktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750978335; c=relaxed/simple;
	bh=TJN2uUYZsGtZlOHAF1x+jhPjonJYJ6oMh2gKoPSGSOI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4Ra+qFdDenHuVL9gg9eHUNzu1xnJnHvVQXvFlvuyfvmnc1qY0VO6UC2zb02z7ugSAQbE2nVIjahzSXhskwiU79VeZrxnv4Ws/peBCdhm4rl9Q1K9AFfrwlnF55jkBUi5q7In+Zq78Bc0WfGti1eugl0vPZGiq8KvjdxdYToFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByFdqm0q; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso911471f8f.2;
        Thu, 26 Jun 2025 15:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750978332; x=1751583132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G9vH3pbRWo1e8T8OQBvwE9+gUTs8uHLsma3D0Hah9OI=;
        b=ByFdqm0qj9muQQF3NxmJ99iM3Ci4WGCPUPBL72qUyVzAHGSrR5RODT8mb5a690Z+uR
         MkhW6ZMPiRVz1zoZq0T1ywn74Qtjj+aK2g6v5shedOakP6d/ZpawABCV111tGUMe41FC
         7BupQSnvQDpk3L9toE5uB+nlAJCPPetIZ8fAafSHmvSCZ1flDopmMd7VzN/pgzumDMB8
         NAFsS+FblKFOMEeNRoTUzExkyF/SPQ+h+r4OZaq3tqm/1P1JZY00YSJmPvVMgZwgNT7A
         A1FXak9NbAq4kBSdqRKCGlTV9KwADvchIVrA6c/uh86wzVdZEZvWmqvsVuRtBaZiE34S
         Zu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750978332; x=1751583132;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9vH3pbRWo1e8T8OQBvwE9+gUTs8uHLsma3D0Hah9OI=;
        b=OC21DWwnVD5+iM84i/MxGnkN3afP3MPETfqK+FCgfWMnZDbpQN8LZYTMldJEytXNaB
         Sat26mtlGcVS1p4hIhlzlvc1Qd1cBRlChI/jE4UwXZ57d7zPWZW3Wi+HpbtfF2C01pse
         Mc3teIU03SvJs9W5vfco++HRTvSgijf6kwgtR3QH5NlRHrBeJfR80MGYF8RBmygaDcq+
         XrV6HcNn10eZxa55zEmOIi/N/ufFVqAbsIoKFSIG5ihvLwEOrpkxVMGdq/K0I6Kj1ism
         KFeg1b0Pd1Ri7ARLx89CRmlQapthjpGUJHzKm3bqrnSrJvzJOTcqAchES+aZcIpVntgF
         WVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWDF8//Zstz1+mAJkxULEAdYX5VAH40Ln1SxxhFYheQwQ9IaPtZxnK34hH7Nt2XqNg56SJyfzWBVWrFfQ=@vger.kernel.org, AJvYcCUb9pJ+/pEjqgLCnEh7U/zJMpf6Bdz18OkfE4Bc3QZVyMEcyLgOGZpY7qxwac6pVxT20UmZSsJPAZWV@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQxFd46iJKL0JZWkQXpFIWGoBgLUF8vimu4DXfYUs+6wzxpfp
	JYpmKqYbSQMkARtmIakflLwAVlUVzQg2i8e2d+NqVquR1c93JPIfzFfO0i1C0g==
X-Gm-Gg: ASbGncuTtZwsgnZi6W+L/cDZDs6Igihxc0fpbHYHP1ki2+Pto9Upy5zilwQLK+xpKWO
	Su7Ma9VsfWowFfNidgYLiZVdcEwvfBmrd56WwjznGfZPPsz+altqpAHWZTHpmtR8aATrV8yo+z0
	p3/9vHgjv6Mn6H3vymGPfpfhy9CTxxZhGU53UjfvQPgHAY6/9bbe9xPG+Z78g8Vud48RXc1XzUZ
	eCuU3eVgWop7OmfWid+2lPovn+SMF8nU3UJIbyMJJOHCcmYRgASO1jUU0pArXDsiEn4J1pS9oD4
	834ibce8zeyVrwTVHU06NRsedpwKxK5ZNo4g5xA7JrUEcm2WOwpHJZWtdXMDKD0nh+wrZSWXLMb
	OzqUUuTyBCLPbcrhT0g==
X-Google-Smtp-Source: AGHT+IHWyEGZ4A45qkOel41aLyBzrADFdKfGnHIYKpc9pXrPf+xMteLOX+g/yXe2aTvJlXAyWIy+Bw==
X-Received: by 2002:a05:6000:4011:b0:3a4:dd8e:e16b with SMTP id ffacd0b85a97d-3a8fe2d3c47mr993436f8f.20.1750978331468;
        Thu, 26 Jun 2025 15:52:11 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b5aesm1017410f8f.44.2025.06.26.15.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:52:11 -0700 (PDT)
Message-ID: <685dcf1b.050a0220.2cbe17.6342@mx.google.com>
X-Google-Original-Message-ID: <aF3PFinMls5kVasA@Ansuel-XPS.>
Date: Fri, 27 Jun 2025 00:52:06 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v17] pwm: airoha: Add support for EN7581 SoC
References: <20250625194919.94214-1-ansuelsmth@gmail.com>
 <aF1RIVzVNcdsU1DB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF1RIVzVNcdsU1DB@smile.fi.intel.com>

On Thu, Jun 26, 2025 at 04:54:41PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 25, 2025 at 09:49:01PM +0200, Christian Marangi wrote:
> > From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > 
> > Introduce driver for PWM module available on EN7581 SoC.
> 
> Almost from my perspective.
> If you address the below as suggested, feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ...
> 
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
> 
> On my calendar 2025 is. Also MODULE_AUTHOR() list disagrees with this
> (you should add yourself somewhere here).
> 
> > + *  Limitations:
> > + *  - Only 8 concurrent waveform generators are available for 8 combinations of
> > + *    duty_cycle and period. Waveform generators are shared between 16 GPIO
> > + *    pins and 17 SIPO GPIO pins.
> > + *  - Supports only normal polarity.
> > + *  - On configuration the currently running period is completed.
> > + *  - Minimum supported period is 4ms
> > + *  - Maximum supported period is 1s
> > + */
> 
> ...
> 
> > +#define AIROHA_PWM_SGPIO_CLK_DIVR_32		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x3)
> > +#define AIROHA_PWM_SGPIO_CLK_DIVR_16		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x2)
> > +#define AIROHA_PWM_SGPIO_CLK_DIVR_8		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x1)
> > +#define AIROHA_PWM_SGPIO_CLK_DIVR_4		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x0)
> 
> Remove 0x:s, they are just noise and moreover the list here is plain numbers,
> not bit combinations or so. In such cases we use decimal numbers.
> 
> ...
> 
> > +/* Cycle cfg handles 4 generators in one register */
> 
> I am a bit lost in the meaning of "cycle cfg". Can you elaborate in
> the comment that it's readable in plain English?
> 
> > +#define AIROHA_PWM_BUCKET_PER_CYCLE_CFG		4
> 
> ...
> 
> > +static u32 airoha_pwm_get_duty_ticks_from_ns(u32 period_ns, u32 duty_ns)
> > +{
> > +	return mul_u64_u32_div(duty_ns, AIROHA_PWM_DUTY_FULL,
> > +			       period_ns);
> 
> It's less than 80 if put on one line!
> 
> > +}
> 
> ...
> 
> > +static int airoha_pwm_get_bucket(struct airoha_pwm *pc, int bucket,
> > +				 u64 *period_ns, u64 *duty_ns)
> > +{
> > +	u32 period_tick, duty_tick;
> > +	unsigned int offset;
> > +	u32 shift, val;
> > +	int ret;
> > +
> > +	offset = bucket / AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> > +	shift = bucket % AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> > +	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> > +
> > +	ret = regmap_read(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset),
> > +			  &val);
> 
> You may shorten the line and the code (as below the same can be applied)
> by introducing
> 
> 	struct regmap *map = pc->regmap;
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	period_tick = FIELD_GET(AIROHA_PWM_WAVE_GEN_CYCLE, val >> shift);
> > +	*period_ns = period_tick * AIROHA_PWM_PERIOD_TICK_NS;
> > +
> > +	offset = bucket / AIROHA_PWM_BUCKET_PER_FLASH_PROD;
> > +	shift = bucket % AIROHA_PWM_BUCKET_PER_FLASH_PROD;
> > +	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> > +
> > +	ret = regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +			  &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	duty_tick = FIELD_GET(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, val >> shift);
> > +	/*
> > +	 * Overflow can't occur in multiplication as duty_tick is just 8 bit
> > +	 * and period_ns is clamped to AIROHA_PWM_PERIOD_MAX_NS and fit in a
> > +	 * u64.
> > +	 */
> > +	*duty_ns = DIV_U64_ROUND_UP(duty_tick * *period_ns, AIROHA_PWM_DUTY_FULL);
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int airoha_pwm_get_generator(struct airoha_pwm *pc, u32 duty_ticks,
> > +				    u32 period_ticks)
> > +{
> > +	int best = -ENOENT, unused = -ENOENT;
> > +	u32 best_period_ticks = 0;
> > +	u32 best_duty_ticks = 0;
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {
> 
> You want array_size.h.
> 
> > +		struct airoha_pwm_bucket *bucket = &pc->buckets[i];
> > +		u32 bucket_period_ticks = bucket->period_ticks;
> > +		u32 bucket_duty_ticks = bucket->duty_ticks;
> 
> > +		/* If found, save an unused bucket to return it later */
> > +		if (refcount_read(&bucket->used) == 0) {
> > +			unused = i;
> > +			continue;
> > +		}
> > +
> > +		/* We found a matching bucket, exit early */
> > +		if (duty_ticks == bucket_duty_ticks &&
> > +		    period_ticks == bucket_period_ticks)
> > +			return i;
> > +
> > +		/*
> > +		 * Unlike duty cycle zero, which can be handled by
> > +		 * disabling PWM, a generator is needed for full duty
> > +		 * cycle but it can be reused regardless of period
> > +		 */
> > +		if (duty_ticks == AIROHA_PWM_DUTY_FULL &&
> > +		    bucket_duty_ticks == AIROHA_PWM_DUTY_FULL)
> > +			return i;
> > +
> > +		/*
> > +		 * With an unused bucket available, skip searching for
> > +		 * a bucket to recycle (closer to the requested period/duty)
> > +		 */
> > +		if (unused != -ENOENT)
> 
> Can unused be negative and have different error code or so?
> If not, simplify here (and in return below) to
> 
> 		if (unused >= 0)
> 
> > +			continue;
> > +
> > +		/* Ignore bucket with invalid configs */
> > +		if (bucket_period_ticks > period_ticks ||
> > +		    bucket_duty_ticks > duty_ticks)
> > +			continue;
> > +
> > +		/*
> > +		 * Search for a bucket closer to the requested period/duty
> > +		 * that has the maximal possible period that isn't bigger
> > +		 * than the requested period. For that period pick the maximal
> > +		 * duty_cycle that isn't bigger than the requested duty_cycle.
> 
> duty cycle
> 
> (with underscore I haven't found a variable in this function the comment refers to)
> 
> > +		 */
> > +		if (bucket_period_ticks > best_period_ticks ||
> > +		    (bucket_period_ticks == best_period_ticks &&
> > +		     bucket_duty_ticks > best_duty_ticks)) {
> > +			best_period_ticks = bucket_period_ticks;
> > +			best_duty_ticks = bucket_duty_ticks;
> > +			best = i;
> > +		}
> > +	}
> > +
> > +	/* With no unused bucket, return the best one found (if ever) */
> > +	return unused == -ENOENT ? best : unused;
> > +}
> 
> ...
> 
> > +static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
> > +					u32 duty_ticks, u32 period_ticks,
> > +					unsigned int hwpwm)
> > +{
> > +	int bucket, ret;
> > +
> > +	/*
> > +	 * Search for a bucket that already satisfies duty and period
> > +	 * or an unused one.
> > +	 * If not found, -ENOENT is returned.
> > +	 */
> > +	bucket = airoha_pwm_get_generator(pc, duty_ticks, period_ticks);
> > +	if (bucket < 0)
> > +		return bucket;
> > +
> > +	/* Release previous used bucket (if any) */
> > +	airoha_pwm_release_bucket_config(pc, hwpwm);
> 
> > +	if (refcount_read(&pc->buckets[bucket].used) == 0) {
> > +		pc->buckets[bucket].period_ticks = period_ticks;
> > +		pc->buckets[bucket].duty_ticks = duty_ticks;
> > +		ret = airoha_pwm_apply_bucket_config(pc, bucket,
> > +						     duty_ticks,
> > +						     period_ticks);
> > +		if (ret)
> > +			return ret;
> > +
> > +		refcount_set(&pc->buckets[bucket].used, 1);
> 
> What happens if refcount is updated in between? This is wrong use of atomics.
> 
> > +	} else {
> > +		refcount_inc(&pc->buckets[bucket].used);
> 
> Ditto.
> 
> You probably wanted _inc_and_test() variant.
>

The main problem is that adding macro for refcount and atomic is that
normaly you expect to have parallel ASM code for it to have real aotmic
OP. Anyway I think I solved it with a simple mutex.

The usage of refcount here it's not really for atomic but for object
tracking but refcount doesn't love to initialize from 0 and incremented
so I have to use this _set and _inc thing.

> > +	}
> > +
> > +	return bucket;
> > +}
> 
> ...
> 
> > +static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *pwm,
> > +			     u32 duty_ticks, u32 period_ticks)
> > +{
> > +	unsigned int hwpwm = pwm->hwpwm;
> > +	int bucket, ret;
> > +
> > +	bucket = airoha_pwm_consume_generator(pc, duty_ticks, period_ticks,
> > +					      hwpwm);
> > +	if (bucket < 0)
> > +		return bucket;
> > +
> > +	ret = airoha_pwm_config_flash_map(pc, hwpwm, bucket);
> > +	if (ret) {
> > +		refcount_dec(&pc->buckets[bucket].used);
> > +		return ret;
> > +	}
> 
> > +	set_bit(hwpwm, pc->initialized);
> 
> Does it need to be atomic? (Just asking) If not, use non-atomic variant, i.e.
> __set_bit().
> 

Yes it needs to be atomic since the initialized bitmask is global.

> > +	pc->channel_bucket[hwpwm] = bucket;
> > +
> > +	/*
> > +	 * SIPO are special GPIO attached to a shift register chip. The handling
> > +	 * of this chip is internal to the SoC that takes care of applying the
> > +	 * values based on the flash map. To apply a new flash map, it's needed
> > +	 * to trigger a refresh on the shift register chip.
> > +	 * If a SIPO is getting configuring , always reinit the shift register
> > +	 * chip to make sure the correct flash map is applied.
> > +	 * Skip reconfiguring the shift register if the related hwpwm
> > +	 * is disabled (as it doesn't need to be mapped).
> > +	 */
> > +	if (hwpwm >= AIROHA_PWM_NUM_GPIO) {
> > +		ret = airoha_pwm_sipo_init(pc);
> > +		if (ret) {
> > +			airoha_pwm_release_bucket_config(pc, hwpwm);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static void airoha_pwm_disable(struct airoha_pwm *pc, struct pwm_device *pwm)
> > +{
> > +	/* Disable PWM and release the bucket */
> > +	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
> > +	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
> 
> > +	clear_bit(pwm->hwpwm, pc->initialized);
> 
> As per above.
> 
> > +	/* If no SIPO is used, disable the shift register chip */
> > +	if (find_next_bit(pc->initialized, AIROHA_PWM_MAX_CHANNELS,
> > +			  AIROHA_PWM_NUM_GPIO) >= AIROHA_PWM_NUM_GPIO)
> > +		regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> > +				  AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
> > +}
> 
> ...
> 
> > +static int airoha_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct airoha_pwm *pc;
> > +	struct pwm_chip *chip;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	chip = devm_pwmchip_alloc(dev, AIROHA_PWM_MAX_CHANNELS, sizeof(*pc));
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +
> > +	chip->ops = &airoha_pwm_ops;
> > +	pc = pwmchip_get_drvdata(chip);
> > +
> > +	pc->regmap = device_node_to_regmap(dev->parent->of_node);
> 
> Please, use dev_of_node(dev->parent).
> 
> > +	if (IS_ERR(pc->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(pc->regmap), "Failed to get PWM regmap\n");
> > +
> > +	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++)
> > +		refcount_set(&pc->buckets[i].used, 0);
> > +
> > +	ret = devm_pwmchip_add(&pdev->dev, chip);
> 
> Seems you have dev, why not use it?
> 
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> > +
> > +	return 0;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
	Ansuel

