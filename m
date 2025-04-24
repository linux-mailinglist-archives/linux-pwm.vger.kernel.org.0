Return-Path: <linux-pwm+bounces-5688-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D9BA9A5A2
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 10:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A8F1B83FAA
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 08:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0444205AB8;
	Thu, 24 Apr 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTBJb7/s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E207D529;
	Thu, 24 Apr 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482731; cv=none; b=dooVYtbaMdwtMVxuH3M81tbIZUm4SYRujNBzsLwgmIDEW7XhfdAF4/Hd2l1vVOT42vIA39HwTzuGvNlEfCVvBeQ/ezwSPjUYex0BsG11EEE5jq8Xlk+TYe50l6OidQhm1AsLUGPed+VDXjdCCBkdjIHm9lsoiSFrqar6C6U7zAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482731; c=relaxed/simple;
	bh=luBO6reS1AIHdLD0ocQc2V2sYxCZNmU96oc6vvsTJUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV+55cf7NDgcwQ5FJOC6zAaLvH4Ms50fdYpklfyrbZzuC+ZCRgNFevx6b1XtbZTyYUb5RyD67ruv2f1ufpAPuz/UMvj9+rDdiEu9eS82WpqGNk/H/2FziymfkwbckWbFzVRR6m7dKaRTJMuy+9ILqLb7s7MVpxwbut7OP6hHDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTBJb7/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43241C4CEEA;
	Thu, 24 Apr 2025 08:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745482730;
	bh=luBO6reS1AIHdLD0ocQc2V2sYxCZNmU96oc6vvsTJUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTBJb7/sOtgibfbZQZRPmB3NDzGuw8WXFuKDiYfD9jo9Tfl1ZSBHPmhHPrqPDbTsi
	 PqHif8L8cHGYTe8i0k8oHy+9uqiBj85SewJiQ4iGUtwfYZjyZd1tNMsd4bN3MDeI7e
	 /SLvoq1G4PZmF38YakZaiBvQ9p1SJePpeM0w30Kqbr+NCJoYj+0/E9wlUbYt37+qNU
	 A3Q3oyisKdK3emcymdrL5r4xLHUSYwn0bOWZDKBHJi1kJVfkos9N8MlFNPNRGtv+xK
	 HsjFxwezNty60QqB1PXzwj43UxVrbtToJYEG5xxN47QII5bt2SyzZx44/6CeXdgBQM
	 3ZSjc2+P4yDXA==
Date: Thu, 24 Apr 2025 10:18:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com, 
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr, elder@riscstar.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v2 3/6] riscv: dts: spacemit: add PWM support for K1 SoC
Message-ID: <kftfye2zn2ogyvuv7diuyrv5qkp43csbpkcqfcms2xp5lsuubm@z2kocdzkb7qk>
References: <20250420070251.378950-1-guodong@riscstar.com>
 <20250420070251.378950-4-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rfmkfp7kn4uz32vk"
Content-Disposition: inline
In-Reply-To: <20250420070251.378950-4-guodong@riscstar.com>


--rfmkfp7kn4uz32vk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 3/6] riscv: dts: spacemit: add PWM support for K1 SoC
MIME-Version: 1.0

Hello,

On Sun, Apr 20, 2025 at 03:02:48PM +0800, Guodong Xu wrote:
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index c0cc4b99c935..e7dba623e877 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -556,5 +556,185 @@ sec_uart1: serial@f0612000 {
>  			reg-io-width = <4>;
>  			status = "reserved"; /* for TEE usage */
>  		};
> +
> +		pwm0: pwm@d401a000 {
> +			compatible = "spacemit,k1-pwm", "marvell,pxa910-pwm";
> +			reg = <0x0 0xd401a000 0x0 0x10>;
> +			#pwm-cells = <1>;

I want to make all pwms use #pwm-cells = <3> in the long run. Can you
please use that for the new binding? (Of course this needs adaption in
the binding doc, the code should already be prepared for that.)

> +			clocks = <&syscon_apbc CLK_PWM0>;
> +			resets = <&syscon_apbc RESET_PWM0>;
> +			status = "disabled";
> +		};

The error that the build bot reports happens (I think) because CLK_PWM0
isn't known.

Best regards
Uwe

--rfmkfp7kn4uz32vk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgJ8+QACgkQj4D7WH0S
/k6SQQf9F+et5yXHz1s66Oocx6PAunCNSR5NsrxqTGCCJsG7A5Xj5ihj4O5WEUCh
g1KnQp9haUQ+FUcC6sjHIcs3Mh2V31LduY6wsvyw9etzsVoFtQx6NwojEH+fLNOC
15oZnNgyhsYlrRS7uY0DHuhPikTq2DezMV5I+3LwvFkcwzTcn6d7D0WOR3PP35OV
gVJM6w9bTiftCEH7lmCm//w26e2WI1csVZINIcYDe7PY5rnEkuvOcXeqyy+5YNnO
yjjmRrqptnX7/M5Yk3oekuPEJ/hTPAhIjKlsC8E7QIy5iTWmj6IFzC2Zy5mDAgrn
ii3bv4Z4tHAYiVyefKztz66LwfcOWg==
=PFuz
-----END PGP SIGNATURE-----

--rfmkfp7kn4uz32vk--

