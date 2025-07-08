Return-Path: <linux-pwm+bounces-6775-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA362AFD318
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7973173B2C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48242E1C65;
	Tue,  8 Jul 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4oOoADh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E50225414;
	Tue,  8 Jul 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993421; cv=none; b=aODjWFPMIpPM4xEzbwUru6trQrd0h6T+e+OBSSp0JiENZCb+fLEryCBZnelh1s8q76A+Krr+1jq1XVZ98zP6xUN3HeXT7+wSnTjAQ9xeCQfNrxFxiPq1rPgFkuFlXwEMWLKQJ1KJjpHxNuKrikG2UdtvqoYBJOfddntHKPYr12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993421; c=relaxed/simple;
	bh=8A40c7RkWLHp2FPC7aBzNnB7TI99rPspv5sgH1fkE8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqFynrS4nT+Caeyljx7JOqxVyO+8daDIT90udLw+VaFtHx5fm9MByVeKG/RsCtvTkWm9DRb4AZTTc9eBLuT2DZ++6VuelBpkAzZl8Ly2FLQfvgbzT0n+2E4gwAjFC1v0oD5S5Sydg+lyiaGAMcs6iZZWTOeRangOBEI28Gh4JnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4oOoADh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A293C4CEF0;
	Tue,  8 Jul 2025 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751993421;
	bh=8A40c7RkWLHp2FPC7aBzNnB7TI99rPspv5sgH1fkE8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4oOoADhfoGvM18Nn3/ykD59LMcHlKHrizmm2uAARvweNBAoOGZOSVmcbNHR68RRO
	 lti+FK/MwEGlTEPEUP67aAArp+eYz7Usn7oN6xCwv1n4Yo2hKGvfgea4982oM14o2k
	 w48iC0Z6TEy3rTGSwSiytK/b6adEgxwyKDQsr/aZUC8sdt4EENGzwR4pJeBUnxrab3
	 QQ/YWuHCyWcpOGrrwgN1wE1vUzvFn5XkpAW3XFbxGiHI8AWvDhGkPoQO4ouDrXSSyO
	 6Yx5zdt2oq9VKNLj2dpYLHRH1UH3ZQUYVcDlq9LRnBMKB3HO2pQbOSa0aCpr3pVheB
	 d4XnQZs/nmR7w==
Date: Tue, 8 Jul 2025 17:50:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Guodong Xu <guodong@riscstar.com>, ukleinek@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	drew@pdp7.com, inochiama@gmail.com, geert+renesas@glider.be,
	heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com,
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com, elder@riscstar.com,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH v3 6/6] riscv: defconfig: Enable PWM support for SpacemiT
 K1 SoC
Message-ID: <20250708-wildfowl-curtly-1993ed320572@spud>
References: <20250429085048.1310409-1-guodong@riscstar.com>
 <20250429085048.1310409-7-guodong@riscstar.com>
 <20250707222910-GYC408198@gentoo>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tqHe0xDpc9gw5L64"
Content-Disposition: inline
In-Reply-To: <20250707222910-GYC408198@gentoo>


--tqHe0xDpc9gw5L64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 07, 2025 at 10:29:10PM +0000, Yixun Lan wrote:
> Hi Conor,
>   Can you take this patch? I've checked with riscv's tree for-next
> branch, it's still applicable and meet the "savedefconfig" criteria.

Sure, done.

--tqHe0xDpc9gw5L64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaG1MRgAKCRB4tDGHoIJi
0iMqAQCkQXOHEt1A4XzvWbSQcalLMF/bZO3zekAoxRIfbLq98QEAmuuZF9e149/a
Dr4NUIYP7HDgky9w/jvCn45mJPQCOQM=
=tdoU
-----END PGP SIGNATURE-----

--tqHe0xDpc9gw5L64--

