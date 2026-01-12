Return-Path: <linux-pwm+bounces-7892-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F006D11093
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jan 2026 09:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B0C301D66E
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jan 2026 08:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BC533986F;
	Mon, 12 Jan 2026 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgAOBorA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E0238C03;
	Mon, 12 Jan 2026 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204800; cv=none; b=OebW5IfdYK1LzIvE82Ru6ns4KuvHe7oaB0tNq9s017F3T/Oooedr64fUJrFVQxtj+J/GdwS4TSoBLS7ooKiljouDHMdp8lTTWJwVKHbyPSrkv5I5mGqg1THs9hJ39ronkPdpCy0Z5cS1TS677rTSw1tzVqSuKcJ2ykMNBJh12O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204800; c=relaxed/simple;
	bh=ZO9Fl4GmDk1kumQVN6/vQNOOxDfh/jIRvC+QW/StR68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn3i8wCo0DytQ/k1zyRNK5ZYPcX6cnML5iq9WXNS8eDAfadbPDAsUJ6X200wQ0/8BHxD5QkmRbstUa3o166CFvXmNsas3OZA6vpin2Fetmz6LTz0CR3vn1Gc2U/43+8ZKU39vFf1gRaLsyy8nfEt+7p3srgFLtiGS6WWo/Fj0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgAOBorA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06ACCC116D0;
	Mon, 12 Jan 2026 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768204800;
	bh=ZO9Fl4GmDk1kumQVN6/vQNOOxDfh/jIRvC+QW/StR68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgAOBorAgodcErkbf0KIxHAGrTYismgF7Ir9FwA7xLPGujLp/Dsqs711qD5vs8fbb
	 S7Jbe8XK9uFVQi6Jdo4+2X77VbxyDsiqdf/iaH//Nluzx0rrShvw5ArpEBPCip6t0f
	 r+vy06UhKRy3qADad1JbwkPYW/McNbNKTmnl5q2/lQgB8MZMoFW+gDLKVw0ucgkd/S
	 bxnbCo90TqRoTF0dPcwKMh5Bi8cxBNp0dI9zr0pSlwvzEpuRtUtz6pv9FfJ7E5h065
	 jKUt44qhVHEaVV0E0c8s4QbKq9FoK++F5QYj9ikSjn9ee5pLCDRpAAHdRRZVJ69UIV
	 Sw52NO0GXNq0g==
Date: Mon, 12 Jan 2026 08:59:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: Use size macro
Message-ID: <whjyiyejzdss6mwo7s46kmtshiawwkvoeheg3qjomlfndqhqve@uoaw3eyejent>
References: <20260105091737.17280-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5de6k42bhd4puwy"
Content-Disposition: inline
In-Reply-To: <20260105091737.17280-1-raag.jadav@intel.com>


--z5de6k42bhd4puwy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] pwm: dwc: Use size macro
MIME-Version: 1.0

Hello,

On Mon, Jan 05, 2026 at 02:47:37PM +0530, Raag Jadav wrote:
> Use SZ_4K from size.h instead of hardcoding constant.
>=20
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/pwm/pwm-dwc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index b6c16139ce4a..86b72db58741 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -22,13 +22,14 @@
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> +#include <linux/sizes.h>
> =20
>  #include "pwm-dwc.h"
> =20
>  /* Elkhart Lake */
>  static const struct dwc_pwm_info ehl_pwm_info =3D {
>  	.nr =3D 2,
> -	.size =3D 0x1000,
> +	.size =3D SZ_4K,
>  };

I don't feel strong if this is an improvement or not. I applied it now
with s,size.h,linux/sizes.h, in the commit log.

Best regards
Uwe

--z5de6k42bhd4puwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlkqfEACgkQj4D7WH0S
/k7cZwgAtYKbd0/D68bEmzamvSzfgIq1VcP/meZMuxGHCM/PLJLbw+CXW2zQ5fOF
ABAqey3B4eURrXdwrnXDrAeWq5/EU5lI9rZIqRkDu3BXV77lAc8kHXwrvilGGRvn
q8iuSFmVBRjKfOQrv9Ds6bACFup+piK18aXrCb9LK2Ed3bpIUlLV6U6vBaRH/xzd
xB2G/R4T7mCXxxSrNVCeWqLB6Lb8Vh959/RWPUiNkNYYyP4CCIBeLcM8uswduxbH
whPyelvOlDAf5g20GjY5bmr64/oQY9f4CDIvd0K7FX5aCKFA8wMbU3xZnlLC+o/O
hsYFPfRNimSgC8dWYU/NdwAUERU+5g==
=zXWK
-----END PGP SIGNATURE-----

--z5de6k42bhd4puwy--

