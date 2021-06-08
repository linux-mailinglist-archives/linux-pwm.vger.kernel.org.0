Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04D63A0682
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jun 2021 23:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhFHWAf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Jun 2021 18:00:35 -0400
Received: from foss.arm.com ([217.140.110.172]:42386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234725AbhFHWAf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 8 Jun 2021 18:00:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9207CD6E;
        Tue,  8 Jun 2021 14:58:41 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCCD63F73D;
        Tue,  8 Jun 2021 14:58:40 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] dt-bindings: pwm: Use examples with documented/matching schema
Date:   Tue,  8 Jun 2021 22:58:34 +0100
Message-Id: <20210608215834.2236920-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

'nvidia,tegra20-pwm' is not yet documented in the YAML schema. Use
'allwinner,sun7i-a20-pwm' instead to get rid of the following warning
with 'make DT_CHECKER_FLAGS=-m dt_binding_check':

	pwm/pwm.example.dt.yaml:0:0: /example-0/pwm@7000a000: failed to match
	any schema with compatible: ['nvidia,tegra20-pwm']

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/devicetree/bindings/pwm/pwm.yaml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
index 7d1f687cee9c..2effe6c0de6b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
@@ -24,8 +24,9 @@ additionalProperties: true
 
 examples:
   - |
-    pwm: pwm@7000a000 {
-        compatible = "nvidia,tegra20-pwm";
-        reg = <0x7000a000 0x100>;
-        #pwm-cells = <2>;
+    pwm: pwm@1c20e00 {
+        compatible = "allwinner,sun7i-a20-pwm";
+        reg = <0x01c20e00 0xc>;
+        clocks = <&osc24M>;
+        #pwm-cells = <3>;
     };
-- 
2.25.1

