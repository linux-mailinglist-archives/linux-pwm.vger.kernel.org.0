Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B18E43FB32
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 13:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhJ2LJI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 07:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhJ2LJH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 07:09:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D1C061570
        for <linux-pwm@vger.kernel.org>; Fri, 29 Oct 2021 04:06:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgPiK-0001mx-Nh; Fri, 29 Oct 2021 13:06:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgPiH-0005QG-KK; Fri, 29 Oct 2021 13:06:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgPiH-0002TX-J4; Fri, 29 Oct 2021 13:06:21 +0200
Date:   Fri, 29 Oct 2021 13:06:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>, lkp@intel.com,
        mchehab@kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211029110602.uugnbm5vtfpghiwh@pengutronix.de>
References: <YXlxhpZWf2mxJaMi@fedora>
 <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
 <20211028091442.GA16514@gofer.mess.org>
 <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
 <20211028122610.GA18767@gofer.mess.org>
 <20211028180516.t2tpfbzztm7s6cqm@pengutronix.de>
 <20211029071608.GA28997@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azgvopiwgpdhztkw"
Content-Disposition: inline
In-Reply-To: <20211029071608.GA28997@gofer.mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--azgvopiwgpdhztkw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 29, 2021 at 08:16:08AM +0100, Sean Young wrote:
> On Thu, Oct 28, 2021 at 08:05:16PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Oct 28, 2021 at 01:26:10PM +0100, Sean Young wrote:
> > > > bloat-o-meter reports (for an arm allmodconfig build)
> > > >=20
> > > > 	add/remove: 0/0 grow/shrink: 3/1 up/down: 644/-396 (248)
> > > > 	Function                                     old     new   delta
> > > > 	pwm_ir_probe                                 372     676    +304
> > > > 	pwm_ir_set_carrier                           108     292    +184
> > > > 	pwm_ir_set_duty_cycle                         68     224    +156
> > > > 	pwm_ir_tx                                    908     512    -396
> > > > 	Total: Before=3D2302, After=3D2550, chg +10.77%
> > >=20
> > > So 248 bytes more after your changes.
> >=20
> > ack. This is because the compiler inlines the division which accounts
> > for > 100 bytes.
>=20
> I'm surprised it's that large. This is on 32 bit?

Yes, it's a 64 bit division on 32 bit ARM.

> > > > struct pwm_ir increases from 12 bytes to 40 bytes.
> > > >=20
> > > > The stack space required by pwm_ir_tx decreases from 60 to 36
> > > >=20
> > > > I don't know exactly how kmalloc works internally. Maybe allocating=
 a
> > > > structure of size 40 bytes doesn't need more memory than a structur=
e of
> > > > size 12?
> > > >=20
> > > > I didn't check how runtimes change, but the size decrease of pwm_ir=
_tx()
> > > > is nice and might save a bit of runtime.
> > >=20
> > > I'm not following, how is this decreasing runtime?=20
> >=20
> > With my changes pwm_ir_tx got smaller and { pwm_ir_probe,
> > pwm_ir_set_carrier, pwm_ir_set_duty_cycle } got bigger. Now if for a
> > typical runtime pattern pwm_ir_probe and pwm_ir_set_carrier run once and
> > pwm_ir_set_duty_cycle 100 times and pwm_ir_tx 1000 times (no idea if
> > that is realistic) it might be a net win in sum.
>=20
> The two most common programs for sending IR are
>=20
> ir-ctl: https://git.linuxtv.org/v4l-utils.git/tree/utils/ir-ctl/ir-ctl.c#=
n1041
> lircd: https://sourceforge.net/p/lirc/git/ci/master/tree/lib/transmit.c
>=20
> For each transmission, the carrier is set. If the duty cyle is specified,
> then that is set too. Then the transmit itself is done. Both of them
> set the carrier and duty cycle (if required) for every transmission: sett=
ing
> the carrier and duty cycle is a cheap operation, and it is device property
> which can be overriden by another process.=20
>=20
> This means with your changes, if the carrier and duty cycle are both set
> for each transmission, then we're doing more work. If only the carrier
> is set for each transmission, then there is no net gain/loss (I think),
> but the code size has increased.

OK, then I discard my patch.

While reading that I wondered if it makes sense to have a callback that
sets both carrier and duty cycle and then remove the other two.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--azgvopiwgpdhztkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF71ZIACgkQwfwUeK3K
7Am79wf/SqQB9cLC/swxCjRZ+kXJ+3z7js+zIjZQHScbxNaycBfosNwROYJ/U5IJ
ArOIy5R7/y6PzPwE+iPEIYXA/o7tz/wamOogZWcT8ZxJVC/UlSkcx5Sh7z0xAkbC
ISbuy4VtDhOp0+BL8g4VasCYf1yYs8SFdzcKw76FgYM4/Qmr8VRuukYL21SbHfWV
O+W3G/MZE5NLV79x33fsPNkfvYiJav2xF1IYKde4dyJGG3HKd5uS3OGo8xU6rhpR
WUfLjldheUvP4ZVO0HcGPJTHia1K8bFB1qfwkYDuetBhpICHk+mbpWP92OfBvtJo
2/en1tqciILjZz/+eRRRa9kTnehVWg==
=3f91
-----END PGP SIGNATURE-----

--azgvopiwgpdhztkw--
