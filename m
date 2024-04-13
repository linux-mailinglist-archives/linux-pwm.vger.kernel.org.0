Return-Path: <linux-pwm+bounces-1928-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01558A3BA8
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Apr 2024 10:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1401C20B53
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Apr 2024 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F33A366;
	Sat, 13 Apr 2024 08:34:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C1FC0C
	for <linux-pwm@vger.kernel.org>; Sat, 13 Apr 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712997254; cv=none; b=Zl1pkWc7K10j8nw8Hmj/3BdUkL6fcR85BU0EBCsy461IEyEgK03klJZNsadF5FxRMcbTLn0RP/borOacCZPW1PkfFeGJ4HfC01WzmZAMrTvZGTxNmNYdWpOZajTcF/gyQmYjXrg1ikoxCxYXcqueUMJYctd2+cJQKeYeoOuJNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712997254; c=relaxed/simple;
	bh=40BAp+yZUuTRmoo80dA+61fdXD+O/yD9OHZHF03hoy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5EYBgTr6Bc9bEjf8U5nGdW5rdrvosekZbR89GMC7fZFLOal9t1LgvvD61jpa4egVqdVoeHRqdlwMxlg8GXmNW39hHlFJAuT13o9lRq+T40y3x/mrEpOkekKE/ayeir47wAyV9l2i2ACLI2Lsf1LEUUZWZbja8qHUJaHCk2KdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvYpf-0002JO-Vo; Sat, 13 Apr 2024 10:33:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvYpd-00C1wL-GC; Sat, 13 Apr 2024 10:33:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvYpd-000fpA-1K;
	Sat, 13 Apr 2024 10:33:53 +0200
Date: Sat, 13 Apr 2024 10:33:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Joel Stanley <joel@jms.id.au>
Cc: linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, kernel@pengutronix.de, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] hwmon: (aspeed-g6-pwm-tacho): Prepare for further
 pwm core changes
Message-ID: <f43gbxbyjik76dzlwmjkcvfwdijzotctyngoidh7zb3xgog3ox@krm3avhdolhf>
References: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kxg3gmqzxdbzcys4"
Content-Disposition: inline
In-Reply-To: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--kxg3gmqzxdbzcys4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Mar 18, 2024 at 05:09:48PM +0100, Uwe Kleine-K=F6nig wrote:
> there is a pending rework for the pwm framework[1] that requires a
> preparatory change for all pwm drivers. When creating them I wasn't
> aware of the aspeed-g6-pwm-tacho driver, just found this now while doing
> build tests with my series.
>=20
> To not delay application of my series, I'd like to take the two patches
> from this series via my pwm tree.
>=20
> To state the (maybe) obvious: This series depends on the following commit=
s:
>=20
> 	7e1449cd15d1 "hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fa=
n tach"
> 	024913dbf99f pwm: Provide pwmchip_alloc() function and a devm variant of=
 it
> 	4e59267c7a20 pwm: Provide an inline function to get the parent device of=
 a given chip
>=20
> The earliest commit containing all those is:
>=20
> 	15223fdbdf4f "Merge tag 'hwmon-for-v6.9' of git://git.kernel.org/pub/scm=
/linux/kernel/git/groeck/linux-staging"

I applied this series with Guenter's ack to my branch at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E (Honestly I already did that a while ago, only noticed now that I
didn't explicitly tell about that.)

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kxg3gmqzxdbzcys4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYaQ3AACgkQj4D7WH0S
/k6p1gf/bC+XXzwCLWvjQc2AJM9nGY0a/ogPm9gQDU92NRnSV62zrm3R+3a0I1ID
VFB01y3omfw/G/XnSAoln+OuzfgI9LqUP/e+k1RMH5a/kiSp5elCrb86frHgqcuv
7LhSfgUgPmodytUclM3U7yLO0p8O0w2d9XwThdhEeiT96uCGrdbInaHkaDokp89v
7AriwfntCP5jCny5UPlIT4+TNfAWSHzKUj1y+PZNVLu6bhOsMvuLaHcDlwkLjrQ9
91jIusgrkGas/sdeHtiwucZDdfdbrB8eixUOJNNupYZwOil+Ipyyl8rITkBHMACt
1dL7CG2q5uOVEc7W7ex1aeQrOeofQw==
=Q+r3
-----END PGP SIGNATURE-----

--kxg3gmqzxdbzcys4--

