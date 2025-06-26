Return-Path: <linux-pwm+bounces-6536-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3577CAE9F73
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Jun 2025 15:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B713A772B
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Jun 2025 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53732E1C7E;
	Thu, 26 Jun 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8Se9j3o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF21922F6;
	Thu, 26 Jun 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946089; cv=none; b=GjfyvDjEkakQHQKLsyuaAz09BccZYBXft7wBoxwtioSeGVnsFHxhep4Fr7PSpAShZKFWVbluRzKsAmCu3+8nDAUlc9hr4+yDs2rjMNz7oX5q1i9WETyK5+zBDrYREA1LK16LkduPcXYQsDenhdE0c875+lFX5Ud+7pwwYEs5fYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946089; c=relaxed/simple;
	bh=n8K7BjgUayWBLFvVAFSIS3u6eapQ2dFQhGg4Vt/DuFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIBb666tsqp5Ww0S7EM11p4HOs1tNXdAqQ4nYfdmtDpIrn3QqXfHMNhGbRloxU/54GqE9q2MZp3nJOsOr9Jo9nmNhMUmVQVGq7Y0X9vU+MZpMYlnDXR78ymmvjg83NR0y87INPwZZ2j9szLtrflB0x4S991QedXuoeDNEQRsglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8Se9j3o; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750946088; x=1782482088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n8K7BjgUayWBLFvVAFSIS3u6eapQ2dFQhGg4Vt/DuFc=;
  b=n8Se9j3oXjPrcTdO8MGG5HVbb41HPpt/kiqELLwhAmm+n8B14XYpt4m4
   EalU2jCj6Lap7VgTHQQCbFU7YPE5f9qwy76JyIWe6IJ25C22BF8NYqT1Z
   G5iqOTUviF6xChZBRL+f7tXn2ddIEnYCsPn49GCjUQWLSkQVWrhgf7ac9
   gKJ3BYhNldu0T+44ZH5DNZysywB7HKtnabVGM87grRaDVFU2/seAFyZ0v
   CuOXEziPxFubYXhg7ptqNH2I8Y6/iOWTRNlmK/DyXgQeMj0kpT++X+VGr
   FGmnqql6YSSHoO+uAOIJC3ehbaR+dJDX1j/NHT1MQu4nxd4LOqy6b0aJR
   A==;
X-CSE-ConnectionGUID: f/umjALOQaGQCuYaWpZa5w==
X-CSE-MsgGUID: FrJGssgOT5CWS1/+Jsr5mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55867842"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="55867842"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 06:54:47 -0700
X-CSE-ConnectionGUID: A7hq6bzMS0G4QeFpwDLlCw==
X-CSE-MsgGUID: EmIq/DG5T4aDdWHIBYnurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="152683801"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 06:54:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUn3q-0000000AC0F-0pmS;
	Thu, 26 Jun 2025 16:54:42 +0300
Date: Thu, 26 Jun 2025 16:54:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v17] pwm: airoha: Add support for EN7581 SoC
Message-ID: <aF1RIVzVNcdsU1DB@smile.fi.intel.com>
References: <20250625194919.94214-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625194919.94214-1-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 09:49:01PM +0200, Christian Marangi wrote:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> 
> Introduce driver for PWM module available on EN7581 SoC.

Almost from my perspective.
If you address the below as suggested, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>

On my calendar 2025 is. Also MODULE_AUTHOR() list disagrees with this
(you should add yourself somewhere here).

> + *  Limitations:
> + *  - Only 8 concurrent waveform generators are available for 8 combinations of
> + *    duty_cycle and period. Waveform generators are shared between 16 GPIO
> + *    pins and 17 SIPO GPIO pins.
> + *  - Supports only normal polarity.
> + *  - On configuration the currently running period is completed.
> + *  - Minimum supported period is 4ms
> + *  - Maximum supported period is 1s
> + */

...

> +#define AIROHA_PWM_SGPIO_CLK_DIVR_32		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x3)
> +#define AIROHA_PWM_SGPIO_CLK_DIVR_16		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x2)
> +#define AIROHA_PWM_SGPIO_CLK_DIVR_8		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x1)
> +#define AIROHA_PWM_SGPIO_CLK_DIVR_4		FIELD_PREP_CONST(AIROHA_PWM_SGPIO_CLK_DIVR, 0x0)

Remove 0x:s, they are just noise and moreover the list here is plain numbers,
not bit combinations or so. In such cases we use decimal numbers.

...

> +/* Cycle cfg handles 4 generators in one register */

I am a bit lost in the meaning of "cycle cfg". Can you elaborate in
the comment that it's readable in plain English?

> +#define AIROHA_PWM_BUCKET_PER_CYCLE_CFG		4

...

> +static u32 airoha_pwm_get_duty_ticks_from_ns(u32 period_ns, u32 duty_ns)
> +{
> +	return mul_u64_u32_div(duty_ns, AIROHA_PWM_DUTY_FULL,
> +			       period_ns);

It's less than 80 if put on one line!

> +}

...

> +static int airoha_pwm_get_bucket(struct airoha_pwm *pc, int bucket,
> +				 u64 *period_ns, u64 *duty_ns)
> +{
> +	u32 period_tick, duty_tick;
> +	unsigned int offset;
> +	u32 shift, val;
> +	int ret;
> +
> +	offset = bucket / AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> +	shift = bucket % AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> +	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> +
> +	ret = regmap_read(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset),
> +			  &val);

You may shorten the line and the code (as below the same can be applied)
by introducing

	struct regmap *map = pc->regmap;

> +	if (ret)
> +		return ret;
> +
> +	period_tick = FIELD_GET(AIROHA_PWM_WAVE_GEN_CYCLE, val >> shift);
> +	*period_ns = period_tick * AIROHA_PWM_PERIOD_TICK_NS;
> +
> +	offset = bucket / AIROHA_PWM_BUCKET_PER_FLASH_PROD;
> +	shift = bucket % AIROHA_PWM_BUCKET_PER_FLASH_PROD;
> +	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> +
> +	ret = regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> +			  &val);
> +	if (ret)
> +		return ret;
> +
> +	duty_tick = FIELD_GET(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, val >> shift);
> +	/*
> +	 * Overflow can't occur in multiplication as duty_tick is just 8 bit
> +	 * and period_ns is clamped to AIROHA_PWM_PERIOD_MAX_NS and fit in a
> +	 * u64.
> +	 */
> +	*duty_ns = DIV_U64_ROUND_UP(duty_tick * *period_ns, AIROHA_PWM_DUTY_FULL);
> +
> +	return 0;
> +}

...

> +static int airoha_pwm_get_generator(struct airoha_pwm *pc, u32 duty_ticks,
> +				    u32 period_ticks)
> +{
> +	int best = -ENOENT, unused = -ENOENT;
> +	u32 best_period_ticks = 0;
> +	u32 best_duty_ticks = 0;
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {

You want array_size.h.

> +		struct airoha_pwm_bucket *bucket = &pc->buckets[i];
> +		u32 bucket_period_ticks = bucket->period_ticks;
> +		u32 bucket_duty_ticks = bucket->duty_ticks;

> +		/* If found, save an unused bucket to return it later */
> +		if (refcount_read(&bucket->used) == 0) {
> +			unused = i;
> +			continue;
> +		}
> +
> +		/* We found a matching bucket, exit early */
> +		if (duty_ticks == bucket_duty_ticks &&
> +		    period_ticks == bucket_period_ticks)
> +			return i;
> +
> +		/*
> +		 * Unlike duty cycle zero, which can be handled by
> +		 * disabling PWM, a generator is needed for full duty
> +		 * cycle but it can be reused regardless of period
> +		 */
> +		if (duty_ticks == AIROHA_PWM_DUTY_FULL &&
> +		    bucket_duty_ticks == AIROHA_PWM_DUTY_FULL)
> +			return i;
> +
> +		/*
> +		 * With an unused bucket available, skip searching for
> +		 * a bucket to recycle (closer to the requested period/duty)
> +		 */
> +		if (unused != -ENOENT)

Can unused be negative and have different error code or so?
If not, simplify here (and in return below) to

		if (unused >= 0)

> +			continue;
> +
> +		/* Ignore bucket with invalid configs */
> +		if (bucket_period_ticks > period_ticks ||
> +		    bucket_duty_ticks > duty_ticks)
> +			continue;
> +
> +		/*
> +		 * Search for a bucket closer to the requested period/duty
> +		 * that has the maximal possible period that isn't bigger
> +		 * than the requested period. For that period pick the maximal
> +		 * duty_cycle that isn't bigger than the requested duty_cycle.

duty cycle

(with underscore I haven't found a variable in this function the comment refers to)

> +		 */
> +		if (bucket_period_ticks > best_period_ticks ||
> +		    (bucket_period_ticks == best_period_ticks &&
> +		     bucket_duty_ticks > best_duty_ticks)) {
> +			best_period_ticks = bucket_period_ticks;
> +			best_duty_ticks = bucket_duty_ticks;
> +			best = i;
> +		}
> +	}
> +
> +	/* With no unused bucket, return the best one found (if ever) */
> +	return unused == -ENOENT ? best : unused;
> +}

...

> +static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
> +					u32 duty_ticks, u32 period_ticks,
> +					unsigned int hwpwm)
> +{
> +	int bucket, ret;
> +
> +	/*
> +	 * Search for a bucket that already satisfies duty and period
> +	 * or an unused one.
> +	 * If not found, -ENOENT is returned.
> +	 */
> +	bucket = airoha_pwm_get_generator(pc, duty_ticks, period_ticks);
> +	if (bucket < 0)
> +		return bucket;
> +
> +	/* Release previous used bucket (if any) */
> +	airoha_pwm_release_bucket_config(pc, hwpwm);

> +	if (refcount_read(&pc->buckets[bucket].used) == 0) {
> +		pc->buckets[bucket].period_ticks = period_ticks;
> +		pc->buckets[bucket].duty_ticks = duty_ticks;
> +		ret = airoha_pwm_apply_bucket_config(pc, bucket,
> +						     duty_ticks,
> +						     period_ticks);
> +		if (ret)
> +			return ret;
> +
> +		refcount_set(&pc->buckets[bucket].used, 1);

What happens if refcount is updated in between? This is wrong use of atomics.

> +	} else {
> +		refcount_inc(&pc->buckets[bucket].used);

Ditto.

You probably wanted _inc_and_test() variant.

> +	}
> +
> +	return bucket;
> +}

...

> +static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *pwm,
> +			     u32 duty_ticks, u32 period_ticks)
> +{
> +	unsigned int hwpwm = pwm->hwpwm;
> +	int bucket, ret;
> +
> +	bucket = airoha_pwm_consume_generator(pc, duty_ticks, period_ticks,
> +					      hwpwm);
> +	if (bucket < 0)
> +		return bucket;
> +
> +	ret = airoha_pwm_config_flash_map(pc, hwpwm, bucket);
> +	if (ret) {
> +		refcount_dec(&pc->buckets[bucket].used);
> +		return ret;
> +	}

> +	set_bit(hwpwm, pc->initialized);

Does it need to be atomic? (Just asking) If not, use non-atomic variant, i.e.
__set_bit().

> +	pc->channel_bucket[hwpwm] = bucket;
> +
> +	/*
> +	 * SIPO are special GPIO attached to a shift register chip. The handling
> +	 * of this chip is internal to the SoC that takes care of applying the
> +	 * values based on the flash map. To apply a new flash map, it's needed
> +	 * to trigger a refresh on the shift register chip.
> +	 * If a SIPO is getting configuring , always reinit the shift register
> +	 * chip to make sure the correct flash map is applied.
> +	 * Skip reconfiguring the shift register if the related hwpwm
> +	 * is disabled (as it doesn't need to be mapped).
> +	 */
> +	if (hwpwm >= AIROHA_PWM_NUM_GPIO) {
> +		ret = airoha_pwm_sipo_init(pc);
> +		if (ret) {
> +			airoha_pwm_release_bucket_config(pc, hwpwm);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

...

> +static void airoha_pwm_disable(struct airoha_pwm *pc, struct pwm_device *pwm)
> +{
> +	/* Disable PWM and release the bucket */
> +	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
> +	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);

> +	clear_bit(pwm->hwpwm, pc->initialized);

As per above.

> +	/* If no SIPO is used, disable the shift register chip */
> +	if (find_next_bit(pc->initialized, AIROHA_PWM_MAX_CHANNELS,
> +			  AIROHA_PWM_NUM_GPIO) >= AIROHA_PWM_NUM_GPIO)
> +		regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> +				  AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
> +}

...

> +static int airoha_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct airoha_pwm *pc;
> +	struct pwm_chip *chip;
> +	unsigned int i;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, AIROHA_PWM_MAX_CHANNELS, sizeof(*pc));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	chip->ops = &airoha_pwm_ops;
> +	pc = pwmchip_get_drvdata(chip);
> +
> +	pc->regmap = device_node_to_regmap(dev->parent->of_node);

Please, use dev_of_node(dev->parent).

> +	if (IS_ERR(pc->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pc->regmap), "Failed to get PWM regmap\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++)
> +		refcount_set(&pc->buckets[i].used, 0);
> +
> +	ret = devm_pwmchip_add(&pdev->dev, chip);

Seems you have dev, why not use it?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



