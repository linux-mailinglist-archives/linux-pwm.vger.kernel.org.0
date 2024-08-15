Return-Path: <linux-pwm+bounces-3023-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ADE953584
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2024 16:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CD91F24F97
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2024 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6171A01DA;
	Thu, 15 Aug 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIH/NSNC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7A1684AC;
	Thu, 15 Aug 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732721; cv=none; b=IgBw+2Y7LBdf6ujqKi1DU2SYkBrdGrigUlKyECL/THZPkUZGAyLeh8Twuf9aVBIdr/+azphJIVPz/eI76R/+TLCKybxAZmfEuggeCIL6jQLbXMn8eDDdy15osu5dzDZY+PGPqfheKuWEhvmY00uTeEMKGq0stAgoOzv5n17qpNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732721; c=relaxed/simple;
	bh=k3UTEcJQzJQY4LxNoDzAK/SiM1woRUGDUADRkRRyGHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoRJ90ivqOmlhZW4VzOwGHSRDEi/njprB2nb/tAi/bxzdpTiYg48ufLJRfH1u4z8Xbr9ZN4Bx7ZysHsVtyazYWj5gykJoGdWp+RI74mWSjNjajN8rOJJS2JWPZ3uAhbmtxLfAw4lPOuVAOIVZFHgqpUNqys7uMGmgTY4o+qH0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIH/NSNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F960C4AF0D;
	Thu, 15 Aug 2024 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723732721;
	bh=k3UTEcJQzJQY4LxNoDzAK/SiM1woRUGDUADRkRRyGHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LIH/NSNCo2aNiYQvTHxh4IwPIcLBke3cjGULP+pg/k/Nmbrlw/pkIRmKP9tj5wJNz
	 f2X95GMDFVkINfY5j4HwKqIcYuFCwLDcd5I+ZAGbJ0+qvS3q30LL2baigXkshbXt/9
	 JszKli5b8ZtkgBcv9nCVS2FioFD2mjSV0fY2nCX6RayS8Jtp6BeYaVElTJI2yvCCav
	 gBG21UwR+q6NEL8+SA3Lw3UKyRIwGZX73R4XI+gdi37aaEUtHe1gLvdNS5AL2qAm+H
	 qmURzIfKGO66lsxcGk8wjZOdvzphuvb7RVuNMbhE0FMdD7rL3/R+R8ixeQww/cKiHg
	 GrpaVRvyxy5sg==
Date: Thu, 15 Aug 2024 15:38:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	20240705211452.1157967-2-u.kleine-koenig@baylibre.com,
	20240712171821.1470833-2-u.kleine-koenig@baylibre.com,
	cover.1721040875.git.u.kleine-koenig@baylibre.com,
	aardelean@baylibre.com
Subject: Re: [PATCH 2/8] dt-bindings: iio: adc: ad7606: Add iio backend
 bindings
Message-ID: <20240815-chatter-monotone-c1a00c246d1f@spud>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
 <20240815-ad7606_add_iio_backend_support-v1-2-cea3e11b1aa4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6HKhWcDgbvoBp7P3"
Content-Disposition: inline
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-2-cea3e11b1aa4@baylibre.com>


--6HKhWcDgbvoBp7P3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:11:56PM +0000, Guillaume Stols wrote:
> Add the required properties for iio-backend support, as well as an
> example and the conditions to mutually exclude interruption and
> conversion trigger with iio-backend.
> The iio-backend's function is to controls the communication, and thus the
> interruption pin won't be available anymore.
> As a consequence, the conversion pin must be controlled externally since
> we will miss information about when every single conversion cycle (i.e
> conversion + data transfert) ends, hence a PWM is introduced to trigger
> the conversions.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 75 ++++++++++++++++=
+++++-
>  1 file changed, 72 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index c0008d36320f..4b324f7e3207 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -114,13 +114,28 @@ properties:
>        assumed that the pins are hardwired to VDD.
>      type: boolean
> =20
> +  pwms:
> +    description:
> +      In case the conversion is triggered by a PWM instead of a GPIO plu=
gged to
> +      the CONVST pin, the PWM must be referenced.
> +    minItems: 1
> +    maxItems: 2
> +
> +  pwm-names:
> +    minItems: 1
> +    maxItems: 2

You need to describe what the pwms are.

> +  io-backends:
> +    description:
> +      A reference to the iio-backend, which is responsible handling the =
BUSY
> +      pin's falling edge and communication.
> +      An example of backend can be found at
> +      http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.ht=
ml
> +
>  required:
>    - compatible
> -  - reg
>    - avcc-supply
>    - vdrive-supply
> -  - interrupts
> -  - adi,conversion-start-gpios
> =20
>  # This checks if reg is a chipselect so the device is on an SPI
>  # bus, the if-clause will fail if reg is a tuple such as for a
> @@ -137,6 +152,35 @@ then:
>          - spi-cpol
> =20
>  allOf:
> +  # Communication is handled either by the backend or an interrupt.

This comment seems misplaced, but also superfluous?

> +  - if:
> +      properties:
> +        pwms: false
> +    then:
> +      required:
> +        - adi,conversion-start-gpios
> +
> +  - if:
> +      properties:
> +        adi,conversion-start-gpios: false
> +    then:
> +      required:
> +        - pwms
> +
> +  - if:
> +      properties:
> +        interrupts: false
> +    then:
> +      required:
> +        - io-backends
> +
> +  - if:
> +      properties:
> +        io-backends: false
> +    then:
> +      required:
> +        - interrupts
> +
>    - if:
>        properties:
>          compatible:
> @@ -178,12 +222,37 @@ allOf:
>          adi,sw-mode: false
>      else:
>        properties:
> +        pwms:
> +          maxItems: 1
> +        pwm-names:
> +          maxItems: 1
>          adi,conversion-start-gpios:
>            maxItems: 1
> =20
>  unevaluatedProperties: false
> =20
>  examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    / {
> +        adi_adc {
> +                compatible =3D "adi,ad7606b";

Just two space indent for examples please.

Cheers,
Conor.

> +
> +                pwms =3D <&axi_pwm_gen 0 0>;
> +
> +                avcc-supply =3D <&adc_vref>;
> +                vdrive-supply =3D <&vdd_supply>;
> +
> +                reset-gpios =3D <&gpio0 91 GPIO_ACTIVE_HIGH>;
> +                standby-gpios =3D <&gpio0 90 GPIO_ACTIVE_LOW>;
> +                adi,range-gpios =3D <&gpio0 89 GPIO_ACTIVE_HIGH>;
> +                adi,oversampling-ratio-gpios =3D <&gpio0 88 GPIO_ACTIVE_=
HIGH
> +                                                &gpio0 87 GPIO_ACTIVE_HI=
GH
> +                                                &gpio0 86 GPIO_ACTIVE_HI=
GH>;
> +                io-backends =3D <&iio_backend>;
> +        };
> +    };
> +
>    - |
>      #include <dt-bindings/gpio/gpio.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
>=20
> --=20
> 2.34.1
>=20

--6HKhWcDgbvoBp7P3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4S6gAKCRB4tDGHoIJi
0ulbAP9hVpWaS+YqUymxF/KYZehF0e4fGiVa8VvqdBGTq4r69AD+MauYvu8v8/CJ
i/lNXDbt57S3gsQSkOzHbY8DnCzcQgk=
=tsYn
-----END PGP SIGNATURE-----

--6HKhWcDgbvoBp7P3--

