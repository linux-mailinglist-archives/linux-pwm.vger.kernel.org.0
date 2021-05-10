Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEEC379637
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhEJRnO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhEJRnI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 13:43:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0BC06138B
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 10:42:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg9ug-0005HH-GV; Mon, 10 May 2021 19:41:50 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg9ue-0006aQ-Pr; Mon, 10 May 2021 19:41:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v7 0/6] clk: provide new devm helpers for prepared and enabled clocks
Date:   Mon, 10 May 2021 19:41:36 +0200
Message-Id: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
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

compared to v6 I rebased to v5.13-rc1 (which resulted in a conflict in
the pwm-atmel patch), reformated the doc comments in patch 2 (as
suggested by Jonathan Cameron) and added the two Reviewed-by tags for
Jonathan Cameron.

Best regards
Uwe

Uwe Kleine-König (6):
  clk: generalize devm_clk_get() a bit
  clk: Provide new devm_clk_helpers for prepared and enabled clocks
  pwm: atmel: Simplify using devm_clk_get_prepared()
  rtc: at91sam9: Simplify using devm_clk_get_enabled()
  i2c: imx: Simplify using devm_clk_get_enabled()
  spi: davinci: Simplify using devm_clk_get_enabled()

 drivers/clk/clk-devres.c     | 96 ++++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-imx.c | 12 +----
 drivers/pwm/pwm-atmel.c      | 15 +-----
 drivers/rtc/rtc-at91sam9.c   | 22 ++-------
 drivers/spi/spi-davinci.c    | 11 +----
 include/linux/clk.h          | 90 ++++++++++++++++++++++++++++++++-
 6 files changed, 179 insertions(+), 67 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.30.2

