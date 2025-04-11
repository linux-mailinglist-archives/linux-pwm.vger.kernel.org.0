Return-Path: <linux-pwm+bounces-5463-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DCAA863A2
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 18:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934EF4E38F9
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1910F230D0A;
	Fri, 11 Apr 2025 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tffkgj6N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D991C230BF8;
	Fri, 11 Apr 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389866; cv=none; b=covmdxZwdx6Z5R7Rs9JLP+nbpDDV48inuaNztehVoNfAUc6nbE9mAsUbpwRC5uhLnDEuIovpwzFiphHGh/2Oy1wU7fCkww2Q67LFnLkr8PnQDUvAz/6Z2b6zImVaWwP+oPTUur53iCwaMOrzWxEzOvZnWpaQmjEBoqf6WdgIfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389866; c=relaxed/simple;
	bh=vdiIksur5hafltgBRqqsPovLfkEhiO450uZl4pz97yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGWMf+O/7ZIjNh4fVFX4XzD1pMvMBlDl7EkU3ljWgQ+VL56EPMb3KtOyFJdqX0lQxzcaVF5zXIh+7wFPpOxG8X+ljucJ6ig0L/wbxy2pVcMeFljoo9KMSxSkkXOzdsJyT13GPRkD0ElImVl+2g7scA6dEqEGZB8yS4J7vZfzywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tffkgj6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E6CC4CEE2;
	Fri, 11 Apr 2025 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744389865;
	bh=vdiIksur5hafltgBRqqsPovLfkEhiO450uZl4pz97yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tffkgj6Nb1m5i9EfqYQQ4obKfEilG0rIFW8F2x+NXn1o2EhQul4SIfYCGfoiaeDLU
	 kyqs9TiibfjQczE7BQCcVqQTDhfjDYS9yunXlrGX/HIIBvYlwu/Ggu0jQQifXntRp6
	 1ArPTDq8AO5eKV99YxS0R/emaMB0+dyeNBuOJO/lP7FRAYEBz3We5pidhZPeGMJn0U
	 0MSHEdi5X2A1X3bH6mHsgsoK+3F1CNSGug7w8RBJRiAwQfcsIpAe2NonCCMasUvlim
	 hagNPpjdcWPVCOxJPCh39JroOI5WYwSjctuAqGQm8EvKGVLSNFutMADH0qsJU9G613
	 ZdQ5EM8CGvVzA==
Date: Fri, 11 Apr 2025 17:44:18 +0100
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
Subject: Re: [PATCH 1/9] dt-bindings: pwm: marvell,pxa: add optional property
 resets
Message-ID: <20250411-confider-spinster-35f23040d188@spud>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-2-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JUAwALBWrI3B2Yuo"
Content-Disposition: inline
In-Reply-To: <20250411131423.3802611-2-guodong@riscstar.com>


--JUAwALBWrI3B2Yuo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 09:14:15PM +0800, Guodong Xu wrote:
> Add an optional resets property for the Marvell PWM PXA binding.
>=20
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b=
/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> index 9ee1946dc2e1..9640d4b627c2 100644
> --- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
> @@ -31,6 +31,9 @@ properties:
>    clocks:
>      maxItems: 1
> =20
> +  resets:
> +    maxItems: 1

Do any of the currently supported devices use a reset? If not, then add
this in tandem with the new compatible and only allow it there please.

> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.43.0
>=20

--JUAwALBWrI3B2Yuo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/lG4gAKCRB4tDGHoIJi
0tuJAQDXEtdWF2DQG6RWVHGrAVhfKiqaNW9k5WmrGO0XaKsN6QEAkVieGe1PP/zi
8ad/GJqyFMjAv/MSo0ty84ZjbpPoiwE=
=2MBi
-----END PGP SIGNATURE-----

--JUAwALBWrI3B2Yuo--

