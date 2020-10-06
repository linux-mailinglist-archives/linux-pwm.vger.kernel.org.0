Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0B284875
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Oct 2020 10:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJFIYV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Oct 2020 04:24:21 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:60145 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgJFIYV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2020 04:24:21 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 04:24:20 EDT
X-IronPort-AV: E=Sophos;i="5.77,342,1596466800"; 
   d="scan'208";a="58818942"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Oct 2020 17:19:16 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4913940031F4;
        Tue,  6 Oct 2020 17:19:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: pwm: renesas,tpu-pwm: Document r8a7742 support
Date:   Tue,  6 Oct 2020 09:19:09 +0100
Message-Id: <20201006081910.1238-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201006081910.1238-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201006081910.1238-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document r8a7742 specific compatible strings. No driver change is
needed as the fallback compatible string "renesas,tpu" activates the
right code in the driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index 4bf62a3d5bba..aa9a4570c906 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -15,6 +15,7 @@ properties:
       - enum:
           - renesas,tpu-r8a73a4   # R-Mobile APE6
           - renesas,tpu-r8a7740   # R-Mobile A1
+          - renesas,tpu-r8a7742   # RZ/G1H
           - renesas,tpu-r8a7743   # RZ/G1M
           - renesas,tpu-r8a7744   # RZ/G1N
           - renesas,tpu-r8a7745   # RZ/G1E
-- 
2.17.1

