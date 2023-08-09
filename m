Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A5775292
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Aug 2023 08:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjHIGKU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Aug 2023 02:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjHIGKT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Aug 2023 02:10:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D5A1BE1
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 23:10:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTcOf-0004fu-7J; Wed, 09 Aug 2023 08:10:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTcOe-0029Q9-Ed; Wed, 09 Aug 2023 08:10:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTcOd-00Bb9M-GZ; Wed, 09 Aug 2023 08:10:15 +0200
Date:   Wed, 9 Aug 2023 08:10:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v1 080/101] pwm: lpss: Store parent device in driver data
Message-ID: <20230809061015.qz5r737byhzg4qyb@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-81-u.kleine-koenig@pengutronix.de>
 <ZNKAQV4VXVwkyYBV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cd2pk7mlsk5figoc"
Content-Disposition: inline
In-Reply-To: <ZNKAQV4VXVwkyYBV@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cd2pk7mlsk5figoc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Tue, Aug 08, 2023 at 08:49:53PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 08, 2023 at 07:19:10PM +0200, Uwe Kleine-K=F6nig wrote:
> > struct pwm_chip::dev is about to change. To not have to touch this
> > driver in the same commit as struct pwm_chip::dev, store a pointer to
> > the parent device in driver data.
>=20
> I'm not against this change, so
> Acked-by: Andy Shevchenko <andy@kernel.org>
> bu see some comments below.
>=20
> I think ideally pwm_chip should be an opaque to the driver
> (or something near to it). OTOH it may be I understood that
> wrong.

What would be the benefit of making it opaque? True, the drivers only
use .ops which could be added to devm_pwmchip_alloc() as a parameter to
drop the need to assign .ops, but the benefit of hiding the details
isn't clear to me.

> >  	if (state->enabled) {
> >  		if (!pwm_is_enabled(pwm)) {
> > -			pm_runtime_get_sync(chip->dev);
> > +			pm_runtime_get_sync(lpwm->parent);
> >  			ret =3D pwm_lpss_prepare_enable(lpwm, pwm, state);
> >  			if (ret)
> > -				pm_runtime_put(chip->dev);
> > +				pm_runtime_put(lpwm->parent);
> >  		} else {
> >  			ret =3D pwm_lpss_prepare_enable(lpwm, pwm, state);
> >  		}
> >  	} else if (pwm_is_enabled(pwm)) {
> >  		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
> > -		pm_runtime_put(chip->dev);
> > +		pm_runtime_put(lpwm->parent);
> >  	}
>=20
> I'm wondering why PM runtime calls can't be part of PWM core?
> We may cleanup a lot of code with it, no?

Yes, I wondered about that one during the conversion, too. One thing at
a time. (There are also a few drivers using SET_SYSTEM_SLEEP_PM_OPS /
SET_RUNTIME_PM_OPS which could be converted to moderner variants.)

> > -	pm_runtime_get_sync(chip->dev);
> > +	pm_runtime_get_sync(lpwm->parent);
>=20
>=20
> > -	pm_runtime_put(chip->dev);
> > +	pm_runtime_put(lpwm->parent);
>=20
> Ditto.
>=20
> ...
>=20
> >  struct pwm_lpss_chip {
> > +	struct device *parent;
>=20
> Have you checked IIO approach with the public and private members
> (under private the opaque pointer is meant)? Maybe something of that
> can be applied to PWM code as well, dunno.

Not sure I see what you mean. I guess it's about iio_device_alloc() and
how the size calculations are done there? I didn't do any measurements
if aligning the priv data helps. ISTR that for net the aligning is done
because some drivers do DMA to/from their priv data area. That's not the
case for PWMs. So I kept that simple. I'm open to address that, but
unless there is an obvious reason that doesn't involve extensive runtime
testing, I'd postpone that for a later time and concentrate on getting
the groundwork for my character device plans done.

Thanks for your feedback
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cd2pk7mlsk5figoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTTLcYACgkQj4D7WH0S
/k6ZtAf/e/uRtw6ImntxnMDhffJNcgLzUwujJdHYjOotn2XWXig5YrSAIKDUDc6i
8Pj7Zq9ipiB5aEawJnKj7bQQOtRxH0kJxT2lUXBkjNMkGcWoXw9VNtxz15SzCrre
jd/oTo9uElm/AYRHg8lcLMr0PyLouG14FZlDRhX5NxglSynQvfPSnstg7Gtb5A6F
Hc4J8VSN3egwwH4CQfuVqUQBd+BNw6Wq9v8wb8QY/zypvrjDBzYkW/z2WB5JiQjv
85KNAHSJstnpm7gh6p5425YvG+LEO72t/8iPFGvIvtL7O62QnwwLWvur3cwkBdSp
p2exCyruVA2Zmr8URYG5i7AKynAXiQ==
=+0HL
-----END PGP SIGNATURE-----

--cd2pk7mlsk5figoc--
