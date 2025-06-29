Return-Path: <linux-pwm+bounces-6573-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7530AED195
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 00:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A0216F454
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Jun 2025 22:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879723E344;
	Sun, 29 Jun 2025 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uYMTbo40";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RI4qMhNd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CED1DD0EF;
	Sun, 29 Jun 2025 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751234905; cv=none; b=K2jMTbxl2WAmwG4uNF513GZdliV+H+Pwn8SfxYF8Lgf4ahmAM32JbBx/TBdfnvJi6YLGrpaVoIDqfeGU8qa3OVnSTvLN+MLVMfIOOJzkBgJt35OltuoVdbNo0h0VvCzNhkOj0NtnRbkSQwKbHo+2NfmrwCT8YdDWWf8he4h5AaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751234905; c=relaxed/simple;
	bh=pWKKtMJoC4ym6LjvnfUZUhWU3lNfdAw7ekqyS7Ao5aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjm2YPaKpwGzL1d9TUfe0VwBhZaWBxC1pbNPsAIXmcFLzbKekIxcMdhFIc7B3ENbJqxYoivFl1Whu6vnvyNt7WMxpF3sRt7SG0ANt/9Pw1S4pDcTjY2AlU3XivOp1i342EKMQTEoDfGvm72Ix7OsPzyhnV/nFmRw5S+eia87fXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uYMTbo40; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RI4qMhNd; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bVk275LVtz9scD;
	Mon, 30 Jun 2025 00:08:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1751234895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMYpr1RoDIqxuxAABoByp2vpsUtIB12jb9I91/KMh3w=;
	b=uYMTbo4038kw1qq5dAH3mjKQTqtmQ9L0fHcHDFgOxlqbaYQbF508r/2lJ7wGncK6/6OAY/
	TlZr+TiiojdGQaEQVhHEz38UUEF69TFZfMjqpwheenoh17oTxyVhBDHw6rCWfTCa21lTKs
	386xI8xe71gvicWnLFwSNJRr7sqbxoN5DfPPHarKeoJwX8dvmIK5vfmHKLtahvSZpOHyS/
	BqKRx/q/RhSaE0YBucuOn199x+sy4jpvOSTXus7136pTX/WOqlzYhjjziuGH9+/mLzeuFw
	15RuM83Ob0wPqNQmVt/Dpnaz1pkR2PQVJkzz/u7FfQ4JT5oX0L4ysfVoH34PxQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1751234893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bMYpr1RoDIqxuxAABoByp2vpsUtIB12jb9I91/KMh3w=;
	b=RI4qMhNderomo14CT2I2D7NpJcLgVrvlfBF9lecsKDoWelgnO1mUlHVNY0OPNxNgYfNNkr
	8R/KYQQMsLfQLjd/ZmcXCX3qux5tpSN3qOzsB9FMHSVrqvbUxPFFsf5TG3IlPXsVYDqk60
	UC/J96ZEoS61c0Ln6VwxivpyPXKLpk8iHCPJa7+qQUJUaLISzjUv1fbkzbKx81yrGE0wZM
	EHXvRUiBJd07TvDOrg5WfgsPtavZUTF9IwH+IUcvCMm0a7HFGteHs42Fh16hjuW3dqlwoq
	9p0aymQy4v0W3oItPXnhrp8dd8n6E38t0BEaYobYnW2m0GRZr6VD2RdJZEG4Aw==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: pwm: argon40,fan-hat: Document Argon40 Fan HAT
Date: Mon, 30 Jun 2025 00:07:19 +0200
Message-ID: <20250629220757.936212-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250629220757.936212-1-marek.vasut+renesas@mailbox.org>
References: <20250629220757.936212-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cfcdac191f9fb2db54b
X-MBO-RS-META: zmpi3dzbk87f4fa3wa7hbz84kzzxui6f

Document trivial PWM on Argon40 Fan HAT, which is a RaspberryPi
blower fan hat which can be controlled over I2C.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Implement dedicated binding document
V3: Update the description and pwm-cells
V4: Drop | from description and fix up pwm-cells = <2> in example
V5: Add RB from Rob
---
 .../bindings/pwm/argon40,fan-hat.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml

diff --git a/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
new file mode 100644
index 000000000000..7dbc7c2cd802
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/argon40,fan-hat.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Argon40 Fan HAT PWM controller
+
+maintainers:
+  - Marek Vasut <marek.vasut+renesas@mailbox.org>
+
+description:
+  The trivial PWM on Argon40 Fan HAT, which is a RaspberryPi blower fan
+  hat which can be controlled over I2C, generates a fixed 30 kHz period
+  PWM signal with configurable 0..100% duty cycle to control the fan
+  speed.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: argon40,fan-hat
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pwm@1a {
+        compatible = "argon40,fan-hat";
+        reg = <0x1a>;
+        #pwm-cells = <3>;
+      };
+    };
-- 
2.47.2


