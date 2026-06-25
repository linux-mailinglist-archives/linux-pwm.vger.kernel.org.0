Return-Path: <linux-pwm+bounces-9381-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pDvtJs4HPWpzwAgAu9opvQ
	(envelope-from <linux-pwm+bounces-9381-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:49:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9996C4D6A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:49:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="sGe5t3/A";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9381-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9381-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CDFD306B656
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B100A344DAE;
	Thu, 25 Jun 2026 10:46:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34304373BEC
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jun 2026 10:46:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384403; cv=none; b=hBAMfJGyKWKHU8ujnMGZrGE6JLRAVAdFKzj0GaD7JLy16ZzH85Qd4Tkn0pxB4jXHQRn0xTPoNlMroHwc+kfabIaUKUxd/vgd4TRG80jR2qukIPHcIhXjujZ+KMD98uLUfcG2QVjL4VFXhIotxZqxiEP4L3XfbeIHwSGasFFPxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384403; c=relaxed/simple;
	bh=IUW/jWuAZqZ00WBiH/PlhaaRj68O9+LDUzp8Oi0esoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pq/EjIt9YAgQKVbRuRxFvvQ4FihL8pTWyduaA2vBT3zJszuzw0nTrfjFZqaIbKtbGp7fxnQKIzBWxzxhHuXvJMyJzjEczammlTcl/K10gZ51f2FHRvfCXRrWy/eZ8q+8POMKYUgPl4qV3CcEdHPi7XGBZZRWjMGjDov9r0BXtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGe5t3/A; arc=none smtp.client-ip=74.125.82.179
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30b9e755555so4668948eec.1
        for <linux-pwm@vger.kernel.org>; Thu, 25 Jun 2026 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782384401; x=1782989201; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=00nxWzmG28kPWf/SxYgPpee9K9fo84Tt12Dcs5puz7E=;
        b=sGe5t3/Ak1LtDO2PDpWJpOXG6osQpMexKlQmZp025rLLx8YaivVlFMFH7Ze9qi6qLs
         qC8RZkoxhJJIykjLOpj9RnCLnEMGGD5oOsaeqLEXcnvhe+053wgxeUGZpgSK9M2ZuMPR
         ReUDR3uRu5eFvvFeqXFLQoD3QOcYo/O07542HuaxumcZFdyeRHoNhExJzUjCiLd+Fytk
         r1OZDpuL/efg/9+qsQrK8VVMH9563ikhGJdxT9tP4vdadJjVPFg8ZBG8HAqaVydwj3D+
         NwfVuJucUiRCnlsFGPwcbmivjSwT5rW+91wvoTSCRxnS1mmQZUMj9FEfCVXw+ZLCAq7Q
         iahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782384401; x=1782989201;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00nxWzmG28kPWf/SxYgPpee9K9fo84Tt12Dcs5puz7E=;
        b=cHa8KyVaXheG9EOh9Tm/5n51Y5sGZ0CsUOzBIO0VhLSbYzkQQiN8AIW+vuh6y2PgQB
         5i1HxEk9B1dQsxcjlrpiAzzSDETIZTQcbRkPzgnBlQeyYwZQx0qDYoxROrdl4T+XSXQ2
         NJ4uA9hg4Zb8YlhZ+YXxL+zlJP3cp2fqg8USA8WJsdH0vKDCJ5FiGH3g/UMujybH9nx5
         yoz/A62NvRq33U4TUJehBriTVUv/ssNf+l5wwrgnnb5KsDGx/mZCqoO3MGma+vRzSM5s
         lCdtWzJOUgy7w4XuiLFNDwVFuxQbPHTyw08k/LEtaXGcTQ3ddB+ZJ2KZK4JHjf2DuApg
         KmdA==
X-Gm-Message-State: AOJu0YxnUq4jdlrlfSw6XkR83xJDSf6IyUltRflQo/mrOOBi8NKdtnv1
	VOzHYC4mtW20W6kIXMyLRA2VhC8lnulmvOt1V8I3mNs9raHF76+KPlEv
X-Gm-Gg: AfdE7cmBUj+HFvq4CraNKi+X3P/ilHJDxoTx+Ygv+ob/7keA1wc8Ud/822zF1Z7wnRS
	9vuY9FfsFlZLiI8XRGLvUTBi4ZKtYoBi7+LbqZSrJs6iM6bTirZJrZMkwit8EJj4Dwz9UCCLNHG
	SCj+awVEqHIsvkoRWsMu/DAJKKavuudxPfjRFE7QCAcTfhXvisxgZDJjbNf+mw3dBX99+UbYkNE
	JyXrZK4YsZhhKJXKFGKL8dNEpukM5Jqgp64lZhU0VnjBJgTN2aYLNITOSmhk7u9hS1SGOq8D0pu
	Fakf1UfQde/NcaIU202p+AE36ePcZJ3PiD1ymf63LoYXleyUZGtKZOGpueAXmp2wQEYE5e/lgKW
	/zWhUYuvhxUvF1ci7Rlo4hkZ36kwCgeHQxeacGvn3pfjtL+jJ8nivogag5OzkHV+cWAONt4R6ip
	V0rYJurlr/jg0ylFfDSUUPj7L5JTZmXwvWrw==
X-Received: by 2002:a05:7301:1001:b0:307:140f:d511 with SMTP id 5a478bee46e88-30c84ea683dmr2346028eec.33.1782384401309;
        Thu, 25 Jun 2026 03:46:41 -0700 (PDT)
Received: from Black-Pearl.localdomain ([49.207.56.32])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-30c7c52c591sm10103022eec.7.2026.06.25.03.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:46:40 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 25 Jun 2026 10:46:34 +0000
Subject: [PATCH v3] dt-bindings: pwm: st,pwm: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-st-pwm-v3-1-ace9bff88529@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAkHPWoC/2WNzQ6CMBAGX4X0bA0t8lNPvofxUJcF1gglLVYN4
 d1tMTEknjaTzHw7M4eW0LFjMjOLnhyZIUC2Sxh0emiRUx2YyVQWaSEy7iY+PnsuGtQ1FhBOxoI
 8WmzotQ6dL192j+sNYYp1NDpyk7Hv9ZMX0fsb9YILfsgrkFCpMlX61Paa7nswPYujXm6z6pfJk
 EGpZJ2XKgeU22xZlg9NwY8d5QAAAA==
X-Change-ID: 20260613-st-pwm-1feade6cfea3
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9381-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[charanpedumuru@gmail.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lee@kernel.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:charan.pedumuru@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:charanpedumuru@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charanpedumuru@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linaro.org:email,msgid.link:url,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A9996C4D6A

Convert STMicroelectronics STiH41x PWM/Capture controller binding
to DT schema.
Changes during conversion:
- Fix compatible string from "st,pwm" to "st,sti-pwm" to match the
  actual hardware variant naming convention used across STi bindings.
- Drop pinctrl-names from the required list as pinctrl properties are
  inherited and validated by the pinctrl schema.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v3:
- Fix compatible to "st,sti-pwm".
- Drop pinctrl-names from required.
- Modify the commit message to explain the changes made.
- Change maintainer to "Lee Jones <lee.jones@linaro.org>".
- Link to v2: https://patch.msgid.link/20260618-st-pwm-v2-1-c792d5795ce2@gmail.com

Changes in v2:
- Add the missing interrupts to the required following the old binding.
- Modify the commit message to explain the changes made.
- Link to v1: https://patch.msgid.link/20260613-st-pwm-v1-1-458c2c89709a@gmail.com
---
 Documentation/devicetree/bindings/pwm/pwm-st.txt   | 43 ----------
 .../devicetree/bindings/pwm/st,sti-pwm.yaml        | 92 ++++++++++++++++++++++
 2 files changed, 92 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Documentation/devicetree/bindings/pwm/pwm-st.txt
deleted file mode 100644
index 19fce774cafa..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-st.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-STMicroelectronics PWM driver bindings
---------------------------------------
-
-Required parameters:
-- compatible :		"st,pwm"
-- #pwm-cells : 		Number of cells used to specify a PWM. First cell
-			specifies the per-chip index of the PWM to use and the
-			second cell is the period in nanoseconds - fixed to 2
-			for STiH41x.
-- reg :			Physical base address and length of the controller's
-			registers.
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		List of phandles pointing to pin configuration nodes
-			for PWM module.
-			For Pinctrl properties, please refer to [1].
-- clock-names: 		Valid entries are "pwm" and/or "capture".
-- clocks: 		phandle of the clock used by the PWM module.
-			For Clk properties, please refer to [2].
-- interrupts:		IRQ for the Capture device
-
-Optional properties:
-- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.
-- st,capture-num-chan:	Number of available Capture channels.  Default is 0.
-
-[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Example:
-
-pwm1: pwm@fe510000 {
-	compatible = "st,pwm";
-	reg = <0xfe510000 0x68>;
-	#pwm-cells = <2>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm1_chan0_default
-		     &pinctrl_pwm1_chan1_default
-		     &pinctrl_pwm1_chan2_default
-		     &pinctrl_pwm1_chan3_default>;
-	clocks = <&clk_sysin>;
-	clock-names = "pwm";
-	st,pwm-num-chan = <4>;
-	st,capture-num-chan = <2>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml b/Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml
new file mode 100644
index 000000000000..c69073e79ce9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/st,sti-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STiH41x PWM/Capture controller
+
+maintainers:
+  - Lee Jones <lee.jones@linaro.org>
+
+description:
+  The STiH41x PWM controller supports both PWM output and input capture
+  functionality. It provides multiple PWM output channels for generating
+  variable duty-cycle waveforms, and multiple input capture channels for
+  measuring external signal periods and pulse widths. PWM output channels
+  and input capture channels are configured independently via
+  st,pwm-num-chan and st,capture-num-chan respectively.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: st,sti-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+  pinctrl-names:
+    const: default
+
+  clock-names:
+    items:
+      enum: [pwm, capture]
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    description: IRQ line for the capture device.
+    maxItems: 1
+
+  st,pwm-num-chan:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of available PWM output channels.
+    minimum: 0
+    maximum: 4
+    default: 0
+
+  st,capture-num-chan:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of available input capture channels.
+    minimum: 0
+    maximum: 4
+    default: 0
+
+required:
+  - reg
+  - compatible
+  - "#pwm-cells"
+  - clock-names
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pwm@fe510000 {
+        compatible = "st,pwm";
+        reg = <0xfe510000 0x68>;
+        interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+        #pwm-cells = <2>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pwm1_chan0_default
+                     &pinctrl_pwm1_chan1_default
+                     &pinctrl_pwm1_chan2_default
+                     &pinctrl_pwm1_chan3_default>;
+        clocks = <&clk_sysin>;
+        clock-names = "pwm";
+        st,pwm-num-chan = <4>;
+        st,capture-num-chan = <2>;
+    };
+...

---
base-commit: c425609d6ac4012c8bbf01ec2e10e801b1923a7b
change-id: 20260613-st-pwm-1feade6cfea3

Best regards,
--  
Charan Pedumuru <charan.pedumuru@gmail.com>


