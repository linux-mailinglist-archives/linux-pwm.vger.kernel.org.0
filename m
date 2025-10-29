Return-Path: <linux-pwm+bounces-7523-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D72AC19397
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 09:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E789463C6D
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B031618F;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6xxwPwg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0F3128A9;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727038; cv=none; b=RrzpBQ099a2opTGlJ9Xu+I8oqk+8WHZN3ovG4LpIpaZ+ldLOzUSvHoenGMKyv6VZVwDLqcuaESW99ptpeGwwTcNMs9sZoEY26QaLSoHNNJVoG/zVN3726iq7fsHrxaivh7HWQGQUIBLT3U8uMjmGVdlYXRl9q9h0yZT1cIZftzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727038; c=relaxed/simple;
	bh=BVLvqWYiknuE3RTsMI3OFst20j+dvTINoUrb8fOh9xA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kK7bmLhivJzwgZJ5zSQFhPVsJ87IlFtwbzgahqeldrlhRWMQONw5cHfgGchkuH838E35K0ZU5zWF9KoVBSdNCbW0TYIMEFJcA8jEeekBvVmd+lUelaIXEdRUPQhmRoh7CVPuxbQjPUriynIgVluEmzjWQkhRpzIq6czItYYXx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6xxwPwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3F3AC113D0;
	Wed, 29 Oct 2025 08:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761727038;
	bh=BVLvqWYiknuE3RTsMI3OFst20j+dvTINoUrb8fOh9xA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F6xxwPwgJubY/fgqaJyx38EC/9UjhQ095IVSwcFX7bHinsckvFqebts0Z7aWtjuTA
	 b+86uSwFtNvHHALeX/J/6GI+4/NMjGMNu/8/w60GK62vC5W0JBPnd84tD/2hh5EW02
	 Te5vW9TH+9NjvTmfBLsPJ9Ld/y2hq+ObSaJyGttPPAcAjBQpsMBnf8ldX2e1dLU2v5
	 5Una846+mOTr+vA4Rbxp1+9wLQi0Zf8k14mRrfvF6e9GLPeMiJHY7wAMFS37dmqkdM
	 ZhE9pVcMVJ1t1MjxQhzPdUF8DWUdftVCdDnzkd7phD1KHEt5c6L8PnE8G0409zPbv/
	 PTONYnZizlBtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC32CCF9EE;
	Wed, 29 Oct 2025 08:37:17 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 29 Oct 2025 12:36:57 +0400
Subject: [PATCH v18 1/6] dt-bindings: pwm: add IPQ6018 binding
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ipq-pwm-v18-1-edbef8efbb8e@outlook.com>
References: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
In-Reply-To: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Baruch Siach <baruch.siach@siklu.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761727035; l=2105;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=Ibx3MGKBQtG5XFPAvH9GByVAP62xXho2RMoxEtRDVSE=;
 b=f7TOV9DLImZRAlFXH+UlWkM3QpjTimIXm6kAZoeMQiSqb82rBfXfiQwfKDhqkK0zrBoki07TR
 RKbQtftTVmXBVT0FvJ7z5VfqyFLXYkEiblHX/XBHtsW5XW5CUz+JHhx
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Devi Priya <quic_devipriy@quicinc.com>

DT binding for the PWM block in Qualcomm IPQ6018 SoC.
[George: added compatibles for IPQ5018, IPQ5332, and IPQ9574]

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ca8e916f03276e93d755d574e2567b0e4b86a8ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ6018 PWM controller
+
+maintainers:
+  - George Moussalem <george.moussalem@outlook.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,ipq5018-pwm
+              - qcom,ipq5332-pwm
+              - qcom,ipq9574-pwm
+          - const: qcom,ipq6018-pwm
+      - const: qcom,ipq6018-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
+
+    pwm: pwm@1941010 {
+        compatible = "qcom,ipq6018-pwm";
+        reg = <0x01941010 0x20>;
+        clocks = <&gcc GCC_ADSS_PWM_CLK>;
+        assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+        assigned-clock-rates = <100000000>;
+        #pwm-cells = <2>;
+    };

-- 
2.51.1



