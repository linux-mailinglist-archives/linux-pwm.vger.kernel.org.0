Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D055387A2D
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406931AbfHIMbo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 08:31:44 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55864 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406127AbfHIMbj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 08:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565353853; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrHkoEocdoieF4Db5zZoHJvPijP7K/ja2W9uI3sDEmc=;
        b=bRLlIiUmQelgXSBOltny/U+I/NEI1FRZo9MhBepoN03MMn8Jqcvbp7ivPdTer476XiBT+z
        ycnU1tSknED1bGUxfyGnUXq1zBMPE6HiLd+b6+VdtkoNZMCfEOrj3x0fR7MvfNATN/fiXq
        cIicqT81ErzK+hr1VtVLae9QL/52RUo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 7/7] pwm: jz4740: document known limitations
Date:   Fri,  9 Aug 2019 14:30:31 +0200
Message-Id: <20190809123031.24219-8-paul@crapouillou.net>
In-Reply-To: <20190809123031.24219-1-paul@crapouillou.net>
References: <20190809123031.24219-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The jz4740 PMW implementation doesn't fulfill the (up to now
insufficiently documented) requirements of the PWM API. At least
document them in the driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 8df898429d47..b331a73a9d5d 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -2,6 +2,10 @@
 /*
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
  *  JZ4740 platform PWM support
+ *
+ * Limitations:
+ * - The .apply callback doesn't complete the currently running period before
+ *   reconfiguring the hardware.
  */
 
 #include <linux/clk.h>
-- 
2.21.0.593.g511ec345e18

