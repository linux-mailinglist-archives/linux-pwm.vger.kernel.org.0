Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCD422A9E7
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgGWHoZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 03:44:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:57096 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgGWHoZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 23 Jul 2020 03:44:25 -0400
IronPort-SDR: gUqfeC/UCMCYIIpoYwC/eZ/69fOrjB1K/uf8xLhwUDN2zIDE0fVxZmIa4lZkv+9ZrUatFaKOpb
 qKjDHiwUf1Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="137978889"
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="137978889"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 00:44:24 -0700
IronPort-SDR: CbufD7Mhkp5Kw7TdKN24b9meL/Ov70j6yVSll5UkkqtiuSbM2koxkRdd3zLj9oLBVognjxxN5X
 kXAY3507eE+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="310935025"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 00:44:21 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v5 0/2] pwm: intel: Add PWM driver for a new SoC
Date:   Thu, 23 Jul 2020 15:44:16 +0800
Message-Id: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
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

Patch series is baselined on linux 5.8-rc5.

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

 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     |  40 +++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-intel-lgm.c                        | 269 +++++++++++++++++++++
 4 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

-- 
2.11.0

