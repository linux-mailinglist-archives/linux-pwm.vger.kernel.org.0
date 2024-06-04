Return-Path: <linux-pwm+bounces-2338-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6571C8FB4FB
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 16:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7840283EC8
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF0383AC;
	Tue,  4 Jun 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSV0wjnk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A519846D;
	Tue,  4 Jun 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510493; cv=none; b=M/xkmhLfNMs7/b0lEWEVorTJlEkZS8f89GspSLy39LbPFS4EWYUZSG1PdwQSLitDByrzSxECVusfBpTDxUi1gEsybK67NIRJdaW6cHc2/g3+ZDUlGvq7Up0EG9ZinnUdaAC1wo/08TtaIq5Svm+STNci1lGzpNcEW4i+Da593AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510493; c=relaxed/simple;
	bh=Emp2vNt0kaMHwv6fgDZVGPGPq7mJCSey6kFsDap7nuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB5RN2IzEnIpVadXE7XdVLU1ICKuM5jfrjgsUYXN1WmBCZWMaoXMa8q77vPJ64g7nDq8ibzEbO1Hi+Pt50rpmUV5iT+rGz5lUR18QvysISiPKAiQ4yYCiPwWbTLTvs0FKtZniq/u1BaiQLBx0LGlbJbuovpGC8kAZfGEbM5cyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSV0wjnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B280AC2BBFC;
	Tue,  4 Jun 2024 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510492;
	bh=Emp2vNt0kaMHwv6fgDZVGPGPq7mJCSey6kFsDap7nuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSV0wjnkXfg2rV+bQt5MQttTHYjWdjHF9CK1gGVyWQ3wI9FRjWH9gL/FHIIsurtfz
	 yFgs1omVWOfKo5ksb0MXaV27F24OZOPtH/IXQIQVfFSwUWqG0I91PKwQ5R4hIJ3JWZ
	 EljJmkw34TPnYXg3Up7zvLKcVk7elu57wfFlJZ+EfmAid3roAe1wCVa6mGU5WnKvXA
	 uIV6KnjCK6vaQHXcmLvP1D526xD9qXz/ZyRCxVQ6MKkXVSobrvSRFIhNLT7akihE0o
	 uSYykNktm/kowNlOmqJiXnHbovqNMyuMIIWu0RkXvcflwBLmBMMYmtTbWLgubpd3kc
	 ZSxV3tcNnLfbA==
Date: Tue, 4 Jun 2024 15:14:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	Nicola Di Lieto <nicola.dilieto@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: Add pwm-gpio
Message-ID: <20240604-creole-easiest-2146ac2ea996@spud>
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org>
 <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org>
 <CACRpkdbPGEx9QSazVfP7rbkM7x2MnJbrACdTi3zyniQhZSyTbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P8b0aBffJ4COSccn"
Content-Disposition: inline
In-Reply-To: <CACRpkdbPGEx9QSazVfP7rbkM7x2MnJbrACdTi3zyniQhZSyTbw@mail.gmail.com>


--P8b0aBffJ4COSccn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 03:38:41PM +0200, Linus Walleij wrote:
> Some buzz around the patch made me notice this:
>=20
> On Sun, Jun 2, 2024 at 10:33=E2=80=AFPM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
>=20
> > +  "#pwm-cells":
> > +    const: 3
>=20
> I guess we should document these three cells:
> - First cell must be 0 - just the one PWM on the one GPIO pin
> - Second cell should be the default period that can be changed by software
> - Third cell is polarity, 0 or PWM_POLARITY_INVERTED
>=20
> I guess this is 3 not 2 because the maintainers previously said they want=
ed
> it like this? (I haven't read all old mail, nor do I remember...)
>=20
> The #pwm-cells are currently not properly specified in the bindings: for =
example
> pwm-tiecap.yaml says "See pwm.yaml in this directory for a description
> of the cells format."
> and that file says nothing about the cells and what they are for, should
> I send a separate patch for that?

Does this suffice?
https://lore.kernel.org/linux-pwm/20240517-patient-stingily-30611f73e792@sp=
ud/

--P8b0aBffJ4COSccn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl8hVwAKCRB4tDGHoIJi
0sQzAQDB79qvEzSXOqctcAC9IyzJpzVjRToAWN2pNfPL6ftAxgD+NcEjHtiwXOHv
JsqVks3ymjb/GyOMWHWBEBdZJmyDFA8=
=oCvw
-----END PGP SIGNATURE-----

--P8b0aBffJ4COSccn--

