Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3E1521E5E
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 17:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiEJP17 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 11:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345651AbiEJPZx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 11:25:53 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A06DAC07E;
        Tue, 10 May 2022 08:11:20 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,214,1647270000"; 
   d="scan'208";a="120533845"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 May 2022 00:11:19 +0900
Received: from localhost.localdomain (unknown [10.226.92.112])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 81E3C400A11D;
        Wed, 11 May 2022 00:11:15 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [RFC 0/8] Add RZ/G2L POEG support
Date:   Tue, 10 May 2022 16:11:04 +0100
Message-Id: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The output pins of the general PWM timer (GPT) can be disabled by using
the port output enabling function for the GPT (POEG). Specifically,
either of the following ways can be used.
  * Input level detection of the GTETRGA to GTETRGD pins.
  * Output-disable request from the GPT.
  * Register settings.

Added RZ/G2L POEG support under driver/soc/renesas, as currently I am not sure about
the framework to be used for POEG.

This patch series add support for controlling output disable function using sysfs.

For output disable operation, POEG group needs to be linked with
GPT. So introduced renesas,poeg-group property in pwm for linking both GPT and
POEG devices.

Please share your valuable comments.

patch#3 and #4 depend upon [1]
[1] https://lore.kernel.org/linux-renesas-soc/20220510144259.9908-1-biju.das.jz@bp.renesas.com/T/#t

Biju Das (8):
  dt-bindings: soc: renesas: Add RZ/G2L POEG binding
  drivers: soc: renesas: Add POEG driver support
  dt-bindings: pwm: rzg2l-gpt: Document renesas,poeg-group property
  pwm: rzg2l-gpt: Add support for linking with POEG
  arm64: dts: renesas: r9a07g044: Add POEG nodes
  arm64: dts: renesas: r9a07g054: Add POEG nodes
  arm64: dts: renesas: rzg2l-smarc: Enable POEGG{A,B,C,D} on carrier
    board
  arm64: dts: renesas: rzg2l-smarc: Link GPT4 with POEGGD on carrier
    board

 .../bindings/pwm/renesas,rzg2l-gpt.yaml       |   8 +
 .../soc/renesas/renesas,rzg2l-poeg.yaml       |  65 ++++++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  44 ++++++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  44 ++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  17 ++
 drivers/pwm/pwm-rzg2l-gpt.c                   |  59 +++++++
 drivers/soc/renesas/Kconfig                   |   2 +
 drivers/soc/renesas/Makefile                  |   2 +
 drivers/soc/renesas/poeg/Kconfig              |  12 ++
 drivers/soc/renesas/poeg/Makefile             |   2 +
 drivers/soc/renesas/poeg/poeg-rzg2l.c         | 148 ++++++++++++++++++
 11 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-poeg.yaml
 create mode 100644 drivers/soc/renesas/poeg/Kconfig
 create mode 100644 drivers/soc/renesas/poeg/Makefile
 create mode 100644 drivers/soc/renesas/poeg/poeg-rzg2l.c

-- 
2.25.1

