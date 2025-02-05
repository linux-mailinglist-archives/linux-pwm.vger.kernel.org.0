Return-Path: <linux-pwm+bounces-4790-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6CEA29913
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 19:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5377A165733
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C041FECBD;
	Wed,  5 Feb 2025 18:28:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6808211A0B;
	Wed,  5 Feb 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780120; cv=none; b=qJGeh6oD+YhBFlyRUW5aMVMSzEsMhita/vzL4YrTtR+Vxo9SoJIARKgmQ9xzSVd5qxSJzKwW6J3CYmfdcznGMqq3g2vXjQ2Jwi0Ra0Kyhb9VtADDCXHqSspS4+ntnNPw3gecrW17Esp9xsQ/eobML4uUXuVtXosz6CCb/J3Mefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780120; c=relaxed/simple;
	bh=V1KvqEekI6n0A5vDzT+2qWrO7ACO3vGWNpHxLhdYSd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUPQFt0XC5c2xYopfmdzLjZqpvXXiv171/4HKFLE+2QvbWQDumatdkNp/nNGEP39BdeM0jx/uYdo4a/MC0aaKsmhsmdrCdN3CPAAP4/7CNMsprEdHXt/pWOoogm74p/0jQXB1SiNKZONSGmQQpdAgY0UvKi3U8cbEwIz7ZfhGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id B067D82216;
	Wed,  5 Feb 2025 19:21:12 +0100 (CET)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: =?UTF-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] pwm: pxa: Use #pwm-cells = <3>
Date: Wed, 05 Feb 2025 19:19:46 +0100
Message-ID: <2769312.mvXUDI8C0e@radijator>
In-Reply-To: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
References: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=duje.mihanovic@skole.hr;
 keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KER
 1amUgTWloYW5vdmnEhyA8ZHVqZUBkdWplbWloYW5vdmljLnh5ej6ImQQTFgoAQRYhBG3/QdYN8x
 S1t2umMK0xk1JFj60DBQJmiSHOAhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAA
 AoJEK0xk1JFj60D1GABAJVSorZdMOlrp/oQtCSH/G53NE56x/JHA8VX+ZQBd/H3AP4/EcUf6eef
 DUxVMh2bdkmuQKsVZGgOGiXpMksrVntWBrQpRHVqZSBNaWhhbm92acSHIDxkdWplLm1paGFub3Z
 pY0Bza29sZS5ocj6ImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSH/AhsDBQkJZg
 GABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw8A/i4lPOL7NaYoYePDq
 l8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xqh2MRcNmJCHA1YhWAbg4
 BGaJIc4SCisGAQQBl1UBBQEBB0DEc9JeA55OlZfWKgvmRgw6a/EpBQ8mDl6nQTBmnd1XHAMBCAe
 IfgQYFgoAJhYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSHOAhsMBQkJZgGAAAoJEK0xk1JFj6
 0DG5MA/iuo4l2GDEZ1Zf+XaS//8FwdXDO9nHkfbV2MHjF4NZXwAQDroMzBdMcqVvc8GABFlTTgG
 j7KrRDz2HwWNyF8ZeprAQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday 5 February 2025 18:53:59 Central European Standard Time Uwe=20
Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this series' goal is to soften the special device-tree binding of
> marvel,pxa-pwm devices. This is the only binding that doesn't pass the
> line index as first parameter.
>=20
> Here the #pwm-cells value is bumped from 1 to 3, keeping compatibility
> with the old binding.
>=20
> The motivation for this was that Herv=C3=A9 sent a patch introducing pwm
> nexus nodes which don't work nicely with the marvel,pxa-pwm
> particularities.
>=20
> For merging this series (assuming device-tree and pxa maintainers agree)
> I guess keeping the patches together makes sense because with the 2nd
> patch applied but without the 3rd there are a few dt-checker warnings.
>=20
> So I suggest to take it via my pwm tree as I guess drivers/pwm/core.c
> has more potential for a conflict than arch/arm/boot/dts/intel/pxa.
> So please send Acks and tell me if you would need an immutable branch
> for pulling into the PXA tree.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (3):
>   pwm: Add upgrade path to #pwm-cells =3D <3> for users of
>     of_pwm_single_xlate()
>   dt-bindings: pwm: marvell,pxa-pwm: Update to use #pwm-cells =3D <3>
>   ARM: dts: pxa: Use #pwm-cells =3D <3> for marvell,pxa-pwm devices
>=20
>  .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml |  3 +--
>  arch/arm/boot/dts/intel/pxa/pxa25x.dtsi          |  4 ++--
>  arch/arm/boot/dts/intel/pxa/pxa27x.dtsi          |  8 ++++----
>  .../dts/intel/pxa/pxa300-raumfeld-controller.dts |  2 +-
>  arch/arm/boot/dts/intel/pxa/pxa3xx.dtsi          |  8 ++++----
>  drivers/pwm/core.c                               | 16 ++++++++++++++++
>  6 files changed, 28 insertions(+), 13 deletions(-)
>=20
>=20
> base-commit: c98e66144b7d07ee9a3ca8241123b628a8ac0288

=46or the whole series:

Tested-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Regards,
=2D-=20
Duje




