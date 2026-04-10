Return-Path: <linux-pwm+bounces-8547-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJzgIBkE2WnolAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8547-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 16:07:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7041C3D8743
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 16:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C06D83024DF5
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B139D3CD8A8;
	Fri, 10 Apr 2026 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b3wQiR2K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2599F3CC9FE
	for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830026; cv=none; b=TZDtpm7nud6EdyCu5rixNxYHszQfivpDccTRPq9iAIJBAjo6XvBsANWOySZvR/neQhnI88aFikzmunsNt8hHbgToRfWHDGwn2T5KG+SEF4TyAQPJ6v8RfRpfqw7AQmlcyRF+slyI2QURm89NA9BaVcSgEISUvf7p9VDFS7Hk8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830026; c=relaxed/simple;
	bh=s8hb9g9paEXCL92IjeHXdzwCUqKzbSkiTf1BUkd/xRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBrYPwzr1ae852rUQ6JudtpvNlYqVB40gbu8H6AOf9ubuUVVZwEghZsc34IlQwlfC1b/rmMRiO4CuCpN4Rl7gouz5LnXudo+u23wA2NcoeGX6LJmZVzXFLLOirR4OoIalRObA92E5THIvhQNjgcZRvxcsOtQnLkhosoq0yboGNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b3wQiR2K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so31937345e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775830023; x=1776434823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4GNYk08qocSjMmlFQv9r58JfdZ961NOnAm9HRPCHcY=;
        b=b3wQiR2KcNM3YgYKGgNs39nI/DXdq5JQKehikBrE6OsKsryBv/H0JJtSfkfTqRdYhv
         +vj3EOGx0wtZEYkQGzQRnwuCIoWqEb8X6HZ+A0XIDoyaMn9C9hGIBhtEGOu160a5ASFP
         Dynex2IjxTxdJ7BSVPb7EHqb663WXwRY8TSu2oM5J+QMSavRV3MZFzv6cd857fwbk4e3
         IIMKotzFN/aXVpFu6ijMVJmbltUCxS6T8aV8Z9pZftLqbJi1gTIdowfC13k0HYt7J6Jl
         IUCoOEwUv5qNC8pm95z9H9C5yQHlRonlMPBRNYHxL1X7cXYQJVyTGyr3yyAKLsl3sub0
         s3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830023; x=1776434823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4GNYk08qocSjMmlFQv9r58JfdZ961NOnAm9HRPCHcY=;
        b=FiVd4JQtkJTVL8//8rUyal15BtrSc0RCgIisRllDMn1opXOvVm2Qil17OusznoWO/d
         11yWWriDU0Jnn1YGWfrDf33WNKpfxyMiJmKrlnRANqzh7X70lArtlt+CyBf2Ot8j2WyV
         J53/6Zs0Q+tK1SCB+L4h0eRHdHYn/5kLjh7Vl+6bIeS/cKRMookY3fReiMyxtNMeHMiu
         uQ5BTBr3yMClEWGLONl/kNyUpAvbFzpzlb+43pHGamUy/MLZJ2Mv5rvbjNpQxcNLOOp7
         kUckh0Z3TGMJ5XGwFoESu8Oaka5gEx8naePaqghvU1BIAFPQq3nc20uWbcTweAC8aMbr
         iNMA==
X-Forwarded-Encrypted: i=1; AJvYcCWZPg3lMWMzwFJxcASh3++mS2Rrozw7GTZDRHFfEpwJcf2KRGrCFxja18XIqNLdEb8wZg1bzqEzXaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiuvkbXbT8h7N6D/HzWrt062Q98MZPC2kO5ukJGsl9Uao18JZC
	foe6OyXg798yT0/JCFZw+GkpmO3G/O6M1WKsB/YcJk2CPyBBrTMBEPaM0f2zlKMte60=
X-Gm-Gg: AeBDieu3lidy8RtaW3c1zyXg9a/u78TOU0ykF7fu19ea7OHFKaD7OytuiN2nw5YDejE
	LyTtgSOMr3XRc7/X05AZMvMqwxv6xfSgCGjjgPM4eBehgTKU23GbjtR93HrrbfBYiHX8gtmkFRX
	0SHS+Bx8JUUQXm9jHNny1/v7dt7oCxgpl3is+ytAQXi9M1JTJxxP4ei9Mj7O2rvQDBRST4qQ8nR
	JcJSt1vvaUPhmzp//Lzt5oo9TH449cNCQStYb/vngPSmTdDrBBBiFJhG/z0dEvdVtMfTb8BURx5
	R5yM2VQmj/Gkjg3bteK3X8ViAiG3owXDxZv5qAzN3FIMDdXLITHRmH1gwVI13y2OqTitEMTh3nC
	BGrb39Mj7YjeSN2y/siKKego1VOMSKjg5u+NxR+aB5+z3K4BviKFVjn2cSNVqxGn+6vzErNia3l
	67UfFVojIn4cbGIk6wBFuSOYY+mHmh4VYkuJ8aaeHtS4MNs42ekw==
X-Received: by 2002:a05:600c:1391:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-488d67e6a48mr46582625e9.9.1775830023400;
        Fri, 10 Apr 2026 07:07:03 -0700 (PDT)
Received: from localhost (93-41-3-120.ip79.fastwebnet.it. [93.41.3.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b46ffsm27847985e9.6.2026.04.10.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:07:01 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>,
	mbrugger@suse.com
Subject: [PATCH v2 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Fri, 10 Apr 2026 16:09:57 +0200
Message-ID: <6f0fa1a817b5af5040b652320daa7268297932a9.1775829499.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775829499.git.andrea.porta@suse.com>
References: <cover.1775829499.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-8547-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7041C3D8743
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naushir Patuck <naush@raspberrypi.com>

Add the devicetree binding documentation for the PWM
controller found in the Raspberry Pi RP1 chipset.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
new file mode 100644
index 0000000000000..6f8461d0454f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/raspberrypi,rp1-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raspberry Pi RP1 PWM controller
+
+maintainers:
+  - Naushir Patuck <naush@raspberrypi.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+description: |
+  The PWM peripheral is a flexible waveform generator with a
+  variety of operational modes. It has the following features:
+   - four independent output channels
+   - 32-bit counter widths
+   - Seven output generation modes
+   - Optional per-channel output inversion
+   - Optional duty-cycle data FIFO with DMA support
+   - Optional sigma-delta noise shaping engine
+  Serves as a fan speed provider to other nodes for a PWM-connected
+  fan using shared registers (syscon).
+
+properties:
+  compatible:
+    const: raspberrypi,rp1-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@98000 {
+      compatible = "raspberrypi,rp1-pwm";
+      reg = <0x98000 0x100>;
+      clocks = <&rp1_clocks 17>;
+      #pwm-cells = <3>;
+    };
-- 
2.35.3


