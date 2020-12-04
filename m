Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39B32CECF6
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 12:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgLDLWF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 06:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgLDLWE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 06:22:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7D1C0613D1
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 03:21:24 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kl99I-0007bU-Qi; Fri, 04 Dec 2020 12:21:16 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kl99H-0004P7-Nn; Fri, 04 Dec 2020 12:21:15 +0100
Date:   Fri, 4 Dec 2020 12:21:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sean@mess.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201204112115.wopx5p5elgte7gad@pengutronix.de>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ipxeiknnoimo3nk7"
Content-Disposition: inline
In-Reply-To: <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ipxeiknnoimo3nk7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lino,

On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> On 29.11.20 at 19:10, Uwe Kleine-K=F6nig wrote:
> > You're storing an unsigned long long (i.e. 64 bits) in an u32. If
> > you are sure that this won't discard relevant bits, please explain
> > this in a comment for the cursory reader.
>=20
> What about an extra check then to make sure that the period has not been =
truncated,
> e.g:
>=20
> 	value =3D DIV_ROUND_CLOSEST_ULL(state->period, scaler);
>=20
> 	/* dont accept a period that is too small or has been truncated */
> 	if ((value < PERIOD_MIN) ||
> 	    (value !=3D DIV_ROUND_CLOSEST_ULL(state->period, scaler)))
> 		return -EINVAL;

I'd make value an unsigned long long and check for > 0xffffffff instead
of repeating the (expensive) division. (Hmm, maybe the compiler is smart
enough to not actually repeat it, but still.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ipxeiknnoimo3nk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/KG6gACgkQwfwUeK3K
7AmG2Qf/amv7olBkW+obnQcmNF0IyH6SlXaSsCwdoDpgoecCz0P+iIkdbOTfCuh2
W/5fkG0dPGafcmGYsCxKC4W//WpXFoThJIqrh119+JkM3apOCx6uj19Dp4zq9z4s
IvCGrNnTpDATXPbjohCyFAqGytQYnbpCzH8KY8Qx7Ay66v6hK55JVJRBM8gPi3Ck
GRZjWcGg0fPenaGUF7X+fX245CmvTs3MregzKqpkdDvs2J8TVOcHJ0SNgm5Pizjd
AgWaT12h3a319ZEeuHf07Rv3dtH6jHfjNO6bMAaPfY3G0V1q55nHPNuaXqQ1I+j3
SAASbhQiB44PG3PJQVQOIlVR4kbTUA==
=EGSk
-----END PGP SIGNATURE-----

--ipxeiknnoimo3nk7--
