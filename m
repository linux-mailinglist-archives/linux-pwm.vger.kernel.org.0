Return-Path: <linux-pwm+bounces-5533-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34537A90712
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CB61898B18
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8841FBCA7;
	Wed, 16 Apr 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN++NVpN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3B171658;
	Wed, 16 Apr 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815383; cv=none; b=JgRg7oyAryh0J7TOIGZahE4KLCaSgthDrVbxudU9SxU6Sw8YL5zaCjfjn5KK291eGYUqskEPjxruB8HEMzmLSj+CqxM0aZe2H7ai9UXHajZnylMql2GXn/mznJ/rfIZ9YLIuDwaMAY258pk3T4cwNZ+9XuKxTBeUwlB8inVcrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815383; c=relaxed/simple;
	bh=YgDN44xj67UxlkGlXq/z4BMLc1kLJK45drEaqMMTO8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUmmQfzGfNGIkJiNUuzsMIdSvUw2jZqWaBA1oDayL9b3x0ps66GkzUdapiswHa9MTG1nPIfRXAU5EMqgYpubDNzDw29XO5/nzCM+owo/wcAj9c4r+PX5de+7N+a/HDYpfip+uNWiOH7oetLeOujjAW9xOK0NdKDjbe7mf8MiugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN++NVpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CDAC4CEE2;
	Wed, 16 Apr 2025 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744815382;
	bh=YgDN44xj67UxlkGlXq/z4BMLc1kLJK45drEaqMMTO8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oN++NVpNhHYAZSEooP4+g77Qm4SP7b7H6zm/n6fwLi56f0PdK07SvLGmtuq0ExnQQ
	 As5qC6nXvV/vYxKxVc3cpmD/djdYE9R1Wk/R2hc/R4jjshOxsTKKaHjFGIJMD3ApDu
	 C8V/D9Z/VwmG+QNTvDhJEvt+cIHp31kaYmuON349pMuuGuSIFct1v925eY0G4LyVxz
	 P7Lv5PeKZznsEX0CLYOLxq54s6pJimYGsU82/S9WEI89ZCQuIyNJ2ZIxgGttyzq6XB
	 gNd2dTGxboZxUrK2OG8XDjq04HNXatCdHpt6iC0CWX/LX4gm6bihIFhDdpZJ26xVOg
	 33cUK6i1KxNPg==
Date: Wed, 16 Apr 2025 16:56:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: Yixun Lan <dlan@gentoo.org>, Guodong Xu <guodong@riscstar.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Conor Dooley <conor@kernel.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, drew@pdp7.com, 
	inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, 
	hal.feng@starfivetech.com, unicorn_wang@outlook.com, duje.mihanovic@skole.hr, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 1/9] dt-bindings: pwm: marvell,pxa: add optional property
 resets
Message-ID: <bnrfclqrbzqzg43b2yjypsolvvukpppa7lxceoocfm6ww6kjes@gkuoeygu5vwz>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-2-guodong@riscstar.com>
 <20250411-confider-spinster-35f23040d188@spud>
 <89b6142bacecd4a7742341b88dc1e28c4454527a.camel@pengutronix.de>
 <CAH1PCMZnJDcYKJR35WirQT95hte0NWvGBe4fjDuyZEgagvunAA@mail.gmail.com>
 <20250415101249-GYA30674@gentoo>
 <0bbd2842-72bc-47a7-832a-fc8833163e32@riscstar.com>
 <20250415122807-GYA30943@gentoo>
 <hogqotzzpzcow2xjrwh34qcuiu7ooc2qnvlhuvexzvqkrcsfop@mhz26t5vu35p>
 <3dfc300f-081c-4824-97c3-842f72d2a7d3@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvbqpn6aaa4mvleg"
Content-Disposition: inline
In-Reply-To: <3dfc300f-081c-4824-97c3-842f72d2a7d3@riscstar.com>


--nvbqpn6aaa4mvleg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/9] dt-bindings: pwm: marvell,pxa: add optional property
 resets
MIME-Version: 1.0

Hello Alex,

On Wed, Apr 16, 2025 at 06:33:42AM -0500, Alex Elder wrote:
> On 4/16/25 12:18 AM, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Tue, Apr 15, 2025 at 12:28:07PM +0000, Yixun Lan wrote:
> > > maybe there are cases that users don't want to issue a reset..
> > > so, want to make it optional.. I can think one example that,
> > > display controller is up and working from bootloader to linux,
> > > reset it will got a flicker picture..
> >=20
> > Agreed. You can just deassert the reset at probe time. That shouldn't
> > interfere with a PWM that is already producing an output.
>=20
> I think you're saying reset can be a required property, to be
> harmlessly deasserted at probe time?  Yixun was suggesting it
> should not be required, because it might already be deasserted.
>=20
> Anyway, I don't feel strongly either way.  Maybe the DTS
> maintainers can recommend what to do.

IMHO you shouldn't have to modify the dts if you want to initialize a
display in the bootloader and than boot flicker-free into Linux.

If the only thing you do with the reset is
devm_reset_control_get_optional_shared_deasserted() (or a variant of
it), everything should work just fine.

I'm not a DTS maintainer, but still have my opinion and recommend that.
:-)

Best regards
Uwe

--nvbqpn6aaa4mvleg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmf/xREACgkQj4D7WH0S
/k79QwgAumneJJTU70ctlA9cRnIOTKxwGWl3IxHMtKIMx/Knwy5qCFoGmtBgK5HO
9UflSaqdQ1pXi7MF5fIY7k8PvgkO9T/sVjAnyhdygEKUqiebkepSX6TCWcd4tJwb
71HCVPYmc7+YlDiYYgOsHrhBISHSugf4d1RyJ4PNs3Ad4IckmilMC0Wd0x2e45uG
CEn3JntNTBm1l+ddSW1Vrv3fdZkjJMjjUb2gRC34JFwYVhQF2JUMsE8zW8v6SO0h
d1Yfh03EEStFFH1HBZfIqOocV13snt9t+SeyaZaHTtnAPXER+97gr1cfoqBZG+kC
y9eC+Ru1+1AS6Szu5MBpVwSrtD8fyQ==
=myXU
-----END PGP SIGNATURE-----

--nvbqpn6aaa4mvleg--

