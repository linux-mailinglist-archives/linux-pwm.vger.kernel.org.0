Return-Path: <linux-pwm+bounces-2059-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0E38B02EB
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 09:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF168B2178E
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF6157E6C;
	Wed, 24 Apr 2024 07:13:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311E157A4F
	for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942821; cv=none; b=kvc795Jkbw4LYvmQqEQx4kymNYuXKefL+Q4W2ZLl0ZhoI+toTQGIz4D94Z0Ac5rby/0jeiIVTIzEWQpoPKqFKgoeV/Ye40b4IG3wRDdGQ07299QrQ4SrtOBTPG0rrPi7gJkJ8FTPrHnrmLXDRcKIEIlXhlC5bUXrkQfg55CvPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942821; c=relaxed/simple;
	bh=rx8dQxF7O2w+LsWT4uOhrTVXL0DqhqsFlUl3fNHBo4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEXTRGipcx5c3kbeQx9IUbfXzYtNEmy+fHBrZ3hqQMKHoKUy7JSzdLXf5IWyjZ0szAH/A5f5Rp4BnhMkba2uJfasV6icuC0jroawskSez88X4o/fInZsKwT2NOVnXeGY0t3+sbDpUJfn8C5G0Pqxpfv0T+Tbyoe07nDxcUGvFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzWon-0000Qw-CI; Wed, 24 Apr 2024 09:13:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzWom-00E2Nk-5q; Wed, 24 Apr 2024 09:13:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzWom-007ftQ-0F;
	Wed, 24 Apr 2024 09:13:24 +0200
Date: Wed, 24 Apr 2024 09:13:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: George Stark <gnstark@salutedevices.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, thierry.reding@gmail.com, hkallweit1@gmail.com, 
	linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@salutedevices.com, 
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH 2/2] pwm: meson: add check for error from clk_round_rate()
Message-ID: <egrt5wtiulo7ovnxkgyxaaopyfbwsnmy6ire26vukj6kyaiuki@gkzflkoxmjwb>
References: <20240423161356.2522636-1-gnstark@salutedevices.com>
 <20240423161356.2522636-3-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qnio7x5dn2l5fiqc"
Content-Disposition: inline
In-Reply-To: <20240423161356.2522636-3-gnstark@salutedevices.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--qnio7x5dn2l5fiqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 23, 2024 at 07:13:56PM +0300, George Stark wrote:
> clk_round_rate() can return not only zero if requested frequency can not
> be provided but also negative error code so add check for it too.
>=20
> Fixes: 329db102a26d ("pwm: meson: make full use of common clock framework=
")
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  drivers/pwm/pwm-meson.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index ebe76298f6e2..52604635b31e 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -168,9 +168,10 @@ static int meson_pwm_calc(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  		freq =3D ULONG_MAX;
> =20
>  	fin_freq =3D clk_round_rate(channel->clk, freq);
> -	if (fin_freq =3D=3D 0) {
> -		dev_err(pwmchip_parent(chip), "invalid source clock frequency\n");
> -		return -EINVAL;
> +	if (fin_freq <=3D 0) {

fin_freq is an unsigned long, so your change doesn't have the intended
effect.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qnio7x5dn2l5fiqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYosRIACgkQj4D7WH0S
/k777wf/YOQM3/Dxt9O6SoVOz6MFbrovsT52w/n56bi6J1XQp845Y2b4HfQKqObS
ZKMnklknnVoOSRAJyuPtD3asa/pnZjZMTNzFomshqjlMGZGH7L8iXrpbbcxYegG2
t028M81HcjNPNLcYobkNJIaBGz4/XyIL0RtkoIb6KC/jtNWo7l1vmgoNos9i7ooD
Z9omjRL7BUfu7Df78FL/fTBBSKTiNB6Qez1TrvQusNWFquJGJ1EoZXgIK8KXKvua
qC8nZE3AOGp3aPIDtOxM98b729+2lCpIv2I2TLxxcnBXTMxzHaEfCtQckFxa9TNW
PgTEnXpzsCjbu0YPeDDXFB4kQWyhjQ==
=opt7
-----END PGP SIGNATURE-----

--qnio7x5dn2l5fiqc--

