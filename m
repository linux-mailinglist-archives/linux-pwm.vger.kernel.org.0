Return-Path: <linux-pwm+bounces-2204-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0EA8CAEFA
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 15:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128D8283FFD
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AA47C09E;
	Tue, 21 May 2024 13:06:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED280046
	for <linux-pwm@vger.kernel.org>; Tue, 21 May 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296769; cv=none; b=pS7iK8m2kHF0u4mZ4bsaf/jSSLLcVtQjO9806jJTe50B7SrELLrJlapIU8OmSJFyxW0vnBfN/6ejWEctsIAJsdHJgsk7Lkzgzn79zSltpUP+8Sd2w7gdW2s4rOPOsmxDgjOrWMz/llJmAz7E5N+XiQLTYs/1aa1d7RwVqRAn6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296769; c=relaxed/simple;
	bh=Gm4Rfz371L48OCVFj/POrZrHcEmt4Wh36gFUtfw+L2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5IG5irjJn1CMg8wLtrik1/Fhy6eS9A4I7+PlGk/vv5uWz+d0eAJ+XXpFoa+jTmKSAmdGoJqfKiWbZsHT32xoFql3Jp4DIaOH3oMC7DiZrLE8tfbVVW9GldyISxakZt/T5FMuhJyLgSbXOP9FjV7mjp7gCTje+KqDUMW/H6SbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9PBi-0000Dp-Ik; Tue, 21 May 2024 15:05:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9PBh-002OPX-SC; Tue, 21 May 2024 15:05:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9PBh-009TFH-2X;
	Tue, 21 May 2024 15:05:53 +0200
Date: Tue, 21 May 2024 15:05:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH 5/5] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <xobmekjwqanow765yr42tsgknc5gc7szjublq6ywgbmoxovlr5@v3sofz5bmkol>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-6-laurent.pinchart@ideasonboard.com>
 <dl7a6puox5lc36fpto2fgyfgmpd3uboqc4lcfdtuaxzzsboqld@alw7vyi7pqjz>
 <20240521100922.GF16345@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kumwfefmbg4urjq2"
Content-Disposition: inline
In-Reply-To: <20240521100922.GF16345@pendragon.ideasonboard.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--kumwfefmbg4urjq2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropping Alexandru Ardelean from Cc as their address bounces]

On Tue, May 21, 2024 at 01:09:22PM +0300, Laurent Pinchart wrote:
> On Tue, May 21, 2024 at 10:51:26AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, May 20, 2024 at 10:59:41PM +0300, Laurent Pinchart wrote:
> > > +	ret =3D regmap_update_bits(adp5585_pwm->regmap, ADP5585_GENERAL_CFG,
> > > +				 ADP5585_OSC_EN, ADP5585_OSC_EN);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return 0;
> >=20
> > The last four lines are equivalent to
> >=20
> > 	return ret;
>=20
> I prefer the existing code but can also change it.

Well, I see the upside of your approach. If this was my only concern I
wouldn't refuse to apply the patch.

> > > +	regmap_update_bits(adp5585_pwm->regmap, ADP5585_GENERAL_CFG,
> > > +			   ADP5585_OSC_EN, 0);
> > > +}
> > > +
> > > +static int pwm_adp5585_apply(struct pwm_chip *chip,
> > > +			     struct pwm_device *pwm,
> > > +			     const struct pwm_state *state)
> > > +{
> > > +	struct adp5585_pwm_chip *adp5585_pwm =3D to_adp5585_pwm_chip(chip);
> > > +	u32 on, off;
> > > +	int ret;
> > > +
> > > +	if (!state->enabled) {
> > > +		guard(mutex)(&adp5585_pwm->lock);
> > > +
> > > +		return regmap_update_bits(adp5585_pwm->regmap, ADP5585_PWM_CFG,
> > > +					  ADP5585_PWM_EN, 0);
> > > +	}
> > > +
> > > +	if (state->period < ADP5585_PWM_MIN_PERIOD_NS ||
> > > +	    state->period > ADP5585_PWM_MAX_PERIOD_NS)
> > > +		return -EINVAL;
> >=20
> > Make this:
> >=20
> > 	if (state->period < ADP5585_PWM_MIN_PERIOD_NS)
> > 		return -EINVAL;
> >=20
> > 	period =3D min(ADP5585_PWM_MAX_PERIOD_NS, state->period)
> > 	duty_cycle =3D min(period, state->period);
>=20
> I haven't been able to find documentation about the expected behaviour.
> What's the rationale for returning an error if the period is too low,
> but silently clamping it if it's too high ?

Well, it's only implicitly documented in the implementation of
PWM_DEBUG. The reasoning is a combination of the following thoughts:

 - Requiring exact matches is hard to work with, so some deviation
   between request and configured value should be allowed.
 - Rounding in both directions has strange and surprising effects. The
   corner cases (for all affected parties (=3Dconsumer, lowlevel driver
   and pwm core)) are easier if you only round in one direction.
   One ugly corner case in your suggested patch is:
   ADP5585_PWM_MAX_PERIOD_NS corresponds to 0xffff clock ticks.
   If the consumer requests period=3D64000.2 clock ticks, you configure
   for 64000. If the consumer requests period=3D65535.2 clock ticks you
   return -EINVAL.
   Another strange corner case is: Consider a hardware that can
   implement the following periods 499.7 ns, 500.2 ns, 500.3 ns and then
   only values >502 ns.
   If you configure for 501 ns, you'd get 500.3 ns. get_state() would
   tell you it's running at 500 ns. If you then configure 500 ns you
   won't get 500.3 ns any more.
 - If you want to allow 66535.2 clock ticks (and return 65535), what
   should be the maximal value that should yield 65535? Each cut-off
   value is arbitrary, so using \infty looks reasonable (to me at
   least).
 - Rounding down is easier than rounding up, because that's what C's /
   does. (Well, this is admittedly a bit arbitrary, because if you round
   down in .apply() you have to round up in .get_state().)

> > round-closest is wrong. Testing with PWM_DEBUG should point that out.
> > The right algorithm is:
> >=20
> > 	on =3D duty_cycle / (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
> > 	off =3D period / (NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ) - on
> >=20
> >=20
> > > +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > > +		swap(on, off);
> >=20
> > Uhh, no. Either you can do inverted polarity or you cannot. Don't claim
> > you can.
>=20
> OK, but what's the rationale ? This is also an area where I couldn't
> find documentation.

I don't have a good rationale here. IMHO this inverted polarity stuff is
only a convenience for consumers because the start of the period isn't
visible from the output wave form (apart from (maybe) the moment where
you change the configuration) and so

	.period =3D 5000, duty_cycle =3D 1000, polarity =3D PWM_POLARITY_NORMAL

isn't distinguishable from

	.period =3D 5000, duty_cycle =3D 4000, polarity =3D PWM_POLARITY_INVERSED

=2E But it's a historic assumption of the pwm core that there is a
relevant difference between the two polarities and I want at least a
consistent behaviour among the lowlevel drivers. BTW, this convenience
is the reason I'm not yet clear how I want to implemement a duty_offset.

> > > +	ret =3D devm_pwmchip_add(&pdev->dev, &adp5585_pwm->chip);
> > > +	if (ret) {
> > > +		mutex_destroy(&adp5585_pwm->lock);
> > > +		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void adp5585_pwm_remove(struct platform_device *pdev)
> > > +{
> > > +	struct adp5585_pwm_chip *adp5585_pwm =3D platform_get_drvdata(pdev);
> > > +
> > > +	mutex_destroy(&adp5585_pwm->lock);
> >=20
> > Huh, this is a bad idea. The mutex is gone while the pwmchip is still
> > registered. AFAIK calling mutex_destroy() is optional, and
> > adp5585_pwm_remove() can just be dropped. Ditto in the error paths of
> > .probe().
>=20
> mutex_destroy() is a no-op when !CONFIG_DEBUG_MUTEXES. When the config
> option is selected, it gets more useful. I would prefer moving away from
> the devm_* registration, and unregister the pwm_chip in .remove()
> manually, before destroying the mutex.

In that case I'd prefer a devm_mutex_init()?!
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kumwfefmbg4urjq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZMnDAACgkQj4D7WH0S
/k6cSgf9GGbNJK6nrF2obOZaaHxRDIpOYDcxw0EnZdOniUP0LlmCDHna8Awg+NAZ
XMkcq0a60qCSMNDLSJqjm8mF4zwWmlUl9NLyRIjptLAM7g8D5N8MkPsxPIfXcA2o
KeC8zxOriHRK5Pju5wMXdVg4Vkmre8i5GgWHqH4dGcJILfFtU+xiAy5J9S9RYfyU
xI67jpvDLuAfknGQcNGpaHrS0Z1MkrcG7yr1IJdyfu6VTDiW7RvH6SUufd004lfL
w1uO2vXMAHO9lmKgnTT8j6u2edjxyuWVLZPn71yVTqAZ5aPaWPAQCV5Qbyd3sgJY
nTjKK/hJUb8bN5cFPij9tjhFMwlN2Q==
=VRiY
-----END PGP SIGNATURE-----

--kumwfefmbg4urjq2--

