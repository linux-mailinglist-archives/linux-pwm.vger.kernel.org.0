Return-Path: <linux-pwm+bounces-3591-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BAD999489
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 23:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A961C21CC3
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 21:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D5A1E2029;
	Thu, 10 Oct 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff4smxCo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98B28F6A;
	Thu, 10 Oct 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596498; cv=none; b=L6NttK9c2bBcXtjhDHRGk9cPoXHIahkXUywDt+Pnzw3hRu8sTFWrNGQPzAAQkDoX6FNaJ9zzf+pTC/eoqnduMbZwA+HAklLDATLvlWiDjRc4ZC5eHuuet+pOKSApjDTLm98BClqoUcmp/PIAKVkmAk55TVAZKSVwJoApm6S7KpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596498; c=relaxed/simple;
	bh=Q3NSqYisG8WYYrz9LbzVCsdGWId+yQgVgrE9CldSbWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjtOXljznDDAG6tj+AsWIgQMseEPX0HBIBcLNeeBUmmeEyppNFoUgFLIprAUH4Vqf4TEa/tgAgagtAufgJk898JX8/X4BTjbabrnqry7CCc1qUNoHwJy0qbSpvR3+2F3Ox5qnZvUIXf+USQkKxyfpXWx5IUIEnIPv+upqHqMa3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff4smxCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A19DC4CEC5;
	Thu, 10 Oct 2024 21:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728596498;
	bh=Q3NSqYisG8WYYrz9LbzVCsdGWId+yQgVgrE9CldSbWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ff4smxCowyQsOzSZBcDuIyVWqWv/61X1uavBKz8DJUX8cXkv5+Mx3jGn8sbcG38EP
	 4fRAu7327zqxPs02gP0WqVovMYHXhL4/1XG3ck/E2sXzoWygvrJLe4pJxdskmMmggb
	 OcR53YMM6BpHNp5pgxfil2lMD8PpEcKDVI/zvObcCJrfrHZIKhwpk2SDazat7jCQ4m
	 uuaUReEE9U3KB1VxljIDS2k2i2iZu2Q0XV4+eJAUbI5SO1sDG73k6bDyl4bUSBQkyq
	 s6TlXLpKUc9wiG2DPyyVafAuPndNXHQorowMctwTQ+9B2igTSUjmoo2xTB210y1KYJ
	 n6/47pTrMCMoA==
Date: Thu, 10 Oct 2024 23:41:36 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
Message-ID: <ZwhKECIpL7g7ZGEC@lore-desk>
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org>
 <20241002132518.GD7504@google.com>
 <ZwWscWk5axQI9H1t@lore-desk>
 <20241009104821.GF276481@google.com>
 <20241009105550.GG276481@google.com>
 <6707a8ec.df0a0220.376450.293e@mx.google.com>
 <CACRpkdanpA-wq0sYv9HRF=uVeAX_mW4LaKhE8i6TgC9+0d7bCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Fg0vtOBpPK/9AuB"
Content-Disposition: inline
In-Reply-To: <CACRpkdanpA-wq0sYv9HRF=uVeAX_mW4LaKhE8i6TgC9+0d7bCg@mail.gmail.com>


--3Fg0vtOBpPK/9AuB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Oct 10, 2024 at 12:14=E2=80=AFPM Christian Marangi <ansuelsmth@gm=
ail.com> wrote:
>=20
> > mfd: system-controller@1fbf0200 {
>=20
> Drop the mfd: thing, you probably don't want to reference the syscon
> node directly
> in the device tree. If you still give it a label just say
> en7581_syscon: system-controller...

ack, I am fine with it.

>=20
> >         compatible =3D "syscon", "simple-mfd";
> >         reg =3D <0x0 0x1fbf0200 0x0 0xc0>;
> >
> >         interrupt-parent =3D <&gic>;
> >         interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> >
> >         gpio-controller;
> >         #gpio-cells =3D <2>;
> >
> >         interrupt-controller;
> >         #interrupt-cells =3D <2>;
> >
> >         gpio-ranges =3D <&mfd 0 13 47>;
>=20
> I think you want a separate GPIO node inside the system controller:
>=20
>   en7581_gpio: gpio {
>          compatible =3D "airhoa,en7581-gpio";
>          interrupt-parent =3D <&gic>;
>          interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>=20
>          gpio-controller;
>          #gpio-cells =3D <2>;
>=20
>          interrupt-controller;
>          #interrupt-cells =3D <2>;
>=20
>          gpio-ranges =3D <&en7581_pinctrl 0 13 47>;
> };

So far I implemented the gpio functionalities in the en7581 pinctrl driver
(as it is done for other mtk pinctrl drivers) but I am fine to reuse the
gpio-en7523 driver for it. Do you prefer this second approach?

>=20
> So users pick GPIOs:
>=20
> foo-gpios =3D <&en7581_gpio ...>;
>=20
> Notice that the gpio-ranges should refer to the pin controller
> node.
>=20
> >
> >         #pwm-cells =3D <3>;
>=20
> Shouldn't this be inside the pwm node?
>=20
>          en7581_pwm: pwm {
>                  compatible =3D "airoha,en7581-pwm";
>                  #pwm-cells =3D <3>;
>          };
>=20
> So PWM users can pick a PWM with pwms =3D <&en7581_pwm ...>;

ack, I am fine with it.

>=20
> >         pio: pinctrl {
>=20
> I would use the label en7581_pinctrl:

ack, I am fine with it.

>=20
> >                 compatible =3D "airoha,en7581-pinctrl";
> >
> >                 mdio_pins: mdio-pins {
> >                         mux {
> >                                 function =3D "mdio";
> >                                 groups =3D "mdio";
> >                         };
> >
> >                         conf {
> >                                 pins =3D "gpio2";
> >                                 output-high;
> >                         };
> >                 };
> >
> >                 pcie0_rst_pins: pcie0-rst-pins {
> >                         conf {
> >                                 pins =3D "pcie_reset0";
> >                                 drive-open-drain =3D <1>;
> >                         };
> >                 };
> >
> >                 pcie1_rst_pins: pcie1-rst-pins {
> >                         conf {
> >                                 pins =3D "pcie_reset1";
> >                                 drive-open-drain =3D <1>;
> >                         };
> >                 };
> >         };
> >
> >         pwm {
> >                 compatible =3D "airoha,en7581-pwm";
> >         };
> > };
>=20
> This will make subdevices probe and you can put the pure GPIO
> driver in drivers/gpio/gpio-en7581.c

We could actually reuse gpio-en7523 driver (removing the gpio part from en7=
581
pinctrl driver) and extend it to support irq_chip. I do not have a strong
opinion about it.

Regards,
Lorenzo

>=20
> Yours,
> Linus Walleij

--3Fg0vtOBpPK/9AuB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZwhKDwAKCRA6cBh0uS2t
rImsAP9+SEsCTPYOJYMr4ud8qWMHenJk1t0UVS3lUEut+um/GAD+NxbBrcxxZ9S+
X5f21EFnXDysNRmyWuVjeQzkIJdZ6A0=
=CX97
-----END PGP SIGNATURE-----

--3Fg0vtOBpPK/9AuB--

