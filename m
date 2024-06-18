Return-Path: <linux-pwm+bounces-2520-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5228E90D468
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4EA1F2273F
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4091A070A;
	Tue, 18 Jun 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfaEAGfI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF841A072E;
	Tue, 18 Jun 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719238; cv=none; b=TmuQdR5nLMfvF/L1g4v0cgM+H8xhFWuWRZNkBaauX0KKTV1zAg6d/Yb/4a0RnOSL2rAU8lSymbTIlWc47t7mJyRjL1gp6VuhmkpHwkCfES9Pm/fMnGBlIL90sSXgD38WAKbV445xlCV8onRqgAU83YLJf7ICrCNjRQSHlhJZK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719238; c=relaxed/simple;
	bh=DzdFdRz1gVcaCMECSJAIQnLBTgojo3XrhxzENnm7+Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZOw+CmrjR7WVu4ZuBp5ZoQKfEvOvfKX7cOMlkw4WA06ijqB/oVG3jPnEB12wzRfsEbXW1i6ukdsk31SlLCvbRqgVTP9H4xUZGzYI4CnEwhaXNcpYP43m52X39uN0wxf4klJvbeNV+3X+QcvtzWar02J6S+98jjh8uBn5KVMt70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfaEAGfI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cfe600cbeso768035a12.2;
        Tue, 18 Jun 2024 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719236; x=1719324036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8C5cZtO+2UCwtEojtBuXITHFJF0Ul+anrs/LLrVrxk=;
        b=JfaEAGfIKRlATPRzpxbaRiuXBrbgrA7s3fGaeKJHmFBNdwRg40DYKa3Kji4QyhnplE
         KN7DZ35sJ6eCHBFaMHKwU198tjmOicefm9ORorV/KxjuTUSFLYsM/RVi6ACmVvAoAxJu
         onQpG3erUV4yB9rfJHJikzJa3J+y2m/RpwKgUgN/RxlK5Lh9tcifq8iTFFt4ZWwKRmXt
         CN19Eh2m6OTKAt86aTB/11eMuiAz1xqippqnrnTZYZMmeFgl3Bdr6V4fwwuDLiBCZUor
         esMfVXSbBZjszgNsyAznla9kZIxsogUXYoAo7S6vDxENt9pQ1TRQ+Ds8iXsGvsunSXZJ
         TZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719236; x=1719324036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8C5cZtO+2UCwtEojtBuXITHFJF0Ul+anrs/LLrVrxk=;
        b=upDKPA6cUVRkAL1BBf0PxBwb6U1Lq5DJnqpzjwY7rMFX5vO1RoABLWPKVQDPyVX/mx
         UC1s8tGRVogDBbF5wxALtVPoRMVHsifxeauLZqo+CCXxqIRsN5EL3A7dLKDul01uc3wU
         HeCMtaUd4A7mLNO9cL3CG6tcUapgp8kyjpfcHkZw8Ij3B7yZqG7HuCYXZflyJMPzpez9
         z5kT7gYH4QS9GhE/M/NFpXDhAvdnhcy/FB5rQXYsW0Ra0Pjevmn75XB3pS4Dv/jlFK30
         1BVE1A5pd/8KmRXvcawfsd+gdJDckm13S+xnzlKza8L8cQytITp5HQfqHt3gvwnXOqdV
         fW8g==
X-Forwarded-Encrypted: i=1; AJvYcCWsnbdIP4cOVNb8pA9L0ZR0aqIp8VyGn2DTpiy7JtHPqqdXSN/bN3ybNfD46/PAe8QkHWARr432hlwwzAwJ9+b1BNp4igqs0hl9ZzaQ/Z96KoOrp1XS0oP0D2YTW/uSaURTEcsxVyQz8p9s08ecUpeRgPuVUEbo1oqiVp7PGobnwCS+ZvPSL2Dvwe8G6hADi8+XhLpaabjsuiPS29nBXihSJKVqZb9abewPSRPJH3Ki8EppleGclX1OHvlujrI9Hj8qkg98zL1JXfJ75xa8crcjla+Aj3cR5K3IWheyE8PuWEV5U07cZeiyPRxJ/zsqSAPMIsBx49sZ+xETWI1TGNHvkOnH2VEaM1G9n5JA9LgOhXty9j9WAafsKd940TiFBv5M/f/DvYloVYvXwxI5EnQuxQYuUOjU
X-Gm-Message-State: AOJu0YxYA/QopuPhEItJfOXmCSAs8Ayi68vze1L6vY8fQDXMXpBmTZKj
	Om5TYkkPMvgEwrk7WvlEdTb1b6XSEjdVpsFv0kG8YSQgFj3v7Qai
X-Google-Smtp-Source: AGHT+IHQorFEBelRVlnJYSg0Nj0exKGkeoGt+vHNChz4s1U63SUJqDJ4IXGFzwDNCjEMHQbzrx2ZIw==
X-Received: by 2002:a50:ab4a:0:b0:578:6c19:4801 with SMTP id 4fb4d7f45d1cf-57cbd6a70e9mr8232985a12.22.1718719235560;
        Tue, 18 Jun 2024 07:00:35 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:00:35 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:55 +0300
Subject: [PATCH v3 21/23] arm64: dts: qcom: starqltechn: remove framebuffer
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-21-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719185; l=914;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=DzdFdRz1gVcaCMECSJAIQnLBTgojo3XrhxzENnm7+Yk=;
 b=V19181JL5PJh1FZxnidHS2IZyd3Qo7EGVRrt7RJyFup2Mg4Or7+mluh4O8nPJterG1dcIbP87
 yDealaQ5i9cA12cOnIJfdiYlbhP/WAfUNEcsJ0zd6HRE5SQ9Rep2O3Z
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Remove framebuffer because a panel driver introduced.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 6fc30fd1262b..578798704577 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -19,15 +19,6 @@ / {
 	chosen {
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
-		framebuffer: framebuffer@9d400000 {
-			compatible = "simple-framebuffer";
-			reg = <0 0x9d400000 0 (2960 * 1440 * 4)>;//2400000
-			width = <1440>;
-			height = <2960>;
-			stride = <(1440 * 4)>;
-			format = "a8r8g8b8";
-		};
 	};
 
 	vph_pwr: vph-pwr-regulator {

-- 
2.39.2


