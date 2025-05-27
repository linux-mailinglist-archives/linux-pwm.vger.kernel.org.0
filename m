Return-Path: <linux-pwm+bounces-6151-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98564AC52BA
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 18:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71EE178BF6
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7F227E7CF;
	Tue, 27 May 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbfWOvHs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB927A477;
	Tue, 27 May 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362374; cv=none; b=acVriErwERVkvpCMdGt22GtVdzO2Km8p2EW1X/J1SyWUKkKWnOYUK7/hm/Vxenc8tteBkIBuruJ0kyNzpOS/zrE891/qbmyVoQq+ruXTFgDga7opywiEBp9+Kiciom0sRK28p07e9KpthbE5ZtcKCmfJ36lKXGB03jSsT70wo3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362374; c=relaxed/simple;
	bh=GxIVaZFoqlqVil+CtwcC9E7UETK3do70uNSXMXX3VqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNT/eMeaLcGlG60c/aGW+XETqNIgwWAnr3tHheojOM8jZUI3WhkPNzBFj/LfTIdSrno7cfOFRCFgLiABJs9cKeoksZ1dSxJVbc9uXbVR9mXbJin+xYV2P7tqaY2KgxHFVtSYHJfAM7sTIZ4jA3/8LATjxDxsHWIUKN+8QpPHMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbfWOvHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A04FC4CEE9;
	Tue, 27 May 2025 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748362373;
	bh=GxIVaZFoqlqVil+CtwcC9E7UETK3do70uNSXMXX3VqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbfWOvHspa/22c/b2iPREaHWPEsd/SvfFekDE82YWtzInTaUiNIe3/Wp6r7vjCyC9
	 QvOWuYYo6tVYBMay0pCQEkfktEgQefIxMtiV6qrcPuBzntjwJtl3rP8iupnOmAPn/y
	 QziHnHrRc12xIlOGheI/zZmzSFkGCjgjGBNByLbLxyeFEdbtkNLfY+zdc3lk+UgunT
	 FtDU3RHgtmd0Wdwl0CeAm+1oWJykMUQBmJMnpr8yE3PU/pisGguLSAqKvXv8O84xnz
	 d8+5DNd2PgcwGlUPg8moCOuKPIk/GPgT9fYbILICLqfOoQftrCFNU8NpqH0iRX9rrD
	 IosYhNC+pjCgA==
Date: Tue, 27 May 2025 18:12:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, linux@roeck-us.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Message-ID: <jzxu6mcbxf5zwyirnb2jjpm2i7sln3v5mz3gyhc5xhpqexicvb@atrcjvh7wuh5>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="llkyqi6gjk3ekkpa"
Content-Disposition: inline
In-Reply-To: <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>


--llkyqi6gjk3ekkpa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
MIME-Version: 1.0

Hello,

On Tue, Jul 23, 2024 at 10:17:35AM +1200, Chris Packham wrote:
> Add fan child nodes that allow describing the connections for the
> ADT7475 to the fans it controls. This also allows setting some
> initial values for the pwm duty cycle and frequency.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>=20
> Notes:
>     Changes in v7:
>     - None
>     Changes in v6:
>     - Collect r-by from Rob
>     Changes in v5:
>     - Use nanoseconds for PWM frequency and duty cycle as per existing
>       conventions for PWMs
>     - Set flags to 0 in example to match adi,pwm-active-state setting
>     Changes in v4:
>     - 0 is not a valid frequency value
>     Changes in v3:
>     - Use the pwm provider/consumer bindings
>     Changes in v2:
>     - Document 0 as a valid value (leaves hardware as-is)
>=20
>  .../devicetree/bindings/hwmon/adt7475.yaml    | 35 ++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
> index 051c976ab711..df2b5b889e4d 100644
> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -51,6 +51,24 @@ properties:
>        enum: [0, 1]
>        default: 1
> =20
> +  "#pwm-cells":
> +    const: 4

I asked to add support for #pwm-cells =3D <4> to the pwm core in reply to
v4 (see
https://lore.kernel.org/linux-pwm/drqvaon5lb2ei3jqofutbr6demibyfdhbmr24sva2=
7gzpqdnon@fxa7rpl33iih/).

I'm unhappy to see this merged anyhow in combination with ad-hoc parsing
of the pwm properties in the driver :-\

> +    description: |
> +      Number of cells in a PWM specifier.
> +      - 0: The PWM channel
> +      - 1: The PWM period in nanoseconds
> +           - 90909091 (11 Hz)
> +           - 71428571 (14 Hz)
> +           - 45454545 (22 Hz)
> +           - 34482759 (29 Hz)
> +           - 28571429 (35 Hz)
> +           - 22727273 (44 Hz)
> +           - 17241379 (58 Hz)
> +           - 11363636 (88 Hz)
> +           - 44444 (22 kHz)
> +      - 2: PWM flags 0 or PWM_POLARITY_INVERTED
> +      - 3: The default PWM duty cycle in nanoseconds
> +

Best regards
Uwe

--llkyqi6gjk3ekkpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg15H8ACgkQj4D7WH0S
/k7FWQgAtEqgUb6AwUFfIVAEycbfhSikddkDLarrnlLWy0J4LF4ItrZ7Oc6f3OGt
/fpPJhO71bh/r5bePC2Svv1FmrCcvMhTBdGtdIjfvMhKzi7/ApLl/dM6v7UmA7y4
nwPpuLXoUUcs0jhJE9NS6gti8x2g8P+BOlZrV8uinozmYIZUmvL3vNI6w2SOQWE6
D46gwlmJ4u/8ykOFgf9/5E2lzEHJLd0/W7fGSDpoEynHsfiLNPOGWc1cycZtf2jt
tYgmu5gKM21/UWRNbZIGzgZfZjtN+fKYwtuQimt2CP08IUmstAKzxLjPJ1ApQ6TZ
TJpJrnrv/xQ57RrAh1qRyRcygshP3A==
=3n4L
-----END PGP SIGNATURE-----

--llkyqi6gjk3ekkpa--

