Return-Path: <linux-pwm+bounces-9253-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rxAuOCROIWqsCwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9253-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:06:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 709BA63ECDE
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:06:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="nK/cY5WR";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9253-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9253-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA0E230E281C
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 09:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30761401A2E;
	Thu,  4 Jun 2026 09:57:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252A83FF891
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 09:57:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567023; cv=none; b=qNarhCenzKLM/z1IzbL7xAx8i6SNCuSRBMEgaOeE7piemL0GzmiaRYmAsCD//UHHqv1rS1l9nyzIkYsDniUwCcJ32DYIGICaywVl0AIVlcj/9PHI+57SEEdoWAmXrZLfuJmB2vsrrwD5oFbQerlxKK3uDvwSwBjES8CKll9NTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567023; c=relaxed/simple;
	bh=evaDaa31llaNDA1fKuLNIMrcVIoSuwe6xA6Yyspx69Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEYt0TaxqJVYL20vj+MtK6AyzbrRlpbCUEvBVS/UIHNIoDdeyEdTKt40HZs/ACgkymH7pW6tHWRF72C/4SquVBnwnUnCIOBZHBUjJGHNIcPqrSeZKBXQN4WnyGuluLXK7ZngHucL+oy52uTsRYtqjtOEDqSjRMAoascQ3cVjxdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK/cY5WR; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so5159015e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567019; x=1781171819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKLaORJorgMTbBd/sx2zZmtjtloHrdymYnVNk+b0fwk=;
        b=nK/cY5WRPlTr/WPviRVz8Plji3lOsJqD1gv44UxxCOkOJwsx/3NaK2aHx1MhdEY7iA
         YNgvzNDLu5B5BhXpgRgrZuzlzQHbBKzWFTaeg3taIMIsZS5joqETcy9u4W5PQJkpWB9f
         0Yrpv5NwbtdZDlBQ8Sdd4aaLQ05ysL7yIHE4yLzTS43L42Vi0ayWUP4KoRWZEBHDdEEq
         2l1V2asQIyA1y/BYEq3ZxGyadl9MHoDDjSnqqrF6jT6sHIklHX/zzgoL6SurtAK8J/63
         TbuvspgKGzQYicPZn/QXUAcxXYNI7dM454s6702NNp8Sl6WhlGxDWQ7Ro5g38kgIhBmD
         OqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567019; x=1781171819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKLaORJorgMTbBd/sx2zZmtjtloHrdymYnVNk+b0fwk=;
        b=hs/LQUzFjSpoxbwo4FPl4NDFdP7huXBPaDqsblL/Pxss6uzutkwGEQcV+7VqLYtF0a
         7ik6IR33PsSKwwefcA+ZIW6hBHSrYj+e2/tYVzeusci2infIn3WftwC2m8H4PKPAdijd
         xQmbbvvtGcNrtKv0EJi3dFENrlS+7UAbFQIrirVeDcekiwSg53XEQiRDeZrjnoN+YE/y
         UfCJdke4L2wXpza0sRiVhom+lRfXNXJVWfxbiBBGs62zJenYTm2IsJX2acwGBaEUlLzK
         dXzc/bANz1oqsSdh/LiJaVXT17/VbjpKho9xlWnziE58c92wL8qzRX9lupJnWK2jshEZ
         NEFA==
X-Forwarded-Encrypted: i=1; AFNElJ+1TNOZTzILeAaWKB7lFl4xgGGCuWNgH14+zB8lEP58t7GjPqdt9EdymVG641/WIGouOSlkjo5mvbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Mj9PfcmaowWokCVI+UdJgW9kLn/zjPWXHJ0VXXeN8feA48eh
	5y5HB7N56OfZASagfYuIrhZ1QPzLnApibPDXxRrmV8AIv1vHK2uEfn3I
X-Gm-Gg: Acq92OF6oTp/ifLjmhST+ZvpyIEDykRK43P3qQAdnATxIpFraLvPACit7CDexlDE/ed
	Obwlj7Va6MDT9uggLJt/DCxnnHvOR6uViFKf0qgDm5YB/oLSZ/O+Xq75ScY13+tX5u+N9NjLUz3
	Mvl4ldrtMkv3Uje1NUya3+WlZzvN3L+yDwvz2d9jMKjL4mfSwSdY4z5mkN1EUHi78i91K1Nwx4p
	hxTkZtBgWOWV7B20vnl4KhGXH6IeN1RzID+NjbjBDxoCNsxoAvBpLQtq+tfbadDlAaVNjDvFuIH
	SVxLMn5riJVsKglzQ7mpSdyLCsYOsTGag5YQdnbMzFFcdhY2UKCszpjWMS3aq5HD2BuUwYU4BBL
	jvY6rGcrRG+wy1c/QgkVqDx7FHEXNRfwhy8b8F98CuRcEfo9p2eO+jUlzfma6W1jyJM7VnLOl1f
	ZRxUqFhQbpuoOU0TWx5YtQzCcmK6x0yuG/NvygsdSMGDR/eXWaSBUoUq36p3s=
X-Received: by 2002:a05:600c:a4b:b0:490:3d62:eb0 with SMTP id 5b1f17b1804b1-490b60ed881mr111383535e9.24.1780567019397;
        Thu, 04 Jun 2026 02:56:59 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:1615:3574:e0c0:837d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm38037335e9.8.2026.06.04.02.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:56:59 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v6 10/11] dt-bindings: pwm: Document RZ/G3E GPT support
Date: Thu,  4 Jun 2026 10:56:40 +0100
Message-ID: <20260604095647.108654-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9253-lists,linux-pwm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:biju.das.jz@bp.renesas.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:biju.das.au@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,m:bijudasau@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,glider.be,gmail.com];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 709BA63ECDE

From: Biju Das <biju.das.jz@bp.renesas.com>

Document support for the GPT found on the Renesas RZ/G3E (R9A09G047)
SoC.

The GPT is a 32-bit timer with 16 hardware channels (GPT0: 8 channel
and GPT1: 8channels). The hardware supports simultaneous control of
all channels. PWM waveforms can be generated by controlling the
up-counter, downcounter, or up- and down-counter.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * No change.
v4->v5:
 * No change.
v3->v4:
 * No change.
v2->v3:
 * Added Rb tag from Rob.
v1->v2:
 * Created separate document for RZ/G3E GPT.
 * Updated commit header and description.
---
 .../bindings/pwm/renesas,rzg3e-gpt.yaml       | 323 ++++++++++++++++++
 1 file changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
new file mode 100644
index 000000000000..cb4ffab5f47f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
@@ -0,0 +1,323 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/renesas,rzg3e-gpt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3E General PWM Timer (GPT)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  RZ/G3E General PWM Timer (GPT) composed of 16 channels with 32-bit
+  timer. It supports the following functions
+  * 32 bits x 16 channels.
+  * Up-counting or down-counting (saw waves) or up/down-counting
+    (triangle waves) for each counter.
+  * Clock sources independently selectable for each channel.
+  * Four I/O pins per channel.
+  * Two output compare/input capture registers per channel.
+  * For the two output compare/input capture registers of each channel,
+    four registers are provided as buffer registers and are capable of
+    operating as comparison registers when buffering is not in use.
+  * In output compare operation, buffer switching can be at crests or
+    troughs, enabling the generation of laterally asymmetric PWM waveforms.
+  * Registers for setting up frame cycles in each channel (with capability
+    for generating interrupts at overflow or underflow)
+  * Generation of dead times in PWM operation.
+  * Synchronous starting, stopping and clearing counters for arbitrary
+    channels.
+  * Count start, count stop, count clear, up-count, down-count, or input
+    capture operation in response to a maximum of 8 ELC events.
+  * Count start, count stop, count clear, up-count, down-count, or input
+    capture operation in response to the status of two input pins.
+  * Starting, clearing, stopping and up/down counters in response to a
+    maximum of four external triggers.
+  * Output pin disable function by detected short-circuits between output
+    pins.
+  * A/D converter start triggers can be generated.
+  * Compare match A to F event and overflow/underflow event can be output
+    to the ELC.
+  * Enables the noise filter for input capture.
+  * Logical operation between the channel output.
+
+properties:
+  compatible:
+    items:
+      - const: renesas,r9a09g047-gpt  # RZ/G3E
+
+  reg:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 3
+
+  interrupts:
+    items:
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.0
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.0
+      - description: A and B both high interrupt for channel GPT{0,1}.0
+      - description: A and B both low interrupt for channel GPT{0,1}.0
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.1
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.1
+      - description: A and B both high interrupt for channel GPT{0,1}.1
+      - description: A and B both low interrupt for channel GPT{0,1}.1
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.2
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.2
+      - description: A and B both high interrupt for channel GPT{0,1}.2
+      - description: A and B both low interrupt for channel GPT{0,1}.2
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.3
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.3
+      - description: A and B both high interrupt for channel GPT{0,1}.3
+      - description: A and B both low interrupt for channel GPT{0,1}.3
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.4
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.4
+      - description: A and B both high interrupt for channel GPT{0,1}.4
+      - description: A and B both low interrupt for channel GPT{0,1}.4
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.5
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.5
+      - description: A and B both high interrupt for channel GPT{0,1}.5
+      - description: A and B both low interrupt for channel GPT{0,1}.5
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.6
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.6
+      - description: A and B both high interrupt for channel GPT{0,1}.6
+      - description: A and B both low interrupt for channel GPT{0,1}.6
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.7
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.7
+      - description: A and B both high interrupt for channel GPT{0,1}.7
+      - description: A and B both low interrupt for channel GPT{0,1}.7
+
+  interrupt-names:
+    items:
+      - const: gtcia0
+      - const: gtcib0
+      - const: gtcic0
+      - const: gtcid0
+      - const: gtcie0
+      - const: gtcif0
+      - const: gtcih0
+      - const: gtcil0
+      - const: gtcia1
+      - const: gtcib1
+      - const: gtcic1
+      - const: gtcid1
+      - const: gtcie1
+      - const: gtcif1
+      - const: gtcih1
+      - const: gtcil1
+      - const: gtcia2
+      - const: gtcib2
+      - const: gtcic2
+      - const: gtcid2
+      - const: gtcie2
+      - const: gtcif2
+      - const: gtcih2
+      - const: gtcil2
+      - const: gtcia3
+      - const: gtcib3
+      - const: gtcic3
+      - const: gtcid3
+      - const: gtcie3
+      - const: gtcif3
+      - const: gtcih3
+      - const: gtcil3
+      - const: gtcia4
+      - const: gtcib4
+      - const: gtcic4
+      - const: gtcid4
+      - const: gtcie4
+      - const: gtcif4
+      - const: gtcih4
+      - const: gtcil4
+      - const: gtcia5
+      - const: gtcib5
+      - const: gtcic5
+      - const: gtcid5
+      - const: gtcie5
+      - const: gtcif5
+      - const: gtcih5
+      - const: gtcil5
+      - const: gtcia6
+      - const: gtcib6
+      - const: gtcic6
+      - const: gtcid6
+      - const: gtcie6
+      - const: gtcif6
+      - const: gtcih6
+      - const: gtcil6
+      - const: gtcia7
+      - const: gtcib7
+      - const: gtcic7
+      - const: gtcid7
+      - const: gtcie7
+      - const: gtcif7
+      - const: gtcih7
+      - const: gtcil7
+
+  clocks:
+    items:
+      - description: Core clock (PCLKD)
+      - description: Bus clock (PCLKA)
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Reset for bus clock (PCLKA/PCLKD)
+      - description: Reset for core clock (PCLKD)
+
+  reset-names:
+    items:
+      - const: rst_p
+      - const: rst_s
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: pwm.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pwm@13010000 {
+        compatible = "renesas,r9a09g047-gpt";
+        reg = <0x13010000 0x10000>;
+        interrupts = <GIC_SPI 538 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 546 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 562 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 570 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 586 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 594 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 539 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 547 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 555 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 563 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 571 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 579 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 587 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 595 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 540 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 548 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 556 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 564 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 572 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 580 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 588 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 596 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 541 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 549 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 557 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 565 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 573 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 581 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 589 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 597 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 542 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 550 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 558 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 566 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 574 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 582 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 590 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 598 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 543 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 551 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 559 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 567 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 575 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 583 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 591 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 599 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 544 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 552 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 560 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 568 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 584 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 592 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 600 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 545 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 553 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 561 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 569 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 577 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 585 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 593 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 601 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "gtcia0", "gtcib0", "gtcic0", "gtcid0",
+                          "gtcie0", "gtcif0", "gtcih0", "gtcil0",
+                          "gtcia1", "gtcib1", "gtcic1", "gtcid1",
+                          "gtcie1", "gtcif1", "gtcih1", "gtcil1",
+                          "gtcia2", "gtcib2", "gtcic2", "gtcid2",
+                          "gtcie2", "gtcif2", "gtcih2", "gtcil2",
+                          "gtcia3", "gtcib3", "gtcic3", "gtcid3",
+                          "gtcie3", "gtcif3", "gtcih3", "gtcil3",
+                          "gtcia4", "gtcib4", "gtcic4", "gtcid4",
+                          "gtcie4", "gtcif4", "gtcih4", "gtcil4",
+                          "gtcia5", "gtcib5", "gtcic5", "gtcid5",
+                          "gtcie5", "gtcif5", "gtcih5", "gtcil5",
+                          "gtcia6", "gtcib6", "gtcic6", "gtcid6",
+                          "gtcie6", "gtcif6", "gtcih6", "gtcil6",
+                          "gtcia7", "gtcib7", "gtcic7", "gtcid7",
+                          "gtcie7", "gtcif7", "gtcih7", "gtcil7";
+        clocks = <&cpg CPG_MOD 0x31>, <&cpg CPG_MOD 0x31>;
+        clock-names = "core", "bus";
+        power-domains = <&cpg>;
+        resets = <&cpg 0x59>, <&cpg 0x5a>;
+        reset-names = "rst_p", "rst_s";
+        #pwm-cells = <3>;
+    };
-- 
2.43.0


