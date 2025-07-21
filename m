Return-Path: <linux-pwm+bounces-6856-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C65B0C21E
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jul 2025 13:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D671891AB2
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jul 2025 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CCC28FFDE;
	Mon, 21 Jul 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9dOftA3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A51D540;
	Mon, 21 Jul 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095843; cv=none; b=ZTTN3vH3yQJ5RsgjSsY6F8bpm+7+AMwq5Famaw1xsnfsNOUgwmlwfq6qXXJWFx/UOmR70Bnx12RHTidLi3d/so0YK69JPk750ds29ZWUd0N8OMdX3u80jQ1h/E76x+LUMNEECh46R5DViDFAOYItUg0G+GPBBve6+28w/BwLtf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095843; c=relaxed/simple;
	bh=EcW+PuwhhXhVoa+pRSceK3tuWnx91zSNXUwkaiOBF8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTlDnozOK60vQl81gwY0zuu6tO0AwY6Gwohvks4aodJ82CeMwC7XIqaoWaSA3MLIrucZPMLqjhcMW8wyRh1R4kYHXP+dFAJVw1U5kj/x1VEsBfNJDlL5iedleRmv5mb/aZGALqosub7cC4PYRM0B1xekvBpiVwPPhduiVUbdalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9dOftA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1423EC4CEED;
	Mon, 21 Jul 2025 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753095842;
	bh=EcW+PuwhhXhVoa+pRSceK3tuWnx91zSNXUwkaiOBF8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9dOftA3ryJYz+Ay2nJJO8r8Hjj/RBFk0OgmQdtlf1ef3l6DokAE5VHSbTQQBdGeX
	 Qs420DHiuJsJdHGxj2+MO60aUY+0fPelpG7Zs6f4LQHL/+GScWKMwlUZNa6ARyTbTn
	 0l7Lac6JhTYbLZDtPLQ05t/ebureu9JR/BoCoG39DPhfOiFsmDFIGNAswmIRQ1H22R
	 nw397Iu/AyML2rPT6zYqAA1lc6HIqW3xlP7RXKuAMNms2X7fGJWJ6zdBx0opk0qbRr
	 WObsBeaqSg0ThVBTem2M+P4/ZK7jaRP/oG6qtjYG2wq6q4Rrgz6ook2haBB4v3DwKY
	 AvAGuqkAACxoA==
Date: Mon, 21 Jul 2025 13:03:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: imx-tpm: reset counter if CMOD is 0
Message-ID: <7wsbi7pcwa2otxqkon3zfat7faprhr3l7wc35fkzctmm3cv67m@ph6w7hzwt322>
References: <20250714123634.6442-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="umamwlivydbce7bu"
Content-Disposition: inline
In-Reply-To: <20250714123634.6442-1-laurentiumihalcea111@gmail.com>


--umamwlivydbce7bu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: imx-tpm: reset counter if CMOD is 0
MIME-Version: 1.0

Hello Laurentiu,

On Mon, Jul 14, 2025 at 08:36:34AM -0400, Laurentiu Mihalcea wrote:
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

This needs backporting to stable, right? So we need a reference to the
commit that introduced the problem. I guess that's 738a1cfec2ed ("pwm:
Add i.MX TPM PWM driver support")? (Please add a matching Fixes: line in
your v3.)

> ---
> Changes in v2:
>   - dropped the "VERY IMPORTANT" bit as per Uwe's suggestion.
>   - Link to v1: https://lore.kernel.org/lkml/20250701220147.1007786-1-lau=
rentiumihalcea111@gmail.com/
>=20
>  drivers/pwm/pwm-imx-tpm.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index 7ee7b65b9b90..b15c22796ba9 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -204,6 +204,19 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chi=
p,
>  		val |=3D FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
>  		writel(val, tpm->base + PWM_IMX_TPM_SC);
> =20
> +		/*
> +		 * if CMOD is set to 0 then writing MOD will NOT reset the
> +		 * value of the TPM counter.
> +		 *
> +		 * Therefore, if CNT.COUNT > MOD.MOD, the counter will reset
> +		 * after UINT32_MAX - CNT.COUNT + MOD.MOD cycles, which is
> +		 * incorrect.
> +		 *
> +		 * To avoid this, we need to force a reset of the
> +		 * counter before writing the new MOD value.
> +		 */

I asked in reply to v1 about these register semantics. The idea was not
that you explain them by mail, but improve the comment accordingly that
someone reading the driver doesn't need to consult the reference manual
to understand it.

So maybe something like:

	/*
	 * If the counter is disabled (CMOD =3D=3D 0), programming the new
	 * period length (MOD) doesn't reset the counter (CNT). If
	 * CNT.COUNT happens to be bigger than the new MOD value it will
	 * reset way to late. So reset it manually to zero.
	 */

?

> +		if (!cmod)
> +			writel(0x0, tpm->base + PWM_IMX_TPM_CNT);
>  		/*
>  		 * set period count:
>  		 * if the PWM is disabled (CMOD[1:0] =3D 2b00), then MOD register

Best regards
Uwe

--umamwlivydbce7bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmh+HpwACgkQj4D7WH0S
/k4BGwf+P6kPo7r1ntY/Esoxxhlamfit/RB+dpcIWq3XtsaG5FJjB9BtFHeBQUs3
MgzKcSUT04Ka4PRhM0pFJnJtOTZ2YA5l8tsjM1CHLQXHuYW9x335vbkzjnn3PcBj
thDW2pGSiSioUrY9HHo+JwHeqPSRQaZMNvBroQvxsJyVZd8Cd1lmA1S6+hTDsM6l
ZRqetIHUwQFlFZtAu4DF+J5ApamyNkwmrKFskNX32yKkhcJjYbhgx0H4Ei4ZdbQy
VRdBztPhA+4N+7v3rmUVmnj9NRzjd5yuoMPDdNjVEmuuI2n4q3iPYPK2Xkx1xqQa
U9Lw9/bDBBnrfC4N79YWPy4WQ+3HCw==
=yx+y
-----END PGP SIGNATURE-----

--umamwlivydbce7bu--

