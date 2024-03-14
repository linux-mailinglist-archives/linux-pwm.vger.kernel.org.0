Return-Path: <linux-pwm+bounces-1759-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893D87BB98
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 11:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1168E284AAB
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D246CDCE;
	Thu, 14 Mar 2024 10:56:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F126DCE3
	for <linux-pwm@vger.kernel.org>; Thu, 14 Mar 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413799; cv=none; b=BIc4WoLUedcN9a162gKEsFPEE1Fd2X9Y3VBVamMdm7+IX4KYS/uei0RWkyUOYhyYW2Y7g85BV/mQ4W/nvM5FJYHZjAMoyQHkfUi7U022HAbKkk6TV0IiumOZjTsqBUpGLPIkPasYQy5Y2QBdcUbBjJSZn5IpJyfoCW3KVQinZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413799; c=relaxed/simple;
	bh=76qAhW6gccmsrpJwTyJcCP1xdFqLz11/H0oJjYTUp3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p44aq4ziGRZBMMBEVrh0SrudQgrL0/5Itrm4THMHzc1keYqjYiyEEzW08yIsE1E+HFxgFBB4ICA27ZuUVh8IJ9DQWUutS0VajY2BX8iDJq7MeFGvGaStDyeeBKPbZcl/PLCEF1PBckjqVV2pkQ7Xn5OdCUq78n8ubXK1JX8oUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkil9-0003Sm-F8; Thu, 14 Mar 2024 11:56:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkil8-006IHm-3C; Thu, 14 Mar 2024 11:56:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkil8-005zWW-00;
	Thu, 14 Mar 2024 11:56:26 +0100
Date: Thu, 14 Mar 2024 11:56:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: linux-pwm@vger.kernel.org, 
	Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@pengutronix.de
Subject: Re: [PATCH] backlight: lp8788: Drop support for platform data
Message-ID: <ccvjubtxqqd445yb6g5smjko6p3d3ss337waqeoaray2imogyx@zo5hhnbipokv>
References: <20240313124828.861731-2-u.kleine-koenig@pengutronix.de>
 <7nvqboywxhviyuzkiesy4qfqybxx7vc5sw2seluc3dwnhk3q5h@hlzwxhnm2q6r>
 <20240314102035.GI1522089@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ozpx575aexkagfrb"
Content-Disposition: inline
In-Reply-To: <20240314102035.GI1522089@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ozpx575aexkagfrb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Lee,

On Thu, Mar 14, 2024 at 10:20:35AM +0000, Lee Jones wrote:
> On Wed, 13 Mar 2024, Uwe Kleine-K=F6nig wrote:
> > On Wed, Mar 13, 2024 at 01:48:27PM +0100, Uwe Kleine-K=F6nig wrote:
> > >  struct lp8788_bl {
> > >  	struct lp8788 *lp;
> > >  	struct backlight_device *bl_dev;
> > > -	struct lp8788_backlight_platform_data *pdata;
> > > -	enum lp8788_bl_ctrl_mode mode;
> > >  	struct pwm_device *pwm;
> >=20
> > Actually this pwm_device member should be dropped, too. I wonder why
> > this even passes a W=3D1 build without a warning ...
> >=20
> > @Lee: Feel free to fix this up while applying, or tell me if you prefer
> > an incremental fixup or a complete v2.
>=20
> Either of the last 2 options would be fine.

I'd prefert a v2 then. Added to my today's todo list.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ozpx575aexkagfrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXy19kACgkQj4D7WH0S
/k4nfAf+OQrf3llV5RSiTXvYqQ5I+p8EfNgaMwsW7vdlhFNXtVZRVorG1ikkWhSD
xa+tG8NM7HdSqfd+wtGF13UVzsXtQXgn7ILWePxen58V/rHq3VVYFn+wk7o2ciJB
B5Z9mZKLN2VSHR9AbJiOXCF8Ij0ROr83wqtkkH6Ahv/cWRbN6oyXMU3ECmQIBaFB
P8777pkXgGBslkn0YfIBQwrWT+gTXC9Yr+ptH1rr/B0VoPvhtB03epw5698eUk4h
ppoBrpQegRwd+MFwVMb+36wFx1LPpMK432J1uNe7OPbX6QC7Fzq6+p8tDJckUX2L
/mVGM3JtStRsgL9hY8kZNSaVeIgCoQ==
=rMia
-----END PGP SIGNATURE-----

--ozpx575aexkagfrb--

