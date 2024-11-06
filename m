Return-Path: <linux-pwm+bounces-4035-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E008D9BE13E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 09:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9798D1F24575
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6DA1D61B9;
	Wed,  6 Nov 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRAecVAd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17551917CD;
	Wed,  6 Nov 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882602; cv=none; b=KolPzaU3yC/fsmiZ5KqQ7n8Ar0+Bu/a7wrsG2Wh+muKMHOwWmFB6p6eC8xHcsCghafx/t1dj8YFKjD7eYnEQq9ju18NmziTaWMqmWxlgHezNtHs06hx/3UEaO+RjjyT7yxnA7lZSj5wSmtH+8nekVTSQYs06fggKEqnci/6meoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882602; c=relaxed/simple;
	bh=w49LxhkG70KI0gN8j5DWZTrcBdUddq9fKfZsQP4gzwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFqBbuZyDgLGrdM5vALIdbKuSK4+IkEDp4aUqLS3z4j10E6DtM+7Ol7L1/79hrDwbZTtwi7CdcpDRvWkOUbgyj5FHqGExjogGJsBlX3/MOLVwI23aS7U3JmjhJh5C0gz775G8lG0txJcIzuBj4AArZBQZ4iPCLDy+CwMEV8kj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRAecVAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED581C4CECD;
	Wed,  6 Nov 2024 08:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730882601;
	bh=w49LxhkG70KI0gN8j5DWZTrcBdUddq9fKfZsQP4gzwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRAecVAd+Flufp11ATsduPALAzLfhE0vyh0tPWoZSNODge6Bf9LOEx341C/TvSAMy
	 t17nWcjztEyKHgN9Gy4kG+/FEMqQPHMYqml0GSPUpps0qfohsdB8yeCO0Q6dIvzQAn
	 afjWi/fP7ggEq5QpRRBBVbpG1tKd8Ge7u+nIJ5Ii30gmdyuYsvg+qJTQUVqN7vD6zc
	 MiT2prpxIH3JI91PRlgys73btYLX7KU/CVRYmyZX9y81BtCQKVbyIMSYcdotiv62lf
	 wMeKgr7MTAU72r5gUUy+07Btq52PNJoh3OvU7WTMuxEcnwrVK9/9TetIW9kgqMtXhS
	 6Kxq29TQ+6ovA==
Date: Wed, 6 Nov 2024 09:43:18 +0100
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
Message-ID: <ZyssJpR7xwbMzUsm@lore-desk>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-4-afb0cbcab0ec@kernel.org>
 <173088099542.3237297.18018729158887853624.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wx+Mvx1qg95x0q+u"
Content-Disposition: inline
In-Reply-To: <173088099542.3237297.18018729158887853624.b4-ty@kernel.org>


--Wx+Mvx1qg95x0q+u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 06, Lee Jones wrote:
> On Wed, 23 Oct 2024 01:20:04 +0200, Lorenzo Bianconi wrote:
> > Add support for Airoha EN7581 GPIO System Controller which provide a
> > register map for controlling the GPIO, pinctrl and PWM of the SoC via
> > dedicated pinctrl and pwm child nodes.
> >=20
> >=20
>=20
> Applied, thanks!
>=20
> [4/6] dt-bindings: mfd: Add support for Airoha EN7581 GPIO System Control=
ler
>       commit: f49f37f3cfe1482d4dc77d26f3e8c38eab630d52
>=20
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>=20

Hi Lee,

according to my understanding this patch has been already applied by Linus
here:

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/co=
mmit/?h=3Ddevel&id=3D50dedb1eb1e6755ccab55f6140916c2d192be765

Regards,
Lorenzo

--Wx+Mvx1qg95x0q+u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZyssJgAKCRA6cBh0uS2t
rBX2AP432eJMkZH/0I6xMefXrLL+NeoxIDMS0/hQjMIv70LhngD/VPpbBXZM0k6S
cxO57ypvUMPKaDRXdqx6g7gGZKJ6KAU=
=+WZo
-----END PGP SIGNATURE-----

--Wx+Mvx1qg95x0q+u--

