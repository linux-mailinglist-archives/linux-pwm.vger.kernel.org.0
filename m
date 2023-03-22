Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89F6C58F1
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Mar 2023 22:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCVVpp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 Mar 2023 17:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVVpo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Mar 2023 17:45:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4515F33CE8
        for <linux-pwm@vger.kernel.org>; Wed, 22 Mar 2023 14:45:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pf6H7-00037V-Om; Wed, 22 Mar 2023 22:45:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pf6H6-0060XW-TR; Wed, 22 Mar 2023 22:45:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pf6H6-0078ml-1D; Wed, 22 Mar 2023 22:45:40 +0100
Date:   Wed, 22 Mar 2023 22:45:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org
Subject: [PULL] pwm: fixes for the 6.3 development cycle
Message-ID: <20230322214539.vbjpsqnlvhagiibd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lud3ssdgk3o6hsyl"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lud3ssdgk3o6hsyl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

the following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.pengutronix.de/git/ukl/linux tags/pwm/for-6.3

for you to fetch changes up to cd8e136dc420bd40e27f77e7bd3da5289c4c4b67:

  pwm: Zero-initialize the pwm_state passed to driver's .get_state() (2023-=
03-22 22:18:29 +0100)

IMHO these should go in before the 6.3 release as they fix a reported
crash.

The idea of this PR is to simplify sending these fixes to Linus for you
(in the assumption that you agree that's the right thing to do).

Best regards
Uwe

----------------------------------------------------------------
pwm fixes for 6.3

A commit merged for 6.2-rc1 (namely c73a3107624d ("pwm: Handle
=2Eget_state() failures")) resulted in passing an uninitialized struct
pwm_state to lowlevel driver's .get_state() callback. Together with some
lowlevel drivers not overwriting all members of this output variable,
this resulted in a crash on an Amlogic Meson G12B board reported by
Munehisa Kamata.

The patches in this pull request fix this twice:

 a) by ensuring that all pwm drivers set the .polarity member
 b) by zero initializing the memory passed to .get_state()

----------------------------------------------------------------
Uwe Kleine-K=F6nig (6):
      pwm: hibvt: Explicitly set .polarity in .get_state()
      pwm: cros-ec: Explicitly set .polarity in .get_state()
      pwm: iqs620a: Explicitly set .polarity in .get_state()
      pwm: sprd: Explicitly set .polarity in .get_state()
      pwm: meson: Explicitly set .polarity in .get_state()
      pwm: Zero-initialize the pwm_state passed to driver's .get_state()

 drivers/pwm/core.c        | 12 ++++++++++--
 drivers/pwm/pwm-cros-ec.c |  1 +
 drivers/pwm/pwm-hibvt.c   |  1 +
 drivers/pwm/pwm-iqs620a.c |  1 +
 drivers/pwm/pwm-meson.c   |  8 ++++++++
 drivers/pwm/pwm-sprd.c    |  1 +
 6 files changed, 22 insertions(+), 2 deletions(-)

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lud3ssdgk3o6hsyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQbdwMACgkQj4D7WH0S
/k4UDQgAtX36oCfGEocd23uqKhW8Qyb+1E9jXDq9OJMBn89BGPfL/p7iASIbaMEL
Q5P1MrcActLmGy2Bf53g7PiXaJgbtxFvUGn2kkAhzVDzEOFlK1l0HlBjbo+Ykl7a
coxBZ5b0kEVolkUnUosmPuxEvbfXvloMcjMt3FVs+5Ji0QY6Bf8eRQgVm+aDGwVp
U1dMI309p1VgSifxv7WsaxTmxxtxZ91eh2XDJquNKL4TtcD5OG9GJKjgIjqGH4mG
sIQIdsvQv5xb0QWFqktQp5dMT9LGucwQpQJ9AaylMj/GxQ4AU2k5J7X+J3n9DsPd
1/0BIczf/Q1RJWMY9hPub5URC5w18g==
=1lpX
-----END PGP SIGNATURE-----

--lud3ssdgk3o6hsyl--
