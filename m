Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E28935303B
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Apr 2021 22:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhDBUX1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Apr 2021 16:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhDBUXY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Apr 2021 16:23:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0CDC0613E6
        for <linux-pwm@vger.kernel.org>; Fri,  2 Apr 2021 13:23:22 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lSQK8-0005B5-GB; Fri, 02 Apr 2021 22:23:20 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lSQK8-0002VA-6b; Fri, 02 Apr 2021 22:23:20 +0200
Date:   Fri, 2 Apr 2021 22:23:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <20210402202317.vq4xsp4yfpmvrxab@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
 <20210329180206.rejl32uajslpvbgi@pengutronix.de>
 <YGRqZsi4WApZcwIT@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rimdad5gkaqhxbgo"
Content-Disposition: inline
In-Reply-To: <YGRqZsi4WApZcwIT@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rimdad5gkaqhxbgo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 31, 2021 at 02:26:14PM +0200, Clemens Gruber wrote:
> On Mon, Mar 29, 2021 at 08:02:06PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 29, 2021 at 07:16:38PM +0200, Clemens Gruber wrote:
> > > On Mon, Mar 29, 2021 at 07:03:57PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Mar 29, 2021 at 02:57:04PM +0200, Clemens Gruber wrote:
> > > > > The PCA9685 supports staggered LED output ON times to minimize cu=
rrent
> > > > > surges and reduce EMI.
> > > > > When this new option is enabled, the ON times of each channel are
> > > > > delayed by channel number x counter range / 16, which avoids asse=
rting
> > > > > all enabled outputs at the same counter value while still maintai=
ning
> > > > > the configured duty cycle of each output.
> > > > >=20
> > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > >=20
> > > > Is there a reason to not want this staggered output? If it never hu=
rts I
> > > > suggest to always stagger and drop the dt property.
> > >=20
> > > There might be applications where you want multiple outputs to assert=
 at
> > > the same time / to be synchronized.
> > > With staggered outputs mode always enabled, this would no longer be
> > > possible as they are spread out according to their channel number.
> > >=20
> > > Not sure how often that usecase is required, but just enforcing the
> > > staggered mode by default sounds risky to me.
> >=20
> > There is no such guarantee in the PWM framework, so I don't think we
> > need to fear breaking setups. Thierry?
>=20
> Still, someone might rely on it? But let's wait for Thierry's opinion.
>=20
> >=20
> > One reason we might not want staggering is if we have a consumer who
> > cares about config transitions. (This however is moot it the hardware
> > doesn't provide sane transitions even without staggering.)
> >=20
> > Did I already ask about races in this driver? I assume there is a
> > free running counter and the ON and OFF registers just define where in
> > the period the transitions happen, right? Given that changing ON and OFF
> > needs two register writes probably all kind of strange things can
> > happen, right? (Example thought: for simplicity's sake I assume ON is
> > always 0. Then if you want to change from OFF =3D 0xaaa to OFF =3D 0xcc=
c we
> > might see a period with 0xacc. Depending on how the hardware works we
> > might even see 4 edges in a single period then.)
>=20
> Yes, there is a free running counter from 0 to 4095.
> And it is probably true, that there can be short intermediate states
> with our two register writes.
>=20
> There is a separate mode "Update on ACK" (MODE2 register, bit 3 "OCH"),
> which is 0 by default (Outputs change on STOP command) but could be set
> to 1 (Outputs change on ACK):
> "Update on ACK requires all 4 PWM channel registers to be loaded before
> outputs will change on the last ACK."

After reading the manual I understood that at least a bit now.

The Output chang on STOP is only needed to synchronize two or more
PCA9685 chips. Also with "Update on ACK" it is possible to prevent
glitches when writing with the auto increment mode. Not sure what
happens with the way it is implemented now, as it isn't described in
manual when the registers are written in four separate transfers.

I agree that addressing this in a separater patch is sensible.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rimdad5gkaqhxbgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBnfTIACgkQwfwUeK3K
7AnILQf+K2zbUUb+LkcaQ+sDwIrqbZo8O1lSwQcbK5TCWtvx5SJDZVataE9llISA
grwX637hFU8eh/7dZUiaRTlW/mmejOm7QfqGSUQLci+mYt0o4eDT8wJpHc1vDPGf
rKlNz8Q231V/WOmXOxsPVRV6yFGOGRxje+cqXHBDHDVrq/OuWADLCsQz9wR3HY+Z
crtPORzN0cqj3YhCzwewOEExG4wCyz2pLhCuQeShasVmFeC6yqy/6olSeGTxsOkm
K3afDyn3RRAfRddxUy6hq8TKnmk5isO9wnu+HfjHSVC3XBqWltxDrbL3a9wf3LVg
dVxK9/STSRiCGkyPzusLHnx2m+5lJw==
=RS9E
-----END PGP SIGNATURE-----

--rimdad5gkaqhxbgo--
