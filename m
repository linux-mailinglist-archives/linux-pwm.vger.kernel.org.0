Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5A35A877
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 23:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhDIVsK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhDIVsJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 17:48:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0BC061762
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 14:47:56 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUyyo-0004DL-Dt; Fri, 09 Apr 2021 23:47:54 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUyyn-0002sl-Pc; Fri, 09 Apr 2021 23:47:53 +0200
Date:   Fri, 9 Apr 2021 23:47:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/3] pwm: lpss: Simplify using devm_pwmchip_add
Message-ID: <20210409214753.bh2ymarb74au55rh@pengutronix.de>
References: <20210407080155.55004-1-u.kleine-koenig@pengutronix.de>
 <20210407080155.55004-3-u.kleine-koenig@pengutronix.de>
 <YHBWZw8haF0SU1Cc@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3oyj46wajyrduegu"
Content-Disposition: inline
In-Reply-To: <YHBWZw8haF0SU1Cc@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3oyj46wajyrduegu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 09, 2021 at 03:28:07PM +0200, Thierry Reding wrote:
> On Wed, Apr 07, 2021 at 10:01:55AM +0200, Uwe Kleine-K=F6nig wrote:
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-lpss-pci.c      | 4 ----
> >  drivers/pwm/pwm-lpss-platform.c | 4 +---
> >  drivers/pwm/pwm-lpss.c          | 8 +-------
> >  drivers/pwm/pwm-lpss.h          | 1 -
> >  4 files changed, 2 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> > index cf749ea0de9f..c893ec3d2fb4 100644
> > --- a/drivers/pwm/pwm-lpss-pci.c
> > +++ b/drivers/pwm/pwm-lpss-pci.c
> > @@ -69,12 +69,8 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
> > =20
> >  static void pwm_lpss_remove_pci(struct pci_dev *pdev)
> >  {
> > -	struct pwm_lpss_chip *lpwm =3D pci_get_drvdata(pdev);
> > -
> >  	pm_runtime_forbid(&pdev->dev);
> >  	pm_runtime_get_sync(&pdev->dev);
> > -
> > -	pwm_lpss_remove(lpwm);
> >  }
>=20
> Isn't this going to defeat your quest to make all drivers release
> resources only after pwmchip_remove() was called? Before this patch
> you'd be able to fix that by moving pwm_lpss_remove() before the runtime
> PM stuff, but after using devm_pwmchip_add() the pwmchip_remove() will
> always get called after the driver's ->remove() returns.
>=20
> Granted, in this case it's perhaps not the best example because this
> driver is actually grabbing a runtime PM reference, so that should be
> safe. However, I'm thinking in general device-managed PWM chip addition
> and removal becomes less useful because of the ordering requirements.

The conversion to devm_pwmchip_add is obviously only correct if all
other resources needed by the PWM are also devm managed (ab8500,
bcm-kona). Once I got the clk maintainers to apply
https://lore.kernel.org/r/20210330181755.204339-1-u.kleine-koenig@pengutron=
ix.de
this should be possible for some more drivers. (pwm-atmel, atmel_hlcdc,
bcm2835, bcm-iproc, berlin, brcmstb (stopped checking after b*))

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3oyj46wajyrduegu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBwy4YACgkQwfwUeK3K
7AlX1AgAjK7/tl/myVXNsCnZ3UECUvnY/70b36GCL3sRJYwAW76GNUnvg6qOklu/
Xvy7lcpN1+hwtcX1MxbbUnyHU3V7AhPe7HgRJKCQFGZoZ8UHTCqUSThv5oEjBb2N
N/Es5G6B/V9MhKFz4w+IUgKZIN0xWxKPhKM1rYboCXB0PofCkcTw1sohP7MnXlGa
Ly8e5Ta6l68vTT3pkK1XcXhAAb+jCns+++/DMx4vnIjTReAFABBHYR3apXzdgJ3G
ZrTkGTr2JLFKl0yXO3J7kaRqnPcDD1evMlYDIZn2XGr1J37i0bzqRLU4anJxDMg8
avwecPGiqcEtUxeAsN4yB1o1ZkZOfg==
=/rbY
-----END PGP SIGNATURE-----

--3oyj46wajyrduegu--
