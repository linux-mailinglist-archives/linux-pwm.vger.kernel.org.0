Return-Path: <linux-pwm+bounces-8470-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BvEDejPz2m50gYAu9opvQ
	(envelope-from <linux-pwm+bounces-8470-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 16:34:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9639547F
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 16:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96EDD30214D0
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2026 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970923C5540;
	Fri,  3 Apr 2026 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CCTNqxQ/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99DE279DC2
	for <linux-pwm@vger.kernel.org>; Fri,  3 Apr 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226541; cv=none; b=AJrrQ1KVVhX2v5ya0vhc60yl2ExigyqIZwNXb3tpB3FOA7BgYFW+U8GOKp1InSbr1rVWqD80prpEwmN9i9xyt1eb3latRLDa0TOLJhAsouTH7VD3v+Vhb+jGVMG/9hHwuJpmu4TpWBobZ+sJuqcOIhE1vNTJV0qxCwbsRjqw1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226541; c=relaxed/simple;
	bh=Fy3LxmfFwAHBA49eU81J4yKn6v7ciijjsYceXxhe0CM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoZhOFQwIsBo5ogQwThvdAAo6TOhUTRj61v9NFidItCqL+LG04Ik6hS5acngJjt/CTEOQS4w7c288Eot8QL+DfXVVzChDyBTwPZepp6R+CczCUzm5+BoVN+2gWNJWM6E9cWXxDZGuDtoqJpM89S6Co8/XKo26BGlyBJXMhkeKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CCTNqxQ/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488879b2e6aso17452215e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 03 Apr 2026 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775226538; x=1775831338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItvUs7qnYuRhfo9MnKht/hLCIFj2PmkiwnfJhnbvcpk=;
        b=CCTNqxQ/fr3EYM0bKODDyqTSY8sQFVn08w/3qeF6AGSlkAbuxcqookqTBPPKLxrJ8o
         X0FdqTgEODM9bwzsphVQ824wULv+dDMWZmAILBZoE8MYuCJT/H/fSkK1T7rbDgplhEav
         uWA/anW4RTE8T4n4mWl6ZvLP2RfIIiPREVhuObPERIhNyeSNaqJ+hsEfUzSaZWTlw1PO
         Lc/xUIjmLqB0CW8esNqZKo03f+jqMdmUdHSP/R3Ob//P15eRovp37WV8z0nUucvEXVcr
         q6IHKL5lrbrk/P6QC3z554Uh5ZY1nzKxLha8i91NXr2Xy1eRpXjTNRnvV4werd+udkMV
         1JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775226538; x=1775831338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ItvUs7qnYuRhfo9MnKht/hLCIFj2PmkiwnfJhnbvcpk=;
        b=bfdO5eWudTF3a0piCnCrlqctogg1pp35O9zIelaAD00p/7/wkKOWnuTSyG3//QBS3T
         MOvHuaFTifHzDmQKC/iWcmStzv9lG6Wuw5b1QEbNCM4kMcrGlZz9G8qC+gW0IsnqOdZe
         FxjOYatXkOV8Pt6a+GWpfY8hRdIVBVcxhLHH1eRz2XXnr0js5EuvO5F4kMGp/lmGaQet
         ZoXYwoIrwaWM4hBNRMDHOmqKaWyYBUh4y6B33mkUErrxuZadJa7YO8mOGwjSb69Noms0
         sCoTikcwzCAXkOI+ofo3W670fERHxKTtaVzvhdlz5qT7YA0mbl39pOWIhD+bAQRE592g
         e3+w==
X-Forwarded-Encrypted: i=1; AJvYcCWvlBDaFhKCf+nIQ3Pi5WZalPvO6H+bJq+AkKTKsMvWADcpOXCSGNInCa0/djJ4KIgU9zE1GTyv9LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbewF1p6yyWdlE83ng6Ho9hWQ8KvbYpWnyZN0OqWETKLStW0YX
	YL7v+aUHRzPDyx5HKJT8gkmwoYMJITU3zXffKdGJ5/+dV2XYwOrAA3X0hmNYGsXnC2k=
X-Gm-Gg: ATEYQzxkIN472hDqnhU0O8J8QJj+4fOmOGwTzfVL2VwBGRl7zu704bE62numuVVgKDm
	vdDfYwNGnUWI1TQb+RcKob8QT5itRrcNolJPcXEDIpyDdBDKBIfwCzBeU5ALY3yG+odvJX/Tn8E
	6wwy8yvX+KQfTToDGjF0f/q51KPIMZeENL0p9kC4BNF5hIxhacLrhAvROPmowIbx3/0ldxW3jSe
	RArcDXhL53KsBYwUyGHPFrUUPh9Pb3D7SwBg8ozfH7c/n/yLLzNKPmeH6PSeGm7LoRA3mWKsI0J
	1QIBrSafO4W/umWO1ikjWn37Ov54pgXvQ5Fr/GCdR8wWQFzbA1wDvSYBOeeFczFS360w/Y57Jlb
	v9AGwBg7SVCVTLjEU4liPP0kfjT8TgaW+msfkdc4GTEMx7/eXx8hugGGm+4mfJ9o2a1Yj/rayVd
	b8AOxSORQUm/3RNcERIdKN7qWZOPkG8DJ/N7ZZAFxAjYTjo7dYMhY0amgyP4DlyNqPEwB5
X-Received: by 2002:a05:600c:45cb:b0:486:ffa3:584 with SMTP id 5b1f17b1804b1-488997853damr44739285e9.15.1775226538384;
        Fri, 03 Apr 2026 07:28:58 -0700 (PDT)
Received: from localhost (host-79-33-140-232.retail.telecomitalia.it. [79.33.140.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889cb46adcsm44349515e9.4.2026.04.03.07.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:28:58 -0700 (PDT)
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
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Fri,  3 Apr 2026 16:31:54 +0200
Message-ID: <11b5eee3c22cfd034bb4b425d28a5a3ff2a71828.1775223441.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775223441.git.andrea.porta@suse.com>
References: <cover.1775223441.git.andrea.porta@suse.com>
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
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8470-lists,linux-pwm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.1.126.208:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,raspberrypi.com:email,devicetree.org:url,suse.de:email]
X-Rspamd-Queue-Id: 8AA9639547F
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
 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
new file mode 100644
index 0000000000000..d6b3f52561636
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
@@ -0,0 +1,52 @@
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
+additionalProperties: false
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


