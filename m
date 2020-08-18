Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB2C247E0A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Aug 2020 07:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHRFtP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Aug 2020 01:49:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:48150 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgHRFtO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 18 Aug 2020 01:49:14 -0400
IronPort-SDR: FxB8RwrW19hl0WaOyfQm+iLHWe386o/1tHoEtsUtfn3wNztn2B1cMcZ+8pV7DrjJ3jqn+Wcc7w
 e6c00cYrN/Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142474100"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="142474100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:49:13 -0700
IronPort-SDR: 7LFrpTXIbE7VBQNOg+PkBf4RrKVUPE5ldPSHtmlkHidlSm04A9JSkcjDnmZwMaF6qEolZ/c9AF
 coAs1ei7IuLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="319972150"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2020 22:49:10 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v7 0/2] pwm: intel: Add PWM driver for a new SoC
Date:   Tue, 18 Aug 2020 13:48:59 +0800
Message-Id: <cover.1597729246.git.rahul.tanwar@linux.intel.com>
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
- Address below review concerns from Uwe Kleine-K�nig.
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
- Address below review concerns from Uwe Kleine-K�nig.
  * Improve notes and limitations comments.
  * Add common prefixes for all #defines.
  * Modify/Improve logic in .apply & .get_state ops as advised.
  * Skip error messages in probe when error is -EPROBE_DEFER.
  * Add dependencies in Kconfig (OF & HAS_IOMEM) and add select REGMAP_MMIO.
  * Address other code quality related review concerns.
- Fix make dt_binding_check reported error in YAML file.

v3:
- Address below review concerns from Uwe Kleine-K�nig.
  * Remove fan rpm calibration task from the driver.
  * Modify apply op as per the review feedback.
  * Add roundup & round down where necessary.
  * Address other misc code quality related review concerns.
  * Use devm_reset_control_get_exclusive(). (Philipp Zabel)
  * Improve dt binding document.

v2:
- Address below review concerns from Uwe Kleine-K�nig.
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
 drivers/pwm/pwm-intel-lgm.c                        | 267 +++++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

-- 
2.11.0

