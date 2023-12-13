Return-Path: <linux-pwm+bounces-520-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A5A80E5D5
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 09:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EED1F21862
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F992233A;
	Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pt9KPg09"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932211A28F;
	Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 327B4C116A7;
	Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702369325;
	bh=a/cZdGJuuVrU9Ek8D9oilewhzZsfNMnr7caWbQucbUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pt9KPg09r3jMiJJ6aWUIv5G1tg8Qp2+aEtuMJ7yFylEpkXRh6i6tjMm9pXnDUGnS7
	 Cv0gNjR3bUL4iPVKPMw4jEE5BTji2jCnmWJ3IIPVmnajK+uFkkuLSFjiqvJ0EoSrdw
	 p/nD5vnETgjP1rB+hInwdieVxTLKTz7jk+sRrOnzwOrNGKOgj5zeTHP8+3omNjlZmM
	 mQpBVDcdwRzd1b2rRCpD3jEDdnHEuuWAFGaA66r9Kef7XZuz+gDLxMRC1LlJXnWPAS
	 2JvmdgWzp7L+k8eUQAzS6ATNF8yTd2FgzdPoT/fcccLkK7pV8kUKKsyXrJa1vPamOw
	 vDwqRLgL9XJsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DDBC38147;
	Tue, 12 Dec 2023 08:22:05 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Tue, 12 Dec 2023 11:20:30 +0300
Subject: [PATCH v6 13/40] dt-bindings: pwm: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231212-ep93xx-v6-13-c307b8ac9aa8@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
In-Reply-To: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702369322; l=1848;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=yiCeIO46pBt38m6arFX6dYafL64TrLSuKy+InISqKkU=; =?utf-8?q?b=3Dwr9OAY+iSHXW?=
 =?utf-8?q?3CdcW50cK4pZHKIutn0mgqORqGrxNWwgq2l7KrvnxRa3Fxbyk8lxb1B5MueySKjM?=
 JNqNVvxNBL/4qEgLvGp2wwWB04qM8r5sTc64tuX43sBmzGqJA81V
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC PWM.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml b/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml
new file mode 100644
index 000000000000..903210ef9c31
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/cirrus,ep9301-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic ep93xx PWM controller
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-pwm
+      - items:
+          - enum:
+              - cirrus,ep9302-pwm
+              - cirrus,ep9307-pwm
+              - cirrus,ep9312-pwm
+              - cirrus,ep9315-pwm
+          - const: cirrus,ep9301-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC PWM clock
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
+    pwm@80910000 {
+        compatible = "cirrus,ep9301-pwm";
+        reg = <0x80910000 0x10>;
+        clocks = <&syscon EP93XX_CLK_PWM>;
+        #pwm-cells = <3>;
+    };

-- 
2.41.0


