Return-Path: <linux-pwm+bounces-3320-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C365397DF5A
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Sep 2024 00:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527041F2168B
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Sep 2024 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B5C153BF8;
	Sat, 21 Sep 2024 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKtEWDwW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3A257B;
	Sat, 21 Sep 2024 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726957150; cv=none; b=ofVB5E05CAQFnvGlewBw4hBzEFvFydPLgfWbjvOeueYanQicOevdyDayJPMzmVTkX2vEMIf90CFqGvXr6+l1nd6XEUbizuhsy3kIRhoNN90hpK0QhFlYCTBkcIYTALBvuz/ZO89OgFmfceH9ztia6g+55hIX/socQgocdg+WDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726957150; c=relaxed/simple;
	bh=kfR14K5vrihyjIzfXPTU8e1xRsbb7EB2RB9CxAyKGns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGR7lScVjz2isv/QhoSWV3GNZ0dbrKs2Rg2Cic/IFKjTF2EYbQbWzCbnM53/jqhtO5nhjeFpYb2hKZiVup6nGkl0jieQxgB8hQr1GCUh2Cwf646CbN2ChwlAeOHykl2rqarelBxzJLEnKO+h/VBHIVbTT7tubgZiDNerwDHUCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKtEWDwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A88C4CEC2;
	Sat, 21 Sep 2024 22:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726957149;
	bh=kfR14K5vrihyjIzfXPTU8e1xRsbb7EB2RB9CxAyKGns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKtEWDwWofb5y/OGX5gOxNGrMyVa8YcbIRHQu6UCj/KmRABpTVAnFHfdEFHEA9Fkf
	 lyjBml+k7UppNw7slrDXufzcHG1EPQp3u9rhVpAOgqC/6eG4atC+4WKx7SjqbjqNN6
	 8+PGvpylJ11aa4N44u7wkfDlkAzkaFOFcP2gSg9koZ0D7hBvaR8dyI8bB7rae9G3tW
	 ++dUzQjreatME31JfJIqy/QdGbzYOC7twHAP5o1cY60yVp7G0jdyg/KOxJqGV5BUDt
	 gOAo6LJHyX6W9hSlju+mYoF1vbWgIWumSOdP0ANHlqeGx6VxVcDdWpaZAmk6/yepUx
	 bw10rLBy2IblQ==
Date: Sat, 21 Sep 2024 23:19:03 +0100
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
	Jonathan Corbet <corbet@lwn.net>, Michal Marek <mmarek@suse.com>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	aardelean@baylibre.com, dlechner@baylibre.com,
	jstephan@baylibre.com
Subject: Re: [PATCH v2 03/10] dt-bindings: iio: adc: ad7606: Add iio backend
 bindings
Message-ID: <20240921-charter-grouped-9f77e0a640a0@spud>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
 <20240920-ad7606_add_iio_backend_support-v2-3-0e78782ae7d0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/E6hod+IHxfXaUGB"
Content-Disposition: inline
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-3-0e78782ae7d0@baylibre.com>


--/E6hod+IHxfXaUGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 05:33:23PM +0000, Guillaume Stols wrote:
> Add the required properties for iio-backend support, as well as an
> example and the conditions to mutually exclude interruption and
> conversion trigger with iio-backend.
> The iio-backend's function is to controls the communication, and thus the
> interruption pin won't be available anymore.
> As a consequence, the conversion pin must be controlled externally since
> we will miss information about when every single conversion cycle (i.e
> conversion + data transfer) ends, hence a PWM is introduced to trigger
> the conversions.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 76 ++++++++++++++++=
+++++-
>  1 file changed, 74 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 12995ebcddc2..74a8680904b1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -118,13 +118,32 @@ properties:
>        this property must be defined.
>      type: boolean
> =20
> +  pwms:
> +    description:
> +      In case the conversion is triggered by a PWM instead of a GPIO plu=
gged to
> +      the CONVST pin, the PWM must be referenced.
> +    minItems: 1
> +    maxItems: 2

Please use an items list to describe what each item is, rather than
doing so in the pwm-names description below.

> +
> +  pwm-names:
> +    description:
> +      The name of each PWM, the first is connected to CONVST, and the se=
cond is
> +      connected to CONVST2 if CONVST2 is available and not connected to =
CONVST1.
> +    minItems: 1
> +    maxItems: 2

You need to define what the names actually are, otherwise you have no
ABI.

Cheers,
Conor.

> +
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
>    - reg
>    - avcc-supply
>    - vdrive-supply
> -  - interrupts
> -  - adi,conversion-start-gpios
> =20
>  oneOf:
>    - required:
> @@ -138,6 +157,34 @@ oneOf:
>            - spi-cpol
> =20
>  allOf:
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
> @@ -179,12 +226,37 @@ allOf:
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
> +            compatible =3D "adi,ad7606b";
> +            parallel-interface;
> +            pwms =3D <&axi_pwm_gen 0 0>;
> +
> +            avcc-supply =3D <&adc_vref>;
> +            vdrive-supply =3D <&vdd_supply>;
> +
> +            reset-gpios =3D <&gpio0 91 GPIO_ACTIVE_HIGH>;
> +            standby-gpios =3D <&gpio0 90 GPIO_ACTIVE_LOW>;
> +            adi,range-gpios =3D <&gpio0 89 GPIO_ACTIVE_HIGH>;
> +            adi,oversampling-ratio-gpios =3D <&gpio0 88 GPIO_ACTIVE_HIGH
> +                                            &gpio0 87 GPIO_ACTIVE_HIGH
> +                                            &gpio0 86 GPIO_ACTIVE_HIGH>;
> +            io-backends =3D <&iio_backend>;
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

--/E6hod+IHxfXaUGB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZu9GVwAKCRB4tDGHoIJi
0sp1AP9PpuRy60rPk9JYWnURXlbuDdPob0rbthuXpOdAIPJZewD/bmxcvaFLN3N6
mVszPN0fIfm39hSecA50i4isHCxlTwA=
=cklL
-----END PGP SIGNATURE-----

--/E6hod+IHxfXaUGB--

