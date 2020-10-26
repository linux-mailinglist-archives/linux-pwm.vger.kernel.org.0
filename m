Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8204D298FA5
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 15:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781830AbgJZOmL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 10:42:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:36072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1781658AbgJZOmK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 26 Oct 2020 10:42:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2EF1CB8E1;
        Mon, 26 Oct 2020 14:42:08 +0000 (UTC)
Message-ID: <700a149849222f3efbec73cb8a6be56b4b1c5bcb.camel@suse.de>
Subject: Re: [PATCH v2 03/10] gpio: raspberrypi-exp: Release firmware handle
 on unbind
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>, wahrenst@gmx.net,
        Linux Input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel@lists.infradead.org
Date:   Mon, 26 Oct 2020 15:42:06 +0100
In-Reply-To: <CAMpxmJXw12hKYCuMDjG-Ns6n=mXmr4B2x3HJaAJ19wH_xDUMag@mail.gmail.com>
References: <20201022155858.20867-1-nsaenzjulienne@suse.de>
         <20201022155858.20867-4-nsaenzjulienne@suse.de>
         <CAMpxmJXw12hKYCuMDjG-Ns6n=mXmr4B2x3HJaAJ19wH_xDUMag@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4RJXy1XArEUanWEz7Yut"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-4RJXy1XArEUanWEz7Yut
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-10-26 at 15:40 +0100, Bartosz Golaszewski wrote:
> On Thu, Oct 22, 2020 at 5:59 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Upon unbinding the device make sure we release RPi's firmware interface=
.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/gpio/gpio-raspberrypi-exp.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpio/gpio-raspberrypi-exp.c b/drivers/gpio/gpio-ra=
spberrypi-exp.c
> > index bb100e0124e6..c008336e1131 100644
> > --- a/drivers/gpio/gpio-raspberrypi-exp.c
> > +++ b/drivers/gpio/gpio-raspberrypi-exp.c
> > @@ -231,8 +231,19 @@ static int rpi_exp_gpio_probe(struct platform_devi=
ce *pdev)
> >         rpi_gpio->gc.get =3D rpi_exp_gpio_get;
> >         rpi_gpio->gc.set =3D rpi_exp_gpio_set;
> >         rpi_gpio->gc.can_sleep =3D true;
> > +       platform_set_drvdata(pdev, rpi_gpio);
> >=20
> > -       return devm_gpiochip_add_data(dev, &rpi_gpio->gc, rpi_gpio);
> > +       return gpiochip_add_data(&rpi_gpio->gc, rpi_gpio);
> > +}
> > +
> > +static int rpi_exp_gpio_remove(struct platform_device *pdev)
> > +{
> > +       struct rpi_exp_gpio *rpi_gpio =3D platform_get_drvdata(pdev);
> > +
> > +       gpiochip_remove(&rpi_gpio->gc);
> > +       rpi_firmware_put(rpi_gpio->fw);
> > +
> > +       return 0;
> >  }
> >=20
> >  static const struct of_device_id rpi_exp_gpio_ids[] =3D {
> > @@ -247,6 +258,7 @@ static struct platform_driver rpi_exp_gpio_driver =
=3D {
> >                 .of_match_table =3D of_match_ptr(rpi_exp_gpio_ids),
> >         },
> >         .probe  =3D rpi_exp_gpio_probe,
> > +       .remove =3D rpi_exp_gpio_remove,
> >  };
> >  module_platform_driver(rpi_exp_gpio_driver);
> >=20
> > --
> > 2.28.0
> >=20
>=20
> Why not introduce devm_rpi_firmware_get()? That would allow you to
> keep the driver elegant without re-adding remove().

I like the idea, I'll look into it.

Thanks,
Nicolas


--=-4RJXy1XArEUanWEz7Yut
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+W4D4ACgkQlfZmHno8
x/4RVwf/UZbRYwQfpY+67Gru7U3IMExckiPcjOHqeN3IO1Aqys6hi0LcCgQmZoRS
yDES/QK4HITWb2LEOikdeICzUhcAmHLuD6l9Si1lOw/g7RZAcNoB+gejoLIKsxsJ
BvBSsCz+ARcANf68gksyv52nsVLhMNlvZpnoVV6p9VTzTb0q7+QOBy7KndC73pyM
cLs3LcbX7jTY71QjVIAVJql7UiQmzjA9V08bxNan8AF/yttAj0PgtZga1WYXQHG/
ipUuvMADCJYB9WrHAhtY8TV1G1pGs0b+OTU6cEZukdSAUaNXzL+DKDHm3nlMi887
7aRyD6vm++8u7ecNrtj2/Iug3MLyQg==
=FwXW
-----END PGP SIGNATURE-----

--=-4RJXy1XArEUanWEz7Yut--

