Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3760C460EE0
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Nov 2021 07:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbhK2Gr3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Nov 2021 01:47:29 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:55499 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243963AbhK2Gp3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Nov 2021 01:45:29 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1AT6HcpA024517;
        Mon, 29 Nov 2021 14:17:38 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Nov
 2021 14:42:05 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <lee.jones@linaro.org>,
        <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <p.zabel@pengutronix.de>, <billy_tsai@aspeedtech.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v13 0/2] Support pwm driver for aspeed ast26xx
Date:   Mon, 29 Nov 2021 14:43:27 +0800
Message-ID: <20211129064329.27006-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1AT6HcpA024517
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The legacy driver of aspeed pwm is binding with tach controller and it
doesn't follow the pwm framworks usage. In addition, the pwm register
usage of the 6th generation of ast26xx has drastic change. So these
patch serials add the new aspeed pwm driver to fix up the problem above.

Change since v12:
- pwm-aspeed-ast2600.c
  - Fix the comment about the duty cycle and period of the PWM.
  - Configured to max period when request period > max period.
  - Remove unnecessary curly braces.

Change since v11:
- pwm-aspeed-ast2600.c
  - Request reset controller before clock enable.

Change since v10:
- pwm-aspeed-ast2600.c
  - Add more comment to explain the feature of PWM
  - Fix the naming of some parameters.
  - Set pin_enable and clk_enable at the same time.
  - Always set fixed divisor to hw register when apply.

Change since v9:
- dt-bindings:
  - Change the naming of tach subnode channel setting property to
  aspeed,tach-ch.
- pwm-aspeed-ast2600.c
  - Fix the naming of some parameters.
  - Capitalise error messages.
  - Handling potentially mult overflow when .apply

Change since v8:
- pwm-aspeed-ast2600.c
  - Replace "* _BITULL(div_h)" to "<< div_h"
  - Fix duty_cycle precision problem.
  - Add the comment about the formula of duty_cycle.

Change since v7:
- pwm-aspeed-g6.c
  - Rename the driver: pwm-aspeed-g6.c -> pwm-aspeed-ast2600.c.
  - Macro remove "_CH" part of the register name.
  - Unroll the aspeed_pwm_get_period and remove it.
  - Simplify the formula to get duty_pt
  - Reduce the number of writing register. Organize all the fields and
    write them at once.

Change since v6:
- dt-bindings:
  - Add blank line between each DT property.
  - Change the sub-node name from fan to tach-ch.
- pwm-aspeed-g6.c
  - Merge aspeed_pwm_set_period and aspeed_pwm_set_duty into .apply.
  - Convert the factor type to u64 when calculating the period value.
  - Using ROUND_UP strategy to calculate div_h for finer resolution.

Change since v5:
- pwm-aspeed-g6.c suggested by Uwe Kleine-König
  - Move the divide at the end of the calculation.
  - Unified the prefix of the function name.
  - Use div64_u64 to calculate the divider of frequency.

Change since v4:
- dt_binding:
  - pwm/tach yaml: Replace child-node with additionalProperties
  - pwm-tach yaml: Replace child-node with patternProperties
- pwm-aspeed-g6.c suggested by Uwe Kleine-König
  - The bit definitions contained the name of the register.
  - Remove single caller function and fold it to the caller.
  - Avoid to divide by the result of a division.
  - Remove unnecessary condition in .apply().
  - Use goto for error handling

Changes since v3:
- Add the dt_binding for aspeed,ast2600-tach.
- Describe the pwm/tach as child-node of pwm-tach mfd.
- Complete the properties of pwm node.

Changes since v2:
- Remove the tach node, #address-cells and #size-cells from pwm-tach.yaml
- Add clocks and reset properties to pwm-tach.yaml
- Kconfig/Makfile sorted alphabetically
- pwm-aspeed-g6.c suggested by Uwe Kleine-König
  - Add more hardware descriptions at top of the driver.
  - Remove unused api request and free
  - Move the initialize settings of all pwm channel to probe.
  - Change the method of getting the approximate period.
  - Read the hardware register values to fill the state for .get_state()

Changes since v1:
- Fix the dt_binding_check fail suggested by Rob Herring
- Add depends to PWM_ASPEED_G6 configure suggested by Uwe Kleine-Konig
- pwm-aspeed-g6.c suggested by Uwe Kleine-König
  - Fix license header
  - Use bitfiled.h macro to define register fields
  - Implement .remove device function
  - Implement .get_state pwm api

Billy Tsai (2):
  dt-bindings: Add bindings for aspeed pwm-tach.
  pwm: Add Aspeed ast2600 PWM support

 .../bindings/hwmon/aspeed,ast2600-tach.yaml   |  68 ++++
 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  76 ++++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  64 ++++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-aspeed-ast2600.c              | 327 ++++++++++++++++++
 6 files changed, 546 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
 create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c

-- 
2.25.1

