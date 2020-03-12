Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA2A1827AE
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 05:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgCLEXL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 00:23:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55496 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCLEXL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 00:23:11 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02C4N1dM104202;
        Wed, 11 Mar 2020 23:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583986981;
        bh=jkK+KRwj12OUckK9FWpu1twNQ2nA5hS5XjMeKgX19HE=;
        h=From:To:CC:Subject:Date;
        b=RcUp0pY+vKmJxs7OE+59Y6ajjYsNmpbzBDPyKuqKwkFswuatDYGLBgEZowefXF/LI
         V7KJc+IH60umDldvDEIRh8mn3I9z8i+ipMf+1sX5UHBsAM+4cxYbPVnD15oG2VfVxt
         /RmnsVBK70Ot9iF5PZxCUzu9P0zjz/vDufPmtc0A=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02C4N16w079129
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Mar 2020 23:23:01 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Mar 2020 23:23:00 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Mar 2020 23:23:01 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02C4Mvgg065984;
        Wed, 11 Mar 2020 23:22:58 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 0/5] pwm: omap-dmtimer: Allow for dynamic pwm period updates
Date:   Thu, 12 Mar 2020 09:52:05 +0530
Message-ID: <20200312042210.17344-1-lokeshvutla@ti.com>
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
- https://patchwork.kernel.org/project/linux-omap/list/?series=251691

Full dependencies can be seen here:
https://github.com/lokeshvutla/linux/tree/devel/pwm-dynamic-period-updates-v3

Changes since v2:
- Restored the existing behavior on pwm stop. PWM stops immediately when
  .stop is called as timer counter stops immediately. If just the
  autoreload is disabled as in v2, there is a possibility that pwm is
  never stopped.
- Added the above limitation in the driver description
- Rebased on top of v5.6-rc5

Changes since v1:
- Updated commit description in PATCH 1
- Added a brief about PWM generation using OMAP DM timer.
- Updated the pwm stop callback to allow for completing the current pwm
  cycle.
- Added the limitaitons of hardware.
- Used hw status instead of relying on pwm framework for state update.


Lokesh Vutla (5):
  pwm: omap-dmtimer: Drop unused header file
  pwm: omap-dmtimer: Update description for pwm omap dm timer
  pwm: omap-dmtimer: Fix pwm enabling sequence
  pwm: omap-dmtimer: Do not disable pwm before changing
    period/duty_cycle
  pwm: omap-dmtimer: Implement .apply callback

 drivers/pwm/pwm-omap-dmtimer.c                | 219 ++++++++++++------
 include/clocksource/timer-ti-dm.h             |   3 +-
 .../linux/platform_data/pwm_omap_dmtimer.h    |  90 -------
 3 files changed, 149 insertions(+), 163 deletions(-)
 delete mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h

-- 
2.23.0

