Return-Path: <linux-pwm+bounces-2221-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A313C8CC48A
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFEBDB2403A
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 15:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FB4210EC;
	Wed, 22 May 2024 15:54:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8377D3F6
	for <linux-pwm@vger.kernel.org>; Wed, 22 May 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393245; cv=none; b=EHd2VrjHcoDGrCz6xzsMBP+uySe4Ikzk+SXGvE3n4zqqiZUre23PWl0+Q0MbIdPTg02vgIBcE4imHTf/1iUfQ3ZX742lxoRZRuEFgoyU3DvBINm8dUZiAC/z11s3RyCFdjhr5IFzX6D9459gWxyY7OC1unt+reSakl6rbt6m6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393245; c=relaxed/simple;
	bh=to0sQNlWsC0XK/kopHRIttkU4lEn+bubnkhzZoOrXdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnJ7jKjlkEoTjhR7nuPDvdZU6ORznitFic5YCEwhDFBTLMDOsKgHjAsqkr9Su5CpE6qfXRu/oyZskZ1FcGyVxfoaLftmAOXk/IR1CpEh4mHmuNFpMnmTIfbI57BcH2UoYRNcGhdElYIXk3eR951JL+UbGUtT7Tr/d3q0163ZPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9oHq-0003du-9h; Wed, 22 May 2024 17:53:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9oHp-002XrX-EB; Wed, 22 May 2024 17:53:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9oHp-00A7aZ-19;
	Wed, 22 May 2024 17:53:53 +0200
Date: Wed, 22 May 2024 17:53:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH 1/2 v3] pwm: add duty offset support
Message-ID: <73y7ovftjv35gw3sjeu3jisg7feplhyebmcnldqvszuofqnn7q@eh4lyicuhfmq>
References: <20240521194916.1897909-1-tgamblin@baylibre.com>
 <20240521194916.1897909-2-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rv7d2yo4lgaqszb2"
Content-Disposition: inline
In-Reply-To: <20240521194916.1897909-2-tgamblin@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--rv7d2yo4lgaqszb2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trevor,

On Tue, May 21, 2024 at 03:49:15PM -0400, Trevor Gamblin wrote:
> Some PWM chips support a "phase" or "duty_offset" feature. This patch
> continues adding support for configuring this property in the PWM
> subsystem.
>=20
> Functions duty_offset_show(), duty_offset_store(), and
> pwm_get_duty_offset() are added to match what exists for duty_cycle.
>=20
> Add a check to disallow applying a state with both inversed polarity and
> a nonzero duty_offset.
>=20
> Also add duty_offset to TP_printk in include/trace/events/pwm.h so that
> it is reported with other properties when using the event tracing pipe
> for debug.
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> v3 changes:
> * rebased on top of latest pwm/for-next
> * removed changes related to cdev to match current pwm tree
> * fixed minor whitespace issue caught by checkpatch
>=20
> v2 changes:
> * Address feedback for driver in v1:
>   * Remove line setting supports_offset flag in pwm_chip, since that has
>     been removed from the struct in core.c.
>=20
> ---
>  drivers/pwm/core.c         | 79 +++++++++++++++++++++++++++++++++++---
>  include/linux/pwm.h        | 15 ++++++++
>  include/trace/events/pwm.h |  6 ++-
>  3 files changed, 93 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 18574857641e..2ebfc7f3de8a 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -62,6 +62,7 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>  	 */
>  	if (s1.enabled && s1.polarity !=3D state->polarity) {
>  		s2.polarity =3D state->polarity;
> +		s2.duty_offset =3D s1.duty_cycle;

s/duty_cycle/duty_offset/

>  		s2.duty_cycle =3D s1.period - s1.duty_cycle;
>  		s2.period =3D s1.period;
>  		s2.enabled =3D s1.enabled;
> @@ -103,6 +104,23 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>  			 state->duty_cycle, state->period,
>  			 s2.duty_cycle, s2.period);
> =20
> +	if (state->enabled &&
> +	    last->polarity =3D=3D state->polarity &&
> +	    last->period =3D=3D s2.period &&
> +	    last->duty_offset > s2.duty_offset &&
> +	    last->duty_offset <=3D state->duty_offset)
> +		dev_warn(pwmchip_parent(chip),
> +			 ".apply didn't pick the best available duty offset (requested: %llu/=
%llu, applied: %llu/%llu, possible: %llu/%llu)\n",
> +			 state->duty_offset, state->period,

Does it make sense to emit $duty_offset/$period here? Establishing a
consistent way to write this would be nice. Something like:

	$duty_cycle/$period [+$duty_offset]

maybe?

> +			 s2.duty_offset, s2.period,
> +			 last->duty_offset, last->period);
> +
> +	if (state->enabled && state->duty_offset < s2.duty_offset)
> +		dev_warn(pwmchip_parent(chip),
> +			 ".apply is supposed to round down duty_offset (requested: %llu/%llu,=
 applied: %llu/%llu)\n",
> +			 state->duty_offset, state->period,
> +			 s2.duty_offset, s2.period);
> +
>  	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
>  		dev_warn(pwmchip_parent(chip),
>  			 "requested disabled, but yielded enabled with duty > 0\n");
> @@ -126,12 +144,13 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>  	if (s1.enabled !=3D last->enabled ||
>  	    s1.polarity !=3D last->polarity ||
>  	    (s1.enabled && s1.period !=3D last->period) ||
> +	    (s1.enabled && s1.duty_offset !=3D last->duty_offset) ||
>  	    (s1.enabled && s1.duty_cycle !=3D last->duty_cycle)) {
>  		dev_err(pwmchip_parent(chip),
> -			".apply is not idempotent (ena=3D%d pol=3D%d %llu/%llu) -> (ena=3D%d =
pol=3D%d %llu/%llu)\n",
> +			".apply is not idempotent (ena=3D%d pol=3D%d %llu/%llu/%llu) -> (ena=
=3D%d pol=3D%d %llu/%llu/%llu)\n",
>  			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
> -			last->enabled, last->polarity, last->duty_cycle,
> -			last->period);
> +			s1.duty_offset, last->enabled, last->polarity,
> +			last->duty_cycle, last->period, last->duty_offset);
>  	}
>  }
> =20
> @@ -146,13 +165,24 @@ static int __pwm_apply(struct pwm_device *pwm, cons=
t struct pwm_state *state)
>  	int err;
> =20
>  	if (!pwm || !state || !state->period ||
> -	    state->duty_cycle > state->period)
> +	    state->duty_cycle > state->period ||
> +	    state->duty_offset > state->period)
>  		return -EINVAL;
> =20
>  	chip =3D pwm->chip;
> =20
> +	/*
> +	 * There is no need to set duty_offset with inverse polarity,
> +	 * since signals with duty_offset values greater than 0.5 *
> +	 * period can equivalently be represented by an inverted signal
> +	 * without offset.

This isn't exact. The equation is:

	state_with_offset.period =3D inverted_state.period
	state_with_offset.duty_cycle =3D inverted_state.period - inverted_state.du=
ty_cycle
	state_with_offset.duty_offset =3D inverted_state.duty_cycle

And with duty_offset you can express more wave-forms than with
inversion.

> +	 */
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED && state->duty_offset)
> +		return -EINVAL;
> +
>  	if (state->period =3D=3D pwm->state.period &&
>  	    state->duty_cycle =3D=3D pwm->state.duty_cycle &&
> +	    state->duty_offset =3D=3D pwm->state.duty_offset &&
>  	    state->polarity =3D=3D pwm->state.polarity &&
>  	    state->enabled =3D=3D pwm->state.enabled &&
>  	    state->usage_power =3D=3D pwm->state.usage_power)

While I like the added expressiveness of having .duty_offset, I think we
shouldn't let the low-level drivers face both .duty_offset and
=2Epolarity.

I suggest to add a new callback similar to .apply that gets passed a
variant of pwm_state that only has

	u64 period
	u64 duty_cycle
	u64 duty_offset

period =3D 0 then signals disable. Implementers are then supposed to first
round down period to a possible period (> 0), then duty_cycle to a
possible duty_cycle for the picked period and then duty_offset to a
possible duty_offset with the picked period and duty_cycle.

Then there is a single code location that handles the translation
between state with polarity and state with duty_offset in the core,
instead of case switching in each lowlevel driver. And I wouldn't
add .duty_offset to the sysfs interface, to lure people into using the
character device support which has several advantages over the sysfs
API. (One reasonable justification is that we cannot remove polarity
there, and we also cannot report polarity =3D normal + some duty_offset
without possibly breaking assumptions in sysfs users.)

What is missing in my plan is a nice name for the new struct pwm_state
and the .apply() (and matching .get_state()) callback. Maybe pwm_nstate,
=2Eapply_nstate() and .get_nstate()? n for "new", which however won't age
nicely. Maybe it also makes sense to add a .round_nstate() in the same
go. We'd have to touch all drivers anyhow and implementing a rounding
callback (that has similar semantics to clk_round_rate() for clocks,
i.e. it reports what would be configured for a given (n)state) isn't
much more work. With rounding in place we could also request that
=2Eapply_nstate() only succeeds if rounding down decrements the values by
less than 1, which gives still more control. (The more lax variant can
then be implemented by first passing an nstate to .round_nstate and then
=2Eapply_nstate that one.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rv7d2yo4lgaqszb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZOFRAACgkQj4D7WH0S
/k4EFggApvBQ7BUAVSvRWmjJxQJ7WuGh6x2wdqla96igaBRP+5lPqmsYZ8XXSZAm
f+/DLkMm42gwrxL0Y1B/7gyIfpH2Mv5VJCoyh1E4RHTnxl5Tnd9RD4a00HsHv45j
00Jrb9o6yG/cjRLXPwVCnk81+m8hMFkI5BNGcR9j5ffSvqLJBjUEd+hBVugiwykd
LX2fDaNhx8HIBkRZmEKDTSWo1xocyPapGlykK31LRpgr1m85mpyMuqHhI5lLcn/n
Qxu3LIr07rUCy3oNTOKhikRGwvc2NYKNTZof3lhFHdoYHKwIm0WdWLTWICzthWy/
ZwktP1K4Ej0ISOqlwwES9l8frZJkDQ==
=Zc/O
-----END PGP SIGNATURE-----

--rv7d2yo4lgaqszb2--

