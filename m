Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B7443C9A4
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Oct 2021 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbhJ0Mal (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbhJ0Mak (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Oct 2021 08:30:40 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CCAC061570
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 05:28:14 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:441:6c1a:bc30:46e])
        by michel.telenet-ops.be with bizsmtp
        id B0UA2600W2hfXWm060UAsc; Wed, 27 Oct 2021 14:28:13 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfi2M-008Toa-GS; Wed, 27 Oct 2021 14:28:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfi2M-00DsGj-2t; Wed, 27 Oct 2021 14:28:10 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: pwm: tpu: Add R-Car V3U device tree bindings
Date:   Wed, 27 Oct 2021 14:28:09 +0200
Message-Id: <8ec1e2aadfc894a3cc8c412e266b87220fa0404e.1635337616.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Duc Nguyen <duc.nguyen.ub@renesas.com>

Add device tree bindings for TPU with the PWM controller found
on R-Car V3U SoCs.

Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index 81ccb2110162c3eb..0171a04257b808e7 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -38,6 +38,7 @@ properties:
           - renesas,tpu-r8a77965  # R-Car M3-N
           - renesas,tpu-r8a77970  # R-Car V3M
           - renesas,tpu-r8a77980  # R-Car V3H
+          - renesas,tpu-r8a779a0  # R-Car V3U
       - const: renesas,tpu
 
   reg:
-- 
2.25.1

