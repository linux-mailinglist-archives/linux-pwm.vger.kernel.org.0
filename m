Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FBE2A7739
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 06:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbgKEFtx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 00:49:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:28363 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKEFtx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 5 Nov 2020 00:49:53 -0500
IronPort-SDR: /wqm9nXX2AMb0Hovh+GQXgA3NQUzqlFRYWVhq/1Qw0o/rPVRXg5kGAxIa4CJzasg1H6D2n5ziC
 qWLW/HoSYIsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="166742388"
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="166742388"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 21:49:48 -0800
IronPort-SDR: buOrznqQZj88HlI22V+86sPcSpwbbPG0oTZV9KiJhe+M0uXzgYbWh4YdPdjhuP0Sib93Jil9xa
 ku+RgHwemoUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="354153890"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2020 21:49:44 -0800
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v15 0/2] pwm: intel: Add PWM driver for a new SoC
Date:   Thu,  5 Nov 2020 13:49:38 +0800
Message-Id: <cover.1604555266.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Patch 1 adds dt binding document in YAML format.
Patch 2 add PWM fan controller driver for LGM SoC.

v15:
- Rebase to latest linux 5.10-rc2

v14:
- Address below review concerns from Uwe Kleine-König.
 * Add limitations info about fixed 2-wire mode support.
 * Rename clk/reset _disable function names to _release.
 * Remove clk & rst from driver data structure. Instead
   use them as arguments.
 * Add pwm_chip.base = -1.
- Resolve missing MODULE_LICENSE warning.

v13:
- Address below review concerns (Philipp Zabel)
 * Make unnecessary 2 line comment as 1 line comment.
 * Move reset_deassert at the last after clk_enable.
 * Remove unnecessary return ret statement from .remove()
- Move platform_set_drvdata() at the top of probe. 

v12:
- Rebase to linux 5.9-rc4
- Add Reviewed-by tags from Andy Shevchenko & Rob Herring.

v11:
- Address below review concerns (Andy Shevchenko)
  * Fix a issue with dev_err_probe() usage & improve the usage.
  * Fix & improve a ordering issue with clk_enable/disable &
    reset_control assert/deassert.

v10:
- Removed unused of_device.h and added platform_device.h
  & mod_devicetable.h

v9:
- Address code quality related review concerns (Andy Shevchenko)
- Use devm_add_action_or_reset() instead of explicit unwind calls.

v8:
- Remove fan related optional properties usage, keep
  them as default. If needed, change pwm-fan driver
  separately in future to add them as generic properties.

v7:
- Address code quality related review concerns.
- Rename fan related property to pwm-*.
- Fix one make dt_binding_check reported error.

v6:
- Readjust .apply op as per review feedback.
- Add back pwm-cells property to resolve make dt_binding_check error.
  pwm-cells is a required property for PWM driver.
- Add back fan related optional properties.

v5:
- Address below review concerns from Uwe Kleine-König.
  * Improve comments about Limitations.
  * Use return value of regmap_update_bits if container function returns
    error code.
  * Modify .apply op to have strict checking for fixed period supported
    by PWM HW.
  * Use u64 as type when use min_t for duty_cycle.
  * Add reset_control_assert() in failure case in probe where it was missing
    earlier.
- Remove fan specific optional properties from pwm dt binding document (Rob Herring)

v4:
- Address below review concerns from Uwe Kleine-König.
  * Improve notes and limitations comments.
  * Add common prefixes for all #defines.
  * Modify/Improve logic in .apply & .get_state ops as advised.
  * Skip error messages in probe when error is -EPROBE_DEFER.
  * Add dependencies in Kconfig (OF & HAS_IOMEM) and add select REGMAP_MMIO.
  * Address other code quality related review concerns.
- Fix make dt_binding_check reported error in YAML file.

v3:
- Address below review concerns from Uwe Kleine-König.
  * Remove fan rpm calibration task from the driver.
  * Modify apply op as per the review feedback.
  * Add roundup & round down where necessary.
  * Address other misc code quality related review concerns.
  * Use devm_reset_control_get_exclusive(). (Philipp Zabel)
  * Improve dt binding document.

v2:
- Address below review concerns from Uwe Kleine-König.
  * Add notes and limitations about PWM HW.
  * Rename all functions and structure to lgm_pwm_* 
  * Readjust space aligninment in structure fields to single space.
  * Switch to using apply instead of config/enable/disable.
  * Address other code quality related concerns.
  * Rebase to 5.8-rc1.
- Address review concerns in dt binding YAML from Rob Herring.

v1:
- Initial version.


Rahul Tanwar (2):
  Add DT bindings YAML schema for PWM fan controller of LGM SoC
  Add PWM fan controller driver for LGM SoC

 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     |  44 ++++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-intel-lgm.c                        | 244 +++++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

-- 
2.11.0

