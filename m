Return-Path: <linux-pwm+bounces-8526-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJOXD8P21mlUKQgAu9opvQ
	(envelope-from <linux-pwm+bounces-8526-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 02:45:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D17B43C5184
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 02:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E59FD3037985
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2026 00:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05D6238159;
	Thu,  9 Apr 2026 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itXRQpT2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67840DFD7;
	Thu,  9 Apr 2026 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775695528; cv=none; b=oPgnhxqBd5n8CGvZ7OEgvd2S/wyE6pcN9uXd0z51fm5czUbc+2s82qTl89P/y1BgkT+wFQ46ZYiMIe+OLuNfGQfdOOdMmPj4Y8eXBOKUjNqQnLWJcrNG9kdxcqTY+SI7i6yLZT0hV+uzeYxNfELa5PeQobsbi78WujW8/MpuKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775695528; c=relaxed/simple;
	bh=GjjLDPjnFGSnPCHOn1ibnK1BzP77ajzwwixqSGOk2HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOLzNRZbtqfiBp4IgH8+RHeq9kmMSMOKPYydxC4keoewdNCXyK0zXNzUZQ4QilIlh7PNGUU77A7ZZm3VSbYeCbvL5S5MIj2mrex77/7cEmSi1QF4X+Vi5KFgfsRXaLkVdemqL8TVpk3+AjxSDVlIw0/S2M0EYay/00iaFu30eW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itXRQpT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C447C19424;
	Thu,  9 Apr 2026 00:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775695528;
	bh=GjjLDPjnFGSnPCHOn1ibnK1BzP77ajzwwixqSGOk2HY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=itXRQpT298TTmoBnNxJ944o2GBew+3i2ufMN7Ajf6mnnqm6wBZDhJwJHuV/S3Hm/P
	 dKiFOnN3POTxxEI5M3f3WkmLP3/4SbcXsDcq9Dtq5Uwy+ZTU+fow87dxBGAHQKadw6
	 gdfbT5G+VDArjnW0ef32CIo/gzrwfrJ6I1EHtZnSZwig6TlfkzqxBWZLaVMIfFUOQ1
	 I6Jje2M4sOBZ3LMqBlt+uy3sdHFF6IkhQMxLwm8Rdirfj/rN0hnddJRpPAlfrY4fDu
	 BiOBzffn0sM1L7FhotRty3Ii92eQIHFH4JvIQd7u+F7GGJS5j3iWaNMwv8y+EAyIy+
	 2YdDE492eeVbA==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 09 Apr 2026 00:45:11 +0000
Subject: [PATCH 1/2] dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K3 PWM
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-03-k3-pwm-drv-v1-1-1307a06fba38@kernel.org>
References: <20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org>
In-Reply-To: <20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=dlan@kernel.org;
 h=from:subject:message-id; bh=GjjLDPjnFGSnPCHOn1ibnK1BzP77ajzwwixqSGOk2HY=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBp1vac2ggiRrXysr7NeyHf0sal5mHzkegemt3Zq
 SAEbP1WPYiJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCadb2nBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0TVg//TdIVeocbpZIR0KwWB6pCxILp6k7d4GN/2HcXvgNIk6xQS9zfXVho9
 AOXaDylRtNIhr5OnHcsleIiLTWSqsxoE7EwsetNlJ8ItbRZCk3AQDlDTmNwatD84n20RI1MfL/w
 6fUulRAWvfXVE4GIz3yOP+0dm5TevZxyrRVDXoehY1Sf7RVYdi9YkiEpAphMI10nshwhpmIdF74
 3RZGiQ0RNc25wEWR74/fDHU3XKUTx1YDku7Ok43kWvHJJMw4SdJrbjOiTisqEHq+4cY+leQHosf
 CbfzFpoT0amZYqa7joTvm0n3x9PHiUFb2Vm3qVnf/43jRzNqawJKS8M/j8ms7+nsjzsQbuQoMU9
 C+8S/23DC6O1gbBnPTAs3HOp111saIR5W7IAbB34lvo718VDAaf5nwBc64S6OoiH1ewCphFg/jz
 6/NL+qWH6/1Pc0J0nz3tv3aX5WfH4ixuphd5TTyyJS80+tfLpXjveFmdBcvgsWElgarsgn6vsCU
 4v0s/34giguywfOOJGlQrKqp2QjGy+0Dz3hRTiVzAtfVf3vtgKI6kY2bsl3KkWu11QHdwsZTkAc
 dpZnxoxcCmM7DVLo5daHIEdLofn08kjDcMf59SqG1Ut+aewmeujlyPwWRWuWhJa4YjeKPNz0Wr/
 xQNk3H9hFNcEgmvAF9+CNaoHJb2GDA=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8526-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D17B43C5184
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PWM controller in SpacemiT K3 SoC reuse the same IP as previous K1
generation, while the difference is that one additional bus clock is
added.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   | 53 ++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
index 8df327e52810..3427c8ef3945 100644
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
@@ -26,6 +28,38 @@ allOf:
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
+      properties:
+        clock-names:
+          items:
+            - const: func
+            - const: bus
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
@@ -36,7 +70,9 @@ properties:
           - marvell,pxa168-pwm
           - marvell,pxa910-pwm
       - items:
-          - const: spacemit,k1-pwm
+          - enum:
+              - spacemit,k1-pwm
+              - spacemit,k3-pwm
           - const: marvell,pxa910-pwm
 
   reg:
@@ -47,7 +83,18 @@ properties:
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


