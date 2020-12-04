Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144412CF66E
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 22:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgLDV4Q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 16:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgLDV4P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 16:56:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D466C0613D1
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 13:55:35 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klJ32-0005ls-2d; Fri, 04 Dec 2020 22:55:28 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klJ2z-0007sJ-H3; Fri, 04 Dec 2020 22:55:25 +0100
Date:   Fri, 4 Dec 2020 22:55:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, thierry.reding@gmail.com,
        lee.jones@linaro.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201204215525.uvjxlebth457aoj5@pengutronix.de>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204112115.wopx5p5elgte7gad@pengutronix.de>
 <20201204114036.GB6547@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="juipum4h3khpb5mp"
Content-Disposition: inline
In-Reply-To: <20201204114036.GB6547@gofer.mess.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--juipum4h3khpb5mp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Fri, Dec 04, 2020 at 11:40:36AM +0000, Sean Young wrote:
> On Fri, Dec 04, 2020 at 12:21:15PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> > > On 29.11.20 at 19:10, Uwe Kleine-K=F6nig wrote:
> > > > You're storing an unsigned long long (i.e. 64 bits) in an u32. If
> > > > you are sure that this won't discard relevant bits, please explain
> > > > this in a comment for the cursory reader.
> > >=20
> > > What about an extra check then to make sure that the period has not b=
een truncated,
> > > e.g:
> > >=20
> > > 	value =3D DIV_ROUND_CLOSEST_ULL(state->period, scaler);
> > >=20
> > > 	/* dont accept a period that is too small or has been truncated */
> > > 	if ((value < PERIOD_MIN) ||
> > > 	    (value !=3D DIV_ROUND_CLOSEST_ULL(state->period, scaler)))
> > > 		return -EINVAL;
> >=20
> > I'd make value an unsigned long long and check for > 0xffffffff instead
> > of repeating the (expensive) division. (Hmm, maybe the compiler is smart
> > enough to not actually repeat it, but still.)
>=20
> I wonder where you got that idea from.

I don't know how to honestly answer your question.
Which idea do you mean? That divisions are expensive? Or that compilers
might be smart? And do you consider it a good idea? Or do you disagree?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--juipum4h3khpb5mp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/KsEoACgkQwfwUeK3K
7Ann8Af6An6pTuGI9oEii/TBR5WoX2fxdM3bseKav5aJAmIRLbG0lWnlnzc0mkpI
gO3ZwQrM2pB/RVmQjyp97nDSUVR9UlmUm7Pz/wKOEdBlnBxECOBe/1QIDMbqVPBw
ASax5IwD+wgid7GSZ4qt1pDMiUffE6Mg4N2vgy3HEeG1bGLfeKDYLdnO2of9U8MD
MOSsmni2Q4RGnAuypa5rz6DCgKQfK3klqprtjho27rnoqScjEhM9Haz19w4vACy3
yfasJHf79npmYCZeetOjfFz4nBFbmENUSK0zEHUNC0BYZuTTLP8k8XNhbh69SZgL
gkIyIv/lYAyr9+n2kkal1tEUcks55A==
=Ve9/
-----END PGP SIGNATURE-----

--juipum4h3khpb5mp--
