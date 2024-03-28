Return-Path: <linux-pwm+bounces-1763-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4A87C46A
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 21:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2DF281D4B
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45745763F2;
	Thu, 14 Mar 2024 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e9xJE9Yn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F863763ED
	for <linux-pwm@vger.kernel.org>; Thu, 14 Mar 2024 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449248; cv=none; b=AGoFSpHB/c4CQ6sdxjTgWhj3zrnLTpvCtuT3wuDkZj2qgscDGvJJjVMtYCSCAPcxA+NgyYeKcWk+9RVAuONx+T4Tb83iMS7pW5mZ1QIS1EkBBmSTXySj6aWkywsolRnZyheWNSVS0jRkiHqp7gNA5AWPKU577dB9R6jf7Z3LEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449248; c=relaxed/simple;
	bh=5ovH1aXNUGhwYmg43jcq7wC1/uQK+Bei/R88ECbB4ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTMFbpfgmmutm0lHyRoOKDaBVdCYfTjdqB11f8U90QqHQG35SkGsBOgbIQy/Py+rSJeOu0X0XR6wpG6fRxi5AOnN2YeT5++kUlEGkgSY77lEQgDZRe354XalVsxEXsF+kVy4BHLlsq5PEchRf2Vr6N3f2ClZDmN/dTUwiMzXLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e9xJE9Yn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a029c8e62so9369011cf.1
        for <linux-pwm@vger.kernel.org>; Thu, 14 Mar 2024 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710449245; x=1711054045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTaWihQYnQLfYGaPErRuZAyfnVaDu80XXW0C+HSNw+c=;
        b=e9xJE9Ynic9qalcv5GB+4/azo113BWvQuQ472O6fYl7b7ZoOBE23bvdbe6JnjvBAu6
         QdOkPrUll1F7oUWw1kNYfcWx7uMhMkxkSXxeCtVdLbXKzoIaIR04s25TXAY96eIkgEDD
         u9F4NTneJxHxVTyqO7aNs8Vu629pCdTYELWHsKL8xqTuhBGxxgQ/Oela0ncpyznC/LYi
         SD86TfNQuIgJlQcf54Hyhgnzz65Fxnh7gK3fjBoGDm2HT2DsZa07si9efX/DmAIzvxkL
         Z2r7K/VeatoRrKDj+WpZgJwtj/bC7mICTQAsAplcREkqI5KGP6bO70m1F4sHbQBcqzqs
         jqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449245; x=1711054045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTaWihQYnQLfYGaPErRuZAyfnVaDu80XXW0C+HSNw+c=;
        b=e7K5AJi1Nl1TQEP7fzH5E8npsBPjGQMrZ/aidq3OgEoKUeDY2aAfwr2OrKtpoZA87+
         28IdM2uicnV724BNlsA1HxtanEJe+PwQ/zKjlsdTZfeQBzDCVAeQMuw4XQF/a03+Nv7G
         4ChtUkLqDblw+4qRMXwa77q59GcHrNM3NlUO/KQQmmuk7ofjSURtPvaYFhvwQI1Udbm+
         cexbpY4YA6VOad3KrYqVTRpOIl1We0dVdKI9c54A8eG9eZhpfdIXVB0TaJz//W+FQSow
         icse3butLwbUumEnFRyUbxWfszvo10U9JvZZapMj1B2C5uuTtp6tO/8m/E/0IrqaNql+
         hI5Q==
X-Gm-Message-State: AOJu0YxzJE/2wUPpSQPmFDEEI/s90mEEg5P6AtBUS00uvkcBHsORyWNO
	oj0CiJ0eoF4FVUPBSU9JGVTuFuz2qRpr2wJTr8i0CJSAKqIYSU8vRqZGyD8a9hDvsGWkQf8d/1q
	sdkc=
X-Google-Smtp-Source: AGHT+IG3B31CPepy9bFtQ+qDplPxFOYN2WIteiiEsns4Hk28VuM3iTWES9zOnszVJDqWo2RdVXnpfA==
X-Received: by 2002:a05:622a:5299:b0:42f:200e:1a61 with SMTP id dr25-20020a05622a529900b0042f200e1a61mr2290329qtb.34.1710449245320;
        Thu, 14 Mar 2024 13:47:25 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id n16-20020ac86750000000b0042eef160b4dsm1165272qtp.76.2024.03.14.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 13:47:25 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	tgamblin@baylibre.com,
	dlechner@baylibre.com
Subject: [PATCH 1/2] dt-bindings: pwm: adi,axi-pwmgen: Add compatible for v2 IP
Date: Thu, 14 Mar 2024 16:47:21 -0400
Message-ID: <20240314204722.1291993-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314204722.1291993-1-tgamblin@baylibre.com>
References: <20240314204722.1291993-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a compatible string for the AXI PWMGEN v2 IP block. This is
nearly identical to v1 other than updating the example to use v2.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index 63461920a362..6b344c0e9a1b 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -21,7 +21,9 @@ allOf:
 
 properties:
   compatible:
-    const: adi,axi-pwmgen-1.00.a
+    enum:
+      - adi,axi-pwmgen-1.00.a
+      - adi,axi-pwmgen-2.00.a
 
   reg:
     maxItems: 1
@@ -41,7 +43,7 @@ unevaluatedProperties: false
 examples:
   - |
     pwm@44b00000 {
-       compatible = "adi,axi-pwmgen-1.00.a";
+       compatible = "adi,axi-pwmgen-2.00.a";
        reg = <0x44b00000 0x1000>;
        clocks = <&spi_clk>;
        #pwm-cells = <2>;
-- 
2.44.0


