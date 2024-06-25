Return-Path: <linux-pwm+bounces-2612-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FA0916DEE
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2024 18:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E6A1F26C09
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2024 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C296171668;
	Tue, 25 Jun 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgDzJGYh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5992F17082D;
	Tue, 25 Jun 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332543; cv=none; b=cemuWuaTmbQQ5vWwrvOexgfFmNDwPxmavh8iihHpLjQj1Wy1ERzQjHwMEmVaT6pa18puySL6JfAQclkW7bfmdw45tP7Twns99Oo7V5MG8BL7LobaVK1Ob/iNZkV7hvEnR3BUL6KeUCmExjdgZW/OQfs9VZ+JoRD/lU37nn7OexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332543; c=relaxed/simple;
	bh=akzr2Tcmr8hvoXCrldFTf3vxOcOP1rC3e1w/56iBGCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx89qVRU7DaJMdhzioxKerS3Wil5hHQTO+D+beAX7vzjFbNuD26ixI60neMpbgUtwZ90Xmk1tjyOVMKR8sx39ZKqHRRts6mIpnHda+tqdybFZtQOxXMWaWOWTw2H2sp1kThWna2szv8yLpjMYS1Q++Vt479esCU7jtvaOQoYSQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgDzJGYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8676DC32781;
	Tue, 25 Jun 2024 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332542;
	bh=akzr2Tcmr8hvoXCrldFTf3vxOcOP1rC3e1w/56iBGCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kgDzJGYhBaKcP6lEFjj4Tas4lTM4uNMNjxCcJSfTfs7MGHnesN9d6V0ysjucd8ApJ
	 oGsYgeiLYVUa2J5vjhepCeohL/GNZjw7XkXjWHaYssoEdRIhI2n7uODbb8iBMwyEqX
	 4S57r7ji7tpfhAJcbpsLJY34qc4ZNUCjdN9MVMn1g88vg6Tk+pRScjFqmoIxmueID9
	 r4VRe56YSCVllR1HdOYWbROv/2LVmyhvDR7V4/VcP66FC1vZTZ9Q+9cNvSMdrdbsdn
	 wrR0GQFivlLs3qkoVNHJ9F0yODORAVaO98ansY5enl0Y2V3pUPM9LcJMkkXNN4/SKr
	 qq+kKY/VEPUYw==
Date: Tue, 25 Jun 2024 17:22:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
	linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ukleinek@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Message-ID: <20240625-oppressor-scaling-5713b4719a89@spud>
References: <20240528225638.1211676-1-chris.packham@alliedtelesis.co.nz>
 <20240528225638.1211676-2-chris.packham@alliedtelesis.co.nz>
 <20240529-faucet-vending-3e330f8eb67b@wendy>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R3N5fZNUTuh/Iu6H"
Content-Disposition: inline
In-Reply-To: <20240529-faucet-vending-3e330f8eb67b@wendy>


--R3N5fZNUTuh/Iu6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Uwe,

On Wed, May 29, 2024 at 08:58:41AM +0100, Conor Dooley wrote:
> On Wed, May 29, 2024 at 10:56:36AM +1200, Chris Packham wrote:
> > Add fan child nodes that allow describing the connections for the
> > ADT7475 to the fans it controls. This also allows setting some
> > initial values for the pwm duty cycle and frequency.
> >=20
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >=20
> > Notes:
> >     I realise there is still some discussion about how to express the
> >     frequency and duty cycle. I have a personal preference for using he=
rtz
> >     for the frequency and 0-255 for the duty cycle but if the consensus=
 is
> >     to express these things some other way I'm fine with doing some mat=
h.
>=20
> Probably worth carrying a link to it here:
> https://lore.kernel.org/all/4de798f3-069e-4028-a5b5-5e6a639277e3@alliedte=
lesis.co.nz/
>=20
> I asked Uwe to take a look & it's on his todo list.

This is an attempt to bump this up on your todo list a bit!

Thanks,
Conor.

> >    =20
> >     Changes in v4:
> >     - 0 is not a valid frequency value
> >     Changes in v3:
> >     - Use the pwm provider/consumer bindings
> >     Changes in v2:
> >     - Document 0 as a valid value (leaves hardware as-is)
> >=20
> >  .../devicetree/bindings/hwmon/adt7475.yaml    | 25 ++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Doc=
umentation/devicetree/bindings/hwmon/adt7475.yaml
> > index 051c976ab711..bfef4c803bf7 100644
> > --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > @@ -51,6 +51,15 @@ properties:
> >        enum: [0, 1]
> >        default: 1
> > =20
> > +  "#pwm-cells":
> > +    const: 4
> > +    description: |
> > +      Number of cells in a PWM specifier.
> > +      - 0: The pwm channel
> > +      - 1: The pwm frequency in hertz - 11, 14, 22, 29, 35, 44, 58, 88=
, 22500
> > +      - 2: PWM flags 0 or PWM_POLARITY_INVERTED
> > +      - 3: The default pwm duty cycle - 0-255
> > +
> >  patternProperties:
> >    "^adi,bypass-attenuator-in[0-4]$":
> >      description: |
> > @@ -81,6 +90,10 @@ patternProperties:
> >        - smbalert#
> >        - gpio
> > =20
> > +  "^fan-[0-9]+$":
> > +    $ref: fan-common.yaml#
> > +    unevaluatedProperties: false
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -89,11 +102,12 @@ additionalProperties: false
> > =20
> >  examples:
> >    - |
> > +    #include <dt-bindings/pwm/pwm.h>
> >      i2c {
> >        #address-cells =3D <1>;
> >        #size-cells =3D <0>;
> > =20
> > -      hwmon@2e {
> > +      pwm: hwmon@2e {
> >          compatible =3D "adi,adt7476";
> >          reg =3D <0x2e>;
> >          adi,bypass-attenuator-in0 =3D <1>;
> > @@ -101,5 +115,14 @@ examples:
> >          adi,pwm-active-state =3D <1 0 1>;
> >          adi,pin10-function =3D "smbalert#";
> >          adi,pin14-function =3D "tach4";
> > +        #pwm-cells =3D <4>;
> > +
> > +        fan-0 {
> > +          pwms =3D <&pwm 0 22500 PWM_POLARITY_INVERTED 255>;
> > +        };
> > +
> > +        fan-1 {
> > +          pwms =3D <&pwm 2 22500 PWM_POLARITY_INVERTED 255>;
> > +        };
> >        };
> >      };
> > --=20
> > 2.45.1
> >=20



--R3N5fZNUTuh/Iu6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnruugAKCRB4tDGHoIJi
0kFRAQCZIrHaisIz4R0cjPl4ENnCGHKMXBh7j/mC8rYE/KB85wD/RTIZIcVxwnp3
vJJ40zdLuhvyve24lm/u4nEf90mDYwc=
=rn/M
-----END PGP SIGNATURE-----

--R3N5fZNUTuh/Iu6H--

