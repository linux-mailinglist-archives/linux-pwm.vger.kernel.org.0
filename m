Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0784C298EC4
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 15:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780892AbgJZODD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 10:03:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:55984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780884AbgJZODD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 26 Oct 2020 10:03:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 83880AD83;
        Mon, 26 Oct 2020 14:03:00 +0000 (UTC)
Message-ID: <13068cff8e3a994df5d8fbe19deb068a741365f3.camel@suse.de>
Subject: Re: [PATCH v2 10/10] pwm: Add Raspberry Pi Firmware based PWM bus
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Date:   Mon, 26 Oct 2020 15:02:58 +0100
In-Reply-To: <CAHp75VcB5oxXs38UH5taVGj21wUi3sHYdRPOj3wxa3yXg0vmUA@mail.gmail.com>
References: <20201022155858.20867-1-nsaenzjulienne@suse.de>
         <20201022155858.20867-11-nsaenzjulienne@suse.de>
         <CAHp75VcB5oxXs38UH5taVGj21wUi3sHYdRPOj3wxa3yXg0vmUA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-TTVm3kIKIXd08z1jOMlD"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-TTVm3kIKIXd08z1jOMlD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy, thanks for the review!

On Thu, 2020-10-22 at 21:53 +0300, Andy Shevchenko wrote:
> On Thu, Oct 22, 2020 at 9:05 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Adds support to control the PWM bus available in official Raspberry Pi
> > PoE HAT. Only RPi's co-processor has access to it, so commands have to
> > be sent through RPi's firmware mailbox interface.
> >  drivers/pwm/pwm-raspberrypi.c | 221 ++++++++++++++++++++++++++++++++++
>=20
> Name is completely confusing.
> Please, make it unique enough to understand that this is exactly the
> device it serves for.
>=20
> For example, pwm-rpi-poe is better.

Sounds reasonable, I'll change that.

>=20
> ...
>=20
> > + *  - Only normal polarity
>=20
> Can't it be emulated? Isn't it 100% - duty cycle % ?

I guess it can, OTOH given the rather specific use case, I doubt it'll be
worth the effort.

> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
>=20
> ...
>=20
> > +       ret =3D rpi_firmware_property(firmware, RPI_FIRMWARE_SET_POE_HA=
T_VAL,
> > +                                   &msg, sizeof(msg));
> > +       if (ret)
> > +               return ret;
> > +       else if (msg.ret)
>=20
> Redundant 'else'

Noted.

> > +       firmware_node =3D of_get_parent(dev->of_node);
> > +       if (!firmware_node) {
> > +               dev_err(dev, "Missing firmware node\n");
> > +               return -ENOENT;
> > +       }
> > +
> > +       firmware =3D rpi_firmware_get(firmware_node);
> > +       of_node_put(firmware_node);
> > +       if (!firmware)
> > +               return -EPROBE_DEFER;
>=20
> Looks like a hack.

This is the pattern we've been using on all firmware dependent devices so f=
ar.
Feel free to suggest a better way, I'll be happy to look into it.

>=20
> ...
>=20
> > +       ret =3D pwmchip_remove(&rpipwm->chip);
> > +       if (!ret)
> > +               rpi_firmware_put(rpipwm->firmware);
> > +
> > +       return ret;
>=20
> Can't you use the usual pattern?

Yes of course. Don't know why I went this way.

Regards,
Nicolas


--=-TTVm3kIKIXd08z1jOMlD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+W1xIACgkQlfZmHno8
x/4NJgf/d3PqOAENee9eHOK6FqBMAsNsGn4fscamb7Q7MXABE4U/nFCFY7hg1Xo3
g47j4m8+pNlzE3SjXX0ZyPle4beIWvNQWidQjSyprckUv+wNkJ1Wbt0lFH26GCig
w8mRGcXYm12zKKDSpGf5Wg/qAhE9qV2ruti8nc94lkSoiP2kSlfp6j5MZZYzEd2p
y4khOBqxT1e4Trh+QOhKke2pW43WHNZT0TW6ZhJxKq4UNq7lxzer9TFHWgda16oy
C4kdNiGm9MDQicgNWAq18ctJTZvPoR1scLrBNpJOapJ1UuY0mCqjpMZJDi9W+/EB
7FRq+EXSXY7hpOmPUUJ1pJm1mUNoOw==
=ljds
-----END PGP SIGNATURE-----

--=-TTVm3kIKIXd08z1jOMlD--

