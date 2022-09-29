Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72D75EF374
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Sep 2022 12:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiI2Kax (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Sep 2022 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiI2Kaw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Sep 2022 06:30:52 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 711BCEEB62;
        Thu, 29 Sep 2022 03:30:51 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,354,1654527600"; 
   d="scan'208";a="136619448"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Sep 2022 19:30:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 590F9400F7A2;
        Thu, 29 Sep 2022 19:30:46 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH RFC 0/7] Add RZ/G2L MTU3 PWM driver
Date:   Thu, 29 Sep 2022 11:30:36 +0100
Message-Id: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
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

Add support for RZ/G2L MTU3 PWM driver. The IP supports
following PWM modes

1) PWM mode 1
2) PWM mode 2
3) Reset-synchronized PWM mode
4) Complementary PWM mode 1 (transfer at crest)
5) Complementary PWM mode 2 (transfer at trough)
6) Complementary PWM mode 3 (transfer at crest and trough)

This patch adds basic pwm mode 1 support for RZ/G2L MTU3 driver
by creating separate logical channels for each IOs.

Current patch set is tested with PWM mode 1 on the MTU3 channel
that has 2 IO's.

Please share your valuable comments on this patch series.

This RFC patch series depend upon MFD driver[1]
[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220926132114.60396-4-biju.das.jz@bp.renesas.com/

Biju Das (7):
  dt-bindings: mfd: Document RZ/G2L MTU3a bindings
  dt-bindings: mfd: rzg2l-mtu3: Document RZ/G2L MTU3 counter
  dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3 PWM
  pwm: Add support for RZ/G2L MTU3 PWM
  arm64: dts: renesas: r9a07g044: Add MTU3 PWM support
  arm64: dts: renesas: r9a07g054: Add MTU3 PWM support
  arm64: dts: renesas: rzg2l-smarc: [HACK] Enable MTU3 PWM channel 3 for
    PWM mode 1 testing

 .../bindings/mfd/renesas,rzg2l-mtu3.yaml      | 360 ++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  42 ++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  42 ++
 .../boot/dts/renesas/rz-smarc-common.dtsi     |   2 +
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  |  11 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |   5 +
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  20 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rz-mtu3.c                     | 384 ++++++++++++++++++
 10 files changed, 878 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
 create mode 100644 drivers/pwm/pwm-rz-mtu3.c

-- 
2.25.1

