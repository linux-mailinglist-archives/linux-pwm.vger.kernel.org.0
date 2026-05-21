Return-Path: <linux-pwm+bounces-9041-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFmvFBXDDmrXBwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9041-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 10:32:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FC35A1149
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 10:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC8A0303815C
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2FA35675D;
	Thu, 21 May 2026 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6yFaNgd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BBE2BE655;
	Thu, 21 May 2026 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352028; cv=none; b=X/KFJai2OB4kZ4BfciW7JusqpfRK/hpN9ZGsIPgMmW+pwz08GxFK1p4xaE9uy6bVOmusSudL0L7DE7sr4w2Po+Q05zmBIzQTgsZAoOwKeJC6c4Nv2aEtP5cnv97ZQclsSzKIJMr6Hly41xt0AQiXDsPfwDcoBG6aEPbb+95NOcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352028; c=relaxed/simple;
	bh=zmdM0qo8CX3kHCzsu50etCsSTnTDcsKCliyCWlfpcmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fiOkz6A61tDiMPIwF4Tle73tH/yTrM0oqq35XZzW2UwQj5oJvE1axUu0hbBy9kgf4wDdaWkomrUMxT7+Y2Qrw0FA5bqLgzG/lQojKgeoqfV7PNya/VCRwayxqFy4tftnpjLZpc5YrPjKewjSEHlKRmsZFw2dBqdjDXZbAGf+tS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6yFaNgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1425C2BCB9;
	Thu, 21 May 2026 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779352027;
	bh=zmdM0qo8CX3kHCzsu50etCsSTnTDcsKCliyCWlfpcmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O6yFaNgdZ24tPvORkMDqT/9LMQnMurDaB0VGaCv9k2n6g3R9AwMAoTJ8gKyvmhPD3
	 shazdxiAydFEJEEnQAmFvRmKU0m84kZm22IuS/Np+c+V40xeFCf3s6LDRmF8pwy3HE
	 4b8+yxbhzCE81SMAbb8XgA954uxpsAX8hnZ2YoBWwoDPDVAn5KWUUm/URlGtcNEzZ2
	 OtL5+5yewLoVWNLO1qi76SG6BDi7W5gSND+3G/Xn44EdCgmfDQhsqARSuzu4822RXJ
	 itwfKx4+5OF2Fa2D2vRF7SNK/KHd+KzMu1DTtKHO3WPzfUMI+UIPpVx7rXLUZHE2hg
	 33AwzqyPSVbWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8943CD5BA4;
	Thu, 21 May 2026 08:27:07 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 21 May 2026 08:26:58 +0000
Subject: [PATCH v3 1/2] dt-bindings: pwm: amlogic: Add new bindings for S6
 S7 S7D
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-s6-s7-pwm-v3-1-57b073fbafef@amlogic.com>
References: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
In-Reply-To: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779352023; l=1811;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=jS//+H3tRKyNMEGVeMFEtfJwKQUz9wNI3mixje/H5hM=;
 b=PTJfkqLpXJY8CG2/1IeUXY0TgYTNOuKXgdnZYkkPlxN0t1ApFPyV18CZTxkHoADQboPPPivj7
 f3OMlkjxr+uBJGdSELInRiYPfY0nFDOF5SUPm9lkgXkrKh4Qv+106lU
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9041-lists,linux-pwm=lfdr.de,xianwei.zhao.amlogic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,googlemail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,amlogic.com:replyto,amlogic.com:mid,amlogic.com:email]
X-Rspamd-Queue-Id: B4FC35A1149
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Junyi Zhao <junyi.zhao@amlogic.com>

Amlogic S7/S7D/S6 different from the previous SoCs, a controller
includes one pwm, at the same time, the controller has only one
input clock source.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index c337d85da40f..93fa97f4011b 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -37,6 +37,7 @@ properties:
       - enum:
           - amlogic,meson8-pwm-v2
           - amlogic,meson-s4-pwm
+          - amlogic,s7-pwm
       - items:
           - enum:
               - amlogic,a4-pwm
@@ -45,6 +46,11 @@ properties:
               - amlogic,t7-pwm
               - amlogic,meson-a1-pwm
           - const: amlogic,meson-s4-pwm
+      - items:
+          - enum:
+              - amlogic,s6-pwm
+              - amlogic,s7d-pwm
+          - const: amlogic,s7-pwm
       - items:
           - enum:
               - amlogic,meson8b-pwm-v2
@@ -146,6 +152,19 @@ allOf:
         clock-names: false
       required:
         - clocks
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,s7-pwm
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names: false
+      required:
+        - clocks
 
   - if:
       properties:

-- 
2.52.0



