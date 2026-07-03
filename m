Return-Path: <linux-pwm+bounces-9546-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GiVoHRvrR2pKhgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9546-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 19:02:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AA17047A9
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 19:02:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=MUVnOYcy;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9546-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9546-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BFFE301184C
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39D02F1FEC;
	Fri,  3 Jul 2026 17:02:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7B1A6834
	for <linux-pwm@vger.kernel.org>; Fri,  3 Jul 2026 17:02:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098129; cv=none; b=McZ/H7jkw6t0mEGMaOcpSKvqedtkk+hrmrV1WgHYNsqCqRS0HSu6B0Bl/d5fcWS9DlAx2qvpMKYnIOPB/IGc+6LdR/bC0Fi0iIgSr/pG2WRirLpWCdVSdcGlIgk0k6RlqttJdhzPo8Ec4QGYxHt3htIeN+DcRpRQY9+fnyGOC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098129; c=relaxed/simple;
	bh=YW9uoiEy5CuC0sIxOCa9X8yJ3i0+Ho0/5+EeRbYnQYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtzSnb/sjBzbk1wk1/fn1Hlktc/c85mmalOJA+pjJHOaMJCW4P9J1ZIxMA5oT1sVvK9cSt7JQpORoHGQNjZ99lMqo9V8miSH6gNo/0gODamVKJ8KSZz7C9L2ZTKA/Fs01+eAl292iijiSRp2SATTLdbvmyN595xTfB5W/jfisiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MUVnOYcy; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b68b4643so4338885e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jul 2026 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783098127; x=1783702927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3KtQbiImBVgvP9LE+N4FWws0mqbw5SWS+roXC5ImXQ=;
        b=MUVnOYcy4rbx6+YZPTVD1wfAjhqSreCJ6JheSeNM/jgkUUWC7Tlai/C9T+2ucgrlWq
         SQwD6uh20h5ALxSlk05DjRGHvowPE5N4k1kLOQCFmQdlNUV8XwI5BIXqfov6oLP3Eqzk
         haZnJS6xw3be7qpMuqMW/1zV6xDQ8qHd68Ys0PQyv7RPIfX2n/M6C8Yes3PMp3ftDoAT
         xBLkeFlRL5k+NQ58wQg14q9+D5ddsLCzvpKacQesky4g70ud8PSUGEeWAa7y7VMMz409
         Qgucl8ugOdb1uS3RImk36kSek0cFvBdJQl7ErOG52zIMP/zFhR9R7diE+w4S3+M8v/yP
         1M8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783098127; x=1783702927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x3KtQbiImBVgvP9LE+N4FWws0mqbw5SWS+roXC5ImXQ=;
        b=p67fDg/0HXVcpSCpL9UPBwxaQUE63gINxMC/TWgNqp3hFagzF8KL/fZVooVzSe2j6F
         wvvKbzKPsNPmH61A9Ufd0cbYwygLcUB9kMu7djqCeW8xmbdf4nzH5hLiz+Dn+hLH0ari
         N+/I3dKFCKQeS7GXRMNDIICVcvKPJBtbcEPdFdzQPtB+6FuFOvtl4CrTmLOR6++9zWvb
         W7k2fR6N4qfRRIm6kr+7EbupXBuNR1jMAY3ZDE+WYvML0ACVjVH5XSarGGvU8Rku7m0h
         9n7YnUFE/kQUIuro0wlHwAm9M/19O6CjPLlG38AXGiRX75BSNaGRSn1xOG7TOcE7Vis+
         Cjsw==
X-Forwarded-Encrypted: i=1; AFNElJ8oOYepEUKaKfYcYOOiE+VQb4BVIGGSo8OnxaRi0VshvGpLl3jQNsBYOOTEns6iF9M3bOtZS1zcsXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ek5ftfKxkQK2YKMTNAlKypFcJ5X6a+WoYTnAMMDIvqULelgL
	TSZv2pe3y95SuXqpHfEEXXATKKCy9BEddzgCbBSn0vRobqdwB7sIXiOOuauDO0paUcc=
X-Gm-Gg: AfdE7clnA5rYT5O7qMj2jj3XLl8Sr6H7FHxhUQ+jk/NwiuZXbKz/MtbG7g+AT2XrAc9
	7avAs+iBBHIXAwc+9D8g+8ut53zE8J59e7w0+/QBIOy5YwijseT0fr90V6OS7mahNtJ5bMcdN4s
	moU8IzzU/8KJ/4VmKep+VKeaosutg/cYCpkRVTWmqK6xiszDCfztBVnoUmVJ9mHxua2ulUhAgxY
	KIVsxelAFTq1a5NBZ99KEFNeiAt8kLaFB4uTzN3+j1bM32o/6QG85DWhyyHJ59AZbE4DHYtRqCR
	Tj+KC6F431TTAua7v0QNXTn4N1HmUL72CE7fILJRNNXiPF+KTmMc+9jjO/k2mP9ovcK8vsRi9YZ
	/iQOn877wTK2fKWDB0/Dq6ZgQBiwUXeG08OIbmhlbihchxiLCO06Tg5hu4S6rb3A2U+dofJ/YNi
	owGyAz4XSjCHQ=
X-Received: by 2002:a05:600c:529a:b0:493:b7cb:c5f with SMTP id 5b1f17b1804b1-493d11d7f58mr1680335e9.11.1783098126588;
        Fri, 03 Jul 2026 10:02:06 -0700 (PDT)
Received: from localhost ([195.94.145.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d7801sm762345f8f.16.2026.07.03.10.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:02:06 -0700 (PDT)
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
	mbrugger@suse.com,
	Sean Young <sean@mess.org>,
	Julian Braha <julianbraha@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Fri,  3 Jul 2026 19:05:24 +0200
Message-ID: <67d51a7210f0d7410dbe34e3d93813db1fecd622.1783097764.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1783097764.git.andrea.porta@suse.com>
References: <cover.1783097764.git.andrea.porta@suse.com>
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
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9546-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,broadcom.com,suse.com,lists.infradead.org,raspberrypi.com,suse.de,mess.org,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrea.porta@suse.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:sean@mess.org,m:julianbraha@gmail.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16AA17047A9

From: Naushir Patuck <naush@raspberrypi.com>

Add the devicetree binding documentation for the PWM
controller found in the Raspberry Pi RP1 chipset.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
new file mode 100644
index 0000000000000..970d0f3b33bbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
@@ -0,0 +1,66 @@
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
+  - Andrea della Porta <andrea.porta@suse.com>
+  - Stanimir Varbanov <svarbanov@suse.de>
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
+  dmas:
+    maxItems: 1
+    description: |
+      Phandle to the DMA controller and the channel specifier for
+      the duty-cycle FIFO.
+
+  dma-names:
+    items:
+      - const: tx
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


