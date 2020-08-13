Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64595243CF4
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Aug 2020 18:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHMQG2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Aug 2020 12:06:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:58407 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMQG2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 13 Aug 2020 12:06:28 -0400
IronPort-SDR: W4AhPJqObnHcKsEPTA/nh9xn3m86tGuvrEe1h2wRUd6kys3gUCIwapwkP5PMInIhVPSADkzhFe
 hF85zVq7V38g==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="133778905"
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="133778905"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 09:06:25 -0700
IronPort-SDR: lL/mnoN1yKIf023OJeY4X2w9mxUrz372TA0rvUmKxb6qyP3kYtEJ9eBxCVLAaq82+BHzteZWCR
 fFcKDy6dZhjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="439824466"
Received: from vgjayaku-ilbpg7.png.intel.com ([10.88.227.96])
  by orsmga004.jf.intel.com with ESMTP; 13 Aug 2020 09:06:23 -0700
From:   vineetha.g.jaya.kumaran@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: [PATCH v3 0/2] Add PWM support for Intel Keem Bay SoC
Date:   Fri, 14 Aug 2020 00:04:04 +0800
Message-Id: <1597334646-21087-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
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

 .../devicetree/bindings/pwm/intel,keembay-pwm.yaml |  47 ++++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-keembay.c                          | 236 +++++++++++++++++++++
 4 files changed, 293 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
 create mode 100644 drivers/pwm/pwm-keembay.c

-- 
1.9.1

