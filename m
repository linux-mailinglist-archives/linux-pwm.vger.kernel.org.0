Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7EC76EE39
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Aug 2023 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbjHCPfN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Aug 2023 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbjHCPfH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Aug 2023 11:35:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8DC3C3C
        for <linux-pwm@vger.kernel.org>; Thu,  3 Aug 2023 08:35:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRaLn-0001r8-7n; Thu, 03 Aug 2023 17:34:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRaLm-000sJV-5k; Thu, 03 Aug 2023 17:34:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qRaLl-00AAqD-GW; Thu, 03 Aug 2023 17:34:53 +0200
Date:   Thu, 3 Aug 2023 17:34:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linux-pwm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Wolfram Sang <wsa@kernel.org>, linux-gpio@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 18/18] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20230803153450.fbvqd35memctq6hr@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-19-u.kleine-koenig@pengutronix.de>
 <CAMRc=MfGWvAGYAh8q7mOenGDMpKS3q7UK7-Yxw5bn1avhoQ-UQ@mail.gmail.com>
 <20230729213712.mkfqgk6cage6yqsd@pengutronix.de>
 <CAMRc=MeSg7Emhv4VKdsPLfjTrLtsN8M0uapnDFtYGfbJ8UjxJA@mail.gmail.com>
 <20230803094212.g3il26hqbboppiz4@pengutronix.de>
 <ZMuUzChRuEckOHIE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fx5tsoitclnrs7ab"
Content-Disposition: inline
In-Reply-To: <ZMuUzChRuEckOHIE@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fx5tsoitclnrs7ab
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Thu, Aug 03, 2023 at 02:51:40PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 03, 2023 at 11:42:12AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Sun, Jul 30, 2023 at 12:07:33PM +0200, Bartosz Golaszewski wrote:
>=20
> ...
>=20
> >  - the locking scheme in gpiod_request_commit() looks strange. gpio_lock
> >    is released and retaken possibly several times. I wonder what it
> >    actually protects there. Maybe doing
> >=20
> > 	diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > 	index edab00c9cb3c..496b1cebba58 100644
> > 	--- a/drivers/gpio/gpiolib.c
> > 	+++ b/drivers/gpio/gpiolib.c
> > 	@@ -2064,13 +2064,11 @@ static int gpiod_request_commit(struct gpio_de=
sc *desc, const char *label)
> > 				goto out_free_unlock;
> > 			}
> > 		}
> > 	+	spin_unlock_irqrestore(&gpio_lock, flags);
> > 		if (gc->get_direction) {
> > 			/* gc->get_direction may sleep */
> > 	-		spin_unlock_irqrestore(&gpio_lock, flags);
> > 			gpiod_get_direction(desc);
> > 	-		spin_lock_irqsave(&gpio_lock, flags);
> > 		}
> > 	-	spin_unlock_irqrestore(&gpio_lock, flags);
> > 		return 0;
> > 	=20
> > 	 out_free_unlock:
> >=20
> >    simplifies the code and given that gpiod_get_direction() rechecks
> >    gc->get_direction unlocked I don't think we'd loose anything here.
>=20
> Wouldn't this break sleeping bus accesses (I2C gpio expanders, etc)?

This question is too short for me to understand what you think. The
only difference my patch does is that gc->get_direction is checked
without holding the lock and a lock+unlock pair. I don't see how this is
relevant to sleeping bus accesses.

	lock()
	...
	if (A) {
		unlock()
		something()
		lock()
	}
	unlock()

is nearly identical to:

	lock()
	...
	unlock()
	if (A) {
		something()
	}
	lock()
	unlock()

which in turn is nearly identical to

	lock()
	...
	unlock()
	if (A) {
		something()
	}

=2E But I might well miss something, as the "nearly"s above sometimes are
relevant.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fx5tsoitclnrs7ab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTLyRkACgkQj4D7WH0S
/k4DMQf+Pawujhnc3ZzBYZkiOXP11BGxTqGr1wgg+IovF89b6ga20rTcMBvrMSc6
UJ2vhOyKTyMNJLUdpy5P0W6n6gJ6uhxQAMkQFH5hi+gBaYBL78UlRZ16w8z9Pp1v
T/GPLg7XPi7U+XaLhY+M3JSZlSHJRd+oAPHrIZbnFk8u21rOQem7GsyRdDUHBVf5
LS10rMEBHRE0YXgRyjMh93H5TF1+evQ7rfYZIZ23/2N8qzgv/tfCBdADo0OC7ubt
rV+l6qqip8epP/i9cjpWuwAXX+FmoAZ0ofrp6LaHQ+zKnJVK6OD8rNKR/hVmsNyQ
eOkRwFhgoYAO0FkpbPnvq2ZMjqds2Q==
=p10U
-----END PGP SIGNATURE-----

--fx5tsoitclnrs7ab--
