Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145B628D119
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 17:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbgJMPS3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389261AbgJMPS0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Oct 2020 11:18:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161BDC0613D2
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2020 08:18:26 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSM41-0008HW-Q9; Tue, 13 Oct 2020 17:18:09 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSM3z-0000Zw-Rx; Tue, 13 Oct 2020 17:18:07 +0200
Date:   Tue, 13 Oct 2020 17:18:07 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        wahrenst@gmx.net, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pwm: Add binding for RPi firmware PWM
 bus
Message-ID: <20201013151807.px6o2caoh4vfzlwu@pengutronix.de>
References: <20201009153031.986-1-nsaenzjulienne@suse.de>
 <20201009153031.986-2-nsaenzjulienne@suse.de>
 <20201012070132.it23vl6f3ytavqgj@pengutronix.de>
 <cc7842ed7f8a4db863024a0ff5d8b7d86de52f50.camel@suse.de>
 <20201013120823.hhy7wyqsb3f3ufnx@pengutronix.de>
 <f891916e193707eb55faa9ea93f294ac44925710.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qn6okevj7lpylitq"
Content-Disposition: inline
In-Reply-To: <f891916e193707eb55faa9ea93f294ac44925710.camel@suse.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qn6okevj7lpylitq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 02:33:20PM +0200, Nicolas Saenz Julienne wrote:
> On Tue, 2020-10-13 at 14:08 +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Oct 13, 2020 at 12:35:38PM +0200, Nicolas Saenz Julienne wrote:
> > > Hi Uwe, thanks for having a look at this.
> > >=20
> > > On Mon, 2020-10-12 at 09:01 +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Fri, Oct 09, 2020 at 05:30:28PM +0200, Nicolas Saenz Julienne wr=
ote:
> > > > > The PWM bus controlling the fan in RPi's official PoE hat can onl=
y be
> > > > > controlled by the board's co-processor.
> > > > >=20
> > > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > > ---
> > > > >  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++=
++++++
> > > > >  .../pwm/raspberrypi,firmware-pwm.h            | 13 ++++++++++++
> > > > >  2 files changed, 34 insertions(+)
> > > > >  create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-=
pwm.h
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberryp=
i,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspber=
rypi,bcm2835-firmware.yaml
> > > > > index a2c63c8b1d10..dcaf00e8602e 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm28=
35-firmware.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm28=
35-firmware.yaml
> > > > > @@ -64,6 +64,22 @@ properties:
> > > > >        - compatible
> > > > >        - "#reset-cells"
> > > > > =20
> > > > > +  pwm:
> > > > > +    type: object
> > > > > +
> > > > > +    properties:
> > > > > +      compatible:
> > > > > +        const: raspberrypi,firmware-pwm
> > > > > +
> > > > > +      "#pwm-cells":
> > > > > +        const: 1
> > > > > +        description: >
> > > > > +          The argument is the PWM bus number.
> > > >=20
> > > > This is wrong. #pwm-cells specifies the number of "arguments" for
> > > > phandles pointing to this node. And I would prefer this being 2 to =
match
> > > > the stuff described in the generic pwm binding.
> > >=20
> > > I saw buses out there with the same limitation as this one (unable to=
 change
> > > frequency) that used a single cell, so I whent with it. That said I'l=
l be happy
> > > to change it and drop the custom *_xlate() function in benefit of the=
 default
> > > one.
> >=20
> > As the first cell after the phandle is for the period and only the
> > second if for flags, this is a poor argument.
>=20
> In that case aren't these bindings wrong (and associated xlate() function=
s)?

Ah, got it wrong, I want #pwm-cells =3D <3> where the first argument is
the index, the second the period and the third flags.

> google,cros-ec-pwm.yaml:
> [...]
> 	properties:
> 	  compatible:
> 	    const: google,cros-ec-pwm
> 	  "#pwm-cells":
> 	    description: The cell specifies the PWM index.
> 	    const: 1
> [...]
>=20
> cirrus,clps711x-pwm.txt:
> [...]
> 	- #pwm-cells: Should be 1. The cell specifies the index of the channel.
> [...]
>=20
> Note that pxa-pwm.txt behaves as you comment.

Hmm, this one has a custom .xlate function, too :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qn6okevj7lpylitq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+FxSwACgkQwfwUeK3K
7Al3cAgAjk1ptAKwNfb6sTR0PW+B9xflMvW5NBDs7hGsT9p0ch1OQYp0pmAGdFQR
ZdylEvKMTVooN8aLEqhADveVZQQSAj6ST3vkmCSNCl6u2c5eOtsO8GaGkassre3o
+6hIwO2cRoUrA/rCzjA0VxQv64lRbGXBkp3Yr5Wv0r8oeys1SevM3e5zpbWgmwef
GNcoAAkDVcpbBILvocFhWoDHtpZ+/yV6+nmaZ1AZiOl6mlU9TyA5NkRLm1oOzKXm
ZCJt8P6k7El90eEg3VYf3verHfx1JWYuKEowDbd0k1scsm+a3+Ebgd0idoNK/Rt7
HqnGOdnTkpnYbhuFSUqeq0D1PPW9Sg==
=EP00
-----END PGP SIGNATURE-----

--qn6okevj7lpylitq--
