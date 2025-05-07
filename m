Return-Path: <linux-pwm+bounces-5843-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5638AAADA72
	for <lists+linux-pwm@lfdr.de>; Wed,  7 May 2025 10:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638333A1688
	for <lists+linux-pwm@lfdr.de>; Wed,  7 May 2025 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890591FDE14;
	Wed,  7 May 2025 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTm00zAy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47A1F4CA6;
	Wed,  7 May 2025 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607645; cv=none; b=qahciR2OCYA35UZFWs1Qj5iNKp0a1LBzvm9MkCGjHpH56whasOQ4hPMJSREKbpc8BBoMFSqYrfaUoUQmIfTnT+IOl2XsWEdJKo+zbW++Yv3xnkrGRFWjrr6kV/h4LC63l6vM2pn/Jmkb8JrjMqdujavYtCeWTHToZN8QBPaNsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607645; c=relaxed/simple;
	bh=MdB771dZ+rBXjQh6pZ43Jwf+R6ErJMfzPFbhNeRcU8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ngt9S7hGMec/pUFcl222LqpijgnM1CzHmwp4iM+7bZjTcm1OS8Zz24QYYGa6IxRU+ATA8gFbrUDl5b7AkEy82nFfD4P/WxBj48EfLnozkepytI6LcM7U2VyUeHjeNmQFyq5i+IQ+0qk2BtUb93WnZ5ECEbEoaAE/gfMF2pYS5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTm00zAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CFEC4CEF0;
	Wed,  7 May 2025 08:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746607644;
	bh=MdB771dZ+rBXjQh6pZ43Jwf+R6ErJMfzPFbhNeRcU8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTm00zAyhcWrsX4BME9KZK2kC3hR5vJT7cn7ILyHRXaomvTptRS9GUP/HG6k9hu8k
	 Hq4AMtQa4GpS/h8r3edxpRGPz9taUPlNsiOPZmdcY7+8EwWgsUO2TzgzsabLN8wWST
	 KT58nnqyz4/X2JlQAX5aTAxteeE9JP5TkGgneolB79YuxkY9yQP0vs95FRZ4i0ROjA
	 FmKtm6llZIYTG8TpynIuQk9YytQJX+Z85NHrhPj9eLOYPUecb0B5H72gKUZIl/GGjo
	 6OGzqdJhBiGOa/xyjTWDQT1rJuEVB5m7/Fncg94VEjofdsuwSEOUMGCn2/LEZz6z1E
	 fl0a4dJeANYdQ==
Date: Wed, 7 May 2025 17:47:18 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
	kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 6/7] counter: Add rockchip-pwm-capture driver
Message-ID: <aBseFo-EC-PzxiqM@ishi>
References: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <9YSDgp1lgx6iAp5HG0vS5k0VtP_qnX2YlyDlQOHRYJPU1rRcefCFy8b_ypj4EiQ4i-68q1yIjttcwaTg92zWoA==@protonmail.internalid>
 <20250408-rk3576-pwm-v1-6-a49286c2ca8e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xXULWcVOlYB0+4sM"
Content-Disposition: inline
In-Reply-To: <20250408-rk3576-pwm-v1-6-a49286c2ca8e@collabora.com>


--xXULWcVOlYB0+4sM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 02:32:18PM +0200, Nicolas Frattaroli wrote:
> Among many other things, Rockchip's new PWMv4 IP in the RK3576 supports
> PWM capture functionality.
>=20
> Add a basic driver for this that works to capture period and duty cycle
> values and return them as nanoseconds to the user. It's quite basic, but
> works well enough to demonstrate the device function exclusion stuff
> that mfpwm does, in order to eventually support all the functions of
> this device in drivers within their appropriate subsystems, without them
> interfering with each other.
>=20
> Once enabled, the counter driver waits for enough high-to-low and
> low-to-high interrupt signals to arrive, and then writes the cycle count
> register values into some atomic members of the driver instance's state
> struct. The read callback can then do the conversion from cycle count to
> the more useful period and duty cycle nanosecond values, which require
> knowledge of the clock rate, which requires a call that the interrupt
> handler cannot make itself because said call may sleep.
>=20
> To detect the condition of a PWM signal disappearing, i.e. turning off,
> we modify the delay value of a delayed worker whose job it is to simply
> set those atomic members to zero. Should the "timeout" so to speak be
> reached, we assume the PWM signal is off. This isn't perfect; it
> obviously introduces a latency between it being off and the counter
> reporting it as such. Additionally, periods longer than the timeout
> value will cause the count to "flicker" between the correct period and
> duty cycle values, and zero. This is because there doesn't appear to be
> a way to reset the hardware's internal counters, even when writing to
> the registers.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Hi Nicolas,

I just want to give you a heads-up that I'm looking over this but it's
going to take me a couple more weeks or so; this hardware is a little
weird so I want to properly grok it before I Ack such a driver. In
particular, I'm not sure yet that the counter subsystem is necessarily
the right place for this functionality if you're ultimately after values
in units of time (sounds more like a clk framework feature) -- but we'll
determine so together.

That being said, please continue on to a version 2 of this patchset if
you have other changes ready -- I don't want the counter driver
bottlenecking the development of the rest of this series when progress
can be made independent of it.

Thanks,

William Breathitt Gray

--xXULWcVOlYB0+4sM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaBseFgAKCRC1SFbKvhIj
K3NnAP9fPfygexiooPBDY7YMa3FOYHLiEwL3Ff8romDthgeuZAD/U02/o2pFHFC2
oc7TaVdshAg8bTYLocZqBxZrWjFAHgM=
=fgvr
-----END PGP SIGNATURE-----

--xXULWcVOlYB0+4sM--

