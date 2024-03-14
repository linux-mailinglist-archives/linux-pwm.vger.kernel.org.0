Return-Path: <linux-pwm+bounces-1766-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A44887C528
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 23:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD2E1F21E9E
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 22:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78514FC05;
	Thu, 14 Mar 2024 22:33:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E58FC02
	for <linux-pwm@vger.kernel.org>; Thu, 14 Mar 2024 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455616; cv=none; b=LKWoiSor6xTyqmvOFgNmFLwN/6wzavFYfVKSDTY5K+otk9ZQ3EB44WKPXZlXVSVhaNypIcgsNsyOEcM+5E1WsFl7yKd2G0525qLl9FelF8v8OeBW+upZChokujQXWaq3bZJBDEms76RBNZPgQBOc+SwSLzMOa0SeJ9aiLGBn+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455616; c=relaxed/simple;
	bh=ihgA60LNcNRNsnwrJPMU/qXH480BfDZgJKRbQsnZQU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ird7isiMy01UX72LEDs0KO8cMtULBlxbQnNBp35bOw85dc7p5/OT9mozhhC1FjFebmcOco1kKj2zBdZ2Jz4aAqV00i3pglbsDHH8T0NMQik9W4LZcdo2A5q4JA9tZCRPvmw5SUoczAdAkQ0Udv0GvfR3AE6ViUrmYxuLHJGM9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rktdc-00084t-Qh; Thu, 14 Mar 2024 23:33:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rktdb-006OJk-6S; Thu, 14 Mar 2024 23:33:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rktdb-006Kg3-0L;
	Thu, 14 Mar 2024 23:33:23 +0100
Date: Thu, 14 Mar 2024 23:33:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v18 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <ipm72ujiqm4k2nuq7a6sdmqdrwjwrn7uyp4brgbvmmb5mgu6ko@ljltsjnljett>
References: <20240220194318.672443-1-biju.das.jz@bp.renesas.com>
 <20240220194318.672443-4-biju.das.jz@bp.renesas.com>
 <hy5crf2leuvewkn5omgrk2bmkndivwmhst4yrefnd3mepy4nzd@xw3rtkxdnb2g>
 <OSAPR01MB1587400FECDBFDB3E38A594286292@OSAPR01MB1587.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b2blo5oikeky7f45"
Content-Disposition: inline
In-Reply-To: <OSAPR01MB1587400FECDBFDB3E38A594286292@OSAPR01MB1587.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--b2blo5oikeky7f45
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 14, 2024 at 06:10:50PM +0000, Biju Das wrote:
> > On Tue, Feb 20, 2024 at 07:43:17PM +0000, Biju Das wrote:
> > > +
> > > +static inline u64 rzg2l_gpt_mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> > > +{
> > > +	u64 retval;
> > > +
> > > +	if (a > b)
> > > +		retval =3D mul_u64_u64_div_u64(b, a, c);
> > > +	else
> > > +		retval =3D mul_u64_u64_div_u64(a, b, c);
> >=20
> > With
> > https://lore.kernel.org/lkml/20240303092408.662449-2-u.kleine-koenig@pe=
ngutronix.de
> > this function can be replaced by a direct call to mul_u64_u64_div_u64().
> > I expect this patch to go into v6.9-rc1 as akpm picked it up before the=
 merge window opened.
>=20
> Ok, I will hold next version until v6.9-rc1 as for-pwm-nexxt doesn't have=
 this patch??

I will rebase the stuff for the v6.10-rc1 merge window on v6.9-rc1, so
(assuming my guess is right) you can profit of the improved
mul_u64_u64_div_u64() call. (And even if the patch will go in later, we
can live with the inexact configuration for that period.)

> > > +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8
> > > +prescale) {
> > > +	return min_t(u64, (period_or_duty_cycle + (1 << (2 * prescale)) - 1=
) >> (2 * prescale),
> > > +		     U32_MAX);
> >=20
> > Can the addition overflow? Is the addition even right? This function is=
 used in .apply() where it's
> > usually right to round down.
>=20
> No, It won't overflow. The logic is proposed by you in v17 for DIV64_U64_=
ROUND_UP and it is
> passing all tests with PWM_DEBUG=3Dy.

Then believe my former self, I didn't redo all the maths in this cycle.

> > > +	pm_runtime_enable(&pdev->dev);
> > > +	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > > +	if (ret)
> > > +		goto err_reset;
> > > +
> > > +	ret =3D clk_rate_exclusive_get(rzg2l_gpt->clk);
> >=20
> > There is a devm variant of this function in the mean time.
>=20
> OK, currently for testing I picked it from next.

For the next submission round make sure to properly use the --base
parameter to not annoy the build bots. Or feel free to base your patch
on next.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b2blo5oikeky7f45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXzezIACgkQj4D7WH0S
/k7YlQf+MAzxRIviz2xJNNLzkzyrFam7AJLlqww6mmPogVY0wwlWXLArg+8sKkoZ
Y1qDMNEd/PbODNOFzeitVBVd0aCCATpusVIj3dcWhpv1I6nrYogIlVZcu2S79fFC
fxn451s9KcyzbPkUF5ijVDGwGmMt3XVFLG9Q3zQ9ombqRaYYDicu5SpBwU41p9rZ
UXbbJh1D7CXoZIqn9zrs2txBxAgsYB9JPU6emBkd2tBME+1lCT6bgndyW3kMapFw
OT7MmDfpVLNzrjA+GruGeAgSDJOMP+dzxWIlusdjL83o6TGQtgGebv8xDALEqbka
haS8s3mY/8HqZmpR+3PzHblj9m1bIQ==
=7iVt
-----END PGP SIGNATURE-----

--b2blo5oikeky7f45--

