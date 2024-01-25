Return-Path: <linux-pwm+bounces-1066-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F162583C819
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 17:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3067E1C20B49
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CA5634EE;
	Thu, 25 Jan 2024 16:34:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7E7CF13
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200442; cv=none; b=j8pae0auHZpoC/U2fKvS+0YPAWyMgmCL+lq1p5LI6su8Ndojat+kc3yHFNMKvpRaEJzE4vGdtAyL+uFnveYkMe2GxSsIInWme2zmuCJ+C9ISPyzASPehc/tpi4fu7mcjWuZpFRBf4FkP+8o+g2vetTH12MUb2W/qcWa3gx9VHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200442; c=relaxed/simple;
	bh=MfdSFxdcjytp4smFmdpgmKHlHtclZ8Y5QYXwNANMI5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCYyghgN7E4iwHumz0st8/DmLvgAOOqsJObsHjgNSgkCEP8qHnekhIhOHlFoXReO99xI+3rjK/UtLXXlT+CCMadPveBZQyBaX/knR6fY+Sfe8J9f8R87zb7NKSiBdp8g+mcRwX1jm/4wjyyn7xqj8QvKL/ITfxy4mc9yba8I7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT2ft-0001bv-3l; Thu, 25 Jan 2024 17:33:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT2fs-002KJ9-Mg; Thu, 25 Jan 2024 17:33:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT2fs-007y17-20;
	Thu, 25 Jan 2024 17:33:56 +0100
Date: Thu, 25 Jan 2024 17:33:56 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Walle <mwalle@kernel.org>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 087/111] pwm: sl28cpld: Make use of
 devm_pwmchip_alloc() function
Message-ID: <tdnopqe6tgk4lyelaevyrsklwlpciwqjseqdn22yq56k6yhcfn@jy467apaymil>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <eba4f163b407831e27d1de769fe3a8ef29ad1f0d.1706182805.git.u.kleine-koenig@pengutronix.de>
 <8c92b4fa9e568f875763c65cdebc925e@kernel.org>
 <g3nwht566fqcyxyfholgvhc5za2pe4zmhiow5c4fwwkieuwbsr@slxxexro4dsv>
 <54f93af5837bb07ad5ee2c0aca7a8633@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ohdzcafv5hvzg6qv"
Content-Disposition: inline
In-Reply-To: <54f93af5837bb07ad5ee2c0aca7a8633@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ohdzcafv5hvzg6qv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Thu, Jan 25, 2024 at 02:28:56PM +0100, Michael Walle wrote:
> > > >  static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct
> > > > pwm_chip *chip)
> > > >  {
> > > > -	return container_of(chip, struct sl28cpld_pwm, chip);
> > > > +	return pwmchip_get_drvdata(chip);
> > >=20
> > > This function now seems superfluous. Better use
> > > pwmchip_get_drvdata(chip) directly.
> > >=20
> > > If you don't respin or this is too much work, I can
> > > send a patch once this is applied.
> >=20
> > I like it keeping around, becuase it returns the right type (instead of
> > pwmchip_get_drvdata() which returns void). Also it might be beneficial
> > to mark this function with the const attribute. If you want to care for
> > this, that would be very welcome.
>=20
> It's a matter of taste I guess, so I'm fine with either. It's only used in
> two places. If you return const you can't use it in the probe function.

Why's that?

My guess is, we're not talking about the same thing. I consider:

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 934378d6a002..1dcdcdd03787 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -85,6 +85,7 @@ struct sl28cpld_pwm {
 	u32 offset;
 };
=20
+static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct pwm_chip =
*chip) __attribute__((const));
 static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct pwm_chip =
*chip)
 {
 	return pwmchip_get_drvdata(chip);

=2E Now that I created that diff: It doesn't change anything. Other
drivers might benefit from a similar annotation if they call their
=66rom_chip function in more places.

> And using pwmchip_get_drvdata() just there is worse.

Ack.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ohdzcafv5hvzg6qv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWyjXMACgkQj4D7WH0S
/k6KuwgAgCrQmjKLoFUZZc0Fm4v0+1QyRZwDXODybI6p/Qg0Tt7CK9z0GFIzkIpv
AC7mN7ZEbeEKn/VOVC0HZJvlFnOuKcLNBZpO5lseEv2CQkylN/VxkQ0e9JPsT7Md
9bQ6LhlRS+8qCOTaFtN0jhVD1Msz8WYCAvtbK2SVtEp2cYhi9V+f2ovvsW7Ms7bq
6hnXO+q5KKRAr2eo4sDtgd5OJGcF1puK0jjHqL3aEW2CU9xm4pVezSVKhVliVetZ
bYXKzHgKXfxwlzUZeF06YwRdiLIjJI3wBpzqAdlrYVEq4XoHSxuqkzrs81MM39qx
ugyUHzSfRJRkgN83XsFNt3bzxc3BeQ==
=35Ma
-----END PGP SIGNATURE-----

--ohdzcafv5hvzg6qv--

