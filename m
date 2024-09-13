Return-Path: <linux-pwm+bounces-3247-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5429783F4
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDBE1F25FC1
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62794146D54;
	Fri, 13 Sep 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBicj8Sm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544B146599;
	Fri, 13 Sep 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240133; cv=none; b=lMvcY8XUGbie9B+mW6xfJXapR175WQoD01mknwXCDKfbHtKClsgnuV78fSw8ykowTzhGsMtqgLYCNh7MnGyA/lxjKqxSx8mI8FH84h6C90vbjJmU76iXVrfD4dt2r+K/3JVk3/kKkuGF4Cn4Q6fWKtVvML/QrHQofpp9HQmvJ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240133; c=relaxed/simple;
	bh=YbxXX5O1uF/FO7LjGr4qHVRuSX/d0hagRp09+kmoocw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PSb9KQgsyHF5NNAJZseHpJAheVeWY7ZeACR0WBmQPPdq8AWNDGM5VYd79y+mOf+oooAG86y+FyfjsWrhoOUr38bO5SnzQksUWup46jbxEXBue1NlkUV5JwX0c7j+vFB6hDSvS/aH+yDGUtewAIRkXx5iKz+ivHAHRSxUmjvAeuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBicj8Sm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so5034937a12.1;
        Fri, 13 Sep 2024 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240129; x=1726844929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMyS4TGv+HH7D7PP1BOOaznRGSa+Pie/rUhrnOoO0p8=;
        b=nBicj8SmZL9svSZaXznsqpQqpXnv/3jnA9jajRQb+kz1+Ipj2Kla970JmZeHDaIQfT
         G2nsttmlhqpg54/kqSGGS6UJFc63ZRVRbpKKBqgTEfzSqHO+RM1ylpINRq4o5vofLgly
         W7+N1Z0AUpt5BwrumCU7tiEDAMr/V+tHWJLQ75MFLKjxSO+PQPC3HrXlfC73Z8mxQy0U
         DFToaLX9rOaF/j004AAjmeQfApqbLnQr6O+8spMRNr+FDqID6QHmrdASxxzbBoQlK7h/
         uQzoSlqDUC9DmuAAdM0FJ9znGMIqxmqz2LxqfPxYUs3/j5SKSP24ixNS6k3OuUHF26C2
         QzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240129; x=1726844929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMyS4TGv+HH7D7PP1BOOaznRGSa+Pie/rUhrnOoO0p8=;
        b=PWYzsHwNDXvhi+GjKQ5xBxh1tXwMtmi/QKCyq5E/2llN+e/+9TPz280yUCwq+9+eqo
         /Qblf6y2vnrmWq+i/YvTpkVJPgv4PzgepSl9djkKKPbIjFdmPMg5IEW0zDPQol378m7X
         LihLZyj6RXAlgKAsxF/BYDJoyUST2Y0RT+sE8nUzlO55qBHSyenGQchMg0PDeC6znmpY
         yPeiEGxeVKKK2fTHqS1v/1jbx7xQ0tPFcuvmsOJH6GmjxT7KSHXEuLi/4+d4Lyc6IBlW
         Hj3MVRSwcmWp4T75uZa8czCjUzPcdogGe8l8UE7P9daVTTvH139Ot9/OZz8fsf5hQl4G
         Ylhw==
X-Forwarded-Encrypted: i=1; AJvYcCUO0PweM0NLm43Ljz5nBqz2RkPmJupmdbrG+57hFL4R6v0JXnLbSLoCPEThgFYhMVD/rkVNI5cmaL64Cl8N@vger.kernel.org, AJvYcCUlhEXHTh4s4RKXpN7U5Gvkb2iBrqp2FvOUxFE68tKnSOzi9gXG74CIctJOJoK3TVO/urR42OF8Dv/LiNO2hA==@vger.kernel.org, AJvYcCV0VwikEusfU3GpJPCzazxdsfsD0t//mgb/cZ5p3pcErfFCSxXq0OIdf4EsbAbagsXPTtWwXaRXh9f/@vger.kernel.org, AJvYcCW7cs5+gc9g14cyk2XHAtXast/DIugkf5/WhDwcLgmzSPRbltFq4wLpaSqkMxTvjp110S3OTbPxNLr5@vger.kernel.org, AJvYcCWj3ho0rgZd+nplkhheV0963r9pQNF5CO65qVWYVUwZx+BWoCqvKvO0Lf/AbiQkjQZm9G6/WoaQuBC4q/c=@vger.kernel.org, AJvYcCXAeKztWgahep6b21E3YLdEsgKpIXSECJS/aQyBdnhe0O6s2k3lGXnxA5HgYHne/nbSGymZgnsojX1KuC/jBxsfQUU=@vger.kernel.org, AJvYcCXGCOxCHUlNtPYc2lEd2vKA7synBO5lO2wjS22wq23Fg/igMExzfRPayxoqbBinpghsH89WSYmsFlVqlQ==@vger.kernel.org, AJvYcCXz/dJ4GLe5t+ac42aIjh0cBMc1RPQHPCxgwWGHiFnScE9ASbiW6rWSggN7acUeIAk4067MZhtcDaXc@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQvecJ+OBTn1h/BEs+c6uAOe/Vj9uiIPKIqCHn+vy3KnCGjO8
	/GmO4AKbv9qOA3TtmqXKSCYgLhbUfq+Fm0EFJ5wL5nB8vmqQmlNOMhEqcA==
X-Google-Smtp-Source: AGHT+IHSrEZZjUESARYQ6fIarJ7TrElR8MiGf6iIEpLCfKv9PblhIITrPdP+yNEt2KLdvqVkd+x0iw==
X-Received: by 2002:a05:6402:4144:b0:5c2:6f35:41af with SMTP id 4fb4d7f45d1cf-5c4018e5d05mr17182296a12.16.1726240129470;
        Fri, 13 Sep 2024 08:08:49 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:49 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:57 +0300
Subject: [PATCH v4 14/27] mfd: sec-core: add s2dos05 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-14-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=1802;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=YbxXX5O1uF/FO7LjGr4qHVRuSX/d0hagRp09+kmoocw=;
 b=F+1j39KA2eCELndZF8q3la6rvLp0yMuYrqvtxV93pOaw2HT1vWbRSfjl+rA9qYN4xKfR+oXs4
 XFhJyAbMoYkDn8N8u94dQWU0o+kAVvUJZng5qVb6y3pq9e51TkboXTM
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

S2dos05 is a panel/touchscreen PMIC, often found in
Samsung phones. We define 2 sub-devices for which drivers will
be added in subsequent patches.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/mfd/sec-core.c           | 11 +++++++++++
 include/linux/mfd/samsung/core.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index a6b0d7300b2d..cdfe738e1d76 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -34,6 +34,10 @@ static const struct mfd_cell s5m8767_devs[] = {
 	},
 };
 
+static const struct mfd_cell s2dos05_devs[] = {
+	{ .name = "s2dos05-regulator", },
+};
+
 static const struct mfd_cell s2mps11_devs[] = {
 	{ .name = "s2mps11-regulator", },
 	{ .name = "s2mps14-rtc", },
@@ -83,6 +87,9 @@ static const struct of_device_id sec_dt_match[] = {
 	{
 		.compatible = "samsung,s5m8767-pmic",
 		.data = (void *)S5M8767X,
+	}, {
+		.compatible = "samsung,s2dos05",
+		.data = (void *)S2DOS05,
 	}, {
 		.compatible = "samsung,s2mps11-pmic",
 		.data = (void *)S2MPS11X,
@@ -339,6 +346,10 @@ static int sec_pmic_probe(struct i2c_client *i2c)
 		sec_devs = s5m8767_devs;
 		num_sec_devs = ARRAY_SIZE(s5m8767_devs);
 		break;
+	case S2DOS05:
+		sec_devs = s2dos05_devs;
+		num_sec_devs = ARRAY_SIZE(s2dos05_devs);
+		break;
 	case S2MPA01:
 		sec_devs = s2mpa01_devs;
 		num_sec_devs = ARRAY_SIZE(s2mpa01_devs);
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index a212b9f72bc9..750274d41fc0 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -37,6 +37,7 @@ struct gpio_desc;
 
 enum sec_device_type {
 	S5M8767X,
+	S2DOS05,
 	S2MPA01,
 	S2MPS11X,
 	S2MPS13X,

-- 
2.39.2


