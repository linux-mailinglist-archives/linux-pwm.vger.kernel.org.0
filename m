Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7659328D37D
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 20:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgJMSRC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 14:17:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:18841 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgJMSRC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Oct 2020 14:17:02 -0400
IronPort-SDR: MCuhIMj8OS6tIyttst9UFouHCJLi/4tw6WsKXFPwoXAM1dtb9yGpdjiMhUVmZW33LFaNj1HLYa
 Kq0sDbKy3oaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="166076758"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="166076758"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 11:17:00 -0700
IronPort-SDR: yo3IuQdFNUhW1knAsbyhgEZqkaSQHubJP+1iknJVI8Y3Ei5rpyTgSEdmqUiqjrUVNovyB+vm8a
 poYpH2gBiIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="521131457"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by fmsmga005.fm.intel.com with ESMTP; 13 Oct 2020 11:16:58 -0700
From:   vijayakannan.ayyathurai@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        vijayakannan.ayyathurai@intel.com
Subject: [PATCH v11 0/2] Add PWM support for Intel Keem Bay SoC
Date:   Wed, 14 Oct 2020 02:14:11 +0800
Message-Id: <cover.1602612067.git.vijayakannan.ayyathurai@intel.com>
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
 drivers/pwm/pwm-keembay.c                     | 228 ++++++++++++++++++
 4 files changed, 285 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
 create mode 100644 drivers/pwm/pwm-keembay.c


base-commit: 549738f15da0e5a00275977623be199fbbf7df50
prerequisite-patch-id: 0a348762b660d0d817b8e70cc71647e83173c78c
prerequisite-patch-id: 0c6072cfe492b078c44ec864b8f9d1c76eada93b
prerequisite-patch-id: 12b93428ee51a3d92ca973b928c0e0989f5d585e
-- 
2.17.1

