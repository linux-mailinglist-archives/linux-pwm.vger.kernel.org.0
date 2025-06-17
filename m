Return-Path: <linux-pwm+bounces-6415-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95673ADCFF0
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 16:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF90318977C2
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598942EF658;
	Tue, 17 Jun 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/GzYPds"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326382EF662;
	Tue, 17 Jun 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170483; cv=none; b=S38XGHAHJvoSJ084j+86zhf7r9R6BtAG3FP/BTMzQn1tWDwvR4O6HoBASFxnd1ieLmCp3LR/h27x461mwHStaDB01ZSH5CPZM/OCmdH3F31bHso5rVMLT/+03TE2+bdV6QINg9h3VWqrsbt9mehs4iuUSlb8PkCK82arl1JIqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170483; c=relaxed/simple;
	bh=gbqLTYR0mAYgtvwgmxmyg1ZOj93y/Mo/xYgG/dsqrTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3qIJ86enu8QBCzRb32NEcpCyPqFq+/LRUh48uYRHmKkEaMIe/JavdNOHKgmfUWyPfmrbTeZ+WjOTu9TCuBgEbjocZNvlnh2P0kbPb5AF1w14aMNNke2Ggir4kRQJ2bTcJGfYMJxh9Li2p8igO0Z0/90FilRWxPvyptlXTnWmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/GzYPds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD6FC4CEE3;
	Tue, 17 Jun 2025 14:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750170482;
	bh=gbqLTYR0mAYgtvwgmxmyg1ZOj93y/Mo/xYgG/dsqrTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/GzYPdsKv0M2ulRiafSZdVlzU0gS+6D4PkCQW6oS3JbPWdVHW5IfLZWKcorb0Hxx
	 zE4i6P3XQErzWUHUdIZkeuVbiNGNxeQ5RvGq5VATTzaK9owPzY/2ydtIVga5cP7IHH
	 wn3oMDgyd5m8p1E6jg+73BWYXax8ZIMdorP74PuBnxVCy20zkvgdc5N86A7TEtbmhi
	 Kr0EDkNKqsToJRWkIXxQOMOqjYDRuv/bHgPblD1TsyOwxVMs3lIZduYVVbBom7hJPQ
	 m5PHZriiQiZKER4kHmuPZ9Kwxz8B4iQd/PisHnaNIazULBTMa4hu82a2DpZZQ5e2Di
	 LuyVbFcwKPJKg==
Date: Tue, 17 Jun 2025 16:28:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, 
	Brian Norris <briannorris@chromium.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, kernel@collabora.com, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: rockchip: round period/duty down on apply, up on
 get
Message-ID: <vb2wmbbbmwheovxkac36ab4omw6dj3owb4vhz7r7woumvawkp5@eeejjh6jt7wd>
References: <20250616-rockchip-pwm-rounding-fix-v2-1-a9c65acad7b6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v7m5lcpzioclc2sh"
Content-Disposition: inline
In-Reply-To: <20250616-rockchip-pwm-rounding-fix-v2-1-a9c65acad7b6@collabora.com>


--v7m5lcpzioclc2sh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: rockchip: round period/duty down on apply, up on
 get
MIME-Version: 1.0

Hello Nicolas,

On Mon, Jun 16, 2025 at 05:14:17PM +0200, Nicolas Frattaroli wrote:
> With CONFIG_PWM_DEBUG=3Dy, the rockchip PWM driver produces warnings like
> this:
>=20
>   rockchip-pwm fd8b0010.pwm: .apply is supposed to round down
>   duty_cycle (requested: 23529/50000, applied: 23542/50000)
>=20
> This is because the driver chooses ROUND_CLOSEST for purported
> idempotency reasons. However, it's possible to keep idempotency while
> always rounding down in .apply.
>=20
> Do this by making get_state always round up, and making apply always
> round down. This is done with u64 maths, and setting both period and
> duty to U32_MAX (the biggest the hardware can support) if they would
> exceed their 32 bits confines.
>=20
> Fixes: 12f9ce4a5198 ("pwm: rockchip: Fix period and duty cycle approximat=
ion")
> Fixes: 1ebb74cf3537 ("pwm: rockchip: Add support for hardware readout")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

I pondered if I should drop the Fixes: lines because I think this patch
shouldn't get backported to stable. But I think it's correct to keep
them and then just veto the backport if the stable guys pick it up.

Applied with a few cosmetic changes to the commit log to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

Thanks
Uwe

--v7m5lcpzioclc2sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhRe24ACgkQj4D7WH0S
/k69JAf/ZhADTd/ReNB0MbeK+eTaJsOHFQr+bYl7/xNVsNa4MMdXh50tNin4L2qN
9VjWB4g/M3N5XJjVzV8GW4GN5TgHPjP5XuEAxOfN4Cylp/T9/fcZ7N1fSoVuziGY
dijTKqjqWN1r6bTbc2G75iSajQE6U97rGVcqFQ3hKTQYWAhfib8RVnXfii/PBrqP
/Tn17j6s8alqHVw37ihMG45aPRNYLTursYwHA+XNN2Yjw/YnkF+VkZVpXNYxC3Dj
r3IbqxdoWj8wd4ZIPSTBkShBW7ruy93lxT+XrfnxxhkuJRcftuHne0e8p+tGVNeH
01I8F5vpsiL4Qh6H+CW4lox/PGAwLg==
=k0eL
-----END PGP SIGNATURE-----

--v7m5lcpzioclc2sh--

