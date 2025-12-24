Return-Path: <linux-pwm+bounces-7826-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6873CDB81E
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Dec 2025 07:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B242E3009B20
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Dec 2025 06:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD7D2F290E;
	Wed, 24 Dec 2025 06:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRhcVWjf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB32877E6;
	Wed, 24 Dec 2025 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766557997; cv=none; b=lOV13ybvrYFmmue4xWxrOnfvQYzvOA/FWnrPekTWGV6BM3na7o29uRd+Q4qGixRS3/DEzPIuzltGB+H2TXF/b615jv720uAfVi80GOO7RcWwPpOhrqTbMUDTHG7N5y5dSCMhoS/IL0bcSymfjckShQKGTeSDJN1cHcAYp6r7N88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766557997; c=relaxed/simple;
	bh=AmX3jTR0fIUsh9IUJaJo12SZKK+oJ2JS+Q0WIq9ta3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/0GWvqdCObSTF29rVnuY6WYm5WVDo/KSZfv/uCQPUOC7QUIn7gwvroG9K11QXIS2QipfO2miyZ2UqAUEE7NHUkQfwz3H+b+fBNwEZvo3VpJ3ZVB7rOAvAYgxEa0//5hK/DBtndd6rbcnCu/xRqSi7fGUPNlV5/cmNSLOjtvIvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRhcVWjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2A2C116B1;
	Wed, 24 Dec 2025 06:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766557996;
	bh=AmX3jTR0fIUsh9IUJaJo12SZKK+oJ2JS+Q0WIq9ta3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRhcVWjf04EEC44dMiUOh3QUqgDudMvQARofPuYqfsENezYhROy1GoN7fBR5f1nq5
	 Mk0DO1WszuFHwQzC/8yo/8XbqTDpee4VguLVGARL/uobPodVqztRgme2eD5eAB9EY2
	 RPtPOgTzS6vhpsWtDjCICMSGYoQ6n98CUvOTB3h+QYtdFwIcwrkpo0VKvTs1MZ36oA
	 0Pvx0cz47wWo3Z9NwLfbCuaXDYWDJPQ/Dr7i/0OU/pjsfFYc3Gyp+GB4M21kVPxAFT
	 PgevjfWi4nHxMhlKbEpFZ87bNthNTtUY34sR6fb1XqHeWpcyjuCCxcDjZHZlIjUlcN
	 cUByB0kmhN4gw==
Date: Wed, 24 Dec 2025 07:33:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: kernel@collabora.com, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: rz-mtu3: Share parent device node to MTU3 PWM
Message-ID: <lp2axyn3vyiuk47kf3uqqwasc64a5d24qk76hkavyn4h66zg4g@psygukqadrvl>
References: <20251009162445.701589-1-martyn.welch@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dg6fzpe6ja3siogq"
Content-Disposition: inline
In-Reply-To: <20251009162445.701589-1-martyn.welch@collabora.com>


--dg6fzpe6ja3siogq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: rz-mtu3: Share parent device node to MTU3 PWM
MIME-Version: 1.0

Hello,

On Thu, Oct 09, 2025 at 05:24:44PM +0100, Martyn Welch wrote:
> The PWM currently functions, however if we try to utilise the pwn in a
> device tree, for example as a pwm-backlight:
>=20
>         lcd_bl: backlight {
>                 compatible =3D "pwm-backlight";
>                 pwms =3D <&mtu3 3 833333>;
> 		...
>=20
> This fails:
>=20
> [   15.603948] platform backlight: deferred probe pending: pwm-backlight:=
 unable to request PWM
>=20
> The PWM driver forms part of the Renesas Multi-Function Timer Pulse Unit
> 3. The PWM does not have a DT node of it's own. Share the DT node of the
> parent MFD device, so that the PWM channels can be referenced via phandle=
s.
>=20
> Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

This thread didn't see action for a time and the patch isn't suitable to
go in as is. So I'm discarding this patch from patchwork and my inbox.

Best regards
Uwe

--dg6fzpe6ja3siogq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlLiSUACgkQj4D7WH0S
/k5+EAf/VazbUFgRAXO2M1zgW/XXn6Q5E1OjtBQ3c1vrqwyTbMzZUSkK3YZlgkdp
vEyv1Qwh0XnqFX95lj3VFwO7zRl12EZc2oWTZJvFDJsi4WkltL9663BVlHdB8gBD
Uu+CpoLfruBbtVuNisS1xUA5TOrpFJ07a7BYRcc4UVDntQXYXNBZegmbzqcMXeK1
aa0EobQab1F2bKE6ubtcYPAC/j0UZ4Ij+8QMfmvHpmrkULLMXiNiLaKCFrT11TCy
Ntl9hdGBlgZYYD2zABCif323R3OlkYxDmPD1f/BcXiw+TEme6wPhAg4dh+0rTB3Q
wt3i8u0gh+ArS+J5P9j5E4KsuWI+Uw==
=C4pU
-----END PGP SIGNATURE-----

--dg6fzpe6ja3siogq--

