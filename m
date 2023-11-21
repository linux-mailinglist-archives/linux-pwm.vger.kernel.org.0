Return-Path: <linux-pwm+bounces-2-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821967F2B92
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 12:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5162821B5
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BFA48780;
	Tue, 21 Nov 2023 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1D79C
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 03:20:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5Onu-0005Yb-Gh; Tue, 21 Nov 2023 12:20:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5Onu-00AZEI-4E; Tue, 21 Nov 2023 12:20:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5Ont-004snT-RT; Tue, 21 Nov 2023 12:20:29 +0100
Date: Tue, 21 Nov 2023 12:20:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [GIT PULL] pwm: Changes for next
Message-ID: <20231121112029.gyv3gqirlycysyr4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cetvuv3um2cbrya7"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--cetvuv3um2cbrya7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

to get a defined and useful base for my lifetime and character support
code changes here comes a pull request with the commits that I'd like to
have in next and build upon.

Note that the first commit is a fix that IMHO should go into
v6.7-rc$next.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.pengutronix.de/git/ukl/linux tags/pwm/for-thierry-6.8-rc1

for you to fetch changes up to 869de350ff3834145273a6d39faedea878c6715a:

  pwm: cros-ec: Drop unused member from driver private data (2023-11-21 11:=
13:31 +0100)

----------------------------------------------------------------
These commits are the ones from the pwm mailing list that I currently
consider ready to go into next.

----------------------------------------------------------------
Florian Fainelli (1):
      pwm: bcm2835: Fix NPD in suspend/resume

Philipp Zabel (5):
      pwm: stm32: Replace write_ccrx with regmap_write
      pwm: stm32: Make ch parameter unsigned
      pwm: stm32: Use hweight32 in stm32_pwm_detect_channels
      pwm: stm32: Implement .get_state()
      pwm: stm32: Fix enable count for clk in .probe()

Rob Herring (1):
      pwm: Use device_get_match_data()

Uwe Kleine-K=F6nig (15):
      pwm: Drop unused member "pwm" from struct pwm_device
      pwm: Replace PWM chip unique base by unique ID
      pwm: Mention PWM chip ID in /sys/kernel/debug/pwm
      pwm: atmel-hlcdc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: atmel-tcb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: berlin: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: imx-tpm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: samsung: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: stm32-lp: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: stm32: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: tiecap: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: tiehrpwm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: cros-ec: Drop unused member from driver private data

 drivers/pwm/core.c            |  71 +++++++++++-----------------
 drivers/pwm/pwm-atmel-hlcdc.c |   8 ++--
 drivers/pwm/pwm-atmel-tcb.c   |   8 ++--
 drivers/pwm/pwm-bcm2835.c     |   2 +
 drivers/pwm/pwm-berlin.c      |   8 ++--
 drivers/pwm/pwm-brcmstb.c     |   8 ++--
 drivers/pwm/pwm-cros-ec.c     |   1 -
 drivers/pwm/pwm-dwc.c         |   6 +--
 drivers/pwm/pwm-img.c         |   8 +---
 drivers/pwm/pwm-imx-tpm.c     |  10 ++--
 drivers/pwm/pwm-rockchip.c    |   9 +---
 drivers/pwm/pwm-samsung.c     |   6 +--
 drivers/pwm/pwm-stm32-lp.c    |  10 ++--
 drivers/pwm/pwm-stm32.c       | 106 ++++++++++++++++++++++++++------------=
----
 drivers/pwm/pwm-tiecap.c      |   6 +--
 drivers/pwm/pwm-tiehrpwm.c    |   8 ++--
 drivers/pwm/sysfs.c           |   2 +-
 include/linux/pwm.h           |   4 +-
 18 files changed, 131 insertions(+), 150 deletions(-)
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cetvuv3um2cbrya7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVcknwACgkQj4D7WH0S
/k4O1Af+Iri55XypFhBRqzeG6HMjRy3iDqCglcA17AdY0crl1b+wu1jUCXrJ5VCo
9JYnzBNoBMjri1RzJCyjNQfeZKCJa39JrsiFIO0LEqBQ9guKXYhS1rF0AD3Lf1Ka
+wk8qsg/2pCmC9Bk3fTm6kG0D/KNH3noTIPFRW82uzghy5q7LBI/2o8hvZbQuM3k
Mu03bGxRwayEIZsXIGj29aDZX+utQNlej0fI48zkx+83j4tdljOYGfXRs/tfIyGE
n/C4QysBIdoZPl8Plw1W0/UoRlAZ+BAiZIDb9bA2Dcd7+XGr0P/GqEZQ5Tbn4Nko
a/IGKkaU3JMaiuWBjNJfGsxDmU5/Jw==
=goHc
-----END PGP SIGNATURE-----

--cetvuv3um2cbrya7--

