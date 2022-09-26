Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FF15EA91F
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Sep 2022 16:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiIZOyq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Sep 2022 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiIZOyX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Sep 2022 10:54:23 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0C56925AE;
        Mon, 26 Sep 2022 06:21:22 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,346,1654527600"; 
   d="scan'208";a="133987294"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Sep 2022 22:21:21 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A68F8400544F;
        Mon, 26 Sep 2022 22:21:16 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Date:   Mon, 26 Sep 2022 14:21:06 +0100
Message-Id: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
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

The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
channels and one 32-bit timer channel. It supports the following
functions
 - Counter
 - Timer
 - PWM

This patch series aim to add MFD and counter driver for MTU3a.
Subsequent patch seies will add TImer and PWM driver support
also enhancements to counter driver.

The 8/16/32 bit registers are mixed in each channel. The HW
specifications of the IP is described in patch#2.

Current patch set is tested for 16-bit phase counting mode on
MTU1 channel.

Please share your valuable comments on this patch series.

Biju Das (8):
  clk: renesas: r9a07g044: Add MTU3a clock and reset entry
  dt-bindings: mfd: Document RZ/G2L MTU3a bindings
  mfd: Add RZ/G2L MTU3 driver
  dt-bindings: mfd: rzg2l-mtu3: Document RZ/G2UL MTU3 counter
  counter: Add RZ/G2L MTU3 counter driver
  arm64: dts: renesas: r9a07g044: Add MTU3a node
  arm64: dts: renesas: r9a07g054: Add MTU3a node
  arm64: dts: renesas: rzg2l-smarc: [HACK] Enable MTU for 16-bit phase
    count testing

 .../bindings/mfd/renesas,rzg2l-mtu3.yaml      | 310 ++++++++++++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  83 ++++
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |   2 -
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  83 ++++
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  |  11 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  25 +-
 drivers/clk/renesas/r9a07g044-cpg.c           |   5 +-
 drivers/counter/Kconfig                       |   9 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/rzg2l-mtu3-cnt.c              | 367 +++++++++++++++++
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/rzg2l-mtu3.c                      | 377 ++++++++++++++++++
 include/linux/mfd/rzg2l-mtu3.h                | 124 ++++++
 14 files changed, 1403 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
 create mode 100644 drivers/counter/rzg2l-mtu3-cnt.c
 create mode 100644 drivers/mfd/rzg2l-mtu3.c
 create mode 100644 include/linux/mfd/rzg2l-mtu3.h

-- 
2.25.1

