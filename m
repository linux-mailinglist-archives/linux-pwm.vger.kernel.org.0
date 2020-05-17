Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541531D684D
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 15:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgEQN4D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 09:56:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:63618 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgEQN4D (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 17 May 2020 09:56:03 -0400
IronPort-SDR: CU+EtcS1DoJnk+8ugqV450wLVH//Bdd4y2+kI9hUs141m2STbDhW9eq2GEtP5pjJbfpedF0Tmh
 dAigure5TdCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 06:56:03 -0700
IronPort-SDR: RbAfMFj4QyfRkwLIr5TJrLOo4xkqStD7QqRTDuZFx3Y516R+N+m0dJfyJWPicM8CGtg1TBsJVd
 YLp3aZJ+F3/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,403,1583222400"; 
   d="scan'208";a="263694146"
Received: from vgjayaku-ilbpg7.png.intel.com ([10.88.227.96])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2020 06:56:01 -0700
From:   vineetha.g.jaya.kumaran@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@intel.com, vineetha.g.jaya.kumaran@intel.com
Subject: [PATCH 0/3] Add PWM support for Intel Keem Bay SoC
Date:   Sun, 17 May 2020 21:52:37 +0800
Message-Id: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>

Hi,

This patch set enables support for PWM on the Intel Keem Bay SoC.
Keem Bay is an ARM based SoC, and the GPIO module allows
configuration of 6 PWM outputs. Patch 1 adds a new count attribute to
the sysfs, Patch 2 adds the PWM driver and Patch 3 is for the
required Device Tree bindings documentation.

This driver was tested on the Keem Bay evaluation module board.

Thank you.

Best regards,
Vineetha

Lai, Poey Seng (2):
  pwm: Add count attribute in sysfs for Intel Keem Bay
  pwm: Add PWM driver for Intel Keem Bay

Vineetha G. Jaya Kumaran (1):
  dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM

 Documentation/ABI/testing/sysfs-class-pwm          |   9 +
 .../devicetree/bindings/pwm/pwm-keembay.yaml       |  39 +++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |   3 +-
 drivers/pwm/pwm-keembay.c                          | 308 +++++++++++++++++++++
 drivers/pwm/sysfs.c                                |  37 +++
 include/linux/pwm.h                                |   2 +
 8 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
 create mode 100644 drivers/pwm/pwm-keembay.c

-- 
1.9.1

