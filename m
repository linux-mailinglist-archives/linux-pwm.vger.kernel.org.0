Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282F7640D59
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Dec 2022 19:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiLBSfK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Dec 2022 13:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiLBSfJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Dec 2022 13:35:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1699EC833
        for <linux-pwm@vger.kernel.org>; Fri,  2 Dec 2022 10:35:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1AsN-0007xb-2s; Fri, 02 Dec 2022 19:35:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1AsL-001rNT-DE; Fri, 02 Dec 2022 19:35:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1AsL-0026WH-AM; Fri, 02 Dec 2022 19:35:05 +0100
Date:   Fri, 2 Dec 2022 19:35:04 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PULL] pwm changes for 6.2 for Thierry
Message-ID: <20221202183504.rhz5meomd4a4t7am@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ubsz3k3zyjk22pan"
Content-Disposition: inline
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


--ubsz3k3zyjk22pan
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

there are quite some patches still marked as "new" in our patchwork and
a bit part of them is ready in my eyes on top of your for-next branch.
Given that Linus Torvalds indicated to want the pull requests for 6.2
ready early[1] I thought I collect the patches I consider good for
application.

Feel free to do whatever you want with this pull request. If you find
the time to pick up patches yourself that's just fine for me. And in
case Linus doesn't to a -rc8 but cuts 6.1 this weekend, we have at least
a tree with non-faked timestamps older than the v6.1 tag. :-)

One thing I considered was pulling in Andy's PR[2], just to have it.
But I didn't as you signalled it to be not necessary. (And it merges
just fine into the changes from this PR.)

Best regards and a nice week-end
Uwe

[1] https://lore.kernel.org/lkml/CAHk-=3DwgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16VK=
oqL7Ok9vv7g@mail.gmail.com/
[2] https://lore.kernel.org/linux-pwm/Y30YOvHpqvte9otX@black.fi.intel.com

The following changes since commit 50315945d178eebec4e8e2c50c265767ddb926eb:

  dt-bindings: pwm: renesas,tpu: Add r8a779g0 support (2022-11-23 12:22:35 =
+0100)

are available in the Git repository at:

  https://git.pengutronix.de/git/ukl/linux pwm-6.2

for you to fetch changes up to 145e5425eb85fc833d4b5d983cffa9ef1acd6c16:

  pwm: pca9685: Convert to i2c's .probe_new() (2022-12-02 19:16:30 +0100)

----------------------------------------------------------------
Andre Przywara (1):
      pwm: sun4i: Propagate errors in .get_state() to the caller

Andy Shevchenko (1):
      pwm: core: Remove S_IFREG from debugfs_create_file()

Daniel Golle (2):
      pwm: mediatek: always use bus clock for PWM on MT7622
      pwm: mediatek: Add support for MT7986

Doug Brown (6):
      pwm: pxa: Remove pxa_pwm_enable/disable
      pwm: pxa: Set duty cycle to 0 when disabling PWM
      pwm: pxa: Remove clk enable/disable from pxa_pwm_config
      pwm: pxa: Use abrupt shutdown mode
      pwm: pxa: Add reference manual link and limitations
      pwm: pxa: Enable for MMP platform

Fabrice Gasnier (1):
      pwm: stm32-lp: fix the check on arr and cmp registers update

Uwe Kleine-K=F6nig (23):
      pwm: sifive: Call pwm_sifive_update_clock() while mutex is held
      pwm: lpc18xx-sct: Fix a comment to match code
      pwm: Document variables protected by pwm_lock
      pwm: Reduce time the pwm_lock mutex is held in pwmchip_add()
      pwm: Mark free pwm IDs as used in alloc_pwms()
      pwm: Don't initialize list head before calling list_add()
      pwm: fsl-ftm: Use regmap_clear_bits and regmap_set_bits where applica=
ble
      pwm: img: Use regmap_clear_bits and regmap_set_bits where applicable
      pwm: iqs620a: Use regmap_clear_bits and regmap_set_bits where applica=
ble
      pwm: stm32-lp: Use regmap_clear_bits and regmap_set_bits where applic=
able
      pwm: stm32: Use regmap_clear_bits and regmap_set_bits where applicable
      pwm: Make .get_state() callback return an error code
      pwm/tracing: Also record trace events for failed API calls
      drm/bridge: ti-sn65dsi86: Propagate errors in .get_state() to the cal=
ler
      leds: qcom-lpg: Propagate errors in .get_state() to the caller
      pwm: crc: Propagate errors in .get_state() to the caller
      pwm: cros-ec: Propagate errors in .get_state() to the caller
      pwm: imx27: Propagate errors in .get_state() to the caller
      pwm: mtk-disp: Propagate errors in .get_state() to the caller
      pwm: rockchip: Propagate errors in .get_state() to the caller
      pwm: sprd: Propagate errors in .get_state() to the caller
      pwm: Handle .get_state() failures
      pwm: pca9685: Convert to i2c's .probe_new()

xinlei lee (1):
      pwm: mtk-disp: Fix the parameters calculated by the enabled flag of d=
isp_pwm

 drivers/gpio/gpio-mvebu.c             |  9 ++++++---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 14 ++++++++------
 drivers/leds/rgb/leds-qcom-lpg.c      | 14 ++++++++------
 drivers/pwm/Kconfig                   |  2 +-
 drivers/pwm/core.c                    | 68 +++++++++++++++++++++++++++++++=
+++++++------------------------------
 drivers/pwm/pwm-atmel.c               |  6 ++++--
 drivers/pwm/pwm-bcm-iproc.c           |  8 +++++---
 drivers/pwm/pwm-crc.c                 | 10 ++++++----
 drivers/pwm/pwm-cros-ec.c             |  8 +++++---
 drivers/pwm/pwm-dwc.c                 |  6 ++++--
 drivers/pwm/pwm-fsl-ftm.c             | 18 +++++++-----------
 drivers/pwm/pwm-hibvt.c               |  6 ++++--
 drivers/pwm/pwm-img.c                 | 15 +++++++--------
 drivers/pwm/pwm-imx-tpm.c             |  8 +++++---
 drivers/pwm/pwm-imx27.c               |  8 +++++---
 drivers/pwm/pwm-intel-lgm.c           |  6 ++++--
 drivers/pwm/pwm-iqs620a.c             | 10 ++++++----
 drivers/pwm/pwm-keembay.c             |  6 ++++--
 drivers/pwm/pwm-lpc18xx-sct.c         |  2 +-
 drivers/pwm/pwm-lpss.c                |  6 ++++--
 drivers/pwm/pwm-mediatek.c            |  9 ++++++++-
 drivers/pwm/pwm-meson.c               |  8 +++++---
 drivers/pwm/pwm-mtk-disp.c            | 17 ++++++++++-------
 drivers/pwm/pwm-pca9685.c             | 13 +++++++------
 drivers/pwm/pwm-pxa.c                 | 58 +++++++++++++++++++++++++------=
---------------------------
 drivers/pwm/pwm-raspberrypi-poe.c     |  8 +++++---
 drivers/pwm/pwm-rockchip.c            | 12 +++++++-----
 drivers/pwm/pwm-sifive.c              | 11 ++++++++---
 drivers/pwm/pwm-sl28cpld.c            |  8 +++++---
 drivers/pwm/pwm-sprd.c                |  8 +++++---
 drivers/pwm/pwm-stm32-lp.c            | 15 ++++++++-------
 drivers/pwm/pwm-stm32.c               | 34 ++++++++++++++++---------------=
---
 drivers/pwm/pwm-sun4i.c               | 14 +++++++++-----
 drivers/pwm/pwm-sunplus.c             |  6 ++++--
 drivers/pwm/pwm-visconti.c            |  6 ++++--
 drivers/pwm/pwm-xilinx.c              |  8 +++++---
 include/linux/pwm.h                   |  4 ++--
 include/trace/events/pwm.h            | 20 ++++++++++----------
 38 files changed, 275 insertions(+), 214 deletions(-)


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ubsz3k3zyjk22pan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOKRVUACgkQwfwUeK3K
7AnpPwgAk/WGdoinlv/xV84PXZbDHMp9zzCSIAd5TuryfBQpAo4PX7kJwrkpZgML
3GyX+Fbbmh8IsprOEGBagosbtO9a8fugc5wSaG+mv/x5lvTMAaZTjZGpidMNoVny
d+vUVNEp8DKElTi5aZit1eO9Xf9/DkDip+XY17UZyuXFQi0ukHgjgfGDOjz2kcHH
xu8Ez+vBGF0c9JQaUq0z0BuLyzXwPIf6yglhjYW852c+FWel9eBei3JTe5bMaRMF
1cz8iHcNVawOURlM1CG2mhgJo4O/kyvPJ3CVA+dGpBNq9yGf603ELCFv0+vRyWCQ
X2h3r0H9J+NGJaRsCbxD89E45y7ARg==
=XD2D
-----END PGP SIGNATURE-----

--ubsz3k3zyjk22pan--
