Return-Path: <linux-pwm+bounces-3768-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DDA9AC8BE
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EDC281C74
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 11:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1691A724C;
	Wed, 23 Oct 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJtqu6A/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8621B813;
	Wed, 23 Oct 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682375; cv=none; b=UBNXbBtwnmtKLyCrIdlkhnpv+f/kKEmecYrRYIGl5ohJ4+c1V+4lr/b8Qri1SDpNJVRGDg45UVzg6KmwpyheXGl7ArPyg82NZBrE7uLrSI+lIwpIT03DxIkAGMoQXBmmZID/ItbXJpSZEFFnf4O0sH/nvSBF/SqgNimFxUS67tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682375; c=relaxed/simple;
	bh=Ujb6qmj+YfN5C+CyEVO35zkqPF13EYRq2EmKJ0Pi8HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQJmjrxRgEtDbo2JnAxu5kU8n1W8j2tsIJsoSiHZs5VUaLFMS6hKrUWrps3tmYrFssZbYxZ6rR1083UBbxq/2gMjTBHdAG6AZDaG057R0ClYad1Tj9Fr75phcHYJytbaBnDN/53gUrfRRQnBxK++eQw6R4PynTmIpT8YJyJZZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJtqu6A/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso5258860a91.2;
        Wed, 23 Oct 2024 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729682373; x=1730287173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqOpgB33k4/mfFlaB0ddO360BTxT44SjwW5dyAWL/lc=;
        b=HJtqu6A/km4v51XelQ2Vrf5NSRdUBWg/2YRTlS7uXNYuu2DNuZ02lxVMIbY49EmAEY
         tc5l5StLCT6fpn2n4VSHJvXX1WzC2R15aP93XUr9e+pqLz21lrsSfes0GhriIHu41F/B
         8bkhUxffOKUTy0zDN2HY1wGRZiJONpOXyX8elIJ2KL90bpgrl+UcrMbfzCc1CRmG1xM9
         kyIHipwlK45bBQ4IPSp/kcJmEiidvUbojICo9BiUmjD9rB06x2hi5KQ9dx3o0h1a1Azs
         pgJNNT/ga0fTx2Bj9D0SN26b2i4pn2ZAByCUgGnFjOgzs9t2ih5XZ5+fRe912CB+yU/u
         InYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729682373; x=1730287173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqOpgB33k4/mfFlaB0ddO360BTxT44SjwW5dyAWL/lc=;
        b=nOiNSi/Ez3Fwyh45RqS/SWPLAWYVrLB9Ose0BQj0m41wQXQuGXFX6nsct2aS26BZsO
         siDLZ9+ufcpHMBKyQvAhdBLu7SKg9rVekOLB4DjRakYDhQp4pu07eC+wGvZb27SaniXE
         oSEeAi3IYX4kR5a52yXgrqmQrrIazgLfrHMhVhho27x27TvOhRAcc6wmPMEAVFw9e03O
         KeMI8LZIGBoZRjm5+D8t+cgt6cvHEeGSf0dYvzQgFhftUcB5fRTFq0pqmp/1ZdWGu3p9
         PwvquEvj9F47vu26YH/gHN9OgyMLZGCmunCzngWGKdWLZAq1bpr5md0eRsuENaRCre/t
         BsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0mBMkF0lfOMUbZCN7Vs6Y4gvsfTji31Q1JDItuMGAjnvmmLMuBC+fk2RFTf5I6tAdrl9bWLHNSHT7@vger.kernel.org, AJvYcCXgQAXPlUGzB0yXcYIrHwsYnTNSN6YEnVwvgVEjR35YzxEXpZKemwymugWvAg0luK4uK2pTVUP5gDd/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2N7aXO+ddwbvDwkHuVPCBijXV4d5enI85Lm0LL6Q9Xnen3mpR
	06JBctli3F7q6juoRctp2YRomOMScRQcl1ErmaKABLpQtw4Kides
X-Google-Smtp-Source: AGHT+IEin3sjWOtfvIYwT9evqPpZcOOHK7pwuX8tT5ydwm5VvnSgyFGBNyrr28EQmP3Dm/F/cgGiJg==
X-Received: by 2002:a17:90a:9e3:b0:2e7:6a44:daff with SMTP id 98e67ed59e1d1-2e76b5dd9aamr2507058a91.10.1729682373000;
        Wed, 23 Oct 2024 04:19:33 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76dfbeca4sm1123022a91.32.2024.10.23.04.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 04:19:32 -0700 (PDT)
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
	Chi-Wen Weng <cwweng.linux@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: pwm: nuvoton: Add MA35D1 pwm
Date: Wed, 23 Oct 2024 19:18:40 +0800
Message-Id: <20241023111841.158049-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023111841.158049-1-cwweng.linux@gmail.com>
References: <20241023111841.158049-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for Nuvoton MA35D1 SoC PWM controller.

Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


