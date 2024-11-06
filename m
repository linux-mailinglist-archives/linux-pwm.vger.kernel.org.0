Return-Path: <linux-pwm+bounces-4038-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5759BE543
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 12:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC29B2441A
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 11:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947A1DE4C9;
	Wed,  6 Nov 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPS9dy71"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3181DE3DF;
	Wed,  6 Nov 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891387; cv=none; b=E8ADmyrT0luMqRDYfxjEH3/5JMSWhDGwMGjeLTnvT6niBc1G3Z4a9C85ePWXWwDNBNMjOu/uPAZ78ND86Da3SuMcXTG6UImfj36+DBOudnHP4p7MeB4JMCIE5r2Y8iIIXRz7Wp+70riTesJKFenuQInDyaxDG+3vn9vaMoakVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891387; c=relaxed/simple;
	bh=IzLPv/DEFXlj5cNSZvHDLkVkwT3mFl5/VFrMn/bL8oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVWD05I9nehqYQsVqncSAV/xgbpfxiiIizyCBZlyB+Dl2yr5VUP4+Zw/4/YCqYuC+RUYRfQE9062dHpNUs1AMOl8KbRbwSjzZz5bsMuHEyQUBxdISc75mINxsVDtHPL983f8D4/EOsYMsgSH24kZVvky5TmM4HlwnT3C+DESpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPS9dy71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AC2C4CECD;
	Wed,  6 Nov 2024 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730891386;
	bh=IzLPv/DEFXlj5cNSZvHDLkVkwT3mFl5/VFrMn/bL8oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPS9dy71VX/WNblUBBvKE0IJ2I7Hi6mKUf8ltHGt7NLvUkMo+X7xMhPmgrMPAp1sE
	 oI5QQRZMBqWELl6ukQMN3/fjhEldNzdesRANfr+l2OCD7TWAnRj813CKLlluVcmq/O
	 czhI+p1xspLM9rCarM4UvPq6C78z1r9dAh6hEcKsa0aCoP1O0afIx4A6zF00YGFZb9
	 zTd5NEQh8bQTDC7fQ5BR0QBIFDgdVla/zEDC/mhqaCr1OUCna+eUKHaFQOcL//OsWG
	 5CxeZQNKDaXvPwC5aF+AlZDp+kQqp43IK5Zsh9UEQGmCR4agO+5T6UxDSzOhuCfAHo
	 dW8Xg4uKc95Qg==
Date: Wed, 6 Nov 2024 12:09:44 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: (subset) [PATCH v9 4/6] dt-bindings: mfd: Add support for Airoha
 EN7581 GPIO System Controller
Message-ID: <ZytOeOkeF9xW2DOV@lore-desk>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-4-afb0cbcab0ec@kernel.org>
 <173088099542.3237297.18018729158887853624.b4-ty@kernel.org>
 <ZyssJpR7xwbMzUsm@lore-desk>
 <20241106110046.GR1807686@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9VjFJ6tz3D5wTAI6"
Content-Disposition: inline
In-Reply-To: <20241106110046.GR1807686@google.com>


--9VjFJ6tz3D5wTAI6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 06, Lee Jones wrote:
> On Wed, 06 Nov 2024, Lorenzo Bianconi wrote:
>=20
> > On Nov 06, Lee Jones wrote:
> > > On Wed, 23 Oct 2024 01:20:04 +0200, Lorenzo Bianconi wrote:
> > > > Add support for Airoha EN7581 GPIO System Controller which provide a
> > > > register map for controlling the GPIO, pinctrl and PWM of the SoC v=
ia
> > > > dedicated pinctrl and pwm child nodes.
> > > >=20
> > > >=20
> > >=20
> > > Applied, thanks!
> > >=20
> > > [4/6] dt-bindings: mfd: Add support for Airoha EN7581 GPIO System Con=
troller
> > >       commit: f49f37f3cfe1482d4dc77d26f3e8c38eab630d52
> > >=20
> > > --
> > > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > >=20
> >=20
> > Hi Lee,
> >=20
> > according to my understanding this patch has been already applied by Li=
nus
> > here:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.gi=
t/commit/?h=3Ddevel&id=3D50dedb1eb1e6755ccab55f6140916c2d192be765
>=20
> An interesting choice.  Linus?

I guess Linus applied all binding patches to his tree since there is a
dependency between airoha,en7581-pwm.yaml/airoha,en7581-pinctrl.yaml
and airoha,en7581-gpio-sysctl.yaml.

Regards,
Lorenzo

>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

--9VjFJ6tz3D5wTAI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZytOeAAKCRA6cBh0uS2t
rAJKAQCziZ9I7pDgrsy7c4G4zSAJV33x5GtUnxzl90JJfuiDVwD+N3L3x58QswNA
Q6MdWbHpRsM5P2NQLRkMsNnq30wJNwE=
=IWqp
-----END PGP SIGNATURE-----

--9VjFJ6tz3D5wTAI6--

