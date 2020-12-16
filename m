Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FAD2DBED0
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Dec 2020 11:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgLPKhr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Dec 2020 05:37:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:38212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgLPKhq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 16 Dec 2020 05:37:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9006CAC91;
        Wed, 16 Dec 2020 10:37:03 +0000 (UTC)
Message-ID: <e2aa9af87060b91397fc4e1485ecf3ab3876f874.camel@suse.de>
Subject: Re: [PATCH v6 02/11] firmware: raspberrypi: Introduce
 devm_rpi_firmware_get()
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
Date:   Wed, 16 Dec 2020 11:37:01 +0100
In-Reply-To: <CAMpxmJX5t=LWpLkY=uYNK9r4rmStuSfmGc7=zcnu4_oHkQevWQ@mail.gmail.com>
References: <20201211164801.7838-1-nsaenzjulienne@suse.de>
         <20201211164801.7838-3-nsaenzjulienne@suse.de>
         <CAMpxmJX5t=LWpLkY=uYNK9r4rmStuSfmGc7=zcnu4_oHkQevWQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vwdPcx+UPfpMDeh3uqYM"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-vwdPcx+UPfpMDeh3uqYM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-12-16 at 11:35 +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 11, 2020 at 5:48 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >=20
> > It'll simplify the firmware handling for most consumers.
> >=20
> > Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >=20
> > Changes since v4:
> > =C2=A0- Rearrange function calls for clarity, same functionality
> >=20
> > Changes since v2:
> > - Create devm_rpi_firmware_get()
> >=20
> > =C2=A0drivers/firmware/raspberrypi.c             | 29 +++++++++++++++++=
+++++
> > =C2=A0include/soc/bcm2835/raspberrypi-firmware.h |  8 ++++++
> > =C2=A02 files changed, 37 insertions(+)
> >=20
> > diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberr=
ypi.c
> > index b65e4c495772..250e01680742 100644
> > --- a/drivers/firmware/raspberrypi.c
> > +++ b/drivers/firmware/raspberrypi.c
> > @@ -243,6 +243,13 @@ void rpi_firmware_put(struct rpi_firmware *fw)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(rpi_firmware_put);
> >=20
> > +static void devm_rpi_firmware_put(void *data)
> > +{
> > +       struct rpi_firmware *fw =3D data;
> > +
> > +       rpi_firmware_put(fw);
> > +}
> > +
> > =C2=A0static int rpi_firmware_probe(struct platform_device *pdev)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev =3D =
&pdev->dev;
> > @@ -331,6 +338,28 @@ struct rpi_firmware *rpi_firmware_get(struct devic=
e_node *firmware_node)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(rpi_firmware_get);
> >=20
> > +/**
> > + * devm_rpi_firmware_get - Get pointer to rpi_firmware structure.
> > + * @firmware_node:    Pointer to the firmware Device Tree node.
> > + *
> > + * Returns NULL is the firmware device is not ready.
> > + */
> > +struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
> > +                                          struct device_node *firmware=
_node)
> > +{
> > +       struct rpi_firmware *fw;
> > +
> > +       fw =3D rpi_firmware_get(firmware_node);
> > +       if (!fw)
> > +               return NULL;
> > +
> > +       if (devm_add_action_or_reset(dev, devm_rpi_firmware_put, fw))
> > +               return NULL;
> > +
> > +       return fw;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_rpi_firmware_get);
> > +
> > =C2=A0static const struct of_device_id rpi_firmware_of_match[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "rasp=
berrypi,bcm2835-firmware", },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{},
> > diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/b=
cm2835/raspberrypi-firmware.h
> > index fdfef7fe40df..73ad784fca96 100644
> > --- a/include/soc/bcm2835/raspberrypi-firmware.h
> > +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> > @@ -142,6 +142,8 @@ int rpi_firmware_property_list(struct rpi_firmware =
*fw,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void *data, size_t tag_size);
> > =C2=A0void rpi_firmware_put(struct rpi_firmware *fw);
> > =C2=A0struct rpi_firmware *rpi_firmware_get(struct device_node *firmwar=
e_node);
> > +struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
> > +                                          struct device_node *firmware=
_node);
> > =C2=A0#else
> > =C2=A0static inline int rpi_firmware_property(struct rpi_firmware *fw, =
u32 tag,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0void *data, size_t len)
> > @@ -160,6 +162,12 @@ static inline struct rpi_firmware *rpi_firmware_ge=
t(struct device_node *firmware
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > =C2=A0}
> > +
> > +static inline struct rpi_firmware *devm_rpi_firmware_get(struct device=
 *dev,
> > +                                       struct device_node *firmware_no=
de)
> > +{
> > +       return NULL;
> > +}
> > =C2=A0#endif
> >=20
> > =C2=A0#endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
> > --
> > 2.29.2
> >=20
>=20
> Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks for the reviews!


--=-vwdPcx+UPfpMDeh3uqYM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/Z400ACgkQlfZmHno8
x/7Iywf+OISkQiK8ivH64i3HBYWqMPVD1qIvtJ1TmGWjD3DvKFTZ6MyChlJ+q50A
SYrVEUumIO6RuuG2lOR7m6xOJPxZtt7L6MfQutuhY6n/dIEVJT40IbV4Kpg3yFFF
/zGjYOHjgXJXwY526+RS3270kIOyF1UI1+UxMj68VBDwiIM6yAHbDfUgVxleiGc0
a7nbijIRYtTOqUXOgUhXBv7wxARIQY+bR7f+d3q7Xk6cJ4fRJpSzV2WR6kZ+q+rV
6M+Jh3ay5tgLFyqffrZ0Dpos+QDtX/60UUz08YYLKW6wu5Ark23dFtFxA7SE/lg6
9/vRJ8DBREyVK1QAxGA+Og64VJX0/w==
=KycM
-----END PGP SIGNATURE-----

--=-vwdPcx+UPfpMDeh3uqYM--

