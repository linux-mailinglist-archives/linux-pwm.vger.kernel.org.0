Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FD46226DB
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Nov 2022 10:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiKIJ1E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Nov 2022 04:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKIJ06 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Nov 2022 04:26:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AF0140F2
        for <linux-pwm@vger.kernel.org>; Wed,  9 Nov 2022 01:26:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oshMF-0005Xb-1w; Wed, 09 Nov 2022 10:26:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oshMD-003DwK-Fv; Wed, 09 Nov 2022 10:26:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oshMD-00FO8i-OD; Wed, 09 Nov 2022 10:26:53 +0100
Date:   Wed, 9 Nov 2022 10:26:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 4/5] pwm: pxa: Wait for final PWM period to finish
Message-ID: <20221109092653.qwwexcclg6gxn4cu@pengutronix.de>
References: <20221003015546.202308-1-doug@schmorgal.com>
 <20221003015546.202308-5-doug@schmorgal.com>
 <20221019073929.3abj6ohhcreifyso@pengutronix.de>
 <a9c974f1-fc66-b964-c7f0-b7e4320f2177@schmorgal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="svigzme6xfd4tylu"
Content-Disposition: inline
In-Reply-To: <a9c974f1-fc66-b964-c7f0-b7e4320f2177@schmorgal.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--svigzme6xfd4tylu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Doug,

On Sat, Oct 22, 2022 at 12:35:23PM -0700, Doug Brown wrote:
> On 10/19/2022 12:39 AM, Uwe Kleine-K=F6nig wrote:
> > On Sun, Oct 02, 2022 at 06:55:45PM -0700, Doug Brown wrote:
> > > If the clock is turned on too quickly after being turned off, it won't
> > > actually turn back on. Work around this problem by waiting for the fi=
nal
> > > period to complete when disabling the PWM. The delay logic is borrowed
> > > from the pwm-sun4i driver.
> > >=20
> > > To avoid unnecessary delays, skip the whole config process if the PWM=
 is
> > > already disabled and staying disabled.
> >=20
> > I wonder if there is some documentation available about this issue. This
> > feels like a workaround without knowledge about the details and so might
> > break at the next opportunity.
>=20
> Thanks for reviewing! Yes, it does feel like a crazy workaround. I'm not
> super proud of it. The best documentation I've been able to look at is
> the PXA168 software manual [1]. Page 502 of the PDF talks about a
> "graceful shutdown" where turning off the clock enable bit doesn't
> immediately stop the clock, and instead it waits for the current PWM
> period to complete first. This driver is currently configuring it for
> graceful shutdown mode, because the PWMCR_SD bit is not set (page 1257).
>=20
> I've experimentally determined that if you try to turn the clock back on
> when a graceful shutdown is still scheduled, it doesn't cancel the
> graceful shutdown, so the clock ends up off afterward, even though the
> common clock framework thinks it's still on. The hacky delay in this
> commit works around that problem. This almost seems like a problem that
> should be solved on the common clock framework side instead, but it
> doesn't know what the PWM frequency is so it wouldn't know how long to
> delay.
>=20
> Do all the other similar drivers in the kernel do a graceful shutdown
> like this when they are turned off? If not, a simpler solution would be
> to start turning on the PWMCR_SD bit instead, so the clock stops
> immediately (potentially resulting in the final duty cycle being short).

There are supported hardwares that (only) support immediate shutdown, so
consumers cannot rely on a graceful stop anyhow. So I'd say using
PWMCR_SD=3D1 is fine. The documentation suggests that in this case "PWM_OUT=
x stops
after at most one PSCLK_PWM" which might explain that the problem can
still be triggered. (i.e. if you reenable before the next PSCLK_PWM
cycle.)

BTW, the driver lacks information about how the hardware behaves on
disable. The most common cases are

 - emits the inactive output
 - freezes where it just happens to be (assuming PWMCR_SD=3D1)

Would you mind testing that and adding a patch to your series? (Look at
e.g. drivers/pwm/pwm-sl28cpld.c for the desired format to ease
grepping.)

> I tested that change in place of this commit and it seems to work pretty
> well, although I can still cause it to fail if I turn my PWM backlight
> off and back on quickly without a "sleep 0.000001" in between. It feels
> to me like there are some weird interdependencies between the clock
> enable bits and the actual PWM controller block, at least in the PXA168,
> likely due to "graceful shutdown" mode's existence.
>=20
> What do you think? Turning on the PWMCR_SD bit would be very simple, but
> it doesn't fully fix the issue in my testing. I'd still be okay with it
> though, because the only failure case I can reproduce is a minor edge
> case (plus, I don't love the delay solution).

+1 for no love for the delay solution.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--svigzme6xfd4tylu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNrcloACgkQwfwUeK3K
7Ann6Af9EMrQQ7cnss/b+NWBDIHI0E95e2NXh4D/birDB5pzGI69RhHF5jJOU2ae
DWjzU3P78EcuasdyW8IW3krtrYpIVdCITgJfkjJdUy9mf2HCIc8HmON+iFA9xKtZ
5/z5yxU6kGIYqS0ah2PgIR2a04RX7QnSRAQtRpB7lCnZXHAvSHw+qt3ocUYRl/aN
ks3npvgBbAalmuJ3gOcugMazpU2YgDptHOvYz6XGpfL7KkVc696MED7voKIf8TxA
U+WOgUe6JYZIEhzjYjKAgwHK9FQ7/P2KSbQAChFEkocwQZRa6maYF8l1LKptZaUK
FnhSu2cZafncH7sRUjPfDMgdmPMrgw==
=8rN/
-----END PGP SIGNATURE-----

--svigzme6xfd4tylu--
