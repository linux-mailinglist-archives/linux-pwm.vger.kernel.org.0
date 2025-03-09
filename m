Return-Path: <linux-pwm+bounces-5127-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3B6A57FFF
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Mar 2025 01:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630ED188BB7F
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Mar 2025 00:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407AE4C83;
	Sun,  9 Mar 2025 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be4m0mGT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6D4A3E;
	Sun,  9 Mar 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741479890; cv=none; b=m4e8NLQvqHlRCzsRnbtg35V/YGo3zBwPQRr2yc4vkXIUvQENGwtsLR8Cpvpn5v4J/LwOGt0c7of8DUqUHgClraF+5PrQ8VMn9BQ+eYOeqp7nyi0bW9c+9hvg6ePQ07XNYYwEeeM31sQQW4c98Na5lkWdwitS+oBIPUGU0YuQA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741479890; c=relaxed/simple;
	bh=szqCjg4d8QsrF+kYbNSWgnbNPQ3W+ripzXsLT+GOp7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMExjbvuKWku+em4/TtOYvzVpQHX+LOajm0RoQ+MeHUwwLAjlythXHi9oTuSvVl+4Zo32qqH1IDhI97i6CYk8HecBkNxP2GGJGiIg4f9GyWb/bJteIXUW1B9Bs3nk9N4nq20tyyGYAhdjTiCpsYtB9rMz2/0PTQTxKKwEHjViyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Be4m0mGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35A5C4CEE0;
	Sun,  9 Mar 2025 00:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741479889;
	bh=szqCjg4d8QsrF+kYbNSWgnbNPQ3W+ripzXsLT+GOp7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Be4m0mGThOYM6JcXqk8+uCCQv6Ltc1Zpke8d5hMkVHlxB0l6HdKQxVCG3IpCuqbky
	 adQIKvBUBLCy/Pa17Ab8DG8QoudztNygRbTGYjoqpEQh8liSD0ml0x7rV5M6XfSOH4
	 8XY7TSIOXqi3N8Xn7PzN349nXzXJFf1i+ewclW1N88Bn9cbrRYHdyXZlE2U3FcycIy
	 r8PyRPZjyicCKZIS9w2ZhsE0jXfr3zmzMHxILXUtLyUsRWgfCff5nilcKeC3qiWO/o
	 3HRHrZ7vZU5HFDEttyxmSuLbSkEeGamw9/lhLB+Wweam0CWtFKxkXITEeRMOFGwKTI
	 UQO0pbMTpRjhg==
Date: Sun, 9 Mar 2025 01:24:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Yao Zi <ziyao@disroot.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: rockchip: Add rockchip,rk3528-pwm
Message-ID: <dit7oqsrs2g5rxor6aakprqw22yyovvcel5tnd2cteydtpt7zg@ndf4cmiamoit>
References: <20250307120004.959980-1-amadeus@jmu.edu.cn>
 <20250307120004.959980-2-amadeus@jmu.edu.cn>
 <pnlkcc2rl7fegltovgtvp4xdxhonw72rclvhn7qmvb7xyuullm@xf5x6lcigji3>
 <5942715.DvuYhMxLoT@phil>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z34uotnwfhj7flql"
Content-Disposition: inline
In-Reply-To: <5942715.DvuYhMxLoT@phil>


--z34uotnwfhj7flql
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: pwm: rockchip: Add rockchip,rk3528-pwm
MIME-Version: 1.0

Hey Heiko,

On Sat, Mar 08, 2025 at 05:25:09PM +0100, Heiko Stuebner wrote:
> Am Freitag, 7. M=E4rz 2025, 18:07:47 MEZ schrieb Uwe Kleine-K=F6nig:
> > On Fri, Mar 07, 2025 at 08:00:03PM +0800, Chukun Pan wrote:
> > > Document pwm compatible for rk3528 which is fallback compatible
> > > of rk3328-pwm group.
> > >=20
> > > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> >=20
> > to prevent binding warnings it's probably sensible to let both patches
> > go in via the same tree at the same time. Feel free to take the binding
> > patch via rockchip/arm-soc.
> >=20
> > Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
>=20
> You already have the rk3562 binding in your for-next branch [0], which
> could create merge-conflicts later on.

Oh indeed.

> This patch already contains it, so should fit neatly onto your branch.
>=20
> And binding warnings only come from linux-next, so won't trigger as the
> pwm will feed the binding there too :-)
>=20
> So I guess it might be better to take the binding through the pwm tree
> and me then picking up the dts patch.

Fine for me, so I applied the first patch to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E

Best regards
Uwe

--z34uotnwfhj7flql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfM37oACgkQj4D7WH0S
/k75Swf7Bf2agH4VhhrJhceAjdIf6UQBP4yoTIlhuCQDNgORf85O2aCq9ThJxGAc
CY2k7Hkupfg6o2VHtsaIpRv9hBxyvKUIejmE1bS575NuAUAsyTya32Wsjyjyxho0
0Hee8EhcDdcsZ9cZW6pYnoJkPlFrPTT39WRG3VRW8m3nS4Qb77HKbu/6YRjZoKVQ
Hw/yk0FI2YP9rvIpT6qf5e1TdWKzB25Mqt9A0n2C9ureAOso8ufB+P1vHX5lb4I4
bI6Iemr0pvmAwC3qAzDJ/oKldaOKlD5pUFofTyPy3YWXpTKknHL9XnNEPOBQ5P9S
RLq9fYax8rVmmepGRTC6XluJOCDk+w==
=iOg2
-----END PGP SIGNATURE-----

--z34uotnwfhj7flql--

