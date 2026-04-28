Return-Path: <linux-pwm+bounces-8738-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL9NMtai8GlAWgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8738-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 14:06:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B5C484898
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 14:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AE7C305BD9A
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 10:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F843F23DA;
	Tue, 28 Apr 2026 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X39aa3Bp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746833F23D1;
	Tue, 28 Apr 2026 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373252; cv=none; b=YcqTCfsqXTN2yX6xtLc770LN40JBSlxQ4VrCwgg/cEy4mA7jhH2vC43Wg53IR9kLdiZveGc7/SuFhC9pt/E51YO5YBCxdpvzMEEGJ4QhEqUUQVt4gvATV8sVSp2FuSeyr3TFcqdv4gwRoVKC9cU0h+X+3nQDWLDM0/A1hzGBVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373252; c=relaxed/simple;
	bh=biVNnj44nyROszDjAQG/JHS7rf+VdCxkoSyME9XB4h4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpbw7Qxc0J3VReaSVIXVtQnHdwI/xl+eHcIeOxON91Zq7MDlczoctsK8AIcmbQlL6EtMJry8LryxxTSxO/0Jywfw/+GJ1Svg6OqXEcgJkWCgjRXUNskfkL8SDVDP8XadHHWCsW9sJi+g+xLOfFPFJpuAkj44JbvSe1np/Ft9ESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X39aa3Bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249E1C4AF0B;
	Tue, 28 Apr 2026 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777373252;
	bh=biVNnj44nyROszDjAQG/JHS7rf+VdCxkoSyME9XB4h4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X39aa3BpFBo44aZLazv1bsS23sFrNYYYYTQSft0BSJAxKWdtGI71gfQpigMoU6QB1
	 zvfuzk2MkVWMiTmCIc9CrGm8v+/tWKkFlgCG9kkb43/yb1lla1xT6d4iLfPgdNAjLr
	 gAc25FINjZwaeYtEErB0QC5R5HoBJ1SUiyo3EoDHkqBsTHT+g0W5i54xzdonoCMSS8
	 iC/qQOgR9laIINUdZz17JO6FHd+GckW6Nnf5dnIkFQhSXxtn6INtdJA2vUGPkPiDYA
	 eRhfiu2v8rNOnPaWua2xG5XzDKWlIad87ot0cmF17AeVkaHyZhjaXTWIGG7QBBVB7/
	 c/lFvylGFWkKA==
From: Yixun Lan <dlan@kernel.org>
Date: Tue, 28 Apr 2026 10:46:50 +0000
Subject: [PATCH v2 1/2] dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K3
 PWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-03-k3-pwm-drv-v2-1-a532bbe45556@kernel.org>
References: <20260428-03-k3-pwm-drv-v2-0-a532bbe45556@kernel.org>
In-Reply-To: <20260428-03-k3-pwm-drv-v2-0-a532bbe45556@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=dlan@kernel.org;
 h=from:subject:message-id; bh=biVNnj44nyROszDjAQG/JHS7rf+VdCxkoSyME9XB4h4=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBp8JAzbxoxvfNt5e31UbcJ3YuMnHh9PBtr4V95h
 HF4T2gTpF+JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCafCQMxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0SCA//VjCRt3c1R06Q3Ls9SLP+8VAZ39oa1vThtZULnb59dH6hwkXOqMK5l
 /l+gQLMe5hnc0cNVEGzccbtyc0ez+yaV8bJKPnhSiReNo0fHZWp6C4O2KYrOr3qVo3hP+xKurjH
 /Sgc5KVknQCuL23CpZYrI84Hiu7X9nBhtz/Lb+WY/NKN/IWFQv7PEh1e5ucTbWi54Yw5WduLfsS
 iO3YGjIyy235czRMWE8T588LUz3Fcnwzjr8JBlTjUSd0MjC/jpgVGN20M4OrQcmC7yVj5RPYZCV
 pGpQgK1m90gi/BuF6TRKacWIZ5Zvev5IN4xoX6FO52Zi6ACEpz5Id6GFpB+bdcK9nOSBAes1Yxn
 0MBv1xUFY/lT413wWEkrUWkQJj3M5CYyWu/V8YnMiOExjCYajJaiOir3xNVIm7b958hmyFpTGZf
 0h5xSWSxDXiic+4dmOaHBEHbNVkFMhidfnsrpYgeKx+ykXptDspFNLPmLjw6SQw9drzZo2w2goG
 8jO3N1rEPiFIWBd4LZbgf0+/6PKFeTLmJ2pVZXV4pbkmMfdAYUDjz6qyMwNqSOYvONkrJHyNbLY
 6dAa8Y0zv8YJXqDWnsVEMSfPjgU8TCDe9i/VHb3mCbKEGVmZJMOrolwlMTZl9PHqn3fkjFqMmPV
 mlXbBjKEKrv4tOI9/l+WxWETNki900=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-Rspamd-Queue-Id: C6B5C484898
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8738-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The PWM controller in SpacemiT K3 SoC reuse the same IP as previous K1
generation, while the difference is that one additional bus clock is
added.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   | 41 ++++++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
index 8df327e52810..f1422a401b6b 100644
--- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
@@ -15,7 +15,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: spacemit,k1-pwm
+            enum:
+              - spacemit,k1-pwm
+              - spacemit,k3-pwm
     then:
       properties:
         "#pwm-cells":
@@ -26,6 +28,26 @@ allOf:
           const: 1
           description: |
             Used for specifying the period length in nanoseconds.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - spacemit,k3-pwm
+    then:
+      required:
+        - clock-names
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
 
 properties:
   compatible:
@@ -36,7 +58,9 @@ properties:
           - marvell,pxa168-pwm
           - marvell,pxa910-pwm
       - items:
-          - const: spacemit,k1-pwm
+          - enum:
+              - spacemit,k1-pwm
+              - spacemit,k3-pwm
           - const: marvell,pxa910-pwm
 
   reg:
@@ -47,7 +71,18 @@ properties:
     description: Number of cells in a pwm specifier.
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: The function clock
+      - description: An optional bus clock
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    oneOf:
+      - items:
+          - const: func
+          - const: bus
 
   resets:
     maxItems: 1

-- 
2.53.0


