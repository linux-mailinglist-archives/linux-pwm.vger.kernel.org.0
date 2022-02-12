Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4184B34DA
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Feb 2022 13:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiBLMAu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 12 Feb 2022 07:00:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiBLMAu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 12 Feb 2022 07:00:50 -0500
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Feb 2022 04:00:47 PST
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491082613A
        for <linux-pwm@vger.kernel.org>; Sat, 12 Feb 2022 04:00:47 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BB8191C0B7A; Sat, 12 Feb 2022 12:54:39 +0100 (CET)
Date:   Sat, 12 Feb 2022 12:54:38 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        sven@svenschwermer.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
Message-ID: <20220212115438.GG20866@duo.ucw.cz>
References: <20220126104844.246068-1-sven@svenschwermer.de>
 <20220126104844.246068-2-sven@svenschwermer.de>
 <00d8de09-360e-4e0f-1496-642ba1cbf863@gmail.com>
 <20220128213609.7a60e9fe@thinkpad>
 <09b46d05-5dd0-a585-2ca3-0bc04e613343@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline
In-Reply-To: <09b46d05-5dd0-a585-2ca3-0bc04e613343@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologi=
es.com>
> > > > ---
> > > [...]
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/leds/common.h>
> > > > +
> > > > +    rgb-led {
> > > > +        compatible =3D "pwm-leds-multicolor";
> > > > +
> > > > +        multi-led {
> > > > +          color =3D <LED_COLOR_ID_RGB>;
> > > > +          function =3D LED_FUNCTION_INDICATOR;
> > > > +          max-brightness =3D <65535>;
> > >=20
> > > It doesn't make much sense to have such a big resolution of global
> > > multi color brightness. 255 will be sufficient.
> >=20
> > If the PWM supports it, why not?
> > On Omnia the default is 255, and since it is PWM, the change from 0/255
> > to 1/255 is much bigger then from, say, 15/255 to 16/255. So if 1/255
> > is too bright, you are then unable to set it less bright. I think 1024
> > or ever 65535 makes sense with PWMs.
>=20
> With values other than 255 we will not achieve 24-bit RGB, which is one
> problem, and the other one is non-linear brightness that can be achieved
> with PWM. So probably we would need to add an additional note in the
> documentation [0], saying that changing global brightness allows to
> preserve combined LED hue only when all sub-leds are linear, and that it
> will not be the case for PWM LEDs.

I have yet to see a LED that was anything but linear. If we'll want to
match colorspace of RGB displays, we'll need to do more work. (Often,
255/255/255 is not white with RGB LEDs, for example).

So 16-bit pwm makes sense to me.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYgef/gAKCRAw5/Bqldv6
8mxaAJ9Huuordp8TZqDmLJtJHl/NWt/PIwCgvwg5KEPKBErrbU2khVMFNF0MsCc=
=oYPN
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--
