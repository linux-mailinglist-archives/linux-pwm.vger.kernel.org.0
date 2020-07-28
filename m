Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F42305C3
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 10:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgG1IwV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 04:52:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:42527 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgG1IwV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Jul 2020 04:52:21 -0400
IronPort-SDR: HAoIyWTWtz5Dyp+kXH6hwDFNmLR1MfhbCpSKOQEWm9JQB85s5VWqFassPpD9btkuq7pRaJnloy
 Ds5rJ9I3MXpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="212696884"
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="scan'208";a="212696884"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 01:52:20 -0700
IronPort-SDR: 7Eu85jCfqD2RtO1KPp5GMOXZv1sOFQPa57rGgy8qas5XMQeBLn5hEPXT3JVtqi179nK69V5eEu
 V5gmhNa7ce/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="scan'208";a="312534773"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2020 01:52:16 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v6 0/2] pwm: intel: Add PWM driver for a new SoC
Date:   Tue, 28 Jul 2020 16:52:11 +0800
Message-Id: <cover.1595926036.git.rahul.tanwar@linux.intel.com>
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

 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     |  54 +++++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-intel-lgm.c                        | 268 +++++++++++++++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

-- 
2.11.0

