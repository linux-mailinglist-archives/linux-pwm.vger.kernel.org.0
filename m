Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACAB7BB8E0
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjJFNQ5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjJFNQ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 09:16:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC2A6
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 06:16:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qokhI-0008QM-FF; Fri, 06 Oct 2023 15:16:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qokhI-00BWsE-0O; Fri, 06 Oct 2023 15:16:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qokhH-00AH3O-NJ; Fri, 06 Oct 2023 15:16:51 +0200
Date:   Fri, 6 Oct 2023 15:16:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 100/101] pwm: Ensure the memory backing a PWM chip
 isn't freed while used
Message-ID: <20231006131651.jcscu6vv7aqgafa4@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-101-u.kleine-koenig@pengutronix.de>
 <ZR__enSpj7_TBcrj@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mwtizycuptvoh2vl"
Content-Disposition: inline
In-Reply-To: <ZR__enSpj7_TBcrj@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mwtizycuptvoh2vl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Oct 06, 2023 at 02:37:14PM +0200, Thierry Reding wrote:
> On Tue, Aug 08, 2023 at 07:19:30PM +0200, Uwe Kleine-K=F6nig wrote:
> [...]
> > +static struct pwm_chip *pwmchip_alloc(struct device *parent, unsigned =
int npwm, size_t sizeof_priv)
> >  {
> >  	struct pwm_chip *chip;
> > +	struct device *dev;
> >  	size_t alloc_size;
> >  	unsigned int i;
> > =20
> >  	alloc_size =3D sizeof(*chip) + npwm * sizeof(struct pwm_device) + siz=
eof_priv;
> > =20
> > -	chip =3D devm_kzalloc(parent, alloc_size, GFP_KERNEL);
> > +	chip =3D kzalloc(alloc_size, GFP_KERNEL);
> >  	if (!chip)
> >  		return ERR_PTR(-ENOMEM);
> > =20
> > -	chip->dev =3D parent;
> > +	dev =3D &chip->dev;
> > +
> > +	device_initialize(dev);
> > +	dev->class =3D &pwm_class;
> > +	dev->parent =3D parent;
> > +	dev->release =3D pwmchip_release;
>=20
> We could potentially make this a lot simpler if we add the new struct
> device and all of that and add it during pwmchip_add(). Really the only
> thing that we need to make sure is that struct pwm_chip is the first
> field in driver-specific structures and then all of this should work the
> same way.
>
> And of course we'd have to eliminate device-managed allocations as well.
> For cases where pwmchip_release() needs to do more than just free the
> memory, we could add a new pwm_ops.release callback that drivers can
> implement if needed.

It took me a while to understand what you want here, I think I did that
now.

Once the driver is unbound, you cannot rely on any function, that the
driver might want to call, still being around -- the module containing
the driver might be unloaded. The idea is that the struct pwm_chip is
just enough for the core to check if the chip is still functional or
not. And if the driver is gone, all calls to the driver are suppressed.
So I don't see a valid (and possible) use case for a driver specific
release callback.

A drawback of your idea (if it worked at all) is that there is some
added complexity in each driver (the requirement to have struct pwm_chip
first, the unusual memory allocation/free pattern, having to care for
lifetime at all).

The pattern I suggested here works fine for spi, net devices, iio and
probably others. Sticking to that seems beneficial to me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mwtizycuptvoh2vl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUgCMIACgkQj4D7WH0S
/k6VCwgAo7n1yAadayg9+YsDFV+3WhQkQXh+0EPE4fbENArndiYsHBYaEzvU60tR
5V6NdTJsj9x1rdwh2b014SP+lETZIHB2VMytyVoAsBhdJrADgtfVPZZqu68SvuQs
8Pc68G6wKOhXVsi2+o0wNG0GBIX+stg9Ml2tUdPYOczLutavCRIGe9bCpGtT+pYf
0SXr8ZVVu7gm3gw5Pa6lY3y2pc/owRunt4hbbh3p89uBblbM/Txfar0h1Bbw0kHe
3KWHTt+oJ4SFhALTg8AGn/ap+MFX8ZKYE4ACSrG2CozylJ2O/eVm/fNFl/nQ68hg
yIWeM5diLsNCuSxIlRjMNsUPCoU07g==
=ffgO
-----END PGP SIGNATURE-----

--mwtizycuptvoh2vl--
