Return-Path: <linux-pwm+bounces-1510-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E3855AFC
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 08:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DC91F227F1
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 07:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CB433C5;
	Thu, 15 Feb 2024 07:03:12 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF6C15B
	for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980592; cv=none; b=fiekq6W1hTjrHj922xKhLH7dYSdo5gXKMPuYp7S26kcaP05KIi+JQIJWkDTGxIOwzsulQ5i3ZPA+/SG7wHbACjIMOZHAT+DkM/sLDgOvn4hzWYK9azoDq22bgPx0dJwz4woJGIjNlq83QJyTx6A0saNHeE9+dQrMpQdj8srrWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980592; c=relaxed/simple;
	bh=YaSPrgx9O2PH8IQnKrm2JLXk+RR8kTd4YxsU2OVOcak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaPqKy9nsstrYy/XIXbrbvSgNY9Dah9AHyH2mrgJKsFytUvw7mbzM9pO4+tNnD/z1V4beEyc0KMwjfCHQvIaZ3CREiQnO0towMMeMPYxDeDqjq9CZ3ICQlN9KD9/gPNGEn3zm2Nyo+1Y310OtsXK2EGUAvN+gHTG/AnBDt910vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raVlw-0007bG-QF; Thu, 15 Feb 2024 08:03:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raVlt-000pjx-12; Thu, 15 Feb 2024 08:03:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raVls-005CTc-31;
	Thu, 15 Feb 2024 08:03:00 +0100
Date: Thu, 15 Feb 2024 08:03:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Doug Anderson <dianders@chromium.org>
Cc: linux-pwm@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Robert Foss <rfoss@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, kernel@pengutronix.de
Subject: Re: [PATCH v6 152/164] drm/bridge: ti-sn65dsi86: Make use of
 pwmchip_parent() accessor
Message-ID: <qh7v3e76vo4s6su4mtd4qjvbi7egpvsbzzkrpdfnnxabjwv7bj@ccmkhauli22y>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <10a8d55110fc48a4759e65cc19556858587e94cc.1707900770.git.u.kleine-koenig@pengutronix.de>
 <CAD=FV=WkJOd6P4f=j0BHfm+ZeHnCtMBXALDWVeypdcirSTQp1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3f2smuqkxhhnd2ar"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WkJOd6P4f=j0BHfm+ZeHnCtMBXALDWVeypdcirSTQp1A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--3f2smuqkxhhnd2ar
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Wed, Feb 14, 2024 at 12:44:23PM -0800, Doug Anderson wrote:
> On Wed, Feb 14, 2024 at 1:34=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > struct pwm_chip::dev is about to change. To not have to touch this
> > driver in the same commit as struct pwm_chip::dev, use the accessor
> > function provided for exactly this purpose.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> I don't see any differences from v5, so not sure why you didn't carry
> forward my Ack [1] on this one. Maybe because of the questions I
> asked? Your answers from v5 seemed fine to me. In any case:

Indeed, I should have kept the Ack. I cannot say why I dropped it,
something wrong on my end for sure as the patch ids match:

	$ v5=3D5ff5120f2b4ef6442a1d7c05916a772ec59a8c34.1706182805.git.u.kleine-ko=
enig@pengutronix.de
	$ v6=3D10a8d55110fc48a4759e65cc19556858587e94cc.1707900770.git.u.kleine-ko=
enig@pengutronix.de
	$ $ for v in $v5 $v6; do curl -s https://lore.kernel.org/all/$v/raw | git =
patch-id; done
	9b067a056fd203dd4b37d69b5aff202f42d970f1 000000000000000000000000000000000=
0000000
	9b067a056fd203dd4b37d69b5aff202f42d970f1 000000000000000000000000000000000=
0000000

Thanks for looking again, I readded your Ack,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3f2smuqkxhhnd2ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXNtyQACgkQj4D7WH0S
/k7LOgf+LalSJ4kgtkodt3LBnGz7X8mok71tGyvCncZ7AQjODVlcAexOxQRtgu+H
gGa1p3Yx1fzM0bDuCj7JrT5H5RXAb6PWzhEfkh753FhoIgLV4OIGrj4ubWKw5RkN
Tt6NbDgYDYGslhQdqI93dO1LtFB2EH9/u389gsPL9vYSafi5WEWaaI/tHcaPfjXJ
vZObGRxMYDB0lzthH+GzeULv85F+p0HVmgPw0fxlipPrdm4KybqKwepnV9HBgl8v
ONfIfzk4Gy9FfVesRLhOFUXh592TAAUQFzQ+VTL1xugkkIufL6jMPXwsqNDi2Id5
rZek/B/WzJzN/x131JVpbgfQx5ySgQ==
=8oXR
-----END PGP SIGNATURE-----

--3f2smuqkxhhnd2ar--

