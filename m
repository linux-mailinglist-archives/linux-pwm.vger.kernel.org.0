Return-Path: <linux-pwm+bounces-3673-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB35E9A069D
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 12:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9ACF285095
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 10:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19620606C;
	Wed, 16 Oct 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaYBAYCd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403921E3DC;
	Wed, 16 Oct 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073298; cv=none; b=VmVYzDXfZJZnwk5y1ApZ+xOS2REMoAC1ayzqe7AAdBl/5L23rJqirwXs40Pr32tR6X064BfQ41Bzeseajd4qcdgE3Cx+xizug1Y5rciyWcsak91xzwO+R+JqtxSiXmPyC6RuA21lFLQLfeeKzxw6vCbJa+kIUz+cvcYVxbIaZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073298; c=relaxed/simple;
	bh=PHnsXDPgonSGur7LNFvBXgYxGpnNy03h+D9rXnrfuM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+8UGFdoPKwFuXkwXOZT9f66T1Bs4DR7rstmUGrkJKo2++nDmaUSrG9ffs8+Lu2Aov+BLwZBsr275RtV+DwRDms+g2+5pW1biGWGnxhnlZNG4/piIHPepAaxFIieo7VLmOh+cHeWjGbAv6+E4vjFDEUmjbyqlL5s4PIs24uCH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaYBAYCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B067C4CEC5;
	Wed, 16 Oct 2024 10:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729073297;
	bh=PHnsXDPgonSGur7LNFvBXgYxGpnNy03h+D9rXnrfuM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MaYBAYCdurWRnQ4W1G4JU9TRWU8zw+mvGlCGZnBK2fsWV6mKs65ClRqFF5WZJYRVC
	 /MKso7TzXaFZu1ILW1OtQX2SNZhDRj5QVycqGtzoIKKUzQuC/wh5hAKVt/0zZIMAFX
	 ovYw1ip4ddI6coC2WlpJiZRRKvl+A35PYs4uo7gWBl+A2YKPYytQiYLWaL+xvwhUW4
	 3iaBdNdCLTYP5DMdWSfmfOXXo3F92wGcJgtgRIVpGApuStTJBmTyFi/x/zceSyccVr
	 f4aWoWugRMCxeVSN6lnQAeTqOlo5C+gbOSciwAKsDeMGp3P93qNJdmkLYACsIJRwcx
	 3/6ONOhRRTEtg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 16 Oct 2024 12:07:29 +0200
Subject: [PATCH v7 1/6] dt-bindings: arm: airoha: Add the chip-scu node for
 EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-en7581-pinctrl-v7-1-4ff611f263a7@kernel.org>
References: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
In-Reply-To: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
 linux-pwm@vger.kernel.org
X-Mailer: b4 0.14.2

This patch adds the chip-scu document bindings for EN7581 SoC.
The airoha chip-scu block provides a configuration interface for clock,
io-muxing and other functionalities used by multiple controllers (e.g.
clock, pinctrl, ecc.) on EN7581 SoC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/arm/airoha,en7581-chip-scu.yaml       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..67c449d804c22b6b8268c9840995fe2584349b58
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/airoha,en7581-chip-scu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha Chip SCU Controller for EN7581 SoC
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  The airoha chip-scu block provides a configuration interface for clock,
+  io-muxing and other functionalities used by multiple controllers (e.g. clock,
+  pinctrl, ecc) on EN7581 SoC.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - airoha,en7581-chip-scu
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      syscon@1fa20000 {
+        compatible = "airoha,en7581-chip-scu", "syscon";
+        reg = <0x0 0x1fa20000 0x0 0x388>;
+      };
+    };

-- 
2.47.0


