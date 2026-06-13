Return-Path: <linux-pwm+bounces-9287-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RxsIKagBLWq2YwQAu9opvQ
	(envelope-from <linux-pwm+bounces-9287-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jun 2026 09:07:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D7667DEAD
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jun 2026 09:07:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mTVX8aGZ;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9287-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9287-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36C2B31261B5
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jun 2026 07:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1CA211A09;
	Sat, 13 Jun 2026 07:05:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99D33120A
	for <linux-pwm@vger.kernel.org>; Sat, 13 Jun 2026 07:05:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334332; cv=none; b=HEXtqEPlvNbINnXT9x0T1OhesLz+6nhfWJ0mbV7FpCF277aFxHdTG6jJ1pnyMTQ99XznlndTBLphrOzsJoy2YXP36m9qkhvCM62vVuuWHI4VuYjPCSICymAUVlvBLrmj9UDOKmPhfNFstu0sWgjv4b3ubCKkXNFZwG2zg+z2fjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334332; c=relaxed/simple;
	bh=qbuq70Uh3IaPAYxL6RvkUK6WcshvrLB9yDi84mUO810=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AY+zcvuDJQsKKqifQBlxX0FtR1wBpliniLMBue8RVLTTw0LLLnH5BtkHvOe7FtNX3nEMwq4xMJ04bmm7lLLofP95o2c4fTPmv264+/0Y4ugP1lwX0xvVmBT21nibh6VtLigewaJLJZDimxgno10KYxwU9kYGvLMPi0f9EONooLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTVX8aGZ; arc=none smtp.client-ip=209.85.215.170
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85d8615b09so1006745a12.3
        for <linux-pwm@vger.kernel.org>; Sat, 13 Jun 2026 00:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781334331; x=1781939131; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=whI/KzO8NNp1wQWQVAnpD6KQOZ6KFgZhU/Hu5Fa3ioA=;
        b=mTVX8aGZh6zblX6gH6N3bHwpYrTh9Q21pj12wRlYLDjvTBpc+D3r/yuN1+hE36gaDd
         WuzBEVXJW7TVhU333V2byidMfW9UL9KJ5z6N1CpdyGZC31RLQD7YGmP/NNUy0ETyPp7U
         fG9EKIwUcsYCes7Gha6JeBfQvAiOUbaZ66tb9qgVpq/MEuxlTYgsRdD5kotRHlVN25c+
         k6gt+tVWqf1U8Zl6/XxVeZ8vHFTHwwBwK76i+COTaWTL1SnxjqlbBRYElTB1V/vha1br
         ciOeUqct9nx5+QUiPE0WZQnZKf9MAS/DXv3R4qiC5J+jCuuCa/kDigEvoJDJfYKRp/8U
         8Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334331; x=1781939131;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whI/KzO8NNp1wQWQVAnpD6KQOZ6KFgZhU/Hu5Fa3ioA=;
        b=rpFXUgwM9Q37MLOWzsTka5IDruVvJR9RdzSTpNJLwls+HjCm4pgNP5/+scxK1fiZBg
         abJQem39vgcsKq8Gr+XFlJ0ifARRdEMz0WNipg87qE1kty3bxzwz0rNSaYfg07Cm89yg
         bEJUOQx/CUmRv+eMtXSCcQlb+vvg0bRj0+kJxb9Rgk5jHp7PF/pAonYJxja8OzhWCOVq
         oU1y9jMx7s8uKuf39GdcuPU0N7FRsjQCyihJbmY+OjW+IUdJy4MVlpwGoJBUBydfVwZ2
         buekagzZFaeZLf5/s5FWu+qkblObC8hf3vt2ZeiOTteb/ldKUY974zuwOLn0/rK3ceR/
         2HuQ==
X-Gm-Message-State: AOJu0YwW+rB9TqTqIpy94QE12vIAHOzLlXO1u0dRJ+ZQynJR0JxjIzXR
	7y04x6Pk1r3hoMG2bwo3MsKKIeKrYhZC+cMRkde6CvvUNkQvhV2zG82kihNrxA==
X-Gm-Gg: Acq92OFAHwMvT/TR+nbqIYBupDilWpzbFmuDAYrSa5jq4Hwp1tsAOGzngtpwuHA7yql
	QIA3ffsYaLu0nBndgbZMBoPaiZMOH/ovfZy7qWTP/KrU8QfrX4/j6gSTFigdaHfIkx2COUcjQ72
	y0Bw1J+ztX2cmwFs54h7vo69vBZegLp/avS9mPw1tPCergt8VWul2b556kNGrpDITmAzL8jwZzu
	avdMbX6KhOJ9sh3ZrvRxba+IfNeqhAfHneO/vmdZXhZRUREw+jEBeWdks5RSzfEsPPSEBKTXhQp
	WO2wvKlAajd8/Yu8moWUep1e9fL3C9RdeFKTRpWUWF3cLwv2QLAOFum1GuJOD9UxVqdZrdWvErd
	lR43fBQheGQnGam2SCKWJC8lpgeGzoMn7Q6BNdWHA7tX88hbAf2DSQteE4aZ/BriE+cxUdarc9K
	4DFtGYDjk+cH/VQyyudDKM40pYMhrhdHSMskjfTtppsYgY
X-Received: by 2002:a05:6a20:d04f:b0:39f:3ca8:a33b with SMTP id adf61e73a8af0-3b783bfcce1mr7416051637.17.1781334330831;
        Sat, 13 Jun 2026 00:05:30 -0700 (PDT)
Received: from Black-Pearl.localdomain ([49.207.61.84])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c8665187d3fsm3611552a12.17.2026.06.13.00.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 00:05:30 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Sat, 13 Jun 2026 07:04:11 +0000
Subject: [PATCH] dt-bindings: pwm: st,pwm: convert to DT schema
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-st-pwm-v1-1-458c2c89709a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOoALWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0Nj3eIS3YLyXF3DtNTElFSzZCBlrARUXFCUmpZZATYoOhbCLy5Nykp
 NLgHpVqqtBQAWIxEkagAAAA==
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
	TAGGED_FROM(0.00)[bounces-9287-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[st.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13D7667DEAD

Convert STMicroelectronics STiH41x PWM/Capture controller binding
to DT schema.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-st.txt  | 43 -----------
 Documentation/devicetree/bindings/pwm/st,pwm.yaml | 90 +++++++++++++++++++++++
 2 files changed, 90 insertions(+), 43 deletions(-)

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
index 000000000000..2c10f54b5caf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/st,pwm.yaml
@@ -0,0 +1,90 @@
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
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@fe510000 {
+        compatible = "st,pwm";
+        reg = <0xfe510000 0x68>;
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


