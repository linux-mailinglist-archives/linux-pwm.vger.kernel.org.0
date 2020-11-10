Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E657F2AD7CE
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 14:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgKJNi5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 08:38:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:35390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgKJNi4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 10 Nov 2020 08:38:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7AAC6ACDB;
        Tue, 10 Nov 2020 13:38:54 +0000 (UTC)
Message-ID: <25933d5863cd6ddb98dea25bdedf342ebd063480.camel@suse.de>
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
Date:   Tue, 10 Nov 2020 14:38:52 +0100
In-Reply-To: <CAMpxmJUZ23uYM3+_L2XvTXzvA48JWrxrhZaLnGAxTpJjFiERRA@mail.gmail.com>
References: <20201104103938.1286-1-nsaenzjulienne@suse.de>
         <20201104103938.1286-2-nsaenzjulienne@suse.de>
         <CAMpxmJWJRcQQiLitJCLWKmhQVQWr3bMDY=td5FEn5uy2YZfwkA@mail.gmail.com>
         <47eaba0bc71c6e23bff87b8a01cebf0c6d12efd0.camel@suse.de>
         <CAMpxmJUZ23uYM3+_L2XvTXzvA48JWrxrhZaLnGAxTpJjFiERRA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-aSQnVn7Q9FP2OogzR6s5"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-aSQnVn7Q9FP2OogzR6s5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz, thanks for the feedback.

On Thu, 2020-11-05 at 10:42 +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 5, 2020 at 10:28 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Hi Bartosz, thanks for the review.
> >=20
> > On Thu, 2020-11-05 at 10:13 +0100, Bartosz Golaszewski wrote:
> > > > +/**
> > > > + * devm_rpi_firmware_get - Get pointer to rpi_firmware structure.
> > > > + * @firmware_node:    Pointer to the firmware Device Tree node.
> > > > + *
> > > > + * Returns NULL is the firmware device is not ready.
> > > > + */
> > > > +struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
> > > > +                                          struct device_node *firm=
ware_node)
> > > > +{
> > > > +       struct platform_device *pdev =3D of_find_device_by_node(fir=
mware_node);
> > > > +       struct rpi_firmware *fw;
> > > > +
> > > > +       if (!pdev)
> > > > +               return NULL;
> > > > +
> > > > +       fw =3D platform_get_drvdata(pdev);
> > > > +       if (!fw)
> > > > +               return NULL;
> > > > +
> > > > +       if (!refcount_inc_not_zero(&fw->consumers))
> > > > +               return NULL;
> > > > +
> > > > +       if (devm_add_action_or_reset(dev, rpi_firmware_put, fw))
> > > > +               return NULL;
> > > > +
> > > > +       return fw;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(devm_rpi_firmware_get);
> > >=20
> > > Usually I'd expect the devres variant to simply call
> > > rpi_firmware_get() and then schedule a release callback which would
> > > call whatever function is the release counterpart for it currently.
> > > Devres actions are for drivers which want to schedule some more
> > > unusual tasks at driver detach. Any reason for designing it this way?
> >=20
> > Yes, see patch #8 where I get rid of rpi_firmware_get() altogether afte=
r
> > converting all users to devres. Since there is no use for the vanilla v=
ersion
> > of the function anymore, I figured it'd be better to merge everything i=
nto
> > devm_rpi_firmware_get(). That said it's not something I have strong fee=
lings
> > about.
> >=20
>=20
> I see. So the previous version didn't really have any reference
> counting and it leaked the reference returned by
> of_find_device_by_node(), got it. Could you just clarify for me the
> logic behind the wait_queue in rpi_firmware_remove()? If the firmware
> driver gets detached and remove() stops on the wait_queue - it will be
> stuck until the last user releases the firmware. I'm not sure this is
> correct.

Yes, that's what I meant to implement.

> I'd prefer to see a kref with a release callback and remove
> would simply decrease the kref and return. Each user would do the same
> and then after the last user is detached the firmware would be
> destroyed.

Sounds good to me. I'll update it.

> Don't we really have some centralized firmware subsystem that would handl=
e this?

Sadly no, this is an RPi specific thing, it doesn't live behind a standard =
like
other firmware based protocols (for ex. SCMI), and evolves as the needs ari=
se.

Regards,
Nicolas


--=-aSQnVn7Q9FP2OogzR6s5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+ql+wACgkQlfZmHno8
x/5TFQgArzH6eU5ljiN7do5NqV1SI7f2HoX88NazrWiPc8Ixl7QT4jfzWnZeyiBn
31OdfWDVQeexADs3RDEvq/o5SSxNP+FDGlnzm9PiYaKPWcGdOpe8wW9wggXest4N
MVtyqksGQlf3MuItqI4HgP/aAhB8EKnYHTVrku2tAPR9cNliVmeusFWsPWIYXSYc
IcX61cPnzFkqU56k7aNrk452Kme6XDFDi2eD2DXAzHNlSHiQOH5ZQPKBmFUkaCDL
xP/T5PwL+YwF3ZWO2sU6voMp96QfiO8R/LYt215dIzlmTmdKcIC7scqEkr4HRSJp
9SW2n981ery3AA1wXoyGhLMJMilzcQ==
=CaET
-----END PGP SIGNATURE-----

--=-aSQnVn7Q9FP2OogzR6s5--

