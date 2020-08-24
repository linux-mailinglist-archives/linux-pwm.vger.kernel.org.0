Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47C24F18E
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 05:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHXDgo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Aug 2020 23:36:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:5441 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgHXDgn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 23 Aug 2020 23:36:43 -0400
IronPort-SDR: pdUjgg4ZTh4z+WweoKdF5mU7yHvfrLr3GTq38VsjBcUFZ+Gx1oyG/rV5f+ETv3vgrQpSIW151c
 aur9N5hYCBnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="135899568"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="135899568"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 20:36:43 -0700
IronPort-SDR: msrS4M8nR96qno0wJZiirWrctNcVFKv/SoOFZCWP8lUj32FBeACjkGiu8+BpQLRop+qMi6V3aG
 RYGK+1/6MUFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="322008258"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2020 20:36:39 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v10 0/2] pwm: intel: Add PWM driver for a new SoC
Date:   Mon, 24 Aug 2020 11:36:35 +0800
Message-Id: <cover.1598240097.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Patch 1 adds dt binding document in YAML format.
Patch 2 add PWM fan controller driver for LGM SoC.

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
 drivers/pwm/pwm-intel-lgm.c                        | 242 +++++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

-- 
2.11.0

