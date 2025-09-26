Return-Path: <linux-pwm+bounces-7355-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D2EBA4C76
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Sep 2025 19:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B547A8BE8
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Sep 2025 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BC2274B4A;
	Fri, 26 Sep 2025 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPJeV2c+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF501E570D;
	Fri, 26 Sep 2025 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758908492; cv=none; b=ZT4P9oAK2LAT9YIwwPfTthxWNmyMWqXWN8nmzvr7Rc43NS3NIcVzCiYdas5Yz3LLDKSU3SITYl+2fN3zIJ+yuonfcw+7pKY2CV8y57cSBeo0wFTBFcjb81fnywYC1NIwbFM3kio8Oa0T3OMOMHao959RfMkZnQLVYoA6emhGFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758908492; c=relaxed/simple;
	bh=y0e3n/Z5cwjnt8a2U4ygi4J6ovqvBuTey5rAbVKlvU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evU6XS/dARXOt/y2e1KV7MTf86vJI69A2OYizSTZE2HnWDwf7EsfKpDXK+E0L9DbtepZQ+Am4+Ilr5UZK9hMW3VoHCwNn8fwmg7UBtOqox5Y/SbhpNKR+mFeLd2enalS/R6jToX1Iahk8Tjvu6/1zqUFw3/TSsz/8daZyqfTsqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPJeV2c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B00C4CEF4;
	Fri, 26 Sep 2025 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758908491;
	bh=y0e3n/Z5cwjnt8a2U4ygi4J6ovqvBuTey5rAbVKlvU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPJeV2c+4uH6bFcHD0j1w2t2Y96QRurk6TyFSLJlwm/PmRc8DzhlxkwmTmjpYAeHe
	 o7mdsTYw8YDDgtIE9MhXJWGs/im8CD6xyj282zYSsU67MTgPpIFav37r/X6K595Vd8
	 /kqcWs7Ip6d4rWw5IXJu3tLBMBRaqefEtSzmceJY0bHTCIu610HN/1Yp7AtaDacWLd
	 iORga2EKfbq7gHSa8WB7NBV7Q1IcZg9oPJ77XmSrapEJB6g24xyS4wijtw5NQ8tAHu
	 +f5fdjT+kHzb0yp/K3TLyo6WLLp02Eb+kRqM1AFKwwpF/A0u/iMFzLT4xHbzQVGAHj
	 ZqEbpkWlY5wVA==
Date: Fri, 26 Sep 2025 19:41:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v23] pwm: airoha: Add support for EN7581 SoC
Message-ID: <dmtb46zsvj4hnn455n4gjhabl3sgpglcb4meoe3glwlzcpvqm7@3u7ds2rdmsve>
References: <20250708145053.798-1-ansuelsmth@gmail.com>
 <xsblhw36y3corxx3pxe6223auirrsqr3efovfnrm5lbo4xy3lf@wf3ytlivzv6g>
 <68bf2509.050a0220.702b3.c003@mx.google.com>
 <aMANiyqxneM1QxQ-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ghrrxael72tbnbfx"
Content-Disposition: inline
In-Reply-To: <aMANiyqxneM1QxQ-@smile.fi.intel.com>


--ghrrxael72tbnbfx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v23] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

On Tue, Sep 09, 2025 at 02:20:43PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 08, 2025 at 08:48:38PM +0200, Christian Marangi wrote:
> > On Fri, Aug 01, 2025 at 11:15:41AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Jul 08, 2025 at 04:50:52PM +0200, Christian Marangi wrote:
>=20
> > > > +	 * Period goes at 4ns step, normalize it to check if we can
> > >=20
> > > 4 ms or 4 ns?
> >=20
> > 4ms you are right
>=20
> One small but important side note (to Uwe as well, however he seems
> follows what I am about to say). Recently I discovered a nice wrap-up [1]
> on the writing values with units. And I think we should try to follow it
> (at bare minimum to be consistent with chosen =E2=80=94 Journalism vs. Sc=
ientific =E2=80=94
>  style).
>=20
> [1]: https://poynton.ca/notes/units/

Looking through that, that matches my expectations, apart from:

	Use big K for the multiplier (1024) common in computing

and

	When applied to raw bits, bytes or pixels:

	    M (mega) denotes (1024 K); and
	    G (giga) denotes .=20

=2E In my bubble at least Ki, Mi, Gi, Ti etc. is usual for base-2
prefixes, see https://en.wikipedia.org/wiki/Binary_prefix for a
reference which also has:

	Prior to the 1999 IEC standard, some industry organizations,
	such as the Joint Electron Device Engineering Council (JEDEC),
	noted the common use of the terms kilobyte, megabyte, and
	gigabyte, and the corresponding symbols KB, MB, and GB in the
	binary sense, for use in storage capacity measurements. However,
	other computer industry sectors (such as magnetic storage)
	continued using those same terms and symbols with the decimal
	meaning. Since then, the major standards organizations have
	expressly disapproved the use of SI prefixes to denote binary
	multiples, and recommended or mandated the use of the IEC
	prefixes for that purpose, but the use of SI prefixes in this
	sense has persisted in some fields.=20

Best regards
Uwe

--ghrrxael72tbnbfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjW0EYACgkQj4D7WH0S
/k5Akgf+KVkYoIdt1UZKCDIW+QTopKdc1hY4AziC7pnanooit5PHNA9mzS57lgHL
RhhSyAHlj7aJEJUyoqe44wlFgloLlLCG/sYKnp5+3qydNTBM9vJY4mnz1lUea8fJ
/GmmhuKE7RJuAkyMoglisr9XiQQ9920gAR3eT8hvLRNbjyCRMI7bPJvLMEsLAAb8
ZKzqsDfZsbFZhCibdIA1uA7RrCXDl5m8/P+9cwy14tufo0EgftSeC9NELjyz0xFP
21JUh18kKsfGOCRDD0RJs6n/XnXk/HkAnHpDHec30FxxzPIweq+lADc7aUAmTVbn
sa4r2Dch9kzlI3gMVAWCpYlSB1eLBA==
=VjO9
-----END PGP SIGNATURE-----

--ghrrxael72tbnbfx--

