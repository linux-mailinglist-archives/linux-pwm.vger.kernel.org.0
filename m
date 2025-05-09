Return-Path: <linux-pwm+bounces-5852-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482DAB0B13
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 08:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA887501E58
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC41826F44B;
	Fri,  9 May 2025 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHTqWuh6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20CB26E16A;
	Fri,  9 May 2025 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746773993; cv=none; b=o8MMedVv+agWN0Wh2TQ2nk9czmMqWTT7g2CQ1TIMbypfQlprdwjyoe6wY3NNaW0T9q/sg8HZHfJjmrVEWLxmPrrHfwobZyJ2PCPJSaSis2v6OfzHiDi0qmBDrbzobf4toBa32ffEgee2/sfYqUgk9t2JM+kmOTT3E9nKVPyQxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746773993; c=relaxed/simple;
	bh=TMk6/4Iu00NGP6c5Ik9rgnUjyn07FN6XHJmqMsg3qDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbCehdCF35O0xnxvdpUO6iyfkpX7bQenJkV1KozEg3AOkLYMukQB9r6OpPZxkSHy2IN1P9tT88Uz8PpgYk97wVPvq4E6mC0ZokaOnvyk8+STIy0Aq8DJgv5ZSpyq0v7l9QRuTtnWt1g9lA375+bPn1Nva4D/iWu1zxk5QAKcvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHTqWuh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BB5C4CEED;
	Fri,  9 May 2025 06:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746773993;
	bh=TMk6/4Iu00NGP6c5Ik9rgnUjyn07FN6XHJmqMsg3qDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHTqWuh6iV54bKrnYXfbPUXGYpvIaRdhKMjZd6kqpBRSDrvyGNkzGlXcmveePKRmh
	 YfvmY0fLxMkV3+2QDoB33Qqwi0RMdwVqRnqJp3sAz0oJy+IaimL+mk7DT8Evk4KrbE
	 rKCCveroVHcLPxZelk7yRRwY76U4vt1V/T3zs0HnIIRfU7lHKhmz/w1bWeWdv7nYwJ
	 1OhhjPak1cZ/mwERaakHd36+vQRl4Y+pmtq+km71McQh/ZyYLAZwGlinvTV7dqcueU
	 y4D1brGirJaFKjAZA7ylBnIYC9/wHU0Bv/X7fkQ54G3vcOzop6GGS5LOtidQbaEvi9
	 TBeHPqJulHcnQ==
Date: Fri, 9 May 2025 08:59:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] pwm: tidyup PWM menu for Renesas
Message-ID: <7vsimju2qa5oa7bnvkqhopmx7dmto5luxz6jjugdwiifa6nhyp@sz7gff3egqps>
References: <87r00ypt81.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cnp5fm7zpaqz6pru"
Content-Disposition: inline
In-Reply-To: <87r00ypt81.wl-kuninori.morimoto.gx@renesas.com>


--cnp5fm7zpaqz6pru
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: tidyup PWM menu for Renesas
MIME-Version: 1.0

Hello,

I like this change much better, just one comment below:

On Thu, May 08, 2025 at 11:39:58PM +0000, Kuninori Morimoto wrote:
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16d..cd4a034061e77 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -510,7 +510,7 @@ config PWM_RASPBERRYPI_POE
>  	  Enable Raspberry Pi firmware controller PWM bus used to control the
>  	  official RPI PoE hat
> =20
> -config PWM_RCAR
> +config PWM_RENESAS_RCAR
>  	tristate "Renesas R-Car PWM support"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on HAS_IOMEM
> @@ -532,15 +532,7 @@ config PWM_RENESAS_TPU
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-renesas-tpu.
> =20
> -config PWM_ROCKCHIP
> -	tristate "Rockchip PWM support"
> -	depends on ARCH_ROCKCHIP || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  Generic PWM framework driver for the PWM controller found on
> -	  Rockchip SoCs.
> -
> -config PWM_RZ_MTU3
> +config PWM_RENESAS_RZ_MTU3
>  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
>  	depends on RZ_MTU3
>  	depends on HAS_IOMEM
> @@ -551,6 +543,14 @@ config PWM_RZ_MTU3
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-rz-mtu3.

PWM_RENESAS_RZ_MTU3 sorts before PWM_RENESAS_TPU.

Best regards
Uwe

--cnp5fm7zpaqz6pru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgdp+QACgkQj4D7WH0S
/k4CZAf/XLfHRw54B0pAtNGbuGw+N5k5w9iKXrtGWIcjCQaYa1gldcCG1qKE/d7U
ilStzplSdKyBSDLFayz5zRdpCjXEm3nDawWePylbDd15leaBy7OFRJFnaNd5rW99
Ko8BJ5m5SHw3LX6rP1mtuGvn43D4l7H8QItUT+4wqL7sZD1SMQiueR5VJ6KOScg4
qSfJtt9Wh7d4sEoijuT8mGO7Jzx4UACozAh/XtB0kVe2mTJknI9r5UQqS3D/3cUS
dBNWY+/A7xQrwpPAtsMnROxQgv8fG/IQBaA2hHIMxFwDcLlxtSmv7ux5P19L3V/x
iiN2qGEAnqnIfpugkIYm8eIOc1M9Hw==
=zU3Z
-----END PGP SIGNATURE-----

--cnp5fm7zpaqz6pru--

