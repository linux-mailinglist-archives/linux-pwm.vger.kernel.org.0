Return-Path: <linux-pwm+bounces-7366-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA98BB09C7
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 16:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898463B4A63
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50E3019B7;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw+WDp7t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278771547F2;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327463; cv=none; b=tvcxql/3LXuxo2gnPTsoVIze0WmNGnqHNuvfA7IE0p061ey02Ut87oXLENUv6wG09sCYv3PS+CIQ+4jdYaiGLQyFtQAkj2H2MmwMXCHuPD+/gZ6wdHxM3SvJhJIouSuSi/M5Tm9MFR75pAK3/Wx7W0vfiUjS++BVX4CFUDkPh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327463; c=relaxed/simple;
	bh=DcwuyX8vW2kqJZ7nlBXFHvGPhvHT+XYW91wlJclysz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NlfV2qJyNB60E5Ha3ZL4yfcaMLyGf91KkDMrAsVzSP9DvJCgfmw5WquGfSs5zdzcbZS47eIZ03D0Fw/kE67tMUzLgukiBn53kjgfbXuAms48WrLMzhfNy93q2orCu7zwFcOUDU6HFHufWBySir1tPPMSGxizg30unwfs1xTkXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw+WDp7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0663BC4CEF9;
	Wed,  1 Oct 2025 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327463;
	bh=DcwuyX8vW2kqJZ7nlBXFHvGPhvHT+XYW91wlJclysz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dw+WDp7tfCs/HdgNqdsMHlB2nMh3x8+mTmXTaPGGQR52J7hnBEZujO3BlSWmebkQu
	 cXwawYWSr2HuNu2zLs79BUGij2t4JBAE9j/ABBH3jzr3RpTJ6GQXr9d5CgH5q7yqfb
	 Mme06hyKYJ5YP5iX0EyEAdkER96vSobhNJNWhF88yzqOkC5ZfBKxJ5J65UKjzszOGb
	 BtEHQz1ZwQ4GcJj2s8Idf4y14vS+DXxnzG4GIT1dCS+bji2cmRTuKYZhjz1W2pDCgJ
	 LaHaCcyZEJzt66B70BmJL1SH6HqgxGvuwwpqjx4uxqJb6OnVYJjnbkkK9BPL574A4u
	 TKhUaFE4QHi2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E347CCAC5BB;
	Wed,  1 Oct 2025 14:04:22 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 01 Oct 2025 18:04:17 +0400
Subject: [PATCH v16 1/9] dt-bindings: pwm: add IPQ6018 binding
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-ipq-pwm-v16-1-300f237e0e68@outlook.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
In-Reply-To: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Baruch Siach <baruch.siach@siklu.com>, 
 Bjorn Andersson <andersson@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759327459; l=1766;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=TIgQXfGvQp7H4uzUZyQsZZpdMSae9nM97ANzvYRj3gc=;
 b=XaG2XNit7oo8lR7gdorPFnH0Ww9dnr+Pi96LwXAiOjPFL+WQwpLo9hCKoijz1+QuFaEfWh1v/
 8VBy6ez2YO3BWj/OXxkNspVoUeztQJR518JzrPZNHdy3aVTs+hFNY+m
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Devi Priya <quic_devipriy@quicinc.com>

DT binding for the PWM block in Qualcomm IPQ6018 SoC.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1172f0b53fadc140482f9384a36020260df372b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ6018 PWM controller
+
+maintainers:
+  - Baruch Siach <baruch@tkos.co.il>
+
+properties:
+  compatible:
+    const: qcom,ipq6018-pwm
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
2.51.0



