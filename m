Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A765F578
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jan 2023 22:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjAEVCo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Jan 2023 16:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjAEVCW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Jan 2023 16:02:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49385DE6E
        for <linux-pwm@vger.kernel.org>; Thu,  5 Jan 2023 13:02:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pDXNR-0007NL-V5; Thu, 05 Jan 2023 22:02:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pDXNQ-0044Be-Ke; Thu, 05 Jan 2023 22:02:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pDXNP-00AViz-UM; Thu, 05 Jan 2023 22:02:15 +0100
Date:   Thu, 5 Jan 2023 22:02:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Axel Lin <axel.lin@ingics.com>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: ab8500:
Message-ID: <20230105210215.4ov3erqpyib2ah6f@pengutronix.de>
References: <20230103231841.1548913-1-u.kleine-koenig@pengutronix.de>
 <CACRpkdYMUBGOPoS3BUhwv=pwhnPfq94VLsanyBs0J_ajrsq30Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wbjihksir7cplx2f"
Content-Disposition: inline
In-Reply-To: <CACRpkdYMUBGOPoS3BUhwv=pwhnPfq94VLsanyBs0J_ajrsq30Q@mail.gmail.com>
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


--wbjihksir7cplx2f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 05, 2023 at 01:14:33AM +0100, Linus Walleij wrote:
> On Wed, Jan 4, 2023 at 12:18 AM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > The .apply() callback only considered the 10 low bits of .duty_cycle and
> > didn't check .period at all.
> >
> > My best guess is the period is fixed at 1024 ns =3D 0x400 ns. Based on
> > that assumption refuse configurations that request a lower period (as
> > usual for PWM drivers) and configure a duty cycle of 0x3ff ns for all
> > bigger requests.
> >
> > This improves behaviour for a few requests:
> >
> >   request  | previous result | new result
> > -----------+-----------------+------------
> >  1024/1024 |          0/1024 |  1023/1024
> >  4000/5000 |        928/1024 |  1023/1024
> >  5000/5000 |        904/1024 |  1023/1024
> >
> > (Values specified as duty_cycle / period in ns)
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Looks correct to me:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Believe it or not but there is a hard-to-find public datasheet:
> https://web.archive.org/web/20130614115108/http://www.stericsson.com/deve=
lopers/CD00291561_UM1031_AB8500_user_manual-rev5_CTDS_public.pdf
>=20
> These register bits are described on page 282-283.

Hmm, there are three settings related to the PWM (page 70):

 EnaPWMOut(i)
 FreqPWMOut(i)
 DutyPWMOut(i)

If I understand the manual correctly, the driver is totaly bogous.
With FreqPWMOut the period is defined, this is always set to 4b0, so the
frequency is 293 Hz =E2=89=83 3412969 ns. So if .duty_cycle =3D 1 ns is req=
uested,
we currently get 2 * 3412969 / 1024 ns =E2=89=83 6666 ns?!

The EnaPWMOut bits are not handled at all. I assume when this is unset,
the output is inactive?

Probably the three PWMs are better represented as one chip with 3
outputs instead of three chips with one PWM each, given there is only
one register for the EnaPWMOut bits.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wbjihksir7cplx2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO3OtQACgkQwfwUeK3K
7Akvigf/fOYVqExaOjsC/oBwEp9wIDCajIGiWp5BVN5D4uX4oN9gSIlPJTSUsDfj
aww9ekH79Mm9m+QRL62xIf17vzIN04X0TWmxo3KT/+I7CwVm6ArD+waBMX990fv2
GdE73wGKC347PAvh6n5B+Rww7BQiA1bIKHU6inJW9qYiCjQlolx44O35e6+U7sAt
pSFzNbuxIQs4WuiqAP061MSE8CgtFr2dUD9D+BTMBGbsFWtHMS+esVfL1X/nyzlV
QWMgZS8qMAzc6Z2nFn4yu6cfKP9j9m7VzzAoxp5OIed3DxKfTW6YhiZQ4kjn9+IC
1Z6mo7e4n9bcAR8dDdjpBFitFm2LNw==
=cRb/
-----END PGP SIGNATURE-----

--wbjihksir7cplx2f--
