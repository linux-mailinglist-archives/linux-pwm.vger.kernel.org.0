Return-Path: <linux-pwm+bounces-9245-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EnBBOipPIWogDAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9245-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:10:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F088E63EDCD
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:10:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=USqgekZk;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9245-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9245-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1943F305BF3E
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6C3E0740;
	Thu,  4 Jun 2026 09:56:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330539B94F
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 09:56:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567015; cv=none; b=kCsKPdBC8JlOxCuvOVpnwOpBXmwncOWgKxgH8+my2XSGFfZ/cs2H2EJeDHPjJ+VpNH08w8UIUU5QPQMoVhJ8DsYkewxJs8vDfrcYsZyk/ACXRNLJFRQxHcpwvcGzGs69DgRzekQpUWAOPxo4u75udJpbvyj2RhJsr3scVLrTIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567015; c=relaxed/simple;
	bh=GlK9ixHx54Su6flP5suqw3t57abQqWUB6DRE7SgXo5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DL1tb6n1KnvEcKYNSABX/MrHjdOpjkpyzbJ+AK81mXyOBd1P56qaxQi0KsLN1bPSKwrCQ7qlPmLgMT1l+xX1DgIOH6veKnGhGi90uu+6hKvj8afuOjKh13kijRZJ7/+p6VQ/7oFaduhyjcvpZ46sKSRWa7NNJRsSR6BWqa9FLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USqgekZk; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b3e03939so4045455e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567013; x=1781171813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpnqT/H77UIaNdz4UGNV31fQveT8Q7DBDQnTYavMONs=;
        b=USqgekZkAxbpGQV2ymPvT1uNwjPrBfku36ElBt/jclzS/CHcGL/dTM/2EzLQwllb1b
         LK5klRIooUYTdjT1AXH3n98y1y0NgyVP2yM/9dsrra2nmwfKV2/BGyLo+RH4R5dgh2JT
         a3vbklzKhfS6rAUbSkxDoijh3FUcHIFBuoP1b7IiDu+hJOEISUfrqmFEwZUSo6dKOG8e
         +IF/13eVJI6NzLNn9qfp/xbXlnHGyezVzfhtv6IkJE3sUW8drNexJr4Ul/q0HXVb+A3n
         JXCtPyT3LvOlQp4aq2ub+LD35Ud/crSqew7XiLwhVxpIFSo436RyrcAIFJeFBvaac36f
         oTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567013; x=1781171813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bpnqT/H77UIaNdz4UGNV31fQveT8Q7DBDQnTYavMONs=;
        b=NbsvqUyP9cYFKaFxwwnvukkEjJLt4BfZH0Y/36jZoXSDXIOpDxaFqbpNpDKzyOWaTK
         AEw05peeJaaS7khGxqgwwiqm/Ppc0RUmFLO8XmVwAT06zkkzXLVWjx0OebMGpCZMLhNx
         yv93S+YDntS2eVPRQmKm7D/4WAtD/SjqS+d5dFzIxmCfWow6LB2tqXryuDVpcSN8VOhh
         xv2EkVVkHbxVrcDz+TfwXLQQJnPVco4EEts2nkM93raPDzVEmWDi8zdOL2daHcHx/FYa
         pKknPIxATdWN8oaIRvSgZmqPG+cBQMZdhEF4V4RxgKDk5bbsLkDEc/dDuSxVvIMNPrwJ
         HHkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+khw7WCqTOYP4OK6uSdeL0x8lQU/mN5xbxLiCJyPZX3IsMVKO9bXR2DntDq25WZLQ+UV9QAmypp3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqDPp295SLo81xzIbTqcB+rVUj0+C62PYTucM8Ru0QNuk9jCc
	bq1LSNVO7U9Vve58P8fPva1/RuvjtOhvOEC4pVDDjOGe7xOKW5Kpvjci
X-Gm-Gg: Acq92OGGXSpWNzy2yaPsNKfIZbkdcznTuZLWAK7pW6V8E1mWq0P7KgyrEN7ANezElqF
	E+0otLKSdt5mtONYtTPetdtXMJ4VOJWptf41OSA7ySJOSG5XtIQ5HjROf4VO3MX0l8HAMQgTZfq
	0Pcj0yqwygeFqFbOeWcF38IFzapbWrzmSxHRx+WCfr0G/DInMypR+zJIfb/x4EIUxFPmoN06mdH
	qlpDVzurdZT7N3Uag/mHCGjwuJ/zm62Z1ixAZPTpdeL7hiOYbxCaswtJ2m9EBs9Jgi8uB0tDbD2
	NmBMzDD1Mc24YUXEMjrO733U0YHZVPoa8w2njoD4Q2tx0zsP/gRFBVJix1bnyIdwEH9hLPhLBI2
	x/Gc5AUu6wHhkDKEBwzI38eQRLnaNW2LWGusRm9/tBE7s1d87M4GRBEYcM6HpZ33jXCXgSmBnzE
	MdX5r+NwxxjCFitqeyjXGtvzNsrxfNz2ZVPzDl1OQK/7vfTiKaSeh1XS9D6vs=
X-Received: by 2002:a05:600c:4453:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490bc50dcecmr42162245e9.16.1780567012510;
        Thu, 04 Jun 2026 02:56:52 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:1615:3574:e0c0:837d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm38037335e9.8.2026.06.04.02.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:56:52 -0700 (PDT)
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
Subject: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
Date: Thu,  4 Jun 2026 10:56:32 +0100
Message-ID: <20260604095647.108654-3-biju.das.jz@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9245-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F088E63EDCD

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G2L GPT IP supports output pin disable function by dead time
error and detecting short-circuits between output pins.

Add documentation for the optional property renesas,poegs to
link a pair of GPT IOs with POEG.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * No change
v5:
 * No change
v24 from [1]:
[1] https://lore.kernel.org/all/20250226144531.176819-1-biju.das.jz@bp.renesas.com/
---
 .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
index 13b807765a30..98bcde755fb9 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
@@ -245,6 +245,28 @@ properties:
   resets:
     maxItems: 1
 
+  renesas,poegs:
+    minItems: 1
+    maxItems: 8
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      items:
+        - description: phandle to POEG instance that serves the output disable
+        - enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+          description: |
+            An index identifying pair of GPT channels.
+              <0> : GPT channels 0 and 1
+              <1> : GPT channels 2 and 3
+              <2> : GPT channels 4 and 5
+              <3> : GPT channels 6 and 7
+              <4> : GPT channels 8 and 9
+              <5> : GPT channels 10 and 11
+              <6> : GPT channels 12 and 13
+              <7> : GPT channels 14 and 15
+    description:
+      A list of phandle and channel index pair tuples to the POEGs that handle the
+      output disable for the GPT channels.
+
 required:
   - compatible
   - reg
@@ -375,4 +397,5 @@ examples:
         power-domains = <&cpg>;
         resets = <&cpg R9A07G044_GPT_RST_C>;
         #pwm-cells = <3>;
+        renesas,poegs = <&poeggd 4>;
     };
-- 
2.43.0


