Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD65A25AAE6
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIBMMt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 08:12:49 -0400
Received: from smtp1.axis.com ([195.60.68.17]:61016 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBMMn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 2 Sep 2020 08:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1099; q=dns/txt; s=axis-central1;
  t=1599048762; x=1630584762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fqy6o6NBpbsoyG7wpoKTmk2ahf6JpbKCxRq6p+fYp1I=;
  b=Q8orBLxRc8SVwOF/lHV2Mc4X7K9SRes1uVbC97R/B8jdmpXSr95bFoL3
   tWtIn30lhAm3Xn5aKfDjnCOs5wGBVr0pzDsbRr4Oy0BYTMcfELHJYifYd
   lVRuP5Q17gyMB58ln14gEYSb1hxY3FMCbGyBOqGy2CRIAMnsLng8JDSG0
   CCRBVBwg7ewIJBgAoGFLseXFTWC9HpeZCbyKn0OPDcUbddNySxZymABmQ
   3/2babO9zByBXJprs0QlgrE/DRI1qV62DcYpoPkMLGU5gplVvFy+qXssh
   u9kC4+FotRAL0zkQfmkE97aBdZAUXpuH3nK4PDMo/kYuuTVTdHEe/bsl3
   g==;
IronPort-SDR: jS3O1R222VaEqTvQKo6iIAxk1/VED7o5MPGsMIxLSs8mKFNTxAuvb7fM1f7aZQ8O1y5kKyXiQ8
 7vUm9k8FCvcYUg0tR6Hqe9la0MLRnUSWrDGTtR5w9oXkt3jzmDSvY9ddTa56EGoaDQQb3HhDnZ
 tRcxtiac2orR4A9CCC67fT+F9KIxODEbCnC7FJfPr730ncxwsmd4AST+BBRLJ7s9nEJMBePIGP
 5C7xmf4LhpvdGp5G9hsUlwH+TCT38/Lu4hRu8ORb6IBETvW+00nToVm4JVaoGRn/sXnCUsRHyW
 RF4=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="12474749"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>
CC:     <kernel@axis.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <oliver@schinagl.nl>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 1/2] dt-bindings: pwm: Add pwm-gpio
Date:   Wed, 2 Sep 2020 14:12:35 +0200
Message-ID: <20200902121236.20514-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902121236.20514-1-vincent.whitchurch@axis.com>
References: <20200902121236.20514-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add bindings for the pwm-gpio driver.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../devicetree/bindings/pwm/pwm-gpio.yaml     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
new file mode 100644
index 000000000000..85ae79d5dcff
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO-based PWM
+
+maintainers:
+  - Vincent Whitchurch <vincent.whitchurch@axis.com>
+
+properties:
+  compatible:
+    enum:
+      - pwm-gpio
+
+  "#pwm-cells":
+    const: 2
+
+  gpios:
+    maxItems: 1
+    description: GPIO to toggle.
+
+required:
+  - compatible
+  - "#pwm-cells"
+  - gpio
+
+additionalProperties: false
-- 
2.28.0

