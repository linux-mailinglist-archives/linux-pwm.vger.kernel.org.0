Return-Path: <linux-pwm+bounces-8937-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKy8HA73CWrgvgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8937-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 19:12:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CED5626B6
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 19:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9CDB3002896
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543C3C278B;
	Sun, 17 May 2026 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUrmpOI5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A053BFE31;
	Sun, 17 May 2026 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037962; cv=none; b=g/53H+8bLMb6FTTLVw3RG9l4NlmstGPLadSThZMynxMcrexNxaWZUlmpaf+U8mCE38IU0hNm6Vu/MwgvB8kIPLev6QVXLXi7XfxFEhnDWva7CUl0Rl5jv2wPO9pYcIXJyvMqGS9go2VAWEo9Ac5H9Zp+vS9s64x9Hyv18irU8ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037962; c=relaxed/simple;
	bh=rZTvaM2qqzZ0+ZHapysXVlkiReT0C0YfxuSAed7oo4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kymCKIz3KK1wLs3cGiDtnObkZelEzlDq4/5e1uWA2oHX44kwS/6at20+geTN9z+CqeISDAXTua3sbT+olos04g7pTYVz4WJMFTrak1UefWYVzds340UKxZVT6/d6meRGNla3Yocy4naJIAjGvWoFYRnbI/mGwF1unc+A8Xp19vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUrmpOI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0632C2BCB8;
	Sun, 17 May 2026 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779037962;
	bh=rZTvaM2qqzZ0+ZHapysXVlkiReT0C0YfxuSAed7oo4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUrmpOI5z3LGWD8/mdNkUlYbcEA4ysfIOvjNwFRxSxquanwD9ZR3iTnB+zT95QL4s
	 BmgZ3CpZXgSsU25OUFfr+ynh/HdoGAP6IPd2DjvkMbRwg0jthmTYzrzjIbZk1paajv
	 U7tO/7oaP4A5gHOcBuSm+xDyKJHnJpvgpb3KP41K0n9NhdnMiGcfdqvyUqVK2B08ZY
	 lrpWt9CBYbSMa16NE3SOPUm3Q3zFNuwKaKAzflJMaP7qMamAdeFVNa1GV8b8ictQD+
	 YqCjNxbWwokvEf0AaTrKrRm23D86U0T8KhMuk5dD8Qx7BZNO7SReEPlyoX35YncqkF
	 mPGdwlJrpqUUA==
Date: Sun, 17 May 2026 19:12:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 2/2] pwm: meson: Add support for Amlogic S7
Message-ID: <agn2Yp3mzI7DcsyN@monoceros>
References: <20260402-s6-s7-pwm-v2-0-657dce040956@amlogic.com>
 <20260402-s6-s7-pwm-v2-2-657dce040956@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eenroa65e3lftv6j"
Content-Disposition: inline
In-Reply-To: <20260402-s6-s7-pwm-v2-2-657dce040956@amlogic.com>
X-Rspamd-Queue-Id: E5CED5626B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8937-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,googlemail.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amlogic.com:email]
X-Rspamd-Action: no action


--eenroa65e3lftv6j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] pwm: meson: Add support for Amlogic S7
MIME-Version: 1.0

Hello,

On Thu, Apr 02, 2026 at 02:40:16AM +0000, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> Add support for Amlogic S7 PWM. Amlogic S7 different from the
> previous SoCs, a controller includes one pwm, at the same time,
> the controller has only one input clock source.
>=20
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/pwm/pwm-meson.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 8c6bf3d49753..7a43c42ef3d6 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -113,6 +113,7 @@ struct meson_pwm_data {
>  	int (*channels_init)(struct pwm_chip *chip);
>  	bool has_constant;
>  	bool has_polarity;
> +	bool single_pwm;

Conceptually I'd prefer a `npwm` field here. That doesn't take more
space in memory and simplifies the logic a bit. (At the cost of having
to adapt all already existing meson_pwm_data instances, but that's fine
in my book.)

>  };
> =20
>  struct meson_pwm {
> @@ -503,6 +504,18 @@ static void meson_pwm_s4_put_clk(void *data)
>  	clk_put(clk);
>  }
> =20
> +static int meson_pwm_init_channels_s7(struct pwm_chip *chip)
> +{
> +	struct device *dev =3D pwmchip_parent(chip);
> +	struct meson_pwm *meson =3D to_meson_pwm(chip);
> +
> +	meson->channels[0].clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(meson->channels[0].clk))
> +		return dev_err_probe(dev, PTR_ERR(meson->channels[0].clk),
> +				     "Failed to get clk\n");
> +	return 0;
> +}
> +
>  static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
>  {
>  	struct device *dev =3D pwmchip_parent(chip);
> @@ -592,6 +605,13 @@ static const struct meson_pwm_data pwm_s4_data =3D {
>  	.has_polarity =3D true,
>  };
> =20
> +static const struct meson_pwm_data pwm_s7_data =3D {
> +	.channels_init =3D meson_pwm_init_channels_s7,
> +	.has_constant =3D true,
> +	.has_polarity =3D true,
> +	.single_pwm =3D true,
> +};
> +
>  static const struct of_device_id meson_pwm_matches[] =3D {
>  	{
>  		.compatible =3D "amlogic,meson8-pwm-v2",
> @@ -642,6 +662,10 @@ static const struct of_device_id meson_pwm_matches[]=
 =3D {
>  		.compatible =3D "amlogic,meson-s4-pwm",
>  		.data =3D &pwm_s4_data
>  	},
> +	{
> +		.compatible =3D "amlogic,s7-pwm",
> +		.data =3D &pwm_s7_data
> +	},
>  	{},

If you touch that array in the next revision, please make this line:

	{ }

(I.e. add a space and drop the comma.)

Best regards
Uwe

--eenroa65e3lftv6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoJ9wUACgkQj4D7WH0S
/k6z4gf8CDKq+whV8je2O5ohJtU1A9GFL80VjHGqWPlp1Vzj64QRpZCZCbBwA/Mr
VhA7vIcUm2o6m3dGLNdz5Y6CXusEk+afjTh3eQOMgyOXCbK6gL69QQ3TU/RCGuIX
AGorWZzjsaV9UveLX4vc2VcZHEfxNb2AWNjvOgRfWrVb82Tw9cmg5Ago9dTFaSmz
LKS03jU9jzuo4qge4VeKniPvSp+a/5YyTGgPOpFcR8RP8/orcE5EhCSI9J4QE+Ad
Ynysyz8gr+delAF0En9fx190Psp2HsJvaEHO8C5xDfNXWkLw0tEiWD3QZVPY5TFH
MgfGGtsEIzVFRLKzVpfLkWRtc6Dr7Q==
=fPc/
-----END PGP SIGNATURE-----

--eenroa65e3lftv6j--

