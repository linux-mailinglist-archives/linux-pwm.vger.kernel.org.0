Return-Path: <linux-pwm+bounces-5448-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AC6A85E71
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5748B188EDD2
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827352367B2;
	Fri, 11 Apr 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="DeIvUonf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9A4964E
	for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377297; cv=none; b=sgbLSGyTa0HgV0hImN/ALCKuL99BwO9NHmb+h2VRaycdh6uJ/kBNvPCJ6zcEPX5QhTUPPFufU4lxM0pnvqsgRbYfPgO9duvZr8LRAUO4nYRugHDIIOdBJ+jn9llBWEvir4SKHsnHUn8Er6ToIFzYZA36qMPWjErrBiqxbVz4ZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377297; c=relaxed/simple;
	bh=Fx2DSj48yYrVxbWj0sHoE5Kp8sSclZ5JpAzWIKIi5ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4YjDu7A0BioYbxwy4agQdy4QcChpLPvpLS4J6Q9Tz+q9Hw+KUGdQcnkJM4MRsdZGxpqkh3X7hiiDzUobbIv/kZ81uxFzssBIhgTyHXowIlSo8AsXZh3lOWxnS5A97qHqpnlvgzIgyKn0/yP1G5ZZvCJFZpdURqtAR/oBVtJe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=DeIvUonf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2264aefc45dso28214115ad.0
        for <linux-pwm@vger.kernel.org>; Fri, 11 Apr 2025 06:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744377295; x=1744982095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZ9GjvnopZqWsxEaOWAw2bgVB4e74J1JbKJhf3MqmuA=;
        b=DeIvUonf4WOFwTRUtSgscVzmRexwjwdvj7KipEtftzXoz2j/0KWHrJzd7xPDJ0wVOy
         fU3hvAIqf4TbIqttARUES3YXrD1cWy5jrKBiVoVf/MVjtQXlGB2wrtHKhLlJNDzxJj0v
         fr/jSdTKZB/15/QPpOdn2t+7gLiOi3MmN0+P4hnaBXaQ8FflDVun0ZlnOfBL1UCrjCBr
         LysRRVSPmS6oPeE5X7RG/zewvT3FmBBkHGOwtvQtqSU5QKZCpCYEjqAh7tkUJxFZ+Osu
         eI8sUhPPmyyWAgaV/1Pl3KMgcCJ6SwR+TSUBH4y7nnNDwRrGSfxjekKyK/lZtBqLNWFD
         2/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377295; x=1744982095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZ9GjvnopZqWsxEaOWAw2bgVB4e74J1JbKJhf3MqmuA=;
        b=RTTETHvhQ0l9/k6ANggC8scUTF9BbcJ9uN/vRaQgfpX57Rpte50ibb97FNrfgWkdG8
         xJWgyBHL0ZwVh/cF1oLyOYd8oFH6ihZt2Lam3WSQrmZL/rHofupkB1bdzpoe1bY0oKUJ
         FRNpgJF5dvlFJ9nciVTWRqkk9WIr+kDWvilCbaauWIBKIaWg+D7KzCUtv6z8MecFigRf
         IIMoeg8EPAfg1asO4PwDyDF3/OmS1QFXGxXJ8TtA+rv82vvKddAAJd/GjK5mgW7GlNUU
         arjkQwPr+e5sQwXNzvmrkBATzmcuIiLOLPQjn9eHdz0dACcd/ByGFuyVKNsyvJ6zrxTU
         aS9w==
X-Forwarded-Encrypted: i=1; AJvYcCXwhQJg0RLqHafMH6EC1JuwbieUow3ncM2itL6c62fRCceVxZ8ODGQA+HmrDaFBIwZfdT81p8CoGLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSplOAHCSeyN07s+wHDxxbmxVQDqZcM6duAqknrKAIkZatg3BD
	jCTsHD2tkBW0vtrpLBp898ceD6J1RzAAc/2CTPCrRBrDD+LkPyjNossCGHt1jPY=
X-Gm-Gg: ASbGncs5YO9MHLXnDqgE6C0Xvnc9c0WTQ3WR5LbEHnw0hmLlk7jENEMIqKCqt8UGHRA
	su4mYtNDL7bSFlyp9D3lq3NUg9cLK4WuSiHANxf8lkTA+lVxIEaraI/6MAkdfLaT48Ex7y7EfnA
	FH9bHcGtsMUXdXDEUIxW/wS+cn5X5IYWInVK2dpyoRM1E5ny0r0/B6XSwocKFt752ipdt8jWLDk
	TJJjLZSKRGpm0E1bvPUmstdGkfNprp3g1z9KmEhJaQG4e37Ej/BSQrNYrLfLbmxnxV9tr++XZVu
	dScK/7RxTLkGfzY65kpdNXrq+L3Alpk=
X-Google-Smtp-Source: AGHT+IFvN5I4E6ZSZP8c6xGMaFyJHcwfDhA7M7Bi4ibh+3ktU+m85bf3AQiHdiDWUBpOoQFNec0A7g==
X-Received: by 2002:a17:902:ac90:b0:224:192a:9154 with SMTP id d9443c01a7336-22bea4bd78amr30197535ad.26.1744377295221;
        Fri, 11 Apr 2025 06:14:55 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a305:4::308a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95cc6sm48245005ad.122.2025.04.11.06.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:14:54 -0700 (PDT)
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
Subject: [PATCH 1/9] dt-bindings: pwm: marvell,pxa: add optional property resets
Date: Fri, 11 Apr 2025 21:14:15 +0800
Message-ID: <20250411131423.3802611-2-guodong@riscstar.com>
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

Add an optional resets property for the Marvell PWM PXA binding.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
index 9ee1946dc2e1..9640d4b627c2 100644
--- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
@@ -31,6 +31,9 @@ properties:
   clocks:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.43.0


