Return-Path: <linux-pwm+bounces-7314-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB6DB56B93
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Sep 2025 21:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6EC16C68C
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Sep 2025 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36512DAFA4;
	Sun, 14 Sep 2025 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4V9BjNL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6132DECB7
	for <linux-pwm@vger.kernel.org>; Sun, 14 Sep 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757877976; cv=none; b=SGQKW5Rq37HNEazK1qxr6zgc88NJLCs/1fcrp4Sti9oL10Qom/wCJcnTfj4IBdnjoB486nHtVMCJfzDyL4+3aFC2EHk95IkUfg0fuCbfvo2YeIwZfo8gnh/4c5/VJlhBtpVMiToCbWTJyEXleb4vwnMsHYw0RRaFqOuLW2c7Sf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757877976; c=relaxed/simple;
	bh=Bwvc4rU78HriKtF+dQxnrLeZu3hmtBcOywpMflC+wr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LppO2D1Z4c/6Oesg2Xpnj/6bfgQQE/ejX4TZLGdOedW14Kgw3CHM4oXMCK5IXwoy7+3k+CM0EK0z6e1ygDf5VYNhX/gg+dZX6DejUOEyGib3zUs0utLIYtvsjZJdihNG4wCxpdOLFXiUU+GG7b0faBV7cPvPSM8cGeuqTJhFRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4V9BjNL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so532125366b.3
        for <linux-pwm@vger.kernel.org>; Sun, 14 Sep 2025 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757877973; x=1758482773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tWORggu1OBca7WXmFFjWgrVVhHzQJbGxIik7S26mM0=;
        b=l4V9BjNLhZlpd4omsZNmvmgPSoNxOTVQxMXjz9UqBAyP15KYGyQO9FMvuAcGQteykF
         +AF4f+CdDZXwh/Acgp8/Nrn8uo+fsnlgzaPeJ1uHSqwH+p4WUfefRZSi0g7Gr/2qprjJ
         tUcWfxvywzLNSmd0sU6GHJ6avOmsoV2ItaMd5OZPYYJS3mseXWR0HFnPHSz3c+ol97Gj
         Q2mZnRvge2qrSvtNuqixXrrv3ZxFg/S20HIIprZGCBwjBnVT29rN1byQCBFPjSEMS74L
         I17zTqpY5enWVa83cFhvwVny9zCiiRpNagHonBGep/olBISvgFP8vfA00xFGw6LmHIBb
         AEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757877973; x=1758482773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tWORggu1OBca7WXmFFjWgrVVhHzQJbGxIik7S26mM0=;
        b=nDrPht+QAliRwfPa9FjtX7a0/naGaEW3JRoaW92o7siXzAddyWLYUmMuQYjM6SoQFj
         Uz1B2RKMtBvserwb8smIXGSE7xDJRKwcVCPOw+lXuIiqaM3ImMMUveTyiXHdA//p5uMo
         SZL8ZzSQkGQvH4aVDsej/O3FMdoKcrTo2vFpU6ZVud6NA+krxE5Zi1zO3KRZ+X/bNET8
         CUrPLTvtsUjGeyk9GaxJ6Mn/RpTVvuvbgdiCPwnZcR1iK1L3ErMe8SL6XJwVxua4Fyvt
         IRQMUDoFga1uNN4DxQoLYj/G6l+i9YxZvCaEtU+/EgxHjnVmNynNxDnlwq5jaM2219Qt
         kOFg==
X-Forwarded-Encrypted: i=1; AJvYcCXkYoDQLA96fQMkd2/qSJh3ZZ55nVL0P4dmy6jyKJfCEToVCyOVEgUzpIyo1amEY/h/fSCByYDfxUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIjxqng4gD3egfH8PaHnmS/DSjODqUYxDqv1UOJLfud9CWl/lm
	aGuQZ9VlbI3cN1y7fCLquqa7yH3HQRUUAPPKEPGuKzhslEZwm9LoWlU=
X-Gm-Gg: ASbGncvp2U8h380chULR1NQ/BOnoHWJmHkLCzGloGwd9FmbaP34LqoMcyQfW8lQdkPk
	lYadn04DLZtwleNAQh/js3Dlmq0qo4ewFawhbhg/WUPQawYjEJ7rcHhbsSknlIdoE6jQhRlVynZ
	TfvOe5J6I5AzURXDDrH6yKKh/adqKJww1k/br26DBV1+NwqBWfSFu6dLktkGaJiB0KLVi6Ajpub
	rLZZrGPmlQU7Qj2Hqf2O7dFVePGm7RGpjDxzvGY8fRUctB1z23W5szArvMJ1f+t3oe8hg5Z+Qh2
	bvQPiJ5CWlQvnxQMjrR0QiPoXGzhy21eQwKheUE7iWo1qY9c3jUvaGNqVSxF/EgCvoZcDMtnmx4
	AG5oGtvJLvzApWpyHVIVjJX5qrb0NCbOYxWG3rQP7vG9JOXF7Zr+shI7nnQ==
X-Google-Smtp-Source: AGHT+IFol1c2OgKrSsYSL0V4fY6x5qf+hsaS07Lg5SpcRo2Kco6q28gBupc4uxTJENFANQGaH+5BLA==
X-Received: by 2002:a17:907:6d0a:b0:aff:fe6:78f0 with SMTP id a640c23a62f3a-b07c3a65e38mr1054189466b.54.1757877972891;
        Sun, 14 Sep 2025 12:26:12 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:226e:7d72:f695:46fd:3aef:7487])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07baf35488sm707841066b.38.2025.09.14.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 12:26:12 -0700 (PDT)
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
Subject: [PATCH v8 3/3] ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible
Date: Sun, 14 Sep 2025 21:25:16 +0200
Message-Id: <20250914192516.164629-4-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
References: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
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
Changes in v8:
 - No changes.

Changes in v7:
 - No changes.

Changes in v6:
 - This patch was added in this version
---
 arch/arm/boot/dts/ti/omap/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-n900.dts b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
index c50ca572d1b..7db73d9bed9 100644
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


