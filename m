Return-Path: <linux-pwm+bounces-4443-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4789F99F9
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 20:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDEDF162FE7
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 19:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279E421E087;
	Fri, 20 Dec 2024 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgswXFQo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767721C174;
	Fri, 20 Dec 2024 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734721857; cv=none; b=psU8P1GfnfH+QnCuJ8biqjXjiq4j1MlSJgErBKyWMY7c0jn5DNnSnm8uV/WrYKeH2xaCU2JcGOn0qS0eI/YyjpGST5X4zGQqr3T3JZJAm0+s4qkiCZwIv5ZPLD+VqvBJwD0Y9icBelhWMGQUJoXh4v23Mmb7epInVVxoMK5Qx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734721857; c=relaxed/simple;
	bh=BfmcZeDZXIPOPuAc/Sy/Gwvm0D6pO7FfLx8A2nWZKLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8+Q9O3UrvNNqutdZV14ryEI852AhVlyT0OnhlpGIG12DTD8eXchZ/mL2C9mFYx2FiDY2ldpeS5yk/v28OezgJd7/NzAUTYQGyqIywDF4Tq0VaHdEpMqL2UQNJlp5redf5JfP7nuq2sdIKtg0QEQ6w09Z8xFoox2DeGaH9D6HOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgswXFQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F028CC4CECD;
	Fri, 20 Dec 2024 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734721856;
	bh=BfmcZeDZXIPOPuAc/Sy/Gwvm0D6pO7FfLx8A2nWZKLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgswXFQoUGmyvq3fMFFCPRZlleWa1DhBULsFMf8EquPfthsOg30aTq8AvIOliPfhb
	 maGtyizEHFr2ccStUakpuEpKH0k+b+P6nnFoODaZioD8Px/aSRC2GiwDJ5W5GZSvHr
	 o0V3ApwLhsnHLQPuBX2yLQlXLqkZZS3SgDQXwJt9/Xf/0lDKw2WxKHGIymaOEUX6M7
	 JenlQmzbZrcPVMRigyRBuOrkORIpgnZyXo8INxxcUY4tKzo+YDSm+0AgcPTS8lLewr
	 TLINI92M11pab5F7NGxQ+SOcknuP7du9qy+WbUKjzVWKM0LgEKwZfJNLOOyBJnBtqe
	 TCbstq96llDkg==
Date: Fri, 20 Dec 2024 19:10:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adf4371: add refin mode
Message-ID: <20241220-work-attest-d842adf74af3@spud>
References: <20241220095620.4918-1-antoniu.miclaus@analog.com>
 <20241220095620.4918-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BqW5FKGWfU8oK8bj"
Content-Disposition: inline
In-Reply-To: <20241220095620.4918-2-antoniu.miclaus@analog.com>


--BqW5FKGWfU8oK8bj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 11:56:13AM +0200, Antoniu Miclaus wrote:
> Add support for selecting between single-ended and differential
> reference input.
>=20
> By default the single-ended input is enabled.

You can, and should, add a default: to the property then. Nothing in the
binding says what teh default is at present.

>=20
> Input frequency boundaries are change based on the mode selected
> (single-ended/differential).
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - add option to select between refin-se and refin-diff
>  .../devicetree/bindings/iio/frequency/adf4371.yaml         | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml=
 b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 1cb2adaf66f9..f927d3af9f43 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -40,6 +40,13 @@ properties:
>        output stage will shut down until the ADF4371/ADF4372 achieves loc=
k as
>        measured by the digital lock detect circuitry.
> =20
> +  adi,refin-mode:
> +    description:
> +      Choose between single-ended or differential reference input.
> +      refin-se - Single-Ended Reference Input
> +      refin-diff - Differential Reference Input
> +    enum: [refin-se, refin-diff]
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.47.1
>=20

--BqW5FKGWfU8oK8bj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2XBPAAKCRB4tDGHoIJi
0mEnAQDOSYzTQd7+LscgrkW+lVt8hXjEbwujRNZdQGUJZqhOGAEA3rWKBdphS6tL
mT4qPAIs9i0Ppfn5S4DCVV8GVaVpzgA=
=nacv
-----END PGP SIGNATURE-----

--BqW5FKGWfU8oK8bj--

