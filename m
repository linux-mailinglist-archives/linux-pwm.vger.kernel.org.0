Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 674318F688
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2019 23:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfHOVlw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Aug 2019 17:41:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35951 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbfHOVlw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Aug 2019 17:41:52 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyNVA-0007cE-3U; Thu, 15 Aug 2019 23:41:44 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyNV8-0003Gl-Br; Thu, 15 Aug 2019 23:41:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH 1/3] pwm: atmel: Add link to reference manual
Date:   Thu, 15 Aug 2019 23:41:31 +0200
Message-Id: <20190815214133.11134-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
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

The reference manual for at least one of the supported variants is
publicly available. Add a link to it at the top of the driver.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-atmel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index e5e1eaf372fa..ac3d7a200b9e 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -4,6 +4,9 @@
  *
  * Copyright (C) 2013 Atmel Corporation
  *		 Bo Shen <voice.shen@atmel.com>
+ *
+ * Reference manual for "atmel,at91sam9rl-pwm":
+ *   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11032-32-bit-ARM926EJ-S-Microcontroller-SAM9G25_Datasheet.pdf
  */
 
 #include <linux/clk.h>
-- 
2.20.1

