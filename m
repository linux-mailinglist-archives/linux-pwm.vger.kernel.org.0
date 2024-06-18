Return-Path: <linux-pwm+bounces-2500-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7E190D3C6
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C289285BE2
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A72C15688E;
	Tue, 18 Jun 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i34RMu67"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5BF155CAE;
	Tue, 18 Jun 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719193; cv=none; b=cAM4Ysz918iOdjSHLTGTLSEkz2GLZyYQxvxGgPH8A2i+B8ucjuWUDmIo14SaqontV64XmnNKlOvDPMopO2niC/GOa6Xw8rR7Wpi/fMy1B/5B3x/+e0p+WFHZrxFxwQUGgv/EqqgM/A7oC7fJFdgZUpCliVKGkmYcseboPgSfQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719193; c=relaxed/simple;
	bh=MYDk+LYjEzzvLPDU6mjzpg2IX7z/HKPNPkCElkRcQ+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KH7vc6RyxUGooCkgEmbeZZ7qKfAJVV9kj65sgPDglB5zS8K5w9PUGDqHZ4weQbR4fynU3c41w/kgMRVMFBxY3mw7du+bq/6naZ2OaTtm+rwd56akgcnKdmP1TawWRiRkjfHlxgKZyspoGN701qStkvsVTodz6Py/nZsfAQY4P/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i34RMu67; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c83100c5fso5996215a12.3;
        Tue, 18 Jun 2024 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719189; x=1719323989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSe0urafDT2z1+HpSSV03N11tNgqTMkBCf6I1SbHXSY=;
        b=i34RMu67dIPdpECRsvigUcKKEInnayN4bROVrpvKxESQSuSyBc1W+pPJB4YDfvsFrc
         +FvBXhLsgjGxco2v77LNkUqXbJZ5gGA2RahB+dDCqbijU8Jgh0wt2Mjc3c2YUPXlS2Rx
         K3cf+ZvaAXrjlu2iiLijVHSl9pauv7hyOEqKyn1GpvqVoBrBiMewrZxK3jluF4Mky8bT
         Hh7V2Do8pUhZEuiSTw/21c5c2ueA7oyqTOAQ5EQlod2zFlPKTs9ziGaDz1YIsGPQ/8og
         +AVzMgEQnXNkoZZR+o5yH9D3+TQAuxBJK+WLytDvj6EKMI1InixOOeep7ILea4YDvoRc
         /5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719189; x=1719323989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSe0urafDT2z1+HpSSV03N11tNgqTMkBCf6I1SbHXSY=;
        b=uwsaVzi52GsO99Kgddd1qzyHSZIEPHQgppruJc33/5SEvqbrnqqnWR4ZoHl6A4G5i6
         2z1yIe2EVUQq2rBYCnGBhAX71OqaUnap9RJy4aNuS4/U4+bDcY3JQBmrHcSWLGf51xa2
         ZoXAjmndPrh1l/DgAGtQJ81PxjACEYPkkWRhHwf0Cp65k1CEoYI44e3Gv5zHaxxxpZHU
         amZD3e/W+jYlbqw6Rz+NmMiIknCyIgkrP+O9GfphiWxz860VUPpz5dzAG6w4oPf35WQi
         JK9E0a3vmFOotntuk7vO3Np9YPMaspaAxVTzKs422vPvR/mryhWj9oU8GU8sFn/uSkqe
         et9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP7N/Leyy0VCxAHYbacNpdD+Q7KJC0D1xzXeOoAIa6WGpDHfeMKf7Sag2A3zTrAObpkvKW0cpnsHXDorBwlra1IMj5ZYUrIrzgv7idYQ9EI9XK2C6zNAs2IcEQ1/bebxw0SzMDFmZiD0J5j7SZykVN4M0q6/XMJWhMgViGqx2yBxrD+wBIWuWi8kpGG1k26WRkQ7KJ9VERUcLaxfAALL0HVRWbZIuazoQ270bbMmihTvfoGhDwVWoR7a+icf4hbFd+eGMG/CV5Js9Wc2GO4uP4IumoNA5NKwFGlM74k0cJx83wRd2rNa+6g2j83O4q4GQJqkU+2o1g1Fgf7e1cy8aHpCSSTxv/he0SLLIrmhxCIBMy2/qf9kjBnKoCcnHendV4ex6YKWKxqowMvm1C/YkaYU1eLsUg
X-Gm-Message-State: AOJu0YxhvBmFutbCmsJlIpPwLWx1y7MsJq57Q+6Z4uVUc+ufk0mPJ6Cl
	e66+p22vpdhn2eJJHe63A1LdnF9oelMih/0srnJZl7/f7zAbJWsb
X-Google-Smtp-Source: AGHT+IGvN7W/J9F3YIuria+CV3PGWcs1VK3Ax+ln3/ipL9AA6AsOYEJMmxSCCBizSSU6Q6We2LB81g==
X-Received: by 2002:aa7:c253:0:b0:57c:ce20:152b with SMTP id 4fb4d7f45d1cf-57cce20164dmr5541095a12.26.1718719189451;
        Tue, 18 Jun 2024 06:59:49 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.06.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:59:49 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:35 +0300
Subject: [PATCH v3 01/23] power: supply: add undervoltage health status
 property
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-1-e3f6662017ac@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=718;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=MYDk+LYjEzzvLPDU6mjzpg2IX7z/HKPNPkCElkRcQ+w=;
 b=6osR5sQb3KfAqZxw/zABeeghkZzuowKR+l9GQi+0gqppa+51FZOCldCtLrCOr+cODyhyepNtO
 Beikk3e7TQ8CKJCAPvaKcz8UpsfsQfaQyB+QH3eRgK0LKT1K32tsI9K
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add POWER_SUPPLY_HEALTH_UNDERVOLTAGE status for power supply
to report under voltage lockout failures.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 include/linux/power_supply.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 65082ef75692..0f82a5c0ccf4 100644
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


