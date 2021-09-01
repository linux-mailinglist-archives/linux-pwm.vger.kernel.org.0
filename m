Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E23FD62A
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Sep 2021 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243285AbhIAJIZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Sep 2021 05:08:25 -0400
Received: from www.zeus03.de ([194.117.254.33]:34310 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242790AbhIAJIY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 1 Sep 2021 05:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=+bJyhykuhSaS2X8gnR6myxPsgcX
        eG20Zb4fKQf7fTio=; b=miuqpzzdGCsqrgObJYYUb0hWV0WIMuJCDtClCIJfmO5
        +ZuMbZa9aFaaUzV2uy5IZAZ5GPPJI3bw+3Y5FvFBfkj7FvYxWr+kPH4vZfOPiuCz
        +yN7F7EbBYOgIT2b/TMpdrxFh7MRVK3VhwdIpWfidE2IyA3/iLG7Nh3hzyBXhr84
        =
Received: (qmail 2975509 invoked from network); 1 Sep 2021 11:07:25 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Sep 2021 11:07:25 +0200
X-UD-Smtp-Session: l3s3148p1@j+PnZOvKToMgARa4Rc4DAUbRC24QnL0V
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-pwm@vger.kernel.org
Cc:     Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pwm: tpu: Add R-Car V3U device tree bindings
Date:   Wed,  1 Sep 2021 11:07:19 +0200
Message-Id: <20210901090719.35375-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
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
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index 81ccb2110162..0171a04257b8 100644
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
2.30.2

