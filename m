Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00A71827BE
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 05:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgCLEXM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 00:23:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55498 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCLEXM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 00:23:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02C4N7lL104287;
        Wed, 11 Mar 2020 23:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583986987;
        bh=NrBF8X7osaKwfx6YKSL4NEakY4NXAPmN1MMw7ujglsQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Q1gYg0Cb4SmaV1RQD2hPmp1L8/Vo6eOiq1kjgM2zXrTWLY95VP2RuAoyBkML6p1kq
         EbdN4V1oRnDG7BPuWknZzEnl9FswA0T87w72tr6gpxn5cMKU0sOxggmy01j9DDWHxP
         YBC7D5DAy2UuAdtc74K/YkEYEWHAGIvilbTYIRPc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02C4N7Hq079986
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Mar 2020 23:23:07 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Mar 2020 23:23:07 -0500
Received: from localhost.localdomain (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Mar 2020 23:23:07 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02C4Mvgi065984;
        Wed, 11 Mar 2020 23:23:04 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 2/5] pwm: omap-dmtimer: Update description for pwm omap dm timer
Date:   Thu, 12 Mar 2020 09:52:07 +0530
Message-ID: <20200312042210.17344-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200312042210.17344-1-lokeshvutla@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update the description with a brief about how pwm is generated
using OMAP DM timer and add Limitations for the pwm generations.
Also add link to the Reference Manual.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index e4f5f710bfaa..92aac6c86b95 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -10,7 +10,15 @@
  *
  * Description:
  *   This file is the core OMAP support for the generic, Linux
- *   PWM driver / controller, using the OMAP's dual-mode timers.
+ *   PWM driver / controller, using the OMAP's dual-mode timers
+ *   with a timer counter that goes up. When it overflows it gets
+ *   reloaded with the load value and the pwm output goes up.
+ *   When counter matches with match register, the output goes down.
+ *   Reference Manual: http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
+ *
+ * Limitations:
+ * - When PWM is stopped, timer counter gets stopped immediately. This
+ *   doesn't allow the current PWM period to complete and stops abruptly.
  */
 
 #include <linux/clk.h>
-- 
2.23.0

