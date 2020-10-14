Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6724128DB17
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Oct 2020 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgJNIT7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Oct 2020 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbgJNITg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Oct 2020 04:19:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C050EC051112
        for <linux-pwm@vger.kernel.org>; Wed, 14 Oct 2020 00:02:38 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSanb-0005kZ-FZ; Wed, 14 Oct 2020 09:02:11 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSanX-0004oR-E9; Wed, 14 Oct 2020 09:02:07 +0200
Date:   Wed, 14 Oct 2020 09:02:07 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        wahrenst@gmx.net, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] pwm: Add Raspberry Pi Firmware based PWM bus
Message-ID: <20201014070207.xg35wg5jnhfuqz2y@pengutronix.de>
References: <20201009153031.986-1-nsaenzjulienne@suse.de>
 <20201009153031.986-4-nsaenzjulienne@suse.de>
 <20201012070626.fzjhp3tkmgglqnm4@pengutronix.de>
 <7899e490543723c97ffad6f42942907f8db6b9b4.camel@suse.de>
 <20201013121758.gl6ni4b47ei2bhdf@pengutronix.de>
 <c171c837a31dea34c845478b7c7d4bdef865b5e0.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgqeuslybdl72l3x"
Content-Disposition: inline
In-Reply-To: <c171c837a31dea34c845478b7c7d4bdef865b5e0.camel@suse.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xgqeuslybdl72l3x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

[Cc: +=3D Greg as base driver maintainer]

On Tue, Oct 13, 2020 at 06:50:47PM +0200, Nicolas Saenz Julienne wrote:
> On Tue, 2020-10-13 at 14:17 +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Oct 13, 2020 at 01:20:00PM +0200, Nicolas Saenz Julienne wrote:
> > > On Mon, 2020-10-12 at 09:06 +0200, Uwe Kleine-K=F6nig wrote:
> > > > I don't see a mechanism that prevents the driver providing the firm=
ware
> > > > going away while the PWM is still in use.
> > >=20
> > > There isn't an explicit one. But since you depend on a symbol from th=
e firmware
> > > driver you won't be able to remove the kernel module before removing =
the PMW
> > > one.
> >=20
> > this prevents the that the module is unloaded, but not that the driver
> > is unbound.
>=20
> Yes, if you were to unbind the firmware device all devices that depend on=
 it
> (there are a bunch of them) would access freed memory. Yet again, there i=
s no
> hotplug functionality, so short of being useful for development it'd be v=
ery
> rare for someone to unbind it. We've been living with it as such for a lo=
ng
> time. Not to say that is something not to fix, but from my perspective it=
's
> just a corner-case.

I agree, that's a corner case. However in my eyes it is one that should
be get right. Did you try if this is indeed a problem?

> We are using 'simple-mfd' in order to probe all devices under the
> firmware interface, so my first intuition would be to add support for
> automatically unbinding of consumer devices in of/platform.c. See:
>=20
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b557a0fcd4ba..d24f2412d518 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -390,7 +390,13 @@ static int of_platform_bus_create(struct device_node=
 *bus,
>         }
> =20
>         dev =3D of_platform_device_create_pdata(bus, bus_id, platform_dat=
a, parent);
> -       if (!dev || !of_match_node(matches, bus))
> +       if (!dev)
> +               return 0;
> +
> +       if (parent && of_device_is_compatible(parent->of_node, "simple-mf=
d"))
> +               device_link_add(&dev->dev, parent, DL_FLAG_AUTOREMOVE_CON=
SUMER);
> +
> +       if (!of_match_node(matches, bus))
>                 return 0;
> =20
>         for_each_child_of_node(bus, child) {

This looks wrong for generic code. A solution local to simple-mfd (or
even the firmware device?) should be done (and doable). I think the
straight forward approach would be to add reference counting and make
=2Eremove of the firmware device block if there are still users.
(Returning an error doesn't prevent the device going away IIRC. Last
time I looked .remove returning something non-0 didn't make any
difference. Maybe we should change it to return void?)

> If this is too much for OF maintainers, we could simply create the link u=
pon
> calling rpi_firmware_get().

I don't know how DL_FLAG_AUTOREMOVE_CONSUMER works, but this sounds
better.

> This solves the problem of getting a kernel panic because of the use after
> free, but you'll still get some warnings after unbinding from the GPIO
> subsystem, for example, as we just removed a gpiochip that still has cons=
umers
> up. I guess device links only go so far.

If this is indeed a real problem, lets take this to the GPIO
maintainers.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xgqeuslybdl72l3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+GomwACgkQwfwUeK3K
7AmfpAf/eJMGdvOaHLFh9CYeu88+4wE2AXSNdxyNnK7AFovUtxsCGbbMCabDiB1g
vTEACdDG196IyiWtz04gSoTVJfHCs9HOUukM6SQot7TKarIaEHZH+kt1QMSddLpG
E6vfCA1KsS/C/2z088PDlSEngoIw9ZQjqsAvdNfECicPkt6xb9JjRTqo0nsKlXvA
gd4JixCJuDzKpT0QX2DMMuUBC1HtderUOOz+bNVfcOcBoZ4ERLvgOKw+Y6z6QpRF
hvd7oDBaBlaq1GW7A+cWKIGeStw20G1DHpa5eeH6Lmi7ujQSwF34g6F77jqfCzR8
MozxfsgfT71ShyrCRK5UUTvXlJuWjQ==
=NE+d
-----END PGP SIGNATURE-----

--xgqeuslybdl72l3x--
