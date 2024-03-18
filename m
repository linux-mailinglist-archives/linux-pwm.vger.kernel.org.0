Return-Path: <linux-pwm+bounces-1795-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9586987E55E
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 10:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504A528299D
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8923028DCA;
	Mon, 18 Mar 2024 09:03:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AAE28DB3
	for <linux-pwm@vger.kernel.org>; Mon, 18 Mar 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752622; cv=none; b=IBb0Ni6xMK+N1+h/72u1oqWEbck5PbEwc8xSVjoKaSXDin8pyW8EJAt2/HZrsosQZbLL+DwvFdYeRhiBEwo6iKRvX2skyY++nptx5LV/U1g8O8pKymij0GLJZCI/IxampgVa0isVKhzR5FUJw5SXTed3aaT91yxKnJCmj3kRE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752622; c=relaxed/simple;
	bh=BTmKdadj2OJYXK6VURAI138StSLXHK5fbYKNJaR2UqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpqAFj4kigUld8t2PIqRlGUfPelPZ5NuD5dIX0a9nfDyJF2LhO5wg3MQWl1ZPT4dS7RkqUjRTRC67pJNg/pGE30oFDp1z+wXhF7qyitGCcst+D2SNpbvP1OR5Iou9yYyo213xrc++aUth1aniI+CZr+8xILOGyXmkh6N6/jBEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rm8uA-0004YB-PJ; Mon, 18 Mar 2024 10:03:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rm8uA-0072fS-4V; Mon, 18 Mar 2024 10:03:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rm8uA-007pJZ-0A;
	Mon, 18 Mar 2024 10:03:38 +0100
Date: Mon, 18 Mar 2024 10:03:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee@kernel.org>, 
	kernel@pengutronix.de
Subject: Re: [PATCH 0/6] pwm: sti: Several improvements
Message-ID: <m2lrf742jn2c4i56z6pzfaamtvvthjh3yhgjjuda2gc4xeeqym@hhjb35usjzyg>
References: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="somp46qjogby76xj"
Content-Disposition: inline
In-Reply-To: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--somp46qjogby76xj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Mar 10, 2024 at 12:00:53PM +0100, Uwe Kleine-K=F6nig wrote:
> Uwe Kleine-K=F6nig (6):
>   pwm: sti: Simplify probe function using devm functions
>   pwm: sti: Improve error reporting using dev_err_probe()
>   pwm: sti: Drop member from driver data that only carries a constant
>   pwm: sti: Maintain all per-chip driver data in a single struct
>   pwm: sti: Use devm_kcalloc() instead of calculating the size for
>     devm_kzalloc()
>   pwm: sti: Prefer local variable over pointer dereference
>=20
>  drivers/pwm/pwm-sti.c | 161 ++++++++++++++----------------------------
>  1 file changed, 54 insertions(+), 107 deletions(-)

I applied this to my for-nexxt branch. Don't rely on the commit sha, the
branch will see a rebase on (at least) v6.9-rc1. I'll also continue to
address feedback (be it a request for changes or review tags).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--somp46qjogby76xj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmX4A2kACgkQj4D7WH0S
/k7z9wf/Q7+SuivBZWtvDKg8U+uo8oLboyZX/T+0L+ODigVmL8AWXuH93jeHI0+9
lFLCV6HJ5cmpDdXFZe9Ho7eMtxcZGRMNDCH2px39mIoNWAsjWtb9DFzXiC0+7wtF
WBmuugmdIefV1jH9AG/5/bU/YmmJUIAhH0yfBy3gK3yeIPn4SbjuEHxBJBUpb6Zf
N1ulPrrEjuOy8aIrDt6hlsX5UU6NuJSgqam8UPf4YobPrSgegk8ttfLIb+TaEWuT
tJ1FmdnuXU57YoHl2ZS3zGGBoB+W+1OeGrDj23bMDbuAVpXOnO6cUWjxeIRfa62p
4Z7NYGoOhVZ2kWtqx3L+GqsA9jkNLw==
=T/2R
-----END PGP SIGNATURE-----

--somp46qjogby76xj--

