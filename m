Return-Path: <linux-pwm+bounces-6133-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8975AC436C
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 19:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9617A177A7D
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627DF23ED6A;
	Mon, 26 May 2025 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCn0el/O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43A17FAC2;
	Mon, 26 May 2025 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748280152; cv=none; b=ZiR+cgSPTRhr28lnm3ZFVj+Ft/L6EIKyFwml+M4TlV8G2SUcEwQ/R2FDzyxaIx14xquFCjualCe219kd+kSwqB5c/S1PAnu4EHs6R7LWorhXQfUXox0sP1MzqXqi2XzRDdB1+YPAajRB281vn/6GMKSMykdZN4kn73QBmCouM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748280152; c=relaxed/simple;
	bh=rR0L3LQFJl5lnuDlkm5fGXdF8rlpXRpdN7zYcCMT5tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDwKx0yhqBEJSDZWZNdBBtNPV/Eq+Woucmi5fgRXFIYuzQbT3fB0/bhk4n8Pt5N/+FkzifeX4vC2k6Vp5KcnoNmGjh3j6GajOKJbFnlt7G6daSFoHOsXEbdszo2HD1oo2acPBKGB8lVnZ1oTwgiKFUwMyy1WF1eB5rtyaM4jbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCn0el/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E24C4CEE7;
	Mon, 26 May 2025 17:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748280151;
	bh=rR0L3LQFJl5lnuDlkm5fGXdF8rlpXRpdN7zYcCMT5tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCn0el/OQuUV5N4jWDVcQWObrc8/FZmxWKlyOSKLkxlBs2K4fOkzUda5X+0Kam+OT
	 a4U7iSSqbk2PUqCHkmuDCSFsK1117VLQQOP3oMoetKAlRNGda2daoD9xj0G7dJLitA
	 dw/uWtNgMXU5zhLg1sFQntHkJ27qbI3KYPv9HTlWeFWxpj+3/5jV+EcddRbpj0JdPh
	 VBeFgw2tUhn0NNt3pZRJKUcIJ4DqhWU9zmGgWFdZzSRsebqKPrfnTybif0TWu2DLW1
	 BzinUUgkIO5rttYtNfljchPqcRrApGlGbHAf4oG03LwY/2ailyMqgMsUKCLMJ/81rB
	 BQan3t6wGdUWw==
Date: Mon, 26 May 2025 19:22:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com, 
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr, heikki.krogerus@linux.intel.com, 
	elder@riscstar.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v3 0/6] pwm: Update PWM_PXA driver for SpacemiT K1
Message-ID: <lgjntm2v4qtp3uwccriodxdefdc4vqydzl4dmula4avhws4zfi@xevkgzfuhyhl>
References: <20250429085048.1310409-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yljumz2plxfqhz5x"
Content-Disposition: inline
In-Reply-To: <20250429085048.1310409-1-guodong@riscstar.com>


--yljumz2plxfqhz5x
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/6] pwm: Update PWM_PXA driver for SpacemiT K1
MIME-Version: 1.0

Hello,

On Tue, Apr 29, 2025 at 04:50:42PM +0800, Guodong Xu wrote:
> This patchset adds support for the SpacemiT K1 SoC in the PWM_PXA driver
> and updates related device tree bindings. The changes enable PWM
> functionality on the K1 platform through driver enhancements,
> configuration updates, and device tree additions.
>=20
> Functionality has been verified on the Banana Pi BPI-F3 board using PWM14,
> configured as a pwm-backlight. Per community feedback, the actual
> pwm-backlight node is not included in this patchset but can be found in
> patch 7 of the v1 series, with modification of pwms property to 4-cell
> format to match updated binding (#pwm-cells =3D <3>) since v3.
>=20
> +		pwms =3D <&pwm14 0 2000 0>;
>=20
> This patchset is based on [spacemit/for-next]
>   base: https://github.com/spacemit-com/linux for-next
>=20
> Plus the following dependencies:
> 1. Clock controller driver, posted by Heylen Chu (v8), with most of it has
>    been accepted:
> https://lore.kernel.org/all/20250416135406.16284-1-heylenay@4d2.org/
> 2. Reset controller driver, posted by Alex Elder (v5):
> https://lore.kernel.org/all/20250418145401.2603648-1-elder@riscstar.com/

It's not clear to me if I have to look into this github tree and the
listed dependencies. My impression is that it can go in on without these
changes. Maybe it only starts working when these are also applied, but
that shouldn't stop me applying this series, right?

There is a patch in pwm/for-6.16-rc1 (namely commit df08fff8add2 ("pwm:
pxa: Improve using dev_err_probe()")) that conflicts with this series.
I applied patches 1, 2 and 5 on top of my pwm/for-nexxt branch resolving
that conflict and rewording the commit log of patch 5. The result was
pushed to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/pxa=
-spacemit

=2E If you confirm that you're happy with my modifications and it's
correct to apply them without the listed dependencies I will add the
patches to my queue for 6.17-rc1.

Best regards
Uwe

--yljumz2plxfqhz5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg0o1EACgkQj4D7WH0S
/k4bgAf4o7db7SVDkKQD9FGqsTvIBAmE7TuWOKwRkL5saF9VkLJjDmgdOVZO3Hf/
Y4uPkJPTAa3bOzVFbL7Eftrjkslzs7Kv6mniyoMuo5X1ggGrfTLcNA7Y3NwArC9l
WUIiGKX84b20aHuYN9FXLAnAF4JtoXCc8gEI/m5nj0iGWi5UCFarRlIKCbKTXsXk
MEDl2vL8OUUutk00El5zEdWQeyDiifhJfXA8nHj3YX1ghBkom8J8UTUhltviYwi2
wZYWvs67N1uFChzLxAZrK8iJI+O5UeUevjGNlF4S7DymPNL6EAvOUY/9+QgALC2L
Ac3leHKJIYqVMeU1E4K33CqmhpVQ
=GSJk
-----END PGP SIGNATURE-----

--yljumz2plxfqhz5x--

