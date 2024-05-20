Return-Path: <linux-pwm+bounces-2184-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF838CA0DD
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 18:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46F9B20B3B
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D755713776F;
	Mon, 20 May 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIWN85ZY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC14E552;
	Mon, 20 May 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716223784; cv=none; b=UroIKQyfViMpT/2yluVSxtYxW0RGhc4RFuN9Eau6m2PjGfvt7c705xFBJV7lImx+xRk89RW4iTPJKgyTldSrZuY+cfYaE5O7PCw/ABkbbJZJwpCZnDyr/0T3lwcwkxt05MPY32pLKhYRZ3s2cHIaDwW4RclCvpZahQRJfNKXje4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716223784; c=relaxed/simple;
	bh=7lK2EaXV5Z2wVlx+P0QHezS3v+W1rlKWdQ50owAmfzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyDjLLDPQVXmjJlqnpLGQ3ykQUmmlhmvEd+MWr2lqqJxrvE3/Y/qy440SiXzUpaRTQeT9k2Jxy5mevGmASF2J0TDdx2MA+LvrrvFzs7bkZAjYXzKwwd1c6qEGaUKVfi+Muo60khV7tMgNaCyfJqrTJ7LS4gs7jgIeHV8WBU3ZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIWN85ZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16C2C2BD10;
	Mon, 20 May 2024 16:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716223784;
	bh=7lK2EaXV5Z2wVlx+P0QHezS3v+W1rlKWdQ50owAmfzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIWN85ZYJBApTFKC24qc0/xj4LqoSoDqHlEmH5dJV5XMR31IE6caPYKGbUlK3MTnZ
	 hM/d2FPtwGk+52vmTUq1rO0PBzB9fIt4uJtipi6SctsUldq0++WlZMXtmpJCcRhCuJ
	 8PIhy3FMp1gphcDy9WrDKDrTK6R/CRUG9XmwuFtrR/VEUA+/akzpqV0DgUQRFcZp0O
	 Ax+3H2qtu3kA5bNbdPZ7Xz1NjHsn8f0utn8h+D6XvjOdthMyB6kgr734KFeQ50MLc4
	 iyVom14jUEHu16DC7l3M/n1Znli2o96gWYJfBNZ1TowBtvZjZY+vQsdQC1NcpDpSWj
	 BpAqzkB9nXyhA==
Date: Mon, 20 May 2024 17:49:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Message-ID: <20240520-pendant-charity-a66a8d738690@spud>
References: <20240520030321.3756604-1-chris.packham@alliedtelesis.co.nz>
 <20240520030321.3756604-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FcZ+YKiVPcvShcYO"
Content-Disposition: inline
In-Reply-To: <20240520030321.3756604-2-chris.packham@alliedtelesis.co.nz>


--FcZ+YKiVPcvShcYO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 03:03:19PM +1200, Chris Packham wrote:
> Add fan child nodes that allow describing the connections for the
> ADT7475 to the fans it controls. This also allows setting some
> initial values for the pwm duty cycle and frequency.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>=20
> Notes:
>     Changes in v3:
>     - Use the pwm provider/consumer bindings
>     Changes in v2:
>     - Document 0 as a valid value (leaves hardware as-is)
>=20
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
> index 051c976ab711..99bd689ae0cd 100644
> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -51,6 +51,15 @@ properties:
>        enum: [0, 1]
>        default: 1
> =20
> +  "#pwm-cells":
> +    const: 4
> +    description: |
> +      Number of cells in a PWM specifier.
> +      - 0: The pwm channel
> +      - 1: The pwm frequency in hertz - 0, 11, 14, 22, 29, 35, 44, 58, 8=
8, 22500

The standard binding is period in nanoseconds, not frequency in Hz.
What's gained from deviating from that?

> +      - 2: PWM flags 0 or PWM_POLARITY_INVERTED
> +      - 3: The default pwm duty cycle - 0-255

Same here I guess, why not match the units used for the period for the
duty cycle?

Cheers,
Conor.

--FcZ+YKiVPcvShcYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkt/IwAKCRB4tDGHoIJi
0mfnAP9s9FF6jnmkLsPw4HMFWexogPLNAzkTcCtHtu3/XsAZmgEA6sGT8IN0+hkD
+T0zrkoU4WrbZN3jfYN5xXzTqQpeWwY=
=o2BQ
-----END PGP SIGNATURE-----

--FcZ+YKiVPcvShcYO--

