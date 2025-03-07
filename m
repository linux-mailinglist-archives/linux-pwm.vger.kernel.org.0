Return-Path: <linux-pwm+bounces-5122-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F3A56C3B
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 16:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF1227A3819
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2993B21D01B;
	Fri,  7 Mar 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfsqKkHU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0001121D002;
	Fri,  7 Mar 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361730; cv=none; b=DZXjjl9ZZmxSimEihUHEzjR4d2qszQiDLaNcXMyXRNUyq0/Zt/LhqoA5SI7kwIz4jhNuwCT7S6AunhFER+8p8kJ7/dm/XpBWCTq1VZvETjZBuF5BeJ/5DgjJSFPxN2UoObsRq7X3k1sDvrGwIQaFZzU0w9+OX94JyupMNe6QUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361730; c=relaxed/simple;
	bh=+NBaiXMA7TB4yM9FUBKC0Vpf3PO8/vw0zeJ97JH5BWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlviDtqt3JA/vjaOY6xkDb5+8yWDG+5MTyKZ/m+meIV4r9MXQIYMNRnwTUQHuywt7S6ydEi92fOWVfaaj5CHKKZ5AlxGFA15K0pGGKyJFNQRgDFV5+ck3l1Lc44QIENHbsMe5HaaBiK6A+LjVN1yFSETB1iAp+UP+mDpNQXpyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfsqKkHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B39C4CED1;
	Fri,  7 Mar 2025 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741361729;
	bh=+NBaiXMA7TB4yM9FUBKC0Vpf3PO8/vw0zeJ97JH5BWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YfsqKkHUjw9IIklBMftnuGiGHxcFvD4TS/2lzMv1w+m/F+mfT2YacH0ItyIeOhy1j
	 ttKrUIYShf6jDDT0/2Gn6TZAxKgDS3b8rDJM5HQJ5Qjdv1vpwAewV11QbmQNtQ3Ziq
	 m/wvq5J+qcXpWKyQumRts24nj7rvj90H9be4HdZoP3GgXWOvvJKRW60zsUqG3vewk4
	 rtfGxEFN++FcbXk3EU8Ib3Ks8nKFgncADKPYJUJYsZxa2Ky1+TLCtAeYzYPucfCWZo
	 AFYS3+2qgLOk5tBqBEH5tzvVfNQyhGvb8+w9a815//7j8oXcOcmpWA+PDIkq42gPRQ
	 NFY/riNN7NoJQ==
Date: Fri, 7 Mar 2025 15:35:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>, Yao Zi <ziyao@disroot.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: rockchip: Add rockchip,rk3528-pwm
Message-ID: <20250307-paddle-zoology-89858b29061d@spud>
References: <20250307120004.959980-1-amadeus@jmu.edu.cn>
 <20250307120004.959980-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Afd+EhsTE5IatMg"
Content-Disposition: inline
In-Reply-To: <20250307120004.959980-2-amadeus@jmu.edu.cn>


--/Afd+EhsTE5IatMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 08:00:03PM +0800, Chukun Pan wrote:
> Document pwm compatible for rk3528 which is fallback compatible
> of rk3328-pwm group.
>=20
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Do=
cumentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> index e4e1976c542d..c8cdfb723336 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> @@ -30,6 +30,7 @@ properties:
>            - enum:
>                - rockchip,px30-pwm
>                - rockchip,rk3308-pwm
> +              - rockchip,rk3528-pwm
>                - rockchip,rk3562-pwm
>                - rockchip,rk3568-pwm
>                - rockchip,rk3588-pwm
> --=20
> 2.25.1
>=20

--/Afd+EhsTE5IatMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sSPAAKCRB4tDGHoIJi
0m/eAP9rX1JDmngdihmkL/YjmxTR+sVxZMPjO2SZ0tmi4POUjQEAq56oMRBUG7s1
0HAle8NRwAy5t4/NvjvcQoi/XxOk7Ak=
=gUgZ
-----END PGP SIGNATURE-----

--/Afd+EhsTE5IatMg--

