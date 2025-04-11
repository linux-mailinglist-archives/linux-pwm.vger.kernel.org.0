Return-Path: <linux-pwm+bounces-5455-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2398EA85EA2
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FA91BA77DB
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2413774D;
	Fri, 11 Apr 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="t4i04Luk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C821A0706
	for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377400; cv=none; b=Hpsw50MVAQ/PibABmvU+RZi516umPdKc4FagZ1bQEVBqOKN/CmiEH22SyyvYMOvv7O483NBzrfYSZRGHd4JocZlJUD1NL9GL3YMvnPGHsCt1Ws41DjcTbMoKH/uf9VRzjfL4faasJ3vKmG9gclVe7gO2lxwCvx/3IUrC04z49ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377400; c=relaxed/simple;
	bh=6n3VL3xR2NW+WiuR1BgpROds4O7/ouFUZ1fFJBmsbDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pym0zQQtl4Apk29R3D387Uk9TlT442zYEvovaw1fzMg5cCZsZYa9DOwGz9i3XEGxzCGig8QGSuQb3M16EchVd66tIY5n07YvjUaHzB40Fl/wb46FkhJoPvFIA6xTPMXkJDe+BNF7JGwudmv8rxB/cP10yf3H62cbqMNMEbJvK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=t4i04Luk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2295d78b45cso27377755ad.0
        for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 06:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744377398; x=1744982198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63RGI1NwLEiYAeH/RFKeArdRDE2NQgX8WQsa8ntLKY4=;
        b=t4i04LukFjjq2+Jq+254ANtrKvTCGKzpLQxQt7IREewSH882ZSOJCRnybPm7A+oVJc
         z8RX2SuHnQddm3FI+tmDM2EnJSRq5QhFqlsqI/QQRBEXjFwg7d2H6kVfkHgodyTbASaN
         Y42s9k/hzpyNcOO4m8xcJAGRcVI6hMlPSOXfu09Cbs+/tDxMmixK/qcYaiAa01HCDY9g
         yduSO0Q5tfHgeZKEO0zSGm/8DA8zQ5Ma7qdY9DoPRCMOX9shwdQDq5dQb4fP5cSRh4k5
         WfG9WRE8qPFlqAFrOlRPNta0Qh58SvtlLY8RuvVuUsNnOn3Jw1lqRXkMaUjbBkdPZ6wZ
         f5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377398; x=1744982198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63RGI1NwLEiYAeH/RFKeArdRDE2NQgX8WQsa8ntLKY4=;
        b=EpeLhzB4/T23pyIuX3+fcOTq2b1sm4j5hvztRZK2DNEkD5Ltjm4ck+jatckEY9WBS0
         LydZQuwE7O6iPCeibSvy64ztZFs6crPdg+E1WwznzM4ZJe85unBLbYjDaYEpwsWGmjeZ
         26pZ3E+7sA0iZa59A1dMLzG3icjUNHmo5ZpgC60pX/r4lcMBuS8sITmcGcUeY73/kN6B
         +dYAJ1Ag45A6FjSvfm5DdBK/mgvOJhsJ9GaJZe5xEfZDzUE1LXw0219W5rpV/9/Ks0Re
         rOGJvGh3fuUmvogXc6eH8i8Tgew5y1zRcDt6R4tMsiOhVlUmmFc/3Ul4j+rJkddQsRyz
         4Row==
X-Forwarded-Encrypted: i=1; AJvYcCX8oCGJDz89cBANg+q5Qh/wu1eUemyPToTNih0LssOPhhrrozI/kIhdAuusRxpGFrcbJV6A7MRDTd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLQVR/MhxWZfAeffmk1Yu2uhhMW22l1N+lcDxhUojVfQqpL0q
	vF/8EqDvI9Tu9bLmcGQUyMXt5hBxJaFUsSsFNZkcDPiaSyAhBAQL64X4/5N/GFI=
X-Gm-Gg: ASbGnctz6xzlIz1I5/gCGUWXaS5N6KCCvwu5riPvB8+Hkk9GToRCWe/WLLyKojqPZ1r
	uyWityfvKcnpKog5vo9lbZyfauv9yQLZAIZqfss28uuScDUa7H6cSDxVUiyJ+VHzo+EQ/7d6th8
	Ub6Jo39bJEuCyDZWVV9VuXAGItJuBjx2BnrJbgvSRR0aLhbniOCi6INJeoBpsOgDVD+JxT+ljZq
	ydgcH6thKC8jzereGf18Dh3v9uYg9xdVri8GZfkkM6K8NBvRM8mHrGgjNwsUrffyGjygTFDyySB
	2Fvd5BIQxU8DbAX+SZZw2Kdjbp6adbQ=
X-Google-Smtp-Source: AGHT+IGdBpii9FqwXTM5hJBzhslBNKfg5Cs2FGnvGr9Q17Wy0FzzwX5fnWry21A6oGkbvSxeOYahLg==
X-Received: by 2002:a17:902:db0d:b0:223:6180:1bf7 with SMTP id d9443c01a7336-22bea4ffb4cmr33239005ad.42.1744377398297;
        Fri, 11 Apr 2025 06:16:38 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a305:4::308a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95cc6sm48245005ad.122.2025.04.11.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:16:37 -0700 (PDT)
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
Subject: [PATCH 8/9] pwm: Kconfig: add depends on ARCH_SPACEMIT to PWM_PXA
Date: Fri, 11 Apr 2025 21:14:22 +0800
Message-ID: <20250411131423.3802611-9-guodong@riscstar.com>
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

The SpacemiT K1 SoC uses PWM_PXA driver.

Update the Kconfig file for the PWM_PXA driver to allow
the SpacemiT K1 SoC to use it.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4731d5b90d7e..6731669e724e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -493,7 +493,7 @@ config PWM_PCA9685
 
 config PWM_PXA
 	tristate "PXA PWM support"
-	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
+	depends on ARCH_PXA || ARCH_MMP || ARCH_SPACEMIT || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for PXA.
-- 
2.43.0


