Return-Path: <linux-pwm+bounces-5390-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B886A811E1
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 18:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F043188078D
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7AD23E345;
	Tue,  8 Apr 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhMp3L95"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89222F38B;
	Tue,  8 Apr 2025 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128502; cv=none; b=hpm2m7zsO5+00sgglcYQhTECOHTr6agnPJudpZAMYKQbsxHN5vFaINdBu3HO3gAmYeMTik/Rt33JuAD9ij3LiO+NeZT+nVo1EsU0OddF6qZhuzOtyGmmoagG5/oiH9whwhJgljoKj02D9JhtwCmrBRry9aIsdfmy7chWdykSNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128502; c=relaxed/simple;
	bh=ckOi7tqsSO7KvykycTRL9CtPqRv/ASq7uban+AGPlrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpVZKw+HKoRLMpHu4scGMbeWcGihetUwSf2c5GGfnP4S8Xtkhl4gaJ75XUEY5M7vD2uJ4fNexBmzZOrA5rsbc7bbFgPPevYPX6IRXqDCjQwoX1h3z35famwuUkD8moKvg0GEenO2K43D7KjlWm56zWiwjlcIpcRBew9yt0893/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhMp3L95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3A6C4CEEB;
	Tue,  8 Apr 2025 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744128502;
	bh=ckOi7tqsSO7KvykycTRL9CtPqRv/ASq7uban+AGPlrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhMp3L959j1gmsrQtuaA2pU6O+vcxsQ/GjFmQORiv/4t1XmucuB7D9c0aUFv9TbSt
	 VY3TCIbQE/LjfJf6JlhJyXxAZgdzluIjdA5uRcXEgsUX5xCirJbir8FOJKtcA0DfGz
	 DY/YyD0h9wkh3f+VC8iLjwQGTwdx1+rZsVe5twn+03E+pSYbmopQVZ3Ys/mUL7PyCZ
	 JiG6D+DytWxgwDz80/bHD6oPKL2JUycQFvU9/P2xnaKkpSKeq52cXxqil2x3FuiHQ0
	 REmgxqP3yXoxXJk2IlcM2w9dMmMZqfZcGAo9v5GFLVGZsket2LnU2tXpy41zCX5nNE
	 BDbvVNHd8Qhkg==
Date: Tue, 8 Apr 2025 17:08:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
	kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 1/7] dt-bindings: pinctrl: rockchip: increase max amount
 of device functions
Message-ID: <20250408-deviate-common-7846a921ddaa@spud>
References: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
 <20250408-rk3576-pwm-v1-1-a49286c2ca8e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3HY2P3D0tNzBUcfu"
Content-Disposition: inline
In-Reply-To: <20250408-rk3576-pwm-v1-1-a49286c2ca8e@collabora.com>


--3HY2P3D0tNzBUcfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 02:32:13PM +0200, Nicolas Frattaroli wrote:
> With the introduction of the RK3576, the maximum device function ID used
> increased to 14, as anyone can easily verify for themselves with:
>=20
>   rg -g '*-pinctrl.dtsi' '<\d+\s+RK_P..\s+(?<func>\d+)\s.*>;$' --trim \
>   -NI -r '$func' arch/arm64/boot/dts/rockchip/ | sort -g | uniq
>=20
> Unfortunately, this wasn't caught by dt-validate as those pins are
> omit-if-no-ref and we had no reference to them in any tree so far.
>=20
> Once again kick the can down the road by increasing the limit to 14.
>=20
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.y=
aml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> index 960758dc417f7405010fab067bfbf6f5c4704179..125af766b99297dc229db1588=
46daea974dda28e 100644
> --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> @@ -135,7 +135,7 @@ additionalProperties:
>                description:
>                  Pin bank index.
>              - minimum: 0
> -              maximum: 13
> +              maximum: 14
>                description:
>                  Mux 0 means GPIO and mux 1 to N means
>                  the specific device function.
>=20
> --=20
> 2.49.0
>=20

--3HY2P3D0tNzBUcfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/VJ8AAKCRB4tDGHoIJi
0o+cAQC++yhzDEA1pD75hj4YsKzIeFWFw+DrbpYLeNqyLfXtlgEA/5+i3Yju2VbF
KzvzOSVA72JUCgJJIxDgw7JYzYv+HQc=
=xuix
-----END PGP SIGNATURE-----

--3HY2P3D0tNzBUcfu--

