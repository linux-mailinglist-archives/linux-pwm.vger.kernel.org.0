Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8102CECD5
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 12:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgLDLOQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 06:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgLDLOQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 06:14:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E149C0613D1
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 03:13:35 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kl91l-0006DV-2e; Fri, 04 Dec 2020 12:13:29 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kl91i-00046Q-HT; Fri, 04 Dec 2020 12:13:26 +0100
Date:   Fri, 4 Dec 2020 12:13:26 +0100
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
Message-ID: <20201204111326.qjux6k2472dmukot@pengutronix.de>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gm4bedrwxq43tqli"
Content-Disposition: inline
In-Reply-To: <20201204084417.GA2154@gofer.mess.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gm4bedrwxq43tqli
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 04, 2020 at 08:44:17AM +0000, Sean Young wrote:
> On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> > > You're storing an unsigned long long (i.e. 64 bits) in an u32. If
> > > you are sure that this won't discard relevant bits, please explain
> > > this in a comment for the cursory reader.
> >=20
> > What about an extra check then to make sure that the period has not bee=
n truncated,
> > e.g:
> >=20
> > 	value =3D DIV_ROUND_CLOSEST_ULL(state->period, scaler);
> >=20
> > 	/* dont accept a period that is too small or has been truncated */
> > 	if ((value < PERIOD_MIN) ||
> > 	    (value !=3D DIV_ROUND_CLOSEST_ULL(state->period, scaler)))
> > 		return -EINVAL;
>=20
> Rather than doing another 64 bit division which is expensive (esp on 32 b=
it
> kernels), you could assign to u64 and check:
>=20
> 	if (value < PERIOD || value > U32_MAX)
> 		return -EINVAL;

Given that value is a u32, value > U32_MAX will never trigger.

Maybe checking period before doing the division is more sensible.

> > > Also note that round_closed is probably wrong, as .apply() is
> > > supposed to round down the period to the next achievable period. (But
> > > fixing this has to do done in a separate patch.)
> >=20
> > According to commit 11fc4edc4 rounding to the closest integer has been =
introduced
> > to improve precision in case that the pwm controller is used by the pwm=
-ir-tx driver.
> > I dont know how strong the requirement is to round down the period in a=
pply(), but I
> > can imagine that this may be a good reason to deviate from this rule.
> > (CCing Sean Young who introduced DIV_ROUND_CLOSEST)
>=20
> There was a problem where the carrier is incorrect for some IR hardware
> which uses a carrier of 455kHz. With periods that small, rounding errors
> do really matter and rounding down might cause problems.
>=20
> A policy of rounding down the carrier is not the right thing to do
> for pwm-ir-tx, and such a change will probably break pwm-ir-tx in some
> edge cases.

IMO it's not an option to say: pwm-driver A is used for IR, so A's
=2Eapply uses round-nearest and pwm-driver B is used for $somethingelse,
so B's .apply uses round-down. To be a sensible API pwm_apply_state
should have a fixed behaviour. I consider round-down the sensible
choice (because it is easier to implmement the other options with this)
and for consumers like the IR stuff we need to provide some more
functions to allow it selecting a better suited state. Something like:

	pwm_round_state_nearest(pwm, { .period =3D 2198, .. }, &state)

which queries the hardwares capabilities and then assigns state.period =3D
2200 instead of 2100.

Where can I find the affected (consumer) driver?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gm4bedrwxq43tqli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/KGdMACgkQwfwUeK3K
7AmNDwf+MoowMGzcyU/5yAwSkPGkjJDBASacRhu95RcC7ey4zPTQK6pl9kOCZqIS
fFAekyFO6neCy2EDeMKwDmVcZS0rZRS/HskJhhAcop3LbsT3Xg2kcK6zV5Pabahn
KLp0drec7iLTGS9blagebWAqTsLnu3S/UNUA18vHviIZ+f7qpuxdzCri17bi+j8Z
y+muPtgemDF8Ip0edZMoV4pABJ3RP1bJR+CF3hIes8d62uuQnydHDsFBAXNAc6Dm
vEWErWr4Q7HQUmsrMKcXJARIF9L+LRclOXu690ao7TVAz5NgJSKU6aE9vk/N8/Xv
DGFmvEXzlOeEXpFEjWHADtDXH5yWLg==
=OBqj
-----END PGP SIGNATURE-----

--gm4bedrwxq43tqli--
