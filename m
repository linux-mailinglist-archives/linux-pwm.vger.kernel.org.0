Return-Path: <linux-pwm+bounces-7905-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D942D237BC
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 10:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6746305EC08
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 09:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FED34DCF2;
	Thu, 15 Jan 2026 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz1pLjDn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90233EAE4;
	Thu, 15 Jan 2026 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469042; cv=none; b=Atl9bxGPpd22gjclpSULVDHb93j4hD9Tq1kHu5yeGnGNWF5G/fOfJk0/KxAPNy2SCL7h77c8k1pZgjc/ZH9LNj8mq598rySbYVFvOlW0jZj7HIz3j2SYNTEMfBu7Zf0OB9C494MeHZ3DrS7TG31et/EQrVZ1lcoWS+tDDwnfVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469042; c=relaxed/simple;
	bh=vwXZPLv9RwgOAyi92He4PKpPDYLNtO4mf23V5viUZ1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC8f9wek3+Bkgnk8EX3R2SSOGHBRTIYgu4EsybHHdK1uF8dGkhlSD3839oSMZXBmzzxkNigwWPaFAtpPdY/WkGx7+oYgOdT5ep4J4LPca6qz/gSbVKTq1Ou5c46kFfFn9myOu84jLdt8V5BHsZ2sQZthhpF3hLPhxvtnJKKuRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz1pLjDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265D5C116D0;
	Thu, 15 Jan 2026 09:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768469042;
	bh=vwXZPLv9RwgOAyi92He4PKpPDYLNtO4mf23V5viUZ1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kz1pLjDnQ9lxokFII/U3OdF3jmfCDNdzEnd54JHX4a3d/4xuALoqjKDew3iqBDaTd
	 0mgFbHMLlC0ahi7XzEl1fPobAi0O8EoTGLIuo1XVhmsNZnoEkhjxKXYZQ4/A+sMMar
	 Lm3EVNNO5HqAW3nSMBOwvHnrnEHw8LXUHCL+W80FXGVgUHpINKOCQLcEDiqlAvoHDP
	 Ivx3uhTFeK+5Lpl1Px9BTqIsp47WKUk3bkKMHfZ0Mbm1dxAB7OifyBrooc0fX5K4oo
	 LVVgSNqzaCmhsWKFAzHunZ7iL4rWOIS+lrrYp2fn9RjQyMY3w9GDnICf1C4uobVYc6
	 FbLlompX4c5Dg==
Date: Thu, 15 Jan 2026 10:23:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 2/9] pwm: tiehrpwm: drop _MASK suffix from TBCTL PRDLD
 field
Message-ID: <njmjei2s434sjxc4dnmg7pzk7jj7cefejhqge5dzihksoljr76@tfq35w3obavw>
References: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
 <20251128003634.247529-3-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sv3x6qq77pbthzmr"
Content-Disposition: inline
In-Reply-To: <20251128003634.247529-3-rafael.v.volkmer@gmail.com>


--sv3x6qq77pbthzmr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/9] pwm: tiehrpwm: drop _MASK suffix from TBCTL PRDLD
 field
MIME-Version: 1.0

On Thu, Nov 27, 2025 at 09:36:27PM -0300, Rafael V. Volkmer wrote:
> Rename TIEHRPWM_TBCTL_PRDLD_MASK to TIEHRPWM_TBCTL_PRDLD so the macro
> name describes the PRDLD field itself instead of carrying a _MASK suffix.
>=20
> Update the single user in ehrpwm_pwm_config() accordingly. The value of
> the bit definition is unchanged.
>=20
> No functional change.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index b6020b2210db..f8625394c056 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -20,7 +20,7 @@
>  #define TIEHRPWM_TBCTL				0x00
>  #define TIEHRPWM_TBPRD				0x0A
> =20
> -#define TIEHRPWM_TBCTL_PRDLD_MASK		BIT(3)
> +#define TIEHRPWM_TBCTL_PRDLD			BIT(3)
>  #define TIEHRPWM_TBCTL_PRDLD_SHDW		0
>  #define TIEHRPWM_TBCTL_PRDLD_IMDT		BIT(3)
>  #define TIEHRPWM_TBCTL_CLKDIV_MASK		(BIT(12) | BIT(11) | BIT(10) | BIT(9=
) | \

There are a few more register names ending in _MASK. Would be nice to
change them all consistently.

Best regards
Uwe

--sv3x6qq77pbthzmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlosi0ACgkQj4D7WH0S
/k4QWQf/ZQHWfCBXEuVPSXw8fnD8V6Ndwdtq0Z2TKzPU07GY8fXWtuerZBcwRZhC
TepldZlzoRBd5B4H4j28lb0l80bYzb0OuwJGuDHe0Ah1tsCHPc0rBCT0V9G/q+O0
Nl7a3z0hX+rIQ6T1Mr1isoGx5Kwabfctnj2hFKqL/l13EV3EIj01fjOeys1Zgjd1
43AojPt6+PHgMs5TmOHpsPuvPYYS+AC0NqMg3kvNZgd7lx7Y3uNVKOZBIUn4uFHA
oatgE7Clr6QK4XsbRwCIhs7r25NVAugQ5QNblT0C5L9FP+IJbhMid7hPHsUmky+L
0OsKf1UApekUcFDjlfyb1RxFYxaj7Q==
=cZ6n
-----END PGP SIGNATURE-----

--sv3x6qq77pbthzmr--

