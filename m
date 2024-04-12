Return-Path: <linux-pwm+bounces-1910-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E113A8A27CC
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Apr 2024 09:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6E228594B
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Apr 2024 07:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D8147A5D;
	Fri, 12 Apr 2024 07:15:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCAB33997
	for <linux-pwm@vger.kernel.org>; Fri, 12 Apr 2024 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906150; cv=none; b=ETsz0k6SAGhUUfkWfiWhXPWrG+t8lMUqY69K+JTgqfxTJkU/8TTsqYASmuhczJrvlpSoL1QcOfh+1GGpzdLFzvwMWAamw3dNYNVV23IB1jE96MqMKXGWk1KdOs4mEBikmmLK0sIJSRh8940IuJpq8xeZVtFq64nskOQ5rtbFwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906150; c=relaxed/simple;
	bh=6AH91ZsOHnGhIN+ZWiRkcUweQPi6FEZQz2eRBCfIUi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwS5dwEi/RQ9vXqbTKQiP1WJj8hJVksEkoB8NaHwvHBaSZ+hQSdUovJ8gf8ZeN6bUMtEcltrcs8iWgL8TBYRTPHYzHDK5oEOkKPnPaqJuVw1Ok+kO0XeWzPSpmbjWDlyyI26CKZFNidXM9MBlkBgrJFv8CO+h/G480GRn6GlbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvB8S-00060T-7W; Fri, 12 Apr 2024 09:15:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvB8P-00BpmQ-Q9; Fri, 12 Apr 2024 09:15:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvB8P-0011vR-2J;
	Fri, 12 Apr 2024 09:15:41 +0200
Date: Fri, 12 Apr 2024 09:15:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.com>, linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, 
	kernel@pengutronix.de, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] hwmon: (aspeed-g6-pwm-tacho): Drop cpp define only used
 once
Message-ID: <i37iuube65656euro5kuxgmfae6hdtlp5a6jsowwfalnmzckkv@bnre5uu6s75r>
References: <20240411160136.247138-2-u.kleine-koenig@pengutronix.de>
 <0787f458-c4ff-4498-820e-15e19796cbe6@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2t6a3mkchjp3ggeu"
Content-Disposition: inline
In-Reply-To: <0787f458-c4ff-4498-820e-15e19796cbe6@roeck-us.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--2t6a3mkchjp3ggeu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:15:05AM -0700, Guenter Roeck wrote:
> On Thu, Apr 11, 2024 at 06:01:36PM +0200, Uwe Kleine-K=F6nig wrote:
> > The macro PWM_ASPEED_NR_PWMS is only used once, just use it's value in
> > this single code line.
>=20
> I am not part of the thou-shalt-not-use-defines-if-only-used-once
> crowd, so I won't take this patch, sorry.

My patch wasn't about religion. It's more that I was annoyed that

	git grep pwmchip_alloc next/master drivers/hwmon

doesn't give me the number of PWM channels. That PWM_ASPEED_NR_PWMS is
only used once then only the detail that makes it easy to actually
change that.

So in my eyes there is no advantage in this define and the only effect
is that it hides information.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2t6a3mkchjp3ggeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYY35wACgkQj4D7WH0S
/k5gnwf/XcPjM9NeMEQD7/TRhaUUnDPMkSQ0octrNyPNLrv/Dxdn6l7zDRl7BvmN
eg5ErrXUjBSKG9d/ExxVrMFUH5U3sN8DDtblg7DTogqmjsjJP88QcQXjoLbB6Bvn
/AW+fabi7DAmcEHK3fdbaxdJqNTRGleP/KQNM84svAIymHKcd3rO/Zru7TfQzD2l
P1tciPXMdLV3tA59zw3WlFsflObr91c4gMSbWbp/x9D5skkIEMcr4xBIT/bIc1Q0
MUCZrq0258DNtce24nl4X/3lgMw1krBD2+0/b5ht3En1XFa7eR1c0gkPZCx/ZljO
liXbSjCRfG+BkI27aKiYrlEKlpIQ+g==
=DzfO
-----END PGP SIGNATURE-----

--2t6a3mkchjp3ggeu--

