Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96096377C2B
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 08:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEJGSy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 02:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhEJGSv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 02:18:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1016EC06138B
        for <linux-pwm@vger.kernel.org>; Sun,  9 May 2021 23:17:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lfzEU-0007Z9-So; Mon, 10 May 2021 08:17:34 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lfzET-0004Zw-F8; Mon, 10 May 2021 08:17:33 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH v6 RESEND 0/6] clk: provide new devm helpers for prepared and enabled clocks
Date:   Mon, 10 May 2021 08:17:18 +0200
Message-Id: <20210510061724.940447-1-u.kleine-koenig@pengutronix.de>
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

this is just a resend as I didn't get any feedback in the two weeks
since the original v6 submission. Would be nice to hear something back,
I'm trying for more than half a year now to get feedback. :-\

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
 include/linux/clk.h          | 87 +++++++++++++++++++++++++++++++-
 6 files changed, 176 insertions(+), 67 deletions(-)


base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
-- 
2.30.2

