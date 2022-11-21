Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E142A63291E
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Nov 2022 17:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiKUQNQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Nov 2022 11:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKUQNN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Nov 2022 11:13:13 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30178D2DF7
        for <linux-pwm@vger.kernel.org>; Mon, 21 Nov 2022 08:13:11 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
        by michel.telenet-ops.be with bizsmtp
        id n4D8280055WXlCv064D83p; Mon, 21 Nov 2022 17:13:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox9Ps-0019J7-Am; Mon, 21 Nov 2022 17:13:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox9Pr-00BS1U-HA; Mon, 21 Nov 2022 17:13:03 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] dt-bindings: pwm: renesas,pwm-rcar: Add r8a779g0 support
Date:   Mon, 21 Nov 2022 17:13:02 +0100
Message-Id: <2d1732595327307080c57e201a7f029f8adeabf3.1669047149.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document support for the PWM timers in the Renesas R-Car V4H (R8A779G0)
SoC.

Based on a patch in the BSP by CongDang.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v2:
  - Add Acked-by, Reviewed-by.
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 1c94acbc2b4a0384..4c80970106877e55 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -35,6 +35,7 @@ properties:
           - renesas,pwm-r8a77980  # R-Car V3H
           - renesas,pwm-r8a77990  # R-Car E3
           - renesas,pwm-r8a77995  # R-Car D3
+          - renesas,pwm-r8a779g0  # R-Car V4H
       - const: renesas,pwm-rcar
 
   reg:
-- 
2.25.1

