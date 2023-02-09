Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9569095A
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Feb 2023 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjBIM5I (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Feb 2023 07:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBIM5H (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Feb 2023 07:57:07 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0DD383EF;
        Thu,  9 Feb 2023 04:57:04 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,283,1669042800"; 
   d="scan'208";a="149037931"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Feb 2023 21:57:03 +0900
Received: from localhost.localdomain (unknown [10.226.92.132])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 13F1543191A6;
        Thu,  9 Feb 2023 21:56:59 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v4 0/4] Add RZ/V2{M, MA} PWM driver support
Date:   Thu,  9 Feb 2023 12:56:52 +0000
Message-Id: <20230209125656.191905-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The RZ/V2{M, MA} PWM Timer (PWM) is composed of 16 channels. Linux is only
allowed access to channels 8 to 14 on RZ/V2M, while there is no restriction
for RZ/V2MA.

The RZ/V2{M, MA} PWM Timer (PWM) supports the following functions:
 * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
 * The frequency division ratio for internal counter operation is selectable
    as PWM_CLK divided by 1, 16, 256, or 2048.
 * The period as well as the duty cycle is adjustable.
 * The low-level and high-level order of the PWM signals can be inverted.
 * The duty cycle of the PWM signal is selectable in the range from 0 to 100%.
 * The minimum resolution is 20.83 ns.
 * Three interrupt sources: Rising and falling edges of the PWM signal and
   clearing of the counter
 * Counter operation and the bus interface are asynchronous and both can
   operate independently of the magnitude relationship of the respective
   clock periods.

v3->v4:
 * Documented the hardware properties in "Limitations" section
 * Dropped the macros F2CYCLE_NSEC, U24_MASK and U24_MAX.
 * Added RZV2M_PWMCYC_PERIOD macro for U24_MAX
 * Dropped rzv2m_pwm_freq_div variable and started using 1 << (4 * i) for
   calculating divider as it is power of 16.
 * Reordered the functions to have rzv2m_pwm_config() directly before
   rzv2m_pwm_apply().
 * Improved the logic for calculating period and duty cycle in config()
 * Merged multiple RZV2M_PWMCTR register writes to a single write in config()
 * replaced pwm_is_enabled()->pwm->state.enabled
 * Avoided assigning bit value as enum pwm_polarity instead used enum constant.
 * Fixed various issues in probe error path.
 * Updated the logic for PWM cycle setting register
 * A 100% duty cycle is only possible with PWMLOW > PWMCYC. So restricting
   PWMCYC values < 0xffffff  
 * The native polarity of the hardware is inverted (i.e. it starts with the
 * low part). So switched the inversion bit handling.
v2->v3:
 * Removed clock patch#1 as it is queued for 6.3 renesas-clk
 * Added Rb tag from Geert for bindings and dt patches
 * Added return code for rzv2m_pwm_get_state()
 * Added comment in rzv2m_pwm_reset_assert_pm_disable()
v1->v2:
 * Updated commit description
 * Replaced pwm8_15_pclk->cperi_grpf
 * Added reset entry R9A09G011_PWM_GPF_PRESETN
 * Added Rb tag from Krzysztof for bindings and the keep the Rb tag as 
   the below changes are trivial
 * Updated the description for APB clock
 * Added resets required property
 * Updated the example with resets property
 * Replaced devm_reset_control_get_optional_shared->devm_reset_control_get_shared
 * Added resets property in pwm nodes.

Note:
 Hardware manual for this IP can be found here
 https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-hardware?language=en

Biju Das (4):
  dt-bindings: pwm: Add RZ/V2M PWM binding
  pwm: Add support for RZ/V2M PWM driver
  arm64: dts: renesas: r9a09g011: Add pwm nodes
  arm64: dts: renesas: rzv2m evk: Enable pwm

 .../bindings/pwm/renesas,rzv2m-pwm.yaml       |  90 ++++
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |  70 +++
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  98 ++++
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rzv2m.c                       | 436 ++++++++++++++++++
 6 files changed, 706 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rzv2m.c

-- 
2.25.1

