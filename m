Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C5CC33B0
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2019 14:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbfJAMDG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Oct 2019 08:03:06 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:48037 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbfJAMDG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Oct 2019 08:03:06 -0400
X-IronPort-AV: E=Sophos;i="5.64,571,1559487600"; 
   d="scan'208";a="27795287"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Oct 2019 21:03:04 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EAED84226653;
        Tue,  1 Oct 2019 21:03:01 +0900 (JST)
From:   Biju Das <biju.das@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Biju Das <biju.das@bp.renesas.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: pwm: rcar: Add r8a774b1 support
Date:   Tue,  1 Oct 2019 13:02:40 +0100
Message-Id: <1569931360-17196-1-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document RZ/G2N (R8A774B1) SoC bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
This patch depend on
https://patchwork.kernel.org/patch/11154813/
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
index 0976cfd..272a4df 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml
@@ -18,6 +18,7 @@ properties:
           - renesas,pwm-r8a7745   # RZ/G1E
           - renesas,pwm-r8a77470  # RZ/G1C
           - renesas,pwm-r8a774a1  # RZ/G2M
+          - renesas,pwm-r8a774b1  # RZ/G2N
           - renesas,pwm-r8a774c0  # RZ/G2E
           - renesas,pwm-r8a7778   # R-Car M1A
           - renesas,pwm-r8a7779   # R-Car H1
-- 
2.7.4

