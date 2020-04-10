Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2031A445C
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2020 11:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDJJOi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Apr 2020 05:14:38 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:3166 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgDJJOi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Apr 2020 05:14:38 -0400
X-IronPort-AV: E=Sophos;i="5.72,366,1580742000"; 
   d="scan'208";a="44149674"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Apr 2020 18:14:37 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EFDFC41FBB41;
        Fri, 10 Apr 2020 18:14:36 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] dt-bindings: pwm: rcar: add r8a77961 support
Date:   Fri, 10 Apr 2020 18:14:17 +0900
Message-Id: <1586510057-31562-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for r8a77961 (R-Car M3-W+).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 945c14e..620a2ff 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -27,6 +27,7 @@ properties:
           - renesas,pwm-r8a7794   # R-Car E2
           - renesas,pwm-r8a7795   # R-Car H3
           - renesas,pwm-r8a7796   # R-Car M3-W
+          - renesas,pwm-r8a77961  # R-Car M3-W+
           - renesas,pwm-r8a77965  # R-Car M3-N
           - renesas,pwm-r8a77970  # R-Car V3M
           - renesas,pwm-r8a77980  # R-Car V3H
-- 
2.7.4

