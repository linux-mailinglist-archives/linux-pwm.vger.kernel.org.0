Return-Path: <linux-pwm+bounces-3241-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CFC9783BE
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858D21F2557F
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CB58563E;
	Fri, 13 Sep 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmA1atxO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7607884DE4;
	Fri, 13 Sep 2024 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240116; cv=none; b=nhQUNifZK6BqInlAwToHRQMjg+jKgBqv7YUvDLe76V6vxYIVVMJg0kvK/Jem5YjZQBZq5U8AFVD0EOJ//I+6E5ENmKURxVtbmuX7QxTBgQ5sIVQaXwhpKvC/pzYctXtBa79yFxH3TZApK5kfXjXEv8cBUFeF36scPge9BqEdftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240116; c=relaxed/simple;
	bh=Q8zEcsu3xOThAfReNawr2bCrmNcwrVa7H+TfC8M0RIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UdH0YlO1tA6Fp77F6bXCghPRPX64EfZdfwHWMIYXePlyQNF2gGSv44wmFaGZycLWaf/WagyifegbR5WnmbvJk+n11aulC7iq3rTVNyquooj4FfBzBg1ufC7UzkOzQQZwMbBdlSHxbaYF1MszzRC0rrXSH37H6RPErqydfqKhJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmA1atxO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so3118172e87.0;
        Fri, 13 Sep 2024 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240112; x=1726844912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BuVtWnpggbksGVD/tDL66cKkJqocyp8CAEvr9d7e9Y=;
        b=LmA1atxO2uRloFl68OcBhojTxuq2YW9jCr9kx+0MC9KTqEzaWWsxoF7Tqby05r5x2A
         +7miC4+9zYOD0GsgX/p/LVvNzdf5YwJVB6Itwtgmxf9erauMc4QAeqc2OQuHs5qgvmzh
         vh33jEE+yaO7uVpxeh9MNoJEYdvSIY5MdJKRIhmNjWw6dHtOxNUu1oY3C0CcUZFMZImY
         4tSN9eG4bdzPrJUc3ES5xYHFDAw551wIjLgcQxO9XieahJy+gE+F1dtKIZbKjiUiXT6N
         Vi+5dSvjlPYi8Qk5dYSPRFs/thwdsTykSopFhue6QozcgaKJempZp35haqFydmHC6JiD
         iFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240112; x=1726844912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BuVtWnpggbksGVD/tDL66cKkJqocyp8CAEvr9d7e9Y=;
        b=id1DugXBFXrbOqHOMnmEiSHb4z9VoY5075fxuZOLmuXn9dRZfZAKu1RMB0DqNzhnLV
         dZ9ueBuZJpLNHEtTMYfjGO97tqWdXXFtTcRTu2IuamcJ36+q/UgQoGjRpPQxWfBJxRS8
         3hR/BsAH54lHO72oS1W98pdq+oltXdyHLk8rypCKcbhR+bzUYj6FQ9BCGxmFQ+55jYqV
         VIh7aIZFYtCGeF4VffGAA6o5U5CLPAir2V3pGENFf4OikL0qQ4iN5vzu4Cn388y/Gj83
         +ccGUF4Lglk4jjAWN4CUrstUzT3wOYV87Jawi2a9jlgcI6Nfcjln5sTce9HCGWeRTNdu
         5Btw==
X-Forwarded-Encrypted: i=1; AJvYcCUBEDS9za4a2vI7fPKHnEr8qT/gjNaz/wv+IXPhucO/0TNH/2ir69dtILFTj9xeKIHW3JaHbzOSLQF5@vger.kernel.org, AJvYcCUhzq7GJCoAGeY9WRvVkl+mhZ/a7CZlgqlYV6rgteRzj8kGDGHFD/n8G+xpVUWTXPJJQoLnDQp4ANDj@vger.kernel.org, AJvYcCVWW3dESQEtrgxrq5+5QeziGW9W++LrI0wJrayD7/y2b/oEPxUtlXEQHILUgSQclTPYygZ8WLZ2XBuWTCtA@vger.kernel.org, AJvYcCWCeQO9d7L7gRlThjf+qN2WDBpxzCkLr90uF41dt8ZuxRENd+YOrfoyNQiTGVwOQjdrmhaWd90jUbQ2GRw=@vger.kernel.org, AJvYcCWGbJrkqhH95EKs3cCso2bdwT2INFcs7KsJBQ9pfY34r3dn/VOq+QTysC37i6awRUOckWU7bk+zanLqmA==@vger.kernel.org, AJvYcCWzpRelxImtpC1ns9MU1a0HgA/zPTPj0TcC7jf+XU9AZfg11u/fDnp7rCOl5pzVqISxkanBeGILWV2HQvmKrA==@vger.kernel.org, AJvYcCX/w5OUydFlnDiv3ZjPF169iKiv5gTyOzdBHVzLULaa02RbNX8DAKopwLKXOpHbQJzPRRILz2vKlxRKw4A/xsOtk98=@vger.kernel.org, AJvYcCXywwVlct5oS1aTYU2jNn1RfAJTF7PVxv7tjcRaViNvVcVLI0OO9HrHuCdfngbpCQzkqz2TnT3soMD9@vger.kernel.org
X-Gm-Message-State: AOJu0YzaM8vjGaJAmlZnvc2HqhfdEViw5KLqoQqPcERVgIOALsAg7oyE
	DeLpt6LeyU6MnuiTtWXOi+QQoZzZkLN06b/6Yf9qF5KF84B3ZzwT/W2alw==
X-Google-Smtp-Source: AGHT+IGBKNI5Hw0ejr5wTOAzZqko2ncnm/G9BUpWyWRp3+NQpm58mdiYixmrMFyeIHbkPTwNF5f3Wg==
X-Received: by 2002:a05:6512:68b:b0:52e:fa6b:e54a with SMTP id 2adb3069b0e04-53678fbfb2amr4385322e87.30.1726240112063;
        Fri, 13 Sep 2024 08:08:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:31 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:51 +0300
Subject: [PATCH v4 08/27] mfd: max77693: remove unused declarations
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-8-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=843;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=Q8zEcsu3xOThAfReNawr2bCrmNcwrVa7H+TfC8M0RIc=;
 b=hHjznQFMl889U4wkRvgPP0WBxOZ7LgBMxuxxVVaN/drKPz4Plhs+ojQQwSc3eNGaDacxx6Sgd
 TwJoYxSmM4jAg5/qwfRAJ9HCAywMGmtxGmC6O86muRBVykLfkbnswIs
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Remove `enum max77693_irq_source` declaration because unused.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 include/linux/mfd/max77693-private.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 20c5e02ed9da..c324d548619e 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -419,17 +419,6 @@ enum max77693_haptic_reg {
 #define MAX77693_CONFIG2_MEN            6
 #define MAX77693_CONFIG2_HTYP           5
 
-enum max77693_irq_source {
-	LED_INT = 0,
-	TOPSYS_INT,
-	CHG_INT,
-	MUIC_INT1,
-	MUIC_INT2,
-	MUIC_INT3,
-
-	MAX77693_IRQ_GROUP_NR,
-};
-
 #define SRC_IRQ_CHARGER			BIT(0)
 #define SRC_IRQ_TOP			BIT(1)
 #define SRC_IRQ_FLASH			BIT(2)

-- 
2.39.2


