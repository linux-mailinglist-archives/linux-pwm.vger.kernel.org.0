Return-Path: <linux-pwm+bounces-8350-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB2ALtjBwmmjlQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8350-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 17:54:48 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E8E319751
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B334930AAE05
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331883FEB0C;
	Tue, 24 Mar 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p++8XnaG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED03F167B;
	Tue, 24 Mar 2026 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370717; cv=none; b=hHNug4Z1b7dhsjRcFN7Xjr/zvwIIEvLou1uS+qubRRck4zd/cD7slZ+d57WaNDFFcvwc2yzP67wBkX2hYEyQcbBTAzNrQ/M+hxD2Ye+X3/NPdcaj0OL/vJkOIirFbR98Eu62DhA8iyB5ld3RnDbk38J0Mv93rvG53mcRdG89T6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370717; c=relaxed/simple;
	bh=tG7aslgt9cGc5lmFDeFMvGXeMSYZCh4bPKKGQN363t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilxvwxUaBNY01rpwOVgZ+IdqIgQUkpJy5X5PyHipNtREnK1XPypUX55vtsPv/h8gZIYko2LCA3CCA84YFBBFM1UQjC44gRTbVuyFJQKl3mMxL5Nj9w9mStJoRooLmrypRULGHCWr5inVs8a/FN/KJpC/vpw3ngJAdzoajzp9/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p++8XnaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C369C19424;
	Tue, 24 Mar 2026 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774370716;
	bh=tG7aslgt9cGc5lmFDeFMvGXeMSYZCh4bPKKGQN363t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p++8XnaGnoEifxx15/oT9ChvRNmTdyX4krenzcstjDb0xZ7JKhkF8iPGf7tcaiWnf
	 ULwXf938y1siFq7L/sH3c33CxW3Jj7SvDYGLiyrvxyQx7/GZ+puN/xlt9ajABx4Ced
	 Ocq3iIoWxW/8bX8Buw0wdOdkr33towrPqR75//nbOlMV4wCENGWSU8JxK5RwgB2+AQ
	 HDvbEC4qhU6rSvQj6Uq3nK1dHOWT0ZfXe76rD2ndsc0VNsa8iF6AxRzWitYclV4EOo
	 WIhY3DuzJwL7Qh2zmixm/9EyML98T8W+SDv/v4HQEFwvP25UiO2rVGP/FuXfm8inJa
	 6ePvYT6OunuDA==
Date: Tue, 24 Mar 2026 17:45:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH 1/5] pwm: tegra: Avoid hard-coded max clock frequency
Message-ID: <acKggw9F7oULLEuJ@monoceros>
References: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
 <20260323-t264-pwm-v1-1-4c4ff743050f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="coyellmeekg53qof"
Content-Disposition: inline
In-Reply-To: <20260323-t264-pwm-v1-1-4c4ff743050f@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8350-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 59E8E319751
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--coyellmeekg53qof
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] pwm: tegra: Avoid hard-coded max clock frequency
MIME-Version: 1.0

On Mon, Mar 23, 2026 at 11:36:37AM +0900, Mikko Perttunen wrote:
> From: Yi-Wei Wang <yiweiw@nvidia.com>
>=20
> The clock driving the Tegra PWM IP can be sourced from different parent
> clocks. Hence, let dev_pm_opp_set_rate() set the max clock rate based
> upon the current parent clock that can be specified via device-tree.
>=20
> After this, the Tegra194 SoC data becomes redundant, so get rid of it.
>=20
> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Co-developed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 172063b51d44..759b98b97b6e 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -59,9 +59,6 @@
> =20
>  struct tegra_pwm_soc {
>  	unsigned int num_channels;
> -
> -	/* Maximum IP frequency for given SoCs */
> -	unsigned long max_frequency;
>  };
> =20
>  struct tegra_pwm_chip {
> @@ -303,7 +300,7 @@ static int tegra_pwm_probe(struct platform_device *pd=
ev)
>  		return ret;
> =20
>  	/* Set maximum frequency of the IP */
> -	ret =3D dev_pm_opp_set_rate(&pdev->dev, pc->soc->max_frequency);
> +	ret =3D dev_pm_opp_set_rate(&pdev->dev, S64_MAX);

The documentation comment for dev_pm_opp_set_rate() reads:

	Device wanting to run at fmax provided by the opp, should have
	already rounded to the target OPP's frequency.

I think using S64_MAX is technically fine (assuming there are no issues
with big numbers in that function), but still it feels wrong to use
something simpler than the comment suggests. Am I missing something?

>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
>  		goto put_pm;
> @@ -318,7 +315,7 @@ static int tegra_pwm_probe(struct platform_device *pd=
ev)
> =20
>  	/* Set minimum limit of PWM period for the IP */
>  	pc->min_period_ns =3D
> -	    (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
> +	    (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;

Orthogonal to this patch: Should this be

	DIV_ROUND_UP(NSEC_PER_SEC, pc->clk_rate >> PWM_DUTY_WIDTH)

? Or even

	DIV_ROUND_UP(NSEC_PER_SEC < PWM_DUTY_WIDTH, pc->clk_rate);

? (Note, the latter doesn't work as is, as the first parameter has an
overflow, I guess you're still getting my question.)

Best regards
Uwe

--coyellmeekg53qof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnCv5cACgkQj4D7WH0S
/k7LLAf9F2ne3GVadd656P5wRSEOEUiI+LwNzKjUkg8iD/61C3/5Az89hykzcvVT
O45j+BIXeIYusAfaMe1fre0uk74wCVkiPTBFb/DnL6uVNJcbWIbLM7Plr1HigxGC
9Qx/7ITlsNQPiJIgPgID3VOLnX5sTYwuf8hEaFbIC9ia1HPT9Vg2img0aRZUF9YC
dl8QOaEiAToRlnf+Ni00c/5BcAbiTE4sikR24Efn6GMK3qc3yoGVoJfU0DSVbx/J
pausJRnArmBRKOTs5oVPalXSjKAe6slEqG3kIl6M/jDfOtYC5t+TGti8/U+cXxPN
NcNEuMmUiJuZ/SzM0eBmTsZxCS0mmg==
=DIAG
-----END PGP SIGNATURE-----

--coyellmeekg53qof--

