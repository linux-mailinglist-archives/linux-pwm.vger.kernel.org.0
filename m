Return-Path: <linux-pwm+bounces-6165-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB95FAC6820
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 13:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC273A34FA
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748E27A47E;
	Wed, 28 May 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTAu1Tje"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D927A462;
	Wed, 28 May 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430525; cv=none; b=lSa9rC5BVi3EKlbiBONIvKUbetrfUAJ+MyVdgCL6P8X1+vbM7nT0i7S521+msrSmkTNCbMwTtevlrTWBpdIMUkoXtZgioTM8kmberz+e2kbXZ5N62NI2uF/ftK+dNhlqgohbVlNmcrlNQhft8ORRE7UMpZqSqe+yIyFtZ44jqVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430525; c=relaxed/simple;
	bh=vs9C+yM7jX/8lBqahjesUiVEoedayFKv4eRr8WPo1Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5MghPI5y375xi/HAfXNOJrClvafr3j0gPGboqLVyxpU6wQwIDgP+P+PcOvxyUdhEyykn7y+ZXlDs9zOgsxTRdkzPhfqXWs8di/bOS8B7uzGFidSv0nfi8VgOm+lKAHsjRmsWCYKWZkdEOj5fnWOnzzNhR9xUY0v5p4CmKx7pIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTAu1Tje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F219AC4CEE7;
	Wed, 28 May 2025 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748430524;
	bh=vs9C+yM7jX/8lBqahjesUiVEoedayFKv4eRr8WPo1Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTAu1Tjew7E5vCuzuLnwXVsjhaJk4oq4cIksA970ux59BFH+zbRzt1E1a9TzFsyOG
	 xEdwj6FCowDGIzbsGCACPUzH+f4UfPvUUXkflpf7Soagv2DC3m3UpFLZ7SEMBGZ5IT
	 yOIoWZctn0xSy1MInbuUzfU8rL063kyt3UFj9qEUmhTmGXPmk9JkXmVM49xsCDUtFz
	 UxF22UnKNzhzGi0OabAhcsiJMQDsWCI7+ZHjZ0pE3YsnmijTp/vRQ/R99jXW+rCEsT
	 +Fa55E+B2opUBxi0dVMKxgHvc5Iq/v836GAtrRgmqAuihWEZ0yCwwE4/HLKXU1FcQP
	 qnh4rhbBUvi6A==
Date: Wed, 28 May 2025 13:08:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0YPQsdC40L0=?= <privatesub2@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-kernel@vger.kernel.org, 
	Brandon Cheo Fusi <fusibrandon13@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <hetih6ul7hdj3kflhy2s2zkkh3r7pcupgwde3xnwmjzs6cujp3@vcw4pde76bdb>
References: <20250427142500.151925-1-privatesub2@gmail.com>
 <20250427142500.151925-3-privatesub2@gmail.com>
 <20250512233944.06bc1cb7@minigeek.lan>
 <CAF4idN=Kwp8bDYVyjM52eUwVEEZcPM9YyK9KiqUzyf8Dm=cXTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j6nnrxchndqyddxe"
Content-Disposition: inline
In-Reply-To: <CAF4idN=Kwp8bDYVyjM52eUwVEEZcPM9YyK9KiqUzyf8Dm=cXTQ@mail.gmail.com>


--j6nnrxchndqyddxe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
MIME-Version: 1.0

Hello,

On Sat, May 24, 2025 at 12:07:28PM +0300, =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=
=B0=D0=BD=D0=B4=D1=80 =D0=A8=D1=83=D0=B1=D0=B8=D0=BD wrote:
> =D0=B2=D1=82, 13 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 01:39, An=
dre Przywara <andre.przywara@arm.com>:
> >
> > On Sun, 27 Apr 2025 17:24:54 +0300
> > Aleksandr Shubin <privatesub2@gmail.com> wrote:
> > > +              */
> > > +             use_bus_clk =3D false;
> > > +             val =3D mul_u64_u64_div_u64(state->period, hosc_rate, N=
SEC_PER_SEC);
> > > +             /*
> > > +              * If the calculated value is =E2=89=A4 1, the period i=
s too short
> > > +              * for proper PWM operation
> > > +              */
> > > +             if (val <=3D 1) {
> >
> > So if I get the code correctly, it prefers HOSC over APB? Is that
> > really the best way? Shouldn't it be the other way around: we use the
> > faster clock, since this will not limit the sibling channel?
> >
> > And another thing to consider are rounding errors due to integer
> > division: certain period rates might be better achievable with one or
> > the other source clock: 3 MHz works best as 24MHz/8, 3.125MHz as
> > 100MHz/32.
> > So shall we calculate the values and compare the errors instead?
> > Oh, and also we need to consider bypassing, I feel like this should be
> > checked first.
> >
> > In any case I think there should be a comment describing the strategy
> > and give some rationale, I think.
>=20
> I like the idea of comparing the quantization error for each clock source
> (i.e. computing the actual period for both APB and HOSC and choosing
> whichever is closer to the requested period).
> I can try to implement that error-minimization approach in the next
> series of patches and add a comment explaining the strategy.

Consumers have different needs. Some might prefer a better match for
period, but in my experience most would go for a fine-grained selection
of duty_cycle, so prefering the faster clock sounds sane.

I don't say minimizing the error is wrong, but if it's unclear that
this matches what a consumer wants I object to make the procedure to
select the hardware settings considerably more complicated and run-time
intensive.

> > > +static int sun20i_pwm_probe(struct platform_device *pdev)
> > > +{
> > > +     struct pwm_chip *chip;
> > > +     struct sun20i_pwm_chip *sun20i_chip;
> > > +     struct clk *clk_bus;
> > > +     struct reset_control *rst;
> > > +     u32 npwm;
> > > +     int ret;
> > > +
> > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "allwinner,npwm=
s", &npwm);
> > > +     if (ret < 0)
> > > +             npwm =3D 8; /* Default value */
> > > +
> > > +     if (npwm > 16) {
> > > +             dev_info(&pdev->dev, "Limiting number of PWM lines from=
 %u to 16", npwm);
> >
> > I don't think we should proceed if the firmware information is clearly
> > wrong. Just bail out with -EINVAL or so here, so that gets fixed in the
> > DT.

To me it's not obvious that the "firmware information is clearly wrong".
Maybe the next Allwinner SoC will have 24 outputs and the problem is
only that this driver isn't prepared to cope for that number of outputs?

If that really happens it's arguable if it's better to refuse completely
or just cope for the 16 outputs that the driver is able to. IMHO it's
better to continue because a partially workable pwmchip is better than
no chip at all. But I'd upgrade the message to dev_warn().

> > > +             npwm =3D 16;
> > > +     }
> > > +
> > > +     chip =3D devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*sun20i_ch=
ip));
> > > +     if (IS_ERR(chip))
> > > +             return PTR_ERR(chip);
> > > +     sun20i_chip =3D to_sun20i_pwm_chip(chip);
> > > +
> > > +     sun20i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> > > +     if (IS_ERR(sun20i_chip->base))
> > > +             return PTR_ERR(sun20i_chip->base);
> > > +
> > > +     clk_bus =3D devm_clk_get_enabled(&pdev->dev, "bus");
> > > +     if (IS_ERR(clk_bus))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(clk_bus),
> > > +                                  "Failed to get bus clock\n");
> > > +
> > > +     sun20i_chip->clk_hosc =3D devm_clk_get_enabled(&pdev->dev, "hos=
c");
> > > +     if (IS_ERR(sun20i_chip->clk_hosc))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->c=
lk_hosc),
> > > +                                  "Failed to get hosc clock\n");
> > > +
> > > +     ret =3D devm_clk_rate_exclusive_get(&pdev->dev, sun20i_chip->cl=
k_hosc);
> >
> > Just ignoring for a bit that the 24 MHz oscillator is a fixed clock
> > anyway, but why would we want exclusivity already at probe time? Isn't
> > that too limiting, as no one might ever use any PWM channels, but it
> > would still "belong to us"?

That's a soft concept of "belong to us". Other consumers can still use
it and even also call clk_rate_exclusive_get(). IMHO it's a good idea to
call clk_rate_exclusive_get() for each clock that a driver relies on not
to change. You could make the driver more flexible and only call that
when the rate is actually relied on, but that's again a compromise with
complexity of the driver. And if the clock rate is fixed anyhow, it
doesn't hurt to do it here, right?

> > > +     if (ret)
> > > +             return dev_err_probe(&pdev->dev, ret,
> > > +                                  "Failed to get hosc exclusive rate=
\n");
> > > +
> > > +     sun20i_chip->clk_apb =3D devm_clk_get_enabled(&pdev->dev, "apb"=
);
> > > +     if (IS_ERR(sun20i_chip->clk_apb))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(sun20i_chip->c=
lk_apb),
> > > +                                  "Failed to get apb clock\n");
> > > +
> > > +     ret =3D devm_clk_rate_exclusive_get(&pdev->dev, sun20i_chip->cl=
k_apb);
> >
> > Just for the records: APB is practically also a fixed clock, set up
> > once in firmware and never changed, since it drives a lot of other
> > peripherals.
> > But same question as above, why do we lock its rate already here?
>=20
> That step was actually recommended by Uwe Kleine-K=C3=B6nig,
> so the decision on whether to keep or drop exclusive reservation
> is really a question for him=E2=80=94please coordinate with Uwe
> to agree on how best to proceed here.

Same as above. Iff the driver relies on the rate of this clock to keep
constant, calling clk_rate_exclusive_get() is right.

> > > +     if (ret)
> > > +             return dev_err_probe(&pdev->dev, ret,
> > > +                                  "Failed to get apb exclusive rate\=
n");
> > > +
> > > +     if (clk_get_rate(sun20i_chip->clk_apb) <=3D clk_get_rate(sun20i=
_chip->clk_hosc))
> > > +             dev_info(&pdev->dev, "APB clock must be greater than ho=
sc clock");
> >
> > Why this check? Does the code make any assumptions about this relation?
> > If yes, we must surely deny this and bail out.
> > If not (and I feel we should handle it this way), we can just ignore
> > this and not print anything.

ack.

Best regards
Uwe

--j6nnrxchndqyddxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg27rUACgkQj4D7WH0S
/k7eMQf+MFh+WPOSnrL0ChmTNdZTkd/HHROpjXJFoKvZp8zcSHMTplW1nj2woA1/
Va88dWGfc9SB3t8CtiIDNa5+Uqe1TKApG1dH+Wa85exLeIamnSGMlmr2UrslLX+Z
U4CO0QmYVZGBjQtwEulMwGIfhZr/v4xBCLhwB0NoHqn2R1S1rxDjK6LHQFBj1RHl
IqvMLUGJ0XSg5bzLiS3OqRH0FpHKyAggpEoqJPYOBBc7yjhxklvLN+u5Gb6riPaT
pm7nwLkH/qBqpTgJfHxGf92AuW23qp/PcytQABrRXlsGNhFJBilXQPcFjN16JthK
FxuATRizXxGVnnfFjeGzHSc9RoSOvw==
=DLbu
-----END PGP SIGNATURE-----

--j6nnrxchndqyddxe--

