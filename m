Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DDB28CBD7
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 12:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391479AbgJMKfm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 06:35:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:55358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388136AbgJMKfm (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Oct 2020 06:35:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61A3BADA8;
        Tue, 13 Oct 2020 10:35:40 +0000 (UTC)
Message-ID: <cc7842ed7f8a4db863024a0ff5d8b7d86de52f50.camel@suse.de>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: Add binding for RPi firmware PWM
 bus
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     f.fainelli@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        wahrenst@gmx.net, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 13 Oct 2020 12:35:38 +0200
In-Reply-To: <20201012070132.it23vl6f3ytavqgj@pengutronix.de>
References: <20201009153031.986-1-nsaenzjulienne@suse.de>
         <20201009153031.986-2-nsaenzjulienne@suse.de>
         <20201012070132.it23vl6f3ytavqgj@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2iVS7ULrnuve/eAfppuC"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-2iVS7ULrnuve/eAfppuC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe, thanks for having a look at this.

On Mon, 2020-10-12 at 09:01 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Oct 09, 2020 at 05:30:28PM +0200, Nicolas Saenz Julienne wrote:
> > The PWM bus controlling the fan in RPi's official PoE hat can only be
> > controlled by the board's co-processor.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
> >  .../pwm/raspberrypi,firmware-pwm.h            | 13 ++++++++++++
> >  2 files changed, 34 insertions(+)
> >  create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-pwm.h
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2=
835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,b=
cm2835-firmware.yaml
> > index a2c63c8b1d10..dcaf00e8602e 100644
> > --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-fir=
mware.yaml
> > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-fir=
mware.yaml
> > @@ -64,6 +64,22 @@ properties:
> >        - compatible
> >        - "#reset-cells"
> > =20
> > +  pwm:
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        const: raspberrypi,firmware-pwm
> > +
> > +      "#pwm-cells":
> > +        const: 1
> > +        description: >
> > +          The argument is the PWM bus number.
>=20
> This is wrong. #pwm-cells specifies the number of "arguments" for
> phandles pointing to this node. And I would prefer this being 2 to match
> the stuff described in the generic pwm binding.

I saw buses out there with the same limitation as this one (unable to chang=
e
frequency) that used a single cell, so I whent with it. That said I'll be h=
appy
to change it and drop the custom *_xlate() function in benefit of the defau=
lt
one.

Regards,
Nicolas


--=-2iVS7ULrnuve/eAfppuC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+FgvoACgkQlfZmHno8
x/5AQAf/UTRVT1pCa5o4xp+ayZmAGGxRlvfxIEn3jBacnTzBtJvYUu4Fp7kxeJ0K
vmfLrRwzZmNWOGzw8NzlUTS48qVPIxkQTDueEEbJP6p4kRqMNx80RB7p+cuJYI1S
NyIZQowKwW7j5Nqzoi2bZ5xICNksvOArBzz06Kw5N4JDExGQHK+XHa/GJS7Oku/B
OAhKs9ZxnN6L6PqhPibL6ZQtbRW4wCGMJQS1ZUZ670UnGbs7jd7P9biUCekeaBXI
yyQaIXZ0J1npanQUgq/XWY2y2Yvj2vW6S0oeRIDuvu5ivBEv91Fl3huViq5orSuL
Qf+7NmmTSx1Is6EbimO01zm2cKf1Rw==
=ek+T
-----END PGP SIGNATURE-----

--=-2iVS7ULrnuve/eAfppuC--

