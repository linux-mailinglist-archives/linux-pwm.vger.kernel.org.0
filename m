Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF039B953
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 02:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfHXAKw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Aug 2019 20:10:52 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:56594 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHXAKw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Aug 2019 20:10:52 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 2A79077D4B4; Sat, 24 Aug 2019 02:10:51 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 1/6] pwm: atmel: Add a hint where to find hardware documentation
Date:   Sat, 24 Aug 2019 02:10:36 +0200
Message-Id: <20190824001041.11007-2-uwe@kleine-koenig.org>
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

Most Microchip (formerly Atmel) chips have publicly available manuals.
A comprehensive list is already contained in the documentation folder.
Reference this list in the header of the driver to allow reviewers to
find the relevant manuals.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Changes since (implicit) v1 sent with Message-Id:
20190815214133.11134-1-uwe@kleine-koenig.org:

 - Only reference Documentation/arm/microchip.rst instead of starting
   another list of links

 drivers/pwm/pwm-atmel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index e5e1eaf372fa..a61a30fa8b7e 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -4,6 +4,9 @@
  *
  * Copyright (C) 2013 Atmel Corporation
  *		 Bo Shen <voice.shen@atmel.com>
+ *
+ * Links to reference manuals for the supported PWM chips can be found in
+ * Documentation/arm/microchip.rst.
  */
 
 #include <linux/clk.h>
-- 
2.20.1

