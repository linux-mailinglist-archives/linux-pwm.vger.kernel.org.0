Return-Path: <linux-pwm+bounces-587-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A580A81A096
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Dec 2023 15:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC5DB21528
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Dec 2023 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F1539869;
	Wed, 20 Dec 2023 14:00:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FDA374FD
	for <linux-pwm@vger.kernel.org>; Wed, 20 Dec 2023 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFx80-0001nM-Oh; Wed, 20 Dec 2023 15:00:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFx7z-000G5n-67; Wed, 20 Dec 2023 15:00:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFx7z-000noS-W8; Wed, 20 Dec 2023 15:00:52 +0100
Date: Wed, 20 Dec 2023 15:00:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de, 
	Tony Lindgren <tony@atomide.com>, Sean Young <sean@mess.org>
Subject: [GIT PULL] pwm: Changes for 6.8 merge window
Message-ID: <ishyqbiop3hnawt4fi6oryxdopr7mgwei6qxtvviw2umf7ms7i@e37l5ixqefhu>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="joq4l5edd2l4ejrv"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--joq4l5edd2l4ejrv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

here comes another PR with patches from the mailing list.

I wondered if your for-next branch is a good and stable base given that
it still contains a copy of the bcm2835 fix. I still based the PR on it
as the first patch that is new here fixes a commit that currently is
only in your branch. (So if you intend to drop the bcm2835 fix from your
for-next, the Fixes line in commit 92dfda9c9a9a ("pwm: cros-ec: Drop
documentation for dropped struct member") becomes wrong.)

I included the first patches of Sean's series with the atomic and
sleeping variants of pwm_apply. This way his adaption to the ir input
driver can go into next after 6.8-rc1 even if there isn't an atomic
pwm driver yet.

The following changes since commit 2cc2cb184833024f140af3175aa02e41f4e3d854:

  pwm: Stop referencing pwm->chip (2023-12-08 17:31:21 +0100)

are available in the Git repository at:

  https://git.pengutronix.de/git/ukl/linux tags/pwm/for-thierry-6.8-rc1-tak=
e2

for you to fetch changes up to ccff9fa92ee3e18fb3d6e59cad5c76c2ffc51e38:

  pwm: Make it possible to apply PWM changes in atomic context (2023-12-20 =
14:10:46 +0100)

Thanks to Tony and Sean for their contributions to the pwm subsystem.

Best regards and happy holidays,
Uwe

----------------------------------------------------------------
pwm patches for the 6.8 merge window

This is the selection of new patches from the mailing list that I
consider ready. With the holiday season about to start, I think it would
be good to get these into next soonish.

----------------------------------------------------------------
Sean Young (4):
      pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()
      pwm: Replace ENOTSUPP with EOPNOTSUPP
      pwm: renesas: Remove unused include
      pwm: Make it possible to apply PWM changes in atomic context

Tony Lindgren (1):
      dt-bindings: pwm: ti,pwm-omap-dmtimer: Update binding for yaml

Uwe Kleine-K=F6nig (8):
      pwm: cros-ec: Drop documentation for dropped struct member
      pwm: Reduce number of pointer dereferences in pwm_device_request()
      pwm: crc: Use consistent variable naming for driver data
      pwm: omap-dmtimer: Drop locking
      pwm: stmpe: Silence duplicate error messages
      pwm: meson: Simplify using dev_err_probe()
      pwm: lpc18xx-sct: Don't modify the cached period of other PWM outputs
      pwm: Drop two unused API functions

 .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   | 22 ------
 .../bindings/pwm/ti,omap-dmtimer-pwm.yaml          | 59 +++++++++++++++
 Documentation/driver-api/pwm.rst                   | 17 ++++-
 MAINTAINERS                                        |  2 +-
 drivers/gpu/drm/i915/display/intel_backlight.c     |  6 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |  2 +-
 drivers/hwmon/pwm-fan.c                            |  8 +-
 drivers/input/misc/da7280.c                        |  4 +-
 drivers/input/misc/pwm-beeper.c                    |  4 +-
 drivers/input/misc/pwm-vibra.c                     |  8 +-
 drivers/leds/leds-pwm.c                            |  2 +-
 drivers/leds/rgb/leds-pwm-multicolor.c             |  4 +-
 drivers/media/rc/pwm-ir-tx.c                       |  4 +-
 drivers/platform/x86/lenovo-yogabook.c             |  2 +-
 drivers/pwm/core.c                                 | 88 ++++++++++++++++--=
----
 drivers/pwm/pwm-crc.c                              | 16 ++--
 drivers/pwm/pwm-cros-ec.c                          |  1 -
 drivers/pwm/pwm-lpc18xx-sct.c                      |  4 +-
 drivers/pwm/pwm-meson.c                            | 35 ++++-----
 drivers/pwm/pwm-omap-dmtimer.c                     | 20 +----
 drivers/pwm/pwm-renesas-tpu.c                      |  1 -
 drivers/pwm/pwm-stmpe.c                            | 12 +--
 drivers/pwm/pwm-twl-led.c                          |  2 +-
 drivers/pwm/pwm-vt8500.c                           |  2 +-
 drivers/pwm/sysfs.c                                | 10 +--
 drivers/regulator/pwm-regulator.c                  |  4 +-
 drivers/video/backlight/lm3630a_bl.c               |  2 +-
 drivers/video/backlight/lp855x_bl.c                |  2 +-
 drivers/video/backlight/pwm_bl.c                   | 12 +--
 drivers/video/fbdev/ssd1307fb.c                    |  2 +-
 include/linux/pwm.h                                | 69 ++++++++++-------
 31 files changed, 252 insertions(+), 174 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.=
txt
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,omap-dmtimer-p=
wm.yaml

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--joq4l5edd2l4ejrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWC848ACgkQj4D7WH0S
/k5sbgf9E297D5ACk+mwWTwijbGYb4PrJeezL6c7D8NtM4yEK24/YKNhfa/OXrBO
uvxHLuUvXw3CEgOvE5DL67epWlpItc4I1Gcepdk6LSX/Z370MVNb7IhgJ3a5xjoJ
AI0MVPw8km8qQZxiOh7voqYr1XcBXGh5NO9XsOH4vq/Ho6sgRx0S1xS9usm4KwDt
e4g+jXJZn9tSQrnjD4qwwSA+jewGOrgP3AGNVUnZx1hJGmZtcRZMAXjgqHkbbIMa
fZ9g205Jhp7cUDsnuDgV7vOLS5C6UfJv3tp0pRpDEczzvNBZhyhtWap9FjEpx6MP
iuU7CWR0rzZtDqhsh+QaBGa2+4PoJQ==
=QSZP
-----END PGP SIGNATURE-----

--joq4l5edd2l4ejrv--

