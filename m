Return-Path: <linux-pwm+bounces-1973-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52A8A7DA8
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 10:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BB0284861
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F077F13;
	Wed, 17 Apr 2024 08:02:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC676402
	for <linux-pwm@vger.kernel.org>; Wed, 17 Apr 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340939; cv=none; b=ebfqMQGUlcZGvHm5zbOoL0y1He0JUqUHGr0K24GZR+xgQZjqp049ax4sWZclQVXVDsb8BKEK4Y+taUJ/rP/q3ObO4uAEN3pcU6t7kh+JsF+whOcfiWLPAbeozJen9i7XHjVkeNm5Hs7YfwnnTJxD89FE1Kh7rVAjO/SJMlzsgdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340939; c=relaxed/simple;
	bh=xqgbBAr+qzpE6aT45CzHZDH1fguOizphFrZG7Cgilg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqEoIoX20aAaOV+Ayj7nD5Vo7DdVqkzaounCoR9+h9cz/iAB50SE1O97+7i6yMZFqXfQFnZeESEs8lbuS++aVe/FRibfO46s4ep44E8jQC54Xh9XJmqtc4jJ0uYyuzdHUeEzdU2ODGPTF9o04qlUkQ+jlUSatBV0AdoOQGO0Oag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0EY-0001q9-4l; Wed, 17 Apr 2024 10:01:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0EW-00CkmG-Qv; Wed, 17 Apr 2024 10:01:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0EW-002e73-2K;
	Wed, 17 Apr 2024 10:01:32 +0200
Date: Wed, 17 Apr 2024 10:01:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 11/18] dt-bindings: pwm: mediatek,pwm-disp: add
 power-domains property
Message-ID: <22yeoik77sdhmg43odjftzjn2douq74zhxwy6qx3hsrvr53r5e@7w3f3zbgxult>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-11-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yebn7lkzwjt2edcd"
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-11-33ce8864b227@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--yebn7lkzwjt2edcd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 16, 2024 at 05:53:12PM +0200, Alexandre Mergnat wrote:
> According to the Mediatek MT8365 datasheet, the display PWM block has
> a power domain.
>=20
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

I already pointed that out in reply to the cover letter, so just to make
it more easily to spot for people considering to apply this patch:

This is already fixed in next.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yebn7lkzwjt2edcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYfgdsACgkQj4D7WH0S
/k6aiQf8DDht8BJdwLA/chC/kqidSgtlv6qxFC1XbFLhIfSvyp8eqaLoaQk+lLDt
9WdQ2VOkHggnHje1S9Gj34fqnvGuJZcZkOnlXI7z6T19ngA1JzvAiKWtVuZbV6bC
Co9nKH9suzuEmBXk3SXdR2WILBaYxqP2UxfZ05BW26JCB+5JKxIMUH0c2tBKP5l3
3LmMOO36eJ95y3iHp8Q8I93qPZDYJhXDkFPehtepPzK30J3XeLct+6tQZUHAzyeP
BBLmoTFgotLZLsDeBpfMlGlgFKqibDM72G/Fh0vVgR1qCRUKFpiE6/xipzch5F3d
IbSttwKcXx3F0YSgQjx223hlA4c2yg==
=1L1v
-----END PGP SIGNATURE-----

--yebn7lkzwjt2edcd--

