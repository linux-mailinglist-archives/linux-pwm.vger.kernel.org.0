Return-Path: <linux-pwm+bounces-9238-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id frXGKGBLIGrm0QAAu9opvQ
	(envelope-from <linux-pwm+bounces-9238-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 17:42:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EEB639541
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 17:42:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=MvvhbIj3;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9238-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9238-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9A9E33F5B59
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA3A3DF002;
	Wed,  3 Jun 2026 15:24:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB93DB32D
	for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2026 15:24:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500284; cv=none; b=UHUM5zE5BTPJT1MqVYgayMEvxEwxhhd34nLcgQEYsNogJaLn7Qmefy469G55O0gnaeip0oxLpaH7RepLG7K84pHHjd8kr8SltlZXo+vc9OkZL9ZoSm15YjVZpe2e02Z8MpmEP6j5C9H8kfJcSx4oxRc1zLQA/ICSF546F1Bh3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500284; c=relaxed/simple;
	bh=/n5mWPN8vWhXXjUOkrU+2eDOzhbedPgQCrOxoHmhzaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4yde40AaFQ5a0yUR6nArADM8Bxn5Ob0pKAbJQf4boOTVNU3NWIn4pAF7iJuIHUfHD36uc1wV5NkIwfMx/GoBGWhahlLwu00102wqLExtpCp6x7lNTKnkSB3+z/rj/r0WClMmPvAtXgrSTPP3p/eTjTVzUUTkJFgshjzv48/0xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MvvhbIj3; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b64c8311so12964945e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 03 Jun 2026 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780500281; x=1781105081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlJLsFGfJfKvxb8nj21NQln9bu8CETkKM8eqefnewUk=;
        b=MvvhbIj3i0bPLoaabUvrSLGmxmKC5FlSWReEL5dCuov1q+2EKX4z2BlZ86sg439TO1
         pfI/IEHh+20F2aq0fTOlLEw058QVuYqlWFy0je2grDGBbvl7je3XuDIFWtNIF2vhKqso
         p4O6bfE7KbeNG2Y9blGfaryEBSAM/yVtsuz+g56gXuXVC6ZqjKQGqttRSrmN0/igCtrE
         U+Xh2gChNJOADBrsPCkIeGlD1pUjSmw0Wwuxy6gcHRROUa4XHWMRKSxAHMfe+oJ6KMK2
         TEMD/ciGDTNaaYz+1B2yuDet14ISbfeggL8PIOSir3Tgji3Rv0qPgqg8C5fxSVFis+74
         Yxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500281; x=1781105081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KlJLsFGfJfKvxb8nj21NQln9bu8CETkKM8eqefnewUk=;
        b=Hze8pI0+AdivoBudya4HcE5SQYIupEyJXoncSN5dWwal6gf+Z3O92NNvZxIY8VK3sk
         boJsLvs1e2BQQuZRR1vpRcLkfvjkuExF1qkxwBlMbksSip+Wx+vK6p9VD8+tbWjeXIwe
         I9WJj7W8lzgAk0K1IUwv8uUSIk2WzCuD5RunWjvJ1QNPAZbXTNoy7nXOBL/4tNWq3a5o
         RCgCHKTMfzyCaTRf9FFrrPVqjLd+DXvXnhIes38zsMmeXCxISpTl6Bk0N0PoCLZnli1e
         7MgjSTIZFeJqYFB0jNSbls72zJduzoZ4DMfX8ww5V3LsX5ucRMUuKngCm7cyOYnT5l9l
         SzAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Y2LZFlKfAIACxdUzCzJ1mN584b0llNLRS/K++n7qpF2qaH4GM7L0V8gVLKANX5pGiNWBMlEmni+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyphkYLmtoRzFLLS+oI2G/xA6lEVHTyS6OE8PuBCUG6QTkk43l9
	wjIDUzrFd1/BTKl3c77dnIOdkefie3+kc3Q885Ne/YEzjBxgi/GduRfrqW0k2Yw97c8=
X-Gm-Gg: Acq92OHeH6NqsNE/fgENU4AjMsZclLoarEZDjA3CleeFO0J1wPvq2aF5uuS66FAitYT
	lTlGfi+zbfynp3DEmRzk/6ZNXZ+gCNLOVj8kzLK8YtRWdFwnALB+uMRVBcdURubhtj6DydsT0NC
	puWMaQdcEEO8WybM7AF7Oaxchh+1h3JUenpgE2D39pFmnK1LPDfzvEyNe1h0uriDWmFKm3kYsoi
	Tq06VMhJoK6Pu5cgXXMyKm9wsJ2o1qtgSdfV0PYdF3r5Z4FQEr4Qk53wgOOLi5f4gUTlHF8259A
	NtQ/4m8bt0NYhl0mhLjyEUSBa8ZcXFeGvD6IioE1ja4AAI+4ACQSjW5lPWlrq2lVuRMkuLiRn2t
	hismyTyPoZnQMfl0Sonfw5yOHLDooqZMMJDKhT0optlZCZLsBCVhk+q28/8NXDePuNkbvKSrDaT
	h1OPPi4rVHrAtQtVW9XlFQNAq4LgtVNSNjpYQ2omMXdEQ=
X-Received: by 2002:a05:600c:810c:b0:490:a646:9d77 with SMTP id 5b1f17b1804b1-490b5e94d2cmr73159965e9.6.1780500281611;
        Wed, 03 Jun 2026 08:24:41 -0700 (PDT)
Received: from localhost ([82.192.120.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344148sm8487897f8f.19.2026.06.03.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:24:40 -0700 (PDT)
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Wed,  3 Jun 2026 17:27:44 +0200
Message-ID: <350c2fb454951fd2c9d959f1d94802fea8fa8152.1780498640.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780498640.git.andrea.porta@suse.com>
References: <cover.1780498640.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9238-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrea.porta@suse.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:from_mime,suse.com:email,sashiko.dev:url,qualcomm.com:email,suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,raspberrypi.com:email,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4EEB639541

From: Naushir Patuck <naush@raspberrypi.com>

Add the devicetree binding documentation for the PWM
controller found in the Raspberry Pi RP1 chipset.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Referring to the first comment from:
https://sashiko.dev/#/patchset/cover.1776932336.git.andrea.porta%40suse.com
regarding the DT-bindings, #pwm-cells is not required here because
that requirement is inherited from the referenced pwm.yaml
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


