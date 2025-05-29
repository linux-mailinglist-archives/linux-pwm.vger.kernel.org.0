Return-Path: <linux-pwm+bounces-6175-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20DDAC813B
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 18:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742824E398F
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B708622E3E6;
	Thu, 29 May 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TNansi3k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8B22DA04
	for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537635; cv=none; b=aIDi4GM4J4q4XAzxhElOHQr/WtyxP0Mq+Q7aVWI4MP7om//3ObJX4M06pz7BMG3NOEWBawOoV1NvFk10FkEhIXmislOt1Wno0rs7SFTDyKcercPG/5dYEKrMv9fsaIu0daki8/u2BVRF/TKNkfyaAzwPgKqRz46EztpRZOVg580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537635; c=relaxed/simple;
	bh=Afxwdef0Jf2HSBiCXGtNVmL7wJWM8CS0UaEkxk3+CTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJ6neBDpfYmARZBB1sigQyjajERKDtYErtqBmiPJBQBStBI/h/zGhOY49PPVvax/K0b2HZUSXliwBh/61UTiulkyjUlxTRILUY95l/hdFgnu2UHwIYFjZ3Ps7C2hcaCAaTTcB2cNPEPuVSkTGQGMORpuJwJGO8HeVWTZsfuOACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TNansi3k; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72ecc0eeb8bso404873a34.0
        for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748537632; x=1749142432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fp00wL1Y5X4So9ecfuqEeP+KnSz3366qtgJ3q9p0wb0=;
        b=TNansi3kvunjDYhhwJte4ByprBOf69V/NWg/iMGC9BdsLbI2Pwls1d//fJPZdctrrK
         0hWt0WXyJjfUc5umsH/Mtyk4VfcRCin6HMAIi5BnCirvRuqi9hWGYon0SLuFf5xV//Yp
         N/SHJuijKNB6z8LH3md8VVkFZYkVcS+Y2VzLCdR3IgSOvLF1U8CIXaL5UYkixDK/DqLH
         wBKqRz5eicWoMYt1yhtGKLtcolN4UW0DPRzY0OUa04Kqsy1owROJDPZ7YTbJcPWs8dOT
         Wuc/Uk1l4sm6JrCDZK4Ay752UEc+fSiBQkERW0W7oExeE+ImOQkI5X/PRFJAPwWWZ8of
         SI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748537632; x=1749142432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp00wL1Y5X4So9ecfuqEeP+KnSz3366qtgJ3q9p0wb0=;
        b=faUGqDdDMKcvCHEWyg5TzOgvrS6Py3GnaiDXMiRt8FuQPNnPd6lKD5mxiZ+vKFI3ec
         56pBxpGItQAcdctKLzfiYE+7EqS7fIeSwzpPV1fafyQ9XCsvgC2Dcigze0iu17bVjpMs
         8XLtwQoM3udR0g3mIG/MbgIQIsUPrxi8t74CQ3VCxEwP7gqfpa1wZjkRLUYzndZaBN4l
         VqPgh5Q2+Jfuaywwra0dbE/BDjpNoGSzUB4EIUIv38anukyCBAc0Tedp0hNJXpTOYqgi
         R2TA6rM3JH/b1P5H3JN46FY/xFAkLHntxe4W40UP0PLhsVH5EBaRH0UiOys6Rn6G/djC
         na3g==
X-Gm-Message-State: AOJu0YzSistFP3zVMLz70+Lhg/Ejr83r1JC8z+sQl3pmkt4TpI58BWBC
	jVfBAiJ/3/ZvIV/ZZ53cVGSNvP+IQtCgA3PUjk0/kJ0q5kYgevULX+2uZ3jVWEJOnoo=
X-Gm-Gg: ASbGncsEbXXGGTTpcZBl6oEhdaYMlhMbkKvmXda6GVF5IMD+ELAvLxV4Hf3wArttKxL
	gAhqbPCzlB5oYNU08V9ZqodhkHzwo68v4oJt714vt0Tq47En3SKIN8czbR3F0vZqNwMjsQUJ0hK
	PDTyfPVYqa9eDcEm7zI/M1B1BGHC/5BTOy/XRAdf9NLdeZyZeAZAAro1ExnNcJruLt4/b0SJ9Cw
	jId/9GhoAXYs+pKkED7H5zv9gZGD6xQ+EzKidtt1kZ9or4FOz/aSyM+6NfmWC18jS8BeOcjLD5h
	O1SXWs67Kwo6dH+XEXMkluKcTJGkF7jCnge7b2E2cwneljYfevWzMXcb
X-Google-Smtp-Source: AGHT+IHWfANHEl60ub2u9RCYUO+1dYUXWM1SqhmMS0Cv0T9+qohTtEh8OvWGwFgekQwnTfEnL0Xe3w==
X-Received: by 2002:a05:6830:63cd:b0:72a:10ec:3542 with SMTP id 46e09a7af769-73670a003d3mr58025a34.13.1748537632570;
        Thu, 29 May 2025 09:53:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af82d2b8sm303265a34.3.2025.05.29.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:53:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 29 May 2025 11:53:18 -0500
Subject: [PATCH v3 1/3] dt-bindings: pwm: adi,axi-pwmgen: update
 documentation link
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-pwm-axi-pwmgen-add-external-clock-v3-1-5d8809a7da91@baylibre.com>
References: <20250529-pwm-axi-pwmgen-add-external-clock-v3-0-5d8809a7da91@baylibre.com>
In-Reply-To: <20250529-pwm-axi-pwmgen-add-external-clock-v3-0-5d8809a7da91@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Afxwdef0Jf2HSBiCXGtNVmL7wJWM8CS0UaEkxk3+CTk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoOJELv3klzplmJWe7i8nFoiNwHuoSes4VI5M8o
 OKFFE59XzeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaDiRCwAKCRDCzCAB/wGP
 wM52B/0f7SuexXaBLZmawRIBtmajfHckBGAw7+J844EWpdy8urMrJGq58sMQdSP80Bts3mt69mC
 y4BKnCuogI3N0m/EWTcQx5AKhUwSSGxjluIlbDXgRxZaMSrMY2ZZBURUjHThpU6AT7dDZ9O5ETR
 EgOAZnsHvIShlnOznLdDHbCfIwPX9pSxW8ZA8VJ96YkH6BPSA3fs1MpGDmn+KuQDMXLOgQv6b7b
 5y0cDrjRIHuIKaJMjzxfAZAG5H1lL2RHpakwS4Jz42QnEyZ7ydceKvuiQPO3Mkwt/+dCNkFY0yi
 Vmv2RRKX2qXmIiv7RCpsrjwCvSzoZ7jIel9nc2R2gWqmhqsv
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the documentation link to point to the location with the most
up-to-date information.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index 45e112d0efb4663bc7fbb3a25a12d66aa8b7492d..bc44381692054f647a160a6573dae4cff2ee3f31 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -14,7 +14,7 @@ description:
   The Analog Devices AXI PWM generator can generate PWM signals
   with variable pulse width and period.
 
-  https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
+  https://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html
 
 allOf:
   - $ref: pwm.yaml#

-- 
2.43.0


