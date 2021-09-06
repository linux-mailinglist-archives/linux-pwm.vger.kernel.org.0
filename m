Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5D5401925
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Sep 2021 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbhIFJq6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Sep 2021 05:46:58 -0400
Received: from www.zeus03.de ([194.117.254.33]:33648 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241609AbhIFJq4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 6 Sep 2021 05:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=NLfJgY6uwZTU51uLNvFJ/KrD/C+
        2m5rzmP5fszb4Cn0=; b=ORiSJsEXFcHmvdlZF2NRJy4B0t5cN0pM/VPOA2CEoIS
        acBYw484YFygcKRm6BWiKnoNYqfn/fCUVWlPJzSFAl4zHt4lYruXtzw6yKlFwzxQ
        PAOHhb83HJ4Ok2vhQdEEb550DSXh+hMf2N3i3Zr2M2rJBLTiPOV62SQaOPb4h6gQ
        =
Received: (qmail 420914 invoked from network); 6 Sep 2021 11:45:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Sep 2021 11:45:50 +0200
X-UD-Smtp-Session: l3s3148p1@KSuqg1DLCKMgARa4Ra5MAc3ZBYWvSFq1
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-pwm@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pwm: tpu: Add R-Car M3-W+ device tree bindings
Date:   Mon,  6 Sep 2021 11:45:35 +0200
Message-Id: <20210906094536.45223-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add device tree bindings for TPU found on R-Car M3-W+ SoCs.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index 0171a04257b8..1f5c6384182e 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -35,6 +35,7 @@ properties:
           - renesas,tpu-r8a7794   # R-Car E2
           - renesas,tpu-r8a7795   # R-Car H3
           - renesas,tpu-r8a7796   # R-Car M3-W
+          - renesas,tpu-r8a77961  # R-Car M3-W+
           - renesas,tpu-r8a77965  # R-Car M3-N
           - renesas,tpu-r8a77970  # R-Car V3M
           - renesas,tpu-r8a77980  # R-Car V3H
-- 
2.30.2

