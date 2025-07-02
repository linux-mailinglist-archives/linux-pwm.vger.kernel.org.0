Return-Path: <linux-pwm+bounces-6683-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF8AF0AF7
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 07:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD5548001F
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 05:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D81F8733;
	Wed,  2 Jul 2025 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM7AuOf1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB81F5820;
	Wed,  2 Jul 2025 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751435468; cv=none; b=dx8vDeU9lPe0mfxJ5La3OqmwCB1TFocCZ9HLnefCb6mwfL9BPDYBZkPYXSc3UK9se3SjiNFqkRVejhB4GtBVwmfmcKiXqJoyVK3375YuTeZcvHlLrHH+zifIwRzK/6MfKgkM1WfUUH2R0sNi1JRy9f2j+LpDXFEDOujRQjbRH80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751435468; c=relaxed/simple;
	bh=ZGAD34V2+/nppac1OT0z+GzgTDgySO7EWRziPrZ69y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F22VQ3ic1UXY0J+tYPPVcRQuZoOH3C6PU/+VJ6YbWk5ki9r2YH9jZnxFvRo8S810VsPIoXXAVYlrXTwZS3FMGtBRYq3+AEQ0WEY23f0a5DZieme7piPWft5/MFv2BC+tUogEGAxJEYNtQYjMNuv9NRgbM8tedV9UonnwLjXnmIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM7AuOf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FEDC4CEEE;
	Wed,  2 Jul 2025 05:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751435468;
	bh=ZGAD34V2+/nppac1OT0z+GzgTDgySO7EWRziPrZ69y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dM7AuOf1hTRbGtNWbCOJAPZl67ADKPrFWgVugY011aGKwfSiAFwq8dvNEL97Vyp8s
	 xTn+6uU1tZs/T9/eBkUPoRD83JOAQJW+1edZsd0pgtPKbFueoai22a8Q9SvxlHEGQ9
	 cf9bByoDeJfGh7mnG6Pu8iwRz8vNlhNYfD88/4m5wB2nrNknIU0f2GOJwR+dikebwt
	 GdT8eDtYQD7HuuQJ6p/gKttY1xjyG16qEF21A6n57p5ml5eGd0vYoBQtVV4OPQcrvL
	 BXvELVmxzhwkmcQBQnnHDxduPaixhatWSVmZXsgjon9WI/4bSBfdZXDDDpd8n/6g5m
	 iXDiaIw0yKAcA==
Date: Wed, 2 Jul 2025 07:51:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Subject: Re: [PATCH] pwm: imx-tpm: reset counter if CMOD is 0
Message-ID: <vwozlwajisjw5qomwtmnfdklmucevyxncsxl2cdmixn2yixxrk@x6j3r2lrl5qz>
References: <20250701220147.1007786-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3g6nf2e7dhscobr3"
Content-Disposition: inline
In-Reply-To: <20250701220147.1007786-1-laurentiumihalcea111@gmail.com>


--3g6nf2e7dhscobr3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: imx-tpm: reset counter if CMOD is 0
MIME-Version: 1.0

Hello,

On Tue, Jul 01, 2025 at 06:01:47PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>=20
> As per the i.MX93 TRM, section 67.3.2.1 "MOD register update", the value
> of the TPM counter does NOT get updated when writing MOD.MOD unless
> SC.CMOD !=3D 0. Therefore, with the current code, assuming the following
> sequence:
>=20
> 	1) pwm_disable()
> 	2) pwm_apply_might_sleep() /* period is changed here */
> 	3) pwm_enable()
>=20
> and assuming only one channel is active, if CNT.COUNT is higher than the
> MOD.MOD value written during the pwm_apply_might_sleep() call then, when
> re-enabling the PWM during pwm_enable(), the counter will end up resetting
> after UINT32_MAX - CNT.COUNT + MOD.MOD cycles instead of MOD.MOD cycles as
> normally expected.
>=20
> Fix this problem by forcing a reset of the TPM counter before MOD.MOD is
> written.
>=20
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index 7ee7b65b9b90..30f271826aed 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -204,6 +204,19 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chi=
p,
>  		val |=3D FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
>  		writel(val, tpm->base + PWM_IMX_TPM_SC);
> =20
> +		/*
> +		 * VERY IMPORTANT: if CMOD is set to 0 then writing

The "VERY IMPORTANT" is correct today as this is missing and so
disturbing operation. However once this patch is applied, it's only
normal to have it. So I suggest to drop this.

> +		 * MOD will NOT reset the value of the TPM counter.
> +		 *
> +		 * Therefore, if CNT.COUNT > MOD.MOD, the counter will reset
> +		 * after UINT32_MAX - CNT.COUNT + MOD.MOD cycles, which is
> +		 * incorrect.
> +		 *
> +		 * To avoid this, we need to force a reset of the
> +		 * counter before writing the new MOD value.
> +		 */

Without the reference manual at hand or a deeper understanding of the
hardware this isn't understandable. What is MOD? What is CMOD?

> +		if (!cmod)
> +			writel(0x0, tpm->base + PWM_IMX_TPM_CNT);
>  		/*
>  		 * set period count:
>  		 * if the PWM is disabled (CMOD[1:0] =3D 2b00), then MOD register

Best regards
Uwe

--3g6nf2e7dhscobr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhkyMYACgkQj4D7WH0S
/k4iHQf8D+bL01vDv300bdPlR2TetB6qvOXjNcXttTNMBqfVUKF0sjh6CPnD9AF4
+UYCBnykBN7RCMFHgKjVj9GhRXC+uZOVJ9dzCGRIA3IthpOQ9bDk+JHQKbSZvZ2S
Ojsa8DXIHC9DILnx3a9+iDTKAYo9mujgg7nm9iJhkqqsUZMNTmzdB+vi1lVBr6Lp
4B01fzHsEGfcnIJI5x+YrYwMVlibGMBTQQe8I4qyf/L0EQjg+7wCwyyfTd9l3Mzv
4DZd0T4ZkQYO/BGUzJjLJhwyfEydNLIIlSFIC0NujZ77I8pytN2Kg224UgvcsagK
+L9FL0eZBLvFJSsg2tf2IML/rNum5w==
=cNud
-----END PGP SIGNATURE-----

--3g6nf2e7dhscobr3--

