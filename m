Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A8836C332
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Apr 2021 12:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhD0KZP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Apr 2021 06:25:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61368 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235372AbhD0KZO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 27 Apr 2021 06:25:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619519071; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jWAUwABSHIxmfg4aBpPOjQbhhQgm6a1ARJ+qicZR39Y=; b=qREDc3y2dIv60XWswUwJGHHHl6pqSYXwpiS7CLtEi9T02Yvxibk9cGZsIp33iC8UXf423/3v
 gOKBZrFgBGmchirvK9ARlvF/T8S1/KlLpa8ENfhyPVesb3c9drwO8IEfrYsDKx2VawlBtXdh
 95iY3oDmkqBxkrDU3ZaH57kt7Bw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJkZWM1ZCIsICJsaW51eC1wd21Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6087e657215b831afb3e7baf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Apr 2021 10:24:23
 GMT
Sender: fenglinw=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BCD77C43147; Tue, 27 Apr 2021 10:24:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from fenglinw02.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: fenglinw)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CF49C433F1;
        Tue, 27 Apr 2021 10:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CF49C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=fenglinw@codeaurora.org
From:   Fenglin Wu <fenglinw@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fenglin Wu <fenglinw@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     subbaram@codeaurora.org, collinsd@codeaurora.org,
        aghayal@codeaurora.org
Subject: [PATCH 1/2] dt-bindings: pwm: add bindings for PWM modules inside QCOM PMICs
Date:   Tue, 27 Apr 2021 18:22:09 +0800
Message-Id: <20210427102247.822-2-fenglinw@codeaurora.org>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210427102247.822-1-fenglinw@codeaurora.org>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add bindings for QCOM PMIC PWM modules which are accessed through SPMI
bus.

Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
---
 .../devicetree/bindings/pwm/pwm-qcom.yaml          | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-qcom.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml b/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml
new file mode 100644
index 0000000..e8d8ed6
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-qcom.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-qcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. PMIC PWM bindings
+
+maintainers:
+  - Fenglin Wu <fenglinw@codeaurora.org>
+
+description:
+  PWM modules inside Qualcomm Technologies, Inc. PMICs can be accessed through
+  SPMI bus and normally one PMIC would have multiple PWM modules with adjacent
+  SPMI address space.
+
+Properties:
+  compatible:
+    const: qcom,pwm
+
+  reg:
+    description:
+      The SPMI address base of the PWM module, if there are multiple PWM
+      modules present with adjacent SPMI address space, only need to specify
+      the address base of the 1st PWM module.
+
+  "#pwm-cells":
+     # See pwm.yaml in this directory for a description of the cells format.
+     const: 2
+
+  qcom,num-channels:
+    description:
+      The number of the PWM channels (modules) with the adjacent SPMI address
+      space following the address base in "reg" property.
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - qcom,num-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    pm8350c_pwm: pwms@e800 {
+        compatible = "qcom,pwm";
+        reg = <0xe800>;
+        #pwm-cells = <2>;
+        qcom,num-channels = <4>;
+    };
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

