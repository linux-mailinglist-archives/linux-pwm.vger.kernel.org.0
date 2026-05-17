Return-Path: <linux-pwm+bounces-8939-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLz8EX/9CWpPvwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8939-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 19:40:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6969562AA9
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 19:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C2673023371
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A553CAA39;
	Sun, 17 May 2026 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+dsyEp9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715A3C7E13;
	Sun, 17 May 2026 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039339; cv=none; b=et9HPCidEtJyE1egkhES3Dvvh3nee/clhe+9GViOR4fwCjPh1dv06P0upkUg/G7v7NdE+pPXK/guHyE3mf9bI8MkXn0AQDul0ZLKjBHKXCItGr3Z0cxDjM83pny/0P4mlaJS5wDJlc+IxEBoKVtS+RgKbwj1OLsuSVi0bssBdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039339; c=relaxed/simple;
	bh=kHEmJEsLgjrrwfX1LtaGf01yk3PATkzVpCn7a91Gql0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3I/wE8OSjLs6k+R1mbJZQbYRbANB3KrZ2lDn+f1JmEwKhgSt64vTPV/aXob+6gK0PpgxrKP6A+Aoxbu5RIjSrVnNXbFXPCL6XYgoOP2IcoPcYYN4Kz4BUagDJppdYNx3uHR5bhBHEiCfKbqggBETDQ+Wc5PZvbecXZQtaT5huE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+dsyEp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B6BC2BCB0;
	Sun, 17 May 2026 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039338;
	bh=kHEmJEsLgjrrwfX1LtaGf01yk3PATkzVpCn7a91Gql0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+dsyEp90fD12YbOY4YALF7F/baFhWY0GpNZGya6zkNeXLopP1G2hksI8cmqIm5yV
	 /VB7prgURakNbtRyyeHp7YHrfhUKIVF+f0v4DXsH7x+wi1JJfG17qU79DFNGdBCTN7
	 nk2bmHPlG69nrca9QQhvbjOUaa/F8jI4gG6Czke1mF7d4+V0ywwNJzVbG+QQoD/x8L
	 q1FHHH2ATWfkcPCuLtQXfBBv6yKdMa+RDp8vULZHHk10+3nEfqHQTOJ+PB/cCgzhkx
	 ErIVcI9RwQ4bN82d9sGs55Tih7MSwjI6QJHOPh5Kgb1u14+0N5o7yRUfmE88G14MzK
	 GJ3Kq1ENDdsTg==
Date: Sun, 17 May 2026 19:35:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v4 4/7] pwm: tegra: Parametrize enable register offset
Message-ID: <agn7SP3ETY4XCX4h@monoceros>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
 <20260331-t264-pwm-v4-4-c041659677cf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fopyhq2p3v2ldjwm"
Content-Disposition: inline
In-Reply-To: <20260331-t264-pwm-v4-4-c041659677cf@nvidia.com>
X-Rspamd-Queue-Id: D6969562AA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8939-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--fopyhq2p3v2ldjwm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 4/7] pwm: tegra: Parametrize enable register offset
MIME-Version: 1.0

Hello,

On Tue, Mar 31, 2026 at 11:12:16AM +0900, Mikko Perttunen wrote:
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
> index 358c81cea05b..b925ef914411 100644
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
> =20
>  	pwm_writel(pwm, PWM_CSR_0, val);
> =20

The patch is a bit artificial because we don't have a driver yet where
`pc->soc->enable_reg =3D=3D PWM_CSR_0` doesn't hold. But it looks strange to
me that there is no enable bit set for the pc->soc->enable_reg !=3D
PWM_CSR_0 case. So I tend to want these changes in squashed into another
patch such that the combined patch handles the enabling completely.

> @@ -213,6 +215,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> =20
>  static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pw=
m)
>  {
> +	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
>  	int rc =3D 0;
>  	u32 val;
> =20
> @@ -220,20 +223,22 @@ static int tegra_pwm_enable(struct pwm_chip *chip, =
struct pwm_device *pwm)
>  	if (rc)
>  		return rc;
> =20
> -	val =3D pwm_readl(pwm, PWM_CSR_0);
> +

A single empty line is enough.

> +	val =3D pwm_readl(pwm, pc->soc->enable_reg);
>  	val |=3D PWM_ENABLE;
> -	pwm_writel(pwm, PWM_CSR_0, val);
> +	pwm_writel(pwm, pc->soc->enable_reg, val);
> =20
>  	return 0;
>  }
> =20
>  static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *=
pwm)
>  {
> +	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
>  	u32 val;
> =20
> -	val =3D pwm_readl(pwm, PWM_CSR_0);
> +	val =3D pwm_readl(pwm, pc->soc->enable_reg);
>  	val &=3D ~PWM_ENABLE;
> -	pwm_writel(pwm, PWM_CSR_0, val);
> +	pwm_writel(pwm, pc->soc->enable_reg, val);
> =20
>  	pm_runtime_put_sync(pwmchip_parent(chip));
>  }
> @@ -398,10 +403,12 @@ static int __maybe_unused tegra_pwm_runtime_resume(=
struct device *dev)
> =20
>  static const struct tegra_pwm_soc tegra20_pwm_soc =3D {
>  	.num_channels =3D 4,
> +	.enable_reg =3D PWM_CSR_0,
>  };
> =20
>  static const struct tegra_pwm_soc tegra186_pwm_soc =3D {
>  	.num_channels =3D 1,
> +	.enable_reg =3D PWM_CSR_0,
>  };
> =20
>  static const struct of_device_id tegra_pwm_of_match[] =3D {
>=20
> --=20
> 2.53.0
>=20

--fopyhq2p3v2ldjwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoJ/GQACgkQj4D7WH0S
/k7AXAf9H6sDXDLbM7hNb9vHT/+s485HnqhOSAaKKX1VVNSmPUj6Ztoc1CRBm5J5
VZd81QDJODnImcgs/Vvp65fFaEYlGUmRJnOToOsRnKLC2Qwet7AzRaFFjEjm76RT
n4hJHObg8jgV8l16NPLh+3e/UjAmCfdBqcND32OvZlSexQL0Wh9XvesTHFLu8ad0
SfsG5YwBFa06DY3mI6LnzPhamiumyl2X2zRr5gBYdeZwZlJcMtQJs8+BjmGpDZNX
BYy3T96DblJc/2O20K2+7EftoTRino+pqyJ0mSccct3WwvI9bDZAi+84FGh+xAyM
YgXMceNQ8/TOBVejTDfLbzVcJt/eUQ==
=NMnW
-----END PGP SIGNATURE-----

--fopyhq2p3v2ldjwm--

