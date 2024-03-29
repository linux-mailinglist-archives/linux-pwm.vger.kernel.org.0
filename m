Return-Path: <linux-pwm+bounces-1834-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB4891F6D
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 16:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F9F28A82B
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D48155748;
	Fri, 29 Mar 2024 13:25:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A014290E
	for <linux-pwm@vger.kernel.org>; Fri, 29 Mar 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718706; cv=none; b=pNkTPt1mSxhCBmAJ+Md6G3tbjYJJLKwDTcmPCD3Q0TTrT/+BteKm/L46k3k8MRnaWsmctfopPqvHxtC3rd2CXinDjhHAT/MUwDt0kJiwLFYropXjwYp8vm+C5Nd6so1BdYdubhn78yN0FhUqZTobReXGUqsbtUZ84ZPWuRkUX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718706; c=relaxed/simple;
	bh=plpEJZpN8RophoBIO428P4+uis6HWGujZNP68CRK+DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9MYP5sfUGY3pEvT11eA3QvWLUnZbi3odTARYdAZBSncyRpJnqTFT+enw+W0bfqGAuW/9F+OQCQHOVCFu4wqJaFEP069JdxLDSc5W6euFl2iJE5vVPwSNIORGSWpz81nGXT8n4M+K+q4TmUbpsT8/d/un96lPX8VG3FjFdIJSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqCE3-0003yc-Nn; Fri, 29 Mar 2024 14:24:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqCE3-009CWw-3M; Fri, 29 Mar 2024 14:24:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqCE3-00DQD5-03;
	Fri, 29 Mar 2024 14:24:55 +0100
Date: Fri, 29 Mar 2024 14:24:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Karel Balej <balejk@matfyz.cz>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Fix setting period with #pwm-cells = <1> and
 of_pwm_single_xlate()
Message-ID: <v5jwouykt37up3bcjiigjgipzfdwgo5cguskunxjmyags43gql@dmrcrynj4zvj>
References: <D05IVTPYH35N.2CLDG6LSILRSN@matfyz.cz>
 <20240329103544.545290-2-u.kleine-koenig@pengutronix.de>
 <D06708BSGQ0J.1L4YOKOADM7T6@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wdi6njopmh7ee7fl"
Content-Disposition: inline
In-Reply-To: <D06708BSGQ0J.1L4YOKOADM7T6@matfyz.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--wdi6njopmh7ee7fl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Karel,

On Fri, Mar 29, 2024 at 12:21:15PM +0100, Karel Balej wrote:
> Uwe Kleine-K=F6nig, 2024-03-29T11:35:40+01:00:
> > For drivers making use of of_pwm_single_xlate() (i.e. those that don't
> > pass a hwpwm index) and also don't pass flags, setting period was
> > wrongly skipped. This affects the pwm-pxa and ti-sn65dsi86 drivers.
> >
> > Reported-by: Karel Balej <balejk@matfyz.cz>
> > Fixes: 40ade0c2e794 ("pwm: Let the of_xlate callbacks accept references=
 without period")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 54a62879fffa..ee3ef3f44bc5 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -512,7 +512,7 @@ of_pwm_single_xlate(struct pwm_chip *chip, const st=
ruct of_phandle_args *args)
> >  	if (IS_ERR(pwm))
> >  		return pwm;
> > =20
> > -	if (args->args_count > 1)
> > +	if (args->args_count > 0)
> >  		pwm->args.period =3D args->args[0];
> > =20
> >  	pwm->args.polarity =3D PWM_POLARITY_NORMAL;
> > --=20
> > 2.43.0
>=20
> Thank you, this fixes the issue for me.
>=20
> Tested-by: Karel Balej <balejk@matfyz.cz>

Great, thanks for your report and test.

> Just a nit: I am not sure if perhaps this being part of the report
> thread is sufficient, but generally there should probably also be a
> Closes: trailer for regzbot to automatically mark the report as resolved
> among other reasons.

I applied this patch and added

Link: https://lore.kernel.org/r/D05IVTPYH35N.2CLDG6LSILRSN@matfyz.cz

to the Signoff area which should be good enough to make the regzbot
recognize this as the matching fix.

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wdi6njopmh7ee7fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYGwSUACgkQj4D7WH0S
/k7rfAgAqO6NeqaoVOvG7Y09tLueKEqMEPyTFhtJfvi8sloEpgS3fFEh0OZY869r
lpX3gFuIE5o0UuK40CCHxIZ8Q2vLv48GiNO7/v8Vsf/EEgxMwxcZ72Ne2BRXvctI
DITqa6L7WuRfeJyRbl0fNE+1mxJd7j4ehEwzSERPzIGzV5S6lcN6Ku33rvoJbSED
JK2KLejk5F3VcToE/1Fht8By1Rr+p9jIZ2UFz7B2HF19OUG/5UPU9wTT1yr3d+uu
+J7pHPL+gcmBA62R8Yb0GacWQdeA8cebhpeYWnUgTb8Zig9ATGIB9q9ww8ckr80n
C3jCKZoCWRvz6/wetY7fjEYGD3dgFQ==
=r3am
-----END PGP SIGNATURE-----

--wdi6njopmh7ee7fl--

