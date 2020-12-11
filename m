Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367022D7327
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 10:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393826AbgLKJyH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 04:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404842AbgLKJxx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Dec 2020 04:53:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47EDC0613CF
        for <linux-pwm@vger.kernel.org>; Fri, 11 Dec 2020 01:53:13 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knf6o-00012u-QY; Fri, 11 Dec 2020 10:53:06 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knf6n-0000Xa-9i; Fri, 11 Dec 2020 10:53:05 +0100
Date:   Fri, 11 Dec 2020 10:53:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sean@mess.org, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201211095305.vsin3mkrytylqm47@pengutronix.de>
References: <1607464905-16630-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201210114330.6pgtome3aq3hj55t@pengutronix.de>
 <trinity-8db15ca3-e42e-497d-8718-b4928fa76a3c-1607678915350@3c-app-gmx-bs43>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yawg4bsslfkpxhbx"
Content-Disposition: inline
In-Reply-To: <trinity-8db15ca3-e42e-497d-8718-b4928fa76a3c-1607678915350@3c-app-gmx-bs43>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yawg4bsslfkpxhbx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 10:28:35AM +0100, Lino Sanfilippo wrote:
> Hi Uwe,
>=20
> > Gesendet: Donnerstag, 10. Dezember 2020 um 12:43 Uhr
> > Von: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> > An: "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
> > Cc: thierry.reding@gmail.com, lee.jones@linaro.org, nsaenzjulienne@suse=
=2Ede, f.fainelli@gmail.com, rjui@broadcom.com, sean@mess.org, sbranden@bro=
adcom.com, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org=
, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.or=
g, linux-kernel@vger.kernel.org
> > Betreff: Re: [PATCH v3] pwm: bcm2835: Support apply function for atomic=
 configuration
>=20
> >=20
> > Side note: I'm a bit surprised about the output of
> >=20
> > 	b4 diff 1607464905-16630-1-git-send-email-LinoSanfilippo@gmx.de
> >=20
> > This is probably due to the fact that compared to v3 you also rebased.
> > Still the diff is quite big.
>=20
> You are right, I made a rebase before I created the last patch, sorry for=
 the confusion this caused.
> Anyway, thanks for the review(s)!

You did everything good enough. (To further improve, you could use
git-format-patch's --base option and mention a rebase in the series'
changelog; note this is quite high level critic.)

This was more me wondering the output is not easier to use. (And note I
also showed the wrong commandline, but that doesn't resolve the issue.
The right command is:

	b4 diff 1607546905-20549-1-git-send-email-LinoSanfilippo@gmx.de

=2E)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yawg4bsslfkpxhbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/TQX0ACgkQwfwUeK3K
7Aka/Af8CjQ2WfsAEJfbFBaqoTFA4yvsqB8cByYbEadvOmSj1RJM8akVF57xwDeo
IszM8P8uATRyClekzicdewDrd91KmqCfweRjawMY6NiSU1h0ckrP00+PPAkTC9H5
WhV2BtRbQxqgbX4s+BQVDeK+djYvn16QW78Ulm4YGz72N8+G+ISPGqEMhpaa05DT
LZywtiuhVEf3DhmD+9xgvSvQ7uZ0GAm2sibmZid5Img5/G1uw51jmjcThsOyNneu
15U2VRfcNN6GmX2HYMVYgZXjcXSLqVcXvYf0UotCjMdEPGCc/7lV/dT6//BE1QXR
kBcpBNLdunxUM5hcfotGYvstbKWsGA==
=rHZV
-----END PGP SIGNATURE-----

--yawg4bsslfkpxhbx--
