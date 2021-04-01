Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CE5352130
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Apr 2021 22:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhDAU62 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Apr 2021 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhDAU62 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Apr 2021 16:58:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE70C0613E6
        for <linux-pwm@vger.kernel.org>; Thu,  1 Apr 2021 13:58:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lS4OV-0003bP-Sw; Thu, 01 Apr 2021 22:58:23 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lS4OV-0005nC-5i; Thu, 01 Apr 2021 22:58:23 +0200
Date:   Thu, 1 Apr 2021 22:58:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <20210401205819.soloiozcrgq4eool@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
 <20210329180206.rejl32uajslpvbgi@pengutronix.de>
 <YGRqZsi4WApZcwIT@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n7fwc2tuuwjeiysf"
Content-Disposition: inline
In-Reply-To: <YGRqZsi4WApZcwIT@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--n7fwc2tuuwjeiysf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

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

Someone might rely on the pca9685 driver being as racy as a driver with
legacy bindings usually is. Should this be the reason to drop this whole
series?

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

This is about the ACK and STOP in the i2c communication, right? I fail
to understand the relevance of this difference. I guess I have to read
the manual myself.
=20
> The chip datasheet also states:
> "Because the loading of the LEDn_ON and LEDn_OFF registers is via the
> I2C-bus, and asynchronous to the internal oscillator, we want to ensure
> that we do not see any visual artifacts of changing the ON and OFF
> values. This is achieved by updating the changes at the end of the LOW
> cycle."

So we're only out of luck if the first register write happens before and
the second after the end of the LOW cycle, aren't we?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n7fwc2tuuwjeiysf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBmM+gACgkQwfwUeK3K
7AnrnAf+PVqO/phKEkjjclL7NYX3i7Sm9fZztTdeMkcLrsnLRFF5qwQXZSraTmST
3WWiIqCLUmgCh/ksNhqyP6Ka1tQe0oEnNodSjMVKCK6773byXUevAz4xF/1xXFfj
Lcef2ZfuztMUgRAKOKCDqMDN/KJNsYZrYWtcJND2GwIGSCIIbnZdkVVPZ2rq2Ewh
lf5HuxSDzn28um1H+4wD4MzXtWcBPV72UFgPwitUC0xDxwuZARQ7HmDJorCp8r7C
swsBJ8V0fVab2vFyL0jch+IHn3E8MS6VFj442JMk9kNwSWjscaJFVJ+XcP0gvwFk
/pQEleVfH97fDbezvKksfAfh5xTi3w==
=scZq
-----END PGP SIGNATURE-----

--n7fwc2tuuwjeiysf--
