Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40120D454
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 21:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgF2TH0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 15:07:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:62620 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730502AbgF2TG3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Jun 2020 15:06:29 -0400
IronPort-SDR: lXLlsiyBLxFrrdh6m5nEbpukwALCQwYGdSBa60m+AnJjcsH8h6N4Sx1L/EjS5V6Nwhz2pQVMXx
 ZbZFvrrZZWpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="126073966"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="126073966"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 02:03:54 -0700
IronPort-SDR: MZhnpP0pf2VFgb3b6QVjSS5RQR+MAR2w6scdr+baj26AvOvJbZ1qMyqYScOr3zZjjoytDrcjPN
 fSCyVzcsx7MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="386338695"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2020 02:03:51 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 0/2] pwm: intel: Add PWM driver for a new SoC
Date:   Mon, 29 Jun 2020 17:03:45 +0800
Message-Id: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
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

Patch series is baselined on linux 5.8-rc2.

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

 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     |  51 ++++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-intel-lgm.c                        | 265 +++++++++++++++++++++
 4 files changed, 326 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

-- 
2.11.0

