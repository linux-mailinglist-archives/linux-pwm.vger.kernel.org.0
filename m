Return-Path: <linux-pwm+bounces-4272-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4639E6963
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 09:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B2283C2F
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F5E1DF748;
	Fri,  6 Dec 2024 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5hpe/e4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53561D9A48;
	Fri,  6 Dec 2024 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475319; cv=none; b=pOePGt1id8vUhk2hUiUNL2kbpy6LfUoh2qf4gQ+7nqR+3LkF4qmxxkwN1MHAsgTs3eJxL8sYhMGeLammkB8wg+a9zmchQMkyuCZD+bitNUtx4cioVWgJ0KiUJbtDYDfVRyqFrZWvM6xraBMX6sMui360qd1rjyJvDuQQBjFXaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475319; c=relaxed/simple;
	bh=djPTpaxKBBT/dowHni0yPufq09MGO+vVekcMffEUqJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1mBGA5+YbN/UuLxYcTm6OdLKRYYJ3GY/ZSzc/HcZU+kRFdF8+yK3tpAAH6qGWJ3HuiPsIbDKHBbWOB/lW5+tlm4sBOnR5LQV7zKhVootRYAOvGoqlBA2MPfB9Yzv0dT0bBwwrB7pjiccOaKkZVPQ+uFxcAQBdjYyEqddqHjrek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5hpe/e4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso393677a91.2;
        Fri, 06 Dec 2024 00:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733475317; x=1734080117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajv5kJXI+klsq4X+xfl1HHA/issB2qLSc3s/dFW3XlI=;
        b=c5hpe/e4+R/FpE8RAZrqYcBAtqqm6z+h1zBC5lD8tyrquoDvdJH81UjGhF8BMhaC5m
         TEUMB8icMFDC1YX1xEk+7DnwZiy+46S96mxnhNpE6HuGpZGcW7BSNZJMVozurCttQE7s
         dlF1accjhI5ENtlgur7y8++ZJn1/I0jZ+JLKMni24aVNdfWWW+Sgpx7oylzYJQL09NAl
         6EyrRe57exvSaddCXITJPO/J8ewcv6wmVHBjJkqe1EClQt8JXu4I5JA++JR0lydXpbyD
         DkjzpzNlD39/NmQYFeOjT2o4Jx5kN2XMOaBE65oitvMLvd5nO9tm10vI9iyFL4ldQ8Q+
         tsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475317; x=1734080117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ajv5kJXI+klsq4X+xfl1HHA/issB2qLSc3s/dFW3XlI=;
        b=H9I/SX3T6651gu+BLTngiqIfbHIfT6Ldhru/29/pPdhRJMwwg8AW902Y8buT2YcphS
         vlSaZFfMy3rtdRlX499rsz9L+IIfO/TZhWV57uftdtLwwzNKQDxY9BjwCQWBHaGgdZPt
         988tVxLuIeVarbDLCpch8JIrLhKt2xtUnCwxrw6JTSbEd/zNfZXUeJr61G36n6xm+c8R
         ee0EL+pj/BaKtONPEx/w3q/bI4CXuEl1pQ2yt7P37s9YSumo9EQJ9ZtZpKn+2z52+G/n
         fmD6lHUwpr/rYyCaFDrHWw6akcIGxgOFkpSTb/vqg/nc5IaZHmwz47IsXst/pQIk5wWX
         VnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3YCnXfy0EPXhsrw4SlChyBQ372LInmg6YKZnW48iItQMPe7gvNe7751/IjspZmLpkoj9dN5Djl/qS@vger.kernel.org, AJvYcCXv0ylWY7n/p8bKa4Do6Of/SG+940mh279RycFfUkpT3pJg5OBjFG4WK8HI65XUhX1MzJf+RUTdbFBa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gGmSI5de5X11QWiXNsZjNtSnjPflHBKe9adpBmX4xrF+otYZ
	OcWecMtp92y74SDbNhxJmM5ZzqLkbAhVCh5NsEf1UfNxevZ0D/9F
X-Gm-Gg: ASbGncv2YlXTmCftc+UbCrBj3HbXxXcE5MD8tq/OHzq4+JEoX4EN7b4mFxnqubpZf3D
	c2+ebs+V5Ks4CsIlttYuz+VaiKdOL2KtKY2cjh4Xerk/AefVUKGUn+ZCXy3BY4ZkAvValQO1szg
	jT0+b4J2WZI/SYyFwoEQDcFPBCrAotVVcl18IBr07nx1gg864TVLDhG6p+8l1fhRnN3npp0numG
	cB/pf3PD6kqWwdS3/+TqoYA6t9PH/XDr+7Z3tVOEmQyjYlqoMw7GDdkO/dce2zgb3wIMt089Ic1
	I0vSayF0VPm+tCbcnG7CE3nquK3oGCf2zbL1Zg==
X-Google-Smtp-Source: AGHT+IFa8txHUtjjo8nUX4k2xkRIIL1rht6CtobgvALv2SxBQTXryMkzj4snr/HcNMfwnajmLUZEWQ==
X-Received: by 2002:a17:90b:5384:b0:2ee:dcf6:1c77 with SMTP id 98e67ed59e1d1-2ef6a2dd226mr3273315a91.16.1733475317237;
        Fri, 06 Dec 2024 00:55:17 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef270795d6sm4548157a91.42.2024.12.06.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:55:16 -0800 (PST)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	cwweng@nuvoton.com,
	Chi-Wen Weng <cwweng.linux@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: pwm: nuvoton: Add MA35D1 pwm
Date: Fri,  6 Dec 2024 16:55:00 +0800
Message-Id: <20241206085501.2623772-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206085501.2623772-1-cwweng.linux@gmail.com>
References: <20241206085501.2623772-1-cwweng.linux@gmail.com>
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
index 000000000000..47a59bdd14d0
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
+    const: 3
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
+      #pwm-cells = <3>;
+    };
-- 
2.25.1


