Return-Path: <linux-pwm+bounces-8684-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNLTDv8962nFKAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8684-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 11:55:11 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8745545C909
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 11:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8065530120E7
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 09:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45533F598;
	Fri, 24 Apr 2026 09:55:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401662D8376;
	Fri, 24 Apr 2026 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024507; cv=none; b=hLICSPhXz9xET9jzOxmWowYg2f5BrkpasG+Qx+dnh3RZxGG+6nqhWBMGd/2sggD4twaNByTbDw+aldLM7w+2aE9JlB3kQKhASp9+1JQwTf3pxdlzW/QI/BX3gC3+nqW5G+xHkcEO1DiSJTVcSF8gR86/1RkBL09oDjXzVHH6f0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024507; c=relaxed/simple;
	bh=QFSYqEgLy8Wzqmp/O9r2ZWk/Xpkk1QVJ7sUvqye0Oxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y5e5pN3sWsXTOOFTjBRxOwF9ZBDw+sW8S2NVvkU7j93p5yX6LFxBvyEI/FDOjg1wyn9XGtHDVGGKpOIIZo5GBcpq2E50qsbgtL7v0Fn71qe2Us3pvxFeAEbYpV6WBxgTIjD2aB7ilcznrh1nhDmkXnNGVYAm9ygJSylg6VWW5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgC3THHdPetpAVgUAA--.11883S2;
	Fri, 24 Apr 2026 17:54:39 +0800 (CST)
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
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v6 1/2] dt-bindings: pwm: dwc: add optional reset
Date: Fri, 24 Apr 2026 17:54:35 +0800
Message-Id: <20260424095435.1721-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20260424094529.1691-1-dongxuyang@eswincomputing.com>
References: <20260424094529.1691-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgC3THHdPetpAVgUAA--.11883S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4fAFyUtF4DGFW3try3twb_yoW8Cr4UpF
	43Zr92qr1fJr13Ww4rXF18C3WaqF1kJr47Gr40qw42ka9rta1jqayakw15JFW5ArZ2qrW3
	Wa93ur15Aw1jvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfGYJUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/
X-Rspamd-Queue-Id: 8745545C909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8684-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[eswincomputing.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,eswincomputing.com:mid,eswincomputing.com:email]

From: Xuyang Dong <dongxuyang@eswincomputing.com>

The DesignWare PWM includes separate reset signals dedicated to each clock
domain:
The presetn signal resets logic in pclk domain.
The timer_N_resetn signal resets logic in the timer_N_clk domain.
The resets are active-low.

EIC7700 use DesignWare IP for PWM controllers. Add ESWIN EIC7700 support
 in snps,dw-apb-timers-pwm2.yaml

Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
index 7523a89a1773..96a70e55a167 100644
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
@@ -43,6 +42,12 @@ properties:
       - const: bus
       - const: timer
 
+  resets:
+    minItems: 1
+    items:
+      - description: Interface bus reset
+      - description: PWM timer logic reset
+
   snps,pwm-number:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The number of PWM channels configured for this instance
@@ -54,6 +59,18 @@ required:
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
+      required:
+        - resets
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


