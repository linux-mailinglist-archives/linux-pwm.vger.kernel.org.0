Return-Path: <linux-pwm+bounces-9379-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vEtlM5YEPWpavwgAu9opvQ
	(envelope-from <linux-pwm+bounces-9379-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:36:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C32C06C4B14
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:36:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=TN1Qy4n4;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9379-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9379-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2C723005310
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42063D34A2;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0273CF217;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383761; cv=none; b=L5GyzVh77TFCJUvy9JeCIc9qcpxTPQcFdmi6hLVgo4ZwSlUFjhGGBjDSgfw+HSnPRpjf8YaUAXPQUOVtY3iWq7hOXosYfqJQfZOT4eOSZM2GPRaDTWwo4W0Ux1w4m79moiqguGJOqKiKes43AN4PndZmdOPboNgvFGSchUdx5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383761; c=relaxed/simple;
	bh=kgoSJfCQHW0+Dg62ei7S7n3mzCu8wyzu0Bm2onZRb/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIDfcLqwEFxma2Fa/1axivHX28hgXhuJSzMy/zjcgPT0mZYSBfj0/m4KkUnrqhRAerGROk1dRN5e0ruZD9xQ1oUGJSEXryzl9nVF+uLslr5J73zZivwjBmyiKnagG3LJRD5tFkHPIcqs417Px5eWWF54E4G4gyW8c8xQOrv2PcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TN1Qy4n4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E7EFC2BCB7;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782383761;
	bh=kgoSJfCQHW0+Dg62ei7S7n3mzCu8wyzu0Bm2onZRb/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TN1Qy4n40Ub0F2P1DbfuQ28HEwThFpqv0n1lbztjKGnSrKVaWt7qO+BJxlrahxK72
	 AyJRfeErtAVd96xN9E0IJlOZ1aX9MXBn0xMPeqZrWMjMCBRwUMQgAGtbD8S9ZDZp/9
	 3j77wI3GG5woLiXFA+b2szNt9HQE78d6i5FdUOvcBs6IJAdf4Qk8IqklH3zm9YVvOw
	 KuQwFRHFo2Ut53u/WwceLZvcgedMuQIvSOdP4MAnrm+MaKCGs99F7B9Wr8qTdOCoC8
	 x2HltgbHMC7o3cFpm7iPUpMF2qK9CevI0ZdQNI0pl1ff2axkFZn520JQ6y1c8HRfqM
	 8Hv6alUDodVcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C0CDB479;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Thu, 25 Jun 2026 18:35:59 +0800
Subject: [PATCH v6 1/3] dt-bindings: pwm: add support for AE350 PWM
 controller
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-andes-pwm-v6-1-3aef11711017@andestech.com>
References: <20260625-andes-pwm-v6-0-3aef11711017@andestech.com>
In-Reply-To: <20260625-andes-pwm-v6-0-3aef11711017@andestech.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782383760; l=2621;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=AlnVaPc7CqtbKonPziakNqedexQPh0xwvAlumniDgw0=;
 b=2aYvFFnDpe6oSZumlqJ+lHU/NX2YFjCougsm0zS9IGtdrNriyDSw1bautJElHww3R7d7wuHd1
 IMX2fx1WVm4Alg5fXblwKGucqa5imnv97K1GxSo2y/shx8Up9EcEtCH
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9379-lists,linux-pwm=lfdr.de,ben717.andestech.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ben717@andestech.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[ben717@andestech.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C32C06C4B14

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



