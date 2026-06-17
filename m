Return-Path: <linux-pwm+bounces-9303-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d25rKbANMmpiuAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9303-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 05:00:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F34CC69634E
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 04:59:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GCWwinvV;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9303-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9303-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5E4B307D9A0
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2026 02:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7974813777E;
	Wed, 17 Jun 2026 02:59:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A15308F38
	for <linux-pwm@vger.kernel.org>; Wed, 17 Jun 2026 02:59:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665177; cv=none; b=IULlnuaKph4eHBdkj/7ue3KfuU39SIXpr70jOsDqPygQmtE138gk5AIQR4iDxfQaBlGOWQ/TXoV9tH7RwlmQgQKz/pN7XhpCYbTiju60G5JTxtbUTJ1Q4GUKKgU6NfqxVtMlMB3RqnW+jxdJvDy+FJtm1pOT9E5rTiV/ckB1YGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665177; c=relaxed/simple;
	bh=10R457NwGTvH71mGj5Kfmru+y69/XctIcBwhK8pKzak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kcDJULm93MK5uf4NFvPu7zlFE3ZHwHZLgB6dT9+ywM0lWr2DzcRwWSKH5yj1SHwcweDIvIISyUFWhiUO8lwmAoEbJNWHZ9aywvgUhyhGcqh11RgTzYFoFDSmyh0o1BYG0eGZoOX3gp3+WfCo8qBwEU/ztNM+TKAjSZYsM641RbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCWwinvV; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8424b00710aso3578217b3a.0
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jun 2026 19:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781665176; x=1782269976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQu/v9VbPVOFvypxy+vSIVqVZUuLUc8YlsM7QgQ5RmA=;
        b=GCWwinvVUWDAXeCkgEswHCD7pb6xpAkWoy0hYYvrT4jfRCozjtbtnsMQwha2BJpgWA
         FZ4v5AHw7ANXY5+4k0x+6pdawwMDw7ZVKg8aeq+6PIRiZoHcfKZpY3U1bbR4TJdd1hBQ
         kNwgOyCOnBEeO2uJnhHrb0wkNlmLxPgWdK3ZKfQVL0Qs41+eJZOhRLRWiaeq+JQ9RUSC
         o2QdA2Ztva506XcoPezOBx1X+nDLXZosw5TaUXbO1/Weh5pEyjwtmEACCNYU8lE63l2w
         IwiJZWsRQRbKL/otZcNZuOT5bTmm+AtKUcZ62NtMCgyoX5RfmQCzX84Y+oAxHYjwycd3
         8QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781665176; x=1782269976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CQu/v9VbPVOFvypxy+vSIVqVZUuLUc8YlsM7QgQ5RmA=;
        b=G6q0p/noazC4URJbLV8217fSXlMoSRbbZcdiwtY9GZaNkq21nHjCdnFnHJojEWSQVb
         kzCDj8yixUGjJcUbuxeEOB4jHgyBpX2fvm1GRQOhuKpGmQyNpP4L8VTg4vm2YCdCnGKk
         rZ5+Sxuorm5gIv1WVQpokZR80yqJMWA+t0c2QbtArUxWwFTt9WIdjwyCPFURp8NmVQt1
         i8hByTe/NKjQuBzLmNmnMBbJbEa793mchHIQq8d1huI2jlNVcA21RAFVRpR0X1yYZ1i0
         QDAiHgM7aDoKElNHh3gTanDyTbHjG/KrNs+mzUXbTtVxBqBGocd2q2S+u+LnWyAxd3bc
         lNGw==
X-Forwarded-Encrypted: i=1; AFNElJ93g0duM+17kRAndmNRPZhchd6xUnCN8E4gMRhXbg6QfOOVQdB/CbGnOMoboC1Xi5L7gXVAkukweUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytnj4fTSNJ/fpoATM62R668k13dUpIQDJucMEkupliUFodwwfH
	cqG7yTduQf2e045meHgNYTky9SSMG1GuV+7Oi8Wppj/9B22hzTMZVF6H
X-Gm-Gg: Acq92OExYRQwxPPyVdRUx2/bVA4x9GLdZU96hqdtbkugvy/Fki3hxvRl8Svbda3xHJG
	mjKGk4Kuj4hHa59YanME5S/eFUoMGNqZoKP7a0o1SS7629QH2ZKyHVjHniXTqmkPaU+Qz/mpFO+
	Z1pYBng35/OAru3VJ38Djtzg6cdFfQFqK9cFK10GbxoxRzdery3lCLDI5eqPfGBv0OrcjmpcbgA
	4IpoFT8/TYAn6YML90P7luW5lHCLR4Opq454CXxacV5Al9gYXxGgQeaHUETF8qYrOeV5Xq9k7+5
	+Myiri5XJb8Fbx8/QXeTZCbOyMp39mYaUIFWnLfJILJPKKrsYfwQw6pKq9hVQ6HNHOY41yDt9IU
	jo1PezdDFj1z7cwNhzliqBIehnR/A6a966JJ1VzNaQ/Btkwm3jH2RqXLbI4p9S/la600ixMVZju
	HUaW2LBei+WEGlXw5bHMjeOyZtLfYA6xIbNC9gqWD0WcABz/vJiy/tRXXTG+Jq2zD2yGAx4mx9j
	zM=
X-Received: by 2002:a05:6a00:2d81:b0:842:4bb9:5fe0 with SMTP id d2e1a72fcca58-84524442788mr1866187b3a.10.1781665175597;
        Tue, 16 Jun 2026 19:59:35 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc825csm14212821b3a.36.2026.06.16.19.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 19:59:35 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: pwm: Add Nuvoton MA35D1 PWM controller
Date: Wed, 17 Jun 2026 10:59:24 +0800
Message-Id: <20260617025925.2539334-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260617025925.2539334-1-cwweng.linux@gmail.com>
References: <20260617025925.2539334-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,nuvoton.com,gmail.com,linaro.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9303-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cwweng@nuvoton.com,m:cwweng.linux@gmail.com,m:krzysztof.kozlowski@linaro.org,m:krzk@kernel.org,m:conor@kernel.org,m:cwwenglinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cwwenglinux@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwwenglinux@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,devicetree.org:url,vger.kernel.org:from_smtp,nuvoton.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F34CC69634E

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add device tree binding for the Nuvoton MA35D1 PWM controller.

The MA35D1 PWM controller provides 6 PWM channels and uses one register
region and one functional clock. The binding uses the standard PWM binding
with three PWM cells.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
new file mode 100644
index 000000000000..47a59bdd14d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nuvoton,ma35d1-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 PWM controller
+
+maintainers:
+  - Chi-Wen Weng <cwweng@nuvoton.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-pwm
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
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    pwm@40580000 {
+      compatible = "nuvoton,ma35d1-pwm";
+      reg = <0x40580000 0x400>;
+      clocks = <&clk EPWM0_GATE>;
+      #pwm-cells = <3>;
+    };
-- 
2.25.1


