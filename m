Return-Path: <linux-pwm+bounces-1778-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9752887D926
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Mar 2024 08:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C181F218F5
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Mar 2024 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F578DDAD;
	Sat, 16 Mar 2024 07:22:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80601DDA0
	for <linux-pwm@vger.kernel.org>; Sat, 16 Mar 2024 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710573742; cv=none; b=E3FVf33B2LgY7WefLl8pEaEMsu+xRRZam/5X4gi3K3Hw8AIXYIZByB/bZrs23urH7R5/9AWrr/NW7kZmam+QyGwIKX1D+oG4/7fJqHKinxoqfBXNR62pbJfQMpdxTLUawcGlHRUioRC/2xBfmYD8e8Yo/ag3AdV36d+ZkQu6Fvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710573742; c=relaxed/simple;
	bh=pUnA3ZcULXonblOYqam9q2cdP2RsvnjmROoWsMBoJIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rApcKkGcuUHfMs1LzJr6RtGSJUTfsPeLehfQR++iu6ffNq1XuZp7vTCwwatD8DvAEoi5C4f0Aq5PFVLkNQehA5Nmhhaq+RxNdc1cSNyH5IPQLKis1d1My5STCnCEKZ22Pf2tfVzwo3VYAnCMSMubvvklRpt7gxMAKN9kixWz/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlOMq-00023s-Gk; Sat, 16 Mar 2024 08:22:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlOMn-006eVy-Fd; Sat, 16 Mar 2024 08:22:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlOMn-0079PS-1F;
	Sat, 16 Mar 2024 08:22:05 +0100
Date: Sat, 16 Mar 2024 08:22:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Subject: Re: [PATCH v5 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Message-ID: <jtqqbpr4qeo4m5oetmmusf2hy2wy6hnpstl344p2hu62vbbqrk@tefqeoqf37jh>
References: <20240314100131.323540-1-qiujingbao.dlmu@gmail.com>
 <20240314100131.323540-3-qiujingbao.dlmu@gmail.com>
 <ZfT42gzJhVd1NQzd@xhacker>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4lgqmjnyk5h5zzy"
Content-Disposition: inline
In-Reply-To: <ZfT42gzJhVd1NQzd@xhacker>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--s4lgqmjnyk5h5zzy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Mar 16, 2024 at 09:41:46AM +0800, Jisheng Zhang wrote:
> On Thu, Mar 14, 2024 at 06:01:31PM +0800, Jingbao Qiu wrote:
> > +static void cv1800_pwm_set_oe(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > +			      u32 mode)
>=20
> Did you get any information about the capture support pwm controller?

Instead of adding capture support to this pwm driver, I'd rather see
support added to the counter subsystem. That's more versatile.

See https://lore.kernel.org/linux-pwm/Y3aze3B6%2Fe5uWS%2FH@fedora for
some more context.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s4lgqmjnyk5h5zzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmX1SJwACgkQj4D7WH0S
/k6F+ggAks6uSCJiH1mbc45Emop15Wur2v3K91t2QJSqBoijti/USWld2/ZtveTC
EcqQzoSjZP4QrYxr+jQybwfgNad47KtT/+IEOiq7Fhg8trvMiBTr5IUJUiQl3aSl
qy3Iz49T0pBsm9FVzYcc9MB2B8I12hl1MHHAM+nh0p2gGeuwu3p89aFHCKgfnD08
3qikAnMFFVotItY+XhhQ6lgYw7PW89bD8HFbpEirHukSpzjuTA9SzAjcNXc+AC0T
N64SQHAl/N37RGUdUiABy/Md3WrMxY4CD3+/cllXgSzj5P+QyT75RMzSrjDtlKaI
IEHPm8ZLCn756hNE8bCRBy4BxQU6zg==
=3u2N
-----END PGP SIGNATURE-----

--s4lgqmjnyk5h5zzy--

