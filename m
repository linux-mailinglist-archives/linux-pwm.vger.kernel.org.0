Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096DA2F392D
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jan 2021 19:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392644AbhALSsg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jan 2021 13:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392633AbhALSsg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jan 2021 13:48:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC655C061575
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jan 2021 10:47:55 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzOhs-0002Bf-Ub; Tue, 12 Jan 2021 19:47:52 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzOhr-00004s-NF; Tue, 12 Jan 2021 19:47:51 +0100
Date:   Tue, 12 Jan 2021 19:47:48 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: bcm2835: Improve period and duty cycle
 calculation
Message-ID: <20210112184748.rl6fsukpaa7erdmq@pengutronix.de>
References: <20201222221319.2101107-1-u.kleine-koenig@pengutronix.de>
 <ab77b694-38c7-7f09-d1c0-b8a680ab84a4@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ak7anwnjgvaov4n"
Content-Disposition: inline
In-Reply-To: <ab77b694-38c7-7f09-d1c0-b8a680ab84a4@gmx.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2ak7anwnjgvaov4n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lino,

On Thu, Dec 31, 2020 at 08:30:12PM +0100, Lino Sanfilippo wrote:
> just some nitpicks (maybe only worth fixing if there will be a v3 for oth=
er reasons):
>=20
> On 22.12.20 at 23:13, Uwe Kleine-K=F6nig wrote:
>=20
> > +	/*
> > +	 * period_cycles must be a 32 bit value, so period * rate / NSEC_PER_=
SEC
> > +	 * must be <=3D U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
> > +	 * multiplication period * rate doesn't overflow.
> > +	 */
> > +	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PE=
R_SEC / 2, rate) - 1;
>=20
> For someone looking at the formula it might be helpful to also have an ex=
planation for the added
> term "+ NSEC_PER_SEC / 2" in the comment. This line also exeeds the 80 ch=
ars limit...

Yeah, the 80 char limit isn't that strict any more and (IMHO) adding a
line break anywhere in the formula hurts readibility, so I accepted
the long line as the lesser evil.

Regarding the + NSEC_PER_SEC / 2: Is it clear to you that it is right?
If so that would be great as confirmation that I got the maths right.

Adding a comment is a good idea, what about:

+	/*
+	 * period_cycles must be a 32 bit value, so period * rate / NSEC_PER_SEC
+	 * must be <=3D U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
+	 * multiplication period * rate doesn't overflow.
+	 * To calculate the maximal possible period that guarantees the
+	 * above inequality:
+	 *
+	 *     round(period * rate / NSEC_PER_SEC) <=3D U32_MAX
+	 * <=3D> period * rate / NSEC_PER_SEC < U32_MAX + 0.5
+	 * <=3D> period * rate < (U32_MAX + 0.5) * NSEC_PER_SEC
	 * <=3D> period < ((U32_MAX + 0.5) * NSEC_PER_SEC) / rate
	 * <=3D> period < ((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate
	 * <=3D> period <=3D ceil((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate=
) - 1
+	 */

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2ak7anwnjgvaov4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/97tEACgkQwfwUeK3K
7Ane5gf7BLMAv9vDjFK99poW9OnQsucnUx1vX0st6YSgd6FRF4noJ7Ro00w+58+X
lpmoo6MNNgM5TR4ZF6AuA5dnSA+HCquzwY877FV/eqr2BUl+xytVCaMEuE48dSW2
cj/DQ2WE+B5aGpyRmM0aKixPN3MvIzvzSq6pN0xp323/SExqfkr+k562nr2aY/Qp
5ZuRZYQMNompBFfiHL+vGctf08ptN9LdNwdpqlPMJEVmZQZ6TOkriGl4gR2T7eki
Gyr63T9coA4LOc6uqCgyGCvtCNk6DhEQsNAVMuD4RtW3+CudvkyQqy4QLHh3zD+O
uKMtV3mghj85grH3VmSSZIETtVcAKA==
=cg7O
-----END PGP SIGNATURE-----

--2ak7anwnjgvaov4n--
