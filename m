Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95316358B79
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Apr 2021 19:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhDHRgy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Apr 2021 13:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhDHRgy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Apr 2021 13:36:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB24C061760
        for <linux-pwm@vger.kernel.org>; Thu,  8 Apr 2021 10:36:42 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUYa7-0005zi-0m; Thu, 08 Apr 2021 19:36:39 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUYa6-0001dJ-5j; Thu, 08 Apr 2021 19:36:38 +0200
Date:   Thu, 8 Apr 2021 19:36:37 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <20210408173637.w26njwystfuyrgan@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
 <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
 <YG4UNoBCQJkEEfwi@workstation.tuxnet>
 <20210407213403.h6n6l2t7vqoalceu@pengutronix.de>
 <YG78IHIMGtl8Pokp@orome.fritz.box>
 <YG8miEOZXsH0NTcA@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lp7gtrg7jitfyjpi"
Content-Disposition: inline
In-Reply-To: <YG8miEOZXsH0NTcA@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lp7gtrg7jitfyjpi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 05:51:36PM +0200, Clemens Gruber wrote:
> On Thu, Apr 08, 2021 at 02:50:40PM +0200, Thierry Reding wrote:
> > Yes, I think that's basically what this is saying. I think we're perhaps
> > getting hung up on the terminology here. PWM_STAGGERING_ALLOWED gives
> > the impression that we're dealing with some provider-specific feature,
> > whereas what we really want to express is that the PWM doesn't care
> > exactly when the active cycle starts and based on that a provider that
> > can support it may optimize the EMI behavior.
> >=20
> > Maybe we can find a better name for this? Ultimately what this means is
> > that the consumer is primarily interested in the power output of the PWM
> > rather than the exact shape of the signal. So perhaps something like
> > PWM_USAGE_POWER would be more appropriate.
>=20
> Yes, although it would then no longer be obvious that this feature leads
> to improved EMI behavior, as long as we mention that in the docs, I
> think it's a good idea
>=20
> Maybe document it as follows?
> PWM_USAGE_POWER - Allow the driver to delay the start of the cycle
> for EMI improvements, as long as the power output stays the same

I don't like both names, because for someone who is only halfway into
PWM stuff it is not understandable. Maybe ALLOW_PHASE_SHIFT?
When a consumer is only interested in the power output than

	.period =3D 20
	.duty_cycle =3D 5

would also be an allowed response for the request

	.period =3D 200
	.duty_cycle =3D 50

and this is not what is in the focus here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lp7gtrg7jitfyjpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBvPyEACgkQwfwUeK3K
7Amyxwf/eaL3FxWvGWQHZWUSKXVy2VMYq4wDy9TcDkiWclNcfgI5tEmYe9ERzL7K
1EpCi8RMTK1g9fZBOy47fH7s3apm+fs3WaawiuMcQn1KXvD/Amq/zBh5K9IKpev2
EGlef+Msxzx8OZjaAjU+Ywxmd/9aGwOdvbFcvLxGPV4/y8/w16XQcuRVRbEeNQrM
ZLVaBpVHfaOs8UcWllrNZjIv3PBhx3yF6x04XzoG+wk8y+mH8L6f4AsvMMyg+nkH
8ysXMNazz5+OufTTTnq9Zf9Dka6r+4G1CsXXJzJdEfv9GNgTy9SOpBpwfCSlgLpR
AqyuPekXjdjSY6UrHkJER7tqGY+Czw==
=AqmW
-----END PGP SIGNATURE-----

--lp7gtrg7jitfyjpi--
