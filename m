Return-Path: <linux-pwm+bounces-3860-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D39AFC13
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 10:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E337F284DED
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 08:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CAE1CB9E5;
	Fri, 25 Oct 2024 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceuzB4Lm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183301C4A03;
	Fri, 25 Oct 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843649; cv=none; b=QRWb/dB7mGwv1kCY2cTYr+IOwpIXpnGGrNqlkQGWHj+2wQNng23cSmGTeYALkpUzZ30uMm+F2EjWCaa1vLxx2OBD9LHqFQ68I24S6yKnXUsmgN+YtPmOxSRYXlZWzm0PxkGMatCPrhicjXG0fOJaMVlhtH9HBBFks9QbX5/gYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843649; c=relaxed/simple;
	bh=3p4yGURKRybyWYfqJv7wifGGEWBo97x5AmEQOI4GZSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUbZtYXQ9MsrUPOpFAIbyfVp0yQAA/mame1J000D834kciHnm9wJBwk+E7GJIiY+HsMk1X0Wqh9/u5KkOp4EaKaYrOfp1OHrvukfMCRYvMYJgxNi1wQ/XTa7WMKJKMRao/l0wZBjO03+FWc8g79kr/XVZNd0RCk1SjYztZr2N6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceuzB4Lm; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc03951abso912422eaf.2;
        Fri, 25 Oct 2024 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729843646; x=1730448446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kROaOIt5szJgAa68Sy5g7p0dogkgu9Z3CSKDjRWOQKY=;
        b=ceuzB4LmeeZoIY9RTtYShamnaO1BC1E0NE/y/DlcH0jFcXfsydpUPJHLQqP85SjY74
         V0NVquz6INjS+MRh8QQVtKIffrRxvDRMmziUCtrR8xp4LVMxGL9f4CRzz/jcdTkJ3p2H
         wmZwLVGiTq9XlXvBUwtK+UnKRoML/kN9pnvr+yVF9EwLb/RnlGPTiaI92f6SQr0jYr2x
         zw0+TRj+quBd1bGuciCiRldT3SKeKFQ3ygLcCIi/M+vk/nUYU2qKvNiDnESsbEMfs97c
         boFQbJ5naaNiXSaRETA4HYn4a/FbDL/PNUDIuHUACoLJH+h6DIlNI0ygFf+yhnWFXlmm
         /frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843646; x=1730448446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kROaOIt5szJgAa68Sy5g7p0dogkgu9Z3CSKDjRWOQKY=;
        b=BToUDJq5PMD9GgRVP14XSwhxH8cjLtqmPrLf4wixkEzfS4r/l6lpmjkW/JuIYf4OI5
         CN8ZFJemCstD0gLcP6o97OlxHQQKIdGYc2522rus0bOveiRX7JXiZ7/2GDRaAhzamxFD
         uWZLFFAFZqtx4K0w7+s/jpVIoPlYZm5pGqtNP1Qz6ZWmvmo3xD1osdALmE0nP7kNo8vJ
         DmGCiPGDgYvlMndXHrNq20xl26JiqYtuj6pN0XKhtIY3JdZDJj4qRmfM7GSoWei+9MNR
         kZYiZD4JLy8wPSW33t3z+1Q34yBQGU1Scy6zMX0bHiRB7EdQ4ehpTyNKsBc93Fjlxsrf
         q+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAIxpFPynKAHtAPFw0MEN+oR91D4n6qxlrf2iN4l3C/FosGy2LQ+4+9rNfROQXzLRugiI4t2mAWi73@vger.kernel.org, AJvYcCWfTY9rn16Ymt5q3xi1nS9psGebLwoZhhCLmvTt1nY59UuC56LK4aiARE+CZCWdTZJO4UC/QS1fneoc@vger.kernel.org, AJvYcCXqNRIRgVwSmeKEtf1bvYqGnoZCvFvcjoGIerMTAI4QQejjy6ryoQrj9q5mlSBAWJtFHqyJmkRiFKDRA9I8@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ62c2Lj5JMDEW9HwE2m/RR75MtxJd7r2xB+QPACx1rxJ6t/wZ
	ALtReharcmdbyooW66uWmwbXKJq9bllr47IhKoUEdrD0iIBh/uZ1
X-Google-Smtp-Source: AGHT+IG3yZ7QFdXMQgZy4VqVWPZpaI1h3p/gTRs7/ehSdIlWEGnDqq5cSNi9pfS2CM4e0Baco2WIzg==
X-Received: by 2002:a05:6820:80f:b0:5eb:db1c:a85d with SMTP id 006d021491bc7-5ebee8e6619mr5987300eaf.4.1729843645926;
        Fri, 25 Oct 2024 01:07:25 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec1843c72csm157328eaf.1.2024.10.25.01.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:07:24 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: pwm: sophgo: add PWM controller for SG2042
Date: Fri, 25 Oct 2024 16:07:16 +0800
Message-Id: <9f9a31a2a19c2743aea36c479b0dc32da0fec629.1729843087.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729843087.git.unicorn_wang@outlook.com>
References: <cover.1729843087.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Sophgo SG2042 contains a PWM controller, which has 4 channels and
can generate PWM waveforms output.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
new file mode 100644
index 000000000000..5dea41fa4c44
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/sophgo,sg2042-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 PWM controller
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  This controller contains 4 channels which can generate PWM waveforms.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: sophgo,sg2042-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb
+
+  resets:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/sophgo,sg2042-reset.h>
+
+    pwm@7f006000 {
+        compatible = "sophgo,sg2042-pwm";
+        reg = <0x7f006000 0x1000>;
+        #pwm-cells = <2>;
+        clocks = <&clock 67>;
+        clock-names = "apb";
+        resets = <&rstgen RST_PWM>;
+    };
-- 
2.34.1


