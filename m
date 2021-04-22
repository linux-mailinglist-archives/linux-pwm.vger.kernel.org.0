Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB50367A63
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Apr 2021 08:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhDVG6R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Apr 2021 02:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbhDVG6R (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Apr 2021 02:58:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F71BC06138B
        for <linux-pwm@vger.kernel.org>; Wed, 21 Apr 2021 23:57:43 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZTHJ-0006TZ-VO; Thu, 22 Apr 2021 08:57:33 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZTHI-0003O5-Cd; Thu, 22 Apr 2021 08:57:32 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pwm@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH v5 0/6] clk: provide new devm helpers for prepared and enabled clocks
Date:   Thu, 22 Apr 2021 08:57:20 +0200
Message-Id: <20210422065726.1646742-1-u.kleine-koenig@pengutronix.de>
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

the only change since v5 is that the fixed i2c patch is now properly
part of this series.

Can I please get a feedback by the clock maintainers? The series got
positive feedback by several people now and is still unreplied by by the
clk maintainers since October. Should I resend regularly, say once per
two weeks? How many digits do I have to consider for the resend counter?
At what point can I ask the maintainers further up in the chain to merge
my series? Does a pull request help?

Best regards
Uwe

Uwe Kleine-König (6):
  clk: generalize devm_clk_get() a bit
  clk: Provide new devm_clk_helpers for prepared and enabled clocks
  pwm: atmel: Simplify using devm_clk_get_prepared()
  rtc: at91sma9: Simplify using devm_clk_get_enabled()
  i2c: imx: Simplify using devm_clk_get_enableded()
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

