Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E8A521E2C
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbiEJP1U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345777AbiEJP0E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 11:26:04 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8042A79809;
        Tue, 10 May 2022 08:11:34 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,214,1647270000"; 
   d="scan'208";a="119261225"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 May 2022 00:11:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.112])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B9675400A0E7;
        Wed, 11 May 2022 00:11:29 +0900 (JST)
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
Subject: [RFC 3/8] dt-bindings: pwm: rzg2l-gpt: Document renesas,poeg-group property
Date:   Tue, 10 May 2022 16:11:07 +0100
Message-Id: <20220510151112.16249-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

For output disable operation, POEG group needs to be linked with
GPT. Document renesas,poeg-group property for linking both GPT and
POEG devices.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
index b57c1b256a86..94be441d742c 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
@@ -89,6 +89,14 @@ properties:
   resets:
     maxItems: 1
 
+  renesas,poeg-group:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    items:
+      maxItems: 1
+    description:
+      phandle to the POEGGroup instance present in the SoC, one for each
+      available GPT channel.
+
 required:
   - compatible
   - reg
-- 
2.25.1

