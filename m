Return-Path: <linux-pwm+bounces-3435-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7228598DF5F
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 17:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2958728123C
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 15:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4793D1D0B8B;
	Wed,  2 Oct 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4xcgL3G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E81D0977;
	Wed,  2 Oct 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883443; cv=none; b=Y+RK20yS+5eaW945SF+9qzJNLQske2rXmiz1N6f0uf+9aW/rANdOmsqdoyMm8PNwRKx/oWkjZywuIeBJVqKnfkogYS/HI+Vp6C3R86m/JLUmrY5b8WqHLCHwTW19wZoiLQxnApe2tfUVk6vStqzpEbPH3Ht3A4CH3kBUIskA8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883443; c=relaxed/simple;
	bh=MT4X6dcUBubM7lv3hZ3oqvwfLote9SJ8fD8+SCx2gBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7isk/CzBc5rca+ZiSVGc3fVKp8RX2B6TYbR1DMOUkbcLW1lZQ13q26+65gvajgzUHtTXxQaooEs9g/SxMyzZ83lrAKONZYEiDSw6FMBypg8EzoGQ70VcBi5lBNmJ+hGuE5VdeIe9+Gts3kYcfU/QslY2kdqTyHTKtLqit7kZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4xcgL3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7E8C4CEC2;
	Wed,  2 Oct 2024 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727883442;
	bh=MT4X6dcUBubM7lv3hZ3oqvwfLote9SJ8fD8+SCx2gBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4xcgL3GFikjK83sb/zEk3muR672O4FB+EWjIvN1EEV0kUm4SyD2xrOJXtA2aT5p9
	 rQVMEm0ENcfjYKOVo3/gQs/7/tPnRY5rOKXeGjyaAJMHtu4nXx4hHN2lXeZgxoT81L
	 R+p/DzvgaPRn8dUhkxF7L5OkWXR9Zu0IQgIOMc2VE72/mczuJFLeFvpnUnqERk1v4K
	 fyvqSnq3TBG1MYWD+YQl+fXtsnjlPDomZTi5spljfD9e7k7ZdzZ4vLrcjFFvsh++OD
	 f2RoU6509kT+8jhnpFaI0S4rthE0CS5eLXeBVbvpbgNshz4xzUaQcOzzAXPEy1oJF4
	 7XwOUUSsFmSZA==
Date: Wed, 2 Oct 2024 17:37:20 +0200
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
Subject: Re: [PATCH v5 4/5] pinctrl: airoha: Add support for EN7581 SoC
Message-ID: <Zv1osANiy8n8Um6y@lore-desk>
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-4-dc1ce542b6c6@kernel.org>
 <CACRpkdZMWKb1h0-sWECCY0E3CxxMyLwCr4M3k6vrY9aAfpzMVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WN0rmCbHDTHdyjt5"
Content-Disposition: inline
In-Reply-To: <CACRpkdZMWKb1h0-sWECCY0E3CxxMyLwCr4M3k6vrY9aAfpzMVg@mail.gmail.com>


--WN0rmCbHDTHdyjt5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 02, Linus Walleij wrote:
> On Tue, Oct 1, 2024 at 7:30=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:
>=20
> > Introduce pinctrl driver for EN7581 SoC. Current EN7581 pinctrl driver
> > supports the following functionalities:
> > - pin multiplexing
> > - pin pull-up, pull-down, open-drain, current strength,
> >   {input,output}_enable, output_{low,high}
> > - gpio controller
> > - irq controller
> >
> > Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Co-developed-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> I missed that there was a v5 out and responded more to v4.
>=20
> Anyway, I think the last comments on v4 still need to be
> adressed:
> https://lore.kernel.org/linux-gpio/CACRpkdbXWMU+wq6DvviCQPQ0EzKUm9oOnyFh3=
4Bm=3DY8K-HmT0Q@mail.gmail.com/

ack, I will do in v6.

Regards,
Lorenzo

>=20
> Yours,
> Linus Walleij

--WN0rmCbHDTHdyjt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZv1orwAKCRA6cBh0uS2t
rK7xAP93gThE4rrEfzNcqrw85E3kcerWOJOqVnoTi+WpWW2JEQD5AeuJvNtGZp6n
HH4wNjZ7Z5fXcCBfgVML15h4HOZWowg=
=eXGw
-----END PGP SIGNATURE-----

--WN0rmCbHDTHdyjt5--

