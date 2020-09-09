Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CADB2631E3
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Sep 2020 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbgIIQ3g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Sep 2020 12:29:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:4048 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731133AbgIIQ32 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 9 Sep 2020 12:29:28 -0400
IronPort-SDR: ZcgQy0Fdv7buiWXjUt5soxTVXo5k89bZhOxMazzdpUlAe73mGsdNH8T0gNTp5ireHRR9QDR3Gm
 jFLkxTtaA33A==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="243175891"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="243175891"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 09:29:22 -0700
IronPort-SDR: K0XKL7ErZAtNGRd2m9yZ9MujTkh7vnneu54tK/VXC63eTlwKuJ5+dofXiAMH6AUS1byh5Orcpp
 X0F20WNzhe6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="343945082"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2020 09:29:19 -0700
From:   vijayakannan.ayyathurai@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: [PATCH v7 0/2] Add PWM support for Intel Keem Bay SoC
Date:   Thu, 10 Sep 2020 00:27:17 +0800
Message-Id: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

Hi,

This patch set enables support for PWM on the Intel Keem Bay SoC.
Keem Bay is an ARM based SoC, and the GPIO module allows
configuration of 6 PWM outputs.

Patch 1 adds the PWM driver and Patch 2 is for the required
Device Tree bindings documentation.

This driver was tested on the Keem Bay evaluation module board.

Thank you.

Regards,
Vijay

Changes since v6:
- Add reviewed-by tag

Changes since v5:
-Reorder symbols/Kconfig in drivers/pwm/Kconfig and drivers/pwm/Makefile
-Use "Limitations" for consistency
-Add clk_prepare_enable()
-Reorder keembay_pwm_get_state() function call
-Rework if conditional for channel disablement in .apply()
-Remove channel disabling from .probe(), and clear LEADIN register bits
in .apply instead
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
-Utilize FIELD_GET/FIELD_PREP for calculating pwm_l/h_count and
pwm_count
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
-Folded keembay_pwm_enable/disable_channel,
keembay_pwm_config_period/duty_cycle,
 and keembay_pwm_config into keembay_pwm_apply
-Updated error messages/error codes
-Removed pwm_disable from keembay_pwm_remove
-Removed clk_prepare/clk_enable/clk_disable from driver

Lai, Poey Seng (1):
  pwm: Add PWM driver for Intel Keem Bay

Vineetha G. Jaya Kumaran (1):
  dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM

.../bindings/pwm/intel,keembay-pwm.yaml       |  47 ++++
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-keembay.c                     | 232 ++++++++++++++++++
 4 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
 create mode 100644 drivers/pwm/pwm-keembay.c

-- 
2.17.1

