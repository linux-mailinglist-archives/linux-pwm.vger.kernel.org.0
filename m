Return-Path: <linux-pwm+bounces-8673-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHXqOpvY6WmglQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8673-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 10:30:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 578A044E8D7
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 10:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4B5C309B034
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2026 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3A3C343A;
	Thu, 23 Apr 2026 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QLPiOoE+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABEB36AB7B
	for <linux-pwm@vger.kernel.org>; Thu, 23 Apr 2026 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932853; cv=none; b=R9+hfwF9zPponpZDqHQJYdMu4aumvaTjX6fbuC7dmk4DhH0ueuD2/o80QLkHYYE1/hUTdFGMaEH7rtTmArEu6qMuTbLKRjZClGhLfBmRAXTkWaBItYezWY9wQf/McGhBGFkCvmTIrIqFMr6WblxS/x9IjOoffLDQrcLqJ8tuWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932853; c=relaxed/simple;
	bh=Ca8dJCyW90j7hqP0A78f/8T/XkttlZt+kLnyxO/ThgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuNFWSSTIsS3XpNVgGViugfW3eLIS2FTxlOyq31DMg1UtQuFPaZkkfkU6h0GnWCfBgs+jfOVWdEVujNZi+udS6OsxKwsAzFEJKl3C99DXVbrBk9MtUdn2XIwA33vBUBj9U2l+rhygUBl9uv/GAsh9A5uwR4EooI+eQp0fNXoUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QLPiOoE+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d7645adbdso3444222f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 23 Apr 2026 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776932849; x=1777537649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtYIyyZaWf61k5kElg2az5B4nsfuSPsBrF1eNrN0vS4=;
        b=QLPiOoE+Jdb90FT4A5s51AmuLynWJq/68afm0UynKo8m68XzLo/dw6DSoiTv7YZwCc
         VfE9R2zbZ5YmYUsHZCNCLgtkY1Ov+mc0wzteasn2tE/+C0gYW1n4ClerTUGvAMOD4YcH
         P4a3vuCe4zLC6iCzcf5NS1NDVxzL09KuySOh64S3uRSadrLYoHk8YdOFmVkmxLSMAdf8
         cwuxsxYHVm3ZKhPfyn3c4+0tTMsVy+brDj2J9ptKbbFnTq7CmcK4SXzoX60E0fmfoo+t
         g1gmgWyzIroeradqzL3cc8n03hlrF+GZSn3cOJs3Rla6cvm+ollEaVcRTs8deE5ObbYo
         Y9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776932849; x=1777537649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtYIyyZaWf61k5kElg2az5B4nsfuSPsBrF1eNrN0vS4=;
        b=W3ZWO8XTjckDEIvnE0bSal68aH9ufWlENcgnpio9SaCu/5uC6U8/YHauCuCWuVTnbf
         RP1eYqNRzMfE484sMZ4XLFjURMD/YlMehEXktNHUXw7Dh1Hwc3Hk5ytkeRVcSYFZJqAO
         msMAO/UF7LX82lA8avwCmNaHe0c/CA8lwyUJurHJMr+0X7Fd9ZNKEmUM7bYJZJ6IYkHs
         1n/FY1dNubldAwKbSTmUeKrXLEH16SQ80z8GmtwVAWkDJ77tLx3MuVUEP9KReyGnsNb5
         8xM+m4cbcJ18P0EmMkXYRYNhEGoKJ23VN2l0BOYd8E3jtLUBKLS2BkSoJNxhcGtiuVmH
         ktgw==
X-Forwarded-Encrypted: i=1; AFNElJ//Q7UXLQdwjRTh1KKPt9MAeVdGZl/xEX1cGi2V4vPe9+XN3x1XA2rHigBGVwJt2o8ikUzG3siMvIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDclS8GOt7zp+IN/9nL90dbhyTnfwS3xRjFtBrw+EIHAoO5Kdg
	d+/9ILAOjU4x0cOzYCcbwJy4e4vO13pNnfVXtwL/MQsJdI3oX8ThBGgd+LpO9yQsz6c=
X-Gm-Gg: AeBDievE6757slBbDkpHhVer+NjAfM8agL+GY/+gIc/0hlxkL8Pp1Q1SDHOwwOO2wtC
	uAUlGQ1h9uVM5rmhF05dKuHEA3Rj2UMzLvvqITliSBl/ZiKHfrMVczcjhbkmMPVKYyG0jjvq/eP
	oraS3VG83x5c5sTIiThhj9TQR9YnnoqhUIKfWTfi6r2CUQ0gh3How8iPpaf2qPKF8zLKBQzDXil
	PFXmPB7HlYb88Up0/4e2ANc8Viy6VqXznp5tyqvlLIMe+OjJJwOsNEL9St+LA2mB0CHQmoMmySj
	zNefEtAtu4TfZfQLXKxWrvfkZXDK+2vHZzeb64AANZBYtB1LQferJhloMOVuo7SnoDQY3sfas42
	NmMIEUvdGu/WhWeMQyio5M9nGiGeK5l+LV11GFHpEsGZaJMo1/V+aCAl9FXDrvP/iOP/dGDN/JX
	6jWBFk3D46h7MAqpQrXypXInLvsBci2MeOy2zzAbrovXZDfP3+B+wX9H1Ir8HdOJP7KEUW1pZuQ
	7cYuN0=
X-Received: by 2002:a5d:5d13:0:b0:43f:e990:2f5d with SMTP id ffacd0b85a97d-43fe9902f8dmr34420482f8f.35.1776932848874;
        Thu, 23 Apr 2026 01:27:28 -0700 (PDT)
Received: from localhost (host-79-33-140-232.retail.telecomitalia.it. [79.33.140.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a174sm56836569f8f.18.2026.04.23.01.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:27:28 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Date: Thu, 23 Apr 2026 10:30:19 +0200
Message-ID: <f21a27b3eed72014cf21650ab22ff45446554d59.1776932336.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776932336.git.andrea.porta@suse.com>
References: <cover.1776932336.git.andrea.porta@suse.com>
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
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8673-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,raspberrypi.com:email,suse.com:email,suse.com:dkim,suse.com:mid,suse.de:email,devicetree.org:url]
X-Rspamd-Queue-Id: 578A044E8D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Naushir Patuck <naush@raspberrypi.com>

Add the devicetree binding documentation for the PWM
controller found in the Raspberry Pi RP1 chipset.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


