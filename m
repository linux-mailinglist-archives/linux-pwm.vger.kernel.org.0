Return-Path: <linux-pwm+bounces-5511-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B871A8AF98
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 07:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5075A17F48B
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Apr 2025 05:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D9227EB2;
	Wed, 16 Apr 2025 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4YsDyhl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAA2DFA2D;
	Wed, 16 Apr 2025 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744780711; cv=none; b=QibJql9VlA8attYgvVIsKBZGxMO8+v/A38dnWC2AzS6/vV8dOPbLtmhvSrhbTJbqg2qzyu7gsYqS6T/zN0AiYidPAkiZxEH0hq8fa3I10Rgw9BLmGHfN9QRRG8UwjyqvLxaVO9dw6JVNEmOZZ4g+GSEhvcn4hboB5xd5Iem5kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744780711; c=relaxed/simple;
	bh=CmNtU/Ng9a+Jh4xKHpsC8mx2FxYmD+EiYZC+QuZh9+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqAZiP/DX+SY5+/LWrZX9I8VKraoDb+pbyuXR/ZPxjq2dpch6NEgokil3q7zv0y2TIerAYWuXAPpnsXsoWa5hsn7G8MQSBKjD/hVperNKAe3vJYu63OkQIHQoWFDo2ObE4RsrhexKViDl5rvcYlHG6AsteZlo24K89xcY9T/D9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4YsDyhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A5DC4CEEC;
	Wed, 16 Apr 2025 05:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744780711;
	bh=CmNtU/Ng9a+Jh4xKHpsC8mx2FxYmD+EiYZC+QuZh9+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4YsDyhl2RK//iQoGDJ4oxeuQ2oGCVN46wS8ndM2H1q8BTeAJYZse3I3Hpeb6+MNu
	 PqY6HWPYLsznjFBt6m8JzrR/fXLChkABbOeyyF9rGB6uco9jqrCgPgnGAGePFdDDfH
	 2ly5/wQBDFv785hDObgMrmIc59qEosIpIkxaACm3mgk6ZnAo/yI9Y9O2VnT4Z30ZTU
	 vfQO4X/IPfT+u5J11+3LXI283MB3NthqovTArwv6n/Ohmz6DU2T6BfuQTpv4J8GFW3
	 rV4VppRCG/NS8cr68X0Kp8MDwEI6Y2ZaNvlqjBQwSFwnGvxC+v7LZsHIScZHcg+T5l
	 W1z+KsnM770wA==
Date: Wed, 16 Apr 2025 07:18:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Alex Elder <elder@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Conor Dooley <conor@kernel.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, drew@pdp7.com, 
	inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, 
	hal.feng@starfivetech.com, unicorn_wang@outlook.com, duje.mihanovic@skole.hr, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 1/9] dt-bindings: pwm: marvell,pxa: add optional property
 resets
Message-ID: <hogqotzzpzcow2xjrwh34qcuiu7ooc2qnvlhuvexzvqkrcsfop@mhz26t5vu35p>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-2-guodong@riscstar.com>
 <20250411-confider-spinster-35f23040d188@spud>
 <89b6142bacecd4a7742341b88dc1e28c4454527a.camel@pengutronix.de>
 <CAH1PCMZnJDcYKJR35WirQT95hte0NWvGBe4fjDuyZEgagvunAA@mail.gmail.com>
 <20250415101249-GYA30674@gentoo>
 <0bbd2842-72bc-47a7-832a-fc8833163e32@riscstar.com>
 <20250415122807-GYA30943@gentoo>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="drktpjdibffse2jk"
Content-Disposition: inline
In-Reply-To: <20250415122807-GYA30943@gentoo>


--drktpjdibffse2jk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/9] dt-bindings: pwm: marvell,pxa: add optional property
 resets
MIME-Version: 1.0

Hello,

On Tue, Apr 15, 2025 at 12:28:07PM +0000, Yixun Lan wrote:
> maybe there are cases that users don't want to issue a reset..
> so, want to make it optional.. I can think one example that,
> display controller is up and working from bootloader to linux,
> reset it will got a flicker picture..

Agreed. You can just deassert the reset at probe time. That shouldn't
interfere with a PWM that is already producing an output.

> GPG Key ID AABEFD55

If you advertise your OpenPGP certificate, I recommend using the long
id. See for example https://keys.openpgp.org/search?q=AABEFD55.

--drktpjdibffse2jk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmf/PaEACgkQj4D7WH0S
/k6ooQf/d4DhhdyM4QPOcTmcUpZ8HOxH7CFCD701mRLpmOlq1dz3/Mtz5tO4wLL2
nvfA4N7zRagUW8grFQIpENy3IFx5DP3Rdg5PtVELqlqPrOW+NqTTJGslRBeIAoQ3
0rybTAJEutOM0DPeL7Ay6iGy78VV/Qosh7dhFUWmzxeF1IBHry2tm+euAw5wKOzP
PNPY/S0CfuOhb2G1ivYYVTBV3fsgYT5G+VfTJyR9/Gkf7F9yKMbX0LRYcG1LM8Ox
0ilgkvwEu9kt2Au+q6PivMLURHJ28CtG1Fl+Qn50PZm0witW6kFfQqSA3WN4z6rz
ueBYfIz0tcqYQIjClrgXnesRcLI+KA==
=8FCS
-----END PGP SIGNATURE-----

--drktpjdibffse2jk--

