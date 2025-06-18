Return-Path: <linux-pwm+bounces-6438-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADA4ADF5AA
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 20:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E26E3A79A5
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB02F3C38;
	Wed, 18 Jun 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzKZWqwH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6E70830;
	Wed, 18 Jun 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270761; cv=none; b=DDbrHWoQ5sPK3xbln3kQgKm1x57v+xWQGqwWdrgl5WKEMUBYihKDDSG2TSodhTz0XfFdKUFd7hYqJor6G+o0E+CVKkBoOYfmEed82A3pZFxy12ayeectUBWGVk1pPSDbpGCbRWokIG8rzGH/RVw23bD8ZFaJ4JT3FGeGukoCF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270761; c=relaxed/simple;
	bh=a50wlknDlpagNq9jT3Q/IWSLUrXmeXKtizwXZ65RjX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtY0/Oy3t6VVByjww8SbTUsdy5nrH8y3xYx9S5CKHq1ANnsDs/IKoqx2CFm5tqFKxOFZspogO+m8Kyq2q9TZWteGToJdErp1Lmpj4E/0cP07dMdlxOI06uSmLUoTjoXiTVpSzbokFLKmserO2lLVdvgQdVT7O5ebaIoMdApqJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzKZWqwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28080C4CEE7;
	Wed, 18 Jun 2025 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750270760;
	bh=a50wlknDlpagNq9jT3Q/IWSLUrXmeXKtizwXZ65RjX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzKZWqwHZj3IpGzO5PE2PMzFEc9y+To0ksq9WMfVFHMABL5TvgULiuHVEv1Q3sICd
	 IvcBuy+9JdRDH9jmtmYKfEGU4DmKUfgoiKms+0R8YUpDXkRf3B0WH60WlDjuJTD6S4
	 2RCswt7B+ik4mQwGkHA7obrN/2VGwQqRxPAXnAplqAx0PVQsRdI+UECPKAIBaAkBKL
	 b0o1Um6RqawIVq36Xc0ZG/mgZFaifAE55ARqxI11lANsh5gjgdy4lJGu6smC7kBtZn
	 CooEN3OuhxDOkP1Efqj2P6vx3bjkzTm2RZJcPdIZShHV0Ng8rm7gXcz/ml3vlKwCN5
	 ZV200A33o5DPQ==
Date: Wed, 18 Jun 2025 20:19:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0YPQsdC40L0=?= <privatesub2@gmail.com>, 
	linux-kernel@vger.kernel.org, Brandon Cheo Fusi <fusibrandon13@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <daopyy24kta2myimufkf2v6c6igdplco6b2kxohm47j6cez5mb@34ccs3wbtkop>
References: <20250427142500.151925-1-privatesub2@gmail.com>
 <20250427142500.151925-3-privatesub2@gmail.com>
 <20250512233944.06bc1cb7@minigeek.lan>
 <CAF4idN=Kwp8bDYVyjM52eUwVEEZcPM9YyK9KiqUzyf8Dm=cXTQ@mail.gmail.com>
 <hetih6ul7hdj3kflhy2s2zkkh3r7pcupgwde3xnwmjzs6cujp3@vcw4pde76bdb>
 <20250528132902.70f634cd@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zqgmvr7sp22wp6bu"
Content-Disposition: inline
In-Reply-To: <20250528132902.70f634cd@donnerap.manchester.arm.com>


--zqgmvr7sp22wp6bu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
MIME-Version: 1.0

Hello Andre,

On Wed, May 28, 2025 at 01:29:02PM +0100, Andre Przywara wrote:
> On Wed, 28 May 2025 13:08:40 +0200
> Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org> wrote:
> > On Sat, May 24, 2025 at 12:07:28PM +0300, =D0=90=D0=BB=D0=B5=D0=BA=D1=
=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=A8=D1=83=D0=B1=D0=B8=D0=BD wrote:
> > > =D0=B2=D1=82, 13 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 01:39=
, Andre Przywara <andre.przywara@arm.com>: =20
> > > >
> > > > On Sun, 27 Apr 2025 17:24:54 +0300
> > > > Aleksandr Shubin <privatesub2@gmail.com> wrote: =20
> > > > > +              */
> > > > > +             use_bus_clk =3D false;
> > > > > +             val =3D mul_u64_u64_div_u64(state->period, hosc_rat=
e, NSEC_PER_SEC);
> > > > > +             /*
> > > > > +              * If the calculated value is =E2=89=A4 1, the peri=
od is too short
> > > > > +              * for proper PWM operation
> > > > > +              */
> > > > > +             if (val <=3D 1) { =20
> > > >
> > > > So if I get the code correctly, it prefers HOSC over APB? Is that
> > > > really the best way? Shouldn't it be the other way around: we use t=
he
> > > > faster clock, since this will not limit the sibling channel?
> > > >
> > > > And another thing to consider are rounding errors due to integer
> > > > division: certain period rates might be better achievable with one =
or
> > > > the other source clock: 3 MHz works best as 24MHz/8, 3.125MHz as
> > > > 100MHz/32.
> > > > So shall we calculate the values and compare the errors instead?
> > > > Oh, and also we need to consider bypassing, I feel like this should=
 be
> > > > checked first.
> > > >
> > > > In any case I think there should be a comment describing the strate=
gy
> > > > and give some rationale, I think. =20
> > >=20
> > > I like the idea of comparing the quantization error for each clock so=
urce
> > > (i.e. computing the actual period for both APB and HOSC and choosing
> > > whichever is closer to the requested period).
> > > I can try to implement that error-minimization approach in the next
> > > series of patches and add a comment explaining the strategy. =20
> >=20
> > Consumers have different needs. Some might prefer a better match for
> > period, but in my experience most would go for a fine-grained selection
> > of duty_cycle, so prefering the faster clock sounds sane.
> >=20
> > I don't say minimizing the error is wrong, but if it's unclear that
> > this matches what a consumer wants I object to make the procedure to
> > select the hardware settings considerably more complicated and run-time
> > intensive.
>=20
> Yes, I agree. There seems to be another use case here, which is to provide
> clocks on output pins. The PWM IP has a bypass switch (per channel, after
> the divider), and this feature is already required to supply the
> "internal" (co-packaged) Ethernet PHY on the Allwinner H616 with its cloc=
k.
> With the two possible input clocks and those pre-dividers there is actual=
ly
> quite a number of possible frequencies to deliver on output pins.
>=20
> Since we need some algorithm to decide when we need to use the bypass
> mode, should we check for that if the duty cycle is 50%, to see if we can
> reach the frequency with just the pre-dividers?
> Chances are we need this anyway, since for instance the 24MHz required for
> the PHY cannot be achieved otherwise.

And the clk output is the output after the predividers I assume? I would
prefer to make the driver create a clk_provider instead of guessing
which requests are supposed to have a meaning for the clk output.

> > > > > +static int sun20i_pwm_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +     struct pwm_chip *chip;
> > > > > +     struct sun20i_pwm_chip *sun20i_chip;
> > > > > +     struct clk *clk_bus;
> > > > > +     struct reset_control *rst;
> > > > > +     u32 npwm;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "allwinner,=
npwms", &npwm);
> > > > > +     if (ret < 0)
> > > > > +             npwm =3D 8; /* Default value */
> > > > > +
> > > > > +     if (npwm > 16) {
> > > > > +             dev_info(&pdev->dev, "Limiting number of PWM lines =
=66rom %u to 16", npwm); =20
> > > >
> > > > I don't think we should proceed if the firmware information is clea=
rly
> > > > wrong. Just bail out with -EINVAL or so here, so that gets fixed in=
 the
> > > > DT. =20
> >=20
> > To me it's not obvious that the "firmware information is clearly wrong".
> > Maybe the next Allwinner SoC will have 24 outputs and the problem is
> > only that this driver isn't prepared to cope for that number of outputs?
>=20
> But then it would be an error, regardless?
> The MMIO register frame of this IP here has a hard limit on 16 channels,
> both by the bit assignments in each register (2 bits per channel in a
> 32-bit register), but also by the layout of the registers (max 8
> registers, each for a pair of 2 PWM channels). So anything with more than
> 16 channels cannot be compatible with what this driver supports.
> So as this driver here stands right now, more than 16 channels is an
> error, simple as that. If we extend the driver later on, to cover more
> advanced IP, we would naturally amend this check, of course.

Agreed. In that case I don't care much if .probe() fails or just limits
the number of PWMs to 16.

Best regards
Uwe

--zqgmvr7sp22wp6bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhTAyMACgkQj4D7WH0S
/k5TXQf/WQifjbmW7D5efouTLo5vO4iUok97pK1+s3+HHamdmm23IWg0PAFmFQBB
UNd0buVhud3TtGtJeSPa57FUEzriGdGzJ2CFN+qDdUY7L7VGACE6S7mGsnLLYQuN
UsGMB0G7qVL5h3zhySTgXtgMF+D9QZHZq/LwR00/PpXVDAG6vES7AwdQlsG0PS+4
so3ravkEOTsVKRYzFLC6dNZoGeGWaz3X0Iedjl4Y8NXs+HKpp2qyh1x8FPJYIy9V
GBtDzx8E4s8SwuJeTJSdcfs/PlIyCWCa51El8AExmHaB0oE8JEB3dqdrKRHxLc0Z
Ie0GiCpIKi3W7ApbehC3rBcHxbwj9g==
=USjg
-----END PGP SIGNATURE-----

--zqgmvr7sp22wp6bu--

