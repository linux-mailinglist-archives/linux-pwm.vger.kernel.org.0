Return-Path: <linux-pwm+bounces-776-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B617D82CA7F
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jan 2024 09:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0021C216C0
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jan 2024 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D61315C9;
	Sat, 13 Jan 2024 08:31:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF915AF
	for <linux-pwm@vger.kernel.org>; Sat, 13 Jan 2024 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOZPw-0000t3-RU; Sat, 13 Jan 2024 09:31:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOZPw-002KQQ-CC; Sat, 13 Jan 2024 09:31:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rOZPw-008m4F-0w;
	Sat, 13 Jan 2024 09:31:00 +0100
Date: Sat, 13 Jan 2024 09:30:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Robert Foss <rfoss@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH 1/5] pwm: Fix out-of-bounds access in
 of_pwm_single_xlate()
Message-ID: <symlgsl5fnejwrycjtnftskfrc6fbgbr65abdv6guoblsznysy@wdl4n2fkv7g5>
References: <cover.1704835845.git.u.kleine-koenig@pengutronix.de>
 <243908750d306e018a3d4bf2eb745d53ab50f663.1704835845.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tdhff7e6iwjytycd"
Content-Disposition: inline
In-Reply-To: <243908750d306e018a3d4bf2eb745d53ab50f663.1704835845.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--tdhff7e6iwjytycd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 09, 2024 at 10:34:31PM +0100, Uwe Kleine-K=F6nig wrote:
> With args->args_count =3D=3D 2 args->args[2] is not defined. Actually the
> flags are contained in args->args[1].
>=20
> Fixes: 3ab7b6ac5d82 ("pwm: Introduce single-PWM of_xlate function")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 9a4c720c88aa..f2728ee787d7 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -152,7 +152,7 @@ of_pwm_single_xlate(struct pwm_chip *chip, const stru=
ct of_phandle_args *args)
>  	pwm->args.period =3D args->args[0];
>  	pwm->args.polarity =3D PWM_POLARITY_NORMAL;
> =20
> -	if (args->args_count =3D=3D 2 && args->args[2] & PWM_POLARITY_INVERTED)
> +	if (args->args_count =3D=3D 2 && args->args[1] & PWM_POLARITY_INVERTED)
>  		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
> =20
>  	return pwm;

I applied this patch to my for-next branch at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with the intention to send it for inclusion in 6.8-rc after being in
next for a few days. The rest of the series is merge-window material and
delayed accordingly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tdhff7e6iwjytycd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWiSkAACgkQj4D7WH0S
/k5N+gf+NB9plzbR/ESSnGR/bdFnEjJqaE8j+jY2LxWsLbQnjtjz2n4mOFo9bHhd
918r4fFqrSzCNrkK6G+fyO4bDSfeeaCFEBwZro6wlDmn26rx64Fe0ppY1aRY3WiW
iYkdlzDJkVQzPK3deTu+Z2pN4tDuL8NumOT84gq9LKOD7ye2+F+u+TnmyqHhVK5w
UhUgvYdGXCwvr+ZAwDeg5r69Z7DjCbNuTGtsYzVm0zqbGukDmbcnqiCOOi4BrL3s
Ce4M4/rL/aJD49YDXTYr2/fFp1Jjv9sNtAfXvagBAs2qE9Fdu8BxMLzxXIoE8+VM
PKOEt7+WBxw8ne8oPeX43TVC6HC+yQ==
=E7Du
-----END PGP SIGNATURE-----

--tdhff7e6iwjytycd--

