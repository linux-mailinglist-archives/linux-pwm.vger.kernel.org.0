Return-Path: <linux-pwm+bounces-5266-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44AEA6B48D
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Mar 2025 07:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B21189B158
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Mar 2025 06:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4C41EB18C;
	Fri, 21 Mar 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxM9mPg4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C51E8333;
	Fri, 21 Mar 2025 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539482; cv=none; b=sDcBmEprtR3ITiehMa8ITXcx84UoigaXhG2REx21NY/ug+I+mhi92WWeZjg5/E16CTesWEryUe74KS6TKYMBF4URXWZZBkyP7N0jSjMhGYkg4PNu7GJ+dY6XVAdX7NXjyhceJAT+pk697WWgWdF+tRiXSmvs3twM92/an7vO/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539482; c=relaxed/simple;
	bh=TvkXbuZksInpmuRFp/TO+JRhs221zttzfw4xU5f3CPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBWBodnU01iGOPabyTdsG/OZFqxaMC5/vHKRP2aWdYkaQAssmvsPMoMDWJqw7chDl25RdI7jfx5Qg7jAzvdamJHLqn4szhSDhYgJEDlkRgqrZfm5T36ZALYyqzITSZkTB6uetTvfxPnhLup+jjzxwPzafqkdpOMe5kkHEj+AVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxM9mPg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5404C4CEE8;
	Fri, 21 Mar 2025 06:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742539482;
	bh=TvkXbuZksInpmuRFp/TO+JRhs221zttzfw4xU5f3CPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxM9mPg4YjcSN17NqRKsk5jkIu3nEXXHfvEL+tzUBgpUFGNfjwZ6ubPU1ueKBL9NO
	 gZBasemgs4m4VPoaV69MoiJvG3dKaochp7bzFOI77r6+z8SZ4C4Ev1Jpg7srqF+MYS
	 U1dFg/FnT365L8gelxv809M+MJ7ZvhPZ1rHB8BEas1CPNJYK0Z92PxxS/IgGXQh+Zm
	 jrd3lne1DtpuVuh0Xm8/AAKmCPpo3VJTva8CiDoECgNc02U6M+5fKQxLe69OWoyeIK
	 2kZhBfeRlFxwK2t5lyPYPLg12b24Ose0eyHa8jR2mAhNXCU3nrL6EMU20Dz1Jr+Mnv
	 XAYS43wK2EmHg==
Date: Fri, 21 Mar 2025 07:44:39 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <uhvxi2yc4vndcqq3wmf3pmlluvmsyabhvvl2ytbtrkilljjnby@54bxmsnzkpxr>
References: <20250110073755.29541-1-dima.fedrau@gmail.com>
 <20250110073755.29541-3-dima.fedrau@gmail.com>
 <lzmsvwzidng7f6ybbfkusauohjya2rlyqrpprjc63y6pczo774@hklfplsgb3un>
 <20250320185118.GA352940@legfed1>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c577x5uivt3uwvu7"
Content-Disposition: inline
In-Reply-To: <20250320185118.GA352940@legfed1>


--c577x5uivt3uwvu7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
MIME-Version: 1.0

Hello Dimitri,

On Thu, Mar 20, 2025 at 07:51:18PM +0100, Dimitri Fedrau wrote:
> Am Wed, Mar 19, 2025 at 04:37:43PM +0100 schrieb Uwe Kleine-K=F6nig:

funny denglisch. :-)

> > After investing some time to reunderstand the rational here
> > I suggest:
> >=20
> > 	/*
> > 	 * Check which step [0 .. 3] is appropriate for the given
> > 	 * period. The period ranges for the different step values
> > 	 * overlap. Prefer big step values as these allow more
> > 	 * finegrained duty cycle selection.
> > 	 */
>=20
> I think this is way better then before. But did you mean:
> Prefer big step values as these allow more finegrained "periods" then
> "duty cylces" ?

It's both. I wrote without considering period because (in my bubble)
most consumers tend to care more for finegrained duty cycle than exact
period. Feel free to add "period and" to my proposal. (Assuming you
agree that the result is correct then.)

> > > +	/*
> > > +	 * As the hardware cannot generate a 0% relative duty cycle but emi=
ts a
> > > +	 * constant low signal when disabled, also disable in the duty_cycl=
e =3D 0
> > > +	 * case.
> > > +	 */
> > > +	mask =3D MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm + 1);
> > > +	wr_val[3] =3D (state->enabled && rel_dc >=3D 0) ? (rd_val[1] | mask=
) :
> > > +						      (rd_val[1] & ~mask);
> >=20
> > This is wrong for inversed polarity I think.
>=20
> Thanks for finding this. Yes, it is for the case when duty_cycle=3D0 and
> polarity=3DPWM_POLARITY_INVERSED. The device should then output a constant
> high signal. This could be done by:
> enabled=3D1
> duty_cycle=3D100%
> polarity=3Dnormal
>=20
> Just tested it, it works. What do you think ?

Sounds like the right thing to do. Probably needs a comment as this
is an asymmetry between the two polarities.

> > > +	pwmchip_set_drvdata(chip, spi);
> > > +	chip->ops =3D &mc33xs2410_pwm_ops;
> > > +	ret =3D mc33xs2410_reset(dev);
> >=20
> > What does this reset? Does it change the output signal if the bootloader
> > already setup the hardware? The answer to that has to go into a comment.
> > (And if it interupts the output, better skip the reset part.)
> >=20
> If reset of the device is asserted on probe it deasserts the reset and
> makes the device available. On the other hand if it is already setup by
> the bootloader the reset will clear all registers to default values which
> means that the output signal will change. The reset gpio is optional, so
> the user can decide wether to use it or not. Both usecases are
> supported. I will add an comment, but will keep the reset handling.

Conceptually it's wrong to make the distinction between "A reset at
probe time is desired" and "Please no reset at probe" via a modification
in the device tree as this is supposed to be an application agnostic
hardware description. I have no nice and constructive suggestion here. I
think I'd go for only deasserting reset in the Linux driver and
otherwise rely on the bootloader to pass the device in a usable state.
With a sane hardware design not doing anything is a valid possibility
for the bootloader then.

Best regards
Uwe

--c577x5uivt3uwvu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfdCtQACgkQj4D7WH0S
/k61Zgf9FBAsjcmT0YUIULFml4yCrOqcdol9x7O/CIbrM2d4Cp07swgYtfzvje9V
W8vxcAuRs2+H5RkTzE5MMc9mvezE9Z6myXJCzPGr6p1bKOI71neNigtEVEWfmZO8
4BL0hzd2k7vJMW3dA/2SWpztspdhpcxCdQMawTjQ55LqiODpAnLfiYKpQ9TldhRg
vUTYPTrvNzJoBBigdnD5x6SM2pAzgurMFBCOCAKHScLchsl/2JXxpWhPNW3+siiJ
qSZHANeHJ0Y6U4pILyCyKcCXnW/vxqTHTciNGQBZzxLgm60gsWv//0fX1FyqQxmW
2F0iJ+mjQ8F99n6XqwoEbkUYYwKndw==
=Xuvb
-----END PGP SIGNATURE-----

--c577x5uivt3uwvu7--

