Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB331734AC
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2020 10:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgB1J57 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Feb 2020 04:57:59 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34612 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgB1J55 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2020 04:57:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01S9vrS7045015;
        Fri, 28 Feb 2020 03:57:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582883873;
        bh=HYpEUc4DlOdrjcU8QuE3wFkAhg+XHUdNw32emLZQJFI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zUyGEwgvLNsxF/3IDlZan38w+0YDtyKN9fCDqlC0nKFtIgI91xQKyZNgVHghFBxtq
         j/LSbb7q2xfH7NXfJXHW+rcSV4wT+yOmH9Gf7efxvxbk9IvrVKncGlfst2VEMFPmEO
         NkKYjCwDUH7//q2oZMLkqXSv7EilYBPAR6bcBPu8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01S9vr1O104660;
        Fri, 28 Feb 2020 03:57:53 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 03:57:52 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 03:57:52 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01S9vhLG115767;
        Fri, 28 Feb 2020 03:57:50 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 2/6] pwm: omap-dmtimer: Update description for pwm omap dm timer
Date:   Fri, 28 Feb 2020 15:26:47 +0530
Message-ID: <20200228095651.32464-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200228095651.32464-1-lokeshvutla@ti.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update the description with a brief about how pwm is generated
using OMAP DM timer. Also add link to the Reference Manual.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index e4f5f710bfaa..a24a630ccdb9 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -10,7 +10,11 @@
  *
  * Description:
  *   This file is the core OMAP support for the generic, Linux
- *   PWM driver / controller, using the OMAP's dual-mode timers.
+ *   PWM driver / controller, using the OMAP's dual-mode timers
+ *   with a timer counter that goes up. When it overflows it gets
+ *   reloaded with the load value and the pwm output goes up.
+ *   When counter matches with match register, the output goes down.
+ *   Reference Manual: http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
  */
 
 #include <linux/clk.h>
-- 
2.23.0

