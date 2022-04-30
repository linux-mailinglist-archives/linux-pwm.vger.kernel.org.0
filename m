Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A3C515B24
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Apr 2022 09:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbiD3ICs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Apr 2022 04:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiD3ICr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Apr 2022 04:02:47 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF7BB91571;
        Sat, 30 Apr 2022 00:59:23 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,187,1647270000"; 
   d="scan'208";a="119653185"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Apr 2022 16:59:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.1])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2887A40078AE;
        Sat, 30 Apr 2022 16:59:17 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [RFC 0/5] Add support for RZ/G2L GPT
Date:   Sat, 30 Apr 2022 08:59:10 +0100
Message-Id: <20220430075915.5036-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
(GPT32E). It supports the following functions
 * 32 bits × 8 channels
 * Up-counting or down-counting (saw waves) or up/down-counting
   (triangle waves) for each counter.
 * Clock sources independently selectable for each channel
 * Two I/O pins per channel
 * Two output compare/input capture registers per channel
 * For the two output compare/input capture registers of each channel,
   four registers are provided as buffer registers and are capable of
   operating as comparison registers when buffering is not in use.
 * In output compare operation, buffer switching can be at crests or
   troughs, enabling the generation of laterally asymmetric PWM waveforms.
 * Registers for setting up frame cycles in each channel (with capability
   for generating interrupts at overflow or underflow)
 * Generation of dead times in PWM operation
 * Synchronous starting, stopping and clearing counters for arbitrary
   channels
 * Starting, stopping, clearing and up/down counters in response to input
   level comparison
 * Starting, clearing, stopping and up/down counters in response to a
   maximum of four external triggers
 * Output pin disable function by dead time error and detected
   short-circuits between output pins
 * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
 * Enables the noise filter for input capture and external trigger
   operation

This patch series aims to add basic pwm support for RZ/G2L GPT driver
by creating separate logical channels for each IOs.

Please share your valuable suggestions.

Biju Das (5):
  dt-bindings: pwm: Add RZ/G2L GPT binding
  pwm: Add support for RZ/G2L GPT
  arm64: dts: renesas: r9a07g044: Add GPT support
  arm64: dts: renesas: r9a07g054: Add GPT support
  [HACK] PWM testing

 .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 104 +++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 192 ++++++++++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 192 ++++++++++
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  |   5 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  14 +
 arch/arm64/configs/defconfig                  |   1 +
 arch/arm64/configs/renesas_defconfig          |   1 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rzg2l-gpt.c                   | 355 ++++++++++++++++++
 10 files changed, 876 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
 create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c

-- 
2.25.1

