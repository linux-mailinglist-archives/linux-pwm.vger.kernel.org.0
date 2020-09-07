Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44231260390
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Sep 2020 19:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgIGRvW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Sep 2020 13:51:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:27574 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729188AbgIGMJ2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Sep 2020 08:09:28 -0400
IronPort-SDR: IjqfOnwA6O65KQXmj93MTUOHYc978BMwjhmas/WEBbandhtt5BpaPxXQisQasafQszJ5aOkhqg
 KeuYwopln0kA==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="137510239"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="137510239"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 05:09:19 -0700
IronPort-SDR: sCvy0gG1XmEcd+dYwNKyEle6/fE1fOWVQ47Cq4kHTUL3tSPe7fjchY0IxeGVn6z7F7EFwbNaJI
 xoeAf+nJeiTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="328068141"
Received: from vgjayaku-ilbpg7.png.intel.com ([10.88.227.96])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2020 05:09:17 -0700
From:   vineetha.g.jaya.kumaran@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com,
        vijayakannan.ayyathurai@intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: [PATCH v6 0/2] Add PWM support for Intel Keem Bay SoC
Date:   Mon,  7 Sep 2020 20:07:48 +0800
Message-Id: <1599480470-5932-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
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

Changes since v5:
-Reorder symbols/Kconfig in drivers/pwm/Kconfig and drivers/pwm/Makefile
-Use "Limitations" for consistency
-Add clk_prepare_enable()
-Reorder keembay_pwm_get_state() function call
-Rework if conditional for channel disablement in .apply()
-Remove channel disabling from .probe(), and clear LEADIN register bits in .apply instead
-Update commit message for Patch 1

Changes since v4:
-Add co-developed-by tag
-Include mod_devicetable.h and remove of.h
-Update comment with correct calulation for high/low time
-Fix missing return from dev_err_probe

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
 drivers/pwm/pwm-keembay.c                          | 232 +++++++++++++++++++++
 4 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
 create mode 100644 drivers/pwm/pwm-keembay.c

-- 
1.9.1

