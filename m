Return-Path: <linux-pwm+bounces-1057-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C32083C37B
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 14:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCFF1F25B4C
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805124F8A5;
	Thu, 25 Jan 2024 13:20:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AE50A76
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188803; cv=none; b=NjvsQKnswOu7KSYHczvjaRHqyBTXXQr/XfbNbY4LDoKQ9btP6BTOxIAXul8R3KJb+Y1IzZn3RiL9wrLhZWzSsSSbvuvAJxRA1voc6FVb3o4fUhEkPbXu8dytG/PSNA8kIkYWAxLir+o27V4siismEwGyzL5uvlkkainsmJFgfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188803; c=relaxed/simple;
	bh=rR98FAdYNTpRvXba0qscEcxIs4qeaM2A1/IUtVb2QQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFpm68Slf9lH698AoLR+p56mNAW7rhiCyahARFZVtxlDmeqFnRQqveCP3ZhHhuAXWd7pPhnEiJr7Ck7sk6xI+FQmpcThmYiDegJJe6vgaa6I92ZxjL4ld9DqSvEnRSpsjoOQxCmsTLMXwgxC8L51ReFQc2fDt3hLPwQ1fiJd+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSzeA-00041b-PC; Thu, 25 Jan 2024 14:19:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSzeA-002ITb-Ch; Thu, 25 Jan 2024 14:19:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSzeA-007ol5-10;
	Thu, 25 Jan 2024 14:19:58 +0100
Date: Thu, 25 Jan 2024 14:19:58 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Walle <mwalle@kernel.org>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 087/111] pwm: sl28cpld: Make use of
 devm_pwmchip_alloc() function
Message-ID: <g3nwht566fqcyxyfholgvhc5za2pe4zmhiow5c4fwwkieuwbsr@slxxexro4dsv>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <eba4f163b407831e27d1de769fe3a8ef29ad1f0d.1706182805.git.u.kleine-koenig@pengutronix.de>
 <8c92b4fa9e568f875763c65cdebc925e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gotvfvwqaqltnk7j"
Content-Disposition: inline
In-Reply-To: <8c92b4fa9e568f875763c65cdebc925e@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--gotvfvwqaqltnk7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 01:26:45PM +0100, Michael Walle wrote:
> > This prepares the pwm-sl28cpld driver to further changes of the pwm core
> > outlined in the commit introducing devm_pwmchip_alloc(). There is no
> > intended semantical change and the driver should behave as before.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Reviewed-by: Michael Walle <mwalle@kernel.org>
>=20
> With a small nit below.
>=20
> > ---
> >  drivers/pwm/pwm-sl28cpld.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
> > index 88b01ff9e460..934378d6a002 100644
> > --- a/drivers/pwm/pwm-sl28cpld.c
> > +++ b/drivers/pwm/pwm-sl28cpld.c
> > @@ -81,14 +81,13 @@
> >  	regmap_write((priv)->regmap, (priv)->offset + (reg), (val))
> >=20
> >  struct sl28cpld_pwm {
> > -	struct pwm_chip chip;
> >  	struct regmap *regmap;
> >  	u32 offset;
> >  };
> >=20
> >  static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct
> > pwm_chip *chip)
> >  {
> > -	return container_of(chip, struct sl28cpld_pwm, chip);
> > +	return pwmchip_get_drvdata(chip);
>=20
> This function now seems superfluous. Better use
> pwmchip_get_drvdata(chip) directly.
>=20
> If you don't respin or this is too much work, I can
> send a patch once this is applied.

I like it keeping around, becuase it returns the right type (instead of
pwmchip_get_drvdata() which returns void). Also it might be beneficial
to mark this function with the const attribute. If you want to care for
this, that would be very welcome.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gotvfvwqaqltnk7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWyX/0ACgkQj4D7WH0S
/k5wdgf+PPCbgcCo6L4y3439xgeSOSI9HrY9vr1ssfwjkCRHhUZyogkHkd06wYhZ
iIBdpo5/C00PCjaeIKC145ajmorP6j0O1OCXQYVsWPK/Rf35rOLP8jQEfWQlHsrN
M7admGotjx08RTtS9veqhyVoLlhMGAI40LxCsBwOg4319m85cKHh2gcNAozywH/l
trYxRT2TZnhFTHLqrUHu90hC0d/8o50hI9GDg++b+DXvfm6IQxptajok12V0j3mh
Ca6GUI/ByEZCOzfobyKMqgTYzxxhlPGAqLWwId+QD4NjnHPWTGdx2rMVlJxppvtC
8rZ5lpvOG7JHkTq9N8ZZsfdGBcYCIQ==
=nPsN
-----END PGP SIGNATURE-----

--gotvfvwqaqltnk7j--

