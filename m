Return-Path: <linux-pwm+bounces-3234-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A712D978369
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342671F259D0
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FF64EB51;
	Fri, 13 Sep 2024 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUfv07vM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B863D0AD;
	Fri, 13 Sep 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240095; cv=none; b=ImPeI/8HZlBR4hGn3oXuzZi5sC30rE31eytcpgynDqNNBL+7UNsb/h6cFfK6ltBDvYS7zHAKE9oSvEGZzZ3Hotau7PdXWwSoSI7dkZKkH2Qajw1gcnkOxHA/DbqROTpbvieytJ0AXkO6QMIF+lNCpXlgFhMvJpOU5GbhAA+Qfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240095; c=relaxed/simple;
	bh=ddijmglUy+4wekTGyDAt+CkBz5h456H3akY2zm7U9hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDxIhK+p37b0lhoY9gfgOpGokm24mfhG1gFmT5OHVqcdHepRwXJsezyZrcIgPAYg2Wb0oe+eF/wlQlsjMO5ON8YYhSk0mFb4Bk0IldT8TZImjnyk5hNdZs0F6ipMxmI4nxC2eAI2fjfzm/nXtyVk4V/hgXppReZ5mFu30KnxkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUfv07vM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so2529252a12.0;
        Fri, 13 Sep 2024 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240092; x=1726844892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EIqNkwsQqZA2boWTxgOSCM1LnprICOAsFLvJ5jdzT0=;
        b=PUfv07vMxzXAQmWC0zclH/PwcHKTnBdAJ1b0UG1hE5a7gANLNoGK5p3eOd1VdOBxn4
         zuy0OOXCiwSF8fyDgb8cETGMDq9q/44myZPgEBr0VtcnrQTpSdWM+z/TxAn9MVz4CyiJ
         h/ezzVVPKOs3gTZXlS9/uuBIe/6glA/6/PMD5yz0yS4GiFWnd78MioB32Kql3dQfu/+n
         NnJzTD1UdpdYz2pS2mH64SznhaFEJsmM2gWqFCKp5t+9pFDzjlbKZhgBbSdq9RxZ1Unv
         YPuvXP5wKIbSeL/DmjZK3b843PNlK8b1N824p7DcQw9SYYZBTy22/sDE8fbz4/ZMN0xV
         jzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240092; x=1726844892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EIqNkwsQqZA2boWTxgOSCM1LnprICOAsFLvJ5jdzT0=;
        b=tNRBBMOoVJDzP+5XPOwXJMFQIkzF3SiR34+BXmK1CSMoDF9Z78zhoFrm8wAnApqGgt
         BE6SNY+ty5hqg/Qqj8UtlpR1GezSUvGFwFFb8oH6A2fJm1kCer3P9N38Vefd+hWLIVj8
         dB2aAStv4prVgG7thFtn+3wJ2o5EhspOnBfTQyyjfQEdZdWeoo97pg6gY0M98JWfLT3v
         xvJsrpJQOxjt4fSWwtZJwhfSpU9OLDCWZYj6PjKdFfvFfuT/xgqAtO0oPHgBpjQgkRGv
         sNZRhg3Ss7mGupZbPKct1nBvT2ZXlrEOnH2BAptbsCiG9Brv4DXtxiT5gHbA08IAKOjE
         FCMg==
X-Forwarded-Encrypted: i=1; AJvYcCUIYerf1kX+OlJ0leelh6AvWIjVeYcEzLXSpfle7zGnUVGU0nCz5SMIpIaaXhvAtEpooN3ICwAAF12o@vger.kernel.org, AJvYcCUPIySp9ApQiqanJ1P2soNl+0WfvhO3rOAcWrL9C8A6bDJB8T+chjfpgzinXzMjT3PHDXFkjtSrUfj1@vger.kernel.org, AJvYcCUxRgbiNcSIergkMJ4BnT50uLnn20jvo3fdLxQ1iGANSJCAWSALKwaTFzjGYEerWXxSDTCTFDKNyQaRnkf35dUet/g=@vger.kernel.org, AJvYcCWKqrf9EKEUnAHzb4BQqO0dIMuOA0Z8MfFGXR2aCPvD72JOQ7TVkSJ5q8hmPmNtubKELpI1x4Onqj4r8Q==@vger.kernel.org, AJvYcCWdN4weG3nvnOhmN9C3vkZjw8UMxqtyZsvzILrDifE2vD5Yw1+o+LjOc/yFEdA68T0mrQM6aWAcdfG4t4E=@vger.kernel.org, AJvYcCWhYx5Hjcm8LPofHemo9nSWV6eAkH+P+kEom5zqel3hihWvhNRIk4FuayRniRkQf2AjpnBmx4nMcVgELwFXRQ==@vger.kernel.org, AJvYcCXjyXGUmUJx1t8F0yv78fU41kwY6BTdmjetUd8hSF112r1E45QYWiCSR6gketgcUAHpz+wJkvBsMH6j@vger.kernel.org, AJvYcCXrYkj/1Js3ng5CJUkZPzYhpVzcEB/b6Uurv9x6jdxrXYQletRwRwsY+CbgS5dd92ikITL42iFQeDS/Z23Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzLL81ynxe8o4/nQf1N/fDovgdInyOmoKmm/XxwjHnfBJTI2/7i
	YJbkSeRYsArQ8xxVN66dQVtRUlZYo838wC1i4yQzB0q/FC8Z1rEIwGKE5g==
X-Google-Smtp-Source: AGHT+IE6p8oIHSJsZjO2mqGheGUSLlmJW/eDkgrNE2S89U66htUkE0mJEAHFXlxpzTiGrpsFC3Ltvg==
X-Received: by 2002:a05:6402:1d53:b0:5c2:7570:3a2a with SMTP id 4fb4d7f45d1cf-5c413e1ee8cmr5399227a12.17.1726240092072;
        Fri, 13 Sep 2024 08:08:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:11 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:44 +0300
Subject: [PATCH v4 01/27] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-1-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=718;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=ddijmglUy+4wekTGyDAt+CkBz5h456H3akY2zm7U9hc=;
 b=DUew05PYQEnECXRBoPaNkYafjbSQTw/TzmdaaO86R3ABKGSwEcD3aOOWmE9UYWH8XHLI1cCOW
 1spV1CZGhufDOpTXp/PEROc9GP7fFhmLUklqPu3P8Cey+x4U1/xnzm/
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add POWER_SUPPLY_HEALTH_UNDERVOLTAGE status for power supply
to report under voltage lockout failures.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 include/linux/power_supply.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 910d407ebe63..8682e6466544 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -58,6 +58,7 @@ enum {
 	POWER_SUPPLY_HEALTH_OVERHEAT,
 	POWER_SUPPLY_HEALTH_DEAD,
 	POWER_SUPPLY_HEALTH_OVERVOLTAGE,
+	POWER_SUPPLY_HEALTH_UNDERVOLTAGE,
 	POWER_SUPPLY_HEALTH_UNSPEC_FAILURE,
 	POWER_SUPPLY_HEALTH_COLD,
 	POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE,

-- 
2.39.2


