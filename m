Return-Path: <linux-pwm+bounces-8938-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOFLBY/7CWpPvwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8938-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 19:31:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580A56294C
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 19:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF9383021EBE
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47123BB68E;
	Sun, 17 May 2026 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGrBiWUv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F91F875A;
	Sun, 17 May 2026 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039045; cv=none; b=l1K9iOxWWNc/dwqCLTLNrZL8yMhc4UiPLhI9tpJao5wXuiKc0oiP1LXM1s36RxfZW7Fp+2h9Ab9qPwSPP72GBsgsBzNBvinLfR2nwjBxiKVxqeaoPfRrD1IEH7Bby6zxu88bbDa6fFu7kvJfH0TK821gJRtbTVS6mHjkKsltOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039045; c=relaxed/simple;
	bh=ZGmTAZXo2EykK8olmkKQqWZWO8exMidmh+IyRcRpvgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMpGds/kKh/yJa6uVhp7Av0DIHGho0dqgA6TtqlU8D9Vx4xMwk6YoK6xNEqXfQqXmtqrF9DkusXPufxqx9Lke+PfNTi9Gk5g1TUMjruJ8c8w2lEBWUrZHwC5/oU3B1C+4U2OYavh4VNhy218xvoHeUnifJFQSuGMirTtWg+Gq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGrBiWUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C230AC2BCB0;
	Sun, 17 May 2026 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039045;
	bh=ZGmTAZXo2EykK8olmkKQqWZWO8exMidmh+IyRcRpvgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGrBiWUvNA7PbkTVubV6qaffErs7g4Zv8oa09vpC0NZTvRwNWhhJXfUBuKypZUlwL
	 IY05DNgKxEEslH+o3oVS2mK+Vb7rlAU1G2HGARInik0BRtcLVlSoekLGUjzYMHVGVu
	 UBl18S6QuLuKFXO7htsj8WYKQn+QCeZAfAV27ODVxRl/Kh/sgM2hRvFyFalxYB08JS
	 FjC2M/DsPFvkolsQetJLvvZDKkEqlFNzgx8RxTnPENElmNc70PWmSmu74Sd3aSQArq
	 4qCtJYHipj2u1jil2otWhxx5BYHK8fGd2Wt0A4gEEns+48MiI7i5hO17SyZBEMZ1c0
	 F7+ROoKEeYSMA==
Date: Sun, 17 May 2026 19:30:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v4 3/7] pwm: tegra: Modify read/write accessors for
 multi-register channel
Message-ID: <agn6i8SmO-jwYNhM@monoceros>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
 <20260331-t264-pwm-v4-3-c041659677cf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6zhznxh2tney57sm"
Content-Disposition: inline
In-Reply-To: <20260331-t264-pwm-v4-3-c041659677cf@nvidia.com>
X-Rspamd-Queue-Id: 8580A56294C
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
	TAGGED_FROM(0.00)[bounces-8938-lists,linux-pwm=lfdr.de];
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


--6zhznxh2tney57sm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/7] pwm: tegra: Modify read/write accessors for
 multi-register channel
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 11:12:15AM +0900, Mikko Perttunen wrote:
> On Tegra264, each PWM instance has two registers (per channel, of which
> there is one). Update the pwm_readl/pwm_writel helper functions to
> take channel (as struct pwm_device *) and offset separately.
>=20
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 8a330169d531..358c81cea05b 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -57,6 +57,8 @@
>  #define PWM_SCALE_WIDTH	13
>  #define PWM_SCALE_SHIFT	0
> =20
> +#define PWM_CSR_0	0

Is this a register offset (of the for now single per channel register)?

One thing that bothers me about this driver is that the defines are not
prefixed by the driver name. `PWM_SCALE_WIDTH` looks more generic than
it is.

> +
>  struct tegra_pwm_soc {
>  	unsigned int num_channels;
>  };
> @@ -78,14 +80,18 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_chi=
p(struct pwm_chip *chip)
>  	return pwmchip_get_drvdata(chip);
>  }
> =20
> -static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int offs=
et)
> +static inline u32 pwm_readl(struct pwm_device *dev, unsigned int offset)

s/dev/pwm/ to match the variable naming in the rest of the driver.

>  {
> -	return readl(pc->regs + (offset << 4));
> +	struct tegra_pwm_chip *chip =3D to_tegra_pwm_chip(dev->chip);
> +
> +	return readl(chip->regs + (dev->hwpwm * 16) + offset);

Best regards
Uwe

--6zhznxh2tney57sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoJ+z8ACgkQj4D7WH0S
/k77tggAmkvd/8aznlVF/z98D/zvMfKw/AW4srXVX0eqQymipnDwfc37p1/VI17x
Pd7/ZwhQFfZ+P1VfzogJ8EA6/pxNOksSBR9qMQZnZOz6oTAiL2hmK28wKbQwfmi9
XeGBDq+9skJAELd56MnedN2LU7RloZsb1NTf+lxvZ0m9XrDxFFzkGvIIV9HarOBi
VMfSdTBNiiDdmEp+OS7mNsf8k5cGzi29UTRFYFRw5jiMMyuEan8Zo0K5nxdi0WmD
fxyos5DipLOG/V7V7+EzgwSiThb6IzY60PNEPkgza4z7a1IR1h/GkTg8dARhG4Zu
pWHKhD+KS9RbficpWoD2VwuyTUYtEA==
=jdKS
-----END PGP SIGNATURE-----

--6zhznxh2tney57sm--

