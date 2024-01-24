Return-Path: <linux-pwm+bounces-906-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC9383A469
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 09:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DF32816B4
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39317BA0;
	Wed, 24 Jan 2024 08:44:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBB17BA1
	for <linux-pwm@vger.kernel.org>; Wed, 24 Jan 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085841; cv=none; b=GEz2RXGhAgCrZJf4qvChjz3aXDQoWzd4CJMqFjSrIC3Rulo1nPpSbWXbHg2eHnwxrVsuewBeLqAl0q+eMJ0m7GdPktG5su7ElTs73g9rG8GHvIPIDlg1BZw8nkpETdvEExVqKcjyNKVhUjdR41bEdU6VXa1wQGC6cEBy+efkVHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085841; c=relaxed/simple;
	bh=s322rBPQa6bzA8+HCuSotTAk6gztBJc/8RjaCxcQ81o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAfgSjvytfqz77Q3hP+gXmLmA+60L2RIK4HDaf4gtyxcp/yTN8RDrtrfuOcm/TTBwNtrqj6ZIqIDZripHazuLiv7d1ab93KDMtlpxMol/VRcvQ5UMo4MeXvCddudWrQO1UHvGYzj5QlEWdjyARGSn0ROCd/COyPIqSvJibPR/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSYrU-0007b7-9M; Wed, 24 Jan 2024 09:43:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSYrR-00211Y-V7; Wed, 24 Jan 2024 09:43:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSYrR-006zr9-2i;
	Wed, 24 Jan 2024 09:43:53 +0100
Date: Wed, 24 Jan 2024 09:43:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>, Robert Foss <rfoss@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Alexander Shiyan <shc_work@mail.ru>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Bjorn Andersson <andersson@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Douglas Anderson <dianders@chromium.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	kernel@pengutronix.de, Benson Leung <bleung@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/5] pwm: Some improvements around .of_xlate()
Message-ID: <66laypnixxg6pvl6keu3zwyzppw4iwbvz2g32euoypymiwqcmv@2pohr23hceg7>
References: <cover.1704835845.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qevj6uqvskaa6zqk"
Content-Disposition: inline
In-Reply-To: <cover.1704835845.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--qevj6uqvskaa6zqk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 09, 2024 at 10:34:30PM +0100, Uwe Kleine-K=F6nig wrote:
> the first patch is a fix for an out-of-bounds access and so should
> probably go in quickly. The other changes are merge window material.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (5):
>   pwm: Fix out-of-bounds access in of_pwm_single_xlate()
>   pwm: Drop useless member .of_pwm_n_cells of struct pwm_chip
>   pwm: Let the of_xlate callbacks accept references without period
>   pwm: clps711x: Drop custom .of_xlate() callback
>   pwm: Drop duplicate check against chip->npwm in
>     of_pwm_xlate_with_flags()
>=20
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c |  1 -
>  drivers/pwm/core.c                    | 45 +++++++--------------------
>  drivers/pwm/pwm-clps711x.c            | 11 -------
>  drivers/pwm/pwm-cros-ec.c             |  1 -
>  drivers/pwm/pwm-pxa.c                 |  4 +--
>  include/linux/pwm.h                   |  2 --
>  6 files changed, 13 insertions(+), 51 deletions(-)

The first patch is already contained in v6.8-rc1, I applied the
remaining 4 patches to my repo at

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qevj6uqvskaa6zqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWwzcgACgkQj4D7WH0S
/k6o0Qf/djY3orpg33cVxhojPEMtT+5dcT6rmUISLQymmg8t8lQqt4D+oSPu8m6i
OV6XRXMgJSKWE5TaJzPWPxQp36cKBKPmFZXoZzQD09l58GdUCTFo/3tQtUd0UJfu
BhmcfecJH+o3G8JTDqy849FCfn/fsDtbkAPjmPMJHR+aZ/H5bP3pj8O3xLRk3Qu/
bH5P/VxDTvPTBJO8Z5DfcZzU4P0p4Ah24HDorvMyV3cxzIHrmLVsrCRmkigpnASq
9yq5F5NDraP/Xta9KhFG3Vtl+69M7DfzvtFIFvZ6CXdqkDCVqf5dy6/Gv/a6Z7Vs
9ppJ7q/IyMgYZ0gaEHgOOArCw7FILA==
=xzTn
-----END PGP SIGNATURE-----

--qevj6uqvskaa6zqk--

