Return-Path: <linux-pwm+bounces-6948-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A02AEB19FCD
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 12:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A62284E0FEF
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D0F24E4C6;
	Mon,  4 Aug 2025 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF0VwUBn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7F22D7B6;
	Mon,  4 Aug 2025 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304059; cv=none; b=B5dq6JL++vQm69L60GFaIvkXFDfIwOpUGO1CWh9U8g4UMgAVG0Tfkq5AaVoPzcRjKmKJnKHNb8HAwkfRcaQv4cO6pO99S+ekUXbokg0sRXL4pmC3Pz+CaLCQLel16kCOeiZJql+uN5ofkOj+qqz6Io4tBwcE8VKX5oLgdOGmCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304059; c=relaxed/simple;
	bh=g6Pc1jt80zUNyigjtjPmetjph8U+d/ALmshuwTo1blw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfdaigyaNXF1EpoxiJTqL+YPI+YtU3MB/iGSb3XCPJUThfew0MIX1C4NQfDGKdS/ht94EGKWKqMH2TyiYZgaFnMli1n59XBCLmfZR8gvHzAFihozRxrO/UEIwg6fmDVrII+BEt0GCcKyBL4WOQ16pglmCYBRdYMqvT8KVR/4vRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF0VwUBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C4DC4CEF0;
	Mon,  4 Aug 2025 10:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754304059;
	bh=g6Pc1jt80zUNyigjtjPmetjph8U+d/ALmshuwTo1blw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gF0VwUBncPEVjDm60cK9QeuDQAQh/UAeCaEeDCYhhnem8PO3Qzov/uFsUachpHSqJ
	 qRxBhMe7wa39FpP3Rncj/jeQyCCABW+W5Ch9GwdIKntxtFzm6K1wEITtHtLdNi6+h5
	 PYP77fzEikTXqIm0ipFTbWtXMdrjtgKWdrQOUv6+NsG740GmVextqXQzgqpvo2wo+y
	 AEqIWXgiXJkzloLK0EuTHLVQHPT2oXYt2jvl5PTVMD7bwUDI9k4z3cekHCKLoRxMau
	 JgXzbk/otSEvD2gkdGfssBHE2Z/kZgQbw+CA8niovYc1UN19fk8A/RhebqGQWVTzsg
	 U/ThgQuNo9zAQ==
Date: Mon, 4 Aug 2025 12:40:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Nylon Chen <nylon.chen@sifive.com>, Zong Li <zong.li@sifive.com>, 
	Vincent Chen <vincent.chen@sifive.com>, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 40/80] pwm: sifive: Fix PWM algorithm and
 clarify inverted compare behavior
Message-ID: <7frg2elz76idsw53z6abohdtzp3z7xzdteohcvonzevjkkduox@lusetfiecucl>
References: <20250804002747.3617039-1-sashal@kernel.org>
 <20250804002747.3617039-40-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yrqyiuodvptb5j2y"
Content-Disposition: inline
In-Reply-To: <20250804002747.3617039-40-sashal@kernel.org>


--yrqyiuodvptb5j2y
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH AUTOSEL 6.15 40/80] pwm: sifive: Fix PWM algorithm and
 clarify inverted compare behavior
MIME-Version: 1.0

Hello Sasha,

On Sun, Aug 03, 2025 at 08:27:07PM -0400, Sasha Levin wrote:
> From: Nylon Chen <nylon.chen@sifive.com>
>=20
> [ Upstream commit 7dbc4432ea6bf9d709391eb57f1e9fb44e99845a ]
>=20
> The `frac` variable represents the pulse inactive time, and the result
> of this algorithm is the pulse active time. Therefore, we must reverse
> the result.
>=20
> Although the SiFive Reference Manual states "pwms >=3D pwmcmpX -> HIGH",
> the hardware behavior is inverted due to a fixed XNOR with 0. As a result,
> the pwmcmp register actually defines the low (inactive) portion of the pu=
lse.
>=20
> The reference is SiFive FU740-C000 Manual[0]
>=20
> Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b=
16acba_fu740-c000-manual-v1p6.pdf [0]
>=20
> Co-developed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> Link: https://lore.kernel.org/r/20250529035341.51736-3-nylon.chen@sifive.=
com
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

As for the 6.1[1] backport, please don't pick this change.

Best regards
Uwe

[1] https://lore.kernel.org/all/52ycm5nf2jrxdmdmcijz57xhm2twspjmmiign6zq6rp=
3d5wt6t@tq5w47fmiwgg/

--yrqyiuodvptb5j2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiQjjUACgkQj4D7WH0S
/k50gAf/aJ3iHL1QQzh1R/HNLEoCmaFNxl13MeiA7J44Qy3vWXYq61akDV/C+81n
IP/Ek7ZL8FKLTPW8b6ZYQFh8rJ7e+TJMOdxTj+WUHCJNFkt/jfvEbeVmafzlrQmX
QB5Ry/KKM4H+X1G9J4gSvHziB9e5Nwjh9VE76x8P3A1sqT9HLSEJw/3GnqW7H9sx
a/gD4EFEH1pM/cCMN+bEs3B3/l6F9aa96yVhIiV3ZzclcAg73W9scBVxkTJ+VvuP
zHUW5e3eyt4Boq0IjIow/opCc+dXpBJlf9usvJPKWuMhdIWAiKAiynxCvQc4AVhm
9E+A1LCzeYO5a5i+cqF6S9+uk81nbw==
=UUTY
-----END PGP SIGNATURE-----

--yrqyiuodvptb5j2y--

