Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4100C9B956
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 02:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfHXAK7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Aug 2019 20:10:59 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:56636 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHXAK7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Aug 2019 20:10:59 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 1239877D4BA; Sat, 24 Aug 2019 02:10:58 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 4/6] pwm: atmel: document known weaknesses of both hardware and software
Date:   Sat, 24 Aug 2019 02:10:39 +0200
Message-Id: <20190824001041.11007-5-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190824001041.11007-1-uwe@kleine-koenig.org>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This documents the my findings while reading through the driver and the
reference manual.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Changes since (implicit) v1 sent with Message-Id:
20190816093748.11769-1-uwe@kleine-koenig.org:

 - Add some prosa to commit log

 drivers/pwm/pwm-atmel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 3786ab9db5cf..89f3a62f7541 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -7,6 +7,16 @@
  *
  * Links to reference manuals for the supported PWM chips can be found in
  * Documentation/arm/microchip.rst.
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

