Return-Path: <linux-pwm+bounces-3250-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454D9978414
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0420128872D
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6431A155324;
	Fri, 13 Sep 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AenlUwaq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19F154458;
	Fri, 13 Sep 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240143; cv=none; b=F2F4Y0IKYTrZMtkN5LfleYJBaHOwTfv9DmiPYxkWWn9SUWDUzgnmMaiJKHYGbQuRfOshdMkjczVxqhsgfaFwz/6j5ebH0zvxVcn5b3GtBFydM/7dxGh6OImm7q4RtCYqTZMpjt6VkdYYl0JFA8ulwF+gBnGJvE4h2U415lnVLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240143; c=relaxed/simple;
	bh=Eph7e0S45r0MTRyCXF3ejlfGwAhuMntaPM1lDGhJahM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJCnuwF3k1MBzz7TRjuf3+YVKofkvVQv3W8BHU/+IGowbBh6GtNDuAKRG0+5fyY7E4jBdjyFk8I6Z5N61TlvuwCWSO8NwOhSvqwYI1iGOr8ezCBI9ejLR6x3JxFtv82GmzrHaq02cfQkkpY6op6YLmM2cPeTnw7SartATckV12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AenlUwaq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so26899521fa.3;
        Fri, 13 Sep 2024 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240139; x=1726844939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MogS/GsWGussElbxSTITWgB14U3ovrKNCk5uQtTkgQ=;
        b=AenlUwaq1f0j0Nngv0vOB5WjJWao62jq7LvohYJFPgpTPR4HsLSjQS2zPYlXTdbGQ9
         aNwDH70Medh45iiMNeUawDOVmaZHnFGMoP9NYk+/uRc/IRZoO3WTf2eEk64zomW5VSsH
         uGx1gISiFIRTiD+noGsu6UXE2q/PA1sFD40BjP/2b253MvViWyInop2MJNmKTccwjdEv
         d0Z7UD+RmaJrqjcRPRo8O7HBzT0sq1qXd+ynfytiHltoUT9dypTTv53D0xrkYMBLkWYh
         6wzrkDdg95hmbFZ04mIWYslzd7+Tge9odzkDSiVsRBwq19cXWsf7QneCRQWUG32tpDt1
         nvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240139; x=1726844939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MogS/GsWGussElbxSTITWgB14U3ovrKNCk5uQtTkgQ=;
        b=SBHI2NSOtLgIsuzM9voYtonDR+IQkDw3pv7lomAf+XCbVXdm+P42KZ4iIWOEDXZ33b
         vt6Rmic9iIPbJceqv5k8qd+PEP1P3xNBVVoAK5z+XzS/r09ZAfeU4rzFIJ304MkGjYk5
         chHF7xP+vTyYRZlY9BbL28OKucLFJLy9hCexRtIMDw3c/NbbbKmGHkQ8ix+5phgq1xDN
         9VS8/RRtjL70K7QmfuIfVPAQbvMDeh2hDVodKRNqEKga82NKo/LeXlBXD6qxijTYJhbS
         dmpzR1DKB84gOsgIn3QdOWy+ErAvX/+a6iMSLGQEbr2Ld94NfCsb9/+4C6C3QdsX4lX+
         EZWA==
X-Forwarded-Encrypted: i=1; AJvYcCV55UKG3vTamoAICC2NPyvMTDj3aNhAV6Wtb6H6s1ZwHUFazCZ/rJ/7up77PgxFrYIjwDv5acMi2SDa@vger.kernel.org, AJvYcCV7I+NgaquxDyRvpkrTIthf+miMjRCtk+N1EM16kAQSm1m16261dMbS7AZVzj96uwdSlnSv2AITeUxcWFWs@vger.kernel.org, AJvYcCVjhWRq1gIWVdOIxcyhkcl8JyL7fmOtZmY9j1Z1LoV1F25b95LGBOn2F+mpvYYDW1c0LYXQSIle6TOw@vger.kernel.org, AJvYcCW7YgRJVXwt0sBSHjK9vugn1051pHAeWDQnhufDMEzQPYW0rzPOCWKHKYVAZ2xJd2LMFlHnlD2u9ZSPsgYEPkla9Wk=@vger.kernel.org, AJvYcCWb74j9KHSFuFlaLnwcy0oGGNg2EDVPr+zal1qjrq6WiGr6StZwxmLlR0pXq1WAeDyEmFrtLF0aEvQepN8ldA==@vger.kernel.org, AJvYcCWrgxHiKaJJFL2BmljmuU9cayXiMQCwT5q7IdaLL8Yknjqg5CELZDLFgL1jA9n2FG+dfzx0c49iNqnZlQ==@vger.kernel.org, AJvYcCWxBDIGwNE4IQcdBIbJrjPOObr1DIISIfWt0aoLPSXJHpM+6a1Jg4pCNtlB9SjF4HkxO/OyMCjA8kDNx7Q=@vger.kernel.org, AJvYcCXK+5H61o01tFuXd081zBjuODOnKJQXrg5ukMkVvRjIX55Z1TvD9Ij0zvIhjyjodrEVcHPnakKuqjhr@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJtJqZdUTB0NvMs0qij0OD4/O/7sZeC30T3tBaQuOgHe2oBFB
	aIbKjjjaKDtkIUaJ1NR9hHl6NC+YfhjvMPTOhTgz6G742ezt4rm23LhZXw==
X-Google-Smtp-Source: AGHT+IG15UZQPWFKTrEWMJoYpOjTZRs1/pybTllYbPk3ZUCPtTA6NrMHeSupfUSZWg7LhFQUdQrI6A==
X-Received: by 2002:a2e:a9a6:0:b0:2f7:7f76:992b with SMTP id 38308e7fff4ca-2f787f4484dmr38107941fa.37.1726240139396;
        Fri, 13 Sep 2024 08:08:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:58 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:08:00 +0300
Subject: [PATCH v4 17/27] arm64: dts: qcom: starqltechn: remove wifi
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-17-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=1053;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=Eph7e0S45r0MTRyCXF3ejlfGwAhuMntaPM1lDGhJahM=;
 b=vALQnYl3+w5MCg7sDPNqQFdT/NtoYAqeD+ucytbEKKHkbRr5ArqYw4dNgJg++Oy86E0lACe3V
 f9aB8bebsZhDs8mQDd098TOeyreaGhbxS6kdp6OHR7eJJBg8bLkG6CV
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Starqltechn has broadcom chip for wifi, so sdm845 wifi part
can be disabled.

Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index d37a433130b9..6fc30fd1262b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -418,14 +418,6 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
-&wifi {
-	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
-	status = "okay";
-};
-
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <27 4>, <81 4>, <85 4>;
 

-- 
2.39.2


