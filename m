Return-Path: <linux-pwm+bounces-7315-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 714DAB572CE
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 10:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DC716210F
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1097D2EB5D5;
	Mon, 15 Sep 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKxBfeUv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2E2727F5;
	Mon, 15 Sep 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924703; cv=none; b=ndqp4qH09MFFvkc76nzh+r0z9Axv1SYE5T4QeaHV6oeudDcNdnYcYZZ2yg+TOrEzjptWRawTOykC/i+T3KSf/wbctgZSHXb6ER6EcHg1T0kGL/7gI4JvQNFiBPzuBSjlGlj9cus7q2qlWgw9CepF4X+DgAO694/OXkBhtMCdt8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924703; c=relaxed/simple;
	bh=pn3KOaP+bzbLsKtQz+c6VUe9G0WP+rbgfvOthuv4F4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skLWUrQ+IF0du9W5yvy5LoN1o7L6tnn8VG3J+aqkQyUx52RvdyujAC2S5bllPfyogo2kHCL+4LzTYwiIqlFB5t7sTrNGcHkcOHJTvO8unlTWHytQwgzXHqwUToaNxnnC+D1zPcpwO2oFdHkoL6GtoHQlvf6zqeUkbCPd8nV2Y2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKxBfeUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19164C4CEF1;
	Mon, 15 Sep 2025 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757924701;
	bh=pn3KOaP+bzbLsKtQz+c6VUe9G0WP+rbgfvOthuv4F4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKxBfeUv2uqV1gQyLnahEugBcH/mb/NVbnOoWodG89kEPsf/5+1ps2UyLzGa5/83Z
	 x7FYfyAV8Q4RPTsM7UHPzL34s5AzsX9sFV610inQVBfg5iIOSYKWnWzb/3SoIabgoo
	 JHohfo/x9gqwxaOFWb69mqiyCii4Y/cHmZkFm5rYFfseG8tjLD01A31epEQ70cfBX5
	 +1R6AiBfEnGuniN6iT/UUEuSJLG6/RaOSg7QyVnMI+hVi8QEF+mKxkSeQHwU97TtEX
	 GjRBL3bnRuc2zHP++54YfWR/9Lkm8jHUfT51gypkL1L+LcjUIDi0q9tIj7zcMAlLFL
	 EEtJfSTOOI6wA==
Date: Mon, 15 Sep 2025 10:24:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: pwm: samsung: add exynos8890 compatible
Message-ID: <b73vhk7jmt4pf2sr4oe56eum27fvydnvoc5q32qatbxrmoyknl@jl6afgispecg>
References: <20250914132033.2622886-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mesynlqvfl7e7g6c"
Content-Disposition: inline
In-Reply-To: <20250914132033.2622886-1-ivo.ivanov.ivanov1@gmail.com>


--mesynlqvfl7e7g6c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] dt-bindings: pwm: samsung: add exynos8890 compatible
MIME-Version: 1.0

On Sun, Sep 14, 2025 at 04:20:33PM +0300, Ivaylo Ivanov wrote:
> Add samsung,exynos8890-pwm compatible string to binding document.
>=20
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Doc=
umentation/devicetree/bindings/pwm/pwm-samsung.yaml
> index 17a2b927a..97acbdec3 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> @@ -31,6 +31,7 @@ properties:
>            - enum:
>                - samsung,exynos5433-pwm
>                - samsung,exynos7-pwm
> +              - samsung,exynos8890-pwm
>                - samsung,exynosautov9-pwm
>                - samsung,exynosautov920-pwm
>                - tesla,fsd-pwm

Applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

as merge window material.

Best regards
Uwe

--mesynlqvfl7e7g6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjHzVgACgkQj4D7WH0S
/k6u8QgAhZqtoIqw0fwOzEGmM67GX0Tkhoe3lLucE4prNZn1m9W7wW5niWTxxW1b
hbpdAqLdakYKjvJq+y/U8BJ0QPVtFfXY26mVY64EdCo/bQz+jJ2bEA6jT0Z1Lv1z
/ZQOXiEx4TmMYi885zl0zBYb6wve0l0eQHzUs3+KdYTHYZ0M+LV32JxROUj2Ruk3
YmRgUDYTk5id5e0kTX9ozd9gSLpMBAEh1yHaIYiGW06U2KAcRf4uEgOp7R8yiJ2t
Ms1Viv0LDPjHUwQSxiajHosvp8DNbh1G42bOxuQnAbJGKW0jmFodjvBa8DU2QuOV
sjMF0001RDHuax8jphkJmHjXPIJI5Q==
=rd6b
-----END PGP SIGNATURE-----

--mesynlqvfl7e7g6c--

