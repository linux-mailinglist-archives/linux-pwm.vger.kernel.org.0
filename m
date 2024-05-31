Return-Path: <linux-pwm+bounces-2304-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBD58D642C
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A761F21F77
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7754917B50C;
	Fri, 31 May 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1knN3uH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D64178369;
	Fri, 31 May 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164750; cv=none; b=nQ+ZSVh/MGvc9t3B1ZlpfmjOpmJCEVJ8RP5pqKwnzDIL4J5kID/QeUG9V/QHbWFVW9RYroSIV6DgFWsKxroh4mMo8l/rwDoi3ShohIcqv6cF+U+696duIUG0/pRevzVcuSH/EG2U3+Tq6i7YyZSLJQFrZSXnL1DCraZVsVTMs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164750; c=relaxed/simple;
	bh=ySGb1Jm4zAUSkNVL5xRbODLWUdyI4QAA3rXBMbD71cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDtim/XcP9GfRN6Lyxqr2Q0fpijWV9ZR7Q0G0MXkw+YaTWZxeE4iT2jt8PXeBb9L1eQzRkVDQvuvi5dfjT9gWy0RByTeVKeqBuFWJKvJwrpqRZ5czV5rlxfZ8QxcRA+KbalrSFucVXGSHoD1mzuSmAAcCpIv1Szyt1qdYtyrXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1knN3uH; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7023b6d810bso1228399b3a.3;
        Fri, 31 May 2024 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717164748; x=1717769548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPJfZzAlshx5ECsaUbb27JTh2zfd8fB5yh8nTmdx9Ew=;
        b=C1knN3uHZig/FWEPiZis+pF1Xxfx+ZrG1D81v1gxRMLhTglQL/NisvO/uEhczgWrZs
         USuNbIo7TC7cZ3NPIhvumEshFgin1RRmGsXWS6K7G0zaTJP3vdNUsDvDHtu1QrI3b83j
         yDua5Mx0EXcun4qcLomzNqRi3P4n1uD8olRiQY3TPoP+YeLabkOpin4F/qROsS1LKVKy
         2/qUF17aeyiimGDteAEx005yavgivKcj/kCS0rw5LAvP2YHhQ8shu7ODV+SwVtEklKwP
         QSWRvEFt71M9oG3TzX+AB03c+AamNWoO5qcU9PYltVAkwbYmHEXeXoSRQilcZXBYARdj
         J7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717164748; x=1717769548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPJfZzAlshx5ECsaUbb27JTh2zfd8fB5yh8nTmdx9Ew=;
        b=khG0EdTuf2gJciCOGgcL/YMNGmzbayNeaF+6sKEZKVBG8x4fdBmAZLbwco7hKYUOXT
         VIdZ/IPW0NByCpTsOj36e0oVPk1+GMSOJMWeIxvEHgtyZDEdbL8fcHkB1gQFqojudhxM
         +dzxt2M64qoCp9/5aR9dDazoHyIoeIittYdoaEfHGqM/14OQ/M60KH3xoPLn35ie/EER
         hYdi+EIFJ0lIF9TgDqlaruWAs8B9xNn9I9UyhcCacpZAkGodzhHo7JNeV/34ouLvv1A6
         72C2GhjA+7mG9wbVYsXYgFy7/ZlwqkCh+xv2zPnqNco6yIvwXrR9AC1PYI94F0o0Liwe
         VmtA==
X-Forwarded-Encrypted: i=1; AJvYcCX9fHklWP5NTRnEa9U6jpAjwr0DP8yNBiSdxhhl2pfT+yvkTi1yeIz3Ec/uHCiTyvsaF1JkraQYV6Hl91d8sFOg8I21DL3joHd1bbb6W002nHAjip0IZfpM+lcUiLS1gZywe7d3yA==
X-Gm-Message-State: AOJu0Yy1bwglczakZPDlNybYKn6XkH/Qe4mCqpvuCb/2mbAcEdRi9+SP
	iX4Xqmz70LsJ/WpbPy3e11NsPRbBZhchHloPWC2vO4HEKMFOz8sdpdYvxSdfT8c=
X-Google-Smtp-Source: AGHT+IFUfZFrkaT77WlxLeA/cfEsI2cTENqqh2ey9z8VUL3vIVSJO76NvoXO2i0KDDceR47Z029OGA==
X-Received: by 2002:a05:6a00:244d:b0:6f4:43d7:6bdc with SMTP id d2e1a72fcca58-702478c6fbcmr2196315b3a.31.1717164748356;
        Fri, 31 May 2024 07:12:28 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b057besm1418103b3a.162.2024.05.31.07.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 07:12:28 -0700 (PDT)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Aleksandr Shubin <privatesub2@gmail.com>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 3/5] dt-bindings: pwm: sun20i: Add compatible string for Allwinner H616 PWM
Date: Fri, 31 May 2024 23:11:35 +0900
Message-ID: <20240531141152.327592-4-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531141152.327592-1-kikuchan98@gmail.com>
References: <20240531141152.327592-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allwinner H616 SoC has a PWM controller similar to the one
in the D1, which is supported by the pwm-sun20i driver.

The main difference is in the register layout. Specifically, the
GATING flag is placed in the PCCR register instead of the
individual PCGR register.

Add a compatible string to distinguish them.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
index 89cebf7841a..b9b6d7e7c87 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
@@ -17,6 +17,7 @@ properties:
       - items:
           - const: allwinner,sun50i-r329-pwm
           - const: allwinner,sun20i-d1-pwm
+      - const: allwinner,sun50i-h616-pwm
 
   reg:
     maxItems: 1
-- 
2.45.1


