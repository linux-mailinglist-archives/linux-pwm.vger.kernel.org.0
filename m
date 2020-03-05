Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21017A13A
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2020 09:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgCEI21 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Mar 2020 03:28:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48184 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCEI21 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Mar 2020 03:28:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0258SD0b031604;
        Thu, 5 Mar 2020 02:28:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583396893;
        bh=hCAaeb1qURJR7vEhpmZJGQIftNwTgSpRLrFvF2X0C3w=;
        h=From:To:CC:Subject:Date;
        b=FmSo/sCgo/5v3PMfL1wD1Se31e1h3RY/LcfLIAuqv+Z8in1WzS1JU2coA4apaA46T
         kIi1Eu/2SqR72AXqNoIk7m7hhaqptBFogVSnjcL+MUh5h+KjFGT4dEZxmXdlXfEJ8B
         i9KZAiyYLKPUFu5o32w4LgOPWKhnejVLogsL9Heo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0258SDAi099176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Mar 2020 02:28:13 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 02:28:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 02:28:13 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0258S9kR067014;
        Thu, 5 Mar 2020 02:28:10 -0600
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
Subject: [PATCH v3 0/6] clocksource: timer-ti-dm: Prepare for dynamic pwm period updates
Date:   Thu, 5 Mar 2020 13:57:09 +0530
Message-ID: <20200305082715.15861-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series fixes dm_timer_ops used for enabling the pwm and enables
cpu_pm notifier for context save and restore. This acts as a preparatory
series for enabling dynamic period updates for pwm omap dm timer driver.

Changes since v2:
- Incorporated changes from Tony

Changes since v1:
- Updated License header to use SPDX identifier
- Implemented cpu_pm notfier
- Added support for getting pwm current status
- Extended set_pwm functionality.

Lokesh Vutla (5):
  clocksource: timer-ti-dm: Convert to SPDX identifier
  clocksource: timer-ti-dm: Implement cpu_pm notifier for context save
    and restore
  clocksource: timer-ti-dm: Do not update counter on updating the period
  clocksource: timer-ti-dm: Add support to get pwm current status
  clocksource: timer-ti-dm: Enable autoreload in set_pwm

Tony Lindgren (1):
  clocksource: timer-ti-dm: Prepare for using cpuidle

 drivers/clocksource/timer-ti-dm.c          | 186 ++++++++++++---------
 drivers/pwm/pwm-omap-dmtimer.c             |   8 +-
 include/clocksource/timer-ti-dm.h          |   4 +-
 include/linux/platform_data/dmtimer-omap.h |   6 +-
 4 files changed, 121 insertions(+), 83 deletions(-)

-- 
2.23.0

