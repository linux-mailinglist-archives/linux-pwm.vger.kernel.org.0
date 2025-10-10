Return-Path: <linux-pwm+bounces-7435-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE557BCD8E9
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 16:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5095189BA35
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729CC2F60D8;
	Fri, 10 Oct 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuIf6N+N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3005A2F5327;
	Fri, 10 Oct 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107175; cv=none; b=Nty2yWOfpLeuiBLCrYU1XRMpndf+hL28e1tXWfgVKIlEHoFv7SceMQR9iltpgydRTUuC9WQy9xOJAML/5H7a6f5uCiNmtGs2zW10ejgbOD2JerVCBajJc69epNsOzlIIkkoK6iULcD0BIP6ZBN8zr08kYoBtqGPDLVyjg+eN+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107175; c=relaxed/simple;
	bh=dtoD4l4VS0bu/I/Y3O30jdEDHBxBK5tOgphUcrs2Nio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrmV8cCsBLen6kYwgr+7FwM6OmKGDyy7pZCtfQrz0dJvNt5i6eVv+gHxVzAhs65Ey2k4ZBq9cXF1w7v7hhm1h9f1knxBHW1jwq8Y3/++JDKfxDTsGWf6tT36Hx7T0vG6Fk7tSR7vcJ05H0iOq/P0efRrXfaPg2d1PV7g75TjC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuIf6N+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34115C4CEF1;
	Fri, 10 Oct 2025 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760107174;
	bh=dtoD4l4VS0bu/I/Y3O30jdEDHBxBK5tOgphUcrs2Nio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuIf6N+NB8MgQ/hhsc/v7fzNeI+29dUxEpyGe2NwFbp84dBg4vpgI0KvLawceBxiA
	 i+GvS65+oReVOilqCqyFwqXioloUKg/9CUUsshon+wOpJ4PmnGb8qktsEtkk9D83xY
	 MMxif79UAqIFsyN6BYBKYMzTFdDi9roKVxf+xYi8n3McYNuMIsXj7VPZm4lghiTTie
	 jx4zYG0bA6lVEeEuwkP8AjupZa9dSLypdtk/QY8hW/3XiLn6Ek154kE1n+XUanKVLf
	 335xMyVJbZyXeSmZ5CFM5eeOX5JNWgqEK5CpxCwxg9AIzIsBV0c+TzNVg4SLWsm41n
	 /g3jEMUwXULUg==
Date: Fri, 10 Oct 2025 15:39:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, ukleinek@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20251010-donut-agreeable-07f3367416d5@spud>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
 <20251008-swooned-closable-fbc8b71601c0@spud>
 <aOgw95ebGWWhahUx@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IJk9hVtxLgVTxZJO"
Content-Disposition: inline
In-Reply-To: <aOgw95ebGWWhahUx@debian-BULLSEYE-live-builder-AMD64>


--IJk9hVtxLgVTxZJO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 07:02:31PM -0300, Marcelo Schmitt wrote:
> On 10/08, Conor Dooley wrote:
> > On Wed, Oct 08, 2025 at 10:51:37AM -0300, Marcelo Schmitt wrote:
> > > ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices =
have a
> > > PGA (programmable gain amplifier) that scales the input signal prior =
to it
> > > reaching the ADC inputs. The PGA is controlled through a couple of pi=
ns (A0
> > > and A1) that set one of four possible signal gain configurations.
> > >=20
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > Change log v3 -> v4
> > > - Now only documenting GPIO setup to control ADAQ PGA pins.
> > >=20
> > > Pin strapped/hardwired connections to PGA pins may benefit from a "fi=
xed-gpios"
> > > driver which may (or may not?) use the shared GPIO abstraction layer =
[1]. I may
> > > propose support for pin-strapped/hardwired connections when I get a w=
orking
> > > fixed-gpios implementation.
> >=20
> > What is a "fixed-gpio" as compared to a hog, from a dt point of view?
> > Is it purely a software change?
>=20
>=20
> Short answer:
>=20
> I think "fixed-gpio" and gpio-hog would mean the same from dt point of vi=
ew.
> Yes, it's mainly related to software.

Long answer is wasted on me, what you I just wanted to know if you were
proposing something new on the dt side or just able to use hogs :)
Well, wasted in an official capacity, obviously new features in the
kernel are also interesting to learn about.

Cheers,
Conor.

>=20
>=20
> Long answer:
>=20
> We would like to read the state of a pin from the GPIO client driver. May=
be we
> are already able to read gpio-hog states from client drivers and just did=
n't
> find out how.
>=20
> The idea is to standardize and simplify the dt bindings when peripheral p=
ins can
> either be connected GPIOs or hard-wired to some logic level.
>=20
> For the particular example of ADAQ4216, it can have PGA control pins conn=
ected
> to GPIOs.
>=20
>     +-------------+         +-------------+
>     |     ADC     |         |     HOST    |
>     |             |         |             |
>     |   SPI lines |<=3D=3D=3D=3D=3D=3D=3D>| SPI lines   |
>     |             |         |             |
>     |          A0 |<--------| GPIO_A      |
>     |          A1 |<--------| GPIO_B      |
>     +-------------+         +-------------+
>=20
> But the pins might instead be hard-wired, like
>=20
>     +-------------+         +-------------+
>     |     ADC     |         |     HOST    |
>     |             |         |             |
>     |   SPI lines |<=3D=3D=3D=3D=3D=3D=3D>| SPI lines   |
>     |             |         +-------------+
>     |          A0 |<-----+
>     |          A1 |<-----+
>     +-------------+      |
>                         VIO
>=20
> or
>=20
>     +-------------+         +-------------+
>     |     ADC     |         |     HOST    |
>     |             |         |             |
>     |   SPI lines |<=3D=3D=3D=3D=3D=3D=3D>| SPI lines   |
>     |             |         +-------------+
>     |          A0 |<--------- VIO
>     |          A1 |<-----+
>     +-------------+      |
>                         GND
>=20
> Or even, possibly, a mix of GPIO and hard-wired.
>=20
>     +-------------+         +-------------+
>     |     ADC     |         |     HOST    |
>     |             |         |             |
>     |   SPI lines |<=3D=3D=3D=3D=3D=3D=3D>| SPI lines   |
>     |             |         |             |
>     |          A0 |<--------| GPIO_A      |
>     |             |         +-------------+
>     |          A1 |<-----+
>     +-------------+      |
>                         GND
>=20
> We have bindings (like adi,ad7191.yaml [1]) describing the hard-wired set=
ups
> with function specific properties. E.g.
>   adi,pga-value:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     description: |
>       Should be present if PGA pins are pin-strapped. Possible values:
>       Gain 1 (PGA1=3D0, PGA2=3D0)
>       Gain 8 (PGA1=3D0, PGA2=3D1)
>       Gain 64 (PGA1=3D1, PGA2=3D0)
>       Gain 128 (PGA1=3D1, PGA2=3D1)
>       If defined, pga-gpios must be absent.
>     enum: [1, 8, 64, 128]
>=20
> This approach works fine, but it requires documenting device-specific val=
ues
> (e.g. gain 1, gain 8, ..., gain X) for each new series of ADCs because ea=
ch
> each series has different hardware properties.
>=20
> Sometimes peripherals have pins with different functions that are also ei=
ther
> hard-wired or connected to GPIOs (like adi,ad7606.yaml [2] and adi,ad7625=
=2Eyaml [3]).
> Software wants to know about the state of those pins. When they are conne=
cted
> to GPIOs, we can just read the GPIO value. But when the pins are hard-wir=
ed,
> we have to set additional dt properties (e.g. adi,pga-value) and then sof=
tware
> figures out the state of the pins from the value read from dt.
> What we wonder is whether it would be possible to have both the GPIO and
> hard-wired cases described by gpio properties.
>=20
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml#n77
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml#n127
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml#n70
>=20
> For example, instead of having
>=20
> /* All GPIOs case */
> pga-gpios =3D <&gpio 23 GPIO_ACTIVE_HIGH>, <&gpio 24 GPIO_ACTIVE_HIGH>;
>=20
> and
>=20
> /* All hard-wired (pin-strapped) case */
> adi,pga-value =3D <1>;
>=20
> maybe we could have something like
>=20
> /* All gpios */
> pga-gpios =3D <&gpio0 0 GPIO_ACTIVE_HIGH>,
>             <&gpio0 1 GPIO_ACTIVE_HIGH>;
> /* or all hard-wired */
> pga-gpios =3D <&fixed_gpio GPIO_FIXED_LOW>,
>             <&fixed_gpio GPIO_FIXED_LOW>;
>=20
> as suggested by David [4].
>=20
> Though, I'm also a bit worried about such way of describing the hard-wired
> connections being potentially confusing as those "fixed-gpios" would not
> necessarily mean any actual GPIO.
>=20
> [4]: https://lore.kernel.org/linux-iio/CAMknhBHzXLjkbKAjkgRwEps=3D0YrOgUc=
dvRpuPRrcPkwfwWo88w@mail.gmail.com/
>=20
>=20
> With best regards,
> Marcelo

--IJk9hVtxLgVTxZJO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOkaoAAKCRB4tDGHoIJi
0utgAP0Wwi0LDpomF8Ynt66f2B6WdGT5A/zQxj/GwL4f+WhADAD9H7yoIwchi7/V
T/w8Zuk/BBHdUbCDgnUYeNZEpay/uQM=
=Ukxv
-----END PGP SIGNATURE-----

--IJk9hVtxLgVTxZJO--

