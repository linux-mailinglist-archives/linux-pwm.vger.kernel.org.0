Return-Path: <linux-pwm+bounces-7576-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7F1C2792D
	for <lists+linux-pwm@lfdr.de>; Sat, 01 Nov 2025 08:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0194F40031E
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Nov 2025 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D9D1F09B3;
	Sat,  1 Nov 2025 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7bnfDi5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738D219E0;
	Sat,  1 Nov 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761983321; cv=none; b=VcVLJ18BLLJVVS/YJDPfkf48Lf7+OVaHPjgBPlfs6Av1Ukl2gLeq3xTode7/z9nFSKhtUd3fP6fX0dqR+U5LpAvjojHELZM4aPbXMr7iPwjt+hUygaK9+ojemhdxvZYSJnq5DFgk1gS5c/Y7CCkDb3efvSCNTAcMum8oROjNf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761983321; c=relaxed/simple;
	bh=mzAWt0VYI2RyQ0sip9V2G/bfNrEhs9YdzGH+8hO9s6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT4QAlvZ9Vz9nLLOtT5DUs/PJmVTcfO09qbK0vqoiOjqlsx2wX++mk3hhCAMR+X9cC3XH/YC2JcW3uSaw3/f++JQLgKnvhkTFiE3PpcixrIeCOX/F1pEaFnW22pI+iKgl1IKlY8hKFodAKXEV/SQfb82lrJPekFEwKQ6VnorHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7bnfDi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2019DC4CEF1;
	Sat,  1 Nov 2025 07:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761983320;
	bh=mzAWt0VYI2RyQ0sip9V2G/bfNrEhs9YdzGH+8hO9s6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c7bnfDi5RwaUlmioUjOoNv55m77nO2La3QV/AhD0KvFBRsWKuoHmveiYpenDOMYyt
	 T/J+hHj9+q0D+hZ/a+0LmV5lkNC7C7g9H9S8SbZwaJVHuIUBcQqAqFxF/6T1UtYgTX
	 iFcanpz3rDdkeqmSNUO61XnHX9911kxotK26C5bkb97+jEZF7Rnnl0IF/pysJjm1sV
	 YqJs0poQ4qd7+C/GqENThkq0AE0PJIDTPPEfIJEt9BPpEsXfeLJ+ArStQZAgF6ZzHl
	 IpSikK4rsOtasXtKVxw9JpiTC1SqrcsAsEuXX0bh7DizbcpVMXbWf+mCtIDG8PAVlJ
	 pruy6NXeFHUnw==
Date: Sat, 1 Nov 2025 08:48:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v24] pwm: airoha: Add support for EN7581 SoC
Message-ID: <d7muk67gsfgrz7ykw57gq5koepa6c3sjt2kqbalcudmilux4fp@yueqgglt4aon>
References: <20251013103408.14724-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y2cpikgkm6gyrjug"
Content-Disposition: inline
In-Reply-To: <20251013103408.14724-1-ansuelsmth@gmail.com>


--y2cpikgkm6gyrjug
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v24] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

On Mon, Oct 13, 2025 at 12:34:03PM +0200, Christian Marangi wrote:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
>=20
> Introduce driver for PWM module available on EN7581 SoC.
>=20
> Limitations:
> - Only 8 concurrent waveform generators are available for 8 combinations =
of
>   duty_cycle and period. Waveform generators are shared between 16 GPIO
>   pins and 17 SIPO GPIO pins.
> - Supports only normal polarity.
> - On configuration the currently running period is completed.
> - Minimum supported period is 4 ms
> - Maximum supported period is 1s
>=20
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

I still have the impression that the bucket selection is more
complicated than necessary, but I don't want to delay this patch
further, so I applied it to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
as 6.19-rc1 material.

Thanks for your perseverance,
Uwe

--y2cpikgkm6gyrjug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkFu1IACgkQj4D7WH0S
/k4tAAf/UztN30JwvU+zVhO9+M9lu/hfAcDNAjMI1yRXXjBgi+/3fmLWbZ5r8iX5
lk2z27Rus93Bh53VjsXRQsqauKs78efxE4vl+nsbHbiz8dAPT3Qtt06EQEk/qfAp
gFOPDjJEt7E65fBiOwgHTvS2rZRz9tdJdGCHulDaUatE1d4lWDuj6djSKU3QcQ5d
sLrXVG5cAGTkh3fosOmOnTSz4MB6SvfVxMf09bYnuAlDa+aH6y9tcqLQxk4GLXqT
c7vHts8UZ/Rg9uuLssyVx5C7VqVMYG8SXnI/1oIMnHZlxlTe3TsmFjTvKL5/SiQJ
nwmgmfg/jBFn8WTweB5rlOQ+enwC2w==
=WCAa
-----END PGP SIGNATURE-----

--y2cpikgkm6gyrjug--

