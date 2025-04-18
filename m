Return-Path: <linux-pwm+bounces-5564-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA1A92FF7
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 04:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE983B3902
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3F0267AF2;
	Fri, 18 Apr 2025 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5Swf0hX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30AAD23;
	Fri, 18 Apr 2025 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943422; cv=none; b=QxkNRTe5Tm8XkP0fQtGSBAMawb05RSefR9rBnTlNd+N+4ZlYRrnYQDlvP7sGP4YKtnx395whLYDWNTitY7/EepwrYmGnHZwhstwQSaLDqD43PoTCnZD+gqvpodL2L+WKDWG14br3qQuvkz70WJTLvuJWW8Nbj0fRCOXWQKgcknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943422; c=relaxed/simple;
	bh=EF/mLJTv6gNbHMAQsAe4x40aedzcnFG52dclCJs95zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWimksGegiC2h1xJxQ0YXpCkXTkdnd7v82eG9OhEOQkwutTO55S0Rz0dY/Eiusad7GyCbjTfEBft++ZZzwN9LsYsD4CAn3caxtDqIX66+OSSZmhpzbl8VqrAO/zttblOVRHQ/Q+bwsDx7yTiT7SNu//Wdssy0peCZjZ9PrGPrQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5Swf0hX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af6a315b491so1133398a12.1;
        Thu, 17 Apr 2025 19:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744943420; x=1745548220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Di4XiSgh+BQAH0MOm1AlDsADVyTkQM6H/o91uhBRMnI=;
        b=f5Swf0hXRJIYqEWW+NTybvCvhlnF+cmDZGQ81NZy6+gXTHHRGtq8gMW49wsfADBkR7
         f03To5QxB2ZCK5YZqtABXNy0wCgiDimz3wI50Bx9qcDpHy1VY9l24YfeIrlVZ2HS+uDt
         AK4kZNSVLjGgiBaGa1m0cIfT3sRHVVAySi5nDOD5ZAKfrsT7a3c0W7ZPVhiBd0FgRHgd
         iF1t3XGoD2oTEX87PED8eIMefobWwXpzOxO3vEhLqj29J+P3PG7f1R6nXptj6NsPga2o
         mpcOj/05ofDMudiFcUXDhkIBci2cqd07IebBBR00Yi7LdRdP2BB5FoYcy018niGo9msP
         fjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744943420; x=1745548220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Di4XiSgh+BQAH0MOm1AlDsADVyTkQM6H/o91uhBRMnI=;
        b=G2u7aK6fB5La97HRg0TidNtF336n2MDkpLyzxiRQK+sZKypI7C7Tt9td2WZazb2TLg
         X1xyqENntoaiCwFWWZDTQ8VsZPHe0Uivui8RQCRSqxc/bAfGpuwjJ99CIYhzYRnW7FeB
         nb7aiRq/nOGlJMniJ1TTai22xxh50whVy87WMu3VhxPw7xaXI5z+5jGW4DjmshY3KziB
         RJhwloejgdEIuhwcNHN+Rz0VKgGA/1NW6PvtayEHMv7EgepJPIMl2FP4P11FCnTkFa0a
         G9mQsI5Tlu1wqAXJIbnuJerHiABWx9+cLeuoxG+sULpK/oomRvWLrCpdF+ycu7ADG0Af
         ffwg==
X-Forwarded-Encrypted: i=1; AJvYcCUIMD2louMN6AhgwuIq2SiFZgJLaxvQm1RJcCnDxbeRDk/FS0OblZu7T2NIXjpITCJoqV8kz7wrk2v0Beo1@vger.kernel.org, AJvYcCVtlLLp9xJcmEKBT6h0LRcJ6iE0LKQxyW2HIhv43QQw1L9SiuxKsg5+kQgrYpc97waRWHhXq1IwEAht@vger.kernel.org, AJvYcCXtDDYS3Kbr9Ld1bSRckKMRpcXXKmraAZr4FzOfd/BpSE3t3vFFCQmTkv3C6SU3etr08vn5t5VHpkaf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0H7E/5nH/LX+Q2FYit39KV+ro3zC8aidf4MRvpPXaY4P4U28j
	9DwramdSpfKZKgziLG0zxBbze7/Hl7sZ/+EZl/g2ESidMpn/q6yP
X-Gm-Gg: ASbGnctCHhT5XZeJ8uin+q8CvSWA7GIsXo16jt7i42BV3rEZtlmpp7K59yCglmpYsLo
	oOutuQ3bf4OaOmunusgM2z+6IZ49C2KAu1lEGhpNCf0wzwXgZnS4vaH9mlyVT+aI/V7zfq+76kY
	nTD3wx2mOP3XsJ9aXTGouz9UVEzbgFWb3+UQIBre7w2cCxHBbqBayBDyA12+GQ6jJ5L6J1rT+i2
	r56ec5Dl8kWWCpHuQYEQSQu4sBsLC0TAPMpAKuAyKeHi+ECDL3utUUEZLgWddfmkAWR1701m/Je
	WVw31BUiSlJhtvgXucvrPrtU8m3E9F+hoCE=
X-Google-Smtp-Source: AGHT+IHfuBCji2IgYL4qWKeIl+Mf4ci+4eN0PNXn0HQ2ZC/Ai+XLtuBn5UkQyieYdRDC8QxP4CcQ/Q==
X-Received: by 2002:a17:90b:51c7:b0:301:1c11:aa83 with SMTP id 98e67ed59e1d1-3087bbad714mr1651155a91.28.1744943420171;
        Thu, 17 Apr 2025 19:30:20 -0700 (PDT)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df0c14esm182185a91.19.2025.04.17.19.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 19:30:19 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: pwm: sophgo: add pwm controller for SG2044
Date: Fri, 18 Apr 2025 10:29:44 +0800
Message-ID: <20250418022948.22853-2-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418022948.22853-1-looong.bin@gmail.com>
References: <20250418022948.22853-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.49.0

