Return-Path: <linux-pwm+bounces-7286-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E4B51D18
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Sep 2025 18:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F3258041A
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Sep 2025 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA3334702;
	Wed, 10 Sep 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIPy5i3U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8983314AC;
	Wed, 10 Sep 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520448; cv=none; b=H5ZqTvvVGo6rYA2EJk7INqDEJHXR+bjqZG9Wvlz/sl/KIgPUCfRJfisJKIp8NhU4lrfkkkbnbqbkrmQnxO1gCuZXJLKjoR2LugcBAWc4kYjJl2KWpE67ngprmxnNo6YbVS11Hv54kDu7OMKOjVJR4hg3hOOGCVED4UkuVVCwPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520448; c=relaxed/simple;
	bh=+9hjrLDc5j5SA8EeENWm1vbseEJFu7AzWTzFjv6npRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D4jc1Y/57gTJNx4oUhRi9fCfqFYECjaH1V8+qyibqPdXaoSVXf3JLHYoppILLhHIr6rih7sK1qXXmjdVZsX7dH63GFDCEcsKIPgtY+NuaYU7TPHEhL0MXYHbMPIJPFtZSv4OW/Bc5je/Xb60zk25zeL9WG6dWzr9KJliaLtuzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIPy5i3U; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b042cc39551so1254636066b.0;
        Wed, 10 Sep 2025 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520444; x=1758125244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLTAGNUvI0OGqTMLT/mwD7B5nqp1pTDVYUJmnCD7zYE=;
        b=XIPy5i3UqixX5eqaYoT4vcK0pkVa6td3A1SHSd2vrFHZYQFhyXbRtSFQjeuiZT2Uul
         omJXJTm3nFSXrSUZHNYYQDW7+rGZMT216A71Xb4RA9UkV3oYJHHrlNNMQCXtmqPCuYRX
         aPVx5donfEynp5i3Wjw47RaaSpmOY/FMXK2ITUFtdVVXlXe2iBshxKqmvpVJ9Wm1EWPM
         E/yegSjTY+OANxSuXcXtY0QvQVXgFKdsxH7nH2vcjsI1RWPgKjMDjr4h3ggt7Tmn+gsa
         +6KNrYMmBx6UbkMlinrHXfdXpk7H5U9P3qTsB0GnbSOTLetHy0fG/S99lBEdcrJRqZYX
         Xi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520444; x=1758125244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLTAGNUvI0OGqTMLT/mwD7B5nqp1pTDVYUJmnCD7zYE=;
        b=l4OHRr2TAWHUwxAk3J7W3KFd8UJUkBa/ga3M3FQEjiHlZzJ/fYH8zqEx0mJVbePHUj
         X3T5KXZp1c/wWs6YJAoRc4c/tp863xkREhdFcgo7MbbeymHIT7Wp4gJlP+eib5NVy6h3
         AO7UwDHmUMNrZS6+SjckIkQqe2PoK7YchzOCrwBRwjRSvpfdkB0FS6jeGOammMTkn8Ct
         VS2u1CZjeMPrTSq1SQ5m9XbsJj/UrsHGhwlzs58xUSHk4JNQDmnKuL/39kWMSC4gvXtQ
         Rp53tLCOyhZLWLIM/LnpBP3+5Dr4eTY0ScH68SHf0Psz7t86lgb2Y0CRPYrgNIwUHGF3
         1dQw==
X-Forwarded-Encrypted: i=1; AJvYcCV9bINvti8+95VpuX8fVBVLl+qnIPXOZxcs1NwnpOV8S7EDJh6EK4sWjEytwn2wql7e/COwGBqhT/yU@vger.kernel.org, AJvYcCVBjA94WpWXuL4qkIigMvsvmO800iyrqfT2y77f5VfL74+MXFVNUHnC6mQuI/QT5IfSq46/zr63lgrB@vger.kernel.org, AJvYcCWQ0qbIfOLogigANwMm4Ya697oA364wNXrQHxfT6iaqgBFEUd98gkcg5gLZkQgK0XkwT1mmSaecMQCQqA==@vger.kernel.org, AJvYcCWoEUl0ekS5MMKf4m4CigV0KjR1JsM0/9UOiBDLKeNR+YCCRzBeVLRNxWMZ/7/zqLK6KQ6HOwJoucIKse52@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIC78iuRGAMhM021fvbWuIrc0td+yPLb4SpMvnj1A5sbcW8OK
	rWlN8HMwVpRMKG5BS5LZcSIuqFBaIV30c1O3FHG/wTb4qG8WBBd4UUM=
X-Gm-Gg: ASbGnctdWmfNU5TsfNxMmuFpySWHu8Eqz7yNgReoJnhSary/EXNqi1OavItB4J24cIb
	uu/rLCHKGpY6n1nFWNCLYv96pHKqyz2f8BF0/B7tmFUbFk+69m9uzrgN9NUTI2QixXmyYYGd4Hv
	5pohrnmMSSm6oTAaIsxde+C13SmQ36FWYn4ZtIQauDFyWtKM7oUS76tkB139KXSbQp8oBxlu0SN
	DElPy/szpGahqQFkhCQjnY9EnkcIW1yV1D9xrV253hZslCQ3gc9d2JKRBUzbDdbzJgMoFzr2iWD
	o8HoGVU2IyykN1KYvXsEySDXkOFMlCS+xM6w+7m8uXtCOrYzwgcJGesM8A6Dr4GL/07J9hXNIJI
	72NiDA0pCqlaVE/ZglcZ+wqTLLmjdbb/iLLgzUytvMXg9+UfRKyfon0/+
X-Google-Smtp-Source: AGHT+IEVvxEKhGMHJEfd1JkOq1cszha3E0xYLDV0xFtrQ3fD8zFWAlrtUxqtKd7UCQoZHTjuZMHAGQ==
X-Received: by 2002:a17:906:b790:b0:b04:b94f:6915 with SMTP id a640c23a62f3a-b04b94f7824mr1395671166b.11.1757520444216;
        Wed, 10 Sep 2025 09:07:24 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:229f:d114:32a:5671:8dbf:7357])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783047b9bsm189424766b.13.2025.09.10.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:07:23 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: andreas@kemnade.info
Cc: lee@kernel.org,
	krzk+dt@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v7 2/3] ARM: dts: omap3: beagle-xm: Correct obsolete TWL4030 power compatible
Date: Wed, 10 Sep 2025 18:07:03 +0200
Message-Id: <20250910160704.115565-3-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
References: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "ti,twl4030-power-beagleboard-xm" compatible string is obsolete and
is not supported by any in-kernel driver. Currently, the kernel falls
back to the second entry, "ti,twl4030-power-idle-osc-off", to bind a
driver to this node.

Make this fallback explicit by removing the obsolete board-specific
compatible. This preserves the existing functionality while making the
DTS compliant with the new, stricter 'ti,twl.yaml' binding.

Fixes: 9188883fd66e9 ("ARM: dts: Enable twl4030 off-idle configuration for selected omaps")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v7:
 - No changes.

Changes in v6:
 - This patch was added in this version
---
 arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts b/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts
index 08ee0f8ea68f..71b39a923d37 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts
@@ -291,7 +291,7 @@ codec {
 		};
 
 		twl_power: power {
-			compatible = "ti,twl4030-power-beagleboard-xm", "ti,twl4030-power-idle-osc-off";
+			compatible = "ti,twl4030-power-idle-osc-off";
 			ti,use_poweroff;
 		};
 	};
-- 
2.39.5


