Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195D47BBD71
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 19:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjJFREY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjJFREX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 13:04:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64BC2
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 10:04:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qooFP-00027r-Vy; Fri, 06 Oct 2023 19:04:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qooFP-00BYp4-B2; Fri, 06 Oct 2023 19:04:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qooFP-00AOMJ-1h; Fri, 06 Oct 2023 19:04:19 +0200
Date:   Fri, 6 Oct 2023 19:04:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 070/101] pwm: Ensure a struct pwm have the same
 lifetime as its pwm_chip
Message-ID: <20231006170418.64c4znd3tbblkdcd@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-71-u.kleine-koenig@pengutronix.de>
 <ZR_VhNLrXVUc2Fxr@orome.fritz.box>
 <20231006110451.eztc5sfw6knzm6xf@pengutronix.de>
 <ZR_sk12BgUYXvFkp@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b3p235hnvz4jmndg"
Content-Disposition: inline
In-Reply-To: <ZR_sk12BgUYXvFkp@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--b3p235hnvz4jmndg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Oct 06, 2023 at 01:16:35PM +0200, Thierry Reding wrote:
> On Fri, Oct 06, 2023 at 01:04:51PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Oct 06, 2023 at 11:38:12AM +0200, Thierry Reding wrote:
> > > On Tue, Aug 08, 2023 at 07:19:00PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > It's required to not free the memory underlying a requested PWM
> > > > while a consumer still has a reference to it. While currently a pwm=
_chip
> > > > doesn't life long enough in all cases, linking the struct pwm to the
> > > > pwm_chip results in the right lifetime as soon as the pwmchip is li=
ving
> > > > long enough. This happens with the following commits.
> > > >=20
> > > > Note this is a breaking change for all pwm drivers that don't use
> > > > pwmchip_alloc().
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  drivers/pwm/core.c  | 24 +++++++++---------------
> > > >  include/linux/pwm.h |  2 +-
> > > >  2 files changed, 10 insertions(+), 16 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > > index cfcddf62ab01..3b8d41fdda1b 100644
> > > > --- a/drivers/pwm/core.c
> > > > +++ b/drivers/pwm/core.c
> > > > @@ -198,7 +198,7 @@ static bool pwm_ops_check(const struct pwm_chip=
 *chip)
> > > > =20
> > > >  void *pwmchip_priv(struct pwm_chip *chip)
> > > >  {
> > > > -	return &chip[1];
> > > > +	return &chip->pwms[chip->npwm];
> > >=20
> > > I already disliked &chip[1] and this isn't making things any better. I
> > > fully realize that this is going to give us the right address, but it
> > > just looks wrong. Can we not do something like:
> > >=20
> > > 	return (void *)chip + sizeof(*chip);
> >=20
> > In practise this works, but I'm not 100% confident that the compiler
> > might not add padding that breaks this. I don't particularly like this
> > function either and will think a bit more about it for v2.
>=20
> I'm not at all a fan of this whole pwmchip_alloc() business and I would
> prefer if we could somehow just keep embedding this into the driver-
> specific structures and take care of the lifetime management with less
> intrusion.
>=20
> However, I don't see how that could easily be done. It would be slightly
> easier if we didn't use the flexible array, I suppose.

Without that flexible array member you'd need a pointer instead of the
struct pwm_device pwms[] in struct pwm_chip and a separate allocation.

While handling the flexible array isn't exactly pretty, I prefer it
compared to the consequences of the alternative (two allocation instead
of one, so more memory management cruft, less cache locality, more
pointer dereferences). Also given that the ugliness of the flexible
array approach is limited to this one function it's IMHO easily possible
to get over it.

The idea used by the counter core (in drivers/counter/counter-core.c)
with a struct counter_device_allochelper doesn't work in combination
with the flexible array. netdev_priv uses a similar approach to what you
suggested (and adds some complexity by adding an alignment). Anyhow, if
we continue to have a single allocation for struct pwm_chip, the array
of pwm_devices belonging to the chip and priv data (which I think is a
good idea), then we cannot avoid some memory address calculation because
the array size and the size of private data differs per driver (or even
per chip). Something like
https://lore.kernel.org/linux-iio/20230724110204.46285-3-andriy.shevchenko@=
linux.intel.com
could be used (but I'm unsure if this makes things prettier). The
struct_size macro from include/linux/overflow.h could be beneficial
though?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b3p235hnvz4jmndg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUgPhIACgkQj4D7WH0S
/k6ruQf/bXb0W3idvhypJ2jIpLAY4imuTW4pdzTqNBri7vegTzlyu6lTL26oKZGN
L/OFetAzLb12KX8QrMVJ8jETknjB8NvdI8QmueZpZ31bLAC1msQLV6EmFDaJUNl7
+qz6txilF4eN7Ifv8e6QVqDe4kk+ruD86yKFvo2RvYjbbkOgAX+ic8nMl6WrGLoD
5a14iXotWpYcTPW/OEl53hXT/hG8YbMDPPLawpkd2G78qtO/qVGrbiDn6Ls14+DO
P529mUCPiFK9FPh2ryxptF0iU2xPb+v0GAJo9Ffc4khaF5d+03H9djRjLyKk0egR
L8nlNuMDuWIXrvahLw++j6HG8IHkhA==
=Vft8
-----END PGP SIGNATURE-----

--b3p235hnvz4jmndg--
