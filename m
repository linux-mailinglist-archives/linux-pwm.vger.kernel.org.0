Return-Path: <linux-pwm+bounces-7652-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E57C7AB7F
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D823A1277
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280DC26AA88;
	Fri, 21 Nov 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeeweYOo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D92E7F03
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741329; cv=none; b=BJRLFD/S0VJOb/jdOvia54YBEBSEC3K4/go6AdW163E+s+R+W+1AJOJXsx89O7iqI67F+k3md0x1SAan5vdLuQwVSiVCEC0dCeYAw/gtYSW3rOmRf2V2XTIbjy16ux4Nh9xI9Fa4VO4dxyq/Lk3zY74PH5Xc3DSnwdU/DVFjch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741329; c=relaxed/simple;
	bh=1EIACcHpWREBKBrExvsNyR4kt5pjQOmBDnFfqrLeyYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5zDjUoFmViTZ2jw18m3iEZG5+HMu7TbaQNnyL0EYyDSeEWzUAaAOOrikBc3TvuZTAd8qR1BaclZZkZCj9qSbL8X9o+UFT+zqKpir8Eb8UPRPMehWHsvbwlcrZ8TQeoOSyS6w3I1scwM6+PT9juIsvo48Z8NMZXQcI2FPM+y4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeeweYOo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso21170425e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741326; x=1764346126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJfD4VZqi2ZHQfXt2nHUaVIuc8hv442d/bl7fR6YDO8=;
        b=WeeweYOoDbtKxtnS9JDxavJEZwh85IxQgCahVjUT5D7mVE4nF/aKg3D5e2rLCB73/g
         uyPa3aNibuDwgUzXbiJApz8iUdwSWggZWmbKMCU0iuvk6u0eBBJdURfgmNloPV7BW8G/
         EajkAg0sqOG5v3fuDfMVbN5Jx1v5BWcVvcuy9R14iYYna8dUMvrkdiWRxEuVa6ygK4bE
         6eIHntd+vvyfucsnTWUYykUMUsvgWnc6r5ROFKU213cgmqIHLjLayQ0gWyM9W0U1kttb
         y6O+PaaXgDyiW+cANWCqbUPx0XcT4p0who3tUVsDG3p9z34y0JX1T2CMNOD5hcLGb+PF
         WRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741326; x=1764346126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YJfD4VZqi2ZHQfXt2nHUaVIuc8hv442d/bl7fR6YDO8=;
        b=uYoATKZnbUxfp07zZYPcd6Xtf6wkgh5d6d1w+pCSNcy4MM0oWJ9cMjDm8uLCPJf0s0
         a8h1HnXzKUQPQjnUrS+33X7zYWpVuYl7qbXcMIMx7l8qWfrGxdrmAG0CRGeG2GV7aUb9
         FkyHL2ynznJScNpKRVXTiizX7lvU9WRijGm1nzYhc5p1+thBUgijYsFYKe1yM9lcq1cN
         ItKvMS6lwbPFrjXgvmIl26xRCztJobCnyQ3eVv/kchncftz0bOdTWPZngmkzNndUbf9K
         LVHJochguScrb8eG/hrqApS3AXLB5xM1U5TOCV5nURcFYkzcoxlHy7U9kG3KWTdFxtF7
         B8fw==
X-Forwarded-Encrypted: i=1; AJvYcCUb0IHuS/6kaAmZhvH2oojqsIN0BODouVzT18HXJGa594egtkFrVHgo8UgcWpGY8Nyii0ZBC3T0WxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzedPFyM/9nwvO39IK34IFusurZ0LeUmW25+EMox3xKmdKxtyVf
	IGsTm4QRWPFQCyJy3A7EOkfB7YMF5f+uq/m2aGkjU/xDPbUguPBl/z1V
X-Gm-Gg: ASbGnctIx97oCdlfw0ME3GC0DQMSBIIADshwq94U3KIME4CmI/HTIPf7ugrAf1EHHpT
	WtAotg+jiMb6XQg5aqKt6/jUI7CRsl6UU4fi30dKGCqr+xNKAoYERDUt5A6KTe7HZly9MfjID53
	O4OAtA80B2Kz3FW6SfwE8sAwPuHBiaytF8dWW9tpTaoT4A2l6vv5YcGjV5M1jKtdkKX/+/8Qy6s
	ocnCPVhQV6pRiO32TgysXob+zmGLnyVo9RSDhoyqR4pnDg+Ynw6Mtjuke+no+zIvMthQXlH98WI
	4YpQlrySINxdhq7GElXGQT7nNnRwvFxJQCqf9ntGfig7iugkf83crlPRYnWPKIKuGT+fBQ9qTMl
	7FUguk5M1JTefWuTAeQukjCIEYPPTQBl5RQOUHoLDfurLjZPRWhByQiaSjuxQfILFLbk52+BTEO
	uj3USsZ13582TtvpmOXS4ycxVLxbi1krZ5F7iV8hxKAm1cnJiWFz5hRLJJwLX9d+b4hLeG6io=
X-Google-Smtp-Source: AGHT+IHvF4xthtd7HqrwnrOiEMX4kqJJqBTuRMV48hSIy3dGjW2hVW1V+c8zM2P+s0BZEIrkjyNsiQ==
X-Received: by 2002:a05:600c:46c3:b0:477:6d96:b3ca with SMTP id 5b1f17b1804b1-477c01743e2mr30865075e9.5.1763741326204;
        Fri, 21 Nov 2025 08:08:46 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm89496195e9.8.2025.11.21.08.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:08:45 -0800 (PST)
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
Subject: [PATCH v8 01/15] dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
Date: Fri, 21 Nov 2025 16:08:08 +0000
Message-ID: <20251121160842.371922-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
References: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G2L GPT IP supports output pin disable function by dead time
error and detecting short-circuits between output pins.

Add documentation for the optional property renesas,poegs to
link a pair of GPT IOs with POEG.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
V24 from [1] -> v8:
 * No change

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


