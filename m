Return-Path: <linux-pwm+bounces-9093-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKNvOyXlEWrirgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9093-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 19:34:29 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FAD5C00DF
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 19:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03035302BDC2
	for <lists+linux-pwm@lfdr.de>; Sat, 23 May 2026 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6998D320A14;
	Sat, 23 May 2026 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhMA0BMT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA342E62A9
	for <linux-pwm@vger.kernel.org>; Sat, 23 May 2026 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779557602; cv=none; b=t1KGgaADClx5z28ENHh3QaRDxiJFe72RLeb5ymB9WOqUOpdLeLkW1AxqclM0V4gmgoFqUgq368/zwzG1qyZtMHTSwVZh9uHgnwJUwYoh7oA9JX2nQPhbpeiZ+S+qMjJcM4D4Qk5+N/uwEa5US0QjkFImg5uJEnKqQap/plqKeOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779557602; c=relaxed/simple;
	bh=WFHJB0zVU9aeCuRj8HDI9lHMmorAHtWcYiuIgtuUY9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwLfDCFUyAnecJ9pTBUKSHS97Dd3BUAIy8DRoothSKn2e/solgOdG7txTJ56wZ3R3JWELed03pMwSVCQ8iXyrydpOtbRlgfZ0Bqb4MV40VN0uH8iXMJYWlE/cGHV+jbQ3cpSnWsmM5HdyU/ZGzx5PVuFNwslJ1/Ni98fpkMc0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhMA0BMT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f8893bff3so3870239b3a.2
        for <linux-pwm@vger.kernel.org>; Sat, 23 May 2026 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779557600; x=1780162400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3F79MqG9jAX2CXiKWut0k15rC5yK9KJ27umq50B/zo=;
        b=JhMA0BMTJSsce+livwjHUt8JWOv5n0h9Crt/89w4uPRQ3CzwZgf/0ttitRAoskd+F0
         EKVVy9Ilnt5DpUGUoNY/kGfXA23LyPmsnakowR22NOJCUKZ7rYfydsqwt0zUkja/q/eY
         /X2h1mo5YsPSU6Aogm66LL/qF2OjANtT7HWSz/oDXtw2+fbssBm8LrToVQ3fsMF0deLw
         U0OwvZN9Pzl01hSPmApZWJJbbjlVN0wr5HpL1gZrpONdvD0qPhFL/zvHefgt7dkcaJYz
         Y4hjVNSDbR+ZBnNQ3SbGHxh3NkTEzFte/labaR51TdBGuyKkWzmLzfGJ9wi7bn4h+lC9
         u0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779557600; x=1780162400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3F79MqG9jAX2CXiKWut0k15rC5yK9KJ27umq50B/zo=;
        b=Gw0jlxR2Iys57HCL5n97iqnXCzdVcURvWePLuEHIyzOY3QIwbjqss7G6jY+KehNIy9
         r6XzoUxLRI08pXr8SOL3nbcXi8STRVsQc0+o8ofTkXhTeoFORjQyqoGHVNpyF3SsNpbD
         qOYmpnb1GovyDD89zFkLXkJze3VxlujUi1n94BE4OY7NL2A1rU74652Da0GGSufHn/CG
         hMP5NuIfpHlwipMGD0ag4s+tCmzput5SVtz5YoDM7d4AFjqxjh6qerv1rlNA1pp+QcLQ
         GGcL9rxhLY31dA3k/2sVhvWbVV/6GOnKoRCDgX9U8P4KaLYoLJCgLyfqaFgIaA0ZepIa
         wNTw==
X-Gm-Message-State: AOJu0YwxMWhEOsSopGfqwKp3q8NaJJr+iXRtbhoEhDHbmLd3WjlMxXj0
	wVfwfe7q15f7k6pva4mqQf1Y9tWnSeZc5sd/3OIhdtuGEGTi+7xY+dWA
X-Gm-Gg: Acq92OEdfiZAixErKQ3cXRfkkx9CIR2jVxp/RRkJKMoqps9LRCRbkrt1RrA5S15daQB
	NCfDEwpaFimrO8JXQR3ymC8WYPPsDGU54+a0XenFQbRCu9VbEvXMl+LKvm88Yu0meSIdxX4YDpi
	Mn2OdUPm2je9V7p+rM01ZkK8CmmgzJRB7zdHgcb7aMZ4n2+wu6O3IAxN3JtAtVOvRTrgatunjv6
	PjdcYuNFHkQaHy6xNbn+3ICDwXx0s412iGoExlsAUqT5blo/zmC3BxeDhyal2CrHxbgtIWrxo2J
	aQ0l3tUebpkEIeMGepcO1w2w+lc8mV5ICJdx48aHGjIeOGS660ltUjGlt6TyTN+PAQxui7k40eZ
	FRb16jGApokHyCfMwlm/1EvbJ4+jdmvbD7+m6VwM9tY/DtCXkgP+Q4qHPDYBTI19ZP3MkypjiqY
	mxB6rI6d79ElkI4T4DDxJlwg4sAJh8D4/IRgKgqJO2/NgtE5iu+HD6sl7NcqsC3QLDzA==
X-Received: by 2002:a05:6a00:4483:b0:82a:780f:a187 with SMTP id d2e1a72fcca58-8415f5e6690mr8305636b3a.36.1779557600057;
        Sat, 23 May 2026 10:33:20 -0700 (PDT)
Received: from Ubuntu.. ([49.37.171.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fc646bsm5162945b3a.46.2026.05.23.10.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 10:33:19 -0700 (PDT)
From: Manish Baing <manishbaing2789@gmail.com>
To: lee@kernel.org,
	ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linusw@kernel.org
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	manishbaing2789@gmail.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/2] dt-bindings: pwm: stmpe: drop legacy binding
Date: Sat, 23 May 2026 17:32:51 +0000
Message-ID: <20260523173251.72540-3-manishbaing2789@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523173251.72540-1-manishbaing2789@gmail.com>
References: <20260523173251.72540-1-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9093-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,foss.st.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com,microchip.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manishbaing2789@gmail.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Queue-Id: 55FAD5C00DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The st,stmpe-pwm binding is already covered by the MFD schema
Documentation/devicetree/bindings/mfd/st,stmpe.yaml. Remove the
obsolete and redundant text binding file.

Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 .../devicetree/bindings/pwm/st,stmpe-pwm.txt   | 18 ------------------
 1 file changed, 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt b/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
deleted file mode 100644
index f401316e0248..000000000000
--- a/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-== ST STMPE PWM controller ==
-
-This is a PWM block embedded in the ST Microelectronics STMPE
-(ST Multi-Purpose Expander) chips. The PWM is registered as a
-subdevices of the STMPE MFD device.
-
-Required properties:
-- compatible: should be:
-  - "st,stmpe-pwm"
-- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Example:
-
-pwm0: pwm {
-	compatible = "st,stmpe-pwm";
-	#pwm-cells = <2>;
-};
-- 
2.43.0


