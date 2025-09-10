Return-Path: <linux-pwm+bounces-7287-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD07B51D09
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Sep 2025 18:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B04484357
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Sep 2025 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4330F335BC5;
	Wed, 10 Sep 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISWcXoij"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE14334728;
	Wed, 10 Sep 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520450; cv=none; b=P0R9W/oaOwYmZR64jijxYmFtWY77sSCGUsoX4NyC7NcFVXiHxBC8cJfjQy3gLNmAXxT2haTRNzYZpWodAvr7OOqd1yEG5DR9Y1XzRMaItgLTXuEJdgb4AgRkePmknOlTVODOKTugwg07Wq7XbepFTFmlnVyj5cdo4cJdUhr+AP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520450; c=relaxed/simple;
	bh=c/8h2azJu/WsiYvzXH4zXeKaqkRGwQ+PmQr4NwBaLtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wc6MSKNH+s/GpwATnVH8d/l2ZqkkcZSv6UsUYfeM3imoRqi9+7lid9MzOpdf6dTGCLt2YEd40iP+0eqml4ITeehALGF+FFe8G5ye4MFi7wNmYlJCrqqBt4V7DCHxDcvTamcT248Ej3Ez4BgQca6RcpnC9c5Ag4V0AnociR69Q/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISWcXoij; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0787fa12e2so162557466b.2;
        Wed, 10 Sep 2025 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520446; x=1758125246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KertHcr0vg3FRzUy9iypUim8zaBvNKNkX0ui3kHw5pQ=;
        b=ISWcXoijK7KzSBPCDYg/f/7s3lCs+COo6R6+eRiVUHixXGmcbEcj5yprlQzkdrgzFQ
         6NFwFLEMP6mdmL4wrll50pHRt1VPiNcb6QnQaOkJBNcveqPO4pVivOjjpqEvrQbK5QJa
         MzQ3xAbMISvn+yGsboGaackVC/sQ1N7dRxE/egcsPZlDJIbCxiy+VIV7/wetKVE6EzxV
         /9M5SgK0FgvoIi8ofi1absEER5YUlMA/dvBWxDZS2ekqJKm5gVhLWtqL8Eld2OpqMJO8
         9pBaRlLkh8cON9gAgBZrZIzy7QxqVqX1HM419I1lXrk+3Z6yno6zmn1ctVy0T43IinKr
         GyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520446; x=1758125246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KertHcr0vg3FRzUy9iypUim8zaBvNKNkX0ui3kHw5pQ=;
        b=X0dl8tKyzI5mSrG61GfKc6hwcisWo4AtcISuU14vRkYn0l1Z8MKNE0+qcmheHFyhE2
         vZOx4MAuSNXcTenijzz1qTIu6sA3fT8DR/aWTMdjRskZQMOnFcEdnroiDa7t2x/aLCoR
         TDskUEGiTwdofo2kIcKPwTnI7+sKvZZnZy6hL5M6YmZkTiic9o5DI7+Jc3jaGRNCepKW
         JfUpEBLN2yLxBHc3UTCjsXWN2mnH75aDOrQ+xfdmq/z+5LdiZjoShxw33NrINXppW9Zq
         o/ahppz4aleMce81Uf/WlQot81JnyC5b9/cyo64VIzRJsh7fG4Pfihp2S0YQGQA38rEt
         QUBg==
X-Forwarded-Encrypted: i=1; AJvYcCVbUiaHJSYRoMynjvMz+H0xro+e/HNFrjFCOl5km9zl0o0iUpZnKgeR78pWqn+75cxECxn+ufZP/UOh@vger.kernel.org, AJvYcCWILUXecFyzvVyYi+1WI7q10GJGkgtGG9BpO6y/2Z2h06gFw3eZf9zxmAn43+9K0BNX9YvUkqApJBWlKA==@vger.kernel.org, AJvYcCWP6JkrHQHWHGHdstfEszMlXUUa6MUrUBnt7wE1pOpRxpQyXzJVoTBCEtIphi5xsDVFXcEHSdUSWUYl@vger.kernel.org, AJvYcCXReczuaakE2LtS1+6Vbs56llCBGSrwRrjuzwVY/BYo4uobKRTc78n/jCkj1CjarCua6JqhOeqJlA5rWsmT@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaiRT54cXIknURsAfKFTppfYx4RBXdYz/KWMQ83xatB4e6UXQ
	xt/eW7gQZhKSaFXTRbHRisuvKpo4jx8pod/Uwx47uWxy7hLT+74K7SQ=
X-Gm-Gg: ASbGncsNqERn6SzV7MRE4N6k8yx8SXtt5kq3QI6l/fT8OTmAaI9VEclgjQx2QyBH9tm
	Jx5nRbXzdaQQi9r4JHEgK7E3O9AperyH9vb0xpo/624gfpGPMsvfXOfVDXCbod2CGxG0kwHsBcU
	cnbYyVXmpuI0qNVQui3V+yg0UeuDzKmvj2lUNGDep4ybW6k2PjOYM+v+b6k8KxOuSRl3ZdcvvEA
	UM+GFjZMc/c88rUHD4wh9/AutbnzicVXgPaB1KiXtn5k5JfBVX36mLIoffGS05flala7mhQtDim
	f83kmsuyaK2oNKkh9zvWx8OhJqG1ZYCrSWeT2hAAzfOoNpU2bHF6+h6MiQzNjaQq6vC+gfOCBAv
	CmsY+UZPNb08Y68g4pflYwtoh9OJm0g7g1QiO7h2tHexmf2f04t3sWrOG
X-Google-Smtp-Source: AGHT+IHSheORl2GHnUvjsTS7VlFMfxi7eNSdgF3Jj2iFYS2eECdvZVErbADCuyyklKtmXNn2yod6Lg==
X-Received: by 2002:a17:907:a07:b0:b04:67f3:890f with SMTP id a640c23a62f3a-b04b166c8afmr1542164566b.33.1757520445531;
        Wed, 10 Sep 2025 09:07:25 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:229f:d114:32a:5671:8dbf:7357])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783047b9bsm189424766b.13.2025.09.10.09.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:07:25 -0700 (PDT)
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
Subject: [PATCH v7 3/3] ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible
Date: Wed, 10 Sep 2025 18:07:04 +0200
Message-Id: <20250910160704.115565-4-jihed.chaibi.dev@gmail.com>
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

The "ti,twl4030-power-n900" compatible string is obsolete and is not
supported by any in-kernel driver. Currently, the kernel falls back to
the second entry, "ti,twl4030-power-idle-osc-off", to bind a driver to
this node.

Make this fallback explicit by removing the obsolete board-specific
compatible. This preserves the existing functionality while making the
DTS compliant with the new, stricter 'ti,twl.yaml' binding.

Fixes: daebabd578647 ("mfd: twl4030-power: Fix PM idle pin configuration to not conflict with regulators")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v7:
 - No changes.

Changes in v6:
 - This patch was added in this version
---
 arch/arm/boot/dts/ti/omap/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-n900.dts b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
index c50ca572d1b9..7db73d9bed9e 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n900.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
@@ -508,7 +508,7 @@ twl_audio: audio {
 	};
 
 	twl_power: power {
-		compatible = "ti,twl4030-power-n900", "ti,twl4030-power-idle-osc-off";
+		compatible = "ti,twl4030-power-idle-osc-off";
 		ti,use_poweroff;
 	};
 };
-- 
2.39.5


