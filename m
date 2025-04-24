Return-Path: <linux-pwm+bounces-5679-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6268DA99E17
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 03:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1CD5A50C5
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 01:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E78A1C3BFC;
	Thu, 24 Apr 2025 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAIleeBf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3321ADC7B;
	Thu, 24 Apr 2025 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745457909; cv=none; b=XEGfdjWfwJMbyrprqKQ8QqYFBf9RS+zrJiEbcziFqvAaQh/2NZ6j1ixw5E1vul6PJJUsymLm7/lRC1SrzBMCnvTDDu9+9MsoVAEfqYlsQYLrKxAkzfoJHERpiN/aktVs2bWNk4hSilk3hXptDkkihMikwX6SuJ8t7Zi9RBaOOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745457909; c=relaxed/simple;
	bh=g7lN4EvhlvjQ1Rm8b3dvcMl1VivNZiQ0MNwUbg3dnNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giF2uvalQSuHGGggs89blyH3Y/bq90H40GDE+uwzfohKLNGt4fCXGsEriE9uSEhFu32176I3y7CT8tVnaw3LyI+zQwAk9fZYpiaWOy0AvgLb6ym2spWREO4Lcqd13Q5nDUefi7BjAId7sJtT7mYQww5Jl0QIbveEw/lF3n5eop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAIleeBf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736b34a71a1so486734b3a.0;
        Wed, 23 Apr 2025 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745457907; x=1746062707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvD2JS9X5Qd8+7z6kHFhYE/eJ+K8DjqF4BtDR2kwdgg=;
        b=IAIleeBf4f8PQxG69yhcNwknuEeMJu36oOcahBZJPSC9xlzuv9yacpMeHyfH/g1o1B
         Nh74HzLjmHPhKeO0IFS2Tgcc4y7rDOkR13QkS9kwLzws7l7fjIgUdZhURpmB08qxYFDX
         19Ux/LOgJ8d4TkA0HN+30zeAgYbKzOoLsn98apyM24Q0OnyLTTy0sfuJJaLYfs5ifjT/
         F/0q9Y8x9+CQaeqhWFLP9TVfHmimSLzQK8qaVd6uI86+oHbiWfAnwxOEmNTTN3CDDoe4
         rLfCcZcS3Be0W0uATV4laZDE+6508swYZFvVKFx/96BTEkIxe7ZPq1RF0CkSRrPsoGaC
         jQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745457907; x=1746062707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvD2JS9X5Qd8+7z6kHFhYE/eJ+K8DjqF4BtDR2kwdgg=;
        b=KQdllZCzWNZM2XkfHB0ru5Z57EUM0D+G5awZjQKsT8XmC6ZU5jgak6aquHH8Ui8u2a
         EHdJA0rA3RfqAIslgZgc6AsRz0LG62cAcqtXCaxENvWaxRMyd1i2i24LpXGibjXSDnr/
         ueVcT+9DiPCSX2twjyIKRBZe8Sh7vuS31PEIrUQ0gdGXcGkpSOmpP4CKAheyXRG/5d35
         sgxzkSJt8K4OTMwWI5wb2t0UCSE+gvcj7sb8aAC7YeHIxAv2fcue73j1Ph3ib8py1jLr
         Ou9iy83StmEgkDGbbbZZ8odVSXNlzQyFfdg53CWVOl82qskyX0aQw9v8L9vpRL4VC8Ou
         RqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgFMtt5o2qTzDPFgqM+9qECdkzhjSuGkphWtC39nu/i43McHAh1gp22GzH31hSV6MyY/YdXtLSPmDJ@vger.kernel.org, AJvYcCUovW8y0t4PJFZpW/YummKSVA4YUNCuRT9zw9ps8n7C2toqhD9RmZNP6++sfE8yuy/mx1BKIMZ7cwUC@vger.kernel.org, AJvYcCVg/KRPFrkziGJkp8es35+6mF7GJvg+/tKPmhPYeNab24RsB9jTzmkw3XksEx5xpixsmxowqwHE2ucSUuKT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4OSx4SM6dDWj7lhmWbWN8tfCeknTGKzbRQYAZKCoRdmIFWzj+
	6KvSoYahSuVDVt/KBg4ddkJqoT3cDqkkZLm2qQD9OOiIAUWlYFV5
X-Gm-Gg: ASbGncviUyrK0t+BJ/7rarsBDAQ2Iwboj+ISaC0rFy6gLGZzNl1IPmj7ya032zeEWK9
	/60wb8vjbA8MH89AgyGxWM/76WQgMyCaGuIS+z5HxyPoy/Ko+vn7v8Kom/lVGYmlp1A1EqJ3Nju
	/wCfWT1MhTnyHBslpMScanhj9rtlyEyA7qilOdZ9huyMRW90Wf3og6o0pkq/o7dTRCoO8FUy3/9
	9m4n/FowTmUsJabg35CNotMoR/c6qAtKy9hGFa49eZkiPp6cdWq6okGM9en29ucrY9jxuZ0yuAz
	0m7CJeQOSFBNMBSnO7wZkFNSidBej1g=
X-Google-Smtp-Source: AGHT+IFz2drTt6QGmwxnYsh9wLssCL62JZqszhXN41V07+NUcllcYb/Qxu2Szo0lKTrVh+hW53QcFA==
X-Received: by 2002:a05:6a00:35c7:b0:736:5545:5b84 with SMTP id d2e1a72fcca58-73e243c5fe5mr1286649b3a.3.1745457907000;
        Wed, 23 Apr 2025 18:25:07 -0700 (PDT)
Received: from cu.. ([111.34.70.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a8cdsm231049b3a.115.2025.04.23.18.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 18:25:06 -0700 (PDT)
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/3] dt-bindings: pwm: sophgo: add pwm controller for SG2044
Date: Thu, 24 Apr 2025 09:23:26 +0800
Message-ID: <20250424012335.6246-2-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424012335.6246-1-looong.bin@gmail.com>
References: <20250424012335.6246-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for PWM controller on SG2044.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
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

