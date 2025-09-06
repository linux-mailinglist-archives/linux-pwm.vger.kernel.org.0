Return-Path: <linux-pwm+bounces-7259-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955D9B471AA
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Sep 2025 17:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D943B0C97
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Sep 2025 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB20283FC5;
	Sat,  6 Sep 2025 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox2Wdz0M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38A1EFF9B;
	Sat,  6 Sep 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757170804; cv=none; b=IBlSOwgUTIvV4nFiE2w6JpkBUO68FPocUJN1YoA+kWKsvkUoQpCU+V5pADn9Ynh6TYbwYyvGYyW8kf8Q0AVKeaYVBYcuLRipNNDtfpiK2SNbFUKOgZhFx6a5tGH4wjK5JXgQ4NuZEMyLgg5Zt1fEzC9Pt2+u1gd7Urbl6gQwa6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757170804; c=relaxed/simple;
	bh=7UeMvLwpAew5MAx9C4StjUQqN7oi5NCczl9I7bCnAUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYOLWxHHJJelykJeamwYU/X1SDMpuB35RLl6j/zpzcr404AP8zuMcC8h7Dhq6yheVtwi+gk30Y5XueDjvXX+jQWDbA1l9+SEImPkV0Q46owOCvOf+aCm6DvVDK0rUh19x8ao4Pp2ZEY1JKFWqH5sROBQnKcNKiOsnbdrZ3k28qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox2Wdz0M; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dea538b826so2471895f8f.2;
        Sat, 06 Sep 2025 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757170800; x=1757775600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW2lxnA9uh15sKI4ePh3Ix0OTOlEvYZrh5mCm6v3jEY=;
        b=Ox2Wdz0M5yup/+psrB0DYVcKp9hnK8w7T69ZM093GO90x2VnZssuCw2/EBM+Co8wTS
         IGyN3lT/MQ+58IfOqb/WKPTeo97tmmQYz0394RK7+tdS+0B1/PU8hM4HrJts1gR5f1Fe
         CUg5x8cZqJXxWAlJ4Cya2W+z7l3qzxFvG1DSaxUUTveivRyRHSK6SXCMGTNm0o5PURHq
         Bjmps4PVpyvXbAkDdDgYs8iNUTuqzv/oftNuELX+ykpG3mlHS/NNq2xuOBO3QAkhW7L+
         NP8v24I7sceBP7UYrR3hPNvAdqECqbLjqhXouIoE6S3062gUE6ySMaNao1nAtTpSc4zs
         bpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757170800; x=1757775600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW2lxnA9uh15sKI4ePh3Ix0OTOlEvYZrh5mCm6v3jEY=;
        b=fGb+c4vZ2QHwBYTAy+SDIjp49tnpcbk+9ZNYEYH2rKCeQfpN2KowJuwRejY6aYM2Yb
         P/z5uekQRiYD6OBkhyD9uIKi/rvijJyNM0Fu6LIm/4oyxmaG4zmd3x6r7TkAP8NRAkFV
         iIOe0hgyDwWiQmd+k+SZ8QSRTCYw1zqYmIZXJ1va6l7zRU2AnEZH0Z5CeqTViqw+6Kmz
         /moME5lXspg69uAJEfSoq8gvEZomNPzEamFKQ+rVeTf2TbTlcBo4za4Mg6iTgq+ggY41
         Bmzqmn3KBtMG2xcaRqSko/yCnwPNIykM2iN7H86FnuPOCIBmYvFpJ8u609uiePE7/98F
         G/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUFXZAlVeNiYO5e5vnz6ZL7Osh5HyYOj4yKJuCinaAoLhS1cG4D/QdSLkO3RYd6Ag+KXkbivVRBjhHh@vger.kernel.org, AJvYcCUp2/bN9pbEnQubnWaLPyD+J2+nXRZWJZ6Z2+VMCuT2n3hhdMVKegRQEYET5Gfp5G7UQ8GDABKXlDMlxcWV@vger.kernel.org, AJvYcCXmgKfhdKSVcOZYqM8Et/KFhZ3dnpPQ0kyc/If6lGJdAI435jAPGsK51AUbCX/0hHPMW48gdaNL6PmFDw==@vger.kernel.org, AJvYcCXow1VxzYy+AsJigyOBocZBRutAtW63z8g8lYCnWsXdZnc9tAo4xFFKQ/gCWzuuL8eHuYvSXM9OzDb4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8lax25NpF68iuPHWe/fKy+xr1Jf+lHLoQAax121hGOk3LsWTm
	IyeTBADkAVQAjlwItCJhve5pX7kpm9MYUac2OZiSmVxswuZmLFg9gvSXC+El3FI=
X-Gm-Gg: ASbGncuzrRS7IWLiucl/kWXJPTBDmvhUmDBw/u/PrTQrBbNpbT/uxQ3BQUbhIqCv+Px
	gSQbKB8qNr1jZ8pdiHCngy9pkdOq1x8p5nUcfewQG7dsVMA4qljW/eSmtcc5rB/IjIXDgAOOHbg
	HWIk1SvSv7ORt3Nk6htZPHItS8QRdfCa4mciXhDFEsUZ00l27UlC9m/ljjV4usxg47o7ThNQrXB
	qDBGDDO1WOo6VnPSf4qwvhvZAEuDzCxuijPdNvzVW4xiZwjwDN0Y6FdnMs595yodZockdhHTl4L
	OWvNoslyCxG/YZgu8rglzKjJYmuYc1i9gu8hvHHnGYj0ZmddL5WmZC4oX7iwMwMSat+s0J4UhJN
	Ku2R9FNry0D+9NEpsUB7owP91fVUpIZOFMB8vFtWvYeTb504sVJpF8cDrxg==
X-Google-Smtp-Source: AGHT+IHbuka9H6DhDCICy8XnMwGTi1B73EEYNvZMNyjZhLgz5u2ikmDitlF8WeWl1ejVslYWXJdfAQ==
X-Received: by 2002:a05:6000:2312:b0:3d5:d5ea:38d5 with SMTP id ffacd0b85a97d-3e642cadd84mr1948970f8f.25.1757170800128;
        Sat, 06 Sep 2025 08:00:00 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:143f:cf9:d8da:f38a:fb6d:ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm35106544f8f.50.2025.09.06.07.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 07:59:59 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: robh@kernel.org,
	andreas@kemnade.info
Cc: lee@kernel.org,
	krzk+dt@kernel.org,
	tony@atomide.com,
	conor+dt@kernel.org,
	ukleinek@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-omap@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v6 2/3] ARM: dts: omap3: beagle-xm: Correct obsolete TWL4030 power compatible
Date: Sat,  6 Sep 2025 16:59:04 +0200
Message-Id: <20250906145905.93845-3-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250906145905.93845-1-jihed.chaibi.dev@gmail.com>
References: <20250906145905.93845-1-jihed.chaibi.dev@gmail.com>
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
Changes in v6:
 - This patch was added in this version
---
 arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts b/arch/arm/boot/dts/ti/omap/omap3-beagle-xm.dts
index 08ee0f8ea68..71b39a923d3 100644
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


