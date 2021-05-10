Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488B7379140
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhEJOuD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbhEJOsv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 10:48:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ADFC06138B
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 07:06:44 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg6YU-0006xA-R3; Mon, 10 May 2021 16:06:42 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg6YU-0001sg-71; Mon, 10 May 2021 16:06:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 0/4] pwm: Simplify drivers with of_pwm_n_cells = 3
Date:   Mon, 10 May 2021 16:06:36 +0200
Message-Id: <20210510140640.980100-1-u.kleine-koenig@pengutronix.de>
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

changes since v1:

 - rebased to v5.13-rc1
 - reformulate an if in a way that pleases Thierry (no semantic change)

Thierry's suggestion was to apply this series shortly after v5.13-rc1
(i.e. around now) to have it exposed to next for a long time before it
flows to Linus Torvalds.

Best regards
Uwe

Uwe Kleine-König (4):
  pwm: Make of_pwm_xlate_with_flags() work with #pwm-cells = <2>
  pwm: Drop of_pwm_simple_xlate() in favour of of_pwm_xlate_with_flags()
  pwm: Autodetect default value for of_pwm_n_cells from device tree
  pwm: Simplify all drivers with explicit of_pwm_n_cells = 3

 drivers/pwm/core.c             | 45 +++++++++++-----------------------
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
 27 files changed, 14 insertions(+), 88 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.30.2

