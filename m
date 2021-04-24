Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F936A315
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Apr 2021 23:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhDXVIM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Apr 2021 17:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbhDXVIK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Apr 2021 17:08:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1C0C06175F
        for <linux-pwm@vger.kernel.org>; Sat, 24 Apr 2021 14:07:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1laPUs-000135-My; Sat, 24 Apr 2021 23:07:26 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1laPUr-00034S-IN; Sat, 24 Apr 2021 23:07:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 0/4] pwm: Simplify drivers with of_pwm_n_cells = 3
Date:   Sat, 24 Apr 2021 23:07:14 +0200
Message-Id: <20210424210718.2787498-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

this is v2 of the series sent earlier starting with Message-Id:
20210315111124.2475274-1-u.kleine-koenig@pengutronix.de. (See
https://lore.kernel.org/r/20210315111124.2475274-1-u.kleine-koenig@pengutronix.de).

The only change is using

	if (pc->of_pwm_n_cells >= 3) {
		if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
			pwm->args.polarity = PWM_POLARITY_INVERSED;
	}

instead of

	if (pc->of_pwm_n_cells >= 3 && args->args_count > 2 &&
	    args->args[2] & PWM_POLARITY_INVERTED)
		pwm->args.polarity = PWM_POLARITY_INVERSED;

in the first patch which is semantically equivalent but Thierry likes it
better. This targets to go into next early after v5.13-rc1 so that it
gets proper testing before entering mainline.

Best regards
Uwe

Uwe Kleine-König (4):
  pwm: Make of_pwm_xlate_with_flags() work with #pwm-cells = <2>
  pwm: Drop of_pwm_simple_xlate() in favour of of_pwm_xlate_with_flags()
  pwm: Autodetect default value for of_pwm_n_cells from device tree
  pwm: Simplify all drivers with explicit of_pwm_n_cells = 3

 drivers/pwm/core.c             | 44 ++++++++++------------------------
 drivers/pwm/pwm-atmel-hlcdc.c  |  2 --
 drivers/pwm/pwm-atmel-tcb.c    |  2 --
 drivers/pwm/pwm-atmel.c        |  2 --
 drivers/pwm/pwm-bcm-iproc.c    |  2 --
 drivers/pwm/pwm-bcm-kona.c     |  2 --
 drivers/pwm/pwm-bcm2835.c      |  2 --
 drivers/pwm/pwm-berlin.c       |  2 --
 drivers/pwm/pwm-fsl-ftm.c      |  2 --
 drivers/pwm/pwm-hibvt.c        |  2 --
 drivers/pwm/pwm-imx-tpm.c      |  2 --
 drivers/pwm/pwm-imx27.c        |  3 ---
 drivers/pwm/pwm-jz4740.c       |  2 --
 drivers/pwm/pwm-lpc18xx-sct.c  |  2 --
 drivers/pwm/pwm-meson.c        |  2 --
 drivers/pwm/pwm-mxs.c          |  2 --
 drivers/pwm/pwm-omap-dmtimer.c |  2 --
 drivers/pwm/pwm-renesas-tpu.c  |  2 --
 drivers/pwm/pwm-rockchip.c     |  5 ----
 drivers/pwm/pwm-samsung.c      |  3 ---
 drivers/pwm/pwm-sifive.c       |  2 --
 drivers/pwm/pwm-stm32-lp.c     |  2 --
 drivers/pwm/pwm-stm32.c        |  2 --
 drivers/pwm/pwm-sun4i.c        |  2 --
 drivers/pwm/pwm-tiecap.c       |  2 --
 drivers/pwm/pwm-tiehrpwm.c     |  2 --
 drivers/pwm/pwm-vt8500.c       |  2 --
 27 files changed, 13 insertions(+), 88 deletions(-)


base-commit: 30d0031bd7cab931589e023149afc77739a4b175
-- 
2.30.2

