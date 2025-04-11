Return-Path: <linux-pwm+bounces-5450-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2320FA85E80
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 15:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07284464F44
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966D21885A1;
	Fri, 11 Apr 2025 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ezFwS2pD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0042AE99
	for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377332; cv=none; b=Lkr5npbz3vojQH8F3CV6Gv5KxKHq5I0xwHW37GCWcMBsYWHnk19uxTA1jDmavuGocASaPDnFDkxVzBVoCs/oBt6Mh14MJ8dtMvgxggYnKI7dUoJZE6RLARUmbakac6YxDY5BGYRQR0ayg9KiG+yT8ERxuh+qX2BvMXHC2Vsr1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377332; c=relaxed/simple;
	bh=1swIy7rxFEZEpzVbtoG003Ve9GvpHlafYnb4ccnIdDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK2m48MdPZbG+SbuJVWOdBc2ReOJk7XYITveiJX5BjuOYqWv1dktizmJxfySd5RBrXteL2PRVC4Mn5vwJ4R3Pcc3D1NUGJIL5kjH/3+npAXXBMF2WrEr7dpEgNneL08sw/VprjhXg/pFeny+QuV7fS60iY0qgTgj4I6rzO9Hg+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ezFwS2pD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227aaa82fafso15893975ad.2
        for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744377329; x=1744982129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/PuzfNro6+y5gilkjTT2xRfkKu3sAMB/YAOWIAOfRU=;
        b=ezFwS2pDzDzWZIZh3ySYop5umZohIo3OIWo8pbiIKCMWM97e7RM/sd5lMOAXJhMapi
         QPm4GaZ9ih4wi4wFxvizSsA/Wph/7Q/kESaUxUG23Wfl74/cVk8baBiJkFBMlCuH1rw2
         nxGQoqGmBWzB8iv7w8l7veDd6ZGwR0eXB0sJVjRF5R/IQT3jOcyc/trvyhfezx91sqaG
         F89IKrfv3A9iD8NyYXcJq7n7cS/2Vup3poDiqsu/bIZ0gCegMi+uH07KJZ/jojxRt/OD
         NFArmOFxfyPa9QBIpmpjhrTDCL8AyywWO72UbtL0az5+XSHuFYYUqlFwjVrXIfWBGA9w
         NPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377329; x=1744982129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/PuzfNro6+y5gilkjTT2xRfkKu3sAMB/YAOWIAOfRU=;
        b=uTm0LauvR+n55tkNhSkEEUclaUAZAVd31DI6S3lTEa4f4ntw93055b3d3H4H2gidfx
         tK0ZekbWo4qcun0Tn4z/o4hSyaEFSEiwrcefR5jQo+q5p38A7iMiuS9/Xnt4Fa00Bws0
         cZOJZsv0s7VeT/7J6WeNFN1Oru/ZasdPJkwNc2UmytUzbAFDzmexpWVQYOmunILNxL9u
         5wYDNg6nhI3D/AQrGPLnC2K1b9K/3Wq+cuOrmgGXpNmeRRr8eL86nQGxdQn46Zd13aqH
         dkfM5728Y/lzVQbBhphzKuI8V4XSYySM6kEY9XWMDUBxecxxQ57O1F7RzhEVnBQ8Yi0S
         F22A==
X-Forwarded-Encrypted: i=1; AJvYcCVsVrPi/2VTvfo6Jf8MbHPa13qd3nUeBRqyHH0aZqYsEbfcXI/8HNwNMETZhMbRa7pcQa7sq/DOzbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycs0W06LRpmK0XEURlupHTUFIGAjIX4hmGA8QnnsWx9Q9xpIr3
	K8RSx1ZfSnF8A4zQmb7s8w06C2xe6t3Id2BR3EmEisVVRMSrhHFi7oSyNzA4DtY=
X-Gm-Gg: ASbGncswxPdj/dNLLjxPAgursQRqel49Htom0VELH9TElJ4ylNIW1QYAqEXx9Z7+6YS
	DGcxknJv7XMozsSv2hto81+uGsk/HlEObDHMPk7exLTr9thJi3JWJ9zCAclpGaUoEcvZJvXEJ6n
	ZStA08KgEC4ltaPVMk9MK8CFj6iN0XEzx0Q275jcGVzCoo3P05dh1EPVMCCf1Zw37eX8bFGWuhf
	MwzeVqEBmK8gAuc/fhpUx15PrtIPisZknQMzzlkfpLZ2n08NLlvefq8gb4X0TdlDjN8OdmvxdhV
	a++iWhXG1/JFcGMpzt1dZGMWdAKcngk=
X-Google-Smtp-Source: AGHT+IHitAgPlQRhs5N+Pq3jnUrMsP733j1aryRrbpuBG1bREkPzJLptIcFojxxM3RnqxYYr08nnJw==
X-Received: by 2002:a17:903:41c3:b0:223:60ce:2451 with SMTP id d9443c01a7336-22bea4adea2mr41309915ad.15.1744377329094;
        Fri, 11 Apr 2025 06:15:29 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a305:4::308a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95cc6sm48245005ad.122.2025.04.11.06.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:15:28 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	heylenay@4d2.org,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 3/9] dt-bindings: pwm: marvell,pxa: add support to spacemit K1
Date: Fri, 11 Apr 2025 21:14:17 +0800
Message-ID: <20250411131423.3802611-4-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411131423.3802611-1-guodong@riscstar.com>
References: <20250411131423.3802611-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "spacemit,k1-pwm" as a compatible string to support the PWM
controller on the SpacemiT K1 platform.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
index 9640d4b627c2..1e3cabf6a89a 100644
--- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
@@ -19,6 +19,7 @@ properties:
       - marvell,pxa270-pwm
       - marvell,pxa168-pwm
       - marvell,pxa910-pwm
+      - spacemit,k1-pwm
 
   reg:
     # Length should be 0x10
-- 
2.43.0


