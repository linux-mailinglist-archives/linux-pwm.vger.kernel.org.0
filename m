Return-Path: <linux-pwm+bounces-2797-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6654493100C
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 10:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9846F1C218C3
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0869185E50;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhvnOXtP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B64185631;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032803; cv=none; b=X0BeXKSZt2aU2vIqDpe4Drq83EuOrNfHbd3ZcvbMoolXQlkSrwFWbddEW1MJTOGnH4soh4d7LM3vx5/lmRyrTJKb/97Wa8/umZmLXsOEFH/iymNdN7buUVzYRBZrHZB/pKZQxrt0ogF6Xjk9GtQhX15PIvcJcjvFmKVpxGNC6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032803; c=relaxed/simple;
	bh=3Q2bRQKoQu0LqnylJP2cSZjMQXfgAIE/N3cWrJixn1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gV5EYsMHo9iipXnOIifG/Rzx5QLZBQSY+85dYzfKTW2eLWDU3LBFPelM0SGtO4uFyPfd/v9jNQMUGwqAh5uJmf9tbQd/havfyITRE0T89PhrtSV7LXRk/84F7HcVZh/9q/yZV4cF006Nt/PcCJHhfHNwI+7jzABhTu8h3ZoevUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhvnOXtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CBDBC4AF48;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032803;
	bh=3Q2bRQKoQu0LqnylJP2cSZjMQXfgAIE/N3cWrJixn1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bhvnOXtPe2V+0ZE6xhkclKdKucwzv0M9Wem0d7QYueCK543uzMexHXjjHjda5GflE
	 ShoSwSe+2uJbUdqPyBR6AaGiwcLveSjx6PQQW6q+hE8lcIKZIJ+GPF5Hj/WQms+hTT
	 93TRPk2K1DDcgleifljDiKhC9ffdmFE5NUEtxVztQ3hzHHegGO8e1JhQ8cLRbJrRW/
	 2s79UGnm/39nCYoUl5iOtXFx3mrthKfVW05s1ITOdLVKN7YYbNv57j2x2IN8SW50z8
	 zolK1FuU6+5JfnzA4TUZok7GfmHmHUDG6QYfca7AA5g0aafX6T46A6m7mAF7mRt8T0
	 ua9K0wXbA+14w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C29C3DA4D;
	Mon, 15 Jul 2024 08:40:03 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 15 Jul 2024 11:38:16 +0300
Subject: [PATCH v11 12/38] dt-bindings: pwm: Add Cirrus EP93xx
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240715-ep93xx-v11-12-4e924efda795@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
In-Reply-To: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721032799; l=1848;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=z+2yOwm4hvQxzJhJWQahTMtiq2gz+415iGkW4eGQ8Eg=;
 b=lg/mg2q13y006104VQFi6zPTrOkSBNnSHGgpmfx2fsZOMNar6wn+joch6V/RrtHNgNOhNhdmopWT
 Ck5NlT7CCk4ng4MbUZvPpEjBSA1yRP57OrdrK77IZrAbaXV3kAQG
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add YAML bindings for ep93xx SoC PWM.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.43.2



