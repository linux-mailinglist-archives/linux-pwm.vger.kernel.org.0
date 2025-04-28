Return-Path: <linux-pwm+bounces-5731-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF8A9E5CF
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 03:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D67A3A97C4
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 01:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0655156228;
	Mon, 28 Apr 2025 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvB1QUBE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F599A945;
	Mon, 28 Apr 2025 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804158; cv=none; b=AF+R23uZ+9G7EbdqdZlmecCBFf7eTaGXFv2t+CUrT72BS4MKfBwaqbH37dhe+PRij/dBbQ58cYWrpYguWBCSatfHxS8QWVPsI3naLpKDMqvs42IiX8PcDa40y+QxgvI9eyvQYT8R8zsIVx8BD8o2jCOwiET6u2M6GoZ2oLYQHVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804158; c=relaxed/simple;
	bh=t1QahdLTkbggHPkd85bqDjxlEjBR+yVNZ2AkbAlaWf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrFuViPr+4STQyAYuBuOarRIpRmSbwK10fOI6eN66hodHt6jPxpWvJuNP2qxCz6lsORo6B8sgDgHkJj4zENF+nDTeUxYIeQ9OHQclpjAfxhJqIq7UsfDzUAU7Glyjl5qUtw+nHv324dxIMdG3hZDRSsNFZW8UOohsQbrS2i5hrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvB1QUBE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30820167b47so4076037a91.0;
        Sun, 27 Apr 2025 18:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745804157; x=1746408957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHBvgY1YVP5MIQkksIw+XJJlNkG/WcVVicP7k946nis=;
        b=OvB1QUBEkH2zDrm9xI+qfFFiS9Yq5R6/ic6zeJHacUwFen37wSRu0MQMLu0C/TNHU/
         yKg8yOX23Kkoq1BO4wf8KAlgafvRnJA5M79IBGbC54kt06PYotlS41Bvm9VCY8HmNU5g
         RhQbQEwWXYc6U8l9Zs6xi+9NsgCoHdA4zw/Qa8coL1sKiKJ3Hsb8FmECL6qRbDJVXQIJ
         MD/w4BXb+Im9SQm9rIVfEvMZo5H6qrG/t9jTeBxMVD/rWnQ/p+mdZ44GpWQcYoI7rrWM
         cdNJ6BsIjNF6PFfiwu+Uh+V/B2OKLvlHIzMWJ+CZUk5mJ67Mo1lBG08FBT2BNOoRzhgd
         yZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745804157; x=1746408957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHBvgY1YVP5MIQkksIw+XJJlNkG/WcVVicP7k946nis=;
        b=GPsFcldPQQqFC2xR4Pg3SH5wumpg291DhAT1Z2dvRSGKCX/Jea20ouQPXa01e+x0ua
         e1qW7xpwMBzwzfslSNiEf6uMzHrydgESmHUKwU3kuWMXwERiEgQ/xb4iyFFXeHTelUO7
         Le52PxXGNLr2FbdadwfItfWmMUEavrqfck1qEF6zrQ76uKRR9Ey0p+w6qUhMqto5RDyj
         jRkUwP1pjgUNtnPLUKdFb7xKdgymWB6GA46kO/CMFwfra2PZxrezLDRxJnndYKIUFpVj
         LkeTVvvZ6dnysyZN3nzM/D+2TtJGNov40QJY4bosoLkZ65fPTCurkZAFeQKIV0ArfAfU
         iJUw==
X-Forwarded-Encrypted: i=1; AJvYcCUN6JHU9yVNqfmQWLmk3pfTocgJb1wrbD2ep5R0sIhHiiF8/OwtkrZYMRe6iwS9gSwij4MHNnlwAotu@vger.kernel.org, AJvYcCUeSQg/zz5aBTq4Q/iNs+ci3OMJWzFrf7Qz/EmS/sopyad3K5gDGfqnW75v3TjDPDg0h8ss8LOlLh03@vger.kernel.org, AJvYcCXYR/+f1K/OVjgJUD0SkGmvU+WujWa1EALHVxenYq60gjrZiB6pe7lYc1HirT05PlOLQ/SVYHCJRa2Q++/y@vger.kernel.org
X-Gm-Message-State: AOJu0Yxso8cxcYJmIweU6Qu8MaL+i/ExlVMUQvM4/5e8Y3to1zz0NQ5P
	xh03HzONNlx1y2rihqYLE/y0V6JJyktNZOehC02ul3B6B0mEvJzg
X-Gm-Gg: ASbGncv+gbztBk7vc3+jBOTW+DXRlpcAf8Hcjfe+t9pqhn48LoqLOsf7HUfUMZvkNTD
	H7kcOHh+QmwZU8K7hk1JImnNgoNHcCxGbeAIk71D95hSsnVfNtdAI8QBXvn3EdZ55sxZgicWeaN
	PKPcNdK28F6mTjWHn/SIK9059VL8ojkpbjiOG0/Q1XUywsTM1lH1soPYrIWzCLsyRUQ7Ae5wlGx
	HhsB1WwpOT+BLxMRvKrvMXBxit0+8gtMkDf4lXSguGGL6FkaZbMBu+Q2c1ieIK6wCu48SPNUqA2
	pQPbQ5JLBVDw
X-Google-Smtp-Source: AGHT+IFqoBqa1cKvvhGBCQiK2llHcQRAb6wNABgaxcrqM57k4VTCHHFQ9C6HjSqiASDd5djKAcaSlA==
X-Received: by 2002:a17:90b:5870:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-309f8a076f5mr14749294a91.14.1745804156600;
        Sun, 27 Apr 2025 18:35:56 -0700 (PDT)
Received: from cu.. ([2001:da8:7001:11::460])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb26sm8508671a91.6.2025.04.27.18.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 18:35:56 -0700 (PDT)
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
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: pwm: sophgo: add pwm controller for SG2044
Date: Mon, 28 Apr 2025 09:34:48 +0800
Message-ID: <20250428013501.6354-2-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428013501.6354-1-looong.bin@gmail.com>
References: <20250428013501.6354-1-looong.bin@gmail.com>
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

