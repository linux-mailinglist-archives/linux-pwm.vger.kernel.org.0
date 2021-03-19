Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8273419F8
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Mar 2021 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhCSK31 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Mar 2021 06:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCSK3C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Mar 2021 06:29:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3A7C06174A
        for <linux-pwm@vger.kernel.org>; Fri, 19 Mar 2021 03:29:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNCNI-0003ho-8Z; Fri, 19 Mar 2021 11:29:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNCNH-0001gI-LG; Fri, 19 Mar 2021 11:28:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 00/14] pwm: Patches I consider ready for the next merge window 
Date:   Fri, 19 Mar 2021 11:28:38 +0100
Message-Id: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

this is the set of patches that are open on the list for some time.
Lee suggested to resend them.

@Thierry: I'm unsure what is the best way to nag. Is it really
resending? Or does this just result mostly in overhead because the
patches are still open in patchwork and it adds copies to your mailbox?
(Another downside is that taking the patches from this thread results in
recording a newer Author Date compared to picking up the originals.)

Anhow, you can also find these patches applied on top of a pull of Lee's

        git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-pwm-rtc-v5.13-1

from https://lore.kernel.org/r/20210310110846.GL701493@dell at:

        https://git.pengutronix.de/git/ukl/linux pwm-next

if you prefer to just pull this series.

Best regards
Uwe

Fabio Estevam (1):
  pwm: imx-tpm: Use a single line for error message

Uwe Kleine-König (13):
  pwm: bcm2835: Improve period and duty cycle calculation
  pwm: bcm-kona: Use pwmchip_add() instead of
    pwmchip_add_with_polarity()
  pwm: atmel-hlcdc: Use pwmchip_add() instead of
    pwmchip_add_with_polarity()
  pwm: Drop function pwmchip_add_with_polarity()
  pwm: ab8500: Implement .apply instead of .config, .enable and .disable
  pwm: Always allocate pwm id dynamically
  pwm: Return -EINVAL for old-style drivers without .set_polarity
    callback
  pwm: Prevent a glitch in compat code
  pwm: atmel-tcb: Implement .apply callback
  pwm: atmel-tcb: Only free resources after pwm_chip_remove() returned
  pwm: sprd: Refuse requests with unsupported polarity
  pwm: cros-ec: Refuse requests with unsupported polarity
  pwm: Soften potential loss of precision in compat code

 drivers/pwm/core.c             | 81 +++++++++++++---------------------
 drivers/pwm/pwm-ab8500.c       | 54 +++++++++++------------
 drivers/pwm/pwm-atmel-hlcdc.c  |  3 +-
 drivers/pwm/pwm-atmel-tcb.c    | 42 ++++++++++++------
 drivers/pwm/pwm-atmel.c        |  1 -
 drivers/pwm/pwm-bcm-iproc.c    |  1 -
 drivers/pwm/pwm-bcm-kona.c     |  3 +-
 drivers/pwm/pwm-bcm2835.c      | 36 +++++++++++----
 drivers/pwm/pwm-berlin.c       |  1 -
 drivers/pwm/pwm-brcmstb.c      |  1 -
 drivers/pwm/pwm-clps711x.c     |  1 -
 drivers/pwm/pwm-crc.c          |  1 -
 drivers/pwm/pwm-cros-ec.c      |  4 +-
 drivers/pwm/pwm-dwc.c          |  1 -
 drivers/pwm/pwm-ep93xx.c       |  1 -
 drivers/pwm/pwm-fsl-ftm.c      |  1 -
 drivers/pwm/pwm-hibvt.c        |  1 -
 drivers/pwm/pwm-img.c          |  1 -
 drivers/pwm/pwm-imx-tpm.c      |  5 +--
 drivers/pwm/pwm-imx1.c         |  1 -
 drivers/pwm/pwm-imx27.c        |  1 -
 drivers/pwm/pwm-intel-lgm.c    |  1 -
 drivers/pwm/pwm-iqs620a.c      |  1 -
 drivers/pwm/pwm-jz4740.c       |  1 -
 drivers/pwm/pwm-keembay.c      |  1 -
 drivers/pwm/pwm-lp3943.c       |  1 -
 drivers/pwm/pwm-lpc18xx-sct.c  |  1 -
 drivers/pwm/pwm-lpc32xx.c      |  1 -
 drivers/pwm/pwm-lpss.c         |  1 -
 drivers/pwm/pwm-mediatek.c     |  1 -
 drivers/pwm/pwm-meson.c        |  1 -
 drivers/pwm/pwm-mtk-disp.c     |  1 -
 drivers/pwm/pwm-mxs.c          |  1 -
 drivers/pwm/pwm-omap-dmtimer.c |  1 -
 drivers/pwm/pwm-pca9685.c      |  1 -
 drivers/pwm/pwm-pxa.c          |  1 -
 drivers/pwm/pwm-rcar.c         |  1 -
 drivers/pwm/pwm-renesas-tpu.c  |  1 -
 drivers/pwm/pwm-rockchip.c     |  1 -
 drivers/pwm/pwm-samsung.c      |  1 -
 drivers/pwm/pwm-sifive.c       |  1 -
 drivers/pwm/pwm-sl28cpld.c     |  1 -
 drivers/pwm/pwm-spear.c        |  1 -
 drivers/pwm/pwm-sprd.c         |  4 +-
 drivers/pwm/pwm-sti.c          |  1 -
 drivers/pwm/pwm-stm32-lp.c     |  1 -
 drivers/pwm/pwm-stm32.c        |  1 -
 drivers/pwm/pwm-stmpe.c        |  1 -
 drivers/pwm/pwm-sun4i.c        |  1 -
 drivers/pwm/pwm-tegra.c        |  1 -
 drivers/pwm/pwm-tiecap.c       |  1 -
 drivers/pwm/pwm-tiehrpwm.c     |  1 -
 drivers/pwm/pwm-twl-led.c      |  1 -
 drivers/pwm/pwm-twl.c          |  1 -
 drivers/pwm/pwm-vt8500.c       |  1 -
 include/linux/pwm.h            |  2 -
 56 files changed, 121 insertions(+), 159 deletions(-)

-- 
2.30.1

