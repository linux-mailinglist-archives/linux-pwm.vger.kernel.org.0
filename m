Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543AC632922
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Nov 2022 17:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKUQNs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Nov 2022 11:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKUQNr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Nov 2022 11:13:47 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A661D28A8
        for <linux-pwm@vger.kernel.org>; Mon, 21 Nov 2022 08:13:46 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
        by michel.telenet-ops.be with bizsmtp
        id n4Dk2802A5WXlCv064DkBW; Mon, 21 Nov 2022 17:13:45 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox9QW-0019JO-84; Mon, 21 Nov 2022 17:13:44 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox9QV-00BS3c-NG; Mon, 21 Nov 2022 17:13:43 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] dt-bindings: pwm: renesas,tpu: Add r8a779g0 support
Date:   Mon, 21 Nov 2022 17:13:42 +0100
Message-Id: <ccdf2ccb5aeb9329d959599069d60177fe34e892.1669047191.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
R-Car V4H (R8A779G0) SoC.

Based on a patch in the BSP by CongDang.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v2:
  - Add Acked-by, Reviewed-by.
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index c6b2ab56b7feade7..a3e52b22dd180422 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -40,6 +40,7 @@ properties:
           - renesas,tpu-r8a77970  # R-Car V3M
           - renesas,tpu-r8a77980  # R-Car V3H
           - renesas,tpu-r8a779a0  # R-Car V3U
+          - renesas,tpu-r8a779g0  # R-Car V4H
       - const: renesas,tpu
 
   reg:
-- 
2.25.1

