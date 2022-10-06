Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8175F68A1
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Oct 2022 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiJFN53 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Oct 2022 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJFN52 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Oct 2022 09:57:28 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB738915F6;
        Thu,  6 Oct 2022 06:57:26 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.95,164,1661785200"; 
   d="scan'208";a="137903235"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Oct 2022 22:57:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4D5EC53EEFC8;
        Thu,  6 Oct 2022 22:57:20 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 0/4] Add RZ/G2L MTU3a MFD, Counter and pwm driver
Date:   Thu,  6 Oct 2022 14:57:13 +0100
Message-Id: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
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

This patch series aim to add MFD and pwm driver for MTU3a.

The 8/16/32 bit registers are mixed in each channel. The HW
specifications of the IP is described in patch#1.

Current patch set is tested for PWM mode1 on MTU3 channel
and 16 and 32 bit phase counting modes.

v2->v3:
 * Dropped counter bindings and integrated with mfd as it has only one property.
 * Removed "#address-cells" and "#size-cells" as it do not have children with
   unit addresses.
 * Removed quotes from counter and pwm.
 * Provided full path for pwm bindings.
 * Updated the binding example.
 * removed unwanted header files
 * Added LUT for 32 bit registers as it needed for 32-bit cascade counting.
 * Exported 32 bit read/write functions.
 * Modelled as a counter device supporting 3 counters(2 16-bit and 
   32-bit)
 * Add kernel-doc comments to document struct rz_mtu3_cnt
 * Removed mmio variable from struct rz_mtu3_cnt
 * Removed cnt local variable from rz_mtu3_count_read()
 * Replaced -EINVAL->-ERANGE for out of range error conditions.
 * Removed explicit cast from write functions.
 * Removed local variable val from rz_mtu3_count_ceiling_read()
 * Added lock for RMW for counter/ceiling updates.
 * Added different synapses for counter0 and counter{1,2}
 * Used ARRAY for assigning num_counts.
 * Added PM runtime for managing clocks.
 * Add MODULE_IMPORT_NS(COUNTER) to import the COUNTER namespace.

RFC->v2:
 * replaced devm_reset_control_get->devm_reset_control_get_exclusive
 * Dropped 'bindings' from the binding title
 * Updated the binding example
 * Added additionalProperties: false for counter bindings
 * Squashed all the binding patches
 * Modelled as a single counter device providing both 16-bit
   and 32-bit phase counting modes
 * Modelled as a single pwm device for supporting different pwm modes.
 * Moved counter and pwm bindings to respective subsystems.

Biju Das (4):
  dt-bindings: mfd: Document RZ/G2L MTU3a bindings
  mfd: Add RZ/G2L MTU3 driver
  pwm: Add support for RZ/G2L MTU3 PWM
  counter: Add RZ/G2L MTU3 counter driver

 .../bindings/mfd/renesas,rz-mtu3.yaml         | 304 ++++++++++
 .../bindings/pwm/renesas,rz-mtu3-pwm.yaml     |  50 ++
 drivers/counter/Kconfig                       |   9 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/rz-mtu3-cnt.c                 | 568 ++++++++++++++++++
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/rz-mtu3.c                         | 436 ++++++++++++++
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rz-mtu3.c                     | 462 ++++++++++++++
 include/linux/mfd/rz-mtu3.h                   | 183 ++++++
 12 files changed, 2035 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rz-mtu3-pwm.yaml
 create mode 100644 drivers/counter/rz-mtu3-cnt.c
 create mode 100644 drivers/mfd/rz-mtu3.c
 create mode 100644 drivers/pwm/pwm-rz-mtu3.c
 create mode 100644 include/linux/mfd/rz-mtu3.h

-- 
2.25.1

