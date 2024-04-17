Return-Path: <linux-pwm+bounces-1991-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D798A848A
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 15:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D91A1F217D3
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAF13F454;
	Wed, 17 Apr 2024 13:26:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8A1422D5
	for <linux-pwm@vger.kernel.org>; Wed, 17 Apr 2024 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713360392; cv=none; b=ZvRO76b9xSYEXHcgZrG/KT6T99Q8NyHHEA8NOtKYpvzq+BKLQK5XeU4G6l/asNTHbW7mlhmbXu6Y2l5FJbj7Oiir8XJypQo7ArfZlif7932knWL4X0h1704JjiBUWhcmFzDBPuark3uc8h25ZNOQkTM6xT2fE727p8oYzPj9UYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713360392; c=relaxed/simple;
	bh=s8ny+TndcIJQgmcNzBMecyd/A5GThSZKfKRvzWKXkgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGAPKglkoAEFVP+xqz9t9E/AOzY4jYz3LlrxPjZlfwcvb5Y/YURI/LSGOvWJARjKLUfJnLAIG1UkPbY+iJw+rRx95XAVzztNf+v+7mhllZZD/Ysygd65TUSJbFlPQW24QVOJ4ptpyHqqgpt5lAswUdvWDRPyKhBID6OsQyt6PZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx5IP-0007GI-7I; Wed, 17 Apr 2024 15:25:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx5IM-00CnkN-Su; Wed, 17 Apr 2024 15:25:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx5IM-002rHj-2Y;
	Wed, 17 Apr 2024 15:25:50 +0200
Date: Wed, 17 Apr 2024 15:25:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Alexandre Mergnat <amergnat@baylibre.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 11/18] dt-bindings: pwm: mediatek,pwm-disp: add
 power-domains property
Message-ID: <5vqnkgp77tir5j5cumo62pm2cw4xjabexu7nk3kze4gk4ri5dn@g3pee2beuuco>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-11-33ce8864b227@baylibre.com>
 <1db01bd8-0936-40e5-9f1b-7ea34746bef1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2mhwzpvshnycjgzu"
Content-Disposition: inline
In-Reply-To: <1db01bd8-0936-40e5-9f1b-7ea34746bef1@collabora.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--2mhwzpvshnycjgzu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 17, 2024 at 12:19:19PM +0200, AngeloGioacchino Del Regno wrote:
> Il 16/04/24 17:53, Alexandre Mergnat ha scritto:
> > According to the Mediatek MT8365 datasheet, the display PWM block has
> > a power domain.
> >=20
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>=20
> It's the same for at least MT8195, MT8183 and I think MT8192 as well... so
> not having that from the beginning is actually a mistake.
>=20
> Please add a Fixes tag and resend, after which:
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

You mean similar to:

	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/?id=3Dfb7c3d8ba039df877886fd457538d8b24ca9c84b

? It seems someone you know well was quicker :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2mhwzpvshnycjgzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYfzd0ACgkQj4D7WH0S
/k644QgApZcXCwxXpE1GPvpexO/Vc5AFPTJkm7FRBnwJJkvRZ1ycT6cFchMCCuDk
54zNsJAXca62uylo+g0umyShBTdJtfK1/jrxOFPvuA+8sdm6j2zXdQGxrq2QozhU
52gFI/sNHpKkYT/ky/xaUHOpbw/BK8bc/6mkaCoKcZg3aB3U/lJsgIX1x9d/Uqo6
70f0ssIQn1KRrZj66GjL2o9m9A8aZ5shpR3TTBtnjw1/K6I2aAU7VUX4R5Uda7ol
bdrw0/GGO0IuYZ+q+F2LLbRTFE2oHy3ZzNQlJ8HBj2e160g1Mo+AQqfqcEwZe8C6
4qWjBjl/FQQtdEludY7c04KB7u+YSg==
=3M09
-----END PGP SIGNATURE-----

--2mhwzpvshnycjgzu--

