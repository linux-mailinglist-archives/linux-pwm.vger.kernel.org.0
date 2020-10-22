Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C32958EE
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508376AbgJVHR2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 03:17:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:64980 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505929AbgJVHR1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Oct 2020 03:17:27 -0400
IronPort-SDR: SoJ2RhkCYwX5ejPO8vgVHq6fYNE+mzipCF/VkcdzEsqd/eInyIua1cNdV+RTBVM3bgOeegXZqs
 0kZ5g1sjrt7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="252184737"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="252184737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 00:17:27 -0700
IronPort-SDR: vE7lSd/HnUNj4uuHa7y2UyFJuvMoxjJxw0kJKH7eukvgJ7BMfxY42JzimvzMytIZ7qpgD66KVQ
 VL04DYnAm+QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="321286159"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2020 00:17:24 -0700
From:   vijayakannan.ayyathurai@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        vijayakannan.ayyathurai@intel.com
Subject: [PATCH v14 0/2] Add PWM support for Intel Keem Bay SoC
Date:   Thu, 22 Oct 2020 15:14:45 +0800
Message-Id: <cover.1603350036.git.vijayakannan.ayyathurai@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

Hi,

This patch set enables the support for PWM in the Intel Keem Bay SoC.
Keem Bay is an ARM based SoC, and the GPIO module allows
configuration of 6 PWM outputs.

Patch 1 adds the PWM driver and Patch 2 is for the required
Device Tree bindings documentation.

This driver was tested on the Keem Bay evaluation module board.

Thank you.

Regards,
Vijay

Changes since v13:
- Fix indentation error in dt-binding.
- Add maintainer name in dt-binding.

Changes since v12:
- Use devm_add_action_or_reset() as per Andy suggestion.
- Do the clk_prepare_enable() after all devm_ stuff as per Uwe suggestion.
- Optimize keembay_pwm_remove function.
- Simplify the error handling for pwmchip_add.
- In Kconfig, Use depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
- Fix indentation error in dt-binding.
- Add Uwe's Reviewed-by tag and Vijay's Co-developed-by tag.

Changes since v11:
- Minor variable name change to match the api needs.
- Setup polarity as PWM_POLARITY_NORMAL.
- Add comment for LEADIN register usage.

Changes since v10:
- Update low time calculation formula as per Uwe.
- During distruct remove pwmchip first then disable the clock.

Changes since v9:
- Remove Reported-by tag from the commit log.

Changes since v8:
- Fix the compilation error reported by kernel test robot.
- Add the tag Reported-by: kernel test robot <lkp@intel.com>
- Minor correction in the pwm low time calculation formula.
- Rebase with 5.9-rc7

Changes since v7:
- Change the dependency as ARCH_KEEMBAY instead of ARM64 in Kconfig.
- Use DIV_ROUND_DOWN_ULL instead of DIV_ROUND_CLOSEST_ULL.
- Update the right formula as per Uwe.
- List the tags in chronological order.
- Add clk_disable_unprepare in the error paths.

Changes since v6:
- Add reviewed-by tag

Changes since v5:
- Reorder symbols/Kconfig in drivers/pwm/Kconfig and drivers/pwm/Makefile
- Use "Limitations" for consistency
- Add clk_prepare_enable()
- Reorder keembay_pwm_get_state() function call
- Rework if conditional for channel disablement in .apply()
- Remove channel disabling from .probe(), and clear LEADIN register bits
  in .apply instead
- Update commit message for Patch 1

Changes since v4:
- Add co-developed-by tag
- Include mod_devicetable.h and remove of.h
- Update comment with correct calulation for high/low time
- Fix missing return from dev_err_probe

Changes since v3:
- Removed variable for address and calculate in place instead
- Utilized u32_replace_bits() when updating KMB_PWM_LEADIN_OFFSET
- Utilized dev_err_probe() for error reporting
- Updated comments to use physical units
- Updated error check for pwmchip_add()

Changes since v2:
- Include documentation about HW limitation/behaviour
- Use hex values for KMB_PWM_COUNT_MAX
- Redefine register macros
- Utilize FIELD_GET/FIELD_PREP for calculating pwm_l/h_count and
  pwm_count
- Round up duty cycle/period values
- Get current hardware state in .apply instead of cached values
- Do a polarity check before .enabled
- Round high time/low time to closest value
- Set enable bit in KMB_PWM_LEADIN_OFFSET to 0 in probe
- Correct the naming for MODULE_ALIAS
- Add additionalProperties: false in DT bindings

Changes since v1:
- Updated licensing info, "clocks" property and example in DT bindings
- Updated name of DT bindings document to match compatible string
- Removed 1 patch for addition of new sysfs attribute "count"
- Added support for COMPILE_TEST in Kconfig
- Updated naming of defines and regmap attribute
- Updated calculation of waveform high time and low time
- Added range checking for waveform high/low time
- Implemented .get_state
- Removed register writes for lead-in and count values (left to default)
- Updated register access to single-access
- Folded keembay_pwm_enable/disable_channel,
  keembay_pwm_config_period/duty_cycle,
  and keembay_pwm_config into keembay_pwm_apply
- Updated error messages/error codes
- Removed pwm_disable from keembay_pwm_remove
- Removed clk_prepare/clk_enable/clk_disable from driver

Lai, Poey Seng (1):
  pwm: Add PWM driver for Intel Keem Bay

Vineetha G. Jaya Kumaran (1):
  dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM

 .../bindings/pwm/intel,keembay-pwm.yaml       |  47 ++++
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-keembay.c                     | 240 ++++++++++++++++++
 4 files changed, 297 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
 create mode 100644 drivers/pwm/pwm-keembay.c


base-commit: 549738f15da0e5a00275977623be199fbbf7df50
prerequisite-patch-id: 0a348762b660d0d817b8e70cc71647e83173c78c
prerequisite-patch-id: 0c6072cfe492b078c44ec864b8f9d1c76eada93b
prerequisite-patch-id: 12b93428ee51a3d92ca973b928c0e0989f5d585e
--
2.17.1

