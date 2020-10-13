Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306B028CE64
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 14:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgJMMdY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 08:33:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:35496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgJMMdY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Oct 2020 08:33:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75F25ACB8;
        Tue, 13 Oct 2020 12:33:22 +0000 (UTC)
Message-ID: <f891916e193707eb55faa9ea93f294ac44925710.camel@suse.de>
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
Date:   Tue, 13 Oct 2020 14:33:20 +0200
In-Reply-To: <20201013120823.hhy7wyqsb3f3ufnx@pengutronix.de>
References: <20201009153031.986-1-nsaenzjulienne@suse.de>
         <20201009153031.986-2-nsaenzjulienne@suse.de>
         <20201012070132.it23vl6f3ytavqgj@pengutronix.de>
         <cc7842ed7f8a4db863024a0ff5d8b7d86de52f50.camel@suse.de>
         <20201013120823.hhy7wyqsb3f3ufnx@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PNkehS3QHaMWL1P5zC+2"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-PNkehS3QHaMWL1P5zC+2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-10-13 at 14:08 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Oct 13, 2020 at 12:35:38PM +0200, Nicolas Saenz Julienne wrote:
> > Hi Uwe, thanks for having a look at this.
> >=20
> > On Mon, 2020-10-12 at 09:01 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Fri, Oct 09, 2020 at 05:30:28PM +0200, Nicolas Saenz Julienne wrot=
e:
> > > > The PWM bus controlling the fan in RPi's official PoE hat can only =
be
> > > > controlled by the board's co-processor.
> > > >=20
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > ---
> > > >  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++=
++++
> > > >  .../pwm/raspberrypi,firmware-pwm.h            | 13 ++++++++++++
> > > >  2 files changed, 34 insertions(+)
> > > >  create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-pw=
m.h
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,=
bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberry=
pi,bcm2835-firmware.yaml
> > > > index a2c63c8b1d10..dcaf00e8602e 100644
> > > > --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835=
-firmware.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835=
-firmware.yaml
> > > > @@ -64,6 +64,22 @@ properties:
> > > >        - compatible
> > > >        - "#reset-cells"
> > > > =20
> > > > +  pwm:
> > > > +    type: object
> > > > +
> > > > +    properties:
> > > > +      compatible:
> > > > +        const: raspberrypi,firmware-pwm
> > > > +
> > > > +      "#pwm-cells":
> > > > +        const: 1
> > > > +        description: >
> > > > +          The argument is the PWM bus number.
> > >=20
> > > This is wrong. #pwm-cells specifies the number of "arguments" for
> > > phandles pointing to this node. And I would prefer this being 2 to ma=
tch
> > > the stuff described in the generic pwm binding.
> >=20
> > I saw buses out there with the same limitation as this one (unable to c=
hange
> > frequency) that used a single cell, so I whent with it. That said I'll =
be happy
> > to change it and drop the custom *_xlate() function in benefit of the d=
efault
> > one.
>=20
> As the first cell after the phandle is for the period and only the
> second if for flags, this is a poor argument.

In that case aren't these bindings wrong (and associated xlate() functions)=
?

google,cros-ec-pwm.yaml:
[...]
	properties:
	  compatible:
	    const: google,cros-ec-pwm
	  "#pwm-cells":
	    description: The cell specifies the PWM index.
	    const: 1
[...]

cirrus,clps711x-pwm.txt:
[...]
	- #pwm-cells: Should be 1. The cell specifies the index of the channel.
[...]

Note that pxa-pwm.txt behaves as you comment.

Ultimately note that in of_pwm_simple_xlate() the second argument is used t=
o
assign the pwm period, the first one is passed as an index to
pwm_request_from_chip().

> So yes, use #pwm-cells =3D <2> and drop the custom xlate() function pleas=
e.

I'll still go this way nontheless. Just want to make sure I understand thin=
gs
correctly.

Regards,
Nicolas


--=-PNkehS3QHaMWL1P5zC+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+FnpAACgkQlfZmHno8
x/7sdgf/cwMDnViTJv9j3SHpLL9SP1RdL5nmf9W8jZx73EaH4Vu2ymNB/SxLgB85
mStnDoW4rCZdAeC7JWA/gEApJ2qY92bqTewsvnQsMheOHrt82g1UbIl1vLlSUfWa
gCyhWQqKnSdeYkABc8Wqp1RzFSbxi9v9cut4i/xSWUPmvtYkFxCYcHxgFmaTKWLt
WsyZC7YVt/rXLdznRDwqZR3/FMq9twd99ugNdaokW+vqfG1jac+QYrNj85jvnr1Y
p8EAtipopOQFnnJPdTzT4kj/xSC+EZoDWhaCyMe7oEjBDlVRpUqPuifM8ChJGjEU
C+6I9NCizNkeOw9wwR+p2OZDuLrZJQ==
=ryHl
-----END PGP SIGNATURE-----

--=-PNkehS3QHaMWL1P5zC+2--

