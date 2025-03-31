Return-Path: <linux-pwm+bounces-5311-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1458A76989
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Mar 2025 17:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE35A3B1821
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Mar 2025 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D98214A93;
	Mon, 31 Mar 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hefcJv3c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9221149F;
	Mon, 31 Mar 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432743; cv=none; b=DX96jtWL0nhoGILfQnDFnQO5ZXdCYmDo19JbbZHLFwDKv5i8HB/FAy4Gh5ehFSrdcueQ5pH6o5nc9j6tc89R/4fTendX78y1uGjqwaaTkFDtulag1/Kr0PGST2xAUxq9IxXqzq+JVfixATMKomoYz3MwlPw8IIGbCgMBBxAMDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432743; c=relaxed/simple;
	bh=zGY3xRyPG/yS4BfdsHLhX6PG4ziCO7wO3pzJu+4Qa9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdhMrgDmh89pE/Ccrdb1aB63t/RfC3a7ckqjEZAg6B9/pF0CAWwGukvVu4Hcs0mHYXDk1nHD+/EBmlaEekoF2etEFWrGBk14JO5+n1WakJ99Zh5AsDnI/sC3WdhZ+L9UM/cF1TrSwwdHNlKeNpYwJL0IMlB2fHvcSiLceZ8RVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hefcJv3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AE3C4CEE9;
	Mon, 31 Mar 2025 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432742;
	bh=zGY3xRyPG/yS4BfdsHLhX6PG4ziCO7wO3pzJu+4Qa9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hefcJv3cfnQq/doKjqM7aXFpwnrYXPK66t+fv1gzRXwOHadQffCsFW0AMxQxb4YHL
	 yKKOZimb7wWSELhrP+aiUV61IWvI8lJAQ66n7k4GJnSVeODNTm8BZZtFr+uTqZ3TAM
	 z3ThVGpOLA6AObMLESNLD7uOUXmYoE72wSBIhrM5YfsTwL2TjJzwF1t60cWwIfHcyU
	 NM4zrZmdgSyoP5buSo03YPq5obqJ54b/DHUrDT3mscTB+BNdato+T7fRDF5Xa5VRTE
	 zsHKfuDleXop7PBUmGXjyJjBqbMf2YhMSE1HJ/V92jRbkHoJnQY+d6+bhCOszVEA9n
	 FMkEfinRzP4ig==
Date: Mon, 31 Mar 2025 16:52:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v10 0/2] pwm: Introduce pwm driver for the Loongson
 family chips
Message-ID: <zfdhcdy27q5dhaezc22bmx3dnmn2avazsfbpsd4k5lyjikmxnd@dsdbbokjjjag>
References: <cover.1743403075.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6gqwvrz4yr2mbh5z"
Content-Disposition: inline
In-Reply-To: <cover.1743403075.git.zhoubinbin@loongson.cn>


--6gqwvrz4yr2mbh5z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/2] pwm: Introduce pwm driver for the Loongson
 family chips
MIME-Version: 1.0

Hello Binbin,

On Mon, Mar 31, 2025 at 02:53:48PM +0800, Binbin Zhou wrote:
> This patchset introduce a generic PWM framework driver for Loongson famil=
y.
> Each PWM has one pulse width output signal and one pulse input signal to =
be measured.
>=20
> It can be found on Loongson-2K series cpus and Loongson LS7A bridge chips.
>=20
> Thanks.

applied as v5.16-rc1 material to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-nexxt

Thanks for your patience and effort to wait and act on my reviews,
Uwe

--6gqwvrz4yr2mbh5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfqrCEACgkQj4D7WH0S
/k7t8wf+MMqHgPpt2EBH/t+p6qY3YOLCLf3bxa9Yty7Q9PK0KraOoEaB+Gih5Jpn
aLIYsw0//EPew61h+gW8JE3dJqZIipcZnQYbFfBmqcxSqG6zK7ktxqFWG9U9mQQ4
0Q999jIsI/bHSABjHIcVEMJ4FG9i43JS2G6aGux9zFxsD+jZVVAp6t1iGZNRv4Pf
qK//Noo5BNWgePk6dGNireKrt8wl0bz1J4cku5rpwsLKBWTpr7Gm28E+zNQD8/b/
AY1lEhwRryp4qEs24gKNo7nms2GMYORXzx0bpcEcY25uAELvWUbDTnu38wy8DKSw
QeZCDqizRVunBR7YY3TQmTGAn8yyyQ==
=EivV
-----END PGP SIGNATURE-----

--6gqwvrz4yr2mbh5z--

