Return-Path: <linux-pwm+bounces-9319-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6skxBsLnM2qvHwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9319-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 14:42:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B766A0214
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 14:42:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kX+5H0i7;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9319-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9319-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 036BA303749B
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBAC3F54D4;
	Thu, 18 Jun 2026 12:42:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015E3F5BED
	for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2026 12:42:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786546; cv=none; b=BK0yt3gvSYe9xDPxaDwtw9Ph7x8FBajjgTgu4kq4Orf9vFWP3PexdVKm5C2akjzRhA1LRGS9SlwVXWGYbNRtSxZusxCqFAf70qVgCyF6yrRvewpl98FriX2y2vH+ZW/5TJI37Lt6XX6MWcMxQc7bxTEZSWCeQS/5KRIhcZL1HOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786546; c=relaxed/simple;
	bh=jI2F/ByiP5loXTu6awXWLF0O1PHvQZ02TY8duJZD+mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pnIOrIrrepV47/oJObDlU8unnFbuHPTpRZBPmqfGGQeTT2H27ww9Qe9DAq2LhI0/qJyFHFTPT0Cnl+9Aiqw6zUzVPzm7bVZw4ZWnzMCYdicTxqFA24Kw2ZmIqTyeXfZQLO81wiUOMD8/Y+yi23PqC0XCeg0GK7xzMWHDeK3KXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX+5H0i7; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c68190ade4so15143295ad.0
        for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2026 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786536; x=1782391336; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uv/Wqd9A96BxNSdILnrTOWIu5oJDMD/dfSiDHSmHZbY=;
        b=kX+5H0i7zoH8xu9+xeCO1KwKnmeftOhPeLL6NKyVjCbUiXKaawpHWyV94AFz0b8zM/
         EmELR/G9FqWqYcoYdmAUYeIT9AswUllqZTG3QuiLZy4Xa8zHJH6kGaPLVukktbOsL9Xo
         iv1Frjc2Ix8GT+ypH0NQgio8Ndwogl22HYti4Z9/7cwgI50NvDm1+iV3+vzWDNZrTIJ0
         B0Kde2ivPxd7g8tiky2SdKU4rrg9jkyN8t1zRQmIdPxdsPS4h4YtFESyT2m9iDqbGtP2
         Jh4M/tpAiBagxNfjcim5BrrQ7B49l0TDqDCavoaS0HnkV9HbDVMOFxwaElmByCPRSIOa
         dH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786536; x=1782391336;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv/Wqd9A96BxNSdILnrTOWIu5oJDMD/dfSiDHSmHZbY=;
        b=ah+B6uTARcKog9MRbcnFywv+TIc2qXSfkiz3uaqdArHSnwAUL4tFvTjmouNE0XbYLH
         bLjlD7NoJaXzO3Vzu4wyizqpopA/z6qWHoyVeYcgJODGd/nwqYACesA6YTmEcH7TnoYh
         GYdd0RWfN3Dx53pN6DA0fnZ8yXpEAfe17ym/79sLjiGl5pRUbxm026kQDRqN6Wijr7yO
         y2h/TRZmIE+on4eG3OV6jpbEEI9Sp0iDUZj0wY8e9DENMrCDHXnsk0ViBrXFhl/oCre4
         w2vcbF8q03DWn9ApZdBlnkRxu9VS3M4SvqArgHAwHoiRRjDdrG0qE+rvLXmHoTer33OE
         U9HA==
X-Gm-Message-State: AOJu0YzIunS3ut+zgnhL9BBD56+RN2y8CyCE+rHIJD/EGWi7o3zzZLYO
	Kgi4Aq9qou9R2/BrlvtnotfkdjC1C4io377vbTCiZq10HPYgGC7z4V/9
X-Gm-Gg: AfdE7cmfunRY0JWY1CfCWiXQVZBrTvTkh+vLv3jf7vj4Z9GjbLN+BfW+b2chNkccSnh
	oI764dMTyYrMtEfqMVqKPMUWYaGmsVXT58opR55bpALvMxIKBXO348WtQw6dk1BuFaOnzrM+aKT
	3jce3YBkAtT1OMPR3B7IBsulAiyZbWXf0J0ms2LpS6fcOOatZ3C/pXvNZRIVxgegNjvtzEHIRSG
	lyU0VQnTdV6qW232BzCN3p5Jw7Fjrvs1dZriB9Rr03rzmhIfCUb7nMSyBlkOs4RYo0zSlpeBcCM
	4hXH6WCnGuTerIRdk7BccSvIzmApLMqQgWaBB/8yz6h2IZm5JW54JG7iskFuG8eOb4sx9B9gvh+
	AXyWeni7UEUVXcRi6Oxf/FsTw/MYKhc+efv4heDNMJEgT9t/a3UOttt1ktKkmnKAU3IIVHw9kGR
	v902ogWBIsAhfE9joBGp4oQw7wDKsC4+boM3WqeJVz9zg=
X-Received: by 2002:a17:903:2a88:b0:2c6:8d95:fd7e with SMTP id d9443c01a7336-2c6de3dffb8mr38361875ad.6.1781786536064;
        Thu, 18 Jun 2026 05:42:16 -0700 (PDT)
Received: from Black-Pearl.localdomain ([49.207.61.2])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2c432d8a039sm196299455ad.62.2026.06.18.05.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:42:15 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 18 Jun 2026 12:42:07 +0000
Subject: [PATCH v2] dt-bindings: pwm: st,pwm: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-st-pwm-v2-1-c792d5795ce2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJ7nM2oC/2WNwQ6CMBBEf4Xs2TW0KIIn/8NwqGWBNUJJW1FD+
 u+2ePQ0ecmbmRUcWSYH52wFSws7NlMEuctAD2rqCbmNDDKXZV6KAp3H+TWi6Ei1VOoYBUR5ttT
 xexu6Nj92z9udtE/tZAzsvLGf7WkRyfsbXQQKPBwrLXVVn/JaXfpR8WOvzQhNCOELUKdX2a4AA
 AA=
X-Change-ID: 20260613-st-pwm-1feade6cfea3
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pal Singh <ajitpal.singh@st.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9319-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[charanpedumuru@gmail.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ajitpal.singh@st.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:charan.pedumuru@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:charanpedumuru@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,st.com:email,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88B766A0214

Convert STMicroelectronics STiH41x PWM/Capture controller binding
to DT schema.
Changes during conversion:
- Add 'interrupts' to the required list. The text binding listed it
  as required and the driver unconditionally calls platform_get_irq().
- Drop pinctrl-0 from the required list as pinctrl properties are
  inherited and validated by the pinctrl schema.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v2:
- Add the missing interrupts to the required following the old binding.
- Modify commit message to explain the changes made.
- Link to v1: https://patch.msgid.link/20260613-st-pwm-v1-1-458c2c89709a@gmail.com
---
 Documentation/devicetree/bindings/pwm/pwm-st.txt  | 43 -----------
 Documentation/devicetree/bindings/pwm/st,pwm.yaml | 93 +++++++++++++++++++++++
 2 files changed, 93 insertions(+), 43 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/pwm/st,pwm.yaml b/Documentation/devicetree/bindings/pwm/st,pwm.yaml
new file mode 100644
index 000000000000..a045502e0e70
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/st,pwm.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/st,pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STiH41x PWM/Capture controller
+
+maintainers:
+  - Ajit Pal Singh <ajitpal.singh@st.com>
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
+    const: st,pwm
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
+  - pinctrl-names
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


