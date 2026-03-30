Return-Path: <linux-pwm+bounces-8406-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPTmJkgqymnX5gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8406-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 09:46:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47737356994
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 09:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF50C3008A60
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9383A7595;
	Mon, 30 Mar 2026 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqAhYRol"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63123A6B93;
	Mon, 30 Mar 2026 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856745; cv=none; b=X2gP8rFyo+kYz+DgIQQeqjY7wEgaiSPvgGnXY18HYvHPRo1A+VYtY/HxoLdhWyWPcZECHe0xmn5rV29IG9uWG+2Akovra3ywZ5eZ5PVQrUlg//7fpnUHrLdjeeS7atLpQWFDxWJij17JV62hZn0MrFharhHp8TFwV44whx00raI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856745; c=relaxed/simple;
	bh=kgoSJfCQHW0+Dg62ei7S7n3mzCu8wyzu0Bm2onZRb/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YcU/UU3cHeY1FQlYsj2oVq1amN2HxE5gYVopnHD9Qx6KH8NsEvZZX65K/IwJCa8CDFSCmoAyb+MLVDOdgkO+D1undX50+WaJwueASXoO2jeJ6NJF72ImlmGpH7sKwDFqI+7UcrokAVz8gGcSxrEvrSqetN8QCxOAGfsq3MylRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqAhYRol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 455D0C2BCB1;
	Mon, 30 Mar 2026 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774856745;
	bh=kgoSJfCQHW0+Dg62ei7S7n3mzCu8wyzu0Bm2onZRb/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GqAhYRolWpytfcV1zWzmDgJNplfJgUGPaXMaSZJATUbC3L6JQ4ySGzqQ1PSY+rg9N
	 hU2eUKozyIHqdXxHXrl8Lpq63LFmQq1dZ8JzOAGUUNMGPohrtc4BEaLDGN9dHEI8nQ
	 NRLV7vepGWoCsHvD7y8chNJ1w9eBJ3W7bomSb/gi755SV7JhjaOO0MBqovBh1s66Sy
	 dN0NEcdl25qDxCICsl7jYtGsx9QXeEBT1ulxisPrPVYTHLffH4ME/osMtabJ6N/GPV
	 14PC5kwKeHkT+bOAl7Ov7LS048uv0z5nQ6JDiBy3aijIkq+E06lh7kzzebq7Nwzg/7
	 bbXf1MiOePmjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329F0FF495D;
	Mon, 30 Mar 2026 07:45:45 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Mon, 30 Mar 2026 15:45:43 +0800
Subject: [PATCH v5 1/3] dt-bindings: pwm: add support for AE350 PWM
 controller
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-andes-pwm-v5-1-01c59a659d2c@andestech.com>
References: <20260330-andes-pwm-v5-0-01c59a659d2c@andestech.com>
In-Reply-To: <20260330-andes-pwm-v5-0-01c59a659d2c@andestech.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774856744; l=2621;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=AlnVaPc7CqtbKonPziakNqedexQPh0xwvAlumniDgw0=;
 b=NQOyVYcjYUUSVeYI2PvV/eVJCV2abYR/Dv3E4X9Vto8KYnm3pmMWXddT4V6zIj4HtOCkXvEAa
 NMToDQFCh0GAnZYmD+QV3FoBoAgsGFan3Tu1QFNl8+MZ7LPrsT3tjN+
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8406-lists,linux-pwm=lfdr.de,ben717.andestech.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	HAS_REPLYTO(0.00)[ben717@andestech.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,andestech.com:email,andestech.com:replyto,andestech.com:mid]
X-Rspamd-Queue-Id: 47737356994
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Zong-You Xie <ben717@andestech.com>

The ATCPIT100 is a set of compact multi-function timers, which can be
used as pulse width modulators (PWM) as well as simple timers.
ATCPIT100 supports up to 4 PIT channels, and each PIT channel may be
configured as a simple timer or PWM, or a combination of the timer and
the PWM. This IP block is a core component of the Andes AE350 platform,
which serves as a reference architecture for SoC designs. The QiLai SoC
also integrates this controller.

The binding introduces the following compatible strings:
- "andestech,qilai-pwm": For the implementation integrated into the
  Andes QiLai SoC.
- "andestech,ae350-pwm": As a fallback compatible string representing
  the base IP design used across the AE350 platform architecture.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 .../bindings/pwm/andestech,ae350-pwm.yaml          | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/andestech,ae350-pwm.yaml b/Documentation/devicetree/bindings/pwm/andestech,ae350-pwm.yaml
new file mode 100644
index 000000000000..287f3c62965f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/andestech,ae350-pwm.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/andestech,ae350-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Andes PWM controller on AE350 platform
+
+description:
+  This controller has 4 channels and two clock sources. Each channel can
+  switch the clock source by programming the corresponding register.
+
+maintainers:
+  - Ben Zong-You Xie <ben717@andestech.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - andestech,qilai-pwm
+          - const: andestech,ae350-pwm
+      - const: andestech,ae350-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  clocks:
+    items:
+      - description: APB bus clock
+      - description: External clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: extclk
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@f0400000 {
+        compatible = "andestech,ae350-pwm";
+        reg = <0xf0400000 0x100000>;
+        #pwm-cells = <3>;
+        clocks = <&pclk>, <&extclk>;
+        clock-names = "pclk", "extclk";
+    };

-- 
2.34.1



