Return-Path: <linux-pwm+bounces-5389-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C3DA81197
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 18:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F78C7B77B3
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3E22D791;
	Tue,  8 Apr 2025 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyLqtvNt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632EF22A80D;
	Tue,  8 Apr 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128479; cv=none; b=peY4qVqSCoiQteK2vjgsvwj/5xbYz1TG3IuuOrOBiC+WBU17MxzRxDjZDBEF8XRbI4uSTtGW9D9uOzxcTdVbExDAb8dvq1JkQ/AWPH+tK55h+mzZ8fnBZtj04eN5mWARKmSI5JY1jIq3ICTt7ckzSrljsUkjAxRFvduKlO0KHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128479; c=relaxed/simple;
	bh=lzpeBjhQqjKTv5LhjTuLZBeC/RINwYUMzDyi+e++4VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTIi4NJkx3vj+cZLu2vFLGHRjjtP4Pr5p19Ix/2uKtiJgHD5CESf923W2f0e9rQKpYl53X9jax9a4F4kNSnLVm47sWAQjeAVZfVJ+w6fW3wXI7NaNlk4bkXYW73B65GIZjzjwxAp8GKvNdhuPKLyHo/g3J7TyREdXGzkLI6Guv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyLqtvNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B628C4CEE5;
	Tue,  8 Apr 2025 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744128478;
	bh=lzpeBjhQqjKTv5LhjTuLZBeC/RINwYUMzDyi+e++4VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyLqtvNt3uo49sXmzsO/X6m+Zm0NwzwtMrSOp3iDAplnzf1boXsd6IaggyeX8dnsQ
	 +MCD0To/C9JGz07JeAoSJlwidfegqkkqiUcfv+/RaZW6XXPyismKIvOl9t3Ug0yLpt
	 1UBzkv5S5FQ8cUQps3M7tDN+xDN/BxUUo2Z6yXP47XX3qZ3S1ST6C0r1FLzlUdX6SL
	 BDjEEtGqjefpz4rTwexrt/ipf13elsC2SaFHxC2kjVkZZOZ1QEQMwX/9EgHkO17fuy
	 QyK3sRQK+YGvaW4/eCV5B+i53tQHvoXHVTLt5I4ZJOZCJ9gIxL1FZ+nVzUeC1fEA1K
	 8wM/enLNTWrsg==
Date: Tue, 8 Apr 2025 17:07:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
	kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 2/7] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
Message-ID: <20250408-drivable-hypnotize-062fd7cec903@spud>
References: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <20250408-rk3576-pwm-v1-2-a49286c2ca8e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P4Hq9KC+O/IONcbS"
Content-Disposition: inline
In-Reply-To: <20250408-rk3576-pwm-v1-2-a49286c2ca8e@collabora.com>


--P4Hq9KC+O/IONcbS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 02:32:14PM +0200, Nicolas Frattaroli wrote:
> The Rockchip RK3576 SoC has a newer PWM controller IP revision than
> previous Rockchip SoCs. This IP, called "PWMv4" by Rockchip, introduces
> several new features, and consequently differs in its bindings.
>=20
> Instead of expanding the ever-growing rockchip-pwm binding that already
> has an if-condition, add an entirely new binding to handle this.
>=20
> The "osc" clock is an optional clock available on some instances of the
> PWM controller. If present, it allows the controller to switch between
> either the "pwm" clock or the "osc" clock for deriving its PWM signal
> on a per-channel basis, through a hardware register write.
>=20
> However, not all instances have this feature, and the hardware copes
> just fine without this additional clock, so it's optional.
>=20
> The PWM controller also comes with an interrupt now. This interrupt is
> used to signal various conditions.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--P4Hq9KC+O/IONcbS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/VJ2AAKCRB4tDGHoIJi
0jZqAPwOQu41aopdoBSSIQdKHqz2RJ+dwLSozN2+YDI1wW8y7AEAjS2GhaRyfF96
3GHeudBuxceUrbBxoPB8hzmTAP7etQQ=
=yLZr
-----END PGP SIGNATURE-----

--P4Hq9KC+O/IONcbS--

