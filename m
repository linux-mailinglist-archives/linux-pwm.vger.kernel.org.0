Return-Path: <linux-pwm+bounces-7092-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0694B2B919
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 08:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA71583285
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 06:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2279825B2E7;
	Tue, 19 Aug 2025 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIBKQB2U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84771863E;
	Tue, 19 Aug 2025 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583701; cv=none; b=euDrQtMO2rUlsrejdKf4Wsi88rDY9zxvPQYW7bF2I4EZ1fC38halDX5rpMt8wUY2WRTtZotj2KjDqd9T4qgVkhF8zVxLSPpmkEmraMfD+aQPeirrwYcWUCZp+vqX/bcEnMkhH6dNtTx7aF/aw4tIS2Zsc0CVYffMdmODh/eG0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583701; c=relaxed/simple;
	bh=JFOqiQZygYJZwxR9jUnXSWxc6RjvoDhgTgxK8uDWeLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+oyngVtVGnD9IKF9WjYhuFYZcKZKv6ACRFyJoz2Qfb/JGWJ3gicbortAwhYRBRlsX0dxyRPsebw1ryVNSijjtTJ+Q+B9YugT0w8rmQ61V0xMZ8nF3hf7PITJ0Zu6Z+53OERV+rE7o3fRvIKuXWJHXgI2wjEC7PsiRX4V4xe3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIBKQB2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC394C4CEF4;
	Tue, 19 Aug 2025 06:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755583700;
	bh=JFOqiQZygYJZwxR9jUnXSWxc6RjvoDhgTgxK8uDWeLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIBKQB2Ug804maWvOPuUOfpcsNLZO1bdOfLqRy/haIy1HpbJEdniEvVrEjX5PGrkn
	 Zd5u2y457HAPPZ8RqN9l1HIW1r7OVJ3BxFlrMeNwyNwtG5Wnt4gadHSrTP8r4C7F0K
	 98OuY+3Az23afPP211w0a9J7MP4uvuIlsaXKZCrUDWFX/dtPUMNcjiJjxkXZuO7bi9
	 LMLIUb51Dli9W6YN+iVU0eyQ0YEJlyXMUCuCQwX86yf5cz0p3UxRIV4GggyITumYiZ
	 D1VsrhYN/uIL3KTNVTYTwWtYpx9P5V9N/HXa3s/Zu/0lsx42U78eU1axRYCNilOIV3
	 DMaHPbYmlXnaA==
Date: Tue, 19 Aug 2025 08:08:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, peter.ujfalusi@gmail.com, 
	dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, lgirdwood@gmail.com, 
	tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org, broonie@kernel.org, 
	gregkh@linuxfoundation.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	shuah@kernel.org
Subject: Re: [PATCH 5/8] pwm: dt-bindings: ti,twl-pwm: convert to DT schema
Message-ID: <xs5dgd57ycqaohpqevy67mrmngqei5pyg2a62mk6gjzawzvwfm@pzhw5jthxmyo>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
 <20250811224739.53869-6-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5yzp6gv7etjwnva5"
Content-Disposition: inline
In-Reply-To: <20250811224739.53869-6-jihed.chaibi.dev@gmail.com>


--5yzp6gv7etjwnva5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/8] pwm: dt-bindings: ti,twl-pwm: convert to DT schema
MIME-Version: 1.0

On Tue, Aug 12, 2025 at 12:47:36AM +0200, Jihed Chaibi wrote:
> Convert the legacy TXT binding for the TWL-family PWM controller
> to the modern YAML DT schema format. This adds formal validation
> and improves documentation by inheriting from the base pwm schema.
>=20
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---
>  .../devicetree/bindings/pwm/ti,twl-pwm.txt    | 17 -------
>  .../devicetree/bindings/pwm/ti,twl-pwm.yaml   | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 17 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt b/Docum=
entation/devicetree/bindings/pwm/ti,twl-pwm.txt
> deleted file mode 100644
> index d97ca1964..000000000
> --- a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -Texas Instruments TWL series PWM drivers
> -
> -Supported PWMs:
> -On TWL4030 series: PWM1 and PWM2
> -On TWL6030 series: PWM0 and PWM1
> -
> -Required properties:
> -- compatible: "ti,twl4030-pwm" or "ti,twl6030-pwm"
> -- #pwm-cells: should be 2. See pwm.yaml in this directory for a descript=
ion of
> -  the cells format.
> -
> -Example:
> -
> -twl_pwm: pwm {
> -	compatible =3D "ti,twl6030-pwm";
> -	#pwm-cells =3D <2>;
> -};
> diff --git a/Documentation/devicetree/bindings/pwm/ti,twl-pwm.yaml b/Docu=
mentation/devicetree/bindings/pwm/ti,twl-pwm.yaml
> new file mode 100644
> index 000000000..5bbbdc13a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/ti,twl-pwm.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/ti,twl-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TWL4030/TWL6030 family PWM controller
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
> +
> +description: |
> +  Bindings for the following PWM controllers :
> +    TWL4030 series: PWMA and PWMB (connected to LEDA and LEDB terminals)
> +    TWL6030 series: LED PWM (mainly used as charging indicator LED)
> +
> +allOf:
> +  - $ref: /schemas/pwm/pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,twl4030-pwm
> +      - ti,twl6030-pwm
> +
> +  '#pwm-cells':
> +    const: 2
> +
> +required:
> +  - compatible
> +  - '#pwm-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pwm {
> +        compatible =3D "ti,twl4030-pwm";
> +        #pwm-cells =3D <2>;
> +    };
> +
> +  - |
> +    pwm {
> +        compatible =3D "ti,twl6030-pwm";
> +        #pwm-cells =3D <2>;
> +    };

Without having asked dt_binding_check it looks ok formally. I guess you
added Peter Ujfalusi as maintainer from the driver file. I'd like to see
a confirmation from him this is fine.

The 2nd example isn't very helpful. Unless I'm missing some detail that
makes it have a value I suggest to drop it. (But no need to resend just
for that, I don't feel that strong and can keep it or fixup when
applying.)

Best regards
Uwe

--5yzp6gv7etjwnva5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmikFM4ACgkQj4D7WH0S
/k6TXQgAgOHpunUCvCKcPCdfYvw/x0GxIJld2NVPMHAvH/zoqHhuWyA80902Vml7
oaOHd6EvK5AiYwfd6OFaODZy0zw4slH/wNW5v00NSJIkEj01gp/FLJGOmA1nEYSU
oW6E4bjhEhaTM4LdDuIRBsi98yy1rmbwgRu0AgmoSv2Yof3jKwqbFW9UffjiJHus
yjU8tTPF6Tcu7x9JaFNSEJqymp1K97cTTqs6e3njMt8OCCktpSNlKl/u4Wp2o6DY
tXjPDChXLGYrcvwefTl2vb+qrc8/Q1xSx5GH/udU68l+c4RHdPivtxdwyUDOiWpB
Ida7RVbLjhD3LQKIN8RWgaQxC6Pi8A==
=hMLi
-----END PGP SIGNATURE-----

--5yzp6gv7etjwnva5--

