Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93537743F9
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjHHSOc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjHHSOA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D292774AFD
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMx-0006mZ-06; Tue, 08 Aug 2023 19:19:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMw-00222m-2N; Tue, 08 Aug 2023 19:19:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMv-00BTAC-DM; Tue, 08 Aug 2023 19:19:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 000/101] pwm: Fix lifetime issues for pwm_chips
Date:   Tue,  8 Aug 2023 19:17:50 +0200
Message-Id: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=14283; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ZcbnveT6WmoAD0m+uSCzBI+4vDldC1npt/cf58G63as=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0niwlPH820fM3vEjAtgQtjNsREQiIOTioIopC BfnQHBoo6WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4sAAKCRCPgPtYfRL+ TvJiB/9e7cd1k+Ct+WOGzY1gD3LvNFveEOIrPGN9u4lTuo6HT0JWT0Q/ea5XFOGOQAIOV+hr2iZ pBCEt3xn/339w3SdsEt5mHEKBgogASzQ73Nxjp4GpRGIFSjadoz+Swm7JEVe+QuHOH0L1mtTXXp gmse7GMdNqgL6kyJfDGazv8aaxeAnZeuSKCJZ1yLCo7icmfRNoT/d7GcO4dvSaBy797YSODiZhs /qfecsajg3S1ogMOtV7BUD0LwJX8x5SFYd/w7rCKu3/VxdJMKzjdYD9LWgCsyxTclQJv085te3o bgxezwtVXZgESO34ubaXW99wOO6O/o0M5orPo5vuZQTETFCx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

this series addresses the issues I reported already earlier to this
list[1]. It is based on pwm/for-next and several patches I already sent
out, too. Maybe some of these have to be reworked (e.g. Thierry already
signalled not to like the patches dropping runtime error messages) but
in the expectation that I will have to create a v2 for this series, too
and it actually fixes a race condition, I sent the patches out for
review anyhow. For the same reason I didn't Cc: all the individual
maintainers.

If you want to actually test I suggest you fetch my complete history
from

	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking

. 

In the end drivers have to allocate their pwm_chip using
pwmchip_alloc(). This is important for the memory backing the pwm_chip
being able to have a longer life than the driver.

The motivation for this series is to prepare the pwm framework to add a
character device for each pwm_chip for easier and faster access to PWMs
from userspace compared to the sysfs API. For such an extension proper
lifetime tracking is important, too, as such a device can still be open
if a PWM disappears.

Have fun
Uwe

[1] https://lore.kernel.org/linux-pwm/20230725211004.peqxxb4y3j62gmnp@pengutronix.de/

Uwe Kleine-König (101):
  pwm: Provide devm_pwmchip_alloc() function
  pwm: ab8500: Make use of devm_pwmchip_alloc() function
  pwm: apple: Make use of devm_pwmchip_alloc() function
  pwm: atmel-hlcdc: Make use of devm_pwmchip_alloc() function
  pwm: atmel: Make use of devm_pwmchip_alloc() function
  pwm: atmel-tcb: Make use of devm_pwmchip_alloc() function
  pwm: bcm2835: Make use of devm_pwmchip_alloc() function
  pwm: bcm-iproc: Make use of devm_pwmchip_alloc() function
  pwm: bcm-kona: Make use of devm_pwmchip_alloc() function
  pwm: berlin: Make use of devm_pwmchip_alloc() function
  pwm: brcmstb: Make use of devm_pwmchip_alloc() function
  pwm: clk: Make use of devm_pwmchip_alloc() function
  pwm: clps711x: Make use of devm_pwmchip_alloc() function
  pwm: crc: Make use of devm_pwmchip_alloc() function
  pwm: cros-ec: Change prototype of helper to prepare further changes
  pwm: cros-ec: Make use of devm_pwmchip_alloc() function
  pwm: dwc: Make use of devm_pwmchip_alloc() function
  pwm: ep93xx: Make use of devm_pwmchip_alloc() function
  pwm: fsl-ftm: Make use of devm_pwmchip_alloc() function
  pwm: hibvt: Make use of devm_pwmchip_alloc() function
  pwm: img: Make use of devm_pwmchip_alloc() function
  pwm: imx1: Make use of devm_pwmchip_alloc() function
  pwm: imx27: Make use of devm_pwmchip_alloc() function
  pwm: imx-tpm: Make use of devm_pwmchip_alloc() function
  pwm: intel-lgm: Make use of devm_pwmchip_alloc() function
  pwm: iqs620a: Make use of devm_pwmchip_alloc() function
  pwm: jz4740: Make use of devm_pwmchip_alloc() function
  pwm: keembay: Make use of devm_pwmchip_alloc() function
  pwm: lp3943: Make use of devm_pwmchip_alloc() function
  pwm: lpc18xx-sct: Make use of devm_pwmchip_alloc() function
  pwm: lpc32xx: Make use of devm_pwmchip_alloc() function
  pwm: lpss-*: Make use of devm_pwmchip_alloc() function
  pwm: mediatek: Make use of devm_pwmchip_alloc() function
  pwm: meson: Make use of devm_pwmchip_alloc() function
  pwm: microchip-core: Make use of devm_pwmchip_alloc() function
  pwm: mtk-disp: Make use of devm_pwmchip_alloc() function
  pwm: mxs: Make use of devm_pwmchip_alloc() function
  pwm: ntxec: Make use of devm_pwmchip_alloc() function
  pwm: omap-dmtimer: Make use of devm_pwmchip_alloc() function
  pwm: pca9685: Make use of devm_pwmchip_alloc() function
  pwm: pxa: Make use of devm_pwmchip_alloc() function
  pwm: raspberrypi-poe: Make use of devm_pwmchip_alloc() function
  pwm: rcar: Make use of devm_pwmchip_alloc() function
  pwm: renesas-tpu: Make use of devm_pwmchip_alloc() function
  pwm: rockchip: Make use of devm_pwmchip_alloc() function
  pwm: rz-mtu3: Make use of devm_pwmchip_alloc() function
  pwm: samsung: Make use of devm_pwmchip_alloc() function
  pwm: sifive: Make use of devm_pwmchip_alloc() function
  pwm: sl28cpld: Make use of devm_pwmchip_alloc() function
  pwm: spear: Make use of devm_pwmchip_alloc() function
  pwm: sprd: Make use of devm_pwmchip_alloc() function
  pwm: sti: Make use of devm_pwmchip_alloc() function
  pwm: stm32-lp: Make use of devm_pwmchip_alloc() function
  pwm: stm32: Make use of devm_pwmchip_alloc() function
  pwm: stmpe: Make use of devm_pwmchip_alloc() function
  pwm: sun4i: Make use of devm_pwmchip_alloc() function
  pwm: sunplus: Make use of devm_pwmchip_alloc() function
  pwm: tegra: Make use of devm_pwmchip_alloc() function
  pwm: tiecap: Make use of devm_pwmchip_alloc() function
  pwm: tiehrpwm: Make use of devm_pwmchip_alloc() function
  pwm: twl-led: Make use of devm_pwmchip_alloc() function
  pwm: twl: Make use of devm_pwmchip_alloc() function
  pwm: visconti: Make use of devm_pwmchip_alloc() function
  pwm: vt8500: Make use of devm_pwmchip_alloc() function
  pwm: xilinx: Make use of devm_pwmchip_alloc() function
  gpio: mvebu: Make use of devm_pwmchip_alloc() function
  drm/bridge: ti-sn65dsi86: Make use of devm_pwmchip_alloc() function
  leds: qcom-lpg: Make use of devm_pwmchip_alloc() function
  staging: greybus: pwm: Make use of devm_pwmchip_alloc() function
  pwm: Ensure a struct pwm have the same lifetime as its pwm_chip
  pwm: ab8500: Store parent device in driver data
  pwm: atmel: Stop using struct pwm_chip::dev
  pwm: dwc: Store parent device in driver data
  pwm: ep93xx: Store parent device in driver data
  pwm: fsl-ftm: Store parent device in driver data
  pwm: img: Make use of parent device pointer in driver data
  pwm: imx27: Store parent device in driver data
  pwm: jz4740: Store parent device in driver data
  pwm: lpc18xx-sct: Make use of parent device pointer in driver data
  pwm: lpss: Store parent device in driver data
  pwm: mediatek: Store parent device in driver data
  pwm: meson: Store parent device in driver data
  pwm: mtk-disp: Store parent device in driver data
  pwm: omap: Store parent device in driver data
  pwm: pca9685: Store parent device in driver data
  pwm: raspberrypi-poe: Store parent device in driver data
  pwm: rcar: Store parent device in driver data
  pwm: rz-mtu3: Make use of parent device pointer in driver data
  pwm: samsung: Store parent device in driver data
  pwm: sifive: Make use of parent device pointer in driver data
  pwm: stm32: Store parent device in driver data
  pwm: stmpe: Store parent device in driver data
  pwm: sun4i: Store parent device in driver data
  pwm: tiecap: Store parent device in driver data
  pwm: tiehrpwm: Store parent device in driver data
  pwm: twl: Store parent device in driver data
  pwm: twl-led: Store parent device in driver data
  pwm: vt8500: Store parent device in driver data
  staging: greybus: pwm: Store parent device in driver data
  pwm: Ensure the memory backing a PWM chip isn't freed while used
  pwm: Add more locking

 .../driver-api/driver-model/devres.rst        |   1 +
 Documentation/driver-api/pwm.rst              |  10 +-
 drivers/gpio/gpio-mvebu.c                     |  18 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c         |  25 ++-
 drivers/leds/rgb/leds-qcom-lpg.c              |  30 ++-
 drivers/pwm/Kconfig                           |   4 -
 drivers/pwm/Makefile                          |   3 +-
 drivers/pwm/core.c                            | 208 +++++++++++++-----
 drivers/pwm/pwm-ab8500.c                      |  34 +--
 drivers/pwm/pwm-apple.c                       |  18 +-
 drivers/pwm/pwm-atmel-hlcdc.c                 |  35 +--
 drivers/pwm/pwm-atmel-tcb.c                   |  24 +-
 drivers/pwm/pwm-atmel.c                       |  31 ++-
 drivers/pwm/pwm-bcm-iproc.c                   |  19 +-
 drivers/pwm/pwm-bcm-kona.c                    |  17 +-
 drivers/pwm/pwm-bcm2835.c                     |  17 +-
 drivers/pwm/pwm-berlin.c                      |  29 +--
 drivers/pwm/pwm-brcmstb.c                     |  17 +-
 drivers/pwm/pwm-clk.c                         |  27 ++-
 drivers/pwm/pwm-clps711x.c                    |  21 +-
 drivers/pwm/pwm-crc.c                         |  23 +-
 drivers/pwm/pwm-cros-ec.c                     |  49 ++---
 drivers/pwm/pwm-dwc.c                         |  54 +++--
 drivers/pwm/pwm-ep93xx.c                      |  28 +--
 drivers/pwm/pwm-fsl-ftm.c                     |  50 +++--
 drivers/pwm/pwm-hibvt.c                       |  25 ++-
 drivers/pwm/pwm-img.c                         |  51 ++---
 drivers/pwm/pwm-imx-tpm.c                     |  34 +--
 drivers/pwm/pwm-imx1.c                        |  17 +-
 drivers/pwm/pwm-imx27.c                       |  28 ++-
 drivers/pwm/pwm-intel-lgm.c                   |  17 +-
 drivers/pwm/pwm-iqs620a.c                     |  37 ++--
 drivers/pwm/pwm-jz4740.c                      |  38 ++--
 drivers/pwm/pwm-keembay.c                     |  17 +-
 drivers/pwm/pwm-lp3943.c                      |  17 +-
 drivers/pwm/pwm-lpc18xx-sct.c                 |  29 ++-
 drivers/pwm/pwm-lpc32xx.c                     |  19 +-
 drivers/pwm/pwm-lpss-pci.c                    |  10 +-
 drivers/pwm/pwm-lpss-platform.c               |  10 +-
 drivers/pwm/pwm-lpss.c                        |  36 +--
 drivers/pwm/pwm-lpss.h                        |   2 +-
 drivers/pwm/pwm-mediatek.c                    |  30 +--
 drivers/pwm/pwm-meson.c                       |  59 ++---
 drivers/pwm/pwm-microchip-core.c              |  17 +-
 drivers/pwm/pwm-mtk-disp.c                    |  27 +--
 drivers/pwm/pwm-mxs.c                         |  32 +--
 drivers/pwm/pwm-ntxec.c                       |  30 ++-
 drivers/pwm/pwm-omap-dmtimer.c                |  48 ++--
 drivers/pwm/pwm-pca9685.c                     |  44 ++--
 drivers/pwm/pwm-pxa.c                         |  21 +-
 drivers/pwm/pwm-raspberrypi-poe.c             |  22 +-
 drivers/pwm/pwm-rcar.c                        |  28 +--
 drivers/pwm/pwm-renesas-tpu.c                 |  18 +-
 drivers/pwm/pwm-rockchip.c                    |  24 +-
 drivers/pwm/pwm-rz-mtu3.c                     |  35 +--
 drivers/pwm/pwm-samsung.c                     |  56 ++---
 drivers/pwm/pwm-sifive.c                      |  30 +--
 drivers/pwm/pwm-sl28cpld.c                    |  13 +-
 drivers/pwm/pwm-spear.c                       |  17 +-
 drivers/pwm/pwm-sprd.c                        |  50 ++---
 drivers/pwm/pwm-sti.c                         |  34 +--
 drivers/pwm/pwm-stm32-lp.c                    |  23 +-
 drivers/pwm/pwm-stm32.c                       |  46 ++--
 drivers/pwm/pwm-stmpe.c                       |  64 +++---
 drivers/pwm/pwm-sun4i.c                       |  39 ++--
 drivers/pwm/pwm-sunplus.c                     |  17 +-
 drivers/pwm/pwm-tegra.c                       |  27 ++-
 drivers/pwm/pwm-tiecap.c                      |  57 ++---
 drivers/pwm/pwm-tiehrpwm.c                    |  70 +++---
 drivers/pwm/pwm-twl-led.c                     |  62 +++---
 drivers/pwm/pwm-twl.c                         |  52 ++---
 drivers/pwm/pwm-visconti.c                    |  17 +-
 drivers/pwm/pwm-vt8500.c                      |  24 +-
 drivers/pwm/pwm-xilinx.c                      |  34 ++-
 drivers/pwm/sysfs.c                           |  45 +---
 drivers/staging/greybus/pwm.c                 |  80 ++-----
 include/linux/platform_data/x86/pwm-lpss.h    |   4 +-
 include/linux/pwm.h                           |  24 +-
 78 files changed, 1310 insertions(+), 1189 deletions(-)


base-commit: 3ccb179aa40d931eb00ef8910d7b812a95659563
prerequisite-patch-id: cc42495033fc6c784c3139f92610cc9deeb2d87e
prerequisite-patch-id: c3fb50527e1bdd0c63ffba939d24d9d347470bb6
prerequisite-patch-id: f3333980376bf2207e993d0714845f3301c86e2e
prerequisite-patch-id: b30ff565416aab449c4e14fbd6535cad52f61096
prerequisite-patch-id: bea14e240bcd525e2fd1256882e645491624f8c6
prerequisite-patch-id: cd271964ea5243e89857030e28c3e0046ae64bd9
prerequisite-patch-id: 143c8d917c67280ec8cc8465e1a8dce8f7f77618
prerequisite-patch-id: 369332bf9747e4702010d08b45eaa72496cef9ec
prerequisite-patch-id: 2df33999582eeaf1cd2a5c805b989c969577ca0c
prerequisite-patch-id: e8dad0c65b1deb6f8cd7ea2a5a08b3ab2cb2e291
prerequisite-patch-id: b540c7ef3ea7add5e54a65f480daff3018735fd3
prerequisite-patch-id: 72247967f924911ad08210638853d3d3b3d5d278
prerequisite-patch-id: 313ada72ab57438a8d54df0df9c0926bb4f69b36
prerequisite-patch-id: 318824c08f3e7d6500e3c5a47a11c5daffaea34a
prerequisite-patch-id: 921e5b577da74b4f1b666c433e182ddd3cb7e854
prerequisite-patch-id: 4e608e07dc1adf781f21274e37b72fa528b8c60a
prerequisite-patch-id: 9abd8b16e74625e2630655da7d22e75bbe0c6231
prerequisite-patch-id: 7a0daa2918f8a317333e57c1d1698078a1968720
prerequisite-patch-id: a0c8d63424241e64c3e5f9991ea04018a51fcc94
prerequisite-patch-id: 2cae8f054048b5074ed99163e476bee87cd9b7ef
prerequisite-patch-id: 8f6f3e08d426c4d349e93f5fdb3650efcd523299
prerequisite-patch-id: f7dd05d650cd2b4368ec1ce9f7db1716841a72d8
prerequisite-patch-id: e4abcc7c18f6cc49d3d4b4221cd3856189ec71d8
prerequisite-patch-id: 67e046597429677c0bfa48bb044aac39fdcc9eb2
prerequisite-patch-id: 02694b208c763f5dac10bce135cd43a7d50d979f
prerequisite-patch-id: 4317fa5ef50613649e319fff57bb507dab10909d
prerequisite-patch-id: 1483ab31d5f3f7504dda11b5f4660022152f6e88
prerequisite-patch-id: da542cefd47056ad9f5b6fd57b5218437ba7025b
prerequisite-patch-id: 9cded674bc2c8c1a899f6da498b372ae599a7e72
prerequisite-patch-id: 25c85a2b73850671bb4bc970472cfc4c1f9f59f5
prerequisite-patch-id: 07a107646a7f974ff11acb7cd08db31d6dd8f254
prerequisite-patch-id: fdf3805aa0c2f6b7bd250673755936668db6cd4a
prerequisite-patch-id: 13386aad0b7b3f163e27bcb450e9e4c8f42630d2
prerequisite-patch-id: 5b55d44ff77e37c24646bbbee4feb8adbdccfcf7
prerequisite-patch-id: 1fe585c132c1d850e573257fe30f07a7789a235f
prerequisite-patch-id: 027a0eff436112b5c76d5c50aca6eced6ace4355
prerequisite-patch-id: a4068519ff48d7e157d59d77e99b1d95fe33a987
prerequisite-patch-id: 83665e92c2a6d2b40675330bae4bcb9b4f695e48
prerequisite-patch-id: 032d7d39b0111ddc4791a1892348be5fabb1e83b
-- 
2.40.1

