Return-Path: <linux-pwm+bounces-6161-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE3AC66C6
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 12:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213403BFD0C
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A902797B5;
	Wed, 28 May 2025 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZAdIVl+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C063212D7D;
	Wed, 28 May 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427131; cv=none; b=m5mE40G3usZ1lisHj5ZE09ulKgZuxSRPzGQtnqgujCKv8GjNzCBtpFYSjOY/dzWFESnBPJ1XYZTMcojY2Ga+nC51xI7mm0dnYnAF6uEwrPcXylNA3rUXZaIGsmID2SV2i59wHx3o2QQVX5Pk+jKdtbS5FRD0WDGr0/AEm6y4ETw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427131; c=relaxed/simple;
	bh=t1QahdLTkbggHPkd85bqDjxlEjBR+yVNZ2AkbAlaWf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9R13Cd9vtqTbiXWISt2C/6sgRbOnrkMiGfd0QHOHFNDVGORyfm573+9RGnvM5JJFlfoBLxdRAjaoyZaO0aLUhmWpakg4hqKmRaedwnhcioGyhDE/44VNf1ueWRy8JnrxipCMxPZFr22mb2802mTiwid4KX4dM3CLMICMZ0CNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZAdIVl+; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4769bbc21b0so37078711cf.2;
        Wed, 28 May 2025 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748427129; x=1749031929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHBvgY1YVP5MIQkksIw+XJJlNkG/WcVVicP7k946nis=;
        b=jZAdIVl+KmmchVtsjac/Xadd0cD9cifEEcyskRqGqu4MwNmDme8MafI5k73fKdGMN6
         9iF/9ww2TcE2NlPh2sJ5DwQI6BaKdNFHBiicxjZwT7u8y1nBIzy7X1vORiW5DtXXwWjX
         D5UHNRiB+3tOVZE1BRNtbjFx0n6sUmSQdRXtn7ycZrLBBUyfV4quqSwZpu6Qqo9aLKeg
         SSIHMIoI9dxRfCc92pZKfXa58skYDUZ2jWw7SSmpASNNIsmGwgGnYw38UxXOJVqPIMM0
         +3WrRPVyyM9UolUVPylAJjOQ4fckIExP1Q+67J9phvxATM7SumX5UBHr9kk1rxZHviaK
         Lp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748427129; x=1749031929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHBvgY1YVP5MIQkksIw+XJJlNkG/WcVVicP7k946nis=;
        b=kSuaGkQ5gs3GGKJspjkUICjv1+k9d8EXMRmOIg0EH04cCGKPD97ec4P0L6Qc7dp+QV
         zo6OM8lP0JIIdtqHiR4TJkXknrHKCenz7Xq4HgEbGeS/8ribyp8dsFknS+ke9b5OkJXZ
         WeSFmaAptEld01KfQvZHXgdgMIgBOhPfFkx3TjTH0jrG0qLWdHdxM+P+Qjo7YE8uhaJx
         Jgwkb583kFPwCHKsZPUquAPQqtL/HZqXLz/IB6cmgXkUIQdvsICawICZUMV2EvYCnk0V
         69y2BC9daBEP+Yg0hZju++4bUWUd9ZlIWoQiDBeAKhjBs7OMFnZ+nWA/HXLd6vi2MV20
         nnTg==
X-Forwarded-Encrypted: i=1; AJvYcCUTUqIGSc2nSYBOnbdT9RnPdF/O1+zDN61tKcerh4ADUWUMwA/ZlN3L6s75DhgJog+QGUnSv2Rh0PzT@vger.kernel.org, AJvYcCWgWk5H6xSHP8gxdkXz5lcIGjMS803B/iNU6srsWfGSIhhMitVNfdsCUBXttjcAMBWmlnD7mJ2LbJCkZ+XE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmy0FeHnkYa7WGP7GY7Ww4wKKv3QMiOa0ZD4IgE5YKflXz/K+7
	jTwt4PFuIqppniJZIR4s7g1ovAMhOwHsW68QAwrLNVocfOR5q9WQiOOHBlf2rw==
X-Gm-Gg: ASbGncsnXxpVa1H+HfsZQNij/rmLSBM6XDtLl0V0CI34tGzRwqoCsli0BuSr6ic3u17
	lRu0kzixmECAdVYQcdPHvrkkym7YhiBawFbfIn+a4Y4kWMxFi8ClJGdR+UZv1iOTtS4sz/l/l9R
	HuPujD90z99r6VVcVk4NYCZQc0LXXN7cqBSW2WXGXHnsnsZj8tKAjX33b/qpnZLh0WOVkdWqedc
	C53opTPDyyhJK184kXi4g2ODEfEj9DZvzJzTIcxILuqkS8CFM/TvoBJ2Q3fqOIIlr/8fdaBVKAT
	wxDyXBt4M7a8W025vyjf/Pi5tIyPNs4IzFC9ZgpO3zFgOA==
X-Google-Smtp-Source: AGHT+IFtudEecNzRLHvC5Zt8E0tk2TyAeIGxp30jdo8UAfABBjjMtWvXU6go6Qz89iGaprdGhLkqmQ==
X-Received: by 2002:a17:903:2f92:b0:234:d7b2:2aab with SMTP id d9443c01a7336-234d7b22ba9mr17655095ad.14.1748427118714;
        Wed, 28 May 2025 03:11:58 -0700 (PDT)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d358f118sm8453595ad.138.2025.05.28.03.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:11:58 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Longbin Li <looong.bin@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: pwm: sophgo: add pwm controller for SG2044
Date: Wed, 28 May 2025 18:11:36 +0800
Message-ID: <20250528101139.28702-2-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528101139.28702-1-looong.bin@gmail.com>
References: <20250528101139.28702-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for PWM controller on SG2044.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
index bbb6326d47d7..e0e91aa237ec 100644
--- a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
@@ -17,7 +17,9 @@ allOf:

 properties:
   compatible:
-    const: sophgo,sg2042-pwm
+    enum:
+      - sophgo,sg2042-pwm
+      - sophgo,sg2044-pwm

   reg:
     maxItems: 1
--
2.49.0

