Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD686173496
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2020 10:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgB1JzJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Feb 2020 04:55:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34188 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgB1JzI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2020 04:55:08 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01S9suLa043756;
        Fri, 28 Feb 2020 03:54:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582883696;
        bh=LU/W6Hg33rRQqU79OZjtG5sej9WOSp4iGT1rFKr69cg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DhETrxa8d+gtt2A+FJGrnZK5uVrCfwNgQcnVyiBqR25UU8DqCUWNxBAE6ljMNz63c
         th4b7GWRcHbrN63eQrZr0R3w/ZwfUap202w+1OJOaO5ratd7k6eDkxIvFrifbnBsYt
         ysng3Ikz9p41UbatF0icBeg4CxXa3ela991hQRfM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01S9su2Y026143
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 03:54:56 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 03:54:55 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 03:54:55 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01S9sbB7125348;
        Fri, 28 Feb 2020 03:54:52 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 4/5] clocksource: timer-ti-dm: Add support to get pwm current status
Date:   Fri, 28 Feb 2020 15:23:45 +0530
Message-ID: <20200228095346.32177-5-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200228095346.32177-1-lokeshvutla@ti.com>
References: <20200228095346.32177-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

omap_dm_timer_ops provide support to configure the pwm but there is no
support to get the current status. For configuring pwm it is advised to
check the current hw status instead of relying on pwm framework. So
implement a new timer ops to get the current status of pwm.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/clocksource/timer-ti-dm.c          | 15 +++++++++++++++
 include/linux/platform_data/dmtimer-omap.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4c32ee41339a..b776ad3ee924 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -592,6 +592,20 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	return 0;
 }
 
+static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
+{
+	u32 l;
+
+	if (unlikely(!timer))
+		return -EINVAL;
+
+	omap_dm_timer_enable(timer);
+	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	omap_dm_timer_disable(timer);
+
+	return l;
+}
+
 static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 					int prescaler)
 {
@@ -859,6 +873,7 @@ static const struct omap_dm_timer_ops dmtimer_ops = {
 	.set_load = omap_dm_timer_set_load,
 	.set_match = omap_dm_timer_set_match,
 	.set_pwm = omap_dm_timer_set_pwm,
+	.get_pwm_status = omap_dm_timer_get_pwm_status,
 	.set_prescaler = omap_dm_timer_set_prescaler,
 	.read_counter = omap_dm_timer_read_counter,
 	.write_counter = omap_dm_timer_write_counter,
diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
index bdaaf537604a..3173b7b6ff6f 100644
--- a/include/linux/platform_data/dmtimer-omap.h
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -36,6 +36,7 @@ struct omap_dm_timer_ops {
 			     unsigned int match);
 	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
 			   int toggle, int trigger);
+	int	(*get_pwm_status)(struct omap_dm_timer *timer);
 	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
 
 	unsigned int (*read_counter)(struct omap_dm_timer *timer);
-- 
2.23.0

