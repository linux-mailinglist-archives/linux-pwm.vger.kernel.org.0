Return-Path: <linux-pwm+bounces-7801-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF082CBD7E9
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Dec 2025 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A8D53012ECE
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Dec 2025 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0D530DD01;
	Mon, 15 Dec 2025 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeEDjTNt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529525485A;
	Mon, 15 Dec 2025 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798199; cv=none; b=AVCR4VzP6viO0W2tbJIpNh4Iib0WNXcvk0N316qjrZ4pZ2dG3Sr3geQ2RgY3sci2xCCXZUcRAqfcxxWzS0/efcX1r9POkLj39eFLM/n3QeuXXSsKa4ezw9Z+gmr8LLC4OUawL1/qbJKdXtWUvnC4gFrreptoq4uQ8SstDKZgxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798199; c=relaxed/simple;
	bh=pZvRKNQnveDpt4V3OuxBYvkE88PpxoFZHMOMx6hAFFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfOcqjXmGb6oxg9RDDk2bLOKNqsJ9vf07ZYlvgTtaOsfpERlhRc1USzr7rC5/H0cntqTWZ/iNfFT6EFsM8oHiSPTg2Et2kpMZ8P02OPErYwETKuP0Mq3LMPFl/iDVMd1AB/PUMb9Cfe4/CVmFFQODA7MFxXarBXpEr3JN2dT28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeEDjTNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B16C4CEF5;
	Mon, 15 Dec 2025 11:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765798199;
	bh=pZvRKNQnveDpt4V3OuxBYvkE88PpxoFZHMOMx6hAFFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeEDjTNtlu9KzfO/VGbdPOVYs0Jkgs3j99bFjHVOla3Fki2xoaIRpy7WR7dVgo2Xb
	 60ocg1esw6KniRVqwo7YqlpILGpw87am44mYenCzPASr2NF6hZsPzSG2eT06R3HyFH
	 5vf9ZIMTxnJTXPsUm4xdVlMEoD5KI4VZ3wgFWGB5tsKkn++ILWshafpKbo6krVnclE
	 wXnRTptk8iWmLfkLhonDXCT/mCs8aL7PavHSSsdy60wHAj0+EBby74pMs2SeeZyhKp
	 yf02De/IVtYEN+h+H0HQontkvZSaMu/YTrUzgNaKgFLkhMq0j8u8kghe41YTgsscXh
	 s82OBDHbYEh0g==
Date: Mon, 15 Dec 2025 12:29:56 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: 20190311120055 created <payne.lin@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, 
	jh.hsu@mediatek.com
Subject: Re: [PATCH] pwm: mediatek: Add error handling for zero rate in PWM
 state
Message-ID: <s5ieu7cciqgw3x5rnpcn43fm3nkinm4guz33nhwwi45apdz2ot@4zsbi7tckuwz>
References: <20251215104037.3100485-1-payne.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d547b5x5tvmpvovf"
Content-Disposition: inline
In-Reply-To: <20251215104037.3100485-1-payne.lin@mediatek.com>


--d547b5x5tvmpvovf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: mediatek: Add error handling for zero rate in PWM
 state
MIME-Version: 1.0

Hello,

the From: line of your patch is strange.

On Mon, Dec 15, 2025 at 06:40:32PM +0800, 20190311120055 created wrote:
> From: Payne Lin <payne.lin@mediatek.com>
>=20
> Added a check to handle cases where the rate is zero in the
> mtk_disp_pwm_get_state function. This prevents division by zero errors
> when calculating the period.
> - Added error message for zero rate scenario
>=20
> Signed-off-by: Payne Lin <payne.lin@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index bafd6b6195f6..dd0ae041af70 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -176,19 +176,18 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *=
chip,
>  	struct mtk_disp_pwm *mdp =3D to_mtk_disp_pwm(chip);
>  	u64 rate, period, high_width;
>  	u32 clk_div, pwm_en, con0, con1;
> -	int err;
> +	int ret;

If you keep the variable name, the patch gets quite a bit more obivious.

> -	err =3D clk_prepare_enable(mdp->clk_main);
> -	if (err < 0) {
> -		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_main: %pe\n", ERR=
_PTR(err));
> -		return err;
> +	ret =3D clk_prepare_enable(mdp->clk_main);
> +	if (ret < 0) {
> +		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_main: %pe\n", ERR=
_PTR(ret));
> +		goto err_handle;
>  	}

Fixing error handling should go into a separate patch please.

> -	err =3D clk_prepare_enable(mdp->clk_mm);
> -	if (err < 0) {
> -		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_mm: %pe\n", ERR_P=
TR(err));
> -		clk_disable_unprepare(mdp->clk_main);
> -		return err;
> +	ret =3D clk_prepare_enable(mdp->clk_mm);
> +	if (ret < 0) {
> +		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_mm: %pe\n", ERR_P=
TR(ret));
> +		goto err_disable_clk_main;
>  	}
> =20
>  	/*
> @@ -212,15 +211,23 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *=
chip,
>  	 * period has 12 bits, clk_div 11 and NSEC_PER_SEC has 30,
>  	 * so period * (clk_div + 1) * NSEC_PER_SEC doesn't overflow.
>  	 */
That comment belongs to the assignment to state->period. Don't separate
them with your addition.

> +	if (rate =3D=3D 0) {
> +		dev_err(pwmchip_parent(chip), "rate is zero, cannot calculate period\n=
");

All the other messages (at least those in the context above) start with
a capital letter.

> +		ret =3D -EINVAL;
> +		goto err_disable_clk_mm;
> +	}
>  	state->period =3D DIV64_U64_ROUND_UP(period * (clk_div + 1) * NSEC_PER_=
SEC, rate);
>  	high_width =3D FIELD_GET(PWM_HIGH_WIDTH_MASK, con1);
>  	state->duty_cycle =3D DIV64_U64_ROUND_UP(high_width * (clk_div + 1) * N=
SEC_PER_SEC,
>  					       rate);
>  	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +err_disable_clk_mm:
>  	clk_disable_unprepare(mdp->clk_mm);
> +err_disable_clk_main:
>  	clk_disable_unprepare(mdp->clk_main);
> -
> -	return 0;
> +err_handle:
> +	return ret;
>  }

Best regards
Uwe

--d547b5x5tvmpvovf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmk/8TEACgkQj4D7WH0S
/k4RfAgAtDQpygYx//qBH7qfXb2Sege4VLwIXT72UTne+KCDGEH6C50zawka5dG2
s6HT6h93xT9u8srTNskLw/w54rA0Sig2FhZHHE6hdxefIEUsRFAEZg1RR2opnIU5
vzVpPb1kKdwYOn6ropXs+j5mDAY6VYsD5bGc2R54VoNek8saJdzOMfKzICTmmAYr
3SMyBPyNIS/rUnaP8qkIKcd7i3/a0moKPqx8fhSJOL3sfE2uZkOQyDoSNlJQmqCK
V7LrmVVCUqbhfk+fahjoLebPfwXVIiUPzqoPv+QKLo1TFirzq/9xNE20Vc4xhoax
NCv4Gi+rGy3z3BFccks2wuQpIut1ww==
=XB1O
-----END PGP SIGNATURE-----

--d547b5x5tvmpvovf--

