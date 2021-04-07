Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAFD35636B
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 07:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbhDGFrK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 01:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhDGFrK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 01:47:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2205EC06174A
        for <linux-pwm@vger.kernel.org>; Tue,  6 Apr 2021 22:47:01 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU11n-0002gQ-Aj; Wed, 07 Apr 2021 07:46:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU11m-0001re-OB; Wed, 07 Apr 2021 07:46:58 +0200
Date:   Wed, 7 Apr 2021 07:46:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="25q5ivcude7rgd7v"
Content-Disposition: inline
In-Reply-To: <20210406164140.81423-5-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--25q5ivcude7rgd7v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 06:41:37PM +0200, Clemens Gruber wrote:
> If the flag PWM_STAGGERING_ALLOWED is set on a channel, the PWM driver
> may (if supported by the HW) delay the ON time of the channel relative
> to the channel number.
> This does not alter the duty cycle ratio and is only relevant for PWM
> chips with less prescalers than channels, which would otherwise assert
> multiple or even all enabled channels at the same time.
>=20
> If this feature is supported by the driver and the flag is set on
> multiple channels, their ON times are spread out to improve EMI and
> reduce current spikes.

As said in reply to patch 4/8 already: I don't like this idea and
think this should be made explicit using a new offset member in struct
pwm_state instead. That's because I think that the wave form a PWM
generates should be (completely) defined by the consumer and not by a
mix between consumer and device tree. Also the consumer has no (sane)
way to determine if staggering is in use or not.

One side effect (at least for the pca9685) is that when programming a
new duty cycle it takes a bit longer than without staggering until the
new setting is active.=20

Another objection I have is that we already have some technical debt
because there are already two different types of drivers (.apply vs
=2Econfig+.set_polarity+.enable+.disable) and I would like to unify this
first before introducing new stuff.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--25q5ivcude7rgd7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBtR08ACgkQwfwUeK3K
7AnH1gf/cdig397tz+5gNgX38+1Ifc1mHXJ0Rh3cWxKQmZ7xbFajyrhcp+95qXcE
xZfAkeQpyVzycfGUAuioEHz3ufRTMYzl+MRBnimcgVeZR/6Fid3oV4QXT4gLNWtl
D31osUgPOII4IYcNiOaSndK4v/5jcLr1OpzRimBXqwZtitu4Pjzj5GOUmxQAYKHc
8PT6N9HswlSWLx4LJFp4preCsPGTLBiO/NPUxK9hcUtu2DLr625A30RUXOr6ke5Q
zOOSqZWRdgEg7Qt5CI83lB7/cY2TiNHHb9bvwq0h5w7ziwXhkklQ9QkaJP/zZu9L
vwS4AhdLhkxH6rvt0ppFyXOSWlz90Q==
=3pkc
-----END PGP SIGNATURE-----

--25q5ivcude7rgd7v--
