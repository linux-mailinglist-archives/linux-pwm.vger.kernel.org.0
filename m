Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB573576E1
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 23:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhDGVeT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 17:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhDGVeT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 17:34:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1651EC061760
        for <linux-pwm@vger.kernel.org>; Wed,  7 Apr 2021 14:34:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUFoK-0006ld-IO; Wed, 07 Apr 2021 23:34:04 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUFoJ-0001pJ-Tp; Wed, 07 Apr 2021 23:34:03 +0200
Date:   Wed, 7 Apr 2021 23:34:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <20210407213403.h6n6l2t7vqoalceu@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
 <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
 <YG4UNoBCQJkEEfwi@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3rqqlwp4d36foled"
Content-Disposition: inline
In-Reply-To: <YG4UNoBCQJkEEfwi@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3rqqlwp4d36foled
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 10:21:10PM +0200, Clemens Gruber wrote:
> On Wed, Apr 07, 2021 at 07:46:58AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 06, 2021 at 06:41:37PM +0200, Clemens Gruber wrote:
> > > If the flag PWM_STAGGERING_ALLOWED is set on a channel, the PWM driver
> > > may (if supported by the HW) delay the ON time of the channel relative
> > > to the channel number.
> > > This does not alter the duty cycle ratio and is only relevant for PWM
> > > chips with less prescalers than channels, which would otherwise assert
> > > multiple or even all enabled channels at the same time.
> > >=20
> > > If this feature is supported by the driver and the flag is set on
> > > multiple channels, their ON times are spread out to improve EMI and
> > > reduce current spikes.
> >=20
> > As said in reply to patch 4/8 already: I don't like this idea and
> > think this should be made explicit using a new offset member in struct
> > pwm_state instead. That's because I think that the wave form a PWM
> > generates should be (completely) defined by the consumer and not by a
> > mix between consumer and device tree. Also the consumer has no (sane)
> > way to determine if staggering is in use or not.
>=20
> I don't think offsets are ideal for this feature: It makes it more
> cumbersome for the user, because he has to allocate the offsets
> himself instead of a simple on/off switch.
> The envisioned usecase is: "I want better EMI behavior and don't care
> about the individual channels no longer being asserted at the exact same
> time".

The formal thing is: "I want better EMI behavior and don't care if
periods start with the active phase, it might be anywhere, even over a
period boundary." Being asserted at the exact same time is just a detail
for the pca9685.
=20
> > One side effect (at least for the pca9685) is that when programming a
> > new duty cycle it takes a bit longer than without staggering until the
> > new setting is active.=20
>=20
> Yes, but it can be turned off if this is a problem, now even per-PWM.

Yes and that is a good thing. (BTW: I'd call it per-PWM-consumer, but
details.)

> > Another objection I have is that we already have some technical debt
> > because there are already two different types of drivers (.apply vs
> > .config+.set_polarity+.enable+.disable) and I would like to unify this
> > first before introducing new stuff.
>=20
> But there is already PWM_POLARITY_INVERTED, which can be set in the DT.
> I am only adding another flag.

I understand your reasoning, and similar to "This diplay backlight needs
an inverted PWM (as a low duty-cycle results in a high brightness" this
semantic "This consumer doesn't care if the active cycle is anywhere in
the period". Hmm, maybe I just have to think about it a bit more to
become friends with that thought.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3rqqlwp4d36foled
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBuJUgACgkQwfwUeK3K
7AkeZQgAkT07fezSSY0Ww/dh+XugS9Qc2nJ2nzT4ZE/mZ/2XANqgdpXCgWpJTYsT
3JjMiC/3mn8CJBcBHPmVTAjb9sipkJoL6BFPYtcpAZ9JcWiYZPm7FmbViQERfp8a
3uMlxYmTL8h2mIiaPs9Z8U88D15FPXNMExCsMV7kXrtAg8HFOaSO9n8ecXjwi3NO
54bl9AGg2sVbpNqA9msLRQlmbKujHdJHNlm6n+tKX0vBWvI66mVtnuh72Ymxempp
qYjkm9ulM9tNXVsaSj++oV7Li0/NJFsi8kv89Ap1Fb5fuYJSs4R0RoSQFOr9rE3K
cshuyjCapTUubrSwAXiTDVEG27/XZw==
=5yuQ
-----END PGP SIGNATURE-----

--3rqqlwp4d36foled--
