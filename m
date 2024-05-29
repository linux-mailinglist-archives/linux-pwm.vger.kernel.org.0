Return-Path: <linux-pwm+bounces-2279-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0358D2E65
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 09:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0AA1C212DC
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567A8167296;
	Wed, 29 May 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UdK0QMqj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116B1E86E;
	Wed, 29 May 2024 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968346; cv=none; b=medjl86AbOc8hCpyc7faaPrXeCpE1viqIWrdnDl+aglwiHGjBTaJsUU1pgKu2Q1j1IaT/zNyKJ+JtfyGEavSvYfQIQUcEd44UqQhvpo08DPJKuXT182OXjNKjyqYs2cCB0Fas2T5Ct7tKrouSspxmyanfRGhhJG+qVdXCSGs+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968346; c=relaxed/simple;
	bh=jOZf9FxB8Chj+I1FF/6xKPuMzy4ZIWetvg9cXl3DtL4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEMsA84IybwLt1NoJJ+7F5x72NFicyxBMl6kDTji/hM9z2NbRCD7ld+PBRaW/iNco4NyMYWrbGCdGfjYTIx0MwyWLx/o5ETxcJbsbZ0XFVk7L3ru4dBEiJitBwwRenBDeK2w1f5aXRcRFlWXFbFPkBUY2zkyVMBHDmMIOP99Ca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UdK0QMqj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716968344; x=1748504344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jOZf9FxB8Chj+I1FF/6xKPuMzy4ZIWetvg9cXl3DtL4=;
  b=UdK0QMqjLOuWQ4Ty74eJkOwkbFdcQ2tf+Fsq+CucXJ9EHDHBtWcb/hCW
   w2dnt6mvnKyyP8wBsJMWJ4U4++kgYIJnxUdrIi2TR8zZuOL8dvj829GUB
   h24ATH6m9eoioKugzYDighJg9BbCrLNjvX1Wiiq59yR9PryofSQOcQC6g
   VNWFaMe9wzxyI9/sDTGAPBYpj/6/LYMKwaikP22fFCD+jfvlSRZSE/Uqs
   n7aZHQ+jWHbD17uxTT+9VmkaRoctb6nPS6/fPEeat+KRU3rnkZQVpoKOv
   mXC/S/MfLCO980ZK3qz2pjWXIyIZ79MERN6azBNqZ3obeOQXTQHq7Xj+9
   A==;
X-CSE-ConnectionGUID: ozutHQsqTHWSlsdEABSroQ==
X-CSE-MsgGUID: DtTm/icsSPe7NZvAEAQ+mw==
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="asc'?scan'208";a="257520481"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2024 00:39:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 29 May 2024 00:38:59 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 00:38:57 -0700
Date: Wed, 29 May 2024 08:58:41 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
CC: <jdelvare@suse.com>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
	<linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Message-ID: <20240529-faucet-vending-3e330f8eb67b@wendy>
References: <20240528225638.1211676-1-chris.packham@alliedtelesis.co.nz>
 <20240528225638.1211676-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4wiA+HKJ9TqC3xZp"
Content-Disposition: inline
In-Reply-To: <20240528225638.1211676-2-chris.packham@alliedtelesis.co.nz>

--4wiA+HKJ9TqC3xZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:56:36AM +1200, Chris Packham wrote:
> Add fan child nodes that allow describing the connections for the
> ADT7475 to the fans it controls. This also allows setting some
> initial values for the pwm duty cycle and frequency.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>=20
> Notes:
>     I realise there is still some discussion about how to express the
>     frequency and duty cycle. I have a personal preference for using hertz
>     for the frequency and 0-255 for the duty cycle but if the consensus is
>     to express these things some other way I'm fine with doing some math.

Probably worth carrying a link to it here:
https://lore.kernel.org/all/4de798f3-069e-4028-a5b5-5e6a639277e3@alliedtele=
sis.co.nz/

I asked Uwe to take a look & it's on his todo list.

Thanks,
Conor.

>    =20
>     Changes in v4:
>     - 0 is not a valid frequency value
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
> index 051c976ab711..bfef4c803bf7 100644
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
> +      - 1: The pwm frequency in hertz - 11, 14, 22, 29, 35, 44, 58, 88, =
22500
> +      - 2: PWM flags 0 or PWM_POLARITY_INVERTED
> +      - 3: The default pwm duty cycle - 0-255
> +
>  patternProperties:
>    "^adi,bypass-attenuator-in[0-4]$":
>      description: |
> @@ -81,6 +90,10 @@ patternProperties:
>        - smbalert#
>        - gpio
> =20
> +  "^fan-[0-9]+$":
> +    $ref: fan-common.yaml#
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -89,11 +102,12 @@ additionalProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/pwm/pwm.h>
>      i2c {
>        #address-cells =3D <1>;
>        #size-cells =3D <0>;
> =20
> -      hwmon@2e {
> +      pwm: hwmon@2e {
>          compatible =3D "adi,adt7476";
>          reg =3D <0x2e>;
>          adi,bypass-attenuator-in0 =3D <1>;
> @@ -101,5 +115,14 @@ examples:
>          adi,pwm-active-state =3D <1 0 1>;
>          adi,pin10-function =3D "smbalert#";
>          adi,pin14-function =3D "tach4";
> +        #pwm-cells =3D <4>;
> +
> +        fan-0 {
> +          pwms =3D <&pwm 0 22500 PWM_POLARITY_INVERTED 255>;
> +        };
> +
> +        fan-1 {
> +          pwms =3D <&pwm 2 22500 PWM_POLARITY_INVERTED 255>;
> +        };
>        };
>      };
> --=20
> 2.45.1
>=20

--4wiA+HKJ9TqC3xZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlbgLAAKCRB4tDGHoIJi
0tu6AP4/nFnJfrf121gHJBfzksW6XCKET471Txd1cGwJLuTE8QD+OUN7EKN/Vkag
6uwCY8eQG03BAO5DRYNaweHCiQSzdgQ=
=LSol
-----END PGP SIGNATURE-----

--4wiA+HKJ9TqC3xZp--

