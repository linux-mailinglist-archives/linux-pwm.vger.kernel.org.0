Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464EF244C56
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Aug 2020 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHNPz2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Aug 2020 11:55:28 -0400
Received: from smtp1.axis.com ([195.60.68.17]:42238 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgHNPz1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 14 Aug 2020 11:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1098; q=dns/txt; s=axis-central1;
  t=1597420528; x=1628956528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MOupmaCWPWAeM7cgobGOhUOVQpVTqyeE6uDsh4v6ifM=;
  b=SKjifFVdqc/uh84XbRWtg8hwogtkXJxQqKx1Zw4Av1MJA1q9kxCjDM7L
   +rs1RJ9TjZ1p1weQevusWWeD1POfpqo5OXLoXT5ONzF4NEIOgr+mqVGdH
   TYUf/QFkrXmuq6wzL/sdiwlcj+JhkHOCE9SFpmOhbGb4lg3WQ17IL/PZ1
   JrSIo4gkBMvu+07Dp0vBTqqfnrPXvWkpRI2WVBWnTSdLI8Vc5yzheppPm
   IMRokb3UYzZI7TnBzJqiwrcCU1JTuw2QVjDxp5CKiuB7ywtnhnUyzYdiN
   MBHSED1nikzVruTYAgwf/uRSLlYAkqVUBVvGTxYk4pbtNST1QgG2HKUVX
   A==;
IronPort-SDR: lt/OsbVRpvjg6loYeMUc4eV/Wqrr7htK0Mcvk3ewZPb0iAQMOa6mjq7leRvN3dBuCfIKb5uxi+
 5G87csv5vO2qOhRDk6rtbsBL+G2856U97Xlc4632Wh/ctplDIthJgaTPv3qT1rBqeLkrmK3Po9
 0dlJkPhpyvx+kie7ZvhfrkNwv/dQgYPKtCDk8hKBPu3vVld2iiqIPrQnXJ4U6oNP+GcEuP416i
 y9rmkKOPl3oK4VoIyiLIWw99dqgrOOBxQgY1IaPXGskCMNhOfinBn9XvKDi9ZEz4unmhfs/ErB
 GFs=
X-IronPort-AV: E=Sophos;i="5.76,312,1592863200"; 
   d="scan'208";a="11813477"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>
CC:     <kernel@axis.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <oliver@schinagl.nl>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 1/2] dt-bindings: pwm: Add pwm-gpio
Date:   Fri, 14 Aug 2020 17:55:12 +0200
Message-ID: <20200814155513.31936-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.25.1
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
index 000000000000..51941cd03955
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
+  gpio:
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
2.25.1

