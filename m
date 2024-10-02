Return-Path: <linux-pwm+bounces-3434-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E9498DF57
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 17:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4231C23636
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9028C1D097D;
	Wed,  2 Oct 2024 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT+ODeYz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448323CE;
	Wed,  2 Oct 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883401; cv=none; b=CYzMc/BUnVTjE/Yq4xUOhZTiL/lMbA3wVv+AB1WF2zogy+ANhUKN5jm/t/5lIllhyp+YVxfMyiZsmaMVsW3BfLX3Rs9T6k/pAKF1FgvZrKqIzix967k8hBu/GC6jiMBwRk6KDztyKd5nne9cws48mQAUTnSR7L1tHtsz1io2hV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883401; c=relaxed/simple;
	bh=lctykuC46Ge7cuFFtl6NptKvP7roRa2TVOdlVGRKfOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHcUAKXJK66DuUX1XObMM3iTJikum/zQVzJ/gF3CkyEX4dTvYtpFEflBd69Xb51ki+bdhUM9UuaKG0Pd/SP29pqLR6tnrPNITBdNN+QNVF9l4LpJ73lXlRQHxAK62qqrmCsjtxaZ01Ffob3/Ns/mVIJV5mGGHVoH8LSFhI1xFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT+ODeYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D213C4CEC2;
	Wed,  2 Oct 2024 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727883400;
	bh=lctykuC46Ge7cuFFtl6NptKvP7roRa2TVOdlVGRKfOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hT+ODeYzFnlF1CUJBWx1Do8y0KPikbSGpiRD2R0pveI9OLpJe7FQrQ3tH3z3liut8
	 Rughfacwz7VjJNYXlaJgGWABfehCH8SHe3MFgXXN8V7BZmXBgMMY8WhQ8/Wv0o79Tg
	 +pS3gKsghJftIkEU7pRQDy9EluO8SFACY7UNFYjPJ3jKfGJ9BtNv5GX3r2Or+BIpkQ
	 HpYM+wUM9tjKRIl92wEIku/IhiF/77jJ+K4/rRkqgVn5m6cEaO6Xpy7aiDttwN0Oy2
	 yg/Du//UebEzY6udF7tNlyVemf67kiuQ4vzckwQ1ZMdttPtQVJEWyN6lp0hrJoeLyR
	 GOSw30bTmXi2g==
Date: Wed, 2 Oct 2024 17:36:38 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] pinctrl: airoha: Add support for EN7581 SoC
Message-ID: <Zv1ohibsTelBBMc9@lore-desk>
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
 <20240911-en7581-pinctrl-v4-4-60ac93d760bb@kernel.org>
 <CACRpkdZbyQ5bk8oR+Q4UmQCdM5h1mF1ztBc26YzqNsze_B=ehA@mail.gmail.com>
 <ZvKQe73ZKIFy4fny@lore-desk>
 <CACRpkdbXWMU+wq6DvviCQPQ0EzKUm9oOnyFh34Bm=Y8K-HmT0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8Llyx+/6l0oTvjiz"
Content-Disposition: inline
In-Reply-To: <CACRpkdbXWMU+wq6DvviCQPQ0EzKUm9oOnyFh34Bm=Y8K-HmT0Q@mail.gmail.com>


--8Llyx+/6l0oTvjiz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,
>=20
> so these comments:
>=20
> On Tue, Sep 24, 2024 at 12:12=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel=
=2Eorg> wrote:
>=20
> > > > +#include <linux/pinctrl/consumer.h>
> > >
> > > Why do you need the consumer header?
> >
> > we need it for pinctrl_gpio_direction_output() and
> > pinctrl_gpio_direction_input() for direction_input and direction_output
> > callbacks.
>=20
> I looked it over again and it looks good, I was just confused.

ack, no worries.

>=20
> > > > +               arg =3D airoha_pinctrl_gpio_get_direction(pinctrl, =
gpio);
> > >
> > > I don't see why a pin would have to exist in a GPIO range in order to
> > > be set as output or input?
> > >
> > > Can't you just set up the pin as requested and not care whether
> > > it has a corresponding GPIO range?
> > >
> > > Is it over-reuse of the GPIO code? I'd say just set up the pin instea=
d.
> >
> > Do you mean to get rid of PIN_CONFIG_OUTPUT_ENABLE, PIN_CONFIG_INPUT_EN=
ABLE
> > (and even PIN_CONFIG_OUTPUT in airoha_pinconf_set()) here?
> > E.g. we need PIN_CONFIG_OUTPUT_ENABLE to enable pwm for pwm-leds:
>=20
> I was mainly thinking that the
> airoha_pinctrl_gpio_get_direction() is limited to pins that are
> used for GPIO.
>=20
> The callback should be usable on any pins, no matter if they
> can be muxed to GPIO or not?
>=20
> > &mfd {
> >         ...
> >         pio: pinctrl {
> >                 ...
> >                 pwm_gpio18_idx10_pins: pwm-gpio18-idx10-pins {
> >                         function =3D "pwm";
> >                         pins =3D "gpio18";
> >                         output-enable;
> >                 };
> >         };
> > };
>=20
> Like this one.
>=20
> Which I think works.
>=20
> It's the name of the function which confuses me:
> airoha_pinctrl_gpio_get_direction() and anything else that
> is used directly from the airoha_pinconf_set() function
> doesn't really care if the pin is used as GPIO or not does
> it?
>=20
> Can you rename the functions just e.g. airoha_pinctrl_get_direction()
> because it has nothing to do with GPIO. It's jus pin control.

ack, I will do in v6

>=20
> Also some defines are confusing this way:
>=20
> +       /* set output enable */
> +       mask =3D BIT(gpio % AIROHA_GPIO_BANK_SIZE);
> +       index =3D gpio / AIROHA_GPIO_BANK_SIZE;
> +       airoha_pinctrl_rmw(pinctrl, pinctrl->gpiochip.out[index],
> +                          mask, !input ? mask : 0);
>=20
> Variables named "gpio" and AIROHA_GPIO_BANK_SIZE despite
> it is used for pins that are not (in the Linux sense) GPIO all the time.
> This is a big confusion for the mind.
>=20
> Can you rename the variable from "gpio" to "pin" or so
> and the AIROHA_GPIO_BANK_SIZE to AIROHA_PIN_BANK_SIZE
> etc so it is clear what is going on?

ack, I will do in v6

>=20
> I understand that the datasheet might be talking about
> "GPIO this and GPIO that" but what hardware engineers mean
> with GPIO is something else than what Linux mean: for them
> it means "it can be muxed so it is kinda-general-purpose-kinda"
> but in Linux this has a strict meaning: it can be used by the
> gpiolib to control individual lines.
>=20
> I think this would make it easier for me (and possibly others)
> ton understand the driver.

ack.

Regards,
Lorenzo

>=20
> Yours,
> Linus Walleij

--8Llyx+/6l0oTvjiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZv1ohgAKCRA6cBh0uS2t
rH+tAQDVCYAU8i0rHVxzYHBy1Ru8GILe3Gh2kkzSc5/XbFIkzQD/d6b4CDLvoUdk
uGizF04DYikQfU5iZjLOTvNb53Wy3w4=
=cKW5
-----END PGP SIGNATURE-----

--8Llyx+/6l0oTvjiz--

