Return-Path: <linux-pwm+bounces-6623-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BAAAEF189
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 10:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577BD4444E4
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B46D26CE3A;
	Tue,  1 Jul 2025 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbrk+GuU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3A26CE25;
	Tue,  1 Jul 2025 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359317; cv=none; b=Gz17DYSljIivTKVZRy+ZNi9ob3mX1eiQD4oprk/A8JILUNp8yUWeFZ+LAoP0Ws1Igw16PGtt+MQcfFlzV1U+z4xzJ8MFKJ1EvURJfzMscdPg7qeD7u/jLFvEnntpT3Q35bkMxV5T7k/HLn29p17vBQPDWpy7pO5w3KvKr7ityCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359317; c=relaxed/simple;
	bh=gXsGbgXpj8fmGdc/8VJiNnOiZbJG5HKDDpmrJCmwNr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFUJ+TwbkBNjjYEU+TNXL8IMutoepGb/PRWlFL5rSExMQE4QZ5JJdLpeyhu7h1A4AaqWsbFWw0f8cDNwp5rObG7kdzdOqkfGfOyqG4pCo/3bWmPNAd4Cq5/8fg1as56bH+60DPbWRb5uRL7qQ1Pn2PSOUCOW5JByN4tx0rtriHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbrk+GuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F328C4CEEB;
	Tue,  1 Jul 2025 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751359317;
	bh=gXsGbgXpj8fmGdc/8VJiNnOiZbJG5HKDDpmrJCmwNr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbrk+GuUMQv4y6HlgmAgS0CikEMFVdo2i5RyKiOWRBmuL6EJEtKxLp4QWBRmntHqR
	 s8DOVeW+aiNNJWMPoyVtSad3eFo3DWallorH1Z8tKynsv9TfNuQ1ZYlQw823Hk4uBq
	 qYoEOrM6cAofa1naq4qY8KdKmgUs2JP2oDse655IrYJkpJ/NqpSAu2O2p7YZ7j6ufD
	 4VP4qy81oc8Ops+HWCNW9UnPyPCzUt+6gINVXyZL9Zea1m1vuD009WaHTTjUHwqDiQ
	 YDpuGiwumjwZTUmut/i0Y1E2w8lVA8HQ1zO0h+AWSrht/uAprrFnQV9CxlH2Z+IJHE
	 oQqevLClcWQNw==
Date: Tue, 1 Jul 2025 10:41:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v6 17/20] Input: adp5589: remove the driver
Message-ID: <lhhoojlran4xq4tokh3tlxwv4dvf45jn7nqkbvzmzphdrqpwvn@g4dmhdxmoxcl>
References: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
 <20250630-dev-adp5589-fw-v6-17-a0f392a0ba91@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z6eouaflswv35lkm"
Content-Disposition: inline
In-Reply-To: <20250630-dev-adp5589-fw-v6-17-a0f392a0ba91@analog.com>


--z6eouaflswv35lkm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 17/20] Input: adp5589: remove the driver
MIME-Version: 1.0

On Mon, Jun 30, 2025 at 12:53:08PM +0100, Nuno S=E1 via B4 Relay wrote:
> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> The adp5589 support is based on legacy platform data and there's no
> upstream pataform using this device.

s/pataform/platform/ ?

> Moreover, recently, with
>=20
> commit
> 480a8ad683d7 ("mfd: adp5585: Add Analog Devices ADP5585 core support")
>=20
> we overlapped support for the adp5585 device (gpiochip part of it) but
> since it actually makes sense for the device to be supported under MFD, we
> can complement it and add the keymap support for it (properly based on FW
> properties). And that is what
>=20
> commit
> 04840c5363a6 ("Input: adp5585: Add Analog Devices ADP5585/89 support")
>=20
> is doing.

I personally would drop the newlines around (and in) the commit
reference.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> ---

Best regards
Uwe

--z6eouaflswv35lkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhjn1AACgkQj4D7WH0S
/k7zdQgAgQu444GmpdmAWHthl2ytJZxjT7pY7j0yVrVvD+309RjdTKERoOZHzJu5
ITAfDcGemMc1m6SFgsnvJIib+SLpg8ZZlGDnfbxzTPvzhQDtTOpPOkEt5/GDD5S8
MJKEq5xBOM140i22QczUetAVxJxOoaG7Eo5gLpYI2YMDrlw6+5bJgmn/BIE8hc6h
ZGK3aTC3zTCeF1Ysi5UzfkPzqW/xjVqLBPV53vr8PwNun0izAJjWj95C7qB50flI
Q6cqZ3rT2KYl6SVA5XK7z+2qfW7SBxst+lv4ztao+8MmUl1tcGtbY+blfi2ul8ou
VrY02XwftSYyr0Q8ENoGC3lRx5rIwQ==
=rZ0M
-----END PGP SIGNATURE-----

--z6eouaflswv35lkm--

