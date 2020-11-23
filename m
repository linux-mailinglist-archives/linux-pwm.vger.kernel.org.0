Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638692C11C8
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Nov 2020 18:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbgKWRTk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Nov 2020 12:19:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:58310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgKWRTj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 23 Nov 2020 12:19:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52398AC82;
        Mon, 23 Nov 2020 17:19:37 +0000 (UTC)
Message-ID: <ac38b89133f80f82b857ad2b4e421b501c2f4826.camel@suse.de>
Subject: Re: [PATCH v4 01/11] firmware: raspberrypi: Keep count of all
 consumers
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        linux-input <linux-input@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 23 Nov 2020 18:19:35 +0100
In-Reply-To: <20201113072615.GE356503@dtor-ws>
References: <20201112163630.17177-1-nsaenzjulienne@suse.de>
         <20201112163630.17177-2-nsaenzjulienne@suse.de>
         <CAHp75Vf9E7UWVDMs=eRjLjoSN6SVOWw9thNdnR8ruCL6GmY7JQ@mail.gmail.com>
         <20201113072615.GE356503@dtor-ws>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4mT4pfaztxo3yJL0guCg"
User-Agent: Evolution 3.38.1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-4mT4pfaztxo3yJL0guCg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-12 at 23:26 -0800, Dmitry Torokhov wrote:
> On Thu, Nov 12, 2020 at 07:52:14PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 12, 2020 at 6:40 PM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > >=20
> > > When unbinding the firmware device we need to make sure it has no
> > > consumers left. Otherwise we'd leave them with a firmware handle
> > > pointing at freed memory.
> > >=20
> > > Keep a reference count of all consumers and introduce rpi_firmware_pu=
t()
> > > which will permit automatically decrease the reference count upon
> > > unbinding consumer drivers.
> >=20
> > ...
> >=20
> > > =C2=A0/**
> > > - * rpi_firmware_get - Get pointer to rpi_firmware structure.
> > > =C2=A0=C2=A0* @firmware_node:    Pointer to the firmware Device Tree =
node.
> > > =C2=A0=C2=A0*
> > > + * The reference to rpi_firmware has to be released with rpi_firmwar=
e_put().
> > > + *
> > > =C2=A0=C2=A0* Returns NULL is the firmware device is not ready.
> > > =C2=A0=C2=A0*/
> > > =C2=A0struct rpi_firmware *rpi_firmware_get(struct device_node *firmw=
are_node)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct platform_devic=
e *pdev =3D of_find_device_by_node(firmware_node);
> > > +       struct rpi_firmware *fw;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!pdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> > >=20
> > > -       return platform_get_drvdata(pdev);
> > > +       fw =3D platform_get_drvdata(pdev);
> > > +       if (!fw)
> > > +               return NULL;
> > > +
> > > +       if (!kref_get_unless_zero(&fw->consumers))
> > > +               return NULL;
> >=20

Hi Andy, Dimitry,

> > Don't we have a more traditional way of doing this, i.e.
> > try_module_get() coupled with get_device() ?
>=20
> get_device() will make sure that device is there, but gives no
> assurances that device is bound to a driver, so it will not help with
> the racy access to firmware via platform_get_drvdata() call.

I also looked at using get/put_device() just as a means for refcounting (i.=
e.
replacing fw->consumers), but I can't make it work either. I'd need a way t=
o
hook up into one of the struct device_ktype release() functions. AFAIK it's=
 not
possible for private uses like this.

IIUC the way to do this would be to bypass platform device and create a spe=
cial
device class/bus for RPi's firmware dependent devices (I could pretty much =
copy
SCMI's implementation), but I fear that's overkill.

So, for now I'll stick with the kref based implementation, I'll be happy to
change it if you find a better solution. :)

Regards,
Nicolas


--=-4mT4pfaztxo3yJL0guCg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+77ycACgkQlfZmHno8
x/4SuAf/fbVt5dbVlASpaXs9h1cMXb/e8xl+GmDU2l1pP/uQHmyY+sGKGqNo7+G1
gtKuEhPEavnasiHhJaBTWCCpwytJF9/iToX0i75cDZIObrF1xbO1A3L7hvlRiO6x
C+oECKGo3/Awayb7MRHqEiRrLqtuu0odnT3Usn26Rbo7J2o5Lc4KF8WwYblFkmV9
KCW77SlB/6W865vD6KK1KaN6nPqOD3XmKC7doM/MWHIvYd8siFy8qlT5m06s/vhC
OHHbX2/7bhgcB+3/9LA9TF5J/JU9KIDHuUVbPYC2hcAVbkELXL93OwJ3DnN7csjp
6obres4oiWUNt0B5Zi7lJDT4Y1KnUw==
=C3d8
-----END PGP SIGNATURE-----

--=-4mT4pfaztxo3yJL0guCg--

