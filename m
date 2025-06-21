Return-Path: <linux-pwm+bounces-6467-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE534AE2AAD
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 19:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2589C189C352
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896252561D9;
	Sat, 21 Jun 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f+rzv4kK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TdnOdTuE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B5230BD0;
	Sat, 21 Jun 2025 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526495; cv=none; b=t+pzOkNWahJpyJrpr+HglH8sPjZMy0SivgRhkL+Zii3+AzA/Jgd6HEdLY7Hj/PpJFkbmvL/BNDcVMJPLpecAnrpSQUi06NMLPp4xikzOAFhRjrcVS9x+oxDHqfw1LgyEymwHmZX5lyB881zLlBK7jJ4kl7Jzv80+qQvO8l4i8TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526495; c=relaxed/simple;
	bh=z3jk5cgOJrrfERdNtJgPjyi/kDzSGuReHKlJyTwiFBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMQRscDUdrJlUYmIgiOTD643GfRw/I1wZJJasRBAab3zs9mj63Be5faAkycUSSieEM2aGJtom4F24EIWzVz9v6EMA4zSPLhoXHMV82F3Tyzv4TLOqXsgAq8kBE6fyXzxHJkIQLIA0e9knpJ9BaUJclKhvq7vVfNqa6sHpqvoHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=f+rzv4kK; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TdnOdTuE; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bPh2s509yz9sdS;
	Sat, 21 Jun 2025 19:21:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750526485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7qck9y7mYjLxwnPq+4JOmurFxi8yE/QamrmDP0kVuE=;
	b=f+rzv4kKgwAP6tHHx/+lLgdyStsacGJ61yyrFmV3n8fW8iJpkyx9NW74Tol8bdcUnW76MZ
	lUX+FxqVliy4rw/sxGr7L4znCvt+Eyo4f9daBTAN0uG0WxL+x1nGWYx7UjMFJMZw2aig9G
	VJ8UjwFtanTOxLy8VcGEIUszmg+dsIBZC1OcMnS4YpY339oWSYu/X5zm4doI3EQdJdekBE
	/5BY1vCIcl0GT6ky7k2AWmlvrsaIkC0fMQ58XNTnZDrlvTCSMz2x0YnwMGAbB9b5BaCD6q
	cw+kxINUzE+GiGs9CXprCsdpdF4adFnViqqZTOS4K9UxkIzlSPQwaM6YqiBbgw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750526483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7qck9y7mYjLxwnPq+4JOmurFxi8yE/QamrmDP0kVuE=;
	b=TdnOdTuEYlAIATfxEAKCnTsNtnKdyPfYLpaFcVGZ6J+52jCedDA22ZLT8HKEKHKvd8WKPk
	V4cykQpSBi32nKV9Y7glUNEXoikmXIuLSyQf00BLyztFKe45MoJz8Nlxll2glU9JowbZPW
	/qDauSWaZUFlil7SDDe6CnLc8ZjNOdCkra07wFpfQSM4dRnzuc+p1N3pWrMpDa/oz5n+bk
	g9zw+AiE2W/AxPZ0jsqaisXasQCRJGLFa1NRAPEall8CAwooCXa0oivIcOF6f7L8wSu4pl
	bLruFd2/oYm5qxaOjdgJWiJldvSZzZS4iJzJNy2q2xQ6BIZxjwaSMsF8EDi2Uw==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: pwm: argon40,fan-hat: Document Argon40 Fan HAT
Date: Sat, 21 Jun 2025 19:19:55 +0200
Message-ID: <20250621172056.160855-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
References: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yxepinm3qcgo7qsu9zqjhnyoy6jd3scf
X-MBO-RS-ID: 25d5be38f4f20944991
X-Rspamd-Queue-Id: 4bPh2s509yz9sdS

Document trivial PWM on Argon40 Fan HAT, which is a RaspberryPi
blower fan hat which can be controlled over I2C.

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


