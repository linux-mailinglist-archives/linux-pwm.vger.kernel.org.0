Return-Path: <linux-pwm+bounces-9383-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4hweNeoPPWoUwggAu9opvQ
	(envelope-from <linux-pwm+bounces-9383-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 13:24:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99D6C5138
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 13:24:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ppza4FFM;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9383-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9383-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E834D301A91F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC73D9024;
	Thu, 25 Jun 2026 11:24:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314D3D7D80
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jun 2026 11:24:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386664; cv=none; b=bnRupnps4IIpwt+pjCWMEtqQMcOXK8E0SERUt+qmD52Rtpohwyec2SncyBOR0Lh5ji5QiGl1d8bDuXNSF18BHBI0wQ/MJhB790TalfWPFOR9kRCW5Gd5FUgb1sRIN6EJpv41n4rdTngEWo1JMfVabw1ybr81LEVfeu6ujjEmTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386664; c=relaxed/simple;
	bh=z6Gw1SPw/lmw93dnDilsrhDw8RqP2rNo7ttvYQy1Rlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hqcgq7QNzbgx5RS4Un6XrrcNAT80NeKe6a2GM7+Epp2ifsdmaDZKWJof1fVLh205A+n15iCN7TV9BZRnBcSkrbT8L18jTEJrTMOOQ2Jk7R8clVaWSC4VIjq28VueFTTg+sU0Xc2X7m31UKDDMwU77/mP1M3EZ3ndZ29dePrRlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ppza4FFM; arc=none smtp.client-ip=74.125.82.175
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3078e0dcd67so3094404eec.0
        for <linux-pwm@vger.kernel.org>; Thu, 25 Jun 2026 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386662; x=1782991462; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SU+MC387FWgefKqGRXg3QcxpIQf2/exgLisxfx7HExg=;
        b=Ppza4FFMEJlyPOD8/R28Bv5PS1NuUcfhAzDGv+Xqn3IMqDGWC8UQWUJoqVOR+Uu35V
         2hPGl7qb4I3elgGxJD6H73MSZ1t/afVPxtPKhHJnjmNvTPJCqYG6dXK01fcXIUfhcjZH
         cAcbY/OLWBL3JOiFDh0H4ZdHVrXtI2XHHOXehVG+0pCdz+R8sg3ExR0+ktksiDT5x4tv
         ZlCs6Mme2ASBIq+FWdRTFEmiomrDpRfDqDrYffntHyRpAJDNIRS3ZXj7m6C/LgtwoZsk
         XYGUjMIxOjQo6jnaXotPGwDgaf+a2vujUcZnPIJjw3uUCd+COCZUmkdRimI0cYf74Q71
         /8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386662; x=1782991462;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU+MC387FWgefKqGRXg3QcxpIQf2/exgLisxfx7HExg=;
        b=In/pt+HLnmsnfhlVR0afGQYnL+e7pAxbvOMH/oIRkQ8X8+yPAAhMgs8MfV3jx+Xly9
         HmmDdFH4EIHYkIasQqP83IxV+8JZggKzBIKOfL5Jx37wfb5UNiSGXxwb9E0uM65oLfMD
         ImG5ZAYOvJJPG2QiIDzTksHff0sWV7S7l9cnsQWMMzEeQ4o7iRtWNm0AawBO08FjPb9e
         sLmcNiMHxsmLl6V4XC+8FsP63E0WUvuan0x+hFgVNs3plK62tJBZVkzpNso3P7p9BQzu
         NC0OX8m30w53RZOpu3X7gIIput/8pMyyz/GyIrKE9FIDlvKtVrHEXHAn/zAXEDkOPSZ5
         uEXw==
X-Gm-Message-State: AOJu0YzUimBwHgIHfN3C0nYAoupi8/dGaUsaaX/yJBz3MMY+urOjatP5
	hoo3JKH3oasjqupSi3Wzz+o9+8bBHzAPBuECQbobwGVbNZu18yajilp+
X-Gm-Gg: AfdE7ckdHKylaT3t4bW0pgeZKu2kK9Jz7yI77tXgEdUV7ApySeu3GTR1jWrbOQPm1p3
	2LStwU/kq64VyOqu4V0EnUvgqaWwmsn71B5aX8QibQyu3WjbYq3zhvaVeUa7Q61ZpfC5xueeAaK
	kdPThySPD10JmL/TzMfRBzMkJFtwUaSRiD/XqCwlvoW+6zZmU/r9j0Po6ElxsBfkBTYgRIZeGNN
	78ghZVRUMrDOV7BA6xXpUmI301gqQ6WhEKYUNm+r3W3xmbDcQRWgkidF3pJq+4X1uhOzJC1Asxq
	hl67e04IraK9q1uQ4MT0xZmCrmLLjfkzkXVOUB0Lyv52hDeXCb9SZYw4kismTQpLkT8BcpE2HbP
	+PcUdqsbfxYnqD9XqxelWz75eUVVNgQ9rK6kkasOK5rLMcYXPlfn5E9mw9mXtd2EvXpBC+X2wAB
	gi/swLZohvZag01Rp5JcZGh9wBlD2xJSPrEg==
X-Received: by 2002:a05:7301:e2a:b0:30c:72ab:89df with SMTP id 5a478bee46e88-30c84dc2b24mr2058486eec.29.1782386662131;
        Thu, 25 Jun 2026 04:24:22 -0700 (PDT)
Received: from Black-Pearl.localdomain ([49.207.56.32])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm8357352eec.20.2026.06.25.04.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:24:21 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 25 Jun 2026 11:24:15 +0000
Subject: [PATCH v4] dt-bindings: pwm: st,sti-pwm: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-st-pwm-v4-1-958d7d6bdf39@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN4PPWoC/2XNTQ6CMBAF4KuQrq2hA4XWlfcwLsowQI38hCJqC
 He3YEKIriYved+biTnqLTl2CibW02idbRsf4kPAsDJNSdzmPjMIIQkTEXE38O5Zc1GQySlBfyL
 my11PhX2tQ5frN7tHdiMcFr00KuuGtn+vn0ax9P5GR8EFj6VCQKXTUJtzWRt7P2Jbs2V0hD1TG
 wPPMNWQy1RLJPhl0Y6B3FjkmUHSWVEoJUHv2TzPHyxRJtwcAQAA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9383-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C99D6C5138

Convert STMicroelectronics STiH41x PWM/Capture controller binding
to DT schema.
Changes during conversion:
- Fix compatible string from "st,pwm" to "st,sti-pwm" to match the
  actual hardware variant naming convention used across STi bindings.
- Drop pinctrl-names from the required list as pinctrl properties are
  inherited and validated by the pinctrl schema.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
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
index 000000000000..e980c76b54e7
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


