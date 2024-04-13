Return-Path: <linux-pwm+bounces-1930-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A778A3BC3
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Apr 2024 10:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147921C20CA6
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Apr 2024 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02E7F9D4;
	Sat, 13 Apr 2024 08:53:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6B366
	for <linux-pwm@vger.kernel.org>; Sat, 13 Apr 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712998386; cv=none; b=m9HiSq6lZwlVgba0yoCgYsIbAabVbZnZryY9YhzdQqkztO0wRaVZypOQVPzD39cI+CeTenRmRvurzQewveBqh1SUXBqInqNseLin7xANbth//AxsB+uqdvJD6PJqmMg4PACjZ8v/Ivc3rkOUCf92BIuTolew6hUTgaDBCcxnnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712998386; c=relaxed/simple;
	bh=l7ARDl7z66rug4Jnw1sXyXp2sJwlOpQ95hJ0ZRDjnro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxS7t8PnjXuqa44CMrnRukWxBAdACYN75411aTBRX4zh6ghR4dt7oS2iADXKQeUghzLgAlIgq8edhziYCLRZ13vvQslWAqUvapD1vSsFTm08kroDJ6+SRyLEwPZUHB1TsXMZ4O/TYyXFq6Y2CZJH/s7LnAJPTq2iXts9UnIcnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvZ8B-00065o-Q3; Sat, 13 Apr 2024 10:53:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvZ8A-00C20S-SJ; Sat, 13 Apr 2024 10:53:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvZ8A-000gI8-2X;
	Sat, 13 Apr 2024 10:53:02 +0200
Date: Sat, 13 Apr 2024 10:53:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: kernel@pengutronix.de, linux-pwm@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] pwm: bcm2835: Drop open coded variant of
 devm_clk_rate_exclusive_get()
Message-ID: <3qlb7dkccihk5p76aofsh5n52edrwyh3yl7x6jezcv5566t6ff@7s7fzw2vxqme>
References: <cover.1710078146.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cv6x3c2xfvitarzl"
Content-Disposition: inline
In-Reply-To: <cover.1710078146.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--cv6x3c2xfvitarzl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Mar 10, 2024 at 02:47:18PM +0100, Uwe Kleine-K=F6nig wrote:
> the main motivation for this series is the 2nd patch. The first is just
> a minor simplification. Note this series depends on
> b0cde62e4c548b2e7cb535caa6eb0df135888601 which is currently waiting in
> next for the upcoming merge window.

I applied this series to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
based on v6.9-rc1 which includes commit b0cde62e4c54 ("clk: Add a devm
variant of clk_rate_exclusive_get()").

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cv6x3c2xfvitarzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYaR+0ACgkQj4D7WH0S
/k5IFwf7BkLuHcIpTxCh40fjDlVu+BbAFcbDi3bjNQPxjPbyWoMHFiIt6NV6Ypu2
uC+33vQhrKyFEqWbEpqUQSg40/0OXECThXd1LmlTl1aLVYxf82u1GSS09T8wh2bH
mgoGNAawOm324wn6mx8YHRwKaUlBJDzHuRz0CZvy51wBYF2kEz2iWfaouG9MtJ6k
XOzwXIqOY8g5gmA5ONBwN7jHQF9azehtLbKbs7NAyydPj0iwcYphX1JGbSlNxE7H
As0hHcRO5rKSHwE4ZxRONnjk8aLMEqCC6VE5sMt6QwUYBpqeEcdsXOZHjyaHgPln
yY0cOZLdUM4iacNNKeYt7c+B0ccCMw==
=df3I
-----END PGP SIGNATURE-----

--cv6x3c2xfvitarzl--

