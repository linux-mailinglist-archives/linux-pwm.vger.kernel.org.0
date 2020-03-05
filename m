Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61CC817A148
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2020 09:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCEI2m (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Mar 2020 03:28:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59922 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCEI2l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Mar 2020 03:28:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0258SSrM101747;
        Thu, 5 Mar 2020 02:28:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583396908;
        bh=edi2MIqND5xz9BvsrPOuYHZCtiCCHZeaCHrOXHheyBM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yBUkiR9WYj+lPHAgQsS9eb5OivjTdusPyxLC79Kj0JYVL68A+bjoEnwSm4yRf/lDq
         /NQdsWtJ3LYIOt/WeXhSiKNfw2ecFzEZRekGZu1nINBEGJB9LESpL+ZhMjvB5VJVA7
         ZQ6eaMFf6QTIPOcCYjkO+DLGHPTmu3zskT8JD/4w=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0258SRIn009399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Mar 2020 02:28:27 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 02:28:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 02:28:27 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0258S9kV067014;
        Thu, 5 Mar 2020 02:28:24 -0600
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
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v3 4/6] clocksource: timer-ti-dm: Do not update counter on updating the period
Date:   Thu, 5 Mar 2020 13:57:13 +0530
Message-ID: <20200305082715.15861-5-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200305082715.15861-1-lokeshvutla@ti.com>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Write to trigger register(OMAP_TIMER_TRIGGER_REG) will load the value
in Load register(OMAP_TIMER_LOAD_REG) into Counter register
(OMAP_TIMER_COUNTER_REG).

omap_dm_timer_set_load() writes into trigger register every time load
register is updated. When timer is configured in pwm mode, this causes
disruption in current pwm cycle, which is not expected especially when
pwm is used as PPS signal for synchronized PTP clocks. So do not write
into trigger register on updating the period.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index e6b6123ec567..8f6d477d2078 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -548,7 +548,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
 	omap_dm_timer_disable(timer);
 	return 0;
 }
-- 
2.23.0

