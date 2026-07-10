Return-Path: <linux-pwm+bounces-9686-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O5fOJDjSUGoz5gIAu9opvQ
	(envelope-from <linux-pwm+bounces-9686-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 13:06:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15801739F8F
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 13:06:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f+4Sy4F9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9686-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9686-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FA093005783
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E63F41169A;
	Fri, 10 Jul 2026 11:02:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F78412263;
	Fri, 10 Jul 2026 11:02:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681370; cv=none; b=dNaUYn10xAEZ6Oyjs8IgNy74jZHtvmfyCSen4PLRaONAQJaA8s8pIvvEVZlQuk7LsNvtrkcdJyO8GS61Fgg1qKB6A4b1uNjckuGs3vdPj2upzbaEcKi/nGW/I0Pe3THCHVkB+JHRa39RrqaKWDlhP4p9XUSKdAznVAFKc9wp5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681370; c=relaxed/simple;
	bh=SuQWSvu8dH4MYsJ6BjXKHu6h2Bpplj1IM+WZMfFybB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unU4a1OnIVgfFEhyOKPWN/jwQBYQbO6dzkx4CzZjnOlcWKl8Ngs9kNm01P4gLH9IReJbbuWZcAK9y8vaBn5QOwZhoSexEKZH5TWMW7RSpCllxvaQ6gWoUw9yZexn0Uxjsmwev9eXT+/E35452sihBXvDNTYyqd6u95PbZAIgKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+4Sy4F9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 15F381F000E9;
	Fri, 10 Jul 2026 11:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783681367;
	bh=eVRsx3hBBJH/Va+OHfcN9cN1H7LyCaNlLfEaKAQnK3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f+4Sy4F9sL0hz+yEPS8HqKB/0afaTNBkCgQrHHJAEd1j27jzS3D8zxzNZpxU2Tai2
	 2r442TR4HOvLL+s00Yu9iAkKHO9skq4AGRDFO3Zm8KrYHCHVLoA7Il67yfSJ6vE7d2
	 3FK3ivhh/XEg/yzY5RV++aZWJj4YKI5WzUc0PocQLLejibOcPWSifNn8KfD9n0r/ZA
	 VcEm/lIj7jUZDP/wZYVhLslbau+0gq0BboStJVvBr2Q/T70moKwENeOBrM9atTJPEv
	 9lLgBWRvb2rc9R0B2E8nhA1N5DpqDfNkaaZlZqc3kBve9XFtwk0Wds/m6JfzoOhB+c
	 MifZ0UOzJHd/A==
Date: Fri, 10 Jul 2026 13:02:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, Damon Ding <damon.ding@rock-chips.com>, kernel@collabora.com, 
	Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>, 
	linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 3/6] pwm: Add rockchip PWMv4 driver
Message-ID: <alDK7JahbqYpwQmZ@monoceros>
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-3-ae7cfbbe5427@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zmapr4d5j6nd5icv"
Content-Disposition: inline
In-Reply-To: <20260420-rk3576-pwm-v5-3-ae7cfbbe5427@collabora.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nicolas.frattaroli@collabora.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:lee@kernel.org,m:wbg@kernel.org,m:damon.ding@rock-chips.com,m:kernel@collabora.com,m:jonas@kwiboo.se,m:alchark@gmail.com,m:linux-rockchip@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-iio@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9686-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,rock-chips.com,collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15801739F8F


--zmapr4d5j6nd5icv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 3/6] pwm: Add rockchip PWMv4 driver
MIME-Version: 1.0

Hello Nicolas,

On Mon, Apr 20, 2026 at 03:52:40PM +0200, Nicolas Frattaroli wrote:
> [...]
> +/**
> + * rockchip_pwm_v4_round_single - convert a PWM parameter to hardware
> + * @rate: clock rate of the PWM clock, as per clk_get_rate
> + *        Assumed to be <= 1GHz for overflow considerations
> + * @in_val: parameter in nanoseconds to convert
> + *
> + * Returns the rounded value, saturating at U32_MAX if too large
> + */
> +static u32 rockchip_pwm_v4_round_single(unsigned long rate, u64 in_val)

very picky: if you name this function rockchip_pwm_v4_ns_to_ticks it
becomes clearer what the purpose is.

> +{
> +	u64 tmp;
> +
> +	tmp = mul_u64_u64_div_u64(rate, in_val, NSEC_PER_SEC);
> +	if (tmp > U32_MAX)
> +		tmp = U32_MAX;
> +
> +	return tmp;
> +}
> +
> +/**
> + * rockchip_pwm_v4_round_params - convert PWM parameters to hardware
> + * @rate: PWM clock rate to do the calculations at
> + * @wf: pointer to the generic &struct pwm_waveform input parameters
> + * @wfhw: pointer to the hardware-specific &struct rockchip_pwm_v4_wf output
> + *        parameters that the results will be stored in
> + *
> + * Convert nanosecond-based duty/period/offset parameters to the PWM hardware's
> + * native rounded representation in number of cycles at clock rate @rate. Should
> + * any of the input parameters be out of range for the hardware, the
> + * corresponding output parameter is the maximum permissible value for said
> + * parameter with considerations to the others.
> + */
> +static void rockchip_pwm_v4_round_params(unsigned long rate,
> +					 const struct pwm_waveform *wf,
> +					 struct rockchip_pwm_v4_wf *wfhw)
> +{
> +	wfhw->period = rockchip_pwm_v4_round_single(rate, wf->period_length_ns);
> +
> +	wfhw->duty = rockchip_pwm_v4_round_single(rate, wf->duty_length_ns);
> +
> +	/* As per TRM, PWM_OFFSET: "The value ranges from 0 to (period-duty)" */

Have you tried what happens if you break this rule? That seems like a
very arbitrary restriction that might just originate from the
documentation author.

> +	wfhw->offset = rockchip_pwm_v4_round_single(rate, wf->duty_offset_ns);
> +	if (!wfhw->period) /* Don't underflow when pwm disabled */
> +		wfhw->offset = 0;
> +	else if (wfhw->offset > wfhw->period - wfhw->duty)
> +		wfhw->offset = wfhw->period - wfhw->duty;

You don't enforce wfhw->period >= wfhw->duty, which however seems like a
reasonable restriction. When knowing that you can drop the explicit
check for !wfhw->period and just keep the else-if branch.

> +}
> [...]
> +static int rockchip_pwm_v4_write_wf(struct pwm_chip *chip, struct pwm_device *pwm,
> +				    const void *_wfhw)
> +{
> +	struct rockchip_pwm_v4 *pc = to_rockchip_pwm_v4(chip);
> +	const struct rockchip_pwm_v4_wf *wfhw = _wfhw;
> +	bool was_enabled;
> +	int ret;
> +
> +	ret = mfpwm_acquire(pc->pwmf);
> +	if (ret)
> +		return ret;
> +
> +	was_enabled = rockchip_pwm_v4_is_enabled(mfpwm_reg_read(pc->pwmf->base,
> +								PWMV4_REG_ENABLE));
> +
> +	/*
> +	 * "But Nicolas", you ask with valid concerns, "why would you enable the
> +	 * PWM before setting all the parameter registers?"
> +	 *
> +	 * Excellent question, Mr. Reader M. Strawman! The RK3576 TRM Part 1
> +	 * Section 34.6.3 specifies that this is the intended order of writes.
> +	 * Doing the PWM_EN and PWM_CLK_EN writes after the params but before
> +	 * the CTRL_UPDATE_EN, or even after the CTRL_UPDATE_EN, results in
> +	 * erratic behaviour where repeated turning on and off of the PWM may
> +	 * not turn it off under all circumstances. This is also why we don't
> +	 * use relaxed writes; it's not worth the footgun.

I wonder if it's worth however to delay setting PWMV4_CTRL_UPDATE_EN
until after the clkrate is handled to (maybe) prevent glitches?

> +	 */
> +	if (wfhw->rate)
> +		mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> +				FIELD_PREP_WM16(PWMV4_EN_BOTH_MASK,
> +						PWMV4_EN_BOTH_MASK));
> +	else
> +		mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> +				FIELD_PREP_WM16(PWMV4_EN_BOTH_MASK, 0));
> +
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_PERIOD, wfhw->period);
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_DUTY, wfhw->duty);
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_OFFSET, wfhw->offset);
> +
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_CTRL, PWMV4_CTRL_CONT_FLAGS);
> +
> +	/* Commit new configuration to hardware output. */
> +	mfpwm_reg_write(pc->pwmf->base, PWMV4_REG_ENABLE,
> +			PWMV4_CTRL_UPDATE_EN);
> +
> +	if (wfhw->rate) {
> +		if (!was_enabled) {
> +			dev_dbg(&chip->dev, "Enabling PWM output\n");
> +			ret = clk_enable(pc->pwmf->core);
> +			if (ret)
> +				goto err_mfpwm_release;
> +			ret = clk_set_rate_exclusive(pc->pwmf->core, wfhw->rate);
> +			if (ret) {
> +				clk_disable(pc->pwmf->core);
> +				goto err_mfpwm_release;
> +			}
> +
> +			/*
> +			 * Output should be on now, acquire device to guarantee
> +			 * exclusion with other device functions while it's on.
> +			 *
> +			 * It's highly unlikely that this fails, as mfpwm has
> +			 * already been acquired before, and this is just a
> +			 * usage counter increase. Not worth the added
> +			 * complexity of clearing the PWMV4_REG_ENABLE again,
> +			 * especially considering the CTRL_UPDATE_EN behaviour.
> +			 */
> +			ret = mfpwm_acquire(pc->pwmf);
> +			if (ret) {
> +				clk_rate_exclusive_put(pc->pwmf->core);
> +				clk_disable(pc->pwmf->core);
> +				goto err_mfpwm_release;
> +			}
> +		}

Can it happen that we have

	wfhw->rate && was_enabled && wfhw->rate != clk_get_rate()

?

> +	} else if (was_enabled) {
> +		dev_dbg(&chip->dev, "Disabling PWM output\n");
> +		clk_rate_exclusive_put(pc->pwmf->core);
> +		clk_disable(pc->pwmf->core);
> +		/* Output is off now, extra release to balance extra acquire */
> +		mfpwm_release(pc->pwmf);
> +	}
> +
> +err_mfpwm_release:
> +	mfpwm_release(pc->pwmf);
> +
> +	return ret;
> +}
> [...]
> +static int rockchip_pwm_v4_probe(struct platform_device *pdev)
> +{
> +	struct rockchip_mfpwm_func *pwmf = dev_get_platdata(&pdev->dev);
> +	struct rockchip_pwm_v4 *pc;
> +	struct pwm_chip *chip;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	/*
> +	 * For referencing the PWM in the DT to work, we need the parent MFD
> +	 * device's OF node.
> +	 */
> +	dev->of_node_reused = true;
> +	device_set_node(dev, of_fwnode_handle(dev->parent->of_node));
> +
> +	chip = devm_pwmchip_alloc(dev, 1, sizeof(*pc));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	pc = to_rockchip_pwm_v4(chip);
> +	pc->pwmf = pwmf;
> +
> +	ret = mfpwm_acquire(pwmf);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Couldn't acquire mfpwm in probe\n");
> +
> +	if (!rockchip_pwm_v4_on_and_continuous(pc))
> +		mfpwm_release(pwmf);
> +	else {
> +		dev_dbg(dev, "PWM was already on at probe time\n");
> +		ret = clk_enable(pwmf->core);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "Enabling pwm clock failed\n");
> +			goto err_mfpwm_release;
> +		}
> +		ret = clk_rate_exclusive_get(pc->pwmf->core);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "Protecting pwm clock failed\n");
> +			goto err_clk_disable;
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, chip);

This is unused.

> +
> +	chip->ops = &rockchip_pwm_v4_ops;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +		if (rockchip_pwm_v4_on_and_continuous(pc))
> +			goto err_rate_put;
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +err_rate_put:
> +	clk_rate_exclusive_put(pwmf->core);
> +err_clk_disable:
> +	clk_disable(pwmf->core);
> +err_mfpwm_release:
> +	mfpwm_release(pwmf);
> +
> +	return ret;
> +}

Best regards
Uwe

--zmapr4d5j6nd5icv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpQ0VMACgkQj4D7WH0S
/k69Qwf6AyqNQlbHdAGwyu6A+raBNgAyVC7XDQIzx5BWj1Cd8NCNT88Bij7SPu2Z
nOf7fFzlSl4mnbEW76bJxTM4/eowUyhnsL5Ml4Vqdu2qmUeuCeDsFfFiOvbSbERk
O1fFf+xb8aVtNPwSmDBa+E4FW23I7n6+odYUZ2ooWBaARv0r6HF5f2CazdfVP5qL
eDSV1+ezGU3h90Ocs4uYBZtkhlBMO4Ucz4ypbk5/DWkhH+Pp25GLZkdzkrPyfuOO
ulkdT76++QD3uu+AelwsF23yW8KH3NMWkomaed/N+iWFC4R4RJqLbSWcxSJxfPl9
twerZ2j85gHUQGzI8QOIgsxIhfzq+Q==
=WOc0
-----END PGP SIGNATURE-----

--zmapr4d5j6nd5icv--

