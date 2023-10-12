Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9337C72AE
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379615AbjJLQbE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379497AbjJLQa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F932A9
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-0004fk-Kq; Thu, 12 Oct 2023 18:30:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-001C5H-5U; Thu, 12 Oct 2023 18:30:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaI-00F5M7-SS; Thu, 12 Oct 2023 18:30:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 000/109] pwm: Fix lifetime issues for pwm_chips
Date:   Thu, 12 Oct 2023 18:28:28 +0200
Message-ID: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=15383; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ovIaDT8nX8zG8ZiRFszLjXSdRIX2d1O/PVTzRy9C3ns=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB6sNFdEXRuDHqY4hZZqKSa0p/zJk+SOTCXQO 3lR0KXWH9yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgerAAKCRCPgPtYfRL+ TkmaB/wPSHhSqG9a6v9+gb/YDyXUGUL6o7IS2CucN+MbafUCVfLg0MvU0VXlZg+JxdD3kD75Bbr xYc02ZAnOS07DgK5otYUwVq9bhTPFI46obPKC30Lyz4rd++Z37EiLSSV2Pdxwzg4yZ9lThcTHg8 rT98FZifmI9Z0HWba/PgtdRy4IpOrN2GPDKzqFUbj/+USbUgV4iVtRLvlH2Dw+yxfnu4R9uSnrO peqASdoRCVTv9Gc6CnlqpGjFXoaLnuQ7JMO505kekBSHXzuvH+VEwV4i9j2Rfk6+dQcsyt4Sf/O kcOg3/qhqt5MSrZcznENf3Ty8CzzZD8dPzk8QXudvPpFy/d1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
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

Hello,

this is v2 of my series to address the lifetime issues I reported to
this list[1]. It's still unclear to me if this is a shortcoming of
devlinks (only).

For PWM character devices such a clean up is needed for sure as a PWM
driver being unloaded must not result in killing userspace processes
(while removing consumer devices is the status quo).

This series is available at

	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking

including its dependencies of cleanup patches that were sent separately
to the linux-pwm list.

I hope I addressed all review comments, the major changes are:

 - rebase on Thierry's for-next branch
 - Drop the patches that add extra parent pointers to driver data and
   introduce a gpiochip_parent macro instead. Adding this macro and
   adapting the affected drivers is done in one patch each. Thierry
   already wrote he'd prefer to reduce the amount of easy patches. We
   can still squash patches together but separating them is a bit more
   complex, so here comes the series with split patches.
 - Another patch "pwm: Ensure that pwm_chips are allocated using
   pwmchip_alloc()" to catch drivers that were not converted to
   pwmchip_alloc() at register time with a error instead of later with a
   memory corruption. (Affects only oot drivers as I converted all
   in-tree drivers.)
 - use per-chip lock to serialize .apply() calls and chip unbinding.
   This is also a bit prepared to introduce atomic pwm_apply_state()
   calls for (e.g.) pwm-ir-tx.
 - The last patch contains my current WIP state for /dev/pwmchipX
   support. The companion lib can be found at

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git/

   I consider this lib experimental (at least) until the pwmchip char
   dev gets into mainline. So use at your own peril.

   In the last performance tests, 50000 pwm_apply_state operations took
   0.85s via the character device on stm32 while the same took 4.14s via
   /sys/class/pwm.

As before I didn't Cc: all the individual maintainers in the expectation
that I'll need another feedback-adapt-resend round anyhow.

Best regards
Uwe


[1] https://lore.kernel.org/linux-pwm/20230725211004.peqxxb4y3j62gmnp@pengutronix.de/

Uwe Kleine-König (109):
  pwm: cros-ec: Change prototype of helper to prepare further changes
  pwm: Provide a macro to get the parent device of a given chip
  pwm: ab8500: Make use of pwmchip_parent() macro
  pwm: atmel: Make use of pwmchip_parent() macro
  pwm: atmel-tcb: Make use of pwmchip_parent() macro
  pwm: bcm-kona: Make use of pwmchip_parent() macro
  pwm: crc: Make use of pwmchip_parent() macro
  pwm: cros-ec: Make use of pwmchip_parent() macro
  pwm: cros-ec: Drop unused member from driver private data
  pwm: dwc: Make use of pwmchip_parent() macro
  pwm: ep93xx: Make use of pwmchip_parent() macro
  pwm: fsl-ftm: Make use of pwmchip_parent() macro
  pwm: img: Make use of parent device pointer in driver data
  pwm: imx27: Make use of pwmchip_parent() macro
  pwm: jz4740: Make use of pwmchip_parent() macro
  pwm: lpc18xx-sct: Make use of parent device pointer in driver data
  pwm: lpss: Make use of pwmchip_parent() macro
  pwm: mediatek: Make use of pwmchip_parent() macro
  pwm: meson: Make use of pwmchip_parent() macro
  pwm: mtk-disp: Make use of pwmchip_parent() macro
  pwm: omap: Make use of pwmchip_parent() macro
  pwm: pca9685: Store parent device in driver data
  pwm: raspberrypi-poe: Make use of pwmchip_parent() macro
  pwm: rcar: Make use of pwmchip_parent() macro
  pwm: rz-mtu3: Make use of pwmchip_parent() macro
  pwm: samsung: Make use of pwmchip_parent() macro
  pwm: sifive: Make use of parent device pointer in driver data
  pwm: stm32-lp: Make use of pwmchip_parent() macro
  pwm: stm32: Make use of pwmchip_parent() macro
  pwm: stmpe: Make use of pwmchip_parent() macro
  pwm: sun4i: Make use of pwmchip_parent() macro
  pwm: tiecap: Make use of pwmchip_parent() macro
  pwm: tiehrpwm: Make use of pwmchip_parent() macro
  pwm: twl-led: Make use of pwmchip_parent() macro
  pwm: twl: Make use of pwmchip_parent() macro
  pwm: vt8500: Make use of pwmchip_parent() macro
  staging: greybus: pwm: Make use of pwmchip_parent() macro
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
  pwm: twl-led: Make use of devm_pwmchip_alloc() function
  pwm: twl: Make use of devm_pwmchip_alloc() function
  pwm: visconti: Make use of devm_pwmchip_alloc() function
  pwm: vt8500: Make use of devm_pwmchip_alloc() function
  pwm: xilinx: Make use of devm_pwmchip_alloc() function
  gpio: mvebu: Make use of devm_pwmchip_alloc() function
  drm/bridge: ti-sn65dsi86: Make use of devm_pwmchip_alloc() function
  leds: qcom-lpg: Make use of devm_pwmchip_alloc() function
  staging: greybus: pwm: Make use of devm_pwmchip_alloc() function
  pwm: Ensure that pwm_chips are allocated using pwmchip_alloc()
  pwm: Ensure a struct pwm has the same lifetime as its pwm_chip
  pwm: Ensure the memory backing a PWM chip isn't freed while used
  pwm: Add more locking
  WIP: pwm: Add support for pwmchip devices for faster and easier
    userspace access

 .../driver-api/driver-model/devres.rst        |   1 +
 Documentation/driver-api/pwm.rst              |  10 +-
 drivers/gpio/gpio-mvebu.c                     |  18 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c         |  25 +-
 drivers/leds/rgb/leds-qcom-lpg.c              |  30 +-
 drivers/pwm/Kconfig                           |   4 -
 drivers/pwm/Makefile                          |   3 +-
 drivers/pwm/core.c                            | 429 +++++++++++++++---
 drivers/pwm/pwm-ab8500.c                      |  36 +-
 drivers/pwm/pwm-apple.c                       |  18 +-
 drivers/pwm/pwm-atmel-hlcdc.c                 |  35 +-
 drivers/pwm/pwm-atmel-tcb.c                   |  26 +-
 drivers/pwm/pwm-atmel.c                       |  37 +-
 drivers/pwm/pwm-bcm-iproc.c                   |  19 +-
 drivers/pwm/pwm-bcm-kona.c                    |  21 +-
 drivers/pwm/pwm-bcm2835.c                     |  17 +-
 drivers/pwm/pwm-berlin.c                      |  29 +-
 drivers/pwm/pwm-brcmstb.c                     |  17 +-
 drivers/pwm/pwm-clk.c                         |  27 +-
 drivers/pwm/pwm-clps711x.c                    |  21 +-
 drivers/pwm/pwm-crc.c                         |  26 +-
 drivers/pwm/pwm-cros-ec.c                     |  52 +--
 drivers/pwm/pwm-dwc-core.c                    |  25 +-
 drivers/pwm/pwm-dwc.c                         |  18 +-
 drivers/pwm/pwm-dwc.h                         |   9 +-
 drivers/pwm/pwm-ep93xx.c                      |  21 +-
 drivers/pwm/pwm-fsl-ftm.c                     |  48 +-
 drivers/pwm/pwm-hibvt.c                       |  25 +-
 drivers/pwm/pwm-img.c                         |  51 ++-
 drivers/pwm/pwm-imx-tpm.c                     |  34 +-
 drivers/pwm/pwm-imx1.c                        |  17 +-
 drivers/pwm/pwm-imx27.c                       |  26 +-
 drivers/pwm/pwm-intel-lgm.c                   |  17 +-
 drivers/pwm/pwm-iqs620a.c                     |  37 +-
 drivers/pwm/pwm-jz4740.c                      |  35 +-
 drivers/pwm/pwm-keembay.c                     |  17 +-
 drivers/pwm/pwm-lp3943.c                      |  17 +-
 drivers/pwm/pwm-lpc18xx-sct.c                 |  35 +-
 drivers/pwm/pwm-lpc32xx.c                     |  19 +-
 drivers/pwm/pwm-lpss-pci.c                    |  10 +-
 drivers/pwm/pwm-lpss-platform.c               |  10 +-
 drivers/pwm/pwm-lpss.c                        |  34 +-
 drivers/pwm/pwm-lpss.h                        |   1 -
 drivers/pwm/pwm-mediatek.c                    |  28 +-
 drivers/pwm/pwm-meson.c                       |  57 +--
 drivers/pwm/pwm-microchip-core.c              |  17 +-
 drivers/pwm/pwm-mtk-disp.c                    |  25 +-
 drivers/pwm/pwm-mxs.c                         |  32 +-
 drivers/pwm/pwm-ntxec.c                       |  30 +-
 drivers/pwm/pwm-omap-dmtimer.c                |  46 +-
 drivers/pwm/pwm-pca9685.c                     |  98 ++--
 drivers/pwm/pwm-pxa.c                         |  21 +-
 drivers/pwm/pwm-raspberrypi-poe.c             |  20 +-
 drivers/pwm/pwm-rcar.c                        |  25 +-
 drivers/pwm/pwm-renesas-tpu.c                 |  18 +-
 drivers/pwm/pwm-rockchip.c                    |  24 +-
 drivers/pwm/pwm-rz-mtu3.c                     |  38 +-
 drivers/pwm/pwm-samsung.c                     |  56 +--
 drivers/pwm/pwm-sifive.c                      |  32 +-
 drivers/pwm/pwm-sl28cpld.c                    |  13 +-
 drivers/pwm/pwm-spear.c                       |  17 +-
 drivers/pwm/pwm-sprd.c                        |  50 +-
 drivers/pwm/pwm-sti.c                         |  34 +-
 drivers/pwm/pwm-stm32-lp.c                    |  29 +-
 drivers/pwm/pwm-stm32.c                       |  53 ++-
 drivers/pwm/pwm-stmpe.c                       |  58 +--
 drivers/pwm/pwm-sun4i.c                       |  38 +-
 drivers/pwm/pwm-sunplus.c                     |  17 +-
 drivers/pwm/pwm-tegra.c                       |  27 +-
 drivers/pwm/pwm-tiecap.c                      |  55 +--
 drivers/pwm/pwm-tiehrpwm.c                    |  72 +--
 drivers/pwm/pwm-twl-led.c                     |  58 +--
 drivers/pwm/pwm-twl.c                         |  50 +-
 drivers/pwm/pwm-visconti.c                    |  17 +-
 drivers/pwm/pwm-vt8500.c                      |  41 +-
 drivers/pwm/pwm-xilinx.c                      |  34 +-
 drivers/pwm/sysfs.c                           |  64 ++-
 drivers/staging/greybus/pwm.c                 | 130 ++----
 include/linux/platform_data/x86/pwm-lpss.h    |   4 +-
 include/linux/pwm.h                           |  36 +-
 include/uapi/linux/pwm.h                      |  23 +
 81 files changed, 1602 insertions(+), 1292 deletions(-)
 create mode 100644 include/uapi/linux/pwm.h


base-commit: 162844744fa51edbe0d0857c493e37af336af666
prerequisite-patch-id: b30ff565416aab449c4e14fbd6535cad52f61096
prerequisite-patch-id: 9b6751ff5e149b689191aed3ca42d8731cd83863
prerequisite-patch-id: f74b07757ea3bd8b54dc1cce4a0294543ddefd0a
prerequisite-patch-id: 2df33999582eeaf1cd2a5c805b989c969577ca0c
prerequisite-patch-id: e8dad0c65b1deb6f8cd7ea2a5a08b3ab2cb2e291
prerequisite-patch-id: b540c7ef3ea7add5e54a65f480daff3018735fd3
prerequisite-patch-id: 72247967f924911ad08210638853d3d3b3d5d278
prerequisite-patch-id: 313ada72ab57438a8d54df0df9c0926bb4f69b36
prerequisite-patch-id: 318824c08f3e7d6500e3c5a47a11c5daffaea34a
prerequisite-patch-id: 921e5b577da74b4f1b666c433e182ddd3cb7e854
prerequisite-patch-id: fef82506a04db5801dae1ca61820c608d8530193
prerequisite-patch-id: a0c8d63424241e64c3e5f9991ea04018a51fcc94
prerequisite-patch-id: 34407ccb9ea15a9fa9b5cf1ee4a5c38f4540c717
prerequisite-patch-id: dd9252777f15596054fc27d0c868dd0d15999bfa
prerequisite-patch-id: 8901667ff1d7815dd5dd0f5111c2c9f1dd607334
prerequisite-patch-id: 166de2ae8ab4677c998fe1bda6c24b46cce55d1c
prerequisite-patch-id: 2cae8f054048b5074ed99163e476bee87cd9b7ef
prerequisite-patch-id: 8f6f3e08d426c4d349e93f5fdb3650efcd523299
prerequisite-patch-id: f7dd05d650cd2b4368ec1ce9f7db1716841a72d8
prerequisite-patch-id: e4abcc7c18f6cc49d3d4b4221cd3856189ec71d8
prerequisite-patch-id: 67e046597429677c0bfa48bb044aac39fdcc9eb2
prerequisite-patch-id: 4317fa5ef50613649e319fff57bb507dab10909d
prerequisite-patch-id: 1483ab31d5f3f7504dda11b5f4660022152f6e88
prerequisite-patch-id: da542cefd47056ad9f5b6fd57b5218437ba7025b
prerequisite-patch-id: 07a107646a7f974ff11acb7cd08db31d6dd8f254
prerequisite-patch-id: 13386aad0b7b3f163e27bcb450e9e4c8f42630d2
prerequisite-patch-id: 5b55d44ff77e37c24646bbbee4feb8adbdccfcf7
prerequisite-patch-id: cd271964ea5243e89857030e28c3e0046ae64bd9
prerequisite-patch-id: 61fdd540be57dadeeea1ee3cef161b182fda5c32
prerequisite-patch-id: 4cb0cca6da0fa4730d1cd1b17ad3e354631723df
prerequisite-patch-id: f3333980376bf2207e993d0714845f3301c86e2e
-- 
2.42.0

