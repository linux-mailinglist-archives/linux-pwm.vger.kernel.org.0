Return-Path: <linux-pwm+bounces-4468-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305279FB36F
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 18:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F9A1884230
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419D81B3953;
	Mon, 23 Dec 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJA5kof/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A313EFE3;
	Mon, 23 Dec 2024 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734973689; cv=none; b=e+xNrMtiBHNEFB3Asn4l+NT2sMD4r34MePd50LNu6cijdAONV0Du6WawnYiKSFZnQDVfYM+zFQHUKFLLBCZCjpbB53r9NX7cAlmYgmTk+cVW5VxXIOzO7opiiJxzGxVBymh9JuuG7p97ycQwN6ClVZJmXMsMfBoUMjuuNUcXkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734973689; c=relaxed/simple;
	bh=89VDeu9oFgDVlXL+0rBoLBwO/dCycL6SZlMCbf+/yng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/K21aV2gB967qx5d9G4IL/tZBsiHh0dk1J8c3a/vm7NXZSzrmVW3F9VCBQmpBWnYiQ2X+Z0LCC7AhINBo9yiF+pgFN7nvBKlIa9DaUehc12bOTFAtjzGBM9srJrkyuVdVFNgunHI5ZuARxKMZA5kgh59WhjFdc8E0JdGvxwK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJA5kof/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4A9C4CED3;
	Mon, 23 Dec 2024 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734973688;
	bh=89VDeu9oFgDVlXL+0rBoLBwO/dCycL6SZlMCbf+/yng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJA5kof/KmdL3pTPYK9D8gAv6XHYXrr9hE0P1P4lIncRrKpH4xWLAqKIJ1+ThNtFj
	 Ht/90hq1elAq7YPRwGobBKpfkr35jViKtEUOUUGLIwdF1Yw0LpQtQXBZ9evJowO0u2
	 +aTL6mE8rvK76LvG3cHiOJbFW3Ut2TmYPYh6xMgZ2/0XDP0Lop3ylDwez51SdbBAvr
	 ePjN4nqwN1MBykLPl9KX1HiBoiBwqUITCZ/dCQFTVMDIu09Ud67sz4e1TUEBAVi+l0
	 fj2TnFuaOH6MUsLo/1Z4hXecnmuszsK5ue7B2GOWyfjf2zQ1/6jwFLVa5ekaxJ4lXN
	 eW8xB3aEA46Zw==
Date: Mon, 23 Dec 2024 18:08:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: mfd: gpio: Add MAX7360
Message-ID: <khay2avbw6wixkyholctgxt67cycbnfovameyedrqutofcllqf@dbt4gbtxnyty>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-1-37a8d22c36ed@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zujw3nmwcxqain5d"
Content-Disposition: inline
In-Reply-To: <20241223-mdb-max7360-support-v2-1-37a8d22c36ed@bootlin.com>


--zujw3nmwcxqain5d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 1/7] dt-bindings: mfd: gpio: Add MAX7360
MIME-Version: 1.0

Hello,

just a nitpick I noticed, not a full review:

On Mon, Dec 23, 2024 at 05:42:33PM +0100, Mathieu Dubois-Briand wrote:
> +examples:
> +  - |
> +    gpio {
> +      compatible = "maxim,max7360-gpio";
> +
> +      gpio-controller;
> +      #gpio-cells = <0x2>;
> +      ngpios = <8>;
> +      maxim,constant-current-disable = <0x06>;
> +
> +      interrupt-controller;
> +      #interrupt-cells = <0x2>;
> +      };

I think s/  // in the line with the closing curly brace.

Best regards
Uwe

--zujw3nmwcxqain5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdpmPIACgkQj4D7WH0S
/k6t/AgAjOeY5BT9Ue9TUFwMmZUUE/dXEHVNMO48xtu9ZGHavD4ucZuYkFK4+kj2
x97TVouNB7wdpFMwU0aHYBPwOVUjPMUiaoJ8AMzr62ygJfgBPG6is3mny8PO1L2U
1/k0be76N4nl4ai0/UTWNE/nMrBGSa1bW09yIccjuf4Y0IAOTrgmw5Vkj3lb3T79
UWhmI1WPd+lWpUB5nHcXJG9mtmyWG0/2fwFu4VjII/Lf/MyrUFxy41uFIj5rDbdy
suK4d4cnkwnvmEwtEpGuY8MVawfnZWrZFrZo/zz3HA9vnifs7gE8L3DrVS7OeDm3
svJoEI+yr/uVO6cXQC2CAfLq8Ua0vA==
=NhC6
-----END PGP SIGNATURE-----

--zujw3nmwcxqain5d--

