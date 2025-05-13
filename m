Return-Path: <linux-pwm+bounces-5939-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01EAB4FB6
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 11:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A86C164F5B
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9874421FF43;
	Tue, 13 May 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXOU5tqT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F746210F44;
	Tue, 13 May 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128446; cv=none; b=ZWd2AnwX2amRKuAuYIcTN10LCzHR6i8TC5prBIJmyUDnIAm6Ac0aI7Wg8S+fguZ1mJ5kk9Sib/k0v8A/RI0FFniRunu3mHpjFDDrNEQuopmvfbiM3ZFHI0g1/g1SxP6MudrCWWwyD7gW21w87V5k2Vko7Khr8z9ymBD7BSeat0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128446; c=relaxed/simple;
	bh=Wg06r22yGHw69tTIasp8otwWawX8Zrx13Gm/NsTM7Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNma8kZ6W4puuXvJWO0x9SuWp+VaoxMIaQmvJBt2ufU4vCUmpKhUQ87tfY/aeQzohArwlDdAZ4Gv3yl8yCA/5NjBAbjDw3xzbAfoczGMKsu06iNvhywJAlhTryEhe8TL2EpnnSbqbI2xO7YlwmyEJNGQs5njp8dA37sIgYcUh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXOU5tqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911ECC4CEE4;
	Tue, 13 May 2025 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747128445;
	bh=Wg06r22yGHw69tTIasp8otwWawX8Zrx13Gm/NsTM7Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXOU5tqTKTQ3t/0vHaE4JWvwxAWoB0ZmFNE1dtIbU15cbRGFohh4TtKYEDmSdNssG
	 am042avuucvbAyB/Y48h7JJfhSeDCcso5SgQCr/77VlRyeRAhOnBVCYf2nOmZ6XJnv
	 ttJ3QC9x3P16UDLAfBjTALn8OoGwRVmzLHk4DjNzWApxortuMpt7GNsRcjbT0sI01S
	 IbPChFCT5UtvaGBL87DesezQ+bOtmwW4FrehqSJ1L/u+NS1hvSdvCWU+P+XsLhPqTa
	 9X/Lj+KxAlqfdb9tEeksLQncleQsywzbHFNuOTg82fO1nd5fKT+2vhgNsjnbS+XLb2
	 2SymKu+QCMIHg==
Date: Tue, 13 May 2025 11:27:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pwm: tiehrpwm: add get_state function to retrieve
 PWM channel state
Message-ID: <iguu6qhympqyoyxxqwwlyceg4qk2pwqodwfvwh2q45z5hqkqdv@zinbt6go5rqn>
References: <20250419194835.77860-1-rafael.v.volkmer@gmail.com>
 <20250419195555.78933-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gdjj4z3ymrkqaokk"
Content-Disposition: inline
In-Reply-To: <20250419195555.78933-1-rafael.v.volkmer@gmail.com>


--gdjj4z3ymrkqaokk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/4] pwm: tiehrpwm: add get_state function to retrieve
 PWM channel state
MIME-Version: 1.0

Hello Rafael,

On Sat, Apr 19, 2025 at 04:55:55PM -0300, Rafael V. Volkmer wrote:
> The ehrpwm driver was missing a get_state function, which is required
> to properly retrieve the current state of the PWM channel. Add the
> ehrpwm_get_state() function, allowing users to query the enabled state,
> period, duty cycle, and polarity of the PWM output.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 97 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 1ead1aa91a1a..cde331a73696 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -68,7 +68,9 @@
>  #define AQCTL_ZRO_MASK	GENMASK(1, 0)
>  #define AQCTL_PRD_MASK	GENMASK(3, 2)
>  #define AQCTL_CAU_MASK	GENMASK(5, 4)
> +#define AQCTL_CAD_MASK	GENMASK(7, 6)
>  #define AQCTL_CBU_MASK	GENMASK(9, 8)
> +#define AQCTL_CBD_MASK	GENMASK(11, 10)
> =20
>  /* common action codes (2=E2=80=91bit) */
>  #define AQCTL_FRCLOW	1
> @@ -470,9 +472,104 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, =
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
> +	u16 aqcsfrc_reg, aqctl_reg, tbprd_reg, cmpa_reg;
> +
> +	/* Bits */
> +	u8 csf_bits;
> +
> +	/* Values */
> +	u64 period_cycles, duty_cycles;
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
> +	if (pwm->hwpwm =3D=3D 0) {
> +		aqcsfrc_reg =3D readw(pc->mmio_base + AQCSFRC);
> +		csf_bits =3D FIELD_GET(AQCSFRC_CSFA_MASK, aqcsfrc_reg);
> +		aqctl_reg =3D readw(pc->mmio_base + AQCTLA);
> +	} else {
> +		aqcsfrc_reg =3D readw(pc->mmio_base + AQCSFRC);
> +		csf_bits =3D FIELD_GET(AQCSFRC_CSFB_MASK, aqcsfrc_reg);
> +		aqctl_reg =3D readw(pc->mmio_base + AQCTLB);
> +	}
> +
> +	if (csf_bits)
> +		state->enabled =3D false;
> +	else if (aqctl_reg)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;

if (csf_bits || !aqctl_reg) {
	state->enabled =3D false;
	return 0;
}

?
=09
> +
> +	tbprd_reg =3D readw(pc->mmio_base + TBPRD);
> +	period_cycles =3D (u64)tbprd_reg + 1u;
> +
> +	/*
> +	 * period (in ns) =3D (period_cycles * 1e9) / clk_rate
> +	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
> +	 */
> +	state->period =3D DIV_ROUND_UP_ULL(period_cycles * NSEC_PER_SEC, pc->cl=
k_rate);
> +
> +	cmpa_reg =3D readw(pc->mmio_base + CMPA);
> +	duty_cycles =3D cmpa_reg;

duty_cycles =3D readw(pc->mmio_base + CMPA);

and drop the otherwise unused cmpa_reg.

I would expect that you need to read CMPB for hwpwm =3D=3D 1?

I see the naming is consistent with ehrpwm_pwm_config, but I'd prefer
period_ticks and duty_ticks over period_cycles and duty_cycles. Then
it's clear that the unit is clock ticks and not ns.

> +	/*
> +	 * duty_cycle (in ns) =3D (duty_cycles * 1e9) / clk_rate
> +	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
> +	 */
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(duty_cycles * NSEC_PER_SEC, pc->=
clk_rate);
> +
> +	/*
> +	 * The 'hwpwm' field identifies which hardware output channel (e.g.,
> +	 * 0 for channel A and 1 for channel B) of the eHRPWM module is in use.
> +	 */
> +	if (pwm->hwpwm =3D=3D 0) {
> +		aqctl_reg =3D readw(pc->mmio_base + AQCTLA);
> +		up_action =3D FIELD_GET(AQCTL_CAU_MASK, aqctl_reg);
> +		down_action =3D FIELD_GET(AQCTL_CAD_MASK, aqctl_reg);
> +	} else {
> +		aqctl_reg =3D readw(pc->mmio_base + AQCTLB);
> +		up_action =3D FIELD_GET(AQCTL_CBU_MASK, aqctl_reg);
> +		down_action =3D FIELD_GET(AQCTL_CBD_MASK, aqctl_reg);
> +	}

When you send a new revision, please start a new thread.

Best regards
Uwe

--gdjj4z3ymrkqaokk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgjEHgACgkQj4D7WH0S
/k6moAf/cQFPZ4ZF9AmccXdb9k8uDXklzqySktF6cFaaZT+Gds3GYfSV/dL+kgZ9
hLgUjt6l0nvChDTUSUp2HXLrYqYaW1HPKKlgujHWTdzQi6I8c5Jm19mMWmkP1Foh
YqakAuZlDXbBrBCOjYOwCJMEsQ98qvf09aVIYsIrxseCNVga1kYYHZzDTbY9Us/I
64VLyjyPANQ/+4StOsX7y5SCF7on6fiIVxWeX2JOjLB7PX/NtDZ/tFQ7lJ9TxqhK
ZFoUKJIyfKxtecQ3YdfKHNONTnoTfOI+NkXoMqWeeQ+YTK1jrkoB06Ofw7GEggXz
AvkIPyGVdhmyz+k/961d16hgfmMrvw==
=8q+T
-----END PGP SIGNATURE-----

--gdjj4z3ymrkqaokk--

