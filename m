Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEAED9B957
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 02:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfHXALD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Aug 2019 20:11:03 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:56646 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHXALD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Aug 2019 20:11:03 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id A63A677D4BC; Sat, 24 Aug 2019 02:11:01 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 5/6] pwm: atmel: use atmel_pwm_writel in atmel_pwm_ch_writel; ditto for readl
Date:   Sat, 24 Aug 2019 02:10:40 +0200
Message-Id: <20190824001041.11007-6-uwe@kleine-koenig.org>
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

This makes it a bit easier when instrumenting register access to only have
to add code in one place.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
New in v2

 drivers/pwm/pwm-atmel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 89f3a62f7541..152c2b7dd6df 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -111,7 +111,7 @@ static inline u32 atmel_pwm_ch_readl(struct atmel_pwm_chip *chip,
 {
 	unsigned long base = PWM_CH_REG_OFFSET + ch * PWM_CH_REG_SIZE;
 
-	return readl_relaxed(chip->base + base + offset);
+	return atmel_pwm_readl(chip, base + offset);
 }
 
 static inline void atmel_pwm_ch_writel(struct atmel_pwm_chip *chip,
@@ -120,7 +120,7 @@ static inline void atmel_pwm_ch_writel(struct atmel_pwm_chip *chip,
 {
 	unsigned long base = PWM_CH_REG_OFFSET + ch * PWM_CH_REG_SIZE;
 
-	writel_relaxed(val, chip->base + base + offset);
+	atmel_pwm_writel(chip, base + offset, val);
 }
 
 static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
-- 
2.20.1

