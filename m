Return-Path: <linux-pwm+bounces-6025-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BFEABC436
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4EF7B1272
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F8A289343;
	Mon, 19 May 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKRf2Wwl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7528850B;
	Mon, 19 May 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671079; cv=none; b=qcvpZUoclrDtwuxrxnP4Q/YNPEszs5c5m3dpBQgNnFnXCDJcWmi2PUhv3lNbNimjN+VaZTYHGVPkPmfITvD06r0mLA4U1Q29TfLIBK1tc5woyEksnhv+3GJz/PAnldnuXG2JcivgmwJiZupY2E36W2oyfiF/h3swh9S5AI8kFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671079; c=relaxed/simple;
	bh=/6hDOx38+FGxkUeFC3f5N5ACgq2V3ezpi96vcKcJdX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAaoRo4OzZWEjmKmu1rWZa+vi3iyVT7fpopox6LxYzvvwh8gdFl+30iSAueo+Ca1k/6IuNg0N4vG4oCYZaotXaNTLYtWnb0o9EFHh/hCf/rKFQV6eYzWcFPQ63W9LOHmLYVaOCERUroj9C9863yng1sU+odTbLmhubyu+kmJTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKRf2Wwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68156C4CEE4;
	Mon, 19 May 2025 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747671079;
	bh=/6hDOx38+FGxkUeFC3f5N5ACgq2V3ezpi96vcKcJdX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKRf2Wwl7bpcp9pVcyY5ZheNAeNSzdDIRtptozowjy+s8+zFLqb5u2tFlKZTEQHeR
	 WOF73Bb8GqMhrYCSdXNNzVeSHfRyAriWlUyrypJpvk+u7UhuUlfJIUHvCINmBW0ODC
	 ZbhpnOTEdCbiLT6srgMlyCOhzVkjpiP7WWAH/8OlyKlA4Df59LOvKtofSBvpf5Fq70
	 4MxvSsUb6zaxyCzFa+xEL9BlJrcM9ZDaENTIaQPhxnqVyBSeMVYS46DZfUsnwR2A4Z
	 oECy0nh9e19/kcb8eaMrGnU63Ns2kEghWv52qGAJggpoxdxpf99kj72BzR6p5tDZ0D
	 KTKSN+b9qHUeQ==
Date: Mon, 19 May 2025 18:11:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 22/22] pwm: adp5585: make sure to include
 mod_devicetable.h
Message-ID: <gfrckmiyfo3rnvhnryptcwtwlu37aaga22onpra2yteelwl3zq@b6zaszmd4axp>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-22-092b14b79a88@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6hy34zawwyv3ya4"
Content-Disposition: inline
In-Reply-To: <20250512-dev-adp5589-fw-v3-22-092b14b79a88@analog.com>


--m6hy34zawwyv3ya4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 22/22] pwm: adp5585: make sure to include
 mod_devicetable.h
MIME-Version: 1.0

Hello Nuno,

On Mon, May 12, 2025 at 01:39:14PM +0100, Nuno S=E1 via B4 Relay wrote:
> From: Nuno S=E1 <nuno.sa@analog.com>
>=20
> Explicitly include mod_devicetable.h for struct platform_device_id.
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> ---
>  drivers/pwm/pwm-adp5585.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> index f26054c19c2e154d05780af09aee1b2431eba2eb..93d0294d048abfe1a00916102=
5e658b58b669cd9 100644
> --- a/drivers/pwm/pwm-adp5585.c
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -20,6 +20,7 @@
>  #include <linux/mfd/adp5585.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>

This looks relevant for the current state of the driver in mainline and
doesn't depend on other patches in the series.

I applied it to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

and so it should be included in the next next.

Thanks
Uwe

--m6hy34zawwyv3ya4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgrWB4ACgkQj4D7WH0S
/k5yNwf8C6QiKMsJxp9zTuniJkcjoLSZ5Jytz5aCeTjzcZH29Rh1ua/z561fshlh
b6whXP/++JBcqFvNSlUF0zW0DqOWMV1wDeHg3O97Queo/Wa4wIx9bT4/Uf1p6mxV
1Zp58mtsY92M+HDlpbLNYum8FPo5KPQpqOqod9xpWXjnElKWNr4oHNQPNKFkQ04p
5hL+KhsiQ+nPvdu6FMSoyNkNzAnaINVzgMbNmLGuI/cG0WEYakqDTt7TUEH6ROgG
BIyvs2vP1NbVEE55zhHO09SxJOYBwL/wwUnMsQCpKwsM2BNooCoei5DEz+9ihhuY
TNOdbbO0I7TWYM9WIoplCswocI5ltA==
=Qp+H
-----END PGP SIGNATURE-----

--m6hy34zawwyv3ya4--

