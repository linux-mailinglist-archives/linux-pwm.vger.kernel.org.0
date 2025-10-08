Return-Path: <linux-pwm+bounces-7421-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB5BC6A38
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 23:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC82A4E736B
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3C29BDAE;
	Wed,  8 Oct 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6M/6/Fj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64226657B;
	Wed,  8 Oct 2025 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957638; cv=none; b=DhNKU2+OEP/Fots/wbMHCTuQiCEwwFJ7F4V2DTpuwOzZE8VTJeYeiKv5gSPUpc/pN5fAGSXmZbagkaCxdIjb7SjybeZBoaXTjmIYI2Z2pD5AcuRAvO1a5aC+Z79Ty1yqclUW4CmAh7QCSxojgEzcfb8Kd4KhD9NdwZUx+RrIMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957638; c=relaxed/simple;
	bh=LL0RamBUFR6PAe5GMWukxqVeDNw7wqwAhfyL2dF64hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQyVc/2PWmiBZfGq82cCYK2HfsSlbLvwPXFEnHm1tTIV73oiLCd8yu3j0+JwX7adT5Wam1kaRQk/vbKu1QnzKz8tMW9ulPqeeAVeS7V0x/2bMTsQHwzHx7uiFXcM8OKFaog0zlOO3XOW06zuSfmtiP96lAR4q3x3fLkLOfyLxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6M/6/Fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFE7C4CEE7;
	Wed,  8 Oct 2025 21:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759957637;
	bh=LL0RamBUFR6PAe5GMWukxqVeDNw7wqwAhfyL2dF64hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6M/6/Fj7ZD78LRctQ7ZlY+xTd9UrxG7l5pdUcND8ftAhZ6QmIWCyedWPkJZ/ygIJ
	 TMhUZUZjlEyekemtUFw05lM+1GEPBc8JjKsguYrsrI/2hBDpgAiNHdaUJt/aoh8MTt
	 LTrSxa3gYa6eElTKy2fSdT5JfjpdLdXJtmwF6CZaRCegYkuSbxcx06bop9yy5vziI9
	 zWPFOpO2HqNhQca42YFMgh5X1BW3WCaWJGc9CV9+HhQerxJY16Ow5Naxwu+SREXkJL
	 fvitdkW+gEkKLeRw9pNKKufZxCw8+8EECfM3ODN/7n4I+UgjGi+kccmG/tX/gDRoa1
	 5KyCbNVLqVxRA==
Date: Wed, 8 Oct 2025 22:07:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com,
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20251008-swooned-closable-fbc8b71601c0@spud>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hM/C8yvENSUKZA1u"
Content-Disposition: inline
In-Reply-To: <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>


--hM/C8yvENSUKZA1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 10:51:37AM -0300, Marcelo Schmitt wrote:
> ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have=
 a
> PGA (programmable gain amplifier) that scales the input signal prior to it
> reaching the ADC inputs. The PGA is controlled through a couple of pins (=
A0
> and A1) that set one of four possible signal gain configurations.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v3 -> v4
> - Now only documenting GPIO setup to control ADAQ PGA pins.
>=20
> Pin strapped/hardwired connections to PGA pins may benefit from a "fixed-=
gpios"
> driver which may (or may not?) use the shared GPIO abstraction layer [1].=
 I may
> propose support for pin-strapped/hardwired connections when I get a worki=
ng
> fixed-gpios implementation.

What is a "fixed-gpio" as compared to a hog, from a dt point of view?
Is it purely a software change?

This looks fine other than the potential oversight I pointed out in the
other mail.

Cheers,
COnor

>=20
> [1]: https://lore.kernel.org/linux-gpio/CAMRc=3DMdb_cUG+hKq8GyfUP1SYBh0p1=
9J+4dFG7G3JSuZTr4n8Q@mail.gmail.com/T/#t
>=20
>  .../bindings/iio/adc/adi,ad4030.yaml          | 71 +++++++++++++++++--
>  1 file changed, 66 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index 564b6f67a96e..d0e8452598d4 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -19,6 +19,8 @@ description: |
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4030-24-4032-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4630-24_ad4632-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad4630-16-4632-16.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/=
adaq4216.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/=
adaq4224.pdf
> =20
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
> =20
> @@ -31,6 +33,8 @@ properties:
>        - adi,ad4630-24
>        - adi,ad4632-16
>        - adi,ad4632-24
> +      - adi,adaq4216
> +      - adi,adaq4224
> =20
>    reg:
>      maxItems: 1
> @@ -54,6 +58,14 @@ properties:
>      description:
>        Internal buffered Reference. Used when ref-supply is not connected.
> =20
> +  vddh-supply:
> +    description:
> +      PGIA Positive Power Supply.
> +
> +  vdd-fda-supply:
> +    description:
> +      FDA Positive Power Supply.
> +
>    cnv-gpios:
>      description:
>        The Convert Input (CNV). It initiates the sampling conversions.
> @@ -64,6 +76,13 @@ properties:
>        The Reset Input (/RST). Used for asynchronous device reset.
>      maxItems: 1
> =20
> +  pga-gpios:
> +    description:
> +      A0 and A1 pins for gain selection. For devices that have PGA confi=
guration
> +      input pins, pga-gpios should be defined.
> +    minItems: 2
> +    maxItems: 2
> +
>    pwms:
>      description: PWM signal connected to the CNV pin.
>      maxItems: 1
> @@ -86,11 +105,30 @@ required:
>    - vio-supply
>    - cnv-gpios
> =20
> -oneOf:
> -  - required:
> -      - ref-supply
> -  - required:
> -      - refin-supply
> +allOf:
> +  - oneOf:
> +      - required:
> +          - ref-supply
> +      - required:
> +          - refin-supply
> +  # ADAQ devices require a gain property to indicate how hardware PGA is=
 set
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            pattern: ^adi,adaq
> +    then:
> +      required:
> +        - vddh-supply
> +        - vdd-fda-supply
> +        - pga-gpios
> +      properties:
> +        ref-supply: false
> +    else:
> +      properties:
> +        adi,pga-value: false
> +        pga-gpios: false
> +
> =20
>  unevaluatedProperties: false
> =20
> @@ -114,3 +152,26 @@ examples:
>              reset-gpios =3D <&gpio0 1 GPIO_ACTIVE_LOW>;
>          };
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,adaq4216";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <80000000>;
> +            vdd-5v-supply =3D <&supply_5V>;
> +            vdd-1v8-supply =3D <&supply_1_8V>;
> +            vio-supply =3D <&supply_1_8V>;
> +            refin-supply =3D <&refin_sup>;
> +            vddh-supply =3D <&vddh>;
> +            vdd-fda-supply =3D <&vdd_fda>;
> +            cnv-gpios =3D <&gpio0 0 GPIO_ACTIVE_HIGH>;
> +            reset-gpios =3D <&gpio0 1 GPIO_ACTIVE_LOW>;
> +            pga-gpios =3D <&gpio0 2 GPIO_ACTIVE_HIGH>,
> +                        <&gpio0 3 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +...
> --=20
> 2.39.2
>=20

--hM/C8yvENSUKZA1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaObSfwAKCRB4tDGHoIJi
0lY/AP42s28WKlj6/TAIKE6lAwmWLAu1DcM4p1Bryw3PGPhnJgD6ApdUoeyu5DO7
1uw1V7gwEEBZrvdT7xrics1a+2bZ1QQ=
=dpHV
-----END PGP SIGNATURE-----

--hM/C8yvENSUKZA1u--

