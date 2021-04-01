Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD8B352136
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Apr 2021 22:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhDAU7m (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Apr 2021 16:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbhDAU7l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Apr 2021 16:59:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE38C061788
        for <linux-pwm@vger.kernel.org>; Thu,  1 Apr 2021 13:59:41 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lS4Pj-0003dT-Rp; Thu, 01 Apr 2021 22:59:39 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lS4Pj-0005nt-I2; Thu, 01 Apr 2021 22:59:39 +0200
Date:   Thu, 1 Apr 2021 22:59:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <20210401205936.nnraoeeyo5nx3elf@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
 <20210329180206.rejl32uajslpvbgi@pengutronix.de>
 <YGRqZsi4WApZcwIT@workstation.tuxnet>
 <YGR/ZYj+GZIonU/J@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jxpvtgzt3acwzsij"
Content-Disposition: inline
In-Reply-To: <YGR/ZYj+GZIonU/J@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jxpvtgzt3acwzsij
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 31, 2021 at 03:55:49PM +0200, Clemens Gruber wrote:
> On Wed, Mar 31, 2021 at 02:26:14PM +0200, Clemens Gruber wrote:
> > On Mon, Mar 29, 2021 at 08:02:06PM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Mon, Mar 29, 2021 at 07:16:38PM +0200, Clemens Gruber wrote:
> > > > On Mon, Mar 29, 2021 at 07:03:57PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > On Mon, Mar 29, 2021 at 02:57:04PM +0200, Clemens Gruber wrote:
> > > > > > The PCA9685 supports staggered LED output ON times to minimize =
current
> > > > > > surges and reduce EMI.
> > > > > > When this new option is enabled, the ON times of each channel a=
re
> > > > > > delayed by channel number x counter range / 16, which avoids as=
serting
> > > > > > all enabled outputs at the same counter value while still maint=
aining
> > > > > > the configured duty cycle of each output.
> > > > > >=20
> > > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > >=20
> > > > > Is there a reason to not want this staggered output? If it never =
hurts I
> > > > > suggest to always stagger and drop the dt property.
> > > >=20
> > > > There might be applications where you want multiple outputs to asse=
rt at
> > > > the same time / to be synchronized.
> > > > With staggered outputs mode always enabled, this would no longer be
> > > > possible as they are spread out according to their channel number.
> > > >=20
> > > > Not sure how often that usecase is required, but just enforcing the
> > > > staggered mode by default sounds risky to me.
> > >=20
> > > There is no such guarantee in the PWM framework, so I don't think we
> > > need to fear breaking setups. Thierry?
> >=20
> > Still, someone might rely on it? But let's wait for Thierry's opinion.
> >=20
> > >=20
> > > One reason we might not want staggering is if we have a consumer who
> > > cares about config transitions. (This however is moot it the hardware
> > > doesn't provide sane transitions even without staggering.)
> > >=20
> > > Did I already ask about races in this driver? I assume there is a
> > > free running counter and the ON and OFF registers just define where in
> > > the period the transitions happen, right? Given that changing ON and =
OFF
> > > needs two register writes probably all kind of strange things can
> > > happen, right? (Example thought: for simplicity's sake I assume ON is
> > > always 0. Then if you want to change from OFF =3D 0xaaa to OFF =3D 0x=
ccc we
> > > might see a period with 0xacc. Depending on how the hardware works we
> > > might even see 4 edges in a single period then.)
> >=20
> > Yes, there is a free running counter from 0 to 4095.
> > And it is probably true, that there can be short intermediate states
> > with our two register writes.
> >=20
> > There is a separate mode "Update on ACK" (MODE2 register, bit 3 "OCH"),
> > which is 0 by default (Outputs change on STOP command) but could be set
> > to 1 (Outputs change on ACK):
> > "Update on ACK requires all 4 PWM channel registers to be loaded before
> > outputs will change on the last ACK."
>=20
> This would require the auto-increment feature to be enabled, then
> multiple registers could be written before the STOP condition:
> LEDn_ON_L, LEDn_ON_H, LEDn_OFF_L & LEDn_OFF_H
> (With OCH=3D0 in MODE2)

Maybe a continued START would work, too?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jxpvtgzt3acwzsij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBmNDUACgkQwfwUeK3K
7Al66Qf9HYR7KeNN7bbqMAlmpuPRQyV+3WTT+TsYcd/7FfAZ5etZxAGpxuo3zmBL
sZTqrJ/zQ7T6zFODF9ZV2B5457QpsxO1KxSQyF5B8eP+X1S8NwRxmfDBy3TkWtje
IpcR3c/4K26rOk0/Nsb6ZIRc2MDvu4+FUPgC7e3s2+YR2R/MfSwaS7smejvfMP6V
tjNOq1WceZ8PqGlTD4da7ghZgUJ2V5XZblxHeYQL+B83Ounoq2gLNSBVN6MRwYkb
HAlXmHT61sgtL+LTntu7dnVMWzPiYqiEi/f5uINcwrxgKgvOtggHP/3L74x+dnrr
HbJPN1bGRbbFkqOAagIt4ulGp78N4A==
=+8JB
-----END PGP SIGNATURE-----

--jxpvtgzt3acwzsij--
