Return-Path: <linux-pwm+bounces-7260-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3456B471A8
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Sep 2025 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4C7581625
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Sep 2025 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100312C11F0;
	Sat,  6 Sep 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOo1/vM/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B2277C90;
	Sat,  6 Sep 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757170804; cv=none; b=S9rqOhntYfWh7Ig3b97QqRDgnRbOX3vg6ekxRGCbJ+mL+Q0i74ToyNcbXKVsAglrdDZEttc2Ax4O1wbI8Kv59EiL6PH6q+FEr9Y37HJ8ZNj8i+4c5aqw2iu8FUN663bwjbKLM/g9l0JbNgmAjF7OiTvT63DFIgggDtXRFPQtWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757170804; c=relaxed/simple;
	bh=PtR1bvFj895j2XEu618br+oRUVaTipfK6VlIJI11CJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHjm4cedC2fggwHk3jVcUDeXBBXPwQXjvmIVw08iK0JJWgcOS7JHChTz7v2BGyaLPahwMBOcFBq4aDyO/5SSvoecxpKe5q99fa/p53ycuH3xuB10QMBqHr6T2Yl98kaN90Fd8b+IMtfH7Zkrzr4oh+OYzZD+PKRWdZOkhcTKQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOo1/vM/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3dae49b117bso2518331f8f.1;
        Sat, 06 Sep 2025 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757170802; x=1757775602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5exdFFeMfs6pXJOU4JQGRUGWMk+GuCzkezUi2o0S8o=;
        b=WOo1/vM/3jDtv4mJMMIFxY2QefEsg9v6yw4Um9dB5H5Z97IdDLlKOc5nadOr+YnswI
         vu52axDcIU8MOjQn276g1yeGD+F3N4KBJtQRm//7KSph3mGxA06kmG7raJ8a1SAP/ate
         9XW5nN9ps9Zs/hqYNFYjg9quyFMAByjbrWxLQTOQDjlEzZkAy1Aa53Lm+i4EkvR1B5+n
         4AVyxT2hjYUN9dIfu0mQMKVRjztG2sxs2Lh0+I4MdRoqR8IJxq7tTS4O0CnEZvhIF2+W
         u+gasDOEhkCFcSltndsWqjLTngfcpi6Xv12OpFOOqKOkITdKc2Vdu6tHds7EGo8YIYh4
         h3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757170802; x=1757775602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5exdFFeMfs6pXJOU4JQGRUGWMk+GuCzkezUi2o0S8o=;
        b=PEmAqkHjfQfsOEeuKyD2LhPqKDH6jLFCTDgKNttT+x1KDO0SAWnnPIMN7mC1Io9HkK
         4z6wHenmc5YK62qvMuvnmHXiGz0lg3RwRJ4W6U/rc2AF9Tc+nIFUJQwwnBjyB+v668E1
         W9ym4SQzMNaEsP/hjEyAZB0dOUIl7+1AcDSyN/0u8V2jYSnb7pmedT5529YY7FaYcFhG
         n6ITOt+39gO9n21sSxd1zyEyCQinIP3YkM2ZCDXlD46uP9GmhjE9HoRekKVeob5yz0Uq
         cZ+hYTc5T5fkD8X8x5jDLbYm3czMtWyFZ09pJsl6Ly0dBbjsz/Wcq/0LuFxPd9+NC8G9
         dPsg==
X-Forwarded-Encrypted: i=1; AJvYcCURA4tVTTps27ogEqNmWSqFLGBnHgQqIAdF/As8yUVpmjilPXWWB2AqADXqO+bFBCyDLxWky0u+yKhj@vger.kernel.org, AJvYcCVOqtbqDzyDg5FNVxw68S1pIt0w2Iv4ekFXr6TwEi2suY7fW1RCMPHXquSUurLy0FXSM+2wejNYqjSO@vger.kernel.org, AJvYcCWtZv63MLgEwe5QcsUVj3lgqyYeejjL1Rv/ffUypEkgRe/4kUu1F3WxR0/nTID0Tr1zbo7vyYkn8dUgfw==@vger.kernel.org, AJvYcCXmVzHVF83sMpvlaThXm5dlD8rdwek1299ewACrdbTKBfpG9buOW5CKjj/gAyDo5aGOX4lAhe8+MmJeW3AS@vger.kernel.org
X-Gm-Message-State: AOJu0YwVqaIajXWnaNjLDo/ZKpQFvvUkHYnk304qnjU0RuLhnIhbCrJ1
	HEVWMf9zX/hrX1n3/GaC3Jz8b5+oI4ctPwa6mE9j8c4JiQ+RyZtj6A8=
X-Gm-Gg: ASbGncvczgx8XvZNTv3CgWco5OChIHrKN5zG+NfJAFMDsP+5yyYWD+ry0dw+S+IstHM
	t5vwFqdaOTTS8mHfEgp+epjz9k0MvwDJGVv6GxObXAwpn+9LMZBAeWStzZTL7JM6GhJRbROnpVL
	Ac1OLlLbMa4lfF0mkx6GsVb4j5Tb0fpBv5uEjM7LuybgIFwcTSOKZhpGdHjBUDM9BSxdmG2NrwO
	WoBl4NhUC12nH0oJ6Iw+p/ZsDkSCB4DkHORYF1Y34XELYBZB9F5B+/XtXaZZmwYOBwPBvcI6g1G
	zhyKckhlZSUfNFCcUHg60YJlfDv9HAQ9brJJ4+aWrYtCYWCaXyfqtl2lAG+bKJXgVxlr9Au7eGm
	dGQpwVrQ8l57NkCewROukt11KgNfO0mn3uT1EfTagzFoBmwbZMHqj3tvi5A==
X-Google-Smtp-Source: AGHT+IHkfCr/GUbB7Zg0ZVNuXkqzZKgkN3YIlt8oR9MJWtco+KeawFHG3DBPAGLJ8R/YPYvxkX0eYQ==
X-Received: by 2002:a05:6000:184d:b0:3e7:4265:66de with SMTP id ffacd0b85a97d-3e742656b0emr369915f8f.8.1757170801463;
        Sat, 06 Sep 2025 08:00:01 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:143f:cf9:d8da:f38a:fb6d:ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm35106544f8f.50.2025.09.06.08.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 08:00:00 -0700 (PDT)
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
Subject: [PATCH v6 3/3] ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible
Date: Sat,  6 Sep 2025 16:59:05 +0200
Message-Id: <20250906145905.93845-4-jihed.chaibi.dev@gmail.com>
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


