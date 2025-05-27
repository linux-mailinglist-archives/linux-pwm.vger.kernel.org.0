Return-Path: <linux-pwm+bounces-6144-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B4AC4B00
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5750C7A3122
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DD724A069;
	Tue, 27 May 2025 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsr3+FxZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D7F50F;
	Tue, 27 May 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748336607; cv=none; b=a8B15eCc2j08cP7zJq44Mch4dwSFOkVnCv4RevKeDtQQqHWPHSAuytFNUfjKqRjshmVDla7ZaM6uiEyZuSPXVkdS6k4+aJBgUdz3nkJUrSN3Jsv7Fk05D6MYMfCsNarSoQIP9OsEdohqKcLKKVR8SbfImjvIZdvXDM5rmAMmVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748336607; c=relaxed/simple;
	bh=CepjyP+8Q0P8lM7xYgC7fRcPO5/D444YGpDm/oPFMSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvEzRuIR6WqypzJDV3yG3DYLMD1cZqmZZTMYgwpxEMNb23D6G9Kf2f4cV4xLQjFT8+WbCMRH4w50LXNueziPjvuJMzfsCC+OXgo+OZtMd4z3R2bmc5AW86QuEQrANtkxd8shQZyPUAW58AQPcxpzHa9nMgycWLEsCIi0JCEfw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsr3+FxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD77C4CEE9;
	Tue, 27 May 2025 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748336606;
	bh=CepjyP+8Q0P8lM7xYgC7fRcPO5/D444YGpDm/oPFMSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsr3+FxZDJEeNzjVpWICNvLCrY2dAQ6fM+iHHjwd1LIfkdiIacQV2KvO7a0ud7U0c
	 jUi8nOf1811mTewLQB1jrm4TbfRivKocjf91TNEBbmpv9nH7zAYFnTnrMT2KYQ0x6W
	 brNuYokQS0qR6oF38Y+sfENS3vY5ppIGfsjfK9kfEXQg3ue9KlbfHhRBhx9bRAsDFq
	 dvqPzC3It9Es2eUYtcOuuKoD5VvbtbuWfVdUtJfSR5nov2OjhuDwbEd80uIVjCShn/
	 x4WkaUsCQtiOza4xi4S9+dieTwxB9ofpwIfXbdNakLQplD6zxHKqp3GnYqIpyx9Cqg
	 xY+MiDA26ekiA==
Date: Tue, 27 May 2025 11:03:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com, 
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr, heikki.krogerus@linux.intel.com, 
	elder@riscstar.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v3 0/6] pwm: Update PWM_PXA driver for SpacemiT K1
Message-ID: <e2erhnhqfeeb5b74x5aspowgdiqdnywmfswl7vhgr7wt3pacns@j2lbkcnjl7ne>
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <lgjntm2v4qtp3uwccriodxdefdc4vqydzl4dmula4avhws4zfi@xevkgzfuhyhl>
 <CAH1PCMZBBmDibwSLUAhDAyjAORgpS+D-U5_kfLJkbZ2r=XpFDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26g7v56eogwogiqd"
Content-Disposition: inline
In-Reply-To: <CAH1PCMZBBmDibwSLUAhDAyjAORgpS+D-U5_kfLJkbZ2r=XpFDA@mail.gmail.com>


--26g7v56eogwogiqd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/6] pwm: Update PWM_PXA driver for SpacemiT K1
MIME-Version: 1.0

Hello Guodong,

On Tue, May 27, 2025 at 10:41:20AM +0800, Guodong Xu wrote:
> You're right that patches 1, 2, and 5 do not depend on that reset series
> and can be applied independently.
>=20
> > [...]
>=20
> Yeah. And I confirm that they can be applied without the reset
> dependencies.

Thanks for the confirmation, pushed as is to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-nexxt

(i.e. as material for the 6.17-rc1 merge window as the PWM PR for
6.16-rc1 is already sent).

Best regards
Uwe

--26g7v56eogwogiqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg1f9cACgkQj4D7WH0S
/k6Dhgf/X9WuY7qFhMFlefMe19qBwAufGzkajhCdv+bnqB05R5v/Jt+kVwQmhzec
6mBTGEvmeuNhKUA+kXqLyiTEs36yUqVI6LScD9LHe6QzBQaCmMqYelh8SgcfZ4iO
kubD1Zz0uZdhiqzajOI7+z+foBW6rZ7qgNYuOlvjPaNP2YCUYRNd8ypUGCYVn9Zr
mwZvDCDrnH2G+4Cchw+4quN/mGHULoyJawC9djxSfLhWPg72AxLlABSovzvIC+hh
b/uI5FRi/EIzcate4L1hKTVHF9rFIipT3gUv9sFbINCtAUKLhvZ/MlBVLeGWGiiK
40qWRrtpvZ859pNH+jYQzAHk2rmYYQ==
=GMeA
-----END PGP SIGNATURE-----

--26g7v56eogwogiqd--

