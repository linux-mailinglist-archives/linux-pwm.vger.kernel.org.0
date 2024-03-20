Return-Path: <linux-pwm+bounces-1806-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A510880F14
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Mar 2024 10:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7751C20481
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Mar 2024 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A823A3BB35;
	Wed, 20 Mar 2024 09:51:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C73BBCC
	for <linux-pwm@vger.kernel.org>; Wed, 20 Mar 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928309; cv=none; b=pMgrRhJGjwT1OJ5MJzQvn/WHXdy71AgMUwNj1ehhsX/7PopfgK4s7lNn5TPVlw1gUoSCgLzc0yI/0LIig3AoChrKU3nzJdJC2KzfzZb3U8QyuhNows5u8cu7fq5OQkXCkYXhZxXBgGmiRi3/j80VCNQIPiwUjo4OKKaKJ+j1j6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928309; c=relaxed/simple;
	bh=J94+UBFTtDz9RgcjQbKlLhQRNa9Z7lCDQ3TX7MnkexE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmC2d7FYVnGHfB8+PwT0LG/nPxqeNH19E4GWvhrWEx39lY/nGQ/fFitRePhhZRfjOBfRHfvMn4JuDfPukZIhz3AdaF9c00TGYmxxzCPCq585xEdsgDZ3y8pBBSKT9K0txC+Hw9EHZKdTjrGqBHFFSTpAku14Yse/obXUPNL1O8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmsbp-0000bG-6l; Wed, 20 Mar 2024 10:51:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmsbo-007RNi-QS; Wed, 20 Mar 2024 10:51:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmsbo-008iBp-2N;
	Wed, 20 Mar 2024 10:51:44 +0100
Date: Wed, 20 Mar 2024 10:51:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Zoltan HERPAI <wigyori@uid0.hu>
Cc: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: img: fix pwm clock lookup
Message-ID: <kuzl6gbbiwhnvzr6sjfvcbybvujgvb7gbeiykqesvjhjsrpnap@c6oe6p7xqgqb>
References: <20240320083602.81592-1-wigyori@uid0.hu>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4stb5odomizs4ql7"
Content-Disposition: inline
In-Reply-To: <20240320083602.81592-1-wigyori@uid0.hu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--4stb5odomizs4ql7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Zoltan,

On Wed, Mar 20, 2024 at 09:36:02AM +0100, Zoltan HERPAI wrote:
> 22e8e19 has introduced a regression in the imgchip->pwm_clk lookup, where=
as
> the clock name has also been renamed to "imgchip". This causes the driver
> failing to load:
>=20
> [    0.546905] img-pwm 18101300.pwm: failed to get imgchip clock
> [    0.553418] img-pwm: probe of 18101300.pwm failed with error -2
>=20
> Fix this lookup by reverting the clock name back to "pwm".
>=20
> Signed-off-by: Zoltan HERPAI <wigyori@uid0.hu>

Oh indeed. Thanks.

I applied it to my for-next branch at

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

and will care to get it into -rc2.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4stb5odomizs4ql7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmX6sa8ACgkQj4D7WH0S
/k4vnAgAqk1flK2Qm0b1nJQyNh43BOr3e8F8e5xhjPjIrdzhvDOSCZ+Bso7KQ6vi
0DLCcfU1/caUOlvL7O6FBurL8EqAbhwyNyz1fjZmcDvGaD6h2E3kFfDWyHYKdAnq
j/h6h6lqMquzSfIW3CNkVl1f9pQvIdPO44Gs69gYzgrPVBXOQB2gkV9P87XUdi3Z
YNMehwnHYIUzEg7Pzrjvc5W5MhzJBSYm/hB6losL6bJOmiXAVptqs7lHIxTEEbPR
jLmlRS2TemS7OPFGUV2PAFWFib/kNKgFQolJ558zPmBkeY60jPK/RUsUCvRHetNG
r/KeJRt/0v6JhaJ8igEPlun9Ru2U/Q==
=OXRH
-----END PGP SIGNATURE-----

--4stb5odomizs4ql7--

