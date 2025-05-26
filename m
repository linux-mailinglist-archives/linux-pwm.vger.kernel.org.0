Return-Path: <linux-pwm+bounces-6132-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9105CAC432B
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 18:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543DA177F66
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38C222539C;
	Mon, 26 May 2025 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnWclTp+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3103D994;
	Mon, 26 May 2025 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748278494; cv=none; b=gLa56YD3pNWJyBZK1YC6l2HMBYrzrmVa7AcxdepjFNcnG02e6ZKFscnJ8BkhokPw0fI3PBHeXFXwUW5xq71Fy3bgJ2lK/BYv1BgYvR88td6UVPxkPsIK/4JPinJLKaXCaO/fcHK5E9kYfMuAQbPtpxjgTLa/2fB1mXR4WY15KvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748278494; c=relaxed/simple;
	bh=lBm90pZvZ+UoOxLMSy6TVhe9roiPZ8LaELnS6zZuHww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNrPdN08hntFzlrlCJyHBX29o4tNBEfkTQXWxTrBWuIYzxzDu6yO9xHIZw1apxZLK2LW7Vx84zJMeljL+rW30zXErkhqcoi/sgM0c0HJYTB1I7YlE4oz5g7jpsBxNcTbWv2zetN5eovFxERoi9mAX/8eh5nGlZesn95w+WRuMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnWclTp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E162C4CEE7;
	Mon, 26 May 2025 16:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748278494;
	bh=lBm90pZvZ+UoOxLMSy6TVhe9roiPZ8LaELnS6zZuHww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnWclTp+ovOobfxziqbCaFoppus1w1swSUgBUAGMwnV6zUv+jhpbZze9RZH129Y7m
	 +rBgYCFh056fteBEXupwrfYHPmVKIwTAYQnOwK5y6hnZv0ZRSTeIzSWS16YZZN1nRD
	 5iPfE4dnVudevPF2feoFUNvFzjtA0G40OVTAqvHmlF+byXTvkTDcvh0CT866a5alox
	 spVzf+e4rJ+X2YbRj5V3YgW4yIa5YVvjaATkcfUlK4xetO+MfgLuLsR2K5PMxoxdg7
	 ESZsUBa0qkD5X2Kz5kVVZB7pb922zVoOaNxm3xY9O6HaSqC+SS3xazMbqaPYlIopme
	 ixzInJUpR3JgQ==
Date: Mon, 26 May 2025 18:54:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com, 
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr, heikki.krogerus@linux.intel.com, 
	elder@riscstar.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v3 4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
Message-ID: <paasmwjel652r25nxobidydtpxfjy7emerilmwqhvhtgrrtg6v@gowpzqdzvlfz>
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <20250429085048.1310409-5-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="og4jf76cno5lbodv"
Content-Disposition: inline
In-Reply-To: <20250429085048.1310409-5-guodong@riscstar.com>


--og4jf76cno5lbodv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 4/6] riscv: dts: spacemit: add pwm14_1 pinctrl setting
MIME-Version: 1.0

On Tue, Apr 29, 2025 at 04:50:46PM +0800, Guodong Xu wrote:
> diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> index 283663647a86..195eb8874f3c 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> @@ -20,4 +20,11 @@ uart0-2-pins {
>  			drive-strength = <32>;
>  		};
>  	};
> +	pwm14_1_cfg: pwm14-1-cfg {
> +		pwm14-1-pins {
> +			pinmux = <K1_PADCONF(44, 4)>;
> +			bias-pull-up = <0>;
> +			drive-strength = <32>;
> +		};
> +	};

There is a newline expected before the pwm14-1-cfg node, isn't there?

Best regards
Uwe

--og4jf76cno5lbodv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg0nNgACgkQj4D7WH0S
/k4F9Af/Zpy8tXv2q3vdClmG4OFmDlQUd6y7BYw45X1lE4OtNCQADFVZsyy6WU6l
Xtwwi1fftGGiPz+7BWuZWzSlRKLDryGktzeQI/GYoO/4mRDESCNCG+qI8hGjmVAC
kX2TmSxV6PQUSszOdWBGUYI3YiK3Wy4T4LcMM0JuAIhehj1zwBNL5YFvmlmgf9r/
zq7fUmV0h0+TiLERutwSOfZUUmEp6Z3LPS2pDKSoGbF0JYE+mOHJtYaa70jH/QHX
C3RaQgQZ+ENrMf5DGs33pB/QulhfAm/aUUIXLycp+mm8rYnVu1t7GiTRLSfwmp+U
35w4lolFUSrs1hzShLHpE4spKswutQ==
=Bsm/
-----END PGP SIGNATURE-----

--og4jf76cno5lbodv--

