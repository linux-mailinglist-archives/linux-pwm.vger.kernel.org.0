Return-Path: <linux-pwm+bounces-1831-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635C1891699
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 11:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EB31C21158
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E6052F7D;
	Fri, 29 Mar 2024 10:19:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19278524DE
	for <linux-pwm@vger.kernel.org>; Fri, 29 Mar 2024 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707550; cv=none; b=l/MqNky6Tp+VYLpHPhDeYjj1uBfQNJ7To6zlQRh8oLAqxzu/ozIWZqRllTi8MVToW/fuqLSQ7c1HbTcUvgJCaTJSe2/3CUR9xPuQCuGDUz3UWDuHEU2XSsiNjHyYwHFLkxT7HERxY5ZCam8ql6qP2SLxFnS9afa9JiPMuTNKWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707550; c=relaxed/simple;
	bh=8BZ2g2hO/vptofKoHWFryBlSsMlLzOvOovXnremHsXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbxcpymemZSqBhPfrAsNKvULRnIWibxwxK2Zsqe/sxswOts7/ZMmdT+Sh2RJxDRj9nMPaDMPNMQtIuFZPriwvk7rdkm0mcZRWAZTcxzIOYGEjYjVY3gy12W9VGGymk6+WZTs8sdp/Fly8e6Bi3kKS61i6MrG4M/rQCTFpmVP+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq9KE-00066g-4E; Fri, 29 Mar 2024 11:19:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq9KD-009Aoj-Nz; Fri, 29 Mar 2024 11:19:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rq9KD-00DOxj-29;
	Fri, 29 Mar 2024 11:19:05 +0100
Date: Fri, 29 Mar 2024 11:19:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 5/8] pwm: Add a struct device to struct pwm_chip
Message-ID: <jykeil3hx54ffhyzm35y6agrz7cximbli55o7s4bgsb76ylum3@3dlxlm252dmd>
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
 <35c65ea7f6de789a568ff39d7b6b4ce80de4b7dc.1710670958.git.u.kleine-koenig@pengutronix.de>
 <66a6f562-1fdd-4e45-995a-e7995432aa0c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x2umjfuf2rpb6wjf"
Content-Disposition: inline
In-Reply-To: <66a6f562-1fdd-4e45-995a-e7995432aa0c@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--x2umjfuf2rpb6wjf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 01:44:45PM -0500, David Lechner wrote:
> On 3/17/24 5:40 AM, Uwe Kleine-K=F6nig wrote:
>=20
> ...
>=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 8ed4c93cd0ce..09ff6ef0b634 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
>=20
> ...
>=20
> > @@ -1520,6 +1525,8 @@ EXPORT_SYMBOL_GPL(pwm_get);
> >   */
> >  void pwm_put(struct pwm_device *pwm)
> >  {
> > +	struct pwm_chip *chip =3D pwm->chip;
> > +
>=20
> Should this be moved after the !pwm check to avoid potential null
> dereference or is it safe to remove the !pwm check now?

This is indeed on oversight. Thanks for finding and reporting it. I just
sent a patch to address this by delaying the assignment until after the
check below.

See https://lore.kernel.org/r/20240329101648.544155-2-u.kleine-koenig@pengu=
tronix.de

Best regards
Uwe
=20
> >  	if (!pwm)
> >  		return;
> > =20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--x2umjfuf2rpb6wjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYGlZgACgkQj4D7WH0S
/k5s7Af+NWhKbdLSWHq3MUkkZ3oN8CkbHt9dlwX3KWZ8kxR0k4+3hhGKH+Bax7V0
sJ4Ub3XF0aHIY6RH2ELiaVuwRHGUD8DLnKO2E/tiwTtSmeq91Jn1cMFQA9gwin8Y
UXfw8RDlC4pofatEX0ztZ04+vYZo5uFCn4HicRgyQO/9j/3zSBhVxTm7S9H4oZ+i
WiIJWMpJ+f2SQyZLlZtzb58QKZkfoeJ8Dzc6IWb9yYVbTMKey4UhtOIHUbVTrSDk
5Saj/V2pPE6e/9aE8zGGMaQL6Xoz7SNatDmTHVpLKP75Ox8ND5lc80KD25f1mfmH
ysuHLqdRH38KFaZ4MnHkwGHpnXxeNA==
=fuoW
-----END PGP SIGNATURE-----

--x2umjfuf2rpb6wjf--

