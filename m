Return-Path: <linux-pwm+bounces-5287-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B0A715CC
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 12:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8936916FD2B
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F91D6DD4;
	Wed, 26 Mar 2025 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Edwfmcyr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615AA1B87F2;
	Wed, 26 Mar 2025 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988756; cv=none; b=sr0PRe7pxZVCBePKeCtLbUiZ+lrnT1sB2/NrSreBGvwUuiYjvIEYlJf9rpuHZXRpupA88N4vHLPYx2ki7YZZxvItIN+1ws2la5Eyk2DUIMNMDUM0gXUsADndzUaHG+xebI2J0HMmM9hmoXkUpzrP8bSLdcv0Pvl5Dmc116e2K8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988756; c=relaxed/simple;
	bh=q7DwmVhXt+r1eeJ0Yd69/IgoEkDDwrwkgbKKbHqRxU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKoZWE4a+1qxAIbT9kuZDPXUYayYxab13KbQG+lrbffSJgAjlIQ9wUAOK3Fv71PLvT/HHszXvAp/NEHgchIT9u/hbnX26tMmwVERuX0mvatSE3GqLtRsxYMZVHMPi8lGRMkpZtB+YpxJeEra49W/jbox23sWI1vXrqIDl2a4w70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Edwfmcyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4C5C4CEE2;
	Wed, 26 Mar 2025 11:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742988755;
	bh=q7DwmVhXt+r1eeJ0Yd69/IgoEkDDwrwkgbKKbHqRxU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdwfmcyrXDvf31OBxyvyihmDkKIQPI2mAzbKc8SR5GVWC+iqa72B26AnUzIl1uDJS
	 XiqdGYWRZ6qHKvuvfkgzJl0IYpsJduxAz1c/QoAxfe2tq0L9t1xVWnN4yaH/GijBsO
	 vDpJeb0BpX5pgjdk9xkErgWlW03xElTgNj2eG/HJE1oBp19Z3YM10PIIs7edcGz0ww
	 jehnRQldpiXoOtqVnY8sDKb4VjbtzCEVpbNayZe1VejxLOATydEgxOTSbPAhTTTuW/
	 abD3lhWOt0xHdKNsHG1z5tDm9Hq3xSyKYunpgHsxmTn8CjS8rYpCuTJukgHg6mb2i7
	 oXsywjveHQH3g==
Date: Wed, 26 Mar 2025 12:32:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] pwm: ehrpwm: add get_state function to retrieve
 PWM channel state
Message-ID: <vri7ypbwczwj3mrsdocy27k6g4umk3swq5uw34yds2yvri2sq3@7wnx5klo4gfs>
References: <20250207212954.934-1-rafael.v.volkmer@gmail.com>
 <20250207213234.1026-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dzn5ynb6ngfdh3pz"
Content-Disposition: inline
In-Reply-To: <20250207213234.1026-1-rafael.v.volkmer@gmail.com>


--dzn5ynb6ngfdh3pz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] pwm: ehrpwm: add get_state function to retrieve
 PWM channel state
MIME-Version: 1.0

Hello Rafael,

On Fri, Feb 07, 2025 at 06:32:34PM -0300, Rafael V. Volkmer wrote:
> The ehrpwm driver was missing a get_state function, which is required
> to properly retrieve the current state of the PWM channel. This commit
> adds the ehrpwm_get_state() function, allowing users to query the
> enabled state, period, duty cycle, and polarity of the PWM output.

s/This commit adds/Add/

> The function reads the relevant registers (AQCSFRC, AQCTLx, TBPRD, CMPA)
> to determine:
> - Whether the PWM is enabled or disabled
> - The configured period and duty cycle
> - The polarity based on action-qualifier configurations
>=20
> Additionally, this commit updates the pwm_ops structure to include
> .get_state, ensuring proper integration with the PWM subsystem.

The last two paragraphs are too verbose. I'd drop them.

> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 122 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 50516f46ab04..52527136c507 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -81,7 +81,9 @@
>  #define AQCTL_ZRO_MASK			GENMASK(1, 0)
>  #define AQCTL_PRD_MASK			GENMASK(3, 2)
>  #define AQCTL_CAU_MASK			GENMASK(5, 4)
> +#define AQCTL_CAD_MASK			GENMASK(7, 6)
>  #define AQCTL_CBU_MASK			GENMASK(9, 8)
> +#define AQCTL_CBD_MASK			GENMASK(11, 10)
> =20
>  /*
>   * FORCE LOW	=3D> 0b01
> @@ -495,9 +497,129 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	return err;
>  }
> =20
> +/**
> + * ehrpwm_get_state - Retrieves the current state of the eHRPWM channel
> + * @chip:	pointer to the PWM chip structure
> + * @pwm:	pointer to the PWM device structure
> + * @state:	pointer to the pwm_state structure to be filled
> + *
> + * @return:	0 on success or a negative error code on failure
> + */
> +static int ehrpwm_get_state(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +							struct pwm_state *state)
> +{
> +	int ret =3D 0u;
> +
> +	struct ehrpwm_pwm_chip *pc =3D NULL;
> +
> +	unsigned long long tbclk_rate =3D 0u;
> +
> +	/* Registers */
> +	u16 aqcsfrc_reg =3D 0u;
> +	u16 aqctl_reg =3D 0u;
> +	u16 tbprd_reg =3D 0u;
> +	u16 cmpa_reg =3D 0u;

No need to initialize these. Also please drop the u suffix (which is
also inconsistant as you used U in patch #1). And then they can group
them in single code lines (i.e.

	u16 aqcsfrc_reg, aqctl_reg, tbprd_reg, cmpa_reg;

).

> +	/* Bits */
> +	u8 csf_bits =3D 0u;
> +
> +	/* Values */
> +	u64 period_cycles =3D 0u;
> +	u64 duty_cycles =3D 0u;
> +
> +	/* Actions */
> +	u8 up_action =3D 0u;
> +	u8 down_action =3D 0u;
> +
> +	if (chip =3D=3D NULL || pwm =3D=3D NULL || state =3D=3D NULL)
> +		return -EINVAL;

Drop this check, the core makes sure these are all valid.

> +	pc =3D to_ehrpwm_pwm_chip(chip);
> +	if (pc =3D=3D NULL || pwm =3D=3D NULL || state =3D=3D NULL)
> +		return -EINVAL;

Some of these you already checked above (so drop these, too). In my eyes
you can assume that to_ehrpwm_pwm_chip() doesn't return NULL.

> +	tbclk_rate =3D clk_get_rate(pc->tbclk);
> +	if (tbclk_rate <=3D 0)
> +		return -EINVAL;

tbclk_rate is long long while the return value of clk_get_rate is long
only. Also given that tbclk_rate is unsigned <=3D doesn't make much sense.

Also note that clk_get_rate() is only supposed to be called for an
enabled clock.

> +	/*< Get if EHRPWM is enable by checking registers values >*/

s/enable/enabled/

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
> +
> +	else if (aqctl_reg)
> +		state->enabled =3D true;

	else
		state->enable is uninitialized :-\

> +	/*< Get EHRPWM Period by checking registers values >*/

This is kind of obvious. What is that /*< style? Looks like a bird :-)

> +	tbprd_reg =3D readw(pc->mmio_base + TBPRD);
> +	period_cycles =3D (u64)(tbprd_reg + 1u);

Maybe you need to cast first and then add 1?

> +	/*
> +	 * period (in ns) =3D (period_cycles * 1e9) / tbclk_rate
> +	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
> +	 */
> +	state->period =3D DIV_ROUND_UP_ULL(period_cycles * NSEC_PER_SEC, tbclk_=
rate);
> +
> +	/*< Get EHRPWM Duty Cycle by checking registers values >*/
> +	cmpa_reg =3D readw(pc->mmio_base + CMPA);
> +	duty_cycles =3D cmpa_reg;
> +
> +	/*
> +	 * duty_cycle (in ns) =3D (duty_cycles * 1e9) / tbclk_rate
> +	 * Using DIV_ROUND_UP_ULL to avoid floating-point operations.
> +	 */
> +	state->duty_cycle  =3D DIV_ROUND_UP_ULL(duty_cycles * NSEC_PER_SEC, tbc=
lk_rate);

s/  / /

> +
> +	/*< Get EHRPWM polarity by checking registers values >*/
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
> +
> +	/*
> +	 * Evaluate the actions to determine the PWM polarity:
> +	 *  - If an up-count event sets the output (AQCTL_FRCHIGH) and a down-c=
ount
> +	 *    event clears it (AQ_CLEAR), then polarity is NORMAL.
> +	 *  - If an up-count event clears the output (AQ_CLEAR) and a down-count
> +	 *    event sets it (AQCTL_FRCLOW), then polarity is INVERSED.
> +	 */
> +	if (up_action =3D=3D AQCTL_FRCHIGH && down_action =3D=3D AQCTL_FRCLOW)
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	else if (up_action =3D=3D AQCTL_FRCLOW && down_action =3D=3D AQCTL_FRCH=
IGH)
> +		state->polarity =3D PWM_POLARITY_INVERSED;

	else ??? (maybe return an error?)

> +	return ret;
> +}
> +

Best regards
Uwe

--dzn5ynb6ngfdh3pz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfj5c4ACgkQj4D7WH0S
/k4utwgAmsr1tEJGrSSugB+yqB0uNpRNpyYQOnz0rQCx8dNFYSm66VKV41oUtXBN
k+x+LxC9c11itQNuBOY2QIhORp54XXawyE60NeLf21AVssjpkNWY/j4r/h+px6lB
62HeNdk6o/VZmsEqNyqQcIbhqqM9tiBeiQBlu1on49/e0xUhGJxOepv/L+PPliHt
SFzHgQ41mwZ9tzQEkRpaTA/tbnMaiDRsPRQHaETPrvoRKCGC92XP1PIgRn+JMttS
o3Pz8HbZoqEtYxBa1K1rZsGztb3qPM9BppuEKGlYWAAqQWSd/d9srU7UW1Ksyd4W
XwinP2suXvTa/rxSrid1TSLoTJIfuQ==
=r6LV
-----END PGP SIGNATURE-----

--dzn5ynb6ngfdh3pz--

