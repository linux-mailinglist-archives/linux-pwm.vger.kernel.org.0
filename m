Return-Path: <linux-pwm+bounces-5349-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E48A7D5E4
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 09:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908CB188B9EC
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5956237162;
	Mon,  7 Apr 2025 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnuFhSUw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43522DFA9;
	Mon,  7 Apr 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010523; cv=none; b=LRff3hl2GXP6rYZEGsbpfBCtP9w93wjyYLKkdqx+/RwJCs8IBhKylmHvVTPJUq1oTFK+6kLVCvQhPFY8zWznzpzHK5Bywpcg9puyYluh9CxnAlDjzyQ609p56qmR+zaiLyVjnw/+/ZIghA6kT8DKIimds9lBtIL5vylpB34fgWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010523; c=relaxed/simple;
	bh=H7PXJ3/q1jpmKUwO0QleLbE/GXOAF3rDGeIPInU9/p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQ7GnRo2LROhHgaVcdkYJd+djPgKYAf1JF6zFV65oez/ZW9lHhF3GNXwVCM1kPXF1Ybkq6Lp1rv48ijIOQ5FW8fQ9Wk+nZLKeInf6rlf6K3OXr1vYVBzV4+1Pa9q8/4D1tw9n5LK9qQf+XQzG5KBn2z8MjpdKHJlpoSCS39Wh9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnuFhSUw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73712952e1cso3424557b3a.1;
        Mon, 07 Apr 2025 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744010521; x=1744615321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI7qKUSOHtPbHCZyNOWzBNGKwtih9GNqbp0jjFV0joA=;
        b=TnuFhSUwB7o9hMkdppsr2nePV78+DIQr4bGGtPEJgl4EmbT4t9/06zeQuYWuVqtZW6
         QaiwPXEsj5dnk/TuGB3opESwI3uI8Dl519khTvrhC2fFZN+dLj852xRYyFYgk15a/cdp
         Tjf7VkECj34Hr/cEuMNaI2nR2l5YqPz+pmNo2CClnz6nHyCGnGRTj1MLu+Jpm+bcFK8I
         aVXpCqTftaJ/xtcBhOzRrB7IGCFEiJRN2iLYiXQoAhEbn9U0F8RopMP5jxr7N22JzWUJ
         /zmGD/0/hEAGo8DY4YRHn/RTXoT5gB35Gceozaqdi69wzUuER//FKrlauA+5zSJ3GlRK
         Flvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744010521; x=1744615321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI7qKUSOHtPbHCZyNOWzBNGKwtih9GNqbp0jjFV0joA=;
        b=p/lDb27K2KOI+59U8mpGh4/a0msMd4maGCKk/hIehyHjHeEFO6hYZAkw4cvtiSO8os
         PtnCYimxbQlQPCGxI1L8zFfKgnHCpX89SqMbxl/8T8Xkb7FDtVg22EVHRydebklipDHT
         6B+jefEq3vQZqVQaPDASQA58E6JZVpEboze/dP/ehFy2/EUSugAV5oMcx3j0jIfkazRA
         jG6g72REZDitN8Ip3TTeUs8Ak1sLxmUHbLk03DON5pTJ0aysvM9/+/DKGu5QbMua+Ie0
         33HMEgIOmhfC9+pSoZkEwfSE/KMhoSpvUEqoWlG35424FeCgmr5m4P3jDBo/rj1AbLjp
         Cdrg==
X-Forwarded-Encrypted: i=1; AJvYcCVM7bKvRE7UXVAqhvZ74ldatZ9TRXc4QaaRaCb5S3SnODxbMooJXmFTXiTltZUdNBOqj7ySo9dc7Y3SpJVx@vger.kernel.org, AJvYcCVxHTNowcXi93zYcwmPM9jKl3l5JxHOMw+S3fFGzGjdeFiQ4gNvIl5ARG9u7azQfKjhTHn5WV/LqUNj@vger.kernel.org, AJvYcCWSQsPSimyjdpVrMm6cMJutdvg/2Hglmm7fVAaPP7CgFMh+zHsHfMttbD9tLd6i/LlrsTCHZqSJcRuM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7lPN0mPiEGP+xagy6CYF5U/zkToAZ4suVKTef3sRWXvYcpM4u
	1SpuEAKgyU3rictct9LHd4PmwgjJ6O/OXwGIlHq4spDZohOOmpwb
X-Gm-Gg: ASbGncuKCBChYH2WUX7NBze7k6Qvum5C8xKUw4elyFyQl4HPXb8WKkzz2HNCm98jDnU
	dLEpUmQkjeeqsRCAxhVthR3F2L4kYuWoYW6Rr2AyJq8VZwae8eZtgkA2k6b00AGI9jwyd4RR3ew
	1lvFSPlm5GjptZRSF7/Y/eCDZXjcAd0zG5g+Bto7K+c/RhI1eWkGveL42F+16T0/4P5Q+zzu/ha
	eAmI0WlGy1Kz4Kju4DLjf9F44qrAg/ZCsQiYtfT5ZgIrlw2nMDe/3mB7R3+nw2f4md+NuISwvGn
	ZL9iHU9q8VDXL4XA3aAA/ktEWnWRuQ==
X-Google-Smtp-Source: AGHT+IHLMd65M2VZ4ZmW5RpiMvZX6zeOTv2NQAJx+Mj6d7lV/vM3+ZpmsTrMsyJbYOIWBOCs5g33dQ==
X-Received: by 2002:a05:6a00:2442:b0:736:6ac4:d204 with SMTP id d2e1a72fcca58-739e4855dd7mr13523289b3a.11.1744010521317;
        Mon, 07 Apr 2025 00:22:01 -0700 (PDT)
Received: from cu.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee60dsm7787598b3a.40.2025.04.07.00.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:22:00 -0700 (PDT)
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
Cc: ghost <2990955050@qq.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/2] dt-bindings: pwm: sophgo: add pwm controller for SG2044
Date: Mon,  7 Apr 2025 15:20:38 +0800
Message-ID: <20250407072056.8629-2-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407072056.8629-1-looong.bin@gmail.com>
References: <20250407072056.8629-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ghost <2990955050@qq.com>

Add compatible string for PWM controller on SG2044.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
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
2.48.1

