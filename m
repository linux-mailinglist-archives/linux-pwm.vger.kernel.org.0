Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2455E2D2731
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 10:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgLHJLQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 04:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgLHJLQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 04:11:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F01C061749
        for <linux-pwm@vger.kernel.org>; Tue,  8 Dec 2020 01:10:36 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmZ10-0001rh-4G; Tue, 08 Dec 2020 10:10:34 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kmZ0z-0000EF-Dg; Tue, 08 Dec 2020 10:10:33 +0100
Date:   Tue, 8 Dec 2020 10:10:33 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <X863KNo0IaekkU7q@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="acneiids2f4t3ggq"
Content-Disposition: inline
In-Reply-To: <X863KNo0IaekkU7q@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--acneiids2f4t3ggq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Tue, Dec 08, 2020 at 12:13:44AM +0100, Clemens Gruber wrote:
> On Mon, Dec 07, 2020 at 11:00:25PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Dec 07, 2020 at 08:36:27PM +0100, Clemens Gruber wrote:
> > > The hardware readout may return slightly different values than those
> > > that were set in apply due to the limited range of possible prescale =
and
> > > counter register values. If one channel is reconfigured with new duty
> > > cycle and period, the others will keep the same relative duty cycle to
> > > period ratio as they had before, even though the per-chip / global
> > > frequency changed. (The PCA9685 has only one prescaler!)
> >=20
> > This is not acceptable, if you have two PWM outputs and a consumer
> > modifies one of them the other must change. So if this chip only
> > supports a single period length of all channels, the first consumer
> > enabling a channel defines the period to be used. All later consumers
> > must live with that. (Also the first must be denied modifying the period
> > if a second consumer has enabled its PWM.)
>=20
> Good idea, but is it OK to potentially break users relying on the old
> behavior ("the last one who changes the period wins") ?

If this is already in the old code, this probably warrants a separate
fix, and yes, I consider this a severe bug. (Consider one channel
driving a motor and reconfiguring an LED modifies the motor's speed.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--acneiids2f4t3ggq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/PQwYACgkQwfwUeK3K
7AmQZAf/aRaIyHctz+EjoBIMGw6tBPqXWyDp7J3Fbgi28mFexFy+tbd0YqXHHTPD
IYWbUtDb7KSu/IC9mxpXP3SYiSlzA4n3Br2yk3f/xgRyhy6R9DCLQlHoVcx7bnqO
xdYRNyisMprl4sMINFG0ipDT0Cv6CdNrZdEgi8uidWgY7Zzje2hx2In2H3GFlT89
cZ2S6DoVRNdE8XU2FMCdjZ9qvaw12w42oPRcH0oEao1ycSoGQ9dSGBKDi6iUzijX
gtA4gzkQpxJ1LUlVgkG5cy+zENn4bXZD8XHxdsoWLfNw0CkPBXQFYkpHtBfMc/qZ
JkA1aV1ij3kmuVxv4WSn9ui4L6RdpA==
=lGAt
-----END PGP SIGNATURE-----

--acneiids2f4t3ggq--
