Return-Path: <linux-pwm+bounces-6155-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0AAC5BB8
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 22:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3213BB0DC
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 20:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51520D4F0;
	Tue, 27 May 2025 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AJ0RhplB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06920E00C
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 20:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379516; cv=none; b=YFgWXxJxVF3Y8rrSmIvEvqOtQzNnQYPL9C2fISzqfI9NFsqjrDNwe+f0m/6tuwZWIwV+jthybEFClPhJNjYEXJmJjwHjJI+33xnMfGsj/1UAcQ9e/afiorDWx+TMieJcCj163vBS7ji9Pb86o2Ln7uBzZ7/D+t4PS3YM2af01Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379516; c=relaxed/simple;
	bh=2j55HxG++1o7+pdJWJRqq9KAan58dr5frReyQGE0B2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ow207fLWTKqNgI2ZDV6ireZc2oSYe3+ZK4CapNmGVTvtXkGEU/OI/iJXyGbPS86DaUie+anRqKnXF96f8/zDFGl8Q588+Q5pVhwWM0QrT3OQJr8S3giasV/WNB7j6AsNuP1HgjOlvSml6u32MxLnei/QAccLKcIw97d2LV+EhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AJ0RhplB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6045b95d1feso6276283a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748379512; x=1748984312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=emZjqiREaoGi2yubeCTwRZ5yCy+c8DdCcg3D/FzZ4eY=;
        b=AJ0RhplBanWbCI5um31fl/RlDCLD8AZ33+lmwzwuatABE7i4B2FYcdmqEo/Evs9RsV
         KHGhld73XZSo66BuiiOsUqseQetsOvfkvrJefYTw/04G5kXJX/M381DPVfYSaBZyJUDW
         75jHG3LXuacm0w51ToeDNTjwbLS/D9nQ/pZ8GuL3ouKYsqqmP0O6JFvf6trpYdUu8Yvs
         p4F2dQTeQkQGYepnY1Wimj1LO+C8x8SKSDydKn696WOR413k+py4trLBDuwH2V7DRVJ1
         Jz8nDH5EBGeQNaRKcMNBcLPrB+LkFK8D0fVYH3/0Xax8jfyLJNZSaRzBPn8VUDER/2Hk
         p9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748379512; x=1748984312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emZjqiREaoGi2yubeCTwRZ5yCy+c8DdCcg3D/FzZ4eY=;
        b=gJ7ibgaEuK/368ZEF2rkhRS0ufXXiPRbf+APAMBHPuE08cWeYThNkbpcrmgZSaGlaE
         tffrt7SVtpL1c72aRQR4weGzRdHqGgEE3pIzX9zKRisoX1KnUO16RdbrnMzu2K3avdJR
         48e4kWTuqS/ktf+evxYCRQ1bjJ+yHcKUomvP5aimkNv5cBkyFN2GP0VK0Eu2xXt9IowZ
         rT4iPzdB5Q6doJNktk5ZVKyrKegJXEFrZYPl1aH7jgkdyqEqJO7JW7g8FlOTaRXuL6OT
         kjwExTFa273/tO14thLiSjRYk+EnNIFOxT2rNZ7S0CdgSpZ8Yjv5bb9zYTe2nq55YC6O
         Lixg==
X-Forwarded-Encrypted: i=1; AJvYcCXGvWR7KUwItZjGNXsFce1PLOwZUr5Ja/tFundXkYU86J33YspE4RE9B0y6+TBW/yvq6QqG4/OituI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxATRhfLp5fuhyGxJkefFmX22nLK1Fe+YzzIApTfyF00HsaKOqN
	APKp1T6wEF9QD35iMgYlsji6OFxhqgJO0fGw+bvcdmJDiHkx0vkhwkZx9IQK85mcYIk=
X-Gm-Gg: ASbGncsjpvcWHigV5g6J5HZ3/jsdzeqQABENPvoMxm+o92ek8bTmJOfb+H3pQ8rnhRg
	UVs0Ua9198vo3u0unL4ZF0hTrbUbm2+b7pQPbwmplwfLmPxSXeFTOFc7DoYLljPabmAc+7yfef+
	kRsJQPZEfp3HV0wC0UheL2kbtTZq2SS9hzeuo3rpT2SBk5hf92xLtwhGNrzCmWqcgXFZFoCbYvJ
	sQqTma+qjDdIpuNyApz7AgHT5mO3SgoRwTKRpAbx60FwBMvDMf4dI1UFL46mL3fj7IDaqCLh66/
	VmtNgYwtDOTGUqKRTuYZJW5gr3dkOhSVGj17cxsLhdk7wvbZh04DTHgb
X-Google-Smtp-Source: AGHT+IFSEZFLth1i2WF8idDSnCTLky4n60ge/cYVhqY9JgIM5s7CPdNemkYhutHt9SrVLqbShViWHg==
X-Received: by 2002:a17:906:9fcc:b0:ad5:10d9:9061 with SMTP id a640c23a62f3a-ad85b2799cdmr1438576166b.54.1748379512173;
        Tue, 27 May 2025 13:58:32 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad89f087eb3sm10913366b.42.2025.05.27.13.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 13:58:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Use #pwm-cells = <3>
Date: Tue, 27 May 2025 22:58:22 +0200
Message-ID: <20250527205823.377785-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=2j55HxG++1o7+pdJWJRqq9KAan58dr5frReyQGE0B2E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoNidvchLGx7sJjDw3XkwQtzCLWhAeydC1fapAB pgG/EcJqb6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaDYnbwAKCRCPgPtYfRL+ TkqoB/wK0DVgPpFOwwCl+wHBSQVPaTp1DW1ZvFm00WeB35+fPi1flMBZ+hKGs/T0AhBdxZr2ywZ +wq8QkADqh6Flsu6YnJRv1exQltwYc7vjrxp4TwS208gkoVumNnXP7USgOE2+6uvnbq7jBSOUM0 48VTg7JHcBnzrtxwao8kXZCpnmEsONL+XqZQp9sEAbtPVEbCaYVfS/jjtYGQJBNmqNI+Dkc6+b9 wxH1QTw097C9jSTs4dTlpSz019TD/Slv72e0rfG225EsDJwBFlsUDSFI3/m0WdwZYItyzLHFQen ZtENDa39RRNxVRKqaQGJQ2Up5xqVPJv0xSPYTRI3OehU3sdW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With the goal to unify all PWM bindings to use #pwm-cells = <3> update
the renesas,rz-mtu3 binding accordingly. Keep <2> documented as a
deprecated value at least until the in-tree device trees are fixed
accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 .../devicetree/bindings/timer/renesas,rz-mtu3.yaml         | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index 3931054b42fb..3ad10c5b66ba 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -221,7 +221,10 @@ properties:
     maxItems: 1
 
   "#pwm-cells":
-    const: 2
+    oneOf:
+      - const: 2
+        deprecated: true
+      - const: 3
 
 required:
   - compatible
@@ -299,5 +302,5 @@ examples:
       clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
       power-domains = <&cpg>;
       resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
-      #pwm-cells = <2>;
+      #pwm-cells = <3>;
     };

base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.47.2


