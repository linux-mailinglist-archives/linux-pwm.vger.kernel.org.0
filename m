Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346882B181A
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 10:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgKMJVd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 04:21:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:58080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKMJVc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 13 Nov 2020 04:21:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2523CAE92;
        Fri, 13 Nov 2020 09:21:30 +0000 (UTC)
Message-ID: <3af26701a12b0bcb55b8d422e2a18f06a8e94d4d.camel@suse.de>
Subject: Re: [PATCH v4 02/11] firmware: raspberrypi: Introduce
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
Date:   Fri, 13 Nov 2020 10:21:28 +0100
In-Reply-To: <CAMpxmJWZsqfkkTP99a_8mu+O4xHwNWDqHuvgt7Cs88bA-iMvQA@mail.gmail.com>
References: <20201112163630.17177-1-nsaenzjulienne@suse.de>
         <20201112163630.17177-3-nsaenzjulienne@suse.de>
         <CAMpxmJWZsqfkkTP99a_8mu+O4xHwNWDqHuvgt7Cs88bA-iMvQA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-lVAZyxFfZVTn1rZzZexc"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-lVAZyxFfZVTn1rZzZexc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-12 at 18:25 +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 12, 2020 at 5:44 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Itroduce devm_rpi_firmware_get(), it'll simplify the firmware handling
> > for most consumers.
> >=20
> > Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >=20
> > Changes since v2:
> > - Introduce devm_rpi_firmware_get()
> >=20
> >  drivers/firmware/raspberrypi.c             | 31 +++++++++++++++++++++-
> >  include/soc/bcm2835/raspberrypi-firmware.h |  8 ++++++
> >  2 files changed, 38 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberr=
ypi.c
> > index 438e17074a97..4ab2dfdc82ad 100644
> > --- a/drivers/firmware/raspberrypi.c
> > +++ b/drivers/firmware/raspberrypi.c
> > @@ -237,10 +237,17 @@ static void rpi_firmware_delete(struct kref *kref=
)
> >         kfree(fw);
> >  }
> >=20
> > -void rpi_firmware_put(struct rpi_firmware *fw)
> > +static void __rpi_firmware_put(void *data)
> >  {
>=20
> The '__' prefix is very vague and usually used for unlocked variants
> of functions. The casting to void * in rpi_firmware_put() is also
> unneeded. I would much prefer that the devres release callback be
> called devm_rpi_firmware_put() and that it call rpi_firmware_put()
> which would then call kref_put().

Yes, that's better. I'll change it.

Regards,
Nicolas


--=-lVAZyxFfZVTn1rZzZexc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+uUBgACgkQlfZmHno8
x/6lEgf/d59t0Td5W4xLTNBLofc0Vh4uZHeN9Gvi6L52ayUePt+6T8iYBizcBSD7
gMFFnbzAziAWiKl7DSZjZTOaVNPohvZqyhssPCN/xAs2Xw4k/9iy8SfjtY0LyJ5S
cY0As+Fny0/3v+hdAXAcl0O26eMFecffjVnEne56Iyy9pA1GAsjf2IU2XO6bE2sX
qED6OKxz+B+3vVZOyHv4E10B0L1rIs64Tjrh0fUElpaT+d8jPJ2aog1LKEjPe+rD
1QA4cwN8xmkiB6Tj97LK6q2yG2Cji9OHBP6QEw9orQHti/aKKhozLyw+stmIq/uF
gGk9YGb3/9okyNRC33V9EFN+3zjzCg==
=Sbj8
-----END PGP SIGNATURE-----

--=-lVAZyxFfZVTn1rZzZexc--

