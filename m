Return-Path: <linux-pwm+bounces-7887-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC5FD0CC09
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Jan 2026 02:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99E3F302CDFD
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Jan 2026 01:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E2C2066DE;
	Sat, 10 Jan 2026 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Vl8Vo7aq";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Vl8Vo7aq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F0126BF7;
	Sat, 10 Jan 2026 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009546; cv=none; b=F8vseFJHyC2LMciLmqm7L1FJJa1Rdql3XVSR8TtRbFg6eAShupOFlb65qUTSvmjNQQij9KDcFC8N0WishVWu4hGmUCYWICphrgmBf58p7INJU48tqayV7bv9Z1A+uZoJ35VgysPtMIVfMxoKnbAhLeUPDPLNfgIZnDT2hndues4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009546; c=relaxed/simple;
	bh=qg7Pk8rockg88W3JqvhGHWcVwuZqkGR0+ZYRgz5obY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZpGt4vM4EtpVoSCnp4B5OulOU5q0wtQlJk4AJv4XPz+0Slao0S0vViwXWHZH0SFcQvK+qs3F3rxHF/7cpezvvABTnpxg8MEMSVzMZ2gE/ORKE4lkdU3aL9cw/jY2yM1kyUEblOP64bsTtbYkzTIbIxda9aNjHFvAuFEr0s1rA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Vl8Vo7aq; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Vl8Vo7aq; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768009543; bh=qg7Pk8rockg88W3JqvhGHWcVwuZqkGR0+ZYRgz5obY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vl8Vo7aq+nOgj87EwVbk1ye617XCPDyvUD8hsuZKqhbFw1RnFrHg5GAar0M27rqFo
	 01hssqOfY4FecFCYY2qTPg6Pd9TAUayl7DU54DOdVdljS9PIcujdFRtf1TRGhYuNRR
	 WQyMeJWIZV8Pf66imYFI2zAEpLIFuUDQawW4zGJ/8jBdepylyDND6t/tyhYYb5yYt1
	 lvzPmqE+xRXbE3OmUrdu63l7M8jVSptfP4I3KuJe7LW/mcmge0IilnFOyetapNYRGY
	 c0jS6prFJmxvRw/7Fq8tKB2ZHEhpHjFDTPFvh3vNGAZZSVrMg4RGC+7fw20Ms+xCpF
	 /iKsRyGpKaB8w==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 5419E3EB2D5;
	Sat, 10 Jan 2026 01:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1768009543; bh=qg7Pk8rockg88W3JqvhGHWcVwuZqkGR0+ZYRgz5obY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vl8Vo7aq+nOgj87EwVbk1ye617XCPDyvUD8hsuZKqhbFw1RnFrHg5GAar0M27rqFo
	 01hssqOfY4FecFCYY2qTPg6Pd9TAUayl7DU54DOdVdljS9PIcujdFRtf1TRGhYuNRR
	 WQyMeJWIZV8Pf66imYFI2zAEpLIFuUDQawW4zGJ/8jBdepylyDND6t/tyhYYb5yYt1
	 lvzPmqE+xRXbE3OmUrdu63l7M8jVSptfP4I3KuJe7LW/mcmge0IilnFOyetapNYRGY
	 c0jS6prFJmxvRw/7Fq8tKB2ZHEhpHjFDTPFvh3vNGAZZSVrMg4RGC+7fw20Ms+xCpF
	 /iKsRyGpKaB8w==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id A180A3EB80E;
	Sat, 10 Jan 2026 01:45:42 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: pwm: nxp,lpc32xx-pwm: Add optional Motor Control PWM interrupt
Date: Sat, 10 Jan 2026 03:45:23 +0200
Message-ID: <20260110014524.3379187-2-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260110014524.3379187-1-vz@mleia.com>
References: <20260110014524.3379187-1-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260110_014543_361927_B6921BB8 
X-CRM114-Status: UNSURE (   6.94  )
X-CRM114-Notice: Please train this message. 

NXP LPC32xx Motor Control PWM has an interrupt line shared with TIMER4,
and the interrupt may be used to report events from programmable counters
e.g. timer counter limit (period), match counter (pulse-width), or from
counters on input lines of PWM channels.

As a reference and for more details see NXP LPC32xx User Manual, table 595.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 .../devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml       | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
index cdd83ac29caf..53520f005acb 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
@@ -32,6 +32,16 @@ required:
 
 allOf:
   - $ref: pwm.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nxp,lpc3220-motor-pwm
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
 
 unevaluatedProperties: false
 
-- 
2.43.0


