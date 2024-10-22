Return-Path: <linux-pwm+bounces-3763-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36F9AB9FD
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 01:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 094A4B22CDD
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 23:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A8A1CEE80;
	Tue, 22 Oct 2024 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+GwTg2e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52921CDFD8;
	Tue, 22 Oct 2024 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639283; cv=none; b=etc/nLhZ1kSA43yoxbTvWbIM6aeR8ldYc42sZ3SbFPtOS1YR08uBTk6B8m774GE9E0VmGvYfuDS8gBk2lYlsZa0Uh8yIgUu/V77hsvAmZeHvozpXUTbsBWddtbg1pHuE9OkMGEZF1Mkai3xn/cavU09oSLOfchgiGbXac04yaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639283; c=relaxed/simple;
	bh=xf3O2KqOGEwytXIWpIp/7uLYcZVVkfANHvZ0KvLjCYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGqZZVAy54v0Yqx4vTl4lnfflBWU0kyhROfYdhkKvTk27Nsuj3au8z1J7jBH6aCNFrYSxuW+NpTyZq7S6tEtobAKd/+ocUTISKlLsvtFz1c3rChP7OEK0/MSd2UP0/Gdv7A7kg6797OjpxMGDNpnLuUnGHOf/1e2ZukbKZFjV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+GwTg2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695B5C4CEC3;
	Tue, 22 Oct 2024 23:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729639283;
	bh=xf3O2KqOGEwytXIWpIp/7uLYcZVVkfANHvZ0KvLjCYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j+GwTg2eSbXQWi89oilcew2yw6HcVamSZ41rytTTRu6g1bRuDKwa24e3wad405X7Z
	 2b2G+EZC85Y55v3C5NM14fBnykS44z3Ap9n4oeiI97rjhZCaijc1HMOZsGJkgGboJG
	 SGfwpYjKJaYn+uvTqsMuMS/C4MGjMJvXkU6aV4rTeqzvuHMMandj+Sv8cHfv1l9IA3
	 Bw7jeDS5wQ4l1CtRvdS4r3fu3SZ+PMHRTMT/4cMVRmgk4hNHN7aSdbndt+M6uXdgY5
	 SiiYHa180wEQ2V31Q31yFyvRjUe1tWZJ379zbswRPLgDfEntYKyiIadLzI3Pkl0IWp
	 8ciB0tPdJE0aw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 23 Oct 2024 01:20:03 +0200
Subject: [PATCH v9 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-en7581-pinctrl-v9-3-afb0cbcab0ec@kernel.org>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
In-Reply-To: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
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

Introduce device-tree binding documentation for Airoha EN7581 pwm
controller.

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f36387572a9781636aeacdbcc8947017c7ca75a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/airoha,en7581-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 PWM Controller
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: airoha,en7581-pwm
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm {
+      compatible = "airoha,en7581-pwm";
+
+      #pwm-cells = <3>;
+    };

-- 
2.47.0


