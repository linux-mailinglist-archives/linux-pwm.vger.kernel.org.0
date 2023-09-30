Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2787B43B5
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Sep 2023 23:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjI3VIH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Sep 2023 17:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjI3VIG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Sep 2023 17:08:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0995DD
        for <linux-pwm@vger.kernel.org>; Sat, 30 Sep 2023 14:08:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmhBy-00015a-Az; Sat, 30 Sep 2023 23:08:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmhBv-00A86h-DZ; Sat, 30 Sep 2023 23:07:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmhBv-006f0F-21; Sat, 30 Sep 2023 23:07:59 +0200
Date:   Sat, 30 Sep 2023 23:07:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Ruan Jinjie <ruanjinjie@huawei.com>, kernel@pengutronix.de
Subject: [PULL] pwm: Changes for v6.7-rc1
Message-ID: <20230930210758.urhdzkgczpabfsnh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g4bauaplsfc7s4cy"
Content-Disposition: inline
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


--g4bauaplsfc7s4cy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

I started picking patches from the mailing list that I consider ready to
go in. I was unsure if I should include my big series fixing the
lifetime issues I identified. However deciding that was simple as it
depends on patch "drm/ssd130x: Print the PWM's label instead of its
number" which currently waits as 84f54d4966f4 in drm-misc/next and I
neither wanted to duplicate this patch nor merge in drm-misc/next
(including the needed coordination). I'll rebase after the next merge
window.

In the hope this effort is helpful for you and I didn't pick a patch
that you would have refused, you can find my patch stack based on
commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

in the Git repository at:

  https://git.pengutronix.de/git/ukl/linux tags/pwm/for-thierry-6.7-rc1

for you to fetch up to a8b048b7fd94376ec66ec760f034e04c7e38384c:

  pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_err_probe() (2023=
-09-30 22:02:44 +0200)

to be added to your for-next branch.

Thanks to Ben Dooks, Conor Dooley, Fabio Estevam and Ruan Jinjie for
their contributions.

----------------------------------------------------------------
pwm patches targeting 6.7-rc1

This contains several patches from the list that IMHO should go in
during the next merge window. The highlight is that pwm_set_chip_data()
and pwm_get_chip_data() were dropped after all drivers stopped using
these functions. Their semantic was similar to dev_set_drvdata() and
dev_get_drvdata() but they had the confusing property to get cleared by
pwm_put().

Also contained is the first few patches by Ben Dooks of his series to
add device-tree support for the dwc driver.

The remainder consists mainly of cleanups, simplifications and
documentation updates.

----------------------------------------------------------------
Ben Dooks (3):
      pwm: dwc: split pci out of core driver
      pwm: dwc: make timer clock configurable
      pwm: dwc: add PWM bit unset in get_state call

Conor Dooley (1):
      pwm: microchip-core: convert SOC_MICROCHIP_POLARFIRE to ARCH_MICROCHI=
P_POLARFIRE

Fabio Estevam (2):
      dt-bindings: pwm: mxs: Document fsl,imx28-pwm
      dt-bindings: pwm: mxs: Document the clocks property

Ruan Jinjie (2):
      pwm: atmel: Remove redundant of_match_ptr()
      pwm: omap-dmtimer: Remove redundant of_match_ptr()

Uwe Kleine-K=F6nig (24):
      pwm: jz4740: Consistently name driver data "jz"
      pwm: Manage owner assignment implicitly for drivers
      pwm: crc: Allow compilation as module and with COMPILE_TEST
      pwm: berlin: Put per-channel config into driver data
      pwm: samsung: Put per-channel data into driver data
      pwm: jz4740: Put per-channel clk into driver data
      pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
      pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
      pwm: sti: Reduce number of allocations and drop usage of chip_data
      pwm: cros-ec: Put per-channel data into driver data
      pwm: Drop pwm_[sg]et_chip_data()
      pwm: berlin: Simplify using devm functions
      pwm: Adapt sysfs API documentation to reality
      pwm: bcm-iproc: Simplify using devm functions
      pwm: bcm2835: Simplify using devm functions
      pwm: brcmstb: Simplify using devm functions
      pwm: imx-tpm: Simplify using devm functions
      pwm: mtk-disp: Simplify using devm_pwmchip_add()
      pwm: spear: Simplify using devm functions
      pwm: sprd: Provide a helper to cast a chip to driver data
      pwm: sprd: Simplify using devm_pwmchip_add() and dev_err_probe()
      pwm: vt8500: Simplify using devm functions
      pwm: samsung: Consistently use the same name for driver data
      pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_err_probe()

 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml |  13 +-
 Documentation/driver-api/pwm.rst                   |   6 +-
 drivers/gpio/gpio-mvebu.c                          |   1 -
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   1 -
 drivers/leds/rgb/leds-qcom-lpg.c                   |   1 -
 drivers/pwm/Kconfig                                |  20 ++-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  55 ++----
 drivers/pwm/pwm-ab8500.c                           |   1 -
 drivers/pwm/pwm-apple.c                            |   1 -
 drivers/pwm/pwm-atmel-hlcdc.c                      |   1 -
 drivers/pwm/pwm-atmel-tcb.c                        |   1 -
 drivers/pwm/pwm-atmel.c                            |   3 +-
 drivers/pwm/pwm-bcm-iproc.c                        |  38 +---
 drivers/pwm/pwm-bcm-kona.c                         |   1 -
 drivers/pwm/pwm-bcm2835.c                          |  28 +--
 drivers/pwm/pwm-berlin.c                           |  63 ++-----
 drivers/pwm/pwm-brcmstb.c                          |  43 +----
 drivers/pwm/pwm-clk.c                              |   1 -
 drivers/pwm/pwm-clps711x.c                         |   1 -
 drivers/pwm/pwm-crc.c                              |   5 +-
 drivers/pwm/pwm-cros-ec.c                          |  67 ++-----
 drivers/pwm/pwm-dwc-core.c                         | 184 +++++++++++++++++=
++
 drivers/pwm/pwm-dwc.c                              | 197 +----------------=
----
 drivers/pwm/pwm-dwc.h                              |  60 +++++++
 drivers/pwm/pwm-ep93xx.c                           |   1 -
 drivers/pwm/pwm-fsl-ftm.c                          |   1 -
 drivers/pwm/pwm-hibvt.c                            |   1 -
 drivers/pwm/pwm-img.c                              |   1 -
 drivers/pwm/pwm-imx-tpm.c                          |  30 +---
 drivers/pwm/pwm-imx1.c                             |   1 -
 drivers/pwm/pwm-imx27.c                            |   1 -
 drivers/pwm/pwm-intel-lgm.c                        |   1 -
 drivers/pwm/pwm-iqs620a.c                          |   1 -
 drivers/pwm/pwm-jz4740.c                           |  46 ++---
 drivers/pwm/pwm-keembay.c                          |   1 -
 drivers/pwm/pwm-lp3943.c                           |  22 +--
 drivers/pwm/pwm-lpc18xx-sct.c                      |   1 -
 drivers/pwm/pwm-lpc32xx.c                          |   1 -
 drivers/pwm/pwm-lpss.c                             |   1 -
 drivers/pwm/pwm-mediatek.c                         |   1 -
 drivers/pwm/pwm-meson.c                            |   1 -
 drivers/pwm/pwm-microchip-core.c                   |   1 -
 drivers/pwm/pwm-mtk-disp.c                         |  25 +--
 drivers/pwm/pwm-mxs.c                              |   1 -
 drivers/pwm/pwm-ntxec.c                            |   1 -
 drivers/pwm/pwm-omap-dmtimer.c                     |   3 +-
 drivers/pwm/pwm-pca9685.c                          |   1 -
 drivers/pwm/pwm-pxa.c                              |   1 -
 drivers/pwm/pwm-raspberrypi-poe.c                  |   1 -
 drivers/pwm/pwm-rcar.c                             |   1 -
 drivers/pwm/pwm-renesas-tpu.c                      |  23 ++-
 drivers/pwm/pwm-rockchip.c                         |   1 -
 drivers/pwm/pwm-rz-mtu3.c                          |   1 -
 drivers/pwm/pwm-samsung.c                          | 151 ++++++++--------
 drivers/pwm/pwm-sifive.c                           |   1 -
 drivers/pwm/pwm-sl28cpld.c                         |   1 -
 drivers/pwm/pwm-spear.c                            |  41 ++---
 drivers/pwm/pwm-sprd.c                             |  29 ++-
 drivers/pwm/pwm-sti.c                              |  30 ++--
 drivers/pwm/pwm-stm32-lp.c                         |   1 -
 drivers/pwm/pwm-stm32.c                            |   1 -
 drivers/pwm/pwm-stmpe.c                            |   1 -
 drivers/pwm/pwm-sun4i.c                            |   1 -
 drivers/pwm/pwm-sunplus.c                          |   1 -
 drivers/pwm/pwm-tegra.c                            |   1 -
 drivers/pwm/pwm-tiecap.c                           |   1 -
 drivers/pwm/pwm-tiehrpwm.c                         |   1 -
 drivers/pwm/pwm-twl-led.c                          |   2 -
 drivers/pwm/pwm-twl.c                              |   2 -
 drivers/pwm/pwm-visconti.c                         |   1 -
 drivers/pwm/pwm-vt8500.c                           |  43 +----
 drivers/pwm/pwm-xilinx.c                           |   1 -
 drivers/staging/greybus/pwm.c                      |   1 -
 include/linux/pwm.h                                |  24 +--
 75 files changed, 521 insertions(+), 779 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-core.c
 create mode 100644 drivers/pwm/pwm-dwc.h

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g4bauaplsfc7s4cy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUYji4ACgkQj4D7WH0S
/k4Ptgf/U13MRD92fKMGA+c6DVVWIxl88NdtIzfbovf9z5DYwcfredlLO7AsGghm
b2MjUwM0HkO8urveQyjP3O2u4FXJv1ZRABY7c2htC4nDyhbVvL5vYGjNAKZ/ssd+
1cMD5ofjNjiNkjqc0hVakPDUCC9mMHG6MHeXI+qU9Zk14M2cMF0SDS8UCuarZWuM
W3C+cu7inyJa4zbBXhFIlgOaaklG+v9WdxCwTSwKQe9F3snlaUf2Haikl8+JxqL8
8KcPfkRusr5/4uRtPESiadwVnyXfwF6FuE37pfdEmvljpy2+wEM4z4oWrrfSttHf
TMTKra1IPJEBm5JY49BtHHehPw1cEg==
=iiPk
-----END PGP SIGNATURE-----

--g4bauaplsfc7s4cy--
