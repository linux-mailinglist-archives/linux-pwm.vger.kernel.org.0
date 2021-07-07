Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083513BEC1E
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGGQbZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhGGQbY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F7C061762
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APh-0003qA-Pd; Wed, 07 Jul 2021 18:28:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APg-0002ak-OA; Wed, 07 Jul 2021 18:28:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APg-0006Gx-N1; Wed, 07 Jul 2021 18:28:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 00/47] pwm: Make pwmchip_remove return void
Date:   Wed,  7 Jul 2021 18:27:48 +0200
Message-Id: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

this series modifies the drivers that are still using the return value
of pwmchip_return to stop doing that and at the end change this function
to return void.

Best regards
Uwe

Uwe Kleine-König (47):
  pwm: lpc32xx: Don't modify HW state in .probe() after the PWM chip was
    registered
  pwm: mxs: Don't modify HW state in .probe() after the PWM chip was
    registered
  pwm: img: Don't modify HW state in .remove() callback
  pwm: rockchip: Don't modify HW state in .remove() callback
  pwm: stm32-lp: Don't modify HW state in .remove() callback
  pwm: hibvt: Disable the clock only after the PWM was unregistered
  pwm: rockchip: Unprepare clocks only after the PWM was unregistered
  pwm: tiehrpwm: Unprepare clock only after the PWM was unregistered
  pwm: ntxec: Drop useless assignment to struct pwmchip::base
  pwm: jz4740: Improve compile coverage by allowing to enable on !MIPS
  pwm: keembay: Improve compile coverage by allowing to enable on !ARM64
  pwm: ab8500: Simplify using devm_pwmchip_add()
  pwm: bcm-kona: Simplify using devm_pwmchip_add()
  pwm: ep93xx: Simplify using devm_pwmchip_add()
  pwm: fsl-ftm: Simplify using devm_pwmchip_add()
  pwm: imx27: Simplify using devm_pwmchip_add()
  pwm: intel-lgm: Simplify using devm_pwmchip_add()
  pwm: iqs620a: Simplify using devm_pwmchip_add()
  pwm: jz4740: Simplify using devm_pwmchip_add()
  pwm: keembay: Simplify using devm_pwmchip_add()
  pwm: lp3943: Simplify using devm_pwmchip_add()
  pwm: lpc32xx: Simplify using devm_pwmchip_add()
  pwm: mediatek: Simplify using devm_pwmchip_add()
  pwm: mxs: Simplify using devm_pwmchip_add()
  pwm: ntxec: Simplify using devm_pwmchip_add()
  pwm: pxa: Simplify using devm_pwmchip_add()
  pwm: raspberrypi-poe: Simplify using devm_pwmchip_add()
  pwm: sl28cpld: Simplify using devm_pwmchip_add()
  pwm: stm32-lp: Simplify using devm_pwmchip_add()
  pwm: tiecap: Simplify using devm_pwmchip_add()
  pwm: twl-led: Simplify using devm_pwmchip_add()
  pwm: twl: Simplify using devm_pwmchip_add()
  pwm: atmel-hlcdc: Don't check the return code of pwmchip_remove()
  pwm: atmel-tcb: Don't check the return code of pwmchip_remove()
  pwm: brcmstb: Don't check the return code of pwmchip_remove()
  pwm: cros-ec: Don't check the return code of pwmchip_remove()
  pwm: img: Don't check the return code of pwmchip_remove()
  pwm: imx-tpm: Don't check the return code of pwmchip_remove()
  pwm: mtk-disp: Don't check the return code of pwmchip_remove()
  pwm: omap-dmtimer: Don't check the return code of pwmchip_remove()
  pwm: pca9685: Don't check the return code of pwmchip_remove()
  pwm: rcar: Don't check the return code of pwmchip_remove()
  pwm: renesas-tpu: Don't check the return code of pwmchip_remove()
  pwm: samsung: Don't check the return code of pwmchip_remove()
  pwm: sifive: Don't check the return code of pwmchip_remove()
  pwm: sun4i: Don't check the return code of pwmchip_remove()
  pwm: Make pwmchip_remove() return void

 drivers/pwm/Kconfig               |  5 +++--
 drivers/pwm/core.c                |  4 +---
 drivers/pwm/pwm-ab8500.c          | 18 +-----------------
 drivers/pwm/pwm-atmel-hlcdc.c     |  5 +----
 drivers/pwm/pwm-atmel-tcb.c       |  5 +----
 drivers/pwm/pwm-bcm-kona.c        | 12 +-----------
 drivers/pwm/pwm-brcmstb.c         |  5 ++---
 drivers/pwm/pwm-cros-ec.c         |  4 +++-
 drivers/pwm/pwm-ep93xx.c          | 11 +----------
 drivers/pwm/pwm-fsl-ftm.c         | 10 +---------
 drivers/pwm/pwm-hibvt.c           |  4 +++-
 drivers/pwm/pwm-img.c             | 20 +++-----------------
 drivers/pwm/pwm-imx-tpm.c         |  5 +++--
 drivers/pwm/pwm-imx27.c           | 14 +-------------
 drivers/pwm/pwm-intel-lgm.c       | 12 +-----------
 drivers/pwm/pwm-iqs620a.c         | 16 +---------------
 drivers/pwm/pwm-jz4740.c          | 12 +-----------
 drivers/pwm/pwm-keembay.c         | 12 +-----------
 drivers/pwm/pwm-lp3943.c          | 12 +-----------
 drivers/pwm/pwm-lpc32xx.c         | 22 ++++++----------------
 drivers/pwm/pwm-mediatek.c        | 12 +-----------
 drivers/pwm/pwm-mtk-disp.c        |  5 ++---
 drivers/pwm/pwm-mxs.c             | 25 ++++++-------------------
 drivers/pwm/pwm-ntxec.c           | 14 +-------------
 drivers/pwm/pwm-omap-dmtimer.c    |  5 +----
 drivers/pwm/pwm-pca9685.c         |  5 +----
 drivers/pwm/pwm-pxa.c             | 13 +------------
 drivers/pwm/pwm-raspberrypi-poe.c | 12 +-----------
 drivers/pwm/pwm-rcar.c            |  5 ++---
 drivers/pwm/pwm-renesas-tpu.c     |  5 ++---
 drivers/pwm/pwm-rockchip.c        | 16 ++--------------
 drivers/pwm/pwm-samsung.c         |  5 +----
 drivers/pwm/pwm-sifive.c          |  6 +++---
 drivers/pwm/pwm-sl28cpld.c        | 12 +-----------
 drivers/pwm/pwm-stm32-lp.c        | 12 +-----------
 drivers/pwm/pwm-sun4i.c           |  5 +----
 drivers/pwm/pwm-tiecap.c          |  6 ++----
 drivers/pwm/pwm-tiehrpwm.c        |  4 +++-
 drivers/pwm/pwm-twl-led.c         | 17 +----------------
 drivers/pwm/pwm-twl.c             | 17 +----------------
 include/linux/pwm.h               |  2 +-
 41 files changed, 71 insertions(+), 340 deletions(-)


base-commit: 96e45e5202377da39d086ec19f8934ebcc5b0fd6
prerequisite-patch-id: 83b82192f28d84e09e1cdcf9609fc4e085a15a17
-- 
2.30.2

