Return-Path: <linux-pwm+bounces-6177-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F7BAC813F
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F364E35A3
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933322F386;
	Thu, 29 May 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bw+fx9wm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC022D9EF
	for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537636; cv=none; b=Qzo95Jk2RqH4SrlbTHUAoGntVYBpohjvoY62AqzVmGA5l8q7AaBO0rDOi8X8nbuZ26Hw750SPrC5XLjD1IJAVv770647kVeeJ6Xj8ZKSf4mAGQU3K8EynBp40K1nZYpOXDA4Gej8eR8UmcXamZ3m8j0keEY7A7EwcGimYOkRTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537636; c=relaxed/simple;
	bh=tXN/bUv5GGn68VfUhe3b6vC2z9pHKfDijFpQd04/NLw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pa7ET70EyZ0CAgdg0wT/xO4hF6GOAVXPAFNjCrFynrzYJKS2Xz/g4gvW7gG6C+EsUIpBGPmhYy3vyAKkv28xihVN5Hcnh96R3ytSl6FOj+X22jdBUf4i/PLwQ/oSMNuBSZ8Ue+szQhjjiLGsWJBIaonVeMVoBPTedsO9OVctq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bw+fx9wm; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-735a9e65471so696053a34.1
        for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748537632; x=1749142432; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxRvSUzHeev+hBLLES5l8w1nd2OHwRLbMnpZSS6PLIU=;
        b=Bw+fx9wmjb6Ymxt1d0h3TOj+qcW1ZmfSsWIZQ3eYpE9aiYlfDQa460FBWpejn33hm2
         1d2jaA5brvHCOZ+LgWLhkArWqKfb2dgiVBMcDIVvhvSFz88XtlnvD0hiqLKkgtcxKssb
         EGooA9wjJOdkkjWik1nCeu4U6BRSh7w1qzxDuAl8HxLF/aRrZkBhL4chD8BHf8FOQLpS
         C619VC8JNQ7JEVM8V1FfC6DENiSPbnIM6H1QTaUx75tvLsP8Se6MwQ2uBT2u+xyxTugD
         MR26xHhWn4wA+/1TpZdr8BWoFjJtYaPia464bbG385eJsAXNVmBUkpYxPH99wGkHzq+i
         EIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748537632; x=1749142432;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxRvSUzHeev+hBLLES5l8w1nd2OHwRLbMnpZSS6PLIU=;
        b=qQd1qnSLYy0gZwqyKJEFoE42gH3qEVckbr7uddhvfgj3cpW1fcqIwVwaewtzmNUxOE
         hGIw1tGFiUIVmj9GHU49GBtCVXHjF4sUZOX7xnVkDOjSx+LIRhok80HuwmZEn4AJYlQ5
         YDbMwnIVH0y2IivYZ79KSqA3W4fMOoyEjqsF4D3gt2uKMfpcMXrFMo1bKjStZpUV+OTK
         ZCKA242KAx1erXwLwAKzaYKt0W7MSbJajNsedpJrZERWn7I/NEXate/wJHTfyz5Y07EX
         jvy4oLn4pC+nwk4MPP+nEl2OULHz4cog24IIU9Zq+8J4ExzIGV8J0iw3bXy/EfaARVsX
         qIjA==
X-Gm-Message-State: AOJu0YyILvXfDO4r8VDmGyLbJRkf/mZysyeUPc9Mszn7/9l3yVoV4AMx
	fha0zLJYztmNwxTiduM07Zqw173SdPR5+MwRq7iECrum2WHljAD7H2dHj+s/sG1gtyk=
X-Gm-Gg: ASbGncvT3Dd6AVtc0yw78TZnwuY5jFiTeXzK/s9ufhPgb6AqnaV2XwpLrL5dwsS6Acz
	KTwAH5rnn1cNYr7pfR7CCcvQ7AwMF69zuDUNp5JxQQ9pyQlowSJSK+3KUjG8tSWxWjeqDsnf76q
	UvYCiosFnllGxZyqxFYXM+j9DxF4EZbGlt77N9mUIv4VoY3n7cFU3l0NDJOVPhzRM+qf3w7RbKI
	jSzb03rGI6HomPOrggliByGihrNZqEh/rUgJwgFCyPE21C3A/oA1EO0nqVRG42N1J5JwnfFoxYB
	3HHS8lgIozlFQeqjSb6bSLYLqLgyZerE/oeb8Y6z/APTj8PY61l1bgRN
X-Google-Smtp-Source: AGHT+IELS+hG7loPhc/Vw7Ryo09hGdzU1FX0Hl6otVIzbS6UeuyM3wrPyUK6DPm+l3cfGDB550/IyA==
X-Received: by 2002:a05:6830:380c:b0:735:b0a3:e485 with SMTP id 46e09a7af769-73676b88f9bmr33364a34.25.1748537631732;
        Thu, 29 May 2025 09:53:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af82d2b8sm303265a34.3.2025.05.29.09.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:53:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/3] pwm: axi-pwmgen: add external clock
Date: Thu, 29 May 2025 11:53:17 -0500
Message-Id: <20250529-pwm-axi-pwmgen-add-external-clock-v3-0-5d8809a7da91@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP2QOGgC/43NsQ6CMBDG8VchnT1zFGnAyfcwDuV6QCNQUghCC
 O9uIQ7Gyenyv+H3rWJgb3kQ12gVnic7WNeFSE6RoFp3FYM1oYVEmWIap9C/WtCz3W/FHWhjgOe
 RfacboMbREzBRl7IwZYZ5IYLTey7tfGzcH6FrO4zOL8fkFO/fjy7xD32KAUGRUQkRYkzZrdBLY
 wvPZ3Kt2Acm+Y3Kf1AZUMwU65wVU4k/6LZtb/a6lqIqAQAA
X-Change-ID: 20250515-pwm-axi-pwmgen-add-external-clock-0364fbdf809b
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=tXN/bUv5GGn68VfUhe3b6vC2z9pHKfDijFpQd04/NLw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoOJEEKE70jzqKOf4Xnw34nS2599BQ3qJVqgLc8
 FVzfuLopIGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaDiRBAAKCRDCzCAB/wGP
 wLTFB/wKIgZf+3k4itUkgrYwKeZTnNIMlCRpHzg5K6gqrKGJ6BNnZtZu0q11gI8LNqgUDcUvbaP
 WSPXeHak/8nytkml8SseXHsNxdfFCTu6ZaEwvO6OXY5eu6kENPqr4eZdm7QPB9OAw1rAP7BSJyV
 i3PKemCGTJzozdhKtaMjvZ+0msanPHtH2LPhQwjDhozULjD8of6iQr5r3Y76YWRj2qR5gh/1rid
 R/sMBc2N8z/0BfPEzwv3kQ4ziRlxDYZ3GPH9gFt1e1adiZVe2c0knjDo3KeA9LpW7qdMtYjCv1H
 yyFjiI3dKhv6Am6IKHhr+4QOzNe1E2eL9xPkwsiMZVzQY1Bb
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

When we created the driver for the AXI PWMGEN IP block, we overlooked
the fact that it can optionally be configured to use an external clock
in addition to the AXI bus clock. This is easy to miss in testing
because the bus clock is always on because it is driving other
peripherals as well.

Up to now, users were specifying the external clock if there was one and
the AXI bus clock otherwise. But the proper way to do this is to would
be to always specify the bus clock and only specify the external clock
if the IP block has been configured to use it.

To fix this, we add clock-names to the devicetree bindings and change
clocks to allow 1 or 2 clocks.

---
Changes in v3:
- Fixed clock-names DT property restrictions (was failing dt_binding_check)
- Added Cc: stable
- Picked up trailers
- Link to v2: https://lore.kernel.org/r/20250522-pwm-axi-pwmgen-add-external-clock-v2-0-086ea9e6ecf0@baylibre.com

Changes in v2:
- Consider this a fix rather than a new feature.
- Make clock-names required.
- Simplify the logic in the pwm driver to avoid needing to test if
  clock-names is present in old dtbs that used the broken binding.
- Link to v1: https://lore.kernel.org/r/20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com

---
David Lechner (3):
      dt-bindings: pwm: adi,axi-pwmgen: update documentation link
      dt-bindings: pwm: adi,axi-pwmgen: fix clocks
      pwm: axi-pwmgen: fix missing separate external clock

 .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml    | 15 +++++++++++---
 drivers/pwm/pwm-axi-pwmgen.c                       | 23 +++++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)
---
base-commit: 484803582c77061b470ac64a634f25f89715be3f
change-id: 20250515-pwm-axi-pwmgen-add-external-clock-0364fbdf809b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


