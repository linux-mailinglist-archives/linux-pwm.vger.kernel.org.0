Return-Path: <linux-pwm+bounces-3972-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E409B5D65
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 09:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A80B1C20E18
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7245E1E0B70;
	Wed, 30 Oct 2024 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMxH+Bbw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260C1DFE16;
	Wed, 30 Oct 2024 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275890; cv=none; b=hpBcYKXsXlN/aX8sZSlF19Yw8KLf9nzBDcXNxEnZ0GTJ1pN4hJqAIASrUBC5XeoAk5P7oh+D8MagyoG3VODX+ur3r6JY6LN01UrRm+hkXzxLGf3SDBsqSloCD8WbPCb60460cwolb0GlCjkw9kFBmew393X8j2wBAIyrsTP/Xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275890; c=relaxed/simple;
	bh=8D0w9FIRPWyl2qa3PqA5hpbOpMX+liBfZJc9yUSbUpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJXc2rygq9yMUoG6OPYrl9d/Bqec/gLUOUBPAfQBLptWUTFPIU7knWP4Jc2jDFOlAEok81SC2aHReAMqk+gnUxh6ZnfNYeT7n3NFzOCIwknISStveI/Kn+Td6zxk0VXO+MPUZaKMs1a5bqdIZBJSnA/Pzb2yayBLo7g1Kd3eimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMxH+Bbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9678BC4CEE5;
	Wed, 30 Oct 2024 08:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730275890;
	bh=8D0w9FIRPWyl2qa3PqA5hpbOpMX+liBfZJc9yUSbUpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMxH+BbwTSKjy568knTV4h+K4UrEgT1DP4G+0dSxhh5uu6cPEENMrkp+KDzN7Znze
	 oFLRmCZ58RxhV3h2MJWf0EApSSldEum89y6gn1PXAFNrj4rYlmTjmKuE8bpMsRCC4L
	 0NTVGa27/G/gNNPWkkryVnssJh4vk17oM6q2CAdKypJIXVyjRN3O+eh8cujPenesAW
	 saIoT0Cu//rx4iImWt8ZU4Wb0nZM3yFp64kGB2K/Ut7n5M52hYPzO5s4bKHKGoMDOS
	 FpdtbS9qLq1GGkYbDk67olXCz+/JzUp9vkx9xOIKn6zYBRtbY9RlWQSdSKCHB2AB1x
	 JcvtRL2cfMj2Q==
Date: Wed, 30 Oct 2024 09:11:27 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	benjamin.larsson@genexis.eu, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v9 0/6] Add mfd, pinctrl and pwm support to EN7581 SoC
Message-ID: <ZyHqLyycmaOVW4JZ@lore-desk>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <CACRpkdaEQYBim8TuDCCw15QDUWhHC-VqhGq1Le7eOd76k56zwQ@mail.gmail.com>
 <t7i6lkx5oedjma6uauiygnvbgzixnsqmolmkse3j2qiy5znf7t@kfozote6mm2k>
 <6721e35f.050a0220.b8d65.2cd0@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="80BL33JVuIzeKKlY"
Content-Disposition: inline
In-Reply-To: <6721e35f.050a0220.b8d65.2cd0@mx.google.com>


--80BL33JVuIzeKKlY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Oct 30, 2024 at 08:34:01AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Linus,
> >=20
> > On Tue, Oct 29, 2024 at 11:03:14PM +0100, Linus Walleij wrote:
> > > On Wed, Oct 23, 2024 at 1:21=E2=80=AFAM Lorenzo Bianconi <lorenzo@ker=
nel.org> wrote:
> > >=20
> > > > Introduce airoha-mfd driver in order to load pinctrl and pwm driver=
s for
> > > > EN7581 SoC. airoha-mfd is needed since both pinctrl and pwm drivers
> > > > needs to access the same memory block (gpio memory region) to confi=
gure
> > > > {gio,irq}_chip and pwm functionalities respectively, so model them =
as
> > > > childs of a parent mfd driver.
> > >=20
> > > OK someone has to merge this and I suggest that I merge patches 1-5
> > > (all bindings and the pinctrl driver) since the different bindings ha=
ve
> > > dependencies between them.
> >=20
> > Fine for me.
> >=20
> > > Then Uwe can merge patch 6/6 (the pwm driver).
> >=20
> > The pwm patch needs some more love, we can handle that separately then.
> >=20
>=20
> Thanks for the feedback, so I assume we will detach the DT and PWM
> driver from this driver and handle it separately.

Yep, discussing with Linus, he is fine to get patches {1/6-5/6} via
pinctrl tree while patch 6/6 can go via Uwe's one. It seems we are
good for patches {1/6-5/6} and I will fix patch 6/6 separately.

Regards,
Lorenzo

>=20
> --=20
> 	Ansuel

--80BL33JVuIzeKKlY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZyHqLwAKCRA6cBh0uS2t
rALVAP97S+IgH/EXv4BXt+XDVm2AJB0jwqZ2QJOs2532TijmZQEAqATti3LmR9d4
f7eWIZ3b+I/MAhW+9Ll8/L5m47UxOQg=
=Yh0L
-----END PGP SIGNATURE-----

--80BL33JVuIzeKKlY--

