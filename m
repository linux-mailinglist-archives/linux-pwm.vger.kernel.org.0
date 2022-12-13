Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD1064BC79
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Dec 2022 19:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiLMS6k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Dec 2022 13:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiLMS6h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Dec 2022 13:58:37 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61FBC218A5;
        Tue, 13 Dec 2022 10:58:35 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="146047105"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Dec 2022 03:58:34 +0900
Received: from localhost.localdomain (unknown [10.226.93.72])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2F61A40B1019;
        Wed, 14 Dec 2022 03:58:29 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v3 0/4] Add RZ/V2{M, MA} PWM driver support
Date:   Tue, 13 Dec 2022 18:58:23 +0000
Message-Id: <20221213185827.2012004-1-biju.das.jz@bp.renesas.com>
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
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  98 +++++
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rzv2m.c                       | 398 ++++++++++++++++++
 6 files changed, 668 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzv2m-pwm.yaml
 create mode 100644 drivers/pwm/pwm-rzv2m.c

-- 
2.25.1

