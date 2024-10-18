Return-Path: <linux-pwm+bounces-3696-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696359A337F
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 05:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08BE282670
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 03:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0514F9D9;
	Fri, 18 Oct 2024 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUgoB9p/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A620E31D;
	Fri, 18 Oct 2024 03:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729223352; cv=none; b=YPCny8bCfRtEmbPL6kFkSp47BMBO0vSKqL21pjoiXzF+e7rWarJkHckMTAKp5NAka0Id4qYNdELh3rfxuuKCMB7GNw75d9ZsmwFT/b3KpvTfz2RPkJcGNiRHjK3L6N9/fLUHaPqz/kWo40i8CkYRB+4oY4D31t5DmKzTr2nLLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729223352; c=relaxed/simple;
	bh=SENJcWcAAwYK+XnYpjPverqqhH1R//WrKrRV2swj0No=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QjoYH0ot7gZiWyINl+EgdMJZaVqeCezRnGSXbAf9wKQbhIla+VTS6PtJZ5xDBroV+OcQRXFw5pZY79PoFXrJ01LorZBmD6xD1ufOjrsQVY8VBMuEIRYtlNNO2wjI5KnOXBZgoLqcXqPcT922GUR4WUpJIMvuDZjBuXdfmwuzAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUgoB9p/; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e6048bc23cso46623b6e.3;
        Thu, 17 Oct 2024 20:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729223350; x=1729828150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B17V4awjYN0S0ULuazXBmwd7UfCktrAV4iNQfRZYfH0=;
        b=bUgoB9p/Y8ZmbHFLB0OXVYiNi6+LVsrcHb+sILw5W+v8Ka3P5KYV2Y5MZVYjTCtwhe
         q1L9jtrIFxxEC22r2zxUwKQfFJ1ZbdiVOa0VO8MiitTKfHMYsYrng3K/7KNcgEUOHYUE
         laEJARdG6Ge0MbHYVFk7m0jt3xL2d1qEzeDAp31zMnaQpYHGTD2qXRgB0xUUTUvSkRJT
         yGVMlYKvzZwxH7aaL7zGRIWTAcx3hnn9DpVBLSKUDLWUPH9u+5eBw/Zy3swvuA2e5y0p
         dzMAn/WkRXhRPDiutalvF+SPjXJYosaDqzdwwpIoSlaqRQfS2P6kN67QEzkldk6cJI0J
         wfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729223350; x=1729828150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B17V4awjYN0S0ULuazXBmwd7UfCktrAV4iNQfRZYfH0=;
        b=nODqC+vQGCIRzmsM39HO9ba2cupEx8R3lJeJfd67+JzszO/KDxOfztDuXwFm3q/3jd
         YjhnqC+V10ZAvOtAyn6TNX3lBBBnFtzpNNeKrt8IDiN4MPNKbHZNvK7sD/t7wsz8ZkPy
         kwS3wroc9MUngMi9WwKSbwxiCDy0yl8yNlcLEdvCtYhERIG7yhQwkxSZmfueIlIk/jlE
         CBtlcgxn2WimfwkRdccLGsp9rF7PY+qQ+QSsNxBjM2gnHzbBBJuvoz28rzQYEZeFdBiY
         bH/bfH9kTRh8iy5a0cXr/8nAUo9eTneXvoMKaORBVQIX9BAndv6erYXM7k8m6ae1V4WK
         /OdA==
X-Forwarded-Encrypted: i=1; AJvYcCVGWH030afxLVYlEf5q3Y1hURITP5MEbA2MWlt+KlKTiOHUq1RUWJoGINls/0uomh5tM5jWX2ms9jWs@vger.kernel.org, AJvYcCXc3UXOJiS5R6UtGWKAgDpaabX7h7FTLx9d0NgnWriMdx24fP+C67Ylu7/IOJ3bBB1JonFbc+0nDYha@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OX9+ZfQejJdwPy70RyrFarDI/BmiHg/DhQK0w4hiRV8wUYEe
	3YFL9KGdKOJlHe3OLq3w2nUGdtFxbHKxlYy1xi+X8BorodGseU07
X-Google-Smtp-Source: AGHT+IF7MuL5H6Q1aFIBW4w3Skr3dUD1q8TO07yVRunv9OqV0ZUtXM9lLnHuaWEhVNyRPS3WKA9xtQ==
X-Received: by 2002:a05:6870:ac22:b0:287:b133:8aca with SMTP id 586e51a60fabf-2892c3425demr908443fac.25.1729223350296;
        Thu, 17 Oct 2024 20:49:10 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea333d6e2sm459066b3a.66.2024.10.17.20.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 20:49:10 -0700 (PDT)
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
	Chi-Wen Weng <cwweng.linux@gmail.com>
Subject: [PATCH 1/2] dt-bindings: pwm: Add dt-bindings for Nuvoton MA35D1 SoC PWM Controller
Date: Fri, 18 Oct 2024 03:48:56 +0000
Message-Id: <20241018034857.568-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018034857.568-1-cwweng.linux@gmail.com>
References: <20241018034857.568-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation to describe nuvoton ma35d1 PWM controller.

Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
---
 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
new file mode 100644
index 000000000000..95f0a0819f53
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
+    maxItems: 2
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
+    pwm0: pwm@40580000 {
+      compatible = "nuvoton,ma35d1-pwm";
+      reg = <0 0x40580000 0 0x400>;
+      clocks = <&clk EPWM0_GATE>;
+      #pwm-cells = <2>;
+    };
-- 
2.25.1


