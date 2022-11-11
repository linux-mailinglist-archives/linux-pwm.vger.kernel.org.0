Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0226261E3
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Nov 2022 20:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiKKT3w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Nov 2022 14:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiKKT3v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Nov 2022 14:29:51 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 118EA716C9;
        Fri, 11 Nov 2022 11:29:49 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,157,1665414000"; 
   d="scan'208";a="142340656"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Nov 2022 04:29:48 +0900
Received: from localhost.localdomain (unknown [10.226.92.47])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 69A4C40E20C7;
        Sat, 12 Nov 2022 04:29:45 +0900 (JST)
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
Subject: [PATCH v2 0/3] Add support for linking gpt with poeg
Date:   Fri, 11 Nov 2022 19:29:39 +0000
Message-Id: <20221111192942.717137-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v1->v2:
 * removed quotes from ref
 * Added maxItems and minItems for renesas,poegs property
 * Added enums for gpt index
 * Replaced id->poeg-id as per poeg bindings in patch#3.
 
patch#1 is just added to avoid bot errors.
[1] https://lore.kernel.org/linux-renesas-soc/20221111162325.471963-2-biju.das.jz@bp.renesas.com/T/#u

Patch#3 depend upon [2]
[2] https://lore.kernel.org/linux-renesas-soc/20221111162325.471963-3-biju.das.jz@bp.renesas.com/T/#u

Biju Das (3):
  dt-bindings: pwm: Add RZ/G2L GPT binding
  dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
  pwm: rzg2l-gpt: Add support for linking with poeg

 .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 401 ++++++++++++++++++
 drivers/pwm/pwm-rzg2l-gpt.c                   |  69 +++
 2 files changed, 470 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml

-- 
2.25.1

