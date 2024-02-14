Return-Path: <linux-pwm+bounces-1498-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44996854D88
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 17:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781871C2893F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C385FF03;
	Wed, 14 Feb 2024 16:01:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5282C5FF04
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926501; cv=none; b=avoX8Jc8i1x1IFMwJYe4gAFu+55SKtY8O9ypg4d/nLPaK9n+NVHIuxjxbZ3cD6EoHy2o+9ZzF9IJcMtawiva0CLWXWwYqedqpeirm22Kx3cMxU63XEwxKjl+6i9r4UVriW12lafFL4++N+RcJouof0MS5vc5V25JziwdB61+INY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926501; c=relaxed/simple;
	bh=qQgiis671KMhxBu/V+1KoLmS1g8E7kk7u3pEl6sUoeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCYw3Ghowu+O1HSU0hsYm7TP6NCEATv6iw9rIYKNXHrnxFUzzuoJxbrzp0gpwD88f6UYytYmVKRM0fo5hEXirRfV0w7hEwXNACGsifZ3EMAxRk7q+FQf5FmNpxy0V4bVcuYWT/r4UcGz1YNJWBAmxs/61KQ4ZJIfTLsQreTsTLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raHhY-0004Ml-OG; Wed, 14 Feb 2024 17:01:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raHhX-000ibZ-Q7; Wed, 14 Feb 2024 17:01:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raHhX-004mX9-2L;
	Wed, 14 Feb 2024 17:01:35 +0100
Date: Wed, 14 Feb 2024 17:01:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, platform-driver-x86@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, kernel@pengutronix.de, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v6 067/164] pwm: lpss-*: Make use of devm_pwmchip_alloc()
 function
Message-ID: <asyro4yemnlljhyjxk7dxzzo3nlhqxq7hg5vk7lirx6gtknqsh@4jd42jhr6bkp>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <b567ab5dd992e361eb884fa6c2cac11be9c7dde3.1707900770.git.u.kleine-koenig@pengutronix.de>
 <Zcy2GbkjX7N6buB9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uj2rlk6shklovz67"
Content-Disposition: inline
In-Reply-To: <Zcy2GbkjX7N6buB9@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--uj2rlk6shklovz67
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 14, 2024 at 02:46:17PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 10:31:54AM +0100, Uwe Kleine-K=F6nig wrote:
> > This prepares the pwm-lpc drivers to further changes of the pwm core
>=20
> lpc --> lpss
> pwm --> PWM

I'd keep pwm in lower case. While I agree that the thing the pwm core is
about is written PWM, I use "pwm" to describe the framework. So the
directory is drivers/pwm (and not drivers/PWM), the subject prefix is
"pwm", the function prefix for pwm functions is pwm_.

Agreed for the other changes. The current state of the patch is
available at:

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/commit/=
?h=3Dpwm-lifetime-tracking&id=3D5b8f3aa33b3def3c8441ce28c93062766f278b09

(i.e. I didn't add your Reviewed-by tag because I didn't capitalize
pwm).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uj2rlk6shklovz67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXM494ACgkQj4D7WH0S
/k6ZGgf/Ybx1ACeubPaD0rZmGGJ3/29QV/AG6oJ6Lsu1euAxy5PFEC7O8XzXALSw
xT9TM1Cu418Ims5cdCWcoiCDsUWl3Jdo69Ce4GrB2vLtrjswmkWte3VgLUuRbKxy
Erai9v5rbVu141/DB+3Iwyows9F4+Jh1jmbmxh5f9uxDl5EQg+SOEIjucywcusBh
oswV8D0bHQVYFnjZBbh8ZNAh13gz4p4SRR26IbOxhQL3B2nF/frCSWe+eKksT5ip
Zrg9DMuhKmQbksPRaQfGJapH1erd81ktbQ+jZlRWEfbih/HQPLPoGeiiNDRnbwH0
6s03TqXIdAJu/FErDoqmHFNRl8m7vQ==
=947R
-----END PGP SIGNATURE-----

--uj2rlk6shklovz67--

