Return-Path: <linux-pwm+bounces-1837-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D53A891FB5
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 16:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3831228ADD3
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Mar 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2C146D62;
	Fri, 29 Mar 2024 14:02:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C935D85942
	for <linux-pwm@vger.kernel.org>; Fri, 29 Mar 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720977; cv=none; b=YvLX5pmKhw2BJtJeY5zLVz/Cq6h06DG7T+v+jsIQyeMeg4yxGl5rGLZcYrDaIytADuHSHs6iKjylcDJVH42LY+uaRVHJNZHB+C3d5JhB5/gBx8kSO0xWLg3Gi8lLnEQWwSSeJZjoIDvw7GZRR7wSS6EkFDvNiRB2ilVDHe91EL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720977; c=relaxed/simple;
	bh=CTUdk1L/aKRoDFPX3NSo0uVm6JcRn+6eQ4QblsP4Vc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLZSDmgGMjqwy2m5Bgil6JcmPO8RYJAW5eo84V9FHRQe4lcAJKZmK9KdIXCaCo1xe5wvtc6M2vpXqoMp84rN1hCphg+qlMLYplp0EOg6y/MP9diwiJog3FNMIc/f3g5z2CEYq00IfqtxMBzwZ/+WZWVOpsmPAD8kAEBd5MZ3Qsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqCon-0005q7-W2; Fri, 29 Mar 2024 15:02:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqCon-009CdJ-Cu; Fri, 29 Mar 2024 15:02:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqCon-00DQZt-11;
	Fri, 29 Mar 2024 15:02:53 +0100
Date: Fri, 29 Mar 2024 15:02:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Cc: kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Don't check pointer for being non-NULL after use
Message-ID: <5ly72cm6hruwdblgxiecxxf3gcnplhy762vlrlxgbvlg7xyotl@y6tzrlholow7>
References: <20240329101648.544155-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z6bhuwcloiyf7phk"
Content-Disposition: inline
In-Reply-To: <20240329101648.544155-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--z6bhuwcloiyf7phk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Mar 29, 2024 at 11:16:48AM +0100, Uwe Kleine-K=F6nig wrote:
> After assigning chip =3D pwm->chip; the compiler is free to assume that
> pwm is non-NULL and so can optimize out the check for pwm against NULL.
>=20
> While it's probably a programming error to pass a NULL pointer to
> pwm_put() this shouldn't be dropped without careful consideration and
> wasn't intended.
>=20
> So assign chip only after the NULL check.
>=20
> Reported-by: David Lechner <dlechner@baylibre.com>
> Fixes: d60bc2995732 ("pwm: Add a struct device to struct pwm_chip")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

with David's Reviewed-by tag.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--z6bhuwcloiyf7phk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYGygwACgkQj4D7WH0S
/k4cFggAiSy/MUZo+BkDkgX8jTvPBMRSuIN1wQ65oWaKXiReaF69bLgM7qc5Y4M7
apEuS9cvCvZoFcItZLtnvs57SNsmsQA9ZIMU1WCx43/bjSYxCZLhVH/lwiY5dNO9
A50froUUYmoQ+1Eosxr93OyAwYrBN9y+w3Blbtjp/Oq1R7v/1ykcANHjyTBayzRc
afqcghQLoooi/DovGvyCy3srGegZ1i477O32RUDmhortqqmw1ZqRpe+YLvxYDlhA
tbnFtJ5vl2KqaUeIsElpCLGkDr5RNE8aKFw7dqxzmdtiH005MiW9Qc8mykFminHN
XHNO0kqZF3xmJmkuQpqSCDvpvkfGeQ==
=Y8Cg
-----END PGP SIGNATURE-----

--z6bhuwcloiyf7phk--

