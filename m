Return-Path: <linux-pwm+bounces-9493-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FaZRILxiRGrstwoAu9opvQ
	(envelope-from <linux-pwm+bounces-9493-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 02:43:40 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC816E8F38
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 02:43:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9493-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9493-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 988D7300E6B1
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 00:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465BD21D3E4;
	Wed,  1 Jul 2026 00:43:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB2A2135AD;
	Wed,  1 Jul 2026 00:43:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782866614; cv=none; b=hReD2przxwJzW9yx9wW1SnHPMRkuf9vAxSkkFzBSoiSKHWXyDbSkezFLB4H+Ypheo5C6ta3YD8EwcK8xOSJNpNJExxbqNP2CM/7ln0dycxVK4xTiy79Fa8qAmMEZRQiseVMluOuDzLGQmpekxJEkMprrQg/GAD+9BIY4agTdz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782866614; c=relaxed/simple;
	bh=t88GYOY24ARGjqP6IWi9qdjMwXi/z7BII14XmAVmIFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsdgVMFz5/jmYCdRvfY5Fbfg3+ioCFU1XmyIuB231H1xCqx/vfWdU3pQcznic4zPHaxhaOsm5rllGq5oNVmJvyWXU6L2RF5N/ll0yKoxYkhHk4V9pDmzIYk2EL8saYHaKgjJhko9sLHqHFQY2/glBDO7fMLKIxMx7jvb5tiGDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.78.106
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgBHXJ+pYkRqyFgwAA--.7235S2;
	Wed, 01 Jul 2026 08:43:23 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ben-linux@fluff.org,
	ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 2/3] dt-bindings: pwm: dwc: Add eswin compatible
Date: Wed,  1 Jul 2026 08:43:19 +0800
Message-Id: <20260701004319.460-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20260701004139.347-1-dongxuyang@eswincomputing.com>
References: <20260701004139.347-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBHXJ+pYkRqyFgwAA--.7235S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww43uw4fXrW5XF1xJr1kKrg_yoW8uw4kpF
	4furyvqw1fXr17Xws5XF10k3W3Xa4kJFW3Kr1xtFWUCa90qF4jqFW3Kr15AFWUZr4I9rW3
	Wa93ur15A3Wj9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNSdgDUUUU
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ben-linux@fluff.org,m:ben.dooks@codethink.co.uk,m:p.zabel@pengutronix.de,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:xuxiang@eswincomputing.com,m:wangguosheng@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:dongxuyang@eswincomputing.com,m:conor.dooley@microchip.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9493-lists,linux-pwm=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,microchip.com:email,eswincomputing.com:email,eswincomputing.com:mid,eswincomputing.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DC816E8F38

From: Xuyang Dong <dongxuyang@eswincomputing.com>

EIC7700 integrates the DesignWare PWM IP described by the generic
snps,dw-apb-timers-pwm2 binding. On this SoC, the presetn and
timer_N_resetn inputs are physically tied together to a single reset
line, so exactly one reset is both required and sufficient, unlike
the generic binding where up to two independent lines are optional.

Add the eswin,eic7700-pwm compatible string and constrain its resets
property to exactly one entry.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
index 213fdaef25d9..9a9a24ddc61b 100644
--- a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
+++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
@@ -20,12 +20,11 @@ description:
   instead of having to encode the IP version number in the device tree
   compatible.
 
-allOf:
-  - $ref: pwm.yaml#
-
 properties:
   compatible:
-    const: snps,dw-apb-timers-pwm2
+    enum:
+      - snps,dw-apb-timers-pwm2
+      - eswin,eic7700-pwm
 
   reg:
     maxItems: 1
@@ -44,6 +43,7 @@ properties:
       - const: timer
 
   resets:
+    minItems: 1
     items:
       - description: Interface bus (presetn) reset
       - description: PWM timer logic (timer_N_resetn) reset
@@ -59,6 +59,21 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: eswin,eic7700-pwm
+    then:
+      properties:
+        resets:
+          maxItems: 1
+      required:
+        - resets
+
 additionalProperties: false
 
 examples:
@@ -70,3 +85,12 @@ examples:
       clocks = <&bus>, <&timer>;
       clock-names = "bus", "timer";
     };
+  - |
+    pwm@50818000 {
+      compatible = "eswin,eic7700-pwm";
+      reg = <0x50818000 0x4000>;
+      #pwm-cells = <3>;
+      clocks = <&bus>, <&timer>;
+      clock-names = "bus", "timer";
+      resets = <&reset>;
+    };
-- 
2.34.1


