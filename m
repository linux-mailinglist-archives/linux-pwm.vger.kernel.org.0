Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA139106
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2019 17:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfFGPoW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Jun 2019 11:44:22 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48050 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbfFGPoU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Jun 2019 11:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559922257; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbbfeXwZmWXQbAjfubvurecyBgrzslvcdAtsLtn9FkU=;
        b=rcRt4lIE7cXz71RbiEsE3H8TF6Q4iJtl8hp1ZblD+gtaf3613ND4LiLItexOL3J6oIXNWG
        1eThi8RJ9AcWYyHDwtpG3GwkiO+6FIqRtjKNcMv9PIjkYIg9ZDopGDKeItieoLz0yacjLT
        JD5A/IEAiX0j/LZBpUTva32D9kD2RbM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/6] dt-bindings: Remove unused compatible strings
Date:   Fri,  7 Jun 2019 17:44:05 +0200
Message-Id: <20190607154410.10633-2-paul@crapouillou.net>
In-Reply-To: <20190607154410.10633-1-paul@crapouillou.net>
References: <20190607154410.10633-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Right now none of the Ingenic-based boards probe this driver from
devicetree. This driver defined three compatible strings for the exact
same behaviour. Before these strings are used, we can remove two of
them.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Rebase on v5.2-rc3

 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
index 7d9d3f90641b..493bec80d59b 100644
--- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
@@ -2,10 +2,7 @@ Ingenic JZ47xx PWM Controller
 =============================
 
 Required properties:
-- compatible: One of:
-  * "ingenic,jz4740-pwm"
-  * "ingenic,jz4770-pwm"
-  * "ingenic,jz4780-pwm"
+- compatible: Should be "ingenic,jz4740-pwm"
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a description
   of the cells format.
 - clocks : phandle to the external clock.
-- 
2.21.0.593.g511ec345e18

