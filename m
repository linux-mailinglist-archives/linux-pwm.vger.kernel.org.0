Return-Path: <linux-pwm+bounces-7064-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBDFB26F16
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 20:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D7C1C237A9
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A823956A;
	Thu, 14 Aug 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtUlGFTp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF11319865;
	Thu, 14 Aug 2025 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196883; cv=none; b=F864kZh6SeuHkfviBQYvrL6WMV0eUVr5J5wjVKO+0GEApclne1cT91Qc0kOQKlk63U9yGFLRO0K1H6klQQusY9aEcwmO0/JB+VlsyqV3HnScW+uxjmwxxmNX8VnXb32SQuavDSYjbzYG1xipA9XBVGTPOhc7jGjsCwlng2unDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196883; c=relaxed/simple;
	bh=E5DXNSbzapUKppWgx9yarWp9EL2Cugoyg6JuA+LJ6SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QU81OvoYu6omW2RdP8uU4aw8cIGsB/NKdhRBgx47C7DDQ6CG2iJ3FHWmItebJoRukRTEIJ+NI0yvUzwInYX0rHAeeIrvTgX1IYmfD55rgMsxQMfM/vzFHZsHJQKP5YUk4TaskI2ZDr4fu5XUHGGCAVuNE7eVaYeUL2pdoVCWKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtUlGFTp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e415a68eso708293f8f.2;
        Thu, 14 Aug 2025 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755196879; x=1755801679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ykD7n53ivDyU/GviBTKiHTwMYber4UFsbL7XDVUan0=;
        b=NtUlGFTpNMM8CSZmkwHnw4svtCR0oDvwKYx2Tsx3wh0bThTK38Ej8hHSHxxbs8CJS7
         /+gwH/LFgoIT8o6LoqfJOe8WNV7HXoITHST2QfR+PdCBY4PbVMK6FVk2LeNNlyKpUkZN
         iQtH3NKXXlsxHy08Xg16ZW7g/UQ9XZmZjFx8vZQPTJDafCjOX5UmoypUiTKJkCMoH99o
         Eo0vYlR48dZT3jn3c4UFmx7iWDmYWTP6SxT/iAZ+SKZvFOVQ4VwbO4jy/PQEIsozpHh9
         ym3kKQPpqHRfEj+SFZN5INwQ6e3b1Ws3zfB4TO3+qbdKV258SSp9FJpgeGivqkW2ujkv
         rh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755196879; x=1755801679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ykD7n53ivDyU/GviBTKiHTwMYber4UFsbL7XDVUan0=;
        b=VWu1dituxBDpwV6FY/ucquuWfNiJ+K5mIWteblUjUwaXGYb7UMuaRG5hI3wVfByGPb
         Zig2ENDgfmq3VrLerg0rhj2j347I8QfUVk3WcVb5DPKSf+45Zr4WbqYRzsNa+Ka72d0R
         6HOoWHT9NK18WNLOeSCg7Q9+A/BDuFy7VT5Tl0CQ9zpvBR6Cc9NW/EMCUn5zwvIkTtIX
         74PntlmIik0GUv7AqZkUqxw+kWNVj9r+k6ibDKpEn14DzXXEV55lezRcIa95AZz/reAN
         CQJSlKXLbJKas3lZyvPzgn6jZS3H1bdnrBpwl3FECnpdj/lfJfz1Bxl750sEqaeJvICp
         1xgA==
X-Forwarded-Encrypted: i=1; AJvYcCUFByFaqgNnXMU6UXCrx5zvsOJmi6ZNqeQCJ5uhRGCxRxyrn7H2LXZSaHvSKlvj1v5hCCal+o8EQehzqr9G@vger.kernel.org, AJvYcCVXfDcBnbi7wxVHtiwIG1UKc9X4hrE/Sz38biaNryVtzCjyvAWX+p34tnFLL9hfd5cDfJ+tETS+Erin@vger.kernel.org, AJvYcCX2GV4qlYluFd/wr5TJ2wgyTs0z2HAJGI4YmCqPrNOVjgucHXjogA07Z3kciP7f4kM/ocEgKkUuQt9D@vger.kernel.org, AJvYcCXwJa1o9xjQfE07HDV64pHbSyfyITfh+HipdosX9d9X8etgl3tOzR7QFoC9lwxpq5ob9ZDwDEDZ6P2lPiQ0TnbKLPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRUjfzru4ge4Nhm8hDZxaUIoWqtkquobDXJtyBHXgULgm8F+va
	zJ2t1BnqxPLuLezVf/dUR/gf5Uy/TgKFys8JmZJpJNfteIvsHFiD0ztBk6vY0gZ7qk8=
X-Gm-Gg: ASbGncvLbM+FAf+yrbuFMtWStV47+xpg4QEG3SbKD4Yl3vJNOXyP1Os1KdwNh4sJdoq
	1XlknWMZitC0Tn0h54l2Qxz6ZFa8+s+HadK9i/hND/z3JQSPONxmSKVYnShz/DuiJcjtWDciDCZ
	lmCeVBDVByzoStlTlhrQOeBLIJnKWSCvEAvaR71yrMqNWXvGTqI/SN7AE26n/Lfq5OeBgWgwBoJ
	1I7YSCpb8yM7gR9IbUw8AiYrb4+2JEJIWFMIRo6TTgQqwxZZpbrsfJpe1+Rx1cM4cWvFQDjq5S+
	+ct63FMiQIffa18zXhxrsAWXqhe/1cmUADCsJw+8hxAGKHFQhQZ6rS4mMAelC/1gqqf/9xs8QRY
	ClBr68lp+xN626yo9ltxkgbFm5vkboSTgCpfOTahJIOiNWq4amVi2bvEqsUMgHOcgqFSj+HKTGA
	==
X-Google-Smtp-Source: AGHT+IGbjXbLTfGvDbBXosr9Qz6QMoggC/Cx2R2yTiVCS48fHaW9RG27CU1bk0CYXblJtqTiNkH1jg==
X-Received: by 2002:a05:6000:230b:b0:3a5:8934:493a with SMTP id ffacd0b85a97d-3b9edf5a275mr3734740f8f.44.1755196878503;
        Thu, 14 Aug 2025 11:41:18 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm53744383f8f.40.2025.08.14.11.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:41:18 -0700 (PDT)
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
Subject: [PATCH 1/7] dt-bindings: pwm: renesas,rzg2l-gpt: Document RZ/G3E support
Date: Thu, 14 Aug 2025 19:41:05 +0100
Message-ID: <20250814184115.192930-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Document support for the GPT found on the Renesas RZ/G3E (R9A09G047)
SoC.

The GPT IP on these parts is similar to that on RZ/G2L but supports
only 8 interrupts per channel and has multiple clocks and resets.
Introduce a new compatible string `renesas,r9a09g047-gpt` for RZ/G3E.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 525 ++++++++++++------
 1 file changed, 356 insertions(+), 169 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
index 13b807765a30..6250dbb200e7 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
@@ -58,11 +58,14 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g044-gpt  # RZ/G2{L,LC}
-          - renesas,r9a07g054-gpt  # RZ/V2L
-      - const: renesas,rzg2l-gpt
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g044-gpt  # RZ/G2{L,LC}
+              - renesas,r9a07g054-gpt  # RZ/V2L
+          - const: renesas,rzg2l-gpt
+
+      - const: renesas,r9a09g047-gpt  # RZ/G3E
 
   reg:
     maxItems: 1
@@ -71,179 +74,327 @@ properties:
     const: 3
 
   interrupts:
-    items:
-      - description: GPT32E0.GTCCRA input capture/compare match
-      - description: GPT32E0.GTCCRB input capture/compare
-      - description: GPT32E0.GTCCRC compare match
-      - description: GPT32E0.GTCCRD compare match
-      - description: GPT32E0.GTCCRE compare match
-      - description: GPT32E0.GTCCRF compare match
-      - description: GPT32E0.GTADTRA compare match
-      - description: GPT32E0.GTADTRB compare match
-      - description: GPT32E0.GTCNT overflow/GTPR compare match
-      - description: GPT32E0.GTCNT underflow
-      - description: GPT32E1.GTCCRA input capture/compare match
-      - description: GPT32E1.GTCCRB input capture/compare
-      - description: GPT32E1.GTCCRC compare match
-      - description: GPT32E1.GTCCRD compare match
-      - description: GPT32E1.GTCCRE compare match
-      - description: GPT32E1.GTCCRF compare match
-      - description: GPT32E1.GTADTRA compare match
-      - description: GPT32E1.GTADTRB compare match
-      - description: GPT32E1.GTCNT overflow/GTPR compare match
-      - description: GPT32E1.GTCNT underflow
-      - description: GPT32E2.GTCCRA input capture/compare match
-      - description: GPT32E2.GTCCRB input capture/compare
-      - description: GPT32E2.GTCCRC compare match
-      - description: GPT32E2.GTCCRD compare match
-      - description: GPT32E2.GTCCRE compare match
-      - description: GPT32E2.GTCCRF compare match
-      - description: GPT32E2.GTADTRA compare match
-      - description: GPT32E2.GTADTRB compare match
-      - description: GPT32E2.GTCNT overflow/GTPR compare match
-      - description: GPT32E2.GTCNT underflow
-      - description: GPT32E3.GTCCRA input capture/compare match
-      - description: GPT32E3.GTCCRB input capture/compare
-      - description: GPT32E3.GTCCRC compare match
-      - description: GPT32E3.GTCCRD compare match
-      - description: GPT32E3.GTCCRE compare match
-      - description: GPT32E3.GTCCRF compare match
-      - description: GPT32E3.GTADTRA compare match
-      - description: GPT32E3.GTADTRB compare match
-      - description: GPT32E3.GTCNT overflow/GTPR compare match
-      - description: GPT32E3.GTCNT underflow
-      - description: GPT32E4.GTCCRA input capture/compare match
-      - description: GPT32E4.GTCCRB input capture/compare
-      - description: GPT32E4.GTCCRC compare match
-      - description: GPT32E4.GTCCRD compare match
-      - description: GPT32E4.GTCCRE compare match
-      - description: GPT32E4.GTCCRF compare match
-      - description: GPT32E4.GTADTRA compare match
-      - description: GPT32E4.GTADTRB compare match
-      - description: GPT32E4.GTCNT overflow/GTPR compare match
-      - description: GPT32E4.GTCNT underflow
-      - description: GPT32E5.GTCCRA input capture/compare match
-      - description: GPT32E5.GTCCRB input capture/compare
-      - description: GPT32E5.GTCCRC compare match
-      - description: GPT32E5.GTCCRD compare match
-      - description: GPT32E5.GTCCRE compare match
-      - description: GPT32E5.GTCCRF compare match
-      - description: GPT32E5.GTADTRA compare match
-      - description: GPT32E5.GTADTRB compare match
-      - description: GPT32E5.GTCNT overflow/GTPR compare match
-      - description: GPT32E5.GTCNT underflow
-      - description: GPT32E6.GTCCRA input capture/compare match
-      - description: GPT32E6.GTCCRB input capture/compare
-      - description: GPT32E6.GTCCRC compare match
-      - description: GPT32E6.GTCCRD compare match
-      - description: GPT32E6.GTCCRE compare match
-      - description: GPT32E6.GTCCRF compare match
-      - description: GPT32E6.GTADTRA compare match
-      - description: GPT32E6.GTADTRB compare match
-      - description: GPT32E6.GTCNT overflow/GTPR compare match
-      - description: GPT32E6.GTCNT underflow
-      - description: GPT32E7.GTCCRA input capture/compare match
-      - description: GPT32E7.GTCCRB input capture/compare
-      - description: GPT32E7.GTCCRC compare match
-      - description: GPT32E7.GTCCRD compare match
-      - description: GPT32E7.GTCCRE compare match
-      - description: GPT32E7.GTCCRF compare match
-      - description: GPT32E7.GTADTRA compare match
-      - description: GPT32E7.GTADTRB compare match
-      - description: GPT32E7.GTCNT overflow/GTPR compare match
-      - description: GPT32E7.GTCNT underflow
+    oneOf:
+      - items:
+          - description: GPT32E0.GTCCRA input capture/compare match
+          - description: GPT32E0.GTCCRB input capture/compare
+          - description: GPT32E0.GTCCRC compare match
+          - description: GPT32E0.GTCCRD compare match
+          - description: GPT32E0.GTCCRE compare match
+          - description: GPT32E0.GTCCRF compare match
+          - description: GPT32E0.GTADTRA compare match
+          - description: GPT32E0.GTADTRB compare match
+          - description: GPT32E0.GTCNT overflow/GTPR compare match
+          - description: GPT32E0.GTCNT underflow
+          - description: GPT32E1.GTCCRA input capture/compare match
+          - description: GPT32E1.GTCCRB input capture/compare
+          - description: GPT32E1.GTCCRC compare match
+          - description: GPT32E1.GTCCRD compare match
+          - description: GPT32E1.GTCCRE compare match
+          - description: GPT32E1.GTCCRF compare match
+          - description: GPT32E1.GTADTRA compare match
+          - description: GPT32E1.GTADTRB compare match
+          - description: GPT32E1.GTCNT overflow/GTPR compare match
+          - description: GPT32E1.GTCNT underflow
+          - description: GPT32E2.GTCCRA input capture/compare match
+          - description: GPT32E2.GTCCRB input capture/compare
+          - description: GPT32E2.GTCCRC compare match
+          - description: GPT32E2.GTCCRD compare match
+          - description: GPT32E2.GTCCRE compare match
+          - description: GPT32E2.GTCCRF compare match
+          - description: GPT32E2.GTADTRA compare match
+          - description: GPT32E2.GTADTRB compare match
+          - description: GPT32E2.GTCNT overflow/GTPR compare match
+          - description: GPT32E2.GTCNT underflow
+          - description: GPT32E3.GTCCRA input capture/compare match
+          - description: GPT32E3.GTCCRB input capture/compare
+          - description: GPT32E3.GTCCRC compare match
+          - description: GPT32E3.GTCCRD compare match
+          - description: GPT32E3.GTCCRE compare match
+          - description: GPT32E3.GTCCRF compare match
+          - description: GPT32E3.GTADTRA compare match
+          - description: GPT32E3.GTADTRB compare match
+          - description: GPT32E3.GTCNT overflow/GTPR compare match
+          - description: GPT32E3.GTCNT underflow
+          - description: GPT32E4.GTCCRA input capture/compare match
+          - description: GPT32E4.GTCCRB input capture/compare
+          - description: GPT32E4.GTCCRC compare match
+          - description: GPT32E4.GTCCRD compare match
+          - description: GPT32E4.GTCCRE compare match
+          - description: GPT32E4.GTCCRF compare match
+          - description: GPT32E4.GTADTRA compare match
+          - description: GPT32E4.GTADTRB compare match
+          - description: GPT32E4.GTCNT overflow/GTPR compare match
+          - description: GPT32E4.GTCNT underflow
+          - description: GPT32E5.GTCCRA input capture/compare match
+          - description: GPT32E5.GTCCRB input capture/compare
+          - description: GPT32E5.GTCCRC compare match
+          - description: GPT32E5.GTCCRD compare match
+          - description: GPT32E5.GTCCRE compare match
+          - description: GPT32E5.GTCCRF compare match
+          - description: GPT32E5.GTADTRA compare match
+          - description: GPT32E5.GTADTRB compare match
+          - description: GPT32E5.GTCNT overflow/GTPR compare match
+          - description: GPT32E5.GTCNT underflow
+          - description: GPT32E6.GTCCRA input capture/compare match
+          - description: GPT32E6.GTCCRB input capture/compare
+          - description: GPT32E6.GTCCRC compare match
+          - description: GPT32E6.GTCCRD compare match
+          - description: GPT32E6.GTCCRE compare match
+          - description: GPT32E6.GTCCRF compare match
+          - description: GPT32E6.GTADTRA compare match
+          - description: GPT32E6.GTADTRB compare match
+          - description: GPT32E6.GTCNT overflow/GTPR compare match
+          - description: GPT32E6.GTCNT underflow
+          - description: GPT32E7.GTCCRA input capture/compare match
+          - description: GPT32E7.GTCCRB input capture/compare
+          - description: GPT32E7.GTCCRC compare match
+          - description: GPT32E7.GTCCRD compare match
+          - description: GPT32E7.GTCCRE compare match
+          - description: GPT32E7.GTCCRF compare match
+          - description: GPT32E7.GTADTRA compare match
+          - description: GPT32E7.GTADTRB compare match
+          - description: GPT32E7.GTCNT overflow/GTPR compare match
+          - description: GPT32E7.GTCNT underflow
+      - items:
+          - description: Input capture/compare match of the GTCCRA for channel 0 and 8
+          - description: Input capture/compare match of the GTCCRB for channel 0 and 8
+          - description: Compare match with the GTCCRC for channel 0 and 8
+          - description: Compare match with the GTCCRD for channel 0 and 8
+          - description: Compare match with the GTCCRE for channel 0 and 8
+          - description: Compare match with the GTCCRF for channel 0 and 8
+          - description: A and B both high interrupt for channel 0 and 8
+          - description: A and B both low interrupt for channel 0 and 8
+          - description: Input capture/compare match of the GTCCRA for channel 1 and 9
+          - description: Input capture/compare match of the GTCCRB for channel 1 and 9
+          - description: Compare match with the GTCCRC for channel 1 and 9
+          - description: Compare match with the GTCCRD for channel 1 and 9
+          - description: Compare match with the GTCCRE for channel 1 and 9
+          - description: Compare match with the GTCCRF for channel 1 and 9
+          - description: A and B both high interrupt for channel 1 and 9
+          - description: A and B both low interrupt for channel 1 and 9
+          - description: Input capture/compare match of the GTCCRA for channel 2 and 10
+          - description: Input capture/compare match of the GTCCRB for channel 2 and 10
+          - description: Compare match with the GTCCRC for channel 2 and 10
+          - description: Compare match with the GTCCRD for channel 2 and 10
+          - description: Compare match with the GTCCRE for channel 2 and 10
+          - description: Compare match with the GTCCRF for channel 2 and 10
+          - description: A and B both high interrupt for channel 2 and 10
+          - description: A and B both low interrupt for channel 2 and 10
+          - description: Input capture/compare match of the GTCCRA for channel 3 and 11
+          - description: Input capture/compare match of the GTCCRB for channel 3 and 11
+          - description: Compare match with the GTCCRC for channel 3 and 11
+          - description: Compare match with the GTCCRD for channel 3 and 11
+          - description: Compare match with the GTCCRE for channel 3 and 11
+          - description: Compare match with the GTCCRF for channel 3 and 11
+          - description: A and B both high interrupt for channel 3 and 11
+          - description: A and B both low interrupt for channel 3 and 11
+          - description: Input capture/compare match of the GTCCRA for channel 4 and 12
+          - description: Input capture/compare match of the GTCCRB for channel 4 and 12
+          - description: Compare match with the GTCCRC for channel 4 and 12
+          - description: Compare match with the GTCCRD for channel 4 and 12
+          - description: Compare match with the GTCCRE for channel 4 and 12
+          - description: Compare match with the GTCCRF for channel 4 and 12
+          - description: A and B both high interrupt for channel 4 and 12
+          - description: A and B both low interrupt for channel 4 and 12
+          - description: Input capture/compare match of the GTCCRA for channel 5 and 13
+          - description: Input capture/compare match of the GTCCRB for channel 5 and 13
+          - description: Compare match with the GTCCRC for channel 5 and 13
+          - description: Compare match with the GTCCRD for channel 5 and 13
+          - description: Compare match with the GTCCRE for channel 5 and 13
+          - description: Compare match with the GTCCRF for channel 5 and 13
+          - description: A and B both high interrupt for channel 5 and 13
+          - description: A and B both low interrupt for channel 5 and 13
+          - description: Input capture/compare match of the GTCCRA for channel 6 and 14
+          - description: Input capture/compare match of the GTCCRB for channel 6 and 14
+          - description: Compare match with the GTCCRC for channel 6 and 14
+          - description: Compare match with the GTCCRD for channel 6 and 14
+          - description: Compare match with the GTCCRE for channel 6 and 14
+          - description: Compare match with the GTCCRF for channel 6 and 14
+          - description: A and B both high interrupt for channel 6 and 14
+          - description: A and B both low interrupt for channel 6 and 14
+          - description: Input capture/compare match of the GTCCRA for channel 7 and 15
+          - description: Input capture/compare match of the GTCCRB for channel 7 and 15
+          - description: Compare match with the GTCCRC for channel 7 and 15
+          - description: Compare match with the GTCCRD for channel 7 and 15
+          - description: Compare match with the GTCCRE for channel 7 and 15
+          - description: Compare match with the GTCCRF for channel 7 and 15
+          - description: A and B both high interrupt for channel 7 and 15
+          - description: A and B both low interrupt for channel 7 and 15
 
   interrupt-names:
-    items:
-      - const: ccmpa0
-      - const: ccmpb0
-      - const: cmpc0
-      - const: cmpd0
-      - const: cmpe0
-      - const: cmpf0
-      - const: adtrga0
-      - const: adtrgb0
-      - const: ovf0
-      - const: unf0
-      - const: ccmpa1
-      - const: ccmpb1
-      - const: cmpc1
-      - const: cmpd1
-      - const: cmpe1
-      - const: cmpf1
-      - const: adtrga1
-      - const: adtrgb1
-      - const: ovf1
-      - const: unf1
-      - const: ccmpa2
-      - const: ccmpb2
-      - const: cmpc2
-      - const: cmpd2
-      - const: cmpe2
-      - const: cmpf2
-      - const: adtrga2
-      - const: adtrgb2
-      - const: ovf2
-      - const: unf2
-      - const: ccmpa3
-      - const: ccmpb3
-      - const: cmpc3
-      - const: cmpd3
-      - const: cmpe3
-      - const: cmpf3
-      - const: adtrga3
-      - const: adtrgb3
-      - const: ovf3
-      - const: unf3
-      - const: ccmpa4
-      - const: ccmpb4
-      - const: cmpc4
-      - const: cmpd4
-      - const: cmpe4
-      - const: cmpf4
-      - const: adtrga4
-      - const: adtrgb4
-      - const: ovf4
-      - const: unf4
-      - const: ccmpa5
-      - const: ccmpb5
-      - const: cmpc5
-      - const: cmpd5
-      - const: cmpe5
-      - const: cmpf5
-      - const: adtrga5
-      - const: adtrgb5
-      - const: ovf5
-      - const: unf5
-      - const: ccmpa6
-      - const: ccmpb6
-      - const: cmpc6
-      - const: cmpd6
-      - const: cmpe6
-      - const: cmpf6
-      - const: adtrga6
-      - const: adtrgb6
-      - const: ovf6
-      - const: unf6
-      - const: ccmpa7
-      - const: ccmpb7
-      - const: cmpc7
-      - const: cmpd7
-      - const: cmpe7
-      - const: cmpf7
-      - const: adtrga7
-      - const: adtrgb7
-      - const: ovf7
-      - const: unf7
+    oneOf:
+      - items:
+          - const: ccmpa0
+          - const: ccmpb0
+          - const: cmpc0
+          - const: cmpd0
+          - const: cmpe0
+          - const: cmpf0
+          - const: adtrga0
+          - const: adtrgb0
+          - const: ovf0
+          - const: unf0
+          - const: ccmpa1
+          - const: ccmpb1
+          - const: cmpc1
+          - const: cmpd1
+          - const: cmpe1
+          - const: cmpf1
+          - const: adtrga1
+          - const: adtrgb1
+          - const: ovf1
+          - const: unf1
+          - const: ccmpa2
+          - const: ccmpb2
+          - const: cmpc2
+          - const: cmpd2
+          - const: cmpe2
+          - const: cmpf2
+          - const: adtrga2
+          - const: adtrgb2
+          - const: ovf2
+          - const: unf2
+          - const: ccmpa3
+          - const: ccmpb3
+          - const: cmpc3
+          - const: cmpd3
+          - const: cmpe3
+          - const: cmpf3
+          - const: adtrga3
+          - const: adtrgb3
+          - const: ovf3
+          - const: unf3
+          - const: ccmpa4
+          - const: ccmpb4
+          - const: cmpc4
+          - const: cmpd4
+          - const: cmpe4
+          - const: cmpf4
+          - const: adtrga4
+          - const: adtrgb4
+          - const: ovf4
+          - const: unf4
+          - const: ccmpa5
+          - const: ccmpb5
+          - const: cmpc5
+          - const: cmpd5
+          - const: cmpe5
+          - const: cmpf5
+          - const: adtrga5
+          - const: adtrgb5
+          - const: ovf5
+          - const: unf5
+          - const: ccmpa6
+          - const: ccmpb6
+          - const: cmpc6
+          - const: cmpd6
+          - const: cmpe6
+          - const: cmpf6
+          - const: adtrga6
+          - const: adtrgb6
+          - const: ovf6
+          - const: unf6
+          - const: ccmpa7
+          - const: ccmpb7
+          - const: cmpc7
+          - const: cmpd7
+          - const: cmpe7
+          - const: cmpf7
+          - const: adtrga7
+          - const: adtrgb7
+          - const: ovf7
+          - const: unf7
+      - items:
+          - const: gtcia0
+          - const: gtcib0
+          - const: gtcic0
+          - const: gtcid0
+          - const: gtcie0
+          - const: gtcif0
+          - const: gtcih0
+          - const: gtcil0
+          - const: gtcia1
+          - const: gtcib1
+          - const: gtcic1
+          - const: gtcid1
+          - const: gtcie1
+          - const: gtcif1
+          - const: gtcih1
+          - const: gtcil1
+          - const: gtcia2
+          - const: gtcib2
+          - const: gtcic2
+          - const: gtcid2
+          - const: gtcie2
+          - const: gtcif2
+          - const: gtcih2
+          - const: gtcil2
+          - const: gtcia3
+          - const: gtcib3
+          - const: gtcic3
+          - const: gtcid3
+          - const: gtcie3
+          - const: gtcif3
+          - const: gtcih3
+          - const: gtcil3
+          - const: gtcia4
+          - const: gtcib4
+          - const: gtcic4
+          - const: gtcid4
+          - const: gtcie4
+          - const: gtcif4
+          - const: gtcih4
+          - const: gtcil4
+          - const: gtcia5
+          - const: gtcib5
+          - const: gtcic5
+          - const: gtcid5
+          - const: gtcie5
+          - const: gtcif5
+          - const: gtcih5
+          - const: gtcil5
+          - const: gtcia6
+          - const: gtcib6
+          - const: gtcic6
+          - const: gtcid6
+          - const: gtcie6
+          - const: gtcif6
+          - const: gtcih6
+          - const: gtcil6
+          - const: gtcia7
+          - const: gtcib7
+          - const: gtcic7
+          - const: gtcid7
+          - const: gtcie7
+          - const: gtcif7
+          - const: gtcih7
+          - const: gtcil7
 
   clocks:
-    maxItems: 1
+    items:
+      - description: Core clock (PCLKD)
+      - description: Bus clock (PCLKA)
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
 
   power-domains:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    items:
+      - description: Reset for bus clock (PCLKA/PCLKD)
+      - description: Reset for core clock (PCLKD)
+    minItems: 1
+
+  reset-names:
+    items:
+      - const: rst_p
+      - const: rst_s
 
 required:
   - compatible
@@ -257,6 +408,42 @@ required:
 allOf:
   - $ref: pwm.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-gpt
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        resets:
+          minItems: 2
+        interrupts:
+          maxItems: 64
+        interrupt-names:
+          maxItems: 64
+
+      required:
+        - clock-names
+        - reset-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rzg2l-gpt
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        resets:
+          maxItems: 1
+        interrupts:
+          minItems: 80
+        interrupt-names:
+          minItems: 80
+
 additionalProperties: false
 
 examples:
-- 
2.43.0


