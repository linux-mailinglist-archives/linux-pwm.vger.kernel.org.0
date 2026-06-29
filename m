Return-Path: <linux-pwm+bounces-9475-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CWY8EC5zQmoH7gkAu9opvQ
	(envelope-from <linux-pwm+bounces-9475-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:29:18 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C88826DB368
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 15:29:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G570oWgW;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9475-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9475-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A999330CE3E1
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AB11A0BF3;
	Mon, 29 Jun 2026 13:13:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F9380FDD
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2026 13:13:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738825; cv=none; b=SHZtD3tLAljp58nLuFd+mqNxRaQRcZI654wQqqDfn4KsH+WGRFuC/jryKVqQPP5Mb80qWRmnFGqO6XIjLLtmONkwRPsXD2xO69hFbHsAYC5CNeeb00bVGiL/ZYqrb7bciQQ6DIV0u278cDSO9a5ipVaLRhYn+caLAEVZPmZ2F7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738825; c=relaxed/simple;
	bh=uqWUiWxqoK1z4suv25KsMeSJmhIYeFSFGYemREkDadc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ik7e/KFTFoWiQFzcYfPc8CPQbQD3VdOHyNVQI7a9mp87jcQBsYSphce9gfMKygiowx1BQAAHE8Yhqllv+i0nRl99N00Bm5+6jomiqnhNQvrY5mIaCOl89G/I7bYqqrtQO0wLuJTwwhbw7GTltQUtNc4wcQaBzMph5r6PUhPy5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G570oWgW; arc=none smtp.client-ip=74.125.82.181
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so6575142eec.0
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2026 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782738824; x=1783343624; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag7rMygxbcOcB4P3e3XBrLKcZ4BXMFcVbEIShzaDpgU=;
        b=G570oWgWLMNssA1eAouLvtU6M2Os3Sl/nBh/j670e9zc7X1djenc8sOoYh5ZrL/Pqm
         MWRrp4dzw5W63JfkhR0bPYxPVHP6Y+7wZJrj5qKrIi3+dxbRV1X8MQXMJtBBLCBjawrw
         aD1Wp9O4wfJubmab50DpVBXL5J/8VZM3aXpv4CLlx+VX66zrUL1n4I9rS0cbd1LmOAPa
         wOz8IivHV2vkSyYdCxlSvCzQIersA9y+8HKa+qR8zip4QmQ21rhTh/Fnj4wq8D6oLS4S
         sgKCRNymuOvG7JgPffQ/+2Q5QMLsKAi1U1BAmJcGyJ9kgN7BC+NqYNnDDddDzP7ZCoaS
         5row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738824; x=1783343624;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ag7rMygxbcOcB4P3e3XBrLKcZ4BXMFcVbEIShzaDpgU=;
        b=EGfozG+9XiGKdLhkq1bTAzFBcBiKVMuEDC3gnvg7qsO6B2m9mg4otsrpDhVgrPV1Aq
         TZpVqH+f/ncJ/ETrZQVUFgxm6e37fidaKy4VKeGxEk8UKe9yfPjrlAh2YfpdvWm0UWcy
         66b6uTC0XXhHsugGQyahI26obDnAvosqTRn0domqbr254qsJ7BMy4+ajdpO7lKbp39dg
         +stBMIZcgjhahYeVa+QY1p5Njak86FFXF+2aYHRfKbHgSw2ORnTkFJLe7UFoJFyk50E4
         bdigkdpLuD4tb1GLjz+AaQOmSBSUSRepE/QPwE/ZzMM/4T6yTop3SlXZIEmIeJj0NGpV
         0KNA==
X-Gm-Message-State: AOJu0YyKE8EzfOizcyo+HusnuIZWLKxkcO5ARMQPBWwcagqlrsZ4+2FF
	8uiboca9uS0PlGbEMqRsmPvgHYN5Gfbqz3uJiIXCtJ6TD7SQXiM0FO9TDR3uJg==
X-Gm-Gg: AfdE7cmYGEgfEGVYWMyXPJvIFhaxDqh6RNRipb44M39BetOP6/jrFVOdCi6w5rllbG6
	gnhofR1IJxNi4yszyDW83GXpH9e7C+u7QAiionsmoDaaZUGGGIkkoj4f2qi6xdH0pw8+I8XG3Pb
	njK1FIFm3SOwTj7aKXNKo/RkhycCCxyNpzGYWXSO1EvGV2Ww3KkxjXvO0pOSyYotV1pCFxIBrL6
	qPpoUDBtjJnNuoXI9u3alefU69GpDmafiLuu8Uv/HwB0ZyC22V69xIW2myuIWHaN94pApsnkLMO
	K/E1PHKruzrapgl8bSOQ9a+/o8vYFmTaQv/BPCaO77IhPFphB3INqHczO6rOkzQQD1G9nXLWClf
	7RDxl/gC8UAB8vb5ohH6XOqr7gIyK/W4C74l2Xpx/xmTGUBczNPlCQslm7YnHJgmfbsDjlYyoY5
	EWIPqgWTs3QHo2qL3EG00Q97aN5HRV9ffpig8=
X-Received: by 2002:a05:7300:8bab:b0:30c:56a0:ce3f with SMTP id 5a478bee46e88-30caae2f116mr11362069eec.2.1782738823488;
        Mon, 29 Jun 2026 06:13:43 -0700 (PDT)
Received: from Black-Pearl.localdomain ([49.207.62.174])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-30c7c52eed6sm43883676eec.9.2026.06.29.06.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 06:13:42 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Mon, 29 Jun 2026 12:58:37 +0000
Subject: [PATCH v5] dt-bindings: pwm: st,sti-pwm: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-st-pwm-v5-1-a93f2bfec38c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP1rQmoC/23NTQ6CMBAF4KuYrq2hUwqtK+9hXJTpVGsEDEXUG
 O5u0cT4t5q85H1vbixSFyiy5ezGOhpCDG2TgprPGO5ssyUeXMoMMiiyQkgee34811x4so4KTEe
 yVD525MPlMbTePHM8VXvCftJTYxdi33bXx6dBTL2f0UFwwXOlEVCbMjN2ta1tOCywrdk0OsA70
 y8GiWFpwKnSKCT4ZvKNgXoxmZhFMpX3Wisw3yz/z/LEjNKudEXlvPxg4zjeAbM5W1NTAQAA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9475-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,devicetree.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linaro.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C88826DB368

Convert STMicroelectronics STiH41x PWM/Capture controller binding
to DT schema.
Changes during conversion:
- Fix compatible string from "st,pwm" to "st,sti-pwm" to match the
  actual hardware variant naming convention used across STi bindings.
- Drop pinctrl-names from the required list as pinctrl properties are
  inherited and validated by the pinctrl schema.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v5:
- Enforce stricter validation of the clock-names property.
- Link to v4: https://patch.msgid.link/20260625-st-pwm-v4-1-958d7d6bdf39@gmail.com

Changes in v4:
- Fix compatible to "st,sti-pwm" in examples.
- Modify subject line to point to the correct YAML file.
- Link to v3: https://patch.msgid.link/20260625-st-pwm-v3-1-ace9bff88529@gmail.com

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
index 000000000000..39f96596c1ef
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
+    minItems: 1
+    items:
+      - const: pwm
+      - const: capture
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
+        compatible = "st,sti-pwm";
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


