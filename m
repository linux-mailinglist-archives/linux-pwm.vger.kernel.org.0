Return-Path: <linux-pwm+bounces-1635-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD9866E0F
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Feb 2024 10:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D5E285CDA
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Feb 2024 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047E524BE;
	Mon, 26 Feb 2024 08:38:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138A4F61C
	for <linux-pwm@vger.kernel.org>; Mon, 26 Feb 2024 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936680; cv=none; b=LcSjIzga3aqLT4uNWKp19el1G6jSc3Sh3BBPi4QeOZlmuskoew1L8PiG9T64zfJSzWW9HRWHymzOwIE/5j9mz5hKX0fyDX78kO5KqTAEZMEPpgL31EolWtrOaVDTHnQtaAyvKs5kafhQmI2A5jqmdbJ8Vkqp7uyK8p5Gxg/0E+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936680; c=relaxed/simple;
	bh=KAmvne7q+Q8T3w8X2/856LNdrltS10Maa6r6mYC0Gdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxNW3dxrdhfUmASZChY6E+1y9pPKCjs4dY5/hKOVkTF2mkFwYzuQlcTqScoMqED9DTBlPSR8yHnM4EKehIJ9x3sL/H4Y5/df2uS8fXbziuUYdtTBpmzACZvUrOBx/MlcdigA87rzMozRW638GZa5oBBVngMM8cRi6Pos/UZjQtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1reWUi-00039I-JZ; Mon, 26 Feb 2024 09:37:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1reWUh-002xNN-In; Mon, 26 Feb 2024 09:37:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1reWUh-00BVem-1b;
	Mon, 26 Feb 2024 09:37:51 +0100
Date: Mon, 26 Feb 2024 09:37:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Leif Middelschulte <leif.middelschulte@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pwm: imx27: avoid PWM consumer API
Message-ID: <ls4rsrc5qgdz6m3663aussioibzgr4uqauh5lene2rgod5inad@d7kme4d73xi2>
References: <20230906154215.4ikrrbx4xgx2nmu5@pengutronix.de>
 <20240224112902.55539-1-Leif.Middelschulte@gmail.com>
 <20240224112902.55539-2-Leif.Middelschulte@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4cci5o5cbxit77zl"
Content-Disposition: inline
In-Reply-To: <20240224112902.55539-2-Leif.Middelschulte@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--4cci5o5cbxit77zl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Leif,

On Sat, Feb 24, 2024 at 12:29:01PM +0100, Leif Middelschulte wrote:
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index cb564460b79c..d00d79a5edb1 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -255,7 +255,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip =
*chip,
>  	sr =3D readl(imx->mmio_base + MX3_PWMSR);
>  	fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
>  	if (fifoav =3D=3D MX3_PWMSR_FIFOAV_4WORDS) {
> -		period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm),
> +		period_ms =3D DIV_ROUND_UP_ULL(pwm->state.period,
>  					 NSEC_PER_MSEC);
>  		msleep(period_ms);

This doesn't apply anymore on top of pwm/for-next. See commit
1706175c682fdb3fbe0b70d50b137aaa270959db which includes this change (and
more).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4cci5o5cbxit77zl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXcTd4ACgkQj4D7WH0S
/k4wCggAuHGxwCvQ0z2YxiXsjHrkzTfgz/gskpGFGPtEXX9vKVQWmO97CQCWBrkR
BBPx0OavuA/ISBcY/+kUzFbY+Uy7pw0LqAtsA+HNeRTjxLfHHL4z60WFqHbXrtco
+HNpziL97gQWknDeJvdt0xoiT0sJ/ZMpcQ6qWRKMmELPDardltBcURX3UopHsoL2
Z5dpY9G+5RCY5/ALlcCgTT9UuD6BdqlX6pUCDWEr3Qkz0jjqQJi73Oz8vTH1ShNu
DmvXmDQvnL5Qg+HLR9Gy6Zsu9RYm3By870xOAU5hEtAlW1gAD6Y9S189Io++6fkf
4duNo5gOQjRPd/3ulWEXecY5k8y3Bw==
=gX9s
-----END PGP SIGNATURE-----

--4cci5o5cbxit77zl--

