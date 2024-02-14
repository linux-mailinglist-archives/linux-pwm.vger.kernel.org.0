Return-Path: <linux-pwm+bounces-1500-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A1854F74
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 18:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB1BB2AF17
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 17:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4960EEB;
	Wed, 14 Feb 2024 17:04:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72260ED7
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930267; cv=none; b=AQnMsnvcPMyWQbCgwkPguflwOTArEJdeQ/yRBNJeRDPkijnfSzViZohj4rNyL8y9I740tOGbLn0hXeNshWIZtUl0J/xH68BburSSvf1Du8gxH2G+NUMVbqvYTPhdDzHBo5HNyIJ9O7XDhDojawdv1C31BxvbUcbMNRe5NzFY04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930267; c=relaxed/simple;
	bh=wCX+HSUsgVhoSVER6tbzhPegan6QMTSr09rwLcmEo6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBtyVkAhRYSZjzw5HpiO6dK/eqxHFpTSGj2hMlTwzjTLEChT0rNe7cl7Vbbb2HFvjOX0Nt5EkWHFpGoNwZYPUPoSX0uF1CbYZAu5SIhrDK4SMVoMbPxuAA8dpYMaSJE6OVzQmGLXZWV4hE+lURVFvrfYnPDJHXrJmlZjRApgqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raIgG-0004d4-9q; Wed, 14 Feb 2024 18:04:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raIgE-000j6s-PC; Wed, 14 Feb 2024 18:04:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raIgE-004rCh-2C;
	Wed, 14 Feb 2024 18:04:18 +0100
Date: Wed, 14 Feb 2024 18:04:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, kernel@pengutronix.de, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v6 067/164] pwm: lpss-*: Make use of devm_pwmchip_alloc()
 function
Message-ID: <56rydkozta2nl3jsxaitcno5gdygrvvkjhmbtji7vh7pf2vqpk@7znvz5qwtkvu>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <b567ab5dd992e361eb884fa6c2cac11be9c7dde3.1707900770.git.u.kleine-koenig@pengutronix.de>
 <Zcy2GbkjX7N6buB9@smile.fi.intel.com>
 <asyro4yemnlljhyjxk7dxzzo3nlhqxq7hg5vk7lirx6gtknqsh@4jd42jhr6bkp>
 <CAHp75VffQUet_ZiE4-e-DzjzxMoNM8L=0WQiommi=hc1Hr9sxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m5g6gkqfw7vsyz6v"
Content-Disposition: inline
In-Reply-To: <CAHp75VffQUet_ZiE4-e-DzjzxMoNM8L=0WQiommi=hc1Hr9sxg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--m5g6gkqfw7vsyz6v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 06:09:47PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 6:01=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Feb 14, 2024 at 02:46:17PM +0200, Andy Shevchenko wrote:
>=20
> > (i.e. I didn't add your Reviewed-by tag because I didn't capitalize
> > pwm).
>=20
> Are you expecting me to bikeshed?! :-)
> Please, add it there.

No, not expecting it, but taking the possibility into account :-)
And I prefer being told that I'm over-cautious and should add it over
being told to have made a wrong assumption and should drop it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m5g6gkqfw7vsyz6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXM8pEACgkQj4D7WH0S
/k6HXgf/eIC0sD9rIJkIlPWCyb3ThKDg2BNS036wLhgnQPeBRwvDj6P/S5LtqurR
W8RJavLSaWeYeUQHlc5P4iipGJ8TFyTfAWhi/jjuXXkE/CqImbR0njw836ctuA2j
n2/p4p2Ag9fOD1I2N5xPFnytICRay2P6uWt65LLLPfdR8TW+jxPUZVXgXTUM0fA1
fA/DEFQU5fBbINQvIVQcxd3HwOlDd2uDt220FcAlesKS8xj8YaJ7xzv/AIP0ja0+
kbVrGB6Pq1JmQsis4OwWqCHhvI/dOzkJz9BCILtnnm4V5+f8aifEpIOGXkK6md8U
cEhTHR0OaRbWVQm1aGZIZxerQ+GkUw==
=WKaD
-----END PGP SIGNATURE-----

--m5g6gkqfw7vsyz6v--

