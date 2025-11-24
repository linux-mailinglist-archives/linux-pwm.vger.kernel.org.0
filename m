Return-Path: <linux-pwm+bounces-7689-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E8BC81B67
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2034E3ADB59
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADD431A55B;
	Mon, 24 Nov 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tADsD1iI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC231A554;
	Mon, 24 Nov 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003110; cv=none; b=F6fyJRLa3blepU2x5n0VJ080K3roOYK9etWySW0DR1MIcisoc8Fp+IOyxbLjtk4JSvSEKbreZpTw3XMfFv/QcSXZM+yZywuFQ3M2Uvmy+XS/ndYCa9n5GlR/mSiBsoE7fVOzVEkkIsOAnZT8cyJX8WiP9fteV5oqcirby2rsD6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003110; c=relaxed/simple;
	bh=uckaZOA1cWm75KwS8ksQvm9L+oa5NcHzJ5/i78LNY7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7C25gJoIxFjEhfztvwGlrCXMAygHhrZhIXT2Tt4IYpbNN1KVPK83YGVexrHeCpeyl8PHAADqXI90GWwbGMbe6KWP6QqJLQjY+Aq2Bry8zxhM+TxQOgG4gtqlW33qxcF/ihCSlFH7VpvOObnI/QRUR6ZasNUZFo0da3ww7vx3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tADsD1iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FC9C116C6;
	Mon, 24 Nov 2025 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764003110;
	bh=uckaZOA1cWm75KwS8ksQvm9L+oa5NcHzJ5/i78LNY7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tADsD1iILxZRRpuuM3wuFcR8fetNaOskdstYm0LuBOAZiZWjrpNVNb6auXr6Hwz17
	 9mRM2lBRmH7nI0euVkLE4cP2ygquRvuW0WVwIHj1OiFduFLuWwdeKmvj6OjDw/Qq1W
	 gER5VUw1k5d0Bf50POsMaXNNQSg6GTF+bydSYMR3mJy9Q0wnBadAOmlHzYYJCSAM9l
	 gyCwQcvLmkRdiNfrVnXfG8RzbGyYaz96jNh2TzZYxvLzoIUAsQK9uLIR9+64KyxqeB
	 mbNJKMeAVf0uRVlAHRHwISpzg3r2Nws4DM8exKQaOw8OOSwwp4Qqu2GrZlK8EthjpI
	 kA3Lg34VS5RKg==
Date: Mon, 24 Nov 2025 17:51:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 4/6] pwm: tiehrpwm: implement .get_state callback
Message-ID: <4zdh44geiodumnqsfmwbxcfhishs7xeg5qsb6o3zb3nog7yfu6@wvqwqwltlip5>
References: <20251123232947.2085-1-rafael.v.volkmer@gmail.com>
 <20251123233151.2103-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zdwab6zzkumaazei"
Content-Disposition: inline
In-Reply-To: <20251123233151.2103-1-rafael.v.volkmer@gmail.com>


--zdwab6zzkumaazei
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 4/6] pwm: tiehrpwm: implement .get_state callback
MIME-Version: 1.0

Hello Rafael,

On Sun, Nov 23, 2025 at 08:31:51PM -0300, Rafael V. Volkmer wrote:
> Implement ehrpwm_get_state() so that consumers can query the current
> hardware configuration via pwm_get_state().

Note this is wrong as pwm_get_state() only yields the last request but
not the actual hardware setting.

> The callback reconstructs period and duty_cycle in nanoseconds from
> TBPRD, CMPA/B and the TBCTL prescaler fields. It also inspects AQCSFRC
> to treat software-forced outputs as disabled, and decodes the CAx/CDx
> action-qualifier bits in AQCTL(A/B) to report the current polarity.
>=20
> To make polarity decoding reliable, the configuration path now programs
> both up- and down-count compare actions (CAx/CDx) consistently for each
> polarity.
>=20
> This lets consumers query the effective hardware state instead of just
> the last requested settings.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 132 +++++++++++++++++++++++++++++++++----
>  1 file changed, 121 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 9f1be35912d3..cc525626b2f9 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -114,6 +114,9 @@
> =20
>  #define NUM_PWM_CHANNEL		2	/* EHRPWM channels */
> =20
> +#define PWM_CHA			0
> +#define PWM_CHB			1

Please don't introduce more defines with a PWM_ prefix that look more
generic than they are.

>  struct ehrpwm_context {
>  	u16 tbctl;
>  	u16 tbprd;
> @@ -267,37 +270,37 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	/* Update clock prescaler values */
>  	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_PRESCALE_MASK, tb_divval);
> =20
> -	if (pwm->hwpwm =3D=3D 1) {
> +	if (pwm->hwpwm =3D=3D PWM_CHB) {
>  		/* Channel 1 configured with compare B register */
>  		cmp_reg =3D CMPB;
> =20
>  		aqctl_reg =3D AQCTLB;
> -		aqctl_mask =3D AQCTL_CBU_MASK;
> +		aqctl_mask =3D AQCTL_CBU_MASK | AQCTL_CBD_MASK;
> =20
>  		if (polarity =3D=3D PWM_POLARITY_INVERSED)
> -			aqctl_val =3D AQCTL_CHB_UP_POLINVERSE;
> +			aqctl_val =3D AQCTL_CHB_UP_POLINVERSE | AQCTL_CHB_DN_POLINVERSE;
>  		else
> -			aqctl_val =3D AQCTL_CHB_UP_POLNORMAL;
> +			aqctl_val =3D AQCTL_CHB_UP_POLNORMAL | AQCTL_CHB_DN_POLNORMAL;
> =20
> -		/* if duty_cycle is big, don't toggle on CBU */
> +		/* if duty_cycle is big, don't toggle on compare events */
>  		if (duty_cycles > period_cycles)
> -			aqctl_val &=3D ~AQCTL_CBU_MASK;
> +			aqctl_val &=3D ~(AQCTL_CBU_MASK | AQCTL_CBD_MASK);
> =20
>  	} else {
>  		/* Channel 0 configured with compare A register */
>  		cmp_reg =3D CMPA;
> =20
>  		aqctl_reg =3D AQCTLA;
> -		aqctl_mask =3D AQCTL_CAU_MASK;
> +		aqctl_mask =3D AQCTL_CAU_MASK | AQCTL_CAD_MASK;
> =20
>  		if (polarity =3D=3D PWM_POLARITY_INVERSED)
> -			aqctl_val =3D AQCTL_CHA_UP_POLINVERSE;
> +			aqctl_val =3D AQCTL_CHA_UP_POLINVERSE | AQCTL_CHA_DN_POLINVERSE;
>  		else
> -			aqctl_val =3D AQCTL_CHA_UP_POLNORMAL;
> +			aqctl_val =3D AQCTL_CHA_UP_POLNORMAL | AQCTL_CHA_DN_POLNORMAL;
> =20
> -		/* if duty_cycle is big, don't toggle on CAU */
> +		/* if duty_cycle is big, don't toggle on compare events */
>  		if (duty_cycles > period_cycles)
> -			aqctl_val &=3D ~AQCTL_CAU_MASK;
> +			aqctl_val &=3D ~(AQCTL_CAU_MASK | AQCTL_CAD_MASK);
>  	}
> =20
>  	aqctl_mask |=3D AQCTL_PRD_MASK | AQCTL_ZRO_MASK;

Can you please split out these changes? These if branches are nearly
identical, I wonder if there is a way to make them smaller without
making it considerably less understandable.

> @@ -426,9 +429,116 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	return err;
>  }
> =20
> +static int ehrpwm_get_state(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    struct pwm_state *state)
> +{
> +	int ret =3D 0;
> +
> +	struct ehrpwm_pwm_chip *pc =3D NULL;
> +
> +	/* Registers */
> +	u16 aqcsfrc_reg, aqctl_reg, tbprd_reg, tbctl_reg;
> +
> +	/* Bits */
> +	u8 csf_bits, clkdiv_bits, hspclkdiv_bits;
> +
> +	/* Values */
> +	u64 period_ticks, duty_ticks, ps_div;
> +
> +	/* Actions */
> +	u8 up_action, down_action;
> +
> +	pc =3D to_ehrpwm_pwm_chip(chip);
> +
> +	/*
> +	 * The 'hwpwm' field identifies which hardware output channel (e.g.,
> +	 * 0 for channel A and 1 for channel B) of the eHRPWM module is in use.
> +	 */
> +	if (pwm->hwpwm =3D=3D PWM_CHA) {
> +		aqcsfrc_reg =3D readw(pc->mmio_base + AQCSFRC);
> +		csf_bits =3D FIELD_GET(AQCSFRC_CSFA_MASK, aqcsfrc_reg);
> +		aqctl_reg =3D readw(pc->mmio_base + AQCTLA);
> +	} else {
> +		aqcsfrc_reg =3D readw(pc->mmio_base + AQCSFRC);
> +		csf_bits =3D FIELD_GET(AQCSFRC_CSFB_MASK, aqcsfrc_reg);
> +		aqctl_reg =3D readw(pc->mmio_base + AQCTLB);
> +	}
> +
> +	if (csf_bits || !aqctl_reg) {
> +		state->enabled =3D false;
> +		return 0;
> +	}
> +
> +	state->enabled =3D true;
> +
> +	tbprd_reg =3D readw(pc->mmio_base + TBPRD);
> +	period_ticks =3D (u64)tbprd_reg + 1u;
> +
> +	tbctl_reg =3D readw(pc->mmio_base + TBCTL);
> +	hspclkdiv_bits =3D FIELD_GET(TBCTL_HSPCLKDIV_MASK, tbctl_reg);
> +	clkdiv_bits =3D FIELD_GET(TBCTL_CLKDIV_MASK, tbctl_reg);
> +
> +	ps_div =3D (1 << clkdiv_bits) * (hspclkdiv_bits ? (hspclkdiv_bits * 2) =
: 1);
> +
> +	/*
> +	 * period (in ns) =3D (period_ticks * preescaler * 1e9) / clk_rate
> +	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
> +	 */
> +	state->period =3D DIV_ROUND_UP_ULL(period_ticks * ps_div * NSEC_PER_SEC=
, pc->clk_rate);
> +
> +	if (pwm->hwpwm =3D=3D PWM_CHA)
> +		duty_ticks =3D readw(pc->mmio_base + CMPA);
> +	else
> +		duty_ticks =3D readw(pc->mmio_base + CMPB);
> +
> +	/*
> +	 * duty_cycle (in ns) =3D (duty_ticks * preescaler * 1e9) / clk_rate
> +	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
> +	 */
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(duty_ticks * ps_div * NSEC_PER_S=
EC, pc->clk_rate);
> +
> +	/*
> +	 * The 'hwpwm' field identifies which hardware output channel (e.g.,
> +	 * 0 for channel A and 1 for channel B) of the eHRPWM module is in use.
> +	 */
> +	if (pwm->hwpwm =3D=3D PWM_CHA) {
> +		aqctl_reg =3D readw(pc->mmio_base + AQCTLA);
> +		up_action =3D FIELD_GET(AQCTL_CAU_MASK, aqctl_reg);
> +		down_action =3D FIELD_GET(AQCTL_CAD_MASK, aqctl_reg);
> +	} else {
> +		aqctl_reg =3D readw(pc->mmio_base + AQCTLB);
> +		up_action =3D FIELD_GET(AQCTL_CBU_MASK, aqctl_reg);
> +		down_action =3D FIELD_GET(AQCTL_CBD_MASK, aqctl_reg);
> +	}
> +
> +	/*
> +	 * Evaluate the actions to determine the PWM polarity:
> +	 *  - In this driver, NORMAL polarity is programmed as:
> +	 *      ZRO =3D FRCHIGH and CAx/CDx =3D FRCLOW.
> +	 *  - INVERSED polarity is programmed as:
> +	 *      ZRO =3D FRCLOW and CAx/CDx =3D FRCHIGH.
> +	 *
> +	 * So if both up/down compare actions are FRCLOW we treat it as
> +	 * NORMAL, and if both are FRCHIGH we treat it as INVERSED.
> +	 */
> +	if (up_action =3D=3D AQCTL_FRCLOW && down_action =3D=3D AQCTL_FRCLOW) {
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +	} else if (up_action =3D=3D AQCTL_FRCHIGH && down_action =3D=3D AQCTL_F=
RCHIGH) {
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +	} else {
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +		dev_dbg(pwmchip_parent(chip),
> +			"ehrpwm: unknown polarity bits (0x%x/0x%x), defaulting to NORMAL\n",
> +			up_action, down_action);
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct pwm_ops ehrpwm_pwm_ops =3D {
>  	.free =3D ehrpwm_pwm_free,
>  	.apply =3D ehrpwm_pwm_apply,
> +	.get_state =3D ehrpwm_get_state,
>  };

Without having looked in detail:=20

A superior improvement over implementing .get_state() is implementing the
new callbacks round_waveform_tohw, round_waveform_fromhw, read_waveform
and write_waveform. And bonus points if you also implement offset
support.

(A "no" here is completely fine, just let me know if you like the idea
and want to work on it. Otherwise I'll look in more detail here.)

At one point in time I had that on my todo list but dropped the ball
after the fixes that went into 6.18-rc1.

>  static const struct of_device_id ehrpwm_of_match[] =3D {

Best regards
Uwe

--zdwab6zzkumaazei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkkjSAACgkQj4D7WH0S
/k5Wiwf6AlDwzeACMDlUOtVw5/wORS7aG8L1euxaE3835A9mS8CMX03B0N5Qt+Uk
F8dZwdrQQMDqOXgvK/fyArCoeezvcKfkhvlZjGfLhPq75ZVZIwA7R3HOjB+clLit
jbc6IEh7upcV8z3bhQlK3CL7dVTVZScksXz41Pipndq2BoyiKykOKmXS8ovtR45M
m9OqFgvTgGiF2zS1p1KVdtBOXzGHPg70r0KuVxuKMa4z3bhOkbWJaf0a3TcYOfjT
D3aoo9oCfWrRNaL6LxhHhnKAs2t5vBHFswHuzKYZwycO+RQEbxQrb00rtkvGJ02V
eANgLrD8GQ9J/uEpia5IvYNQQGPSFA==
=snP6
-----END PGP SIGNATURE-----

--zdwab6zzkumaazei--

