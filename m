Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425A72A7A78
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 10:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgKEJ2r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 04:28:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:55458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbgKEJ2n (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 5 Nov 2020 04:28:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC238AC19;
        Thu,  5 Nov 2020 09:28:40 +0000 (UTC)
Message-ID: <47eaba0bc71c6e23bff87b8a01cebf0c6d12efd0.camel@suse.de>
Subject: Re: [PATCH v3 01/11] firmware: raspberrypi: Introduce
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
Date:   Thu, 05 Nov 2020 10:28:38 +0100
In-Reply-To: <CAMpxmJWJRcQQiLitJCLWKmhQVQWr3bMDY=td5FEn5uy2YZfwkA@mail.gmail.com>
References: <20201104103938.1286-1-nsaenzjulienne@suse.de>
         <20201104103938.1286-2-nsaenzjulienne@suse.de>
         <CAMpxmJWJRcQQiLitJCLWKmhQVQWr3bMDY=td5FEn5uy2YZfwkA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oC8aCgFhzSXrvhwX/0tO"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-oC8aCgFhzSXrvhwX/0tO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz, thanks for the review.

On Thu, 2020-11-05 at 10:13 +0100, Bartosz Golaszewski wrote:
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
> > +       struct platform_device *pdev =3D of_find_device_by_node(firmwar=
e_node);
> > +       struct rpi_firmware *fw;
> > +
> > +       if (!pdev)
> > +               return NULL;
> > +
> > +       fw =3D platform_get_drvdata(pdev);
> > +       if (!fw)
> > +               return NULL;
> > +
> > +       if (!refcount_inc_not_zero(&fw->consumers))
> > +               return NULL;
> > +
> > +       if (devm_add_action_or_reset(dev, rpi_firmware_put, fw))
> > +               return NULL;
> > +
> > +       return fw;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_rpi_firmware_get);
>=20
> Usually I'd expect the devres variant to simply call
> rpi_firmware_get() and then schedule a release callback which would
> call whatever function is the release counterpart for it currently.
> Devres actions are for drivers which want to schedule some more
> unusual tasks at driver detach. Any reason for designing it this way?

Yes, see patch #8 where I get rid of rpi_firmware_get() altogether after
converting all users to devres. Since there is no use for the vanilla versi=
on
of the function anymore, I figured it'd be better to merge everything into
devm_rpi_firmware_get(). That said it's not something I have strong feeling=
s
about.

Regards,
Nicolas


--=-oC8aCgFhzSXrvhwX/0tO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+jxccACgkQlfZmHno8
x/5VuAf/ZVJHy+YDj0FEO4FzcWJ4vn2WN7US3fwbVPePjVLjGsdlhWl+H5zdV5W2
ZNDlMxJ8w+gcUcLGCaov80hxbNVMQJgoiK/0AeaNxVaa/6fK+IOV05LYOKCIET4a
4FhlGaazIlYPqNLtlW2lCQHmFb7fK+sHX4BQltlAA44qaBVZv206o8WOvmUmxIrz
d3rUtSsUcHJMf+HlCRrKol2ZEmgPjSUFdsGnvaoFVtlxeHGvSJ53cOydnRJK27TN
bITVEZcyTfW/u7Vd+cOLi3Rd3DuzzIFbxW1nb4nIqy2mg3bg2pjFYkkshrV8m7mA
LAhpfGsro/83lduAxqUNuNjw2PoQHQ==
=b2j1
-----END PGP SIGNATURE-----

--=-oC8aCgFhzSXrvhwX/0tO--

