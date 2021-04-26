Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA6336B4AC
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Apr 2021 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhDZOSd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Apr 2021 10:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhDZOSc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Apr 2021 10:18:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208DC061756
        for <linux-pwm@vger.kernel.org>; Mon, 26 Apr 2021 07:17:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb23K-0002KB-Ie; Mon, 26 Apr 2021 16:17:34 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb23I-0005nU-Px; Mon, 26 Apr 2021 16:17:32 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
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
Subject: [PATCH v6 0/6] clk: provide new devm helpers for prepared and enabled clocks
Date:   Mon, 26 Apr 2021 16:17:24 +0200
Message-Id: <20210426141730.2826832-1-u.kleine-koenig@pengutronix.de>
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

compared to v5 sent last week this series only fixes two typos in the
commit logs.

The range-diff is
1:  0f2fe65a9c9c ! 1:  38f213c5eeff rtc: at91sma9: Simplify using devm_clk_get_enabled()
    @@ Metadata
     Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## Commit message ##
    -    rtc: at91sma9: Simplify using devm_clk_get_enabled()
    +    rtc: at91sam9: Simplify using devm_clk_get_enabled()
     
         devm_clk_get_enabled() returns the clk already (prepared and) enabled
         and the automatically called cleanup cares for disabling (and
2:  3f11b70e7427 ! 2:  b9cebea08a73 i2c: imx: Simplify using devm_clk_get_enableded()
    @@ Metadata
     Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
     
      ## Commit message ##
    -    i2c: imx: Simplify using devm_clk_get_enableded()
    +    i2c: imx: Simplify using devm_clk_get_enabled()
     
         devm_clk_get_enabled() returns the clk already (prepared and) enabled
         and the automatically called cleanup cares for disabling (and
3:  6c357913e391 = 3:  8167605ad349 spi: davinci: Simplify using devm_clk_get_enabled()
4:  71b3db526357 < -:  ------------ pwm: Clarify documentation about pwm_get_state()

Other than that the state is still unchanged: This is a series which
allows several cleanups (as can be seen from patches 2 to 6) and I
didn't get any feedback from the clock maintainers since v1 that I sent
in October.

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

