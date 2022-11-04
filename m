Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E95619AC9
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Nov 2022 16:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiKDPCW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Nov 2022 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiKDPCA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Nov 2022 11:02:00 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47EDC31EF4;
        Fri,  4 Nov 2022 07:59:45 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.96,137,1665414000"; 
   d="scan'208";a="138998455"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2022 23:59:44 +0900
Received: from localhost.localdomain (unknown [10.226.93.164])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0F6494358A4A;
        Fri,  4 Nov 2022 23:59:40 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/3] Add support for linking gpt with poeg
Date:   Fri,  4 Nov 2022 14:59:35 +0000
Message-Id: <20221104145938.1782464-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Renesas RZ/G2L gpt supports output pin disable function by dead time
error and detecting short-circuits between output pins. There are 4
poeg groups shared between gpt channels.

This patch adds support for linking poeg group with gpt channel, so that
gpt channel can control the output disable function through poeg module(port
output enable for gpt)

patch#1 is just added to avoid bot errors.

Patch#3 depend upon [1]
[1] https://lore.kernel.org/linux-renesas-soc/20221028104231.220426-3-biju.das.jz@bp.renesas.com/T/#u

Biju Das (3):
  dt-bindings: pwm: Add RZ/G2L GPT binding
  dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
  pwm: rzg2l-gpt: Add support for linking with poeg

 .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 397 ++++++++++++++++++
 drivers/pwm/pwm-rzg2l-gpt.c                   |  69 +++
 2 files changed, 466 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml


base-commit: 0cdb3579f1ee4c1e55acf8dfb0697b660067b1f8
prerequisite-patch-id: 7fc6823735fb2b0b321ece8ee749e9a987ca0da6
-- 
2.25.1

