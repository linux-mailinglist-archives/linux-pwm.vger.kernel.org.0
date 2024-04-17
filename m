Return-Path: <linux-pwm+bounces-1972-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC518A7D8B
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 09:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4AC1F22834
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Apr 2024 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158CB745C3;
	Wed, 17 Apr 2024 07:59:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B573199
	for <linux-pwm@vger.kernel.org>; Wed, 17 Apr 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340740; cv=none; b=RwUDLIMM46PXEAVVP1IaITH26hMBssC36uUi3vNAUHrTkfIeW3Y88djGKy86WBJNhSqO+WMCWMYethooLVsYvs2y1tv0DfjZIMw5bZvAsQLbbqYELeesJmnK60yEyIS5qnz1DT6jzOsQIQ8w9vrw0wIpE4a/rhZvO1CgSae3ZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340740; c=relaxed/simple;
	bh=BO46pDitPo9UhofMMhsVMtjn6zQdsVT57wd1UvRoqQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvbhOi9feZ6bKPeIhX9jzw+pNe5m8HdnRqjjF+jFlqcsxwMF5dPzKppPb7TvjJ1M9etqp438kDsU/gF2hmJT/ZqAIxG9IMvaVJyhWQkWpps4X2sZdhYotOfOYPo5Suzp12eIxrlX0L6jjbdypsLmtC8CmEYM+kVg5e/5LETPlnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0BW-0006cy-IA; Wed, 17 Apr 2024 09:58:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0BU-00Ckm6-DJ; Wed, 17 Apr 2024 09:58:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0BU-002e2n-0y;
	Wed, 17 Apr 2024 09:58:24 +0200
Date: Wed, 17 Apr 2024 09:58:24 +0200
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
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
	Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v2 00/18] Add display support for the MT8365-EVK board
Message-ID: <afetelidcystq4avtmfcvf6h4l5zdthwozwbhjica6jjybkiln@oxx2fqk65psx>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nkhfub2sueyozzkj"
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--nkhfub2sueyozzkj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 16, 2024 at 05:53:01PM +0200, Alexandre Mergnat wrote:
> Alexandre Mergnat (16):
>       [...]
>       dt-bindings: pwm: mediatek,pwm-disp: add power-domains property
>       dt-bindings: pwm: mediatek,pwm-disp: add compatible for mt8365 SoC
> [...]
> base-commit: 890c94ce8a456aa4d7ead5f5fd2603b98dfe7b7e
> change-id: 20231023-display-support-c6418b30e419

I cannot find 890c94ce8a456aa4d7ead5f5fd2603b98dfe7b7e, neither in next
nor in stable nor in drm-misc nor in Linus' repository.

For sure it's not based on next, because otherwise you'd have noticed
that the power-domains property is already documented there. (Currently
as fb7c3d8ba039df877886fd457538d8b24ca9c84b.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nkhfub2sueyozzkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYfgR8ACgkQj4D7WH0S
/k7mIQf+PbzquhwUkWhMaS47IM1H6SK1o8TJsEIaR6wb6Yy4bRV+XUEXe+POTalM
BhknR+V0xm/DcBuQivWKRYfDF/jZUJ/DZ60ila73u0xZRbJhLQLY27RNP/URC3uj
OdBwmD7H6JXYaFs1Rb0oYIyl8lpNtoIJIBDqh/tO7sXYWZtXTr6SXQeEPdhuPn3U
mhZhnfOgESFdC6P41I2AP/MJ/lxTo+k8l0rZ7iD1TiimDtziKX/uH/bPNr/NVS7D
qcL/ItrLaC0O7HA8uuUjxTIpbkPRPKFQKYrCYo0FzOYwv78RwW3qu4bVofMmbx1u
JAVxhSAOAKBafJzgDfONyOIB6du9XA==
=C88w
-----END PGP SIGNATURE-----

--nkhfub2sueyozzkj--

