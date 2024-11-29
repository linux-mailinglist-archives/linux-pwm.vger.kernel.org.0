Return-Path: <linux-pwm+bounces-4155-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C7D9DC0D8
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 09:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92AFB210B7
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72615C13F;
	Fri, 29 Nov 2024 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipCNosFS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25983AD23;
	Fri, 29 Nov 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870265; cv=none; b=OYGXWCY3AKav/WkZSmv3aDBCCupfIVmc6kG2zcpZNjKfF4y8/DF8klJAV8bASnUvZi7XV+u4PFoipibZmiJbbDzC2HW3dX4QrnZc8luwIjh6DirBOcx6iSclxcBhhtfDoZVnSGD/vpFstLAqxGKXcI/TgozEaHLOcnVCa6ROo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870265; c=relaxed/simple;
	bh=GRmj3eHMNeOtMY4gEKVku3sSlV/z01FZfAlVbD5QLw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVIqlStZWy/kaZbobPZrhj1swkU3MUDXwCm+9Kj3kMr3DB8WK8wm39xFMWBmf6Jx1L/sPoIDevNPTfL0nnW2TJOERoOqxpSy3EBnWCiPoWEbYr0lavTl8ayuIyjqNnCX4Or5gMuiXuZ1WRcScKAoUlCDAZzOK9lBx/cBdPJaztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipCNosFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE74C4CECF;
	Fri, 29 Nov 2024 08:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732870264;
	bh=GRmj3eHMNeOtMY4gEKVku3sSlV/z01FZfAlVbD5QLw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipCNosFSBSXRbiXzI0jlk6eiBHIjZoGpNEFT5UffsOy/LSIwcxznZcAGfecBLnigd
	 m43p0UQpSX0cRRb7s41m83Ov4Fgv/M3p153l3sJKJJYo/fXLnRJDoIyoqB+oIV1tzI
	 NafxVKhZy0dzLFzzgQ6skv6s01AO/keh/XTRwAs7eBr9UoBTHsgk6Pu+YxST1eg2Wk
	 vSkVk2N24e3uEGvyXjiAhdlLU333dq0atsfiu7DYDzNGo3UJi0Q0LEp+BTiXptr5Fa
	 EpA4zGzCV+qbUB6h+ecRsbP2Z3n5cM3Ab9ZaWWcSOBAyiZj3589HUXgy4CH5QpexWw
	 pIIFPqLBdHybQ==
Date: Fri, 29 Nov 2024 09:51:01 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v22 1/4] dt-bindings: pwm: Add RZ/G2L GPT binding
Message-ID: <7r7euw7h5fln3y5hy3zkrm4n4fafh5ww3ydxnwcpcjhbpb5vza@fleninlwsaqb>
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vmlmb5div4q3ytg4"
Content-Disposition: inline
In-Reply-To: <20241018130049.138775-2-biju.das.jz@bp.renesas.com>


--vmlmb5div4q3ytg4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v22 1/4] dt-bindings: pwm: Add RZ/G2L GPT binding
MIME-Version: 1.0

On Fri, Oct 18, 2024 at 02:00:42PM +0100, Biju Das wrote:
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 378 ++++++++++++++++++
>  1 file changed, 378 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml

Wow, quite a big binding. An astonishing amount of irqs.

> [...]
> +  '#pwm-cells':
> +    const: 2

Please make this 3. Otherwise no objections.

Best regards
Uwe

--vmlmb5div4q3ytg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdJgHIACgkQj4D7WH0S
/k45ygf/WMLrMTUX76dI+EP+CrBFQEt9HFkA044PNUL49z7ejcQoFq4A9XhuDOO6
umOfPsioUSuIyelW1QgDM9u2D0iQi/3rR6ehOSZRTe5FQ7mFvROmwsaPARnhu7Rm
V0U9d57MV2ZsRzzXtrvU5qqEuio1Q7Zn3tRrmrtlal0s6PW2lejwqFSK8/aYUEjf
QugJfJs/sMSdp7CR/AXeF8AeUg9rHJwzTtxSsdw2vbly6xVObbaTQpT6ScUV5dEg
Or0e0bLnEC4MfLdpmodvBbeepw1msSkfBjBCw0fzp2U+RdP6RxXE9MIkxR29g96C
Hs9o5ODzUFbcTlEqlOx9w+7/aIdfwg==
=YakD
-----END PGP SIGNATURE-----

--vmlmb5div4q3ytg4--

