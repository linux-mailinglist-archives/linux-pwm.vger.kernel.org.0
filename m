Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA81C7BBD73
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 19:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjJFRFo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 13:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjJFRFn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 13:05:43 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A238BF
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 10:05:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qooGi-0002Gm-0c; Fri, 06 Oct 2023 19:05:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qooGh-00BYrS-Ji; Fri, 06 Oct 2023 19:05:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qooGh-00AOO2-AS; Fri, 06 Oct 2023 19:05:39 +0200
Date:   Fri, 6 Oct 2023 19:05:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sean Young <sean@mess.org>, kernel@pengutronix.de
Subject: Re: [PATCH v1 000/101] pwm: Fix lifetime issues for pwm_chips
Message-ID: <20231006170539.6vspucly3bddcpbo@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230926100625.vudo7qp3h5r2dz62@pengutronix.de>
 <20231001111024.a3ce3het2y3n7kvx@pengutronix.de>
 <ZR_eW-YsYrLUxPfF@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2zkzi4rewbq66sx6"
Content-Disposition: inline
In-Reply-To: <ZR_eW-YsYrLUxPfF@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2zkzi4rewbq66sx6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Oct 06, 2023 at 12:15:55PM +0200, Thierry Reding wrote:
> On Sun, Oct 01, 2023 at 01:10:24PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Sep 26, 2023 at 12:06:25PM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Tue, Aug 08, 2023 at 07:17:50PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > this series addresses the issues I reported already earlier to this
> > > > list[1]. It is based on pwm/for-next and several patches I already =
sent
> > > > out, too. Maybe some of these have to be reworked (e.g. Thierry alr=
eady
> > > > signalled not to like the patches dropping runtime error messages) =
but
> > > > in the expectation that I will have to create a v2 for this series,=
 too
> > > > and it actually fixes a race condition, I sent the patches out for
> > > > review anyhow. For the same reason I didn't Cc: all the individual
> > > > maintainers.
> > > >=20
> > > > If you want to actually test I suggest you fetch my complete history
> > > > from
> > > >=20
> > > > 	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking
> > > >=20
> > > > .=20
> > > >=20
> > > > In the end drivers have to allocate their pwm_chip using
> > > > pwmchip_alloc(). This is important for the memory backing the pwm_c=
hip
> > > > being able to have a longer life than the driver.
> > > >=20
> > > > The motivation for this series is to prepare the pwm framework to a=
dd a
> > > > character device for each pwm_chip for easier and faster access to =
PWMs
> > > > from userspace compared to the sysfs API. For such an extension pro=
per
> > > > lifetime tracking is important, too, as such a device can still be =
open
> > > > if a PWM disappears.
> > >=20
> > > I wonder how this topic will continue. This series fixes a lifetime
> > > issue that can result in a userspace triggered oops and it builds the
> > > base for my efforts to create a /dev/pwmchipX for faster control of P=
WMs
> > > from userspace (compared to sysfs). (Currently in the prototype stage=
=2E)
> > >=20
> > > I'd like to get this in during the next merge window, please tell me
> > > what needs to be done to make this happen.
> >=20
> > One problem I noticed yesterday is that this series depends on patch
> > "drm/ssd130x: Print the PWM's label instead of its number" that
> > currently waits in drm-misc-next for getting in the main line. The
> > series could for sure be reworked to not rely on this patch, but I'd
> > prefer to wait until after the next merge window instead of reworking
> > it.
> >=20
> > Still, getting some feedback here in the mean time would be nice. The
> > questions I wonder about myself are:
> >=20
> >  - In patch #1, devm_pwmchip_alloc() could get another parameter for the
> >    .ops member. This would save a line per driver like
> >=20
> >    	chip->ops =3D &pwm_clk_ops;
> >=20
> >    in return for an additional parameter that yields longer lines in the
> >    drivers.
> >=20
> >  - In patch #101 instead of using &pwm_lock a per-pwmchip lock could be
> >    used for pwm_apply_state(). This would allow to parallelize pwm calls
> >    for different chips; I don't know how much this matters. Maybe the
> >    sensible option here is to keep it simple for now (i.e. how I
> >    implemented it now) until someone complains? (But see also the next
> >    item.)
> >=20
> >  - A further complication is the requirement of pwm-ir-tx for faster
> >    pwm_apply_state() calls, see
> >=20
> > 	https://lore.kernel.org/linux-pwm/ZRb5OWvx3GxYWf9g@gofer.mess.org
> >    	https://lore.kernel.org/linux-pwm/1bd5241d584ceb4d6b731c4dc3203fb96=
86ee1d1.1696156485.git.sean@mess.org
> >=20
> >    . This complicates the locking scheme, I didn't try to address that
> >    yet.
>=20
> Frankly, I think per-chip locking is the only way to support slow
> busses. If we use the subsystem-wide lock, effectively all chips become
> slow and unusable for things like pwm-ir-tx.
>=20
> Perhaps we can draw some inspiration from how the IRQ infrastructure
> deals with this? IRQ chips have irq_bus_lock() and irq_bus_sync_unlock()
> callbacks to deal with this. We could have something similar for PWM
> chips. Perhaps that's even something that could be handled in the core
> by checking a "might_sleep" flag for the chip.

I'll invest some time to work on that, also considering that we might
not want sleep at all for "fast" PWMs.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2zkzi4rewbq66sx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUgPmIACgkQj4D7WH0S
/k6XzQgAk2QZ96ShYMezS/2oNV3Mp59VnbhOL6c/E0azfrqGUXq7jgH5MHMG95bO
3iq+aF1BykIV6kQruZfXz84iqnEdlPq77VDZf7faWiPNUhgE/9QCdlCrDXbfK1bR
AgfAogmfaJOMIWCIYntOKl0W4NdMUjC1JgtTA5+bGmQaiI4dcSqy/cVR/v44mqfd
+sBca8LiD+mQTZsGefBc6E3rsIP315BOCea9IntGrkgSkdwb5AEe2bbMDkSRKQTN
S1eiI1XVMTYEoNb6DQVjR+KkeEc6VrHJm19o23h2CwP2hC2VNCTsm8JJ+sQ8AJRS
093GbM8ZBgPr/blYw1dCZhnb4/FO9A==
=NiBR
-----END PGP SIGNATURE-----

--2zkzi4rewbq66sx6--
