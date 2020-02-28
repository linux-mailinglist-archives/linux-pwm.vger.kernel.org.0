Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D901F1734A7
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2020 10:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgB1J5w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Feb 2020 04:57:52 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55508 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1J5w (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2020 04:57:52 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01S9vkUb011813;
        Fri, 28 Feb 2020 03:57:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582883866;
        bh=RSDVCTsvy2Z5fJHhflSr1pvfzLu6/aSaZ+MblDcsENY=;
        h=From:To:CC:Subject:Date;
        b=HDfY5fT36bE48VKedLzyOyPti1z7wvMDg9HJpSGFDpZr2cGYmdqBXRc7lYaEw8lT7
         meunFAW7ujI0UNkXVPJbRU9wBMYTEnxewwbHS4qJWBQN4izYg61wLgjGTebcLuUwR6
         vz8LnweLVeMmoyaO3bBZzLrlS/tRo2/CF4Agb1lU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01S9vke4045809
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 03:57:46 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 03:57:46 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 03:57:46 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01S9vhLE115767;
        Fri, 28 Feb 2020 03:57:43 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/5] pwm: omap-dmtimer: Allow for dynamic pwm period updates
Date:   Fri, 28 Feb 2020 15:26:45 +0530
Message-ID: <20200228095651.32464-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This series fixes minor issues in config callback and allows for on the
fly updates for pwm period and duty cycle. This is mainly intended to
allow pwm omap dmtimer to be used for generating a 1PPS signal that can be
syncronized to PTP clock in CPTS module available in AM335x and AM57xx SoCs.

Series depends on the following series:
- https://patchwork.kernel.org/patch/11379875/
- https://patchwork.kernel.org/project/linux-omap/list/?series=248929 

Full dependencies can be seen here:
https://github.com/lokeshvutla/linux/tree/devel/pwm-1pps-generation-v2

Changes since v1:
- Updated commit description in PATCH 1
- Added a brief about PWM generation using OMAP DM timer.
- Updated the pwm stop callback to allow for completing the current pwm
  cycle.
- Added the limitaitons of hardware.
- Used hw status instead of relying on pwm framework for state update.

Lokesh Vutla (6):
  pwm: omap-dmtimer: Drop unused header file
  pwm: omap-dmtimer: Update description for pwm omap dm timer
  pwm: omap-dmtimer: Fix pwm enabling sequence
  pwm: omap-dmtimer: Fix pwm disabling sequence
  pwm: omap-dmtimer: Do not disable pwm before changing
    period/duty_cycle
  pwm: omap-dmtimer: Implement .apply callback

 drivers/pwm/pwm-omap-dmtimer.c                | 248 +++++++++++++-----
 include/clocksource/timer-ti-dm.h             |   3 +-
 .../linux/platform_data/pwm_omap_dmtimer.h    |  90 -------
 3 files changed, 178 insertions(+), 163 deletions(-)
 delete mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h

-- 
2.23.0

