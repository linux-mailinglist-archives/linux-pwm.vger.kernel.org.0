Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C865FA07C
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Oct 2022 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJJOwc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Oct 2022 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJJOwc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Oct 2022 10:52:32 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A0CC40BEB;
        Mon, 10 Oct 2022 07:52:30 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.95,173,1661785200"; 
   d="scan'208";a="138354530"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Oct 2022 23:52:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B1CA842F5162;
        Mon, 10 Oct 2022 23:52:24 +0900 (JST)
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
Subject: [PATCH v4 0/4] Add RZ/G2L MTU3a MFD, Counter and pwm driver
Date:   Mon, 10 Oct 2022 15:52:18 +0100
Message-Id: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
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

v3->v4:
 * Dropped counter and pwm compatibeles as they don't have any resources.
 * Made rz-mtu3 as pwm provider.
 * Updated the example and description.
 * A single driver that registers both the counter and the pwm functionalities
   that binds against "renesas,rz-mtu3".
 * Moved PM handling from child devices to here.
 * replaced include/linux/mfd/rz-mtu3.h->drivers/mfd/rz-mtu3.h
 * Removed "remove" callback from mfd driver
 * There is no resource associated with "rz-mtu3-counter" and "rz-mtu3-pwm"
   compatible and moved the code to mfd subsystem as it binds against "rz-mtu".
 * Removed struct platform_driver rz_mtu3_cnt_driver.
 * Removed struct platform_driver rz_mtu3_pwm_driver.
 * Updated commit description
 * Updated Kconfig description
 * Added macros RZ_MTU3_16_BIT_MTU{1,2}_CH for MTU1 and MTU2 channels
 * Added RZ_MTU3_GET_HW_CH macro for getting channel ID.
 * replaced priv->ch[id]->priv->ch[0] in rz_mtu3_count_read()
 * Cached counter max values
 * replaced cnt->tsr in rz_mtu3_count_direction_read()
 * Added comments for RZ_MTU3_TCR_CCLR_NONE
 * Replaced if with switch in rz_mtu3_initialize_counter() and
   rz_mtu3_count_ceiling_write()
 * Added locks in initialize, terminate and enable_read to prevent races.
 * Updated rz_mtu3_action_read to take care of MTU2 signals.
 * Added separate distinct array for each group of Synapse.
 * Moved pm handling to parent.
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
  mfd: Add RZ/G2L MTU3 counter driver
  mfd: Add RZ/G2L MTU3 PWM driver

 .../bindings/mfd/renesas,rz-mtu3.yaml         | 305 ++++++++++
 drivers/mfd/Kconfig                           |  26 +
 drivers/mfd/Makefile                          |   5 +
 drivers/mfd/rz-mtu3-cnt.c                     | 554 ++++++++++++++++++
 drivers/mfd/rz-mtu3-core.c                    | 476 +++++++++++++++
 drivers/mfd/rz-mtu3-pwm.c                     | 405 +++++++++++++
 drivers/mfd/rz-mtu3.h                         | 221 +++++++
 7 files changed, 1992 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
 create mode 100644 drivers/mfd/rz-mtu3-cnt.c
 create mode 100644 drivers/mfd/rz-mtu3-core.c
 create mode 100644 drivers/mfd/rz-mtu3-pwm.c
 create mode 100644 drivers/mfd/rz-mtu3.h

-- 
2.25.1

