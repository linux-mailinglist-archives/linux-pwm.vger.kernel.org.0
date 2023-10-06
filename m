Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB0E7BB5DD
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 13:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjJFLE6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 07:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjJFLE5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 07:04:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8D2E9
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 04:04:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoidY-0006ol-PP; Fri, 06 Oct 2023 13:04:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoidY-00BV6G-Bc; Fri, 06 Oct 2023 13:04:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qoidY-00AA0U-2I; Fri, 06 Oct 2023 13:04:52 +0200
Date:   Fri, 6 Oct 2023 13:04:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 070/101] pwm: Ensure a struct pwm have the same
 lifetime as its pwm_chip
Message-ID: <20231006110451.eztc5sfw6knzm6xf@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-71-u.kleine-koenig@pengutronix.de>
 <ZR_VhNLrXVUc2Fxr@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cdqrwvddujfkz26f"
Content-Disposition: inline
In-Reply-To: <ZR_VhNLrXVUc2Fxr@orome.fritz.box>
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


--cdqrwvddujfkz26f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 11:38:12AM +0200, Thierry Reding wrote:
> On Tue, Aug 08, 2023 at 07:19:00PM +0200, Uwe Kleine-K=F6nig wrote:
> > It's required to not free the memory underlying a requested PWM
> > while a consumer still has a reference to it. While currently a pwm_chip
> > doesn't life long enough in all cases, linking the struct pwm to the
> > pwm_chip results in the right lifetime as soon as the pwmchip is living
> > long enough. This happens with the following commits.
> >=20
> > Note this is a breaking change for all pwm drivers that don't use
> > pwmchip_alloc().
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c  | 24 +++++++++---------------
> >  include/linux/pwm.h |  2 +-
> >  2 files changed, 10 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index cfcddf62ab01..3b8d41fdda1b 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -198,7 +198,7 @@ static bool pwm_ops_check(const struct pwm_chip *ch=
ip)
> > =20
> >  void *pwmchip_priv(struct pwm_chip *chip)
> >  {
> > -	return &chip[1];
> > +	return &chip->pwms[chip->npwm];
>=20
> I already disliked &chip[1] and this isn't making things any better. I
> fully realize that this is going to give us the right address, but it
> just looks wrong. Can we not do something like:
>=20
> 	return (void *)chip + sizeof(*chip);

In practise this works, but I'm not 100% confident that the compiler
might not add padding that breaks this. I don't particularly like this
function either and will think a bit more about it for v2.

> instead? That would make it more explict that we're trying to get at the
> extra data that was allocated. It also makes things a bit more robust
> and doesn't explode when somebody decides to add fields after "pwms".

Things will explode if the flexible array member isn't at the end of
struct pwm_chip no matter how you implement pwmchip_priv.

> >  }
> >  EXPORT_SYMBOL_GPL(pwmchip_priv);
> > =20
> > @@ -208,7 +208,7 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *=
parent, unsigned int npwm, si
> >  	size_t alloc_size;
> >  	unsigned int i;
> > =20
> > -	alloc_size =3D sizeof(*chip) + sizeof_priv;
> > +	alloc_size =3D sizeof(*chip) + npwm * sizeof(struct pwm_device) + siz=
eof_priv;
> > =20
> >  	chip =3D devm_kzalloc(parent, alloc_size, GFP_KERNEL);
> >  	if (!chip)
> > @@ -217,6 +217,13 @@ struct pwm_chip *devm_pwmchip_alloc(struct device =
*parent, unsigned int npwm, si
> >  	chip->dev =3D parent;
> >  	chip->npwm =3D npwm;
> > =20
> > +	for (i =3D 0; i < chip->npwm; i++) {
> > +		struct pwm_device *pwm =3D &chip->pwms[i];
> > +
> > +		pwm->chip =3D chip;
> > +		pwm->hwpwm =3D i;
> > +	}
> > +
> >  	return chip;
> >  }
> >  EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
> > @@ -243,26 +250,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct m=
odule *owner)
> > =20
> >  	chip->owner =3D owner;
> > =20
> > -	chip->pwms =3D kcalloc(chip->npwm, sizeof(*pwm), GFP_KERNEL);
>=20
> I think the structure of this patch series is a bit weird. Basically
> you're not actually improving things until the very end, at which point
> all questions get resolved.
>=20
> What this patch does isn't actually changing anything about the object
> lifetimes. chip->pwms still goes away at the same time (effectively)
> because the chip's memory allocation will be released shortly after
> pwmchip_remove() is called.
>=20
> It isn't until the very end of the series that you actually fix up the
> lifetime problem. So I read through the entire series trying to make
> sense of all this and commenting where things aren't going to work as
> expected, only to realize it isn't all going to fall in place until the
> very end.
>=20
> So I think you should either make this clearer in the commit message or
> make sure that things like pwmchip_alloc() do the right things from the
> start.

The commit log for the function introducing pwmchip_alloc() has:

	Compared to the status quo [...] it doesn't change anything
	relevant (yet).

	The intention is that after all drivers are switched to use this
	allocation function, its possible to add a struct device to struct
	pwm_chip to properly track the latter's lifetime without touching all
	drivers again.

The intention of this text is exactly what you asked for. If you have a
better wording I'm open to hear your suggestions.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cdqrwvddujfkz26f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUf6dMACgkQj4D7WH0S
/k7imAf/SrbWnJkOKKkyDTXBaMV6iIIsD3IiLnVeJ3hoiKPaMt3761198P4A3A9j
ID1NTEWEhikpYLE94wu1QFdH0ooenO1yTv2rPEHzAuWDo+6XZirggJQoRlX1iBZV
9+Tw0xds1m3tnu93+7IISjUWzOQ84oCOaQXwMyVcGSCGUnxlFGDNCjor20LGWOMO
2Hx9xQHRotwIQjFYJ+vKB9LRhLFWzp+eSQyD+LS5yEY2L15DaiFGVqbQjG18gW7O
9nY3mzrN4YZTwYOtOtqCbKVuCmfpAc+CrH4BNbux7FJiItPutgrvhcotn/NW7b9F
eXOVkqse65Bv9tXx400HNRUqZ47hIw==
=P4YM
-----END PGP SIGNATURE-----

--cdqrwvddujfkz26f--
