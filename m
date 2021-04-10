Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82635ADC3
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 15:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhDJNqW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 10 Apr 2021 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhDJNqV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Apr 2021 09:46:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ECCC06138A
        for <linux-pwm@vger.kernel.org>; Sat, 10 Apr 2021 06:46:05 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVDw1-00076G-SB; Sat, 10 Apr 2021 15:46:01 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVDw1-0006v6-8d; Sat, 10 Apr 2021 15:46:01 +0200
Date:   Sat, 10 Apr 2021 15:46:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/3] pwm: lpss: Don't modify HW state in .remove callback
Message-ID: <20210410134601.ccqhuor3gd6pm2fw@pengutronix.de>
References: <20210407080155.55004-1-u.kleine-koenig@pengutronix.de>
 <YHBU5MqK+vjTGwio@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="adntn6f4s3n5kikk"
Content-Disposition: inline
In-Reply-To: <YHBU5MqK+vjTGwio@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--adntn6f4s3n5kikk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 09, 2021 at 03:21:40PM +0200, Thierry Reding wrote:
> On Wed, Apr 07, 2021 at 10:01:53AM +0200, Uwe Kleine-K=F6nig wrote:
> > A consumer is expected to disable a PWM before calling pwm_put(). And if
> > they didn't there is hopefully a good reason (or the consumer needs
> > fixing). Also if disabling an enabled PWM was the right thing to do,
> > this should better be done in the framework instead of in each low level
> > driver.
> >=20
> > So drop the hardware modification from the .remove() callback.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-lpss.c | 6 ------
> >  1 file changed, 6 deletions(-)
>=20
> Applied, thanks.

Great, but you didn't push yet. Is this still going through your own CI,
or did you forget to push?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--adntn6f4s3n5kikk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBxrBYACgkQwfwUeK3K
7An/igf9Hlw14/m6mMrEp2WbVed+nSWkbhoCYzldu1scg+H+9Ma+O+guZjVlkKxw
4B9L6UocDevQNAAIl/mxbVQ1pvHs6E+Y/r+LXP3r6tsZedAe+GCAZOBdWllDUDT9
3lnrA0XddZvUUpieOBiOlEVUV06qUsT3PX1MQTyWWaGS34hjB1j6cMQ7G0uj/kYv
ofluwVpPnhg/FwJTLY/gPbT6qMk+YtPQHvCk0/N28HlXHqV2b4+wN7Ic3TTU61fm
oyoQoriqgETaX2sqGRNE6D9Xf79Nt16BWh6BdCO6YJUSsi+zmMaPuOjpljkK/nPS
2s2/TM1CYSBWNbLW9fC8CmVysEBoUg==
=84z5
-----END PGP SIGNATURE-----

--adntn6f4s3n5kikk--
