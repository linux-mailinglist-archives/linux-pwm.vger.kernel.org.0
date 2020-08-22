Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7224E7E4
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgHVOcD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 10:32:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:6683 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgHVOcD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 22 Aug 2020 10:32:03 -0400
IronPort-SDR: CShm0dmIpP6GVrFJRj00YQlo8LgTqR4UrVJXduxzsjNzTzYUUDyABEmjcxbeoTiMRVg5yjwVIL
 yOwTu7Aun8oA==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="155690637"
X-IronPort-AV: E=Sophos;i="5.76,341,1592895600"; 
   d="scan'208";a="155690637"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2020 07:32:02 -0700
IronPort-SDR: EWQbZ4MIuo23j1GJX/BlVcgAy9mtKfCq8mMWQ4+VqDEhbpX9FPqg3pJyzdPI9Na8EFvVHch43+
 FohSM2k4B+IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,341,1592895600"; 
   d="scan'208";a="335569333"
Received: from vgjayaku-ilbpg7.png.intel.com ([10.88.227.96])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2020 07:32:00 -0700
From:   vineetha.g.jaya.kumaran@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: [PATCH v4 0/2] Add PWM support for Intel Keem Bay SoC
Date:   Sat, 22 Aug 2020 22:30:44 +0800
Message-Id: <1598106646-16595-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>

Hi,

This patch set enables support for PWM on the Intel Keem Bay SoC.
Keem Bay is an ARM based SoC, and the GPIO module allows
configuration of 6 PWM outputs. Patch 1 adds the PWM driver and
Patch 2 is for the required Device Tree bindings documentation.

This driver was tested on the Keem Bay evaluation module board.

Thank you.

Best regards,
Vineetha

Changes since v3:
-Removed variable for address and calculate in place instead
-Utilized u32_replace_bits() when updating KMB_PWM_LEADIN_OFFSET
-Utilized dev_err_probe() for error reporting
-Updated comments to use physical units
-Updated error check for pwmchip_add()

Changes since v2:
-Include documentation about HW limitation/behaviour
-Use hex values for KMB_PWM_COUNT_MAX
-Redefine register macros
-Utilize FIELD_GET/FIELD_PREP for calculating pwm_l/h_count and pwm_count
-Round up duty cycle/period values
-Get current hardware state in .apply instead of cached values
-Do a polarity check before .enabled
-Round high time/low time to closest value
-Set enable bit in KMB_PWM_LEADIN_OFFSET to 0 in probe
-Correct the naming for MODULE_ALIAS
-Add additionalProperties: false in DT bindings

Changes since v1:
-Updated licensing info, "clocks" property and example in DT bindings
-Updated name of DT bindings document to match compatible string
-Removed 1 patch for addition of new sysfs attribute "count"
-Added support for COMPILE_TEST in Kconfig
-Updated naming of defines and regmap attribute
-Updated calculation of waveform high time and low time
-Added range checking for waveform high/low time
-Implemented .get_state
-Removed register writes for lead-in and count values (left to default)
-Updated register access to single-access
-Folded keembay_pwm_enable/disable_channel, keembay_pwm_config_period/duty_cycle,
 and keembay_pwm_config into keembay_pwm_apply
-Updated error messages/error codes
-Removed pwm_disable from keembay_pwm_remove
-Removed clk_prepare/clk_enable/clk_disable from driver

Lai, Poey Seng (1):
  pwm: Add PWM driver for Intel Keem Bay

Vineetha G. Jaya Kumaran (1):
  dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM

 .../devicetree/bindings/pwm/intel,keembay-pwm.yaml |  47 +++++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-keembay.c                          | 229 +++++++++++++++++++++
 4 files changed, 286 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
 create mode 100644 drivers/pwm/pwm-keembay.c

-- 
1.9.1

