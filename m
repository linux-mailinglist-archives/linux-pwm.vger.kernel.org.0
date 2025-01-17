Return-Path: <linux-pwm+bounces-4656-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908A6A151FD
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 15:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB243ADB4A
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BEE15B0EF;
	Fri, 17 Jan 2025 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA6BXZKL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9470825;
	Fri, 17 Jan 2025 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737124819; cv=none; b=S4qRWp+8Xp0k57GmkUKmguZp8l1T1k8N4qbPm9g0xDfyNFAdoYnb9yUUcCGtVrEAYIlJ4RvoNFStdr3fUAdBelNuURuvFErzFnmZYKf4TgtTMVJjl/oEy6DPcYe2dXcmWVwz1wiFlvXH/qBqy/M64LZtd9nQ6XEUpFzoUoJOh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737124819; c=relaxed/simple;
	bh=ztDKhBkIzxT+MjV61TU9CzfLHD1NVtR+EdIQ0BKaqNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5Ot5KotfWiOQoUtV5l/PqnPVBB/TXbi1eIxOzHptcYSsFP87a8vyi9SYjt6k0r3x7TwCci9WHVcLLeu8cv5hQLOvRYqP9GEL02Iz0DKmDOPku78PcjYvBGyA5YkV8dUGxHUfVXx/2/+fgBuhj035/oaPvIwYuftpR0vwcqvy9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA6BXZKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32EDC4CEDD;
	Fri, 17 Jan 2025 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737124819;
	bh=ztDKhBkIzxT+MjV61TU9CzfLHD1NVtR+EdIQ0BKaqNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qA6BXZKLmI6jhTfunyY7oj61mvuarIenGdaCai7Oo7pki+UECldWFgLN/XJqH+U0j
	 kwBv/AZBAHZpUGka9Wz1KAhLEcu/g4gtnScO5IZEqJm4Fn1ZzsAT5WDQflXFLAHWaf
	 w5eIQdZEcNhFeLgVmyHmCXQiNFTzP+GDOLhTuw6BO2DUfvCsYxkHnJii1AuqZNIDdf
	 47FZ4tnjYar0hmOAc5j8RVwbRkPd6v4K9SWJczFy+Ns93P7QUKsAQ1xnm2wwnb3KfF
	 HgCaldeaKEfC5l87mvlnVoIck0HiyIBR8IaLutd8jZpYxywm/1TAa51OoVa4aRL7h3
	 TUiPfyiPVov/w==
Date: Fri, 17 Jan 2025 15:40:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/7] pwm: max7360: Add MAX7360 PWM support
Message-ID: <v4bf6bharih6zgz52ya5twfyf47wh3fu56ovic5gjxak2jhufy@q3eudujjwrhm>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-3-9519b4acb0b1@bootlin.com>
 <f22l3uqgt65utxehv2zmozqixjkktp4trpr42xr5arvp6o5zcf@g5iriaeskqa5>
 <D74EQQNADWDP.FQ5XFK8TB5XH@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qts6aw34gcdrduzd"
Content-Disposition: inline
In-Reply-To: <D74EQQNADWDP.FQ5XFK8TB5XH@bootlin.com>


--qts6aw34gcdrduzd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/7] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

On Fri, Jan 17, 2025 at 03:11:29PM +0100, Mathieu Dubois-Briand wrote:
> On Fri Jan 17, 2025 at 10:33 AM CET, Uwe Kleine-K=F6nig wrote:
> > Hello Mathieu,
> >
> > On Mon, Jan 13, 2025 at 01:42:27PM +0100, mathieu.dubois-briand@bootlin=
=2Ecom wrote:
> > > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ...
> > > +static int max7360_pwm_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > > +			     const struct pwm_state *state)
> > > +{
> > > +	struct max7360_pwm *max7360_pwm;
> > > +	u64 duty_steps;
> > > +	int ret;
> > > +
> > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > +		return -EINVAL;
> > > +
> > > +	if (state->period !=3D MAX7360_PWM_PERIOD_NS) {
> > > +		dev_warn(&chip->dev,
> > > +			 "unsupported pwm period: %llu, should be %u\n",
> > > +			 state->period, MAX7360_PWM_PERIOD_NS);
> > > +		return -EINVAL;
> >
> > Please don't emit error messages in .apply(). Also a driver is supposed
> > to round down .period, so any value >=3D MAX7360_PWM_PERIOD_NS should be
> > accepted.
> >
> > Also note that you might want to implement the waveform callbacks
> > instead of .apply() and .get_state() for the more modern abstraction
> > (with slightly different rounding rules).
> >
>=20
> Sure, I just switched to the waveform callbacks, it was quite
> straightforward.

sounds great. Note that the detail in rounding that is different for
waveforms is that a value that cannot be round down to a valid value
(because it's too small) is round up. This is a bit ugly in the drivers
but simplifies usage considerably. So you never return -EINVAL because
the values don't fit.

> Thanks for the reproduce steps: I saw the bug and fixed it. Also
> MAX7360_PWM_MAX_RES had to be set to 255 and not 256...

A good test (for a driver doing .apply/.get_state) is a sequence of
increasing settings. So something like:

	for p in range(1000, 10000):
	    pwm_apply(period=3Dp, duty_cycle=3D0, ...)

and also do the same for duty_cycle and also try decreasing series.

Best regards
Uwe

--qts6aw34gcdrduzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeKa84ACgkQj4D7WH0S
/k7OrAgAit3HCpMmHe0bRa+mj+PgWFq0h5PoGyeUiXpaxTnD+RHAQF4CRL2ZQs8u
QkJrJzDL6/WsXHQ+BHbqSZzN5ZQsuP0gQSTDmrYXBI+FSLiBJ4K9ywXPfIMOJ/ui
PCNuYZHiMPsjkj6K2b8IFg8pREloOXVeI1RzYJzST29dfacfPGCNsv4wb/Mcc0az
Y3lMW+kwIydAv2IkL+L8C17ve8I8mT4qHJ8YrRyPmuFZlBHilujYtpVbkwOXAwUb
nmCEqvrwN8EcBD1rrVurECecUzTo5me39AKZk3a4m5vyr4X6yjcSZNtct5yQFLDq
mgASIK3WEUgllRlsgBrnPctVovtDhQ==
=JwG4
-----END PGP SIGNATURE-----

--qts6aw34gcdrduzd--

