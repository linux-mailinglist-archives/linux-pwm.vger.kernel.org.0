Return-Path: <linux-pwm+bounces-3817-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9E9AE2E6
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 12:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3B31F22DB5
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 10:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59B1C4A20;
	Thu, 24 Oct 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mex7RrCm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FAF1C4A2D;
	Thu, 24 Oct 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766618; cv=none; b=FZ5I+1lFKildkk5y8ZhL5HPRWfzuYGsmc+gqj2gZS+dw4IDPJgYKUrajY+zsFZtXtK0Tp7FYjzuhMzAIzqi14ED8nFx4bjBzEwdl1IfWh8ZvWoE6hTv2BzBGlB4ZxrhHD9HiR4BSGcFG7pJB33jUcit7b/iURtAbSKIMz+wocvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766618; c=relaxed/simple;
	bh=1lbW6k4DEQE1jMH5DGVnXI6yZRKu/RrrCAzWj/NCB6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lj0m+mWUqtY0wNEZYCtyIF0RuzxEl7OPKBVB/HSOYMXgTjk1RtyFM4OPaHWo19lI3bKLqNId1eI0pXQKhZyLBwk57kB5J1coxyfc/BLlebn0rLhwSrr4L9zzQ/MNspEkooudlT5+UcmRDt/R6q9faGdQ9uPQPE2B5m0gU0fxfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mex7RrCm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso608732a91.3;
        Thu, 24 Oct 2024 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729766616; x=1730371416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pg5NSQICuLjHCR9yIb5y3edaodg5RWPG8HA8VIwE0g=;
        b=Mex7RrCmO4uiX3W9cK/8JC2X0xnIZOD+3l6mSjys3C17aAk3HwN5EaZWwUVsmPrVeq
         VPksz30s0OYw8JVcxiIc7+Byt/QuCL9JTaHDQOvz436KihgJ2KpWmyVIgNcMsj3jp+/o
         nUM6rDydkh7JbuIzlwi2yEtlmQFymJlgyoOjvhnSd8ITFCm1CwI614NQTpVtHS+QV0GF
         htOcTYEhaFDHSi9z8O2pMHfHP9x6Zz5pHgeRkOLxKPuoybfDAd/fB9vus4CGaHdmDxq3
         96kvsUqYxjAK2Qu5rBYQQvd3ecIt54iKnSmY3ZdRbYKDKVPEKN6h30e19Fr7dBg079ti
         SHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729766616; x=1730371416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pg5NSQICuLjHCR9yIb5y3edaodg5RWPG8HA8VIwE0g=;
        b=hyZEC0f2+tfkfcmEMjZEbJEl77b678MyJNpwIMdU3k/wr3hOeCpo3UfwJxzf2ADA6l
         DvZVj4o6we2vYSKk8mSGXrjG0IzmR5v4aKZWj6LYQkWwFt6E4PF0UZuOxt4lBLx/q0VJ
         cPVdgGlR7+7EroHubZpK0jyA+w1w5voCq0RAUly1LZQ+dEu5vQldj1VBCv4bv5rvKUh+
         dD2Tz+rK1bhDsCi1TNXqQuEO4XqhYohTHt32THxwA7/f/GfZ3IFPFrx64TkMXz7Vtdm5
         IunTVWWtxZpEX2kVDvwbVv9H2TFc+l9a+Zp01QRa0d5645tf9FL0LNyCEpKN7QZg0/Cm
         oM0w==
X-Forwarded-Encrypted: i=1; AJvYcCViVjLWuNHbre6e80HSnbJtdb8Mvpo1qiHpiVGKRSrK+QP58cTLiklV4XSxpzIc/AthVedKLnEOdJR1@vger.kernel.org, AJvYcCXKMyqY/0LVHo+JPv5ILLyAtoouO3TrO+nFkngxPMnjOwNG9uCRlKMuSXxCp1239bYQB+6KsTqcy18q@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVZQO5DxuVJlNZw81My9AvYFbMl/Mmr2pnPIFAfiLyH37Ipbl
	oNmfEJEpqRKhYNPV4HnlSEdIOGp55inMY8i5iu+LvuEgP5t9TvB4DRtux9nc
X-Google-Smtp-Source: AGHT+IE8Gk3nyttwsDNzbFU+YscAkTIYYy1GnBhvG0f3QZlmzMJX3CkmbBkWS6hSdlauRmdzT2zaOQ==
X-Received: by 2002:a17:90a:ca08:b0:2e2:8995:dd1b with SMTP id 98e67ed59e1d1-2e76b5b67aamr6153379a91.3.1729766615373;
        Thu, 24 Oct 2024 03:43:35 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48ed34sm1252785a91.9.2024.10.24.03.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:43:35 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	cwweng@nuvoton.com,
	Chi-Wen Weng <cwweng.linux@gmail.com>
Subject: [PATCH RESEND v2 1/2] dt-bindings: pwm: nuvoton: Add MA35D1 pwm
Date: Thu, 24 Oct 2024 18:43:08 +0800
Message-Id: <20241024104309.169510-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024104309.169510-1-cwweng.linux@gmail.com>
References: <20241024104309.169510-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for Nuvoton MA35D1 SoC PWM controller.

Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
---
 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
new file mode 100644
index 000000000000..ed32fc573a24
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nuvoton,ma35d1-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 PWM controller
+
+maintainers:
+  - Chi-Wen Weng <cwweng@nuvoton.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-pwm
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
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    pwm@40580000 {
+      compatible = "nuvoton,ma35d1-pwm";
+      reg = <0x40580000 0x400>;
+      clocks = <&clk EPWM0_GATE>;
+      #pwm-cells = <2>;
+    };
-- 
2.25.1


