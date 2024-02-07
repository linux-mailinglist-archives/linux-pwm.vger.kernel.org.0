Return-Path: <linux-pwm+bounces-1232-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0E784D36A
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Feb 2024 22:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B24FB22B0C
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Feb 2024 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222285A0EB;
	Wed,  7 Feb 2024 21:02:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7980E1EB49
	for <linux-pwm@vger.kernel.org>; Wed,  7 Feb 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339779; cv=none; b=nG6hybk/tr5XkhuK4zzYqkw1ptEAJBw5XOJEk7yFKZvyNgYoea/o9GgqN5XKLjo6sD5Vo+TIzmaYFakArAQFtSgrRZYbaXzF+xjQI6rMSqJVscLLtEHOJYFRui9RFRoGRhK4xVyXdBP+EP5B/LfqE14d5RwSf1zc/A4tzAmQuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339779; c=relaxed/simple;
	bh=SMnOxcqyiKOEAilnYNvJ1dFmF1BWPXJbI27lylGchgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipNRlEBa8mVFOYdJ17AeumMUnWX/m4QH/UVD/SeN3bo2nmghA+sN1gZQHLODCSngphB4ee0PTSmD1ivc2j3iBuK/FgXsOahPJzJW5inc+4tW9QG4fJhXUjzst8B84ZrSRzoMzubCvl1UuksgNueqHNwuhbBBtPTTV7scWOD2F9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXp4H-0007oV-5J; Wed, 07 Feb 2024 22:02:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXp4G-0055Vu-Nt; Wed, 07 Feb 2024 22:02:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXp4G-00HWRP-20;
	Wed, 07 Feb 2024 22:02:52 +0100
Date: Wed, 7 Feb 2024 22:02:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: sti: Fix capture for st, pwm-num-chan < st,
 capture-num-chan
Message-ID: <ke2smhqbjkqwdvqgrad3t2zlmsk5fvdbqzdfo74fpsutpqxmn7@my3otofvpxze>
References: <20240204212043.2951852-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e42dhmedfx264hq5"
Content-Disposition: inline
In-Reply-To: <20240204212043.2951852-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--e42dhmedfx264hq5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Feb 04, 2024 at 10:20:43PM +0100, Uwe Kleine-K=F6nig wrote:
> The driver only used the number of pwm channels to set the pwm_chip's
> npwm member. The result is that if there are more capture channels than
> PWM channels specified in the device tree, only a part of the capture
> channel is usable. Fix that by passing the bigger channel count to the
> pwm framework. This makes it possible that the .apply() callback is
> called with .hwpwm >=3D pwm_num_devs, catch that case and return an error
> code.
>=20
> Fixes: c97267ae831d ("pwm: sti: Add PWM capture callback")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e42dhmedfx264hq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXD7/sACgkQj4D7WH0S
/k4W6Af+LP7GAMfV4xW8XI35c10G0QmuXzYGGgm4htVhsO7Ene8t5KZR4EgKZ+wg
qGQt1YjWN622JLJ/3HHxyo+Cb+rXOIJT3Xq4cNFUIv9PT8aE9fL+rjZpekLlKL4j
MyTYlM4yq7xIaipfd18aMuMN934BNfC/7xHKJO3CT+yPui7CFYRL1MoFfxAV1bQC
85J9imw6CzK6KQI5iU70WWHqIPDlrimPXtXhQf3/OwBLfzlLhJT4Plqcwf4EwQyi
wGyqDz8XMzs0UTjXeIcBxby4oBX02NFr1X0tMC+nF/CiKI5pYgseXeA/lshrinNt
JYsIsJs3ydRyICIdFPtqeRcXM33/CA==
=ryXS
-----END PGP SIGNATURE-----

--e42dhmedfx264hq5--

