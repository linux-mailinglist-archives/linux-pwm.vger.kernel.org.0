Return-Path: <linux-pwm+bounces-5462-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FACA86386
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 18:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453751B681E5
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 16:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E882221CC5D;
	Fri, 11 Apr 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDjrLT0g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B697626AD9;
	Fri, 11 Apr 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389787; cv=none; b=KL1yvNkKneT3o9Lcaoox6/4vYVOyI7Hy7bxcQr1Pqz4SFGElEQox7xnp5OqkwC0XTEM+MiQrHcgkGA1rmO1WhKk1MWr9FSU7fsyNSHA/kGDO7Vx38GH8VqPBLncc3YbN/l5491NQY4rsGmrXk/mul4KIVklGAbD7KtTkl2IZ5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389787; c=relaxed/simple;
	bh=tR3UHpCXzeA9///t/Dn2xzAjjM6Zw64YyTco64txTrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz0imBqxGyYAaz+vx7xImMT0GSwrXzN44SantunohBiQTH/OVaq7oxH1rJCWZ0JQLwZ5X3dx4xgnBy4K/gFCaXcVhLYG7gOBpeDXmnIeu9TdCSAfNzRvA+odcOMICBsZxTx/JqpV7ifkpBl5wx6OMphmubPsJQXRyXl7WAJwR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDjrLT0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F30C4CEE2;
	Fri, 11 Apr 2025 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744389787;
	bh=tR3UHpCXzeA9///t/Dn2xzAjjM6Zw64YyTco64txTrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDjrLT0gTM9ncpI1oDN0t7XKA+vnlO4rKWcXymKi7KptWCUHj7CnlK+tvKnHsymDt
	 QSK0KqJdw4SN5qSuSk3OlQ4QaDabTwjf7G9jVmUdsu378eMRc7mKH0N8JhxRjgjUNU
	 uBFTUn0rvGd1efZAwApI8XqmH3zj0C4Do/sD1Vbh5QWFZhbs1CPeK6K97G8zq3YRac
	 GMm2mQP8Fhei5thHit7fEXcBf/8ulfaY4aX3uwM/tr5rLpg+TO4IwCZYm7hqN6VhdC
	 a6ju+/c6cHfYF4ewuw5JF+CSRFa22mrr/RCgC4uEERQfulgCI286FXb0e8/3ACZ86Q
	 8VtNYJUp2zUlg==
Date: Fri, 11 Apr 2025 17:43:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, dlan@gentoo.org,
	p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com,
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de,
	hal.feng@starfivetech.com, unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr, elder@riscstar.com,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH 3/9] dt-bindings: pwm: marvell,pxa: add support to
 spacemit K1
Message-ID: <20250411-spoiler-dispatch-8f709700a996@spud>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-4-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LUVx89P2ckqnLgNF"
Content-Disposition: inline
In-Reply-To: <20250411131423.3802611-4-guodong@riscstar.com>


--LUVx89P2ckqnLgNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 09:14:17PM +0800, Guodong Xu wrote:
> Add "spacemit,k1-pwm" as a compatible string to support the PWM
> controller on the SpacemiT K1 platform.
>=20
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b=
/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> index 9640d4b627c2..1e3cabf6a89a 100644
> --- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> @@ -19,6 +19,7 @@ properties:
>        - marvell,pxa270-pwm
>        - marvell,pxa168-pwm
>        - marvell,pxa910-pwm
> +      - spacemit,k1-pwm

The driver doesn't appear to handle this differently to existing
compatibles, why is a fallback not used?

> =20
>    reg:
>      # Length should be 0x10
> --=20
> 2.43.0
>=20

--LUVx89P2ckqnLgNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/lGlAAKCRB4tDGHoIJi
0rpnAP9M2iA7vkmJyuuQgjwKcFc40rTRbCJ3nRdKJhlWdCEsgAD/TlkE0t6j/G2z
QjLG3R/QWpuj0Zj2vbNRzmF1FzCpQA0=
=ulBE
-----END PGP SIGNATURE-----

--LUVx89P2ckqnLgNF--

