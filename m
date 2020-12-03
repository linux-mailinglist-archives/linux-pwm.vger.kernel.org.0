Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3DD2CD1DA
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Dec 2020 09:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgLCIx5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Dec 2020 03:53:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:58580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbgLCIx4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 3 Dec 2020 03:53:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6E0E5AC55;
        Thu,  3 Dec 2020 08:53:14 +0000 (UTC)
Message-ID: <401be3062e06f4896662da179a751a1a08b8a75a.camel@suse.de>
Subject: Re: [PATCH v5 01/11] firmware: raspberrypi: Keep count of all
 consumers
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>, wahrenst@gmx.net,
        Linux Input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 03 Dec 2020 09:53:12 +0100
In-Reply-To: <CAMpxmJX6zdoYek2THEj2x8ycJYz-bxqE_5RnOz1sYv0vwLSFpA@mail.gmail.com>
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
         <20201123183833.18750-2-nsaenzjulienne@suse.de>
         <CAMpxmJX6zdoYek2THEj2x8ycJYz-bxqE_5RnOz1sYv0vwLSFpA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-SBC+IJay38JRk592gNwQ"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-SBC+IJay38JRk592gNwQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-12-03 at 09:05 +0100, Bartosz Golaszewski wrote:
> On Mon, Nov 23, 2020 at 7:38 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >=20
> > When unbinding the firmware device we need to make sure it has no
> > consumers left. Otherwise we'd leave them with a firmware handle
> > pointing at freed memory.
> >=20
> > Keep a reference count of all consumers and introduce rpi_firmware_put(=
)
> > which will permit automatically decrease the reference count upon
> > unbinding consumer drivers.
> >=20
> > Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> > Changes since v3:
> > - Use kref instead of waiting on refcount
> >=20
> > =C2=A0drivers/firmware/raspberrypi.c             | 37 +++++++++++++++++=
++---
> > =C2=A0include/soc/bcm2835/raspberrypi-firmware.h |  2 ++
> > =C2=A02 files changed, 35 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberr=
ypi.c
> > index 30259dc9b805..ed793aef7851 100644
> > --- a/drivers/firmware/raspberrypi.c
> > +++ b/drivers/firmware/raspberrypi.c
> > @@ -7,6 +7,7 @@
> > =C2=A0=C2=A0*/
> >=20
> > =C2=A0#include <linux/dma-mapping.h>
> > +#include <linux/kref.h>
> > =C2=A0#include <linux/mailbox_client.h>
> > =C2=A0#include <linux/module.h>
> > =C2=A0#include <linux/of_platform.h>
> > @@ -27,6 +28,8 @@ struct rpi_firmware {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mbox_chan *chan;=
 /* The property channel. */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct completion c;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 enabled;
> > +
> > +       struct kref consumers;
> > =C2=A0};
> >=20
> > =C2=A0static DEFINE_MUTEX(transaction_lock);
> > @@ -225,12 +228,27 @@ static void rpi_register_clk_driver(struct device=
 *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-1, NU=
LL, 0);
> > =C2=A0}
> >=20
> > +static void rpi_firmware_delete(struct kref *kref)
> > +{
> > +       struct rpi_firmware *fw =3D container_of(kref, struct rpi_firmw=
are,
> > +                                              consumers);
> > +
> > +       mbox_free_channel(fw->chan);
> > +       kfree(fw);
> > +}
> > +
> > +void rpi_firmware_put(struct rpi_firmware *fw)
> > +{
> > +       kref_put(&fw->consumers, rpi_firmware_delete);
> > +}
> > +EXPORT_SYMBOL_GPL(rpi_firmware_put);
> > +
> > =C2=A0static int rpi_firmware_probe(struct platform_device *pdev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev =3D =
&pdev->dev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct rpi_firmware *fw=
;
> >=20
> > -       fw =3D devm_kzalloc(dev, sizeof(*fw), GFP_KERNEL);
>=20
> One nit from my side: maybe add a comment here saying that you really
> want to use non-managed kzalloc() because you're going to get people
> blindly converting it to devm_kzalloc() very soon.

Good point, I'll change it.

Regards,
Nicolas


--=-SBC+IJay38JRk592gNwQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/Ip3gACgkQlfZmHno8
x/5Ncwf8C0HFE7YBc4W1hWu3koQkBNupWVGDMLkAR36Dfmk6pph04kKcLSt6ZIu1
2SMHgfQG4VikmJnqGQp66Y93QWodjPeglOr+09VL5rY7rehOGcdBICaNPJcS1vrl
LnF+n0Lqyfirpq4rVd7qX5taBOz890GfthlZMmFsNcbFcSEuuUVogJC7iCDe+0cy
nqEYLXfaCEVDE0jR4Zvmyvs20dEZpXHR0gfoc29hMBtRLDL2l1CClG7Vm9im7Ob1
2Jm9YqHMduon8YCqLZF+jxnZesbb9ktTry5StYQ7lSZyfDxb32nOjAQqGeZfsYyF
y1nknR5dNeL/6dbIqCn33h4p6HSTbA==
=idux
-----END PGP SIGNATURE-----

--=-SBC+IJay38JRk592gNwQ--

