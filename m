Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4CF28FF23
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2019 11:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfHPJiI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Aug 2019 05:38:08 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50079 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfHPJiI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Aug 2019 05:38:08 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyYgI-0008M5-Oy; Fri, 16 Aug 2019 11:37:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyYgG-0003yW-Gx; Fri, 16 Aug 2019 11:37:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH 4/3] pwm: atmel: document known weaknesses of both hardware and software
Date:   Fri, 16 Aug 2019 11:37:48 +0200
Message-Id: <20190816093748.11769-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815214133.11134-1-uwe@kleine-koenig.org>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-atmel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 42fe7bc043a8..1ddb93db9627 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -7,6 +7,16 @@
  *
  * Reference manual for "atmel,at91sam9rl-pwm":
  *   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11032-32-bit-ARM926EJ-S-Microcontroller-SAM9G25_Datasheet.pdf
+ *
+ * Limitations:
+ * - Periods start with the inactive level.
+ * - Hardware has to be stopped in general to update settings.
+ *
+ * Software bugs/possible improvements:
+ * - When atmel_pwm_apply() is called with state->enabled=false a change in
+ *   state->polarity isn't honored.
+ * - Instead of sleeping to wait for a completed period, the interrupt
+ *   functionality could be used.
  */
 
 #include <linux/clk.h>
-- 
2.20.1

