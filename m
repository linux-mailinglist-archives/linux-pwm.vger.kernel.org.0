Return-Path: <linux-pwm+bounces-4414-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCEA9F875F
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 22:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EDB16F3E4
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5851C5CC5;
	Thu, 19 Dec 2024 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVfFP/jJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A348F6D;
	Thu, 19 Dec 2024 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734645283; cv=none; b=OBHryjJe79WSu/1SM3wsXyn+U0t7t6Lj/cpNJLJJFarhlRABwvUIfPKA+Mm4cNbs9kIcijtFZK3ihKYqqffUMFlSLLdquREajyBG3+QbZ9t26NrM5SErCB0O/XLGn9On/Bby2yow6jPrNsu3R/lBipNYWut2yC8/ZCbOhdp8QJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734645283; c=relaxed/simple;
	bh=pl79TnXi+xs9ggOuLN30MeeJ5PViiqDkhUUH65BGAfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPFTiG+1gq7mi24kxwuwZd/G99GTAdWDdcIvrYEx3L5MU0XWU837uITfe1xs5BEiwvMYWXR1zSfr5Rd126EvCN6Oxh1X7+c/9hPXNFjN+rBsPy+AWSK/KjuTLRPW7UFCZJRVYAtoipwSHjVGHq/ylv4zMhOYL4frvOYhszYcJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVfFP/jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A25C4CECE;
	Thu, 19 Dec 2024 21:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734645282;
	bh=pl79TnXi+xs9ggOuLN30MeeJ5PViiqDkhUUH65BGAfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVfFP/jJZ2jWhd35t65hNDr02ts7JFxdwSDSbcRUyDvX/v5qBMDvSZ7ybNyyTyTrS
	 sqMu2RWUC2r+gyRQqobHDl+akjtTVhJFk3AMwNOndYw1OIIKCHWEL0bZqLXOV8YZiG
	 2MblayTxpoaVg4DlklkI91+xQeiYOLeC5xUNl+iyItcJo8+Dr7g/MqCHbPCXWyKI7Q
	 WXfgSwzC8sr4gYu3rvYalLfC8GoGX4IAB78pOhARfFKPTgH5OTFN1584XoxifcCzD0
	 9msXtEfdX7k+RvG4FDnBpg0U2qIVuo90sYLBp6maPfW9kvzc60pbiOBbr2w5/xTfVE
	 zVaHxpHtEdxKQ==
Date: Thu, 19 Dec 2024 22:54:39 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/8] dt-bindings: Add MAX7360 subdevices
Message-ID: <owca553wbjaiueh3z2yughwctt3x2d7i63f6a5o72q2bfqwvhk@yckfhmmbnfdu>
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
 <20241219-mdb-max7360-support-v1-2-8e8317584121@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uhklylmhaxwvv2dl"
Content-Disposition: inline
In-Reply-To: <20241219-mdb-max7360-support-v1-2-8e8317584121@bootlin.com>


--uhklylmhaxwvv2dl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/8] dt-bindings: Add MAX7360 subdevices
MIME-Version: 1.0

Hello,

On Thu, Dec 19, 2024 at 05:21:19PM +0100, Mathieu Dubois-Briand wrote:
> diff --git a/Documentation/devicetree/bindings/pwm/max7360-pwm.yaml b/Documentation/devicetree/bindings/pwm/max7360-pwm.yaml
> new file mode 100644
> index 000000000000..68d48969e542
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/max7360-pwm.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/max7360-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX7360 PWM controller
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +
> +description: |
> +  Maxim MAX7360 PWM controller, in MAX7360 MFD
> +  https://www.analog.com/en/products/max7360.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360-pwm
> +
> +  "#pwm-cells":
> +    const: 2

Please make this 3.

> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    max7360_pwm: max7360_pwm {
> +      compatible = "maxim,max7360-pwm";
> +      #pwm-cells = <2>;
> +    };

--uhklylmhaxwvv2dl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdklhwACgkQj4D7WH0S
/k74Dgf+MIDkC0sqLPqyLd4ZhjJFxjMd5mm9NuoT6esrNYYgJxEo2FCECnavVVp0
wKgwiqTl7hrlb1CgjBqgSKrt1sbEtaZz8zJABuSyUNvYj+4ghDThHVQW6J9P+Cuo
Sj8O+f42wiyta+DNitMUE55jKw0IurxCK/uoho9SBfgNTrfnyDvSUMMtPjb2Oj4s
Q2L+v4klIPTbHOzwG51quC1vx06CNRiGmmJlLmJ+qKyVi1om2yzllQIJICuSk1W4
YCpNkCglTKYUo2q4oedV7SuSZvITB1asHjlbSLn8Pyy9P6ld5tYNni0HIfiNAbmW
PvhfBiUBiu6JykwUJI9feWWIRJKqPg==
=CQZS
-----END PGP SIGNATURE-----

--uhklylmhaxwvv2dl--

