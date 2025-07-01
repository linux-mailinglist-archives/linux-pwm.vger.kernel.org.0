Return-Path: <linux-pwm+bounces-6616-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92926AEEFDF
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 09:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB5D179812
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F671EBA1E;
	Tue,  1 Jul 2025 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbnFL73/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47672601;
	Tue,  1 Jul 2025 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355606; cv=none; b=L++eOH8AAQbfNwIPOxWMsq8E2C7xOkgJ4pM5aQLlAdjfAxeOVzAGanjRt6OAjrfLe7+xBP7zxJ3somVBxeeDc2uq7kqnSvMty4YjZkonnuG77aVwPWx2MXBJeM5jkvGySfMpdiA4zLxcsdUy9NmRxXaqW4SGtmi5q2nqF8DAhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355606; c=relaxed/simple;
	bh=j2M3rRPgKt2mVHQc7st/PFk7KUKAIRMshMe8932r2Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMVsRtm/bhGbroF8KdFpmjxdnjsWh/k/VF9eVRyzZDRKIVTLDbTtfQMC9Ko6ouYZ56A09XxyyeQseLH0eFDVLgfE/wV4d1aqTkX2k/wMi/oiiSJKP2TRYHhDIh4Y95ZbmTCe7gm+8YIsZ/Ex5H9jIf55G3kMFMiwEo2ZMZfDdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbnFL73/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9C5C4CEEF;
	Tue,  1 Jul 2025 07:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751355606;
	bh=j2M3rRPgKt2mVHQc7st/PFk7KUKAIRMshMe8932r2Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbnFL73/9NVaxOUiDe+V0dPOG+ciFkOBgNHSk5q/9Np1OHbT6j7laIyCp+MretVmx
	 L/lqNQxhwoz7S3xEegBwePeEAwgHHcby7YlvSMtdPHyaxJ69hV1KH0V4U0A6fc+7xL
	 xvAKJV/tV08+90E29xtgh6Wo76SbR2os9bLAbRAog/Dxl6aKhjOzmq6LP3nVWRr4hU
	 zUTvIOfYOuUNZ7P6E87Ci7O4hShsr/RL0aIgH7MVv7y+iiPUo5WhHNolRex5Jv4PV2
	 08GlpcY+TuV6eY3tCM0HsUNnEY2Y/rkCDywY3od87RgVb+mQyEqN0Je9Rv53L2kauH
	 MLHHfbkcZ64Ow==
Date: Tue, 1 Jul 2025 09:40:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v19] pwm: airoha: Add support for EN7581 SoC
Message-ID: <bwtk2nac2eo2jgf2lousguw7o34tzhz7mesdo3jfaf4gc3pri6@tff3h4f4274u>
References: <20250630114504.8308-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eisa4lv7ycou67jv"
Content-Disposition: inline
In-Reply-To: <20250630114504.8308-1-ansuelsmth@gmail.com>


--eisa4lv7ycou67jv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v19] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

On Mon, Jun 30, 2025 at 01:44:39PM +0200, Christian Marangi wrote:
> +struct airoha_pwm_bucket {
> +	int used;
> +	u32 period_ticks;
> +	u32 duty_ticks;
> +};
> +
> +struct airoha_pwm {
> +	struct regmap *regmap;
> +	/* Global mutex to protect bucket used counter */
> +	struct mutex mutex;

I think you don't need that mutex. There is a chip lock already used by
the core and that is held during .get_state() and .apply() serializing
these calls (and more).

> +	DECLARE_BITMAP(initialized, AIROHA_PWM_MAX_CHANNELS);
> +
> +	struct airoha_pwm_bucket buckets[AIROHA_PWM_NUM_BUCKETS];
> +
> +	/* Cache bucket used by each pwm channel */
> +	u8 channel_bucket[AIROHA_PWM_MAX_CHANNELS];
> +};
> [...]
> +static int airoha_pwm_apply_bucket_config(struct airoha_pwm *pc, int bucket,
> +					  u32 duty_ticks, u32 period_ticks)
> +{
> +	u32 mask, shift, val;
> +	u64 offset;
> +	int ret;
> +
> +	offset = bucket;
> +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);

Do you really need offset as a 64 bit variable? At least on 32 bit archs

	offset = bucket / AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(bucket % AIROHA_PWM_BUCKET_PER_CYCLE_CFG);

should be cheaper. Also can bucket better be an unsigned value (to make
it obvious that no strange things happen with the division)?

> +	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> +
> +	/* Configure frequency divisor */
> +	mask = AIROHA_PWM_WAVE_GEN_CYCLE << shift;
> +	val = FIELD_PREP(AIROHA_PWM_WAVE_GEN_CYCLE, period_ticks) << shift;
> +	ret = regmap_update_bits(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset),
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	offset = bucket;
> +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
> +	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> +
> +	/* Configure duty cycle */
> +	mask = AIROHA_PWM_GPIO_FLASH_PRD_HIGH << shift;
> +	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, duty_ticks) << shift;
> +	ret = regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	mask = AIROHA_PWM_GPIO_FLASH_PRD_LOW << shift;
> +	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_LOW,
> +			 AIROHA_PWM_DUTY_FULL - duty_ticks) << shift;
> +	return regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> +				  mask, val);

Strange hardware, why do you have to configure both the high and the low
relative duty? What happens if AIROHA_PWM_GPIO_FLASH_PRD_LOW +
AIROHA_PWM_GPIO_FLASH_PRD_HIGH != AIROHA_PWM_DUTY_FULL?

> +}
> +
> [...]
> +static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
> +	u32 period_ticks, duty_ticks;
> +	u32 period_ns, duty_ns;
> +
> +	if (!state->enabled) {
> +		airoha_pwm_disable(pc, pwm);
> +		return 0;
> +	}
> +
> +	/* Only normal polarity is supported */
> +	if (state->polarity == PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	/* Exit early if period is less than minimum supported */
> +	if (state->period < AIROHA_PWM_PERIOD_TICK_NS)
> +		return -EINVAL;
> +
> +	/* Clamp period to MAX supported value */
> +	if (state->period > AIROHA_PWM_PERIOD_MAX_NS)
> +		period_ns = AIROHA_PWM_PERIOD_MAX_NS;
> +	else
> +		period_ns = state->period;
> +
> +	/* Validate duty to configured period */
> +	if (state->duty_cycle > period_ns)
> +		duty_ns = period_ns;
> +	else
> +		duty_ns = state->duty_cycle;
> +
> +	/*
> +	 * Period goes at 4ns step, normalize it to check if we can
> +	 * share a generator.
> +	 */
> +	period_ns = rounddown(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> +
> +	/*
> +	 * Duty is divided in 255 segment, normalize it to check if we
> +	 * can share a generator.
> +	 */
> +	duty_ns = DIV_U64_ROUND_UP(duty_ns * AIROHA_PWM_DUTY_FULL,
> +				   AIROHA_PWM_DUTY_FULL);

This looks bogus. This is just duty_ns = duty_ns, or what do I miss?
Also duty_ns is an u32 and AIROHA_PWM_DUTY_FULL an int, so there is no
need for a 64 bit division.

> +	/* Convert ns to ticks */
> +	period_ticks = airoha_pwm_get_period_ticks_from_ns(period_ns);
> +	duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);
> +
> +	return airoha_pwm_config(pc, pwm, period_ticks, duty_ticks);
> +}

Best regards
Uwe

--eisa4lv7ycou67jv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhjkNAACgkQj4D7WH0S
/k5iLQgAqu27McWqaKG3y8e7xRVwFmB00zYU0girWh+QkAsSbk3epaad/f3ECZX9
vOy+XIOYIpducren0cDcdFXgN9pO3z5UV+g8sAA+AoBT6jrFHVJ/eTJ80Kk8X1EU
bCsfff8Zt4FVFBrYAG64ol3XORQ0YA8OhAX7ukly7BHiGFaNZNPrysZTMm3M7keN
jgi2hx64dKq0NktHVV4iIpi3T/V6sqGAIGOtl9YzMpeyRpa2AG7902CTog67sMxs
l+SQYaxuqdFxuIaQnwqzAuTzP+mmSDCdLynju3kB6/dG9vzVMXPP22vAIyj98vKt
SniGYRgdpRLs/UA/trf9fK9CA99kCw==
=sf8c
-----END PGP SIGNATURE-----

--eisa4lv7ycou67jv--

