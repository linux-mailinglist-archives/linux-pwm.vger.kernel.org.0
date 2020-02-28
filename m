Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47638173488
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2020 10:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgB1Jy6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Feb 2020 04:54:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34120 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgB1Jy6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2020 04:54:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01S9sfTU043736;
        Fri, 28 Feb 2020 03:54:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582883681;
        bh=tFNbyFSls0cIg9yQLf3YdifxAAy1SK7224z71RMQhnw=;
        h=From:To:CC:Subject:Date;
        b=oSjk+T18dNQNCcmcua4xxEqLbfPz7vn3n/UgqCMunet4Ag+0TbiP8da8pqRBFB2bA
         phTDioT37escKJusSn4USUlThzWJQtfmC5tnxqaYhxL7Eu23H5n/iNXavjp9C6Ka0P
         IF6EiTIfjbvEoDGsug++rTSeT0jF9t51jOeAHD/E=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01S9sfQo101177;
        Fri, 28 Feb 2020 03:54:41 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 03:54:41 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 03:54:41 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01S9sbB3125348;
        Fri, 28 Feb 2020 03:54:38 -0600
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
Subject: [PATCH v2 0/5] clocksource: timer-ti-dm: Prepare for dynamic pwm period updates
Date:   Fri, 28 Feb 2020 15:23:41 +0530
Message-ID: <20200228095346.32177-1-lokeshvutla@ti.com>
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

 drivers/clocksource/timer-ti-dm.c          | 136 ++++++++++-----------
 drivers/pwm/pwm-omap-dmtimer.c             |   8 +-
 include/clocksource/timer-ti-dm.h          |   3 +-
 include/linux/platform_data/dmtimer-omap.h |   6 +-
 4 files changed, 75 insertions(+), 78 deletions(-)

-- 
2.23.0

