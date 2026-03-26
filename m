Return-Path: <linux-pwm+bounces-8381-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YECjLwIBxWkz5gQAu9opvQ
	(envelope-from <linux-pwm+bounces-8381-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 10:48:50 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F0332A0D
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 10:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3B103011C92
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3638AC8D;
	Thu, 26 Mar 2026 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rckrPF4v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4238C2AF;
	Thu, 26 Mar 2026 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518459; cv=none; b=IsDvnVRecTbt10QXd9VKuRFicLV9bIOHaSLsVFgT8Cf8k2HEn/Ke2cmYJurfwtwYqmxabq6hD47UrRDsDhtjeQr9jQ1E5tp6x6k36uOJgWTJTtiICKQtPoHA3TxzutQBi4eSZXz9vXDGj7ZQ0AOqO5xGwiWnkIu6eVPyU0Utsls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518459; c=relaxed/simple;
	bh=OHirXVSqp9HwGREkLUc3/ocLwoNpOSgHqJF9zkeBTfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3PRDroQAdznqABPIYYKDkL4N/q2V17b74M1vecVTElz/WI8bB16mDiRjqJe0+zTTU+3tjlhm3X+KMXrOqxNTtBDiik5aV3WyIGsb5wrmSI7Sr58wwc326yWqoJXIwR5R0tn+n+mZRgRgMeLXFCzClX8hbjZwkwnSlypCmePbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rckrPF4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646CFC116C6;
	Thu, 26 Mar 2026 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774518458;
	bh=OHirXVSqp9HwGREkLUc3/ocLwoNpOSgHqJF9zkeBTfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rckrPF4v1yQ2JI9bl3zfhrpeVVdKrVKpc2/vtUhDqRnzIxRgUBrLc7zs4hOkTRubK
	 00vQrm7oe++6Faufwggm0JvjBuEyrRSCh04OrizeQvZGdq4joiCvdXCwKkuCxRliiF
	 SfCPRjx9C17NpKsQ8++Ch+kmkmX47A5lAXcfur47d+GRgo5SE/4PGCP+cL38GKse8a
	 pTfoCKVCgdMB5XRhe/DI8GGHYBuTe2MCgPRyEyK9tDOItHyt/XhN/Fu7hZeH9szybU
	 RQ2mzx/Sd+IaSbQk3In7/DydPVBFw/8nFtNVK4FLKPLCvBJTIXdxx0CtLyZ6nXpjv+
	 EPxe3nRPfa3Rg==
Date: Thu, 26 Mar 2026 10:47:36 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v2 4/7] pwm: tegra: Parametrize enable register offset
Message-ID: <acT_nz0TRM4yXwkb@orome>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-4-998d885984b3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eikxdheegqdrxdfr"
Content-Disposition: inline
In-Reply-To: <20260325-t264-pwm-v2-4-998d885984b3@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8381-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 647F0332A0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--eikxdheegqdrxdfr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/7] pwm: tegra: Parametrize enable register offset
MIME-Version: 1.0

On Wed, Mar 25, 2026 at 07:17:02PM +0900, Mikko Perttunen wrote:
> On Tegra264, the PWM enablement bit is not located at the base address
> of the PWM controller. Hence, introduce an enablement offset field in
> the tegra_pwm_soc structure to describe the offset of the register.
>=20
> Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index cf54f75d92a5..22d709986e8c 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -61,6 +61,7 @@
> =20
>  struct tegra_pwm_soc {
>  	unsigned int num_channels;
> +	unsigned int enable_reg;
>  };
> =20
>  struct tegra_pwm_chip {
> @@ -197,8 +198,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		err =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
>  		if (err)
>  			return err;
> -	} else
> +	} else if (pc->soc->enable_reg =3D=3D PWM_CSR_0) {
>  		val |=3D PWM_ENABLE;
> +	}

This looks incomplete for the Tegra264 case where

	pc->soc->enable_reg =3D=3D PWM_CSR_1

> =20
>  	pwm_writel(pwm, PWM_CSR_0, val);

I think we need another write for PWM_CSR_1 here to properly toggle the
PWM_ENABLE bit on Tegra264.

Or am I missing something?

Thierry

--eikxdheegqdrxdfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnFALgACgkQ3SOs138+
s6EhQg//SmMsA2fte6QXhIElZieozmmS+2IkeK4+b4g9LdlHP7EdHNCJmCMo5mtd
9mKGgq+IbYtnE2+6D9MZJ1P/H3Pz2qfR3i2My2/90SK6DblAQW3QCSGa6bm7ye8o
g5YCQAprPeV0Wn0GnnWhZiNVBzm3vQmLxJ0cefP8V6iK57V+KPV0nbqjjxI/ARaZ
rGUnKP/lOA8QaSfY5E0uJLV5UqT0hPKdxRJ5fFvvuOtZCavu31jA0mIt75UpjG02
DheUbaHupdiWsbMwKjqro3RtCRlR3w+lwjDneXBS1Ioc0561PbIlgByfPXTcasGb
5mJOz+n9nFSHoyyieXL6Pa9t/TKMwgDeMqxnEkkz+p9iSODi1kXhG4n4LxibjLob
4KAm3kZ25doBMrBJhB2AjtW4tyB01ZJyxFfWqwrpw6s9/SJYYiplucYt3/CQ3Asv
GdEuy5CIvSMAU0aWy5bs6xM6mmE0eUQ0/ruMGgR830bTgj6bgnJVPhukhyfwX3gH
V+8HJw5Fbu8ahk+rylyGjlhMCOXHubPtMmE8/LQn9SUYpgPDFgwSmxzMkk5yKwXO
rJYd61+HPAk7Hfu5FrgsF5mH9xAykyLeGWD59nYh6i6lSyBAPU6yCC/gR7G8t6Bj
OCHvQOwjeyA9b3FvFdmtPv75g2oNeuhVCuLazE/Wqxp4auxBtQA=
=ge5z
-----END PGP SIGNATURE-----

--eikxdheegqdrxdfr--

