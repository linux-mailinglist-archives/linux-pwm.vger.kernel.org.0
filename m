Return-Path: <linux-pwm+bounces-4711-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0314A1A197
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 11:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D59F3A5BB9
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 10:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC220D51A;
	Thu, 23 Jan 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w4dTQuOt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC91B20D514
	for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627092; cv=none; b=hnPyNpWcCVKK7mKWRPxrap+H20KVg0nMeu1VaRfkOLvIXUtzkxWVOL/uCifGgX5ul715kAUFfKnuCX8uHvfzu7DHg/6YRHGPMOVbBeZuVD6Imiw0EtSzqyIeBketQcFp16XwQPS9xeuR9/dYPRFBuEJicsoTv209fN30ndVr6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627092; c=relaxed/simple;
	bh=PYg5SENmvMeNQ5ErhexAyuRRwu9HFms7ofbKlpAnsfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9nkv+sqEJ76VzXn4aAHCMbzXH2JNMADoNFXfhC80ZNVuYcAdd5QOT8AgCJVdUTGKaY3jsBB5OBFusC6BYCahQ/xyqBgaSOdQYJjCcTV6tqH3c/3vUL0IYpW+ttGjRsmeZpQleGu9R3sOl62Vty7SEOVYT+RLY0kxrFbkIyJ3c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w4dTQuOt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so1140896a12.1
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 02:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737627088; x=1738231888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zB5c6PP3YSzwR7PfKnY4U7m+rg847HJBbMyI3T78qCk=;
        b=w4dTQuOtS1IV0Vk5lM4QN6sPNQ3Jg+D6x7YbsEBnqIB8sM/Z9Ll6cHXsDYvtuQ5PnT
         1q5zhWVoaoU9IPCNjuJ4GAL2G81C1AID1YvKMw1gnBkHVztqJLnnzzUFA8c1TrZjQEnj
         G9vR4pYXhbbDjeIWxhtqjuPusp86Tk6eXUtBoBuwzCxlsqF9mAyH7vyAOiL2DgxvOVzJ
         JRujEjhxMl6sD2aVgbnpd5JuNsdIuHjfx7808D+2/Wk04FpaQ6QnBByo3dD++L7oBVFF
         JzuySkSF8bz2yG+sy5jNLyrtsQuEFVZX8g8rklg01hBxCnno87MeFatNQdTWAcLYLjxu
         cD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737627088; x=1738231888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zB5c6PP3YSzwR7PfKnY4U7m+rg847HJBbMyI3T78qCk=;
        b=CSpSNgJZK8l3eDM6DGqcK/Szc7mN8isxHPc+RlrfroNmpHtt8s83isHHDMihXNAQBJ
         dE1dAoQtLauNyj5LotgYKwnJlw36LlyxM7DXTyOPlX0zDOTQVjQnHvPqUu9rkDxj+WAC
         4pVyjtQI4P1Lx8Lq4egg5dyftlTxuq+NWOlMNj6cz/bLTqhHWhFiVW0THrg4Qg0bc41W
         gTPD9XqdPtiy5/2egmVVg7ef5gvxdvduSlfNpdtI/05T2G/eRQZbw7uSLbOYaEV4TC3Q
         tH1nQ5c7wSaeYy8967tZSb5EiGFjGhIEdm4nC3p5mo4nl3u5HLU2pQ7CZ+0FgfVqNGSw
         xo4Q==
X-Gm-Message-State: AOJu0Yxk19kUIo6Tx80MZLU/nAiUWTkfck0P7ESWJqKO0p5nUxCUXd6Y
	3t05wMfZjbaeFxZUJ6claj8i1MIJWN8jpB2p7KCfdgrCmxE8LYNZErzcn44AEtU=
X-Gm-Gg: ASbGncsrg2+LAnCUfsF4d5Ykl8EEeNEL3VsISIVXJ18lk6cvzkJXFGHuLaB48HBElIf
	rdOMCjBV9ttARuBfcaeCkvwJeYzlGAIBdihMq87H+oAjmx5juP2qgsmTM7XwIYvfT/ae8smzVP7
	83V8MjPAafpyyYEZpH275HRO2lihC6ua9ipQKJXOZmN0qpcyZ3deEDiArUIHHI8nq8jYQ6W4fcH
	YDWIQQf17ysHVjrsdd0CttyfEmvn+XHerJPwcT/6NvqG/uJAh0dfUSdM/kN763cUdHK92hxXlHL
	c8Ef9c6/2cdvWCpsbZK6/8YnqM9puwJM8HFBqStELq88+24=
X-Google-Smtp-Source: AGHT+IGe400Tztd/jtvKXTVVKHrJ41HlMW0XwxuFnekMYp5OI4hrkNBszFO04qxsDkqDsgTBw/8hMw==
X-Received: by 2002:a05:6402:40cd:b0:5dc:6c1:815d with SMTP id 4fb4d7f45d1cf-5dc06c18246mr6461265a12.8.1737627087947;
        Thu, 23 Jan 2025 02:11:27 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce1a49sm1036829166b.46.2025.01.23.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 02:11:27 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2 1/2] pinctrl: intel: Import namespace for pwm_lpss function
Date: Thu, 23 Jan 2025 11:11:10 +0100
Message-ID: <20250123101110.339337-5-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
References: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=PYg5SENmvMeNQ5ErhexAyuRRwu9HFms7ofbKlpAnsfA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnkhXCb5k9qsOluJn+g1HoRUx+lG5t//WXOgfW3 26jTc1MysWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ5IVwgAKCRCPgPtYfRL+ ToJiB/0fMpcUjI0Azf8kBBAIsRNDZnjr+C92eZfOH6nos6nAWK8h2PzxztZTupp3axiGbUOTxE5 l09Zz1b7wzmh79ySJFbd7uYLVfb3LK+4nTHURUxigoAC8HTDqxD8Z8BFPtQaecGB1NWGmKytijm 3rorkTYbAixpvDGkGYagC5pJEsyXZv7gwlYDOVD+1EpmfcatP3pqVD2elc+TgKmJFu1zhmxqGtd bnBBvnB+dVKTRh5Kq3bEBG7rve1x37Dbi9QNl/mWLhoqJVpsBZVwDf4kcB3Dgx8SEUqLaF3Vbi2 GQaPNWvp6olfKa0uQtWSk25CamievmlQVdRtU5tRIlGNLslN
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The intel pinctrl driver can provide a PWM device and for that needs to
call the function devm_pwm_lpss_probe(). That function is provided by
the pwm-lpss driver which intends to export it in the "PWM_LPSS"
namespace. To prepare fixing the pwm-lpss driver to indeed use the
"PWM_LPSS" namespace, import that namespace when used.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 527e4b87ae52..d7f1ebb1919f 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1941,3 +1941,6 @@ MODULE_AUTHOR("Mathias Nyman <mathias.nyman@linux.intel.com>");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_DESCRIPTION("Intel pinctrl/GPIO core driver");
 MODULE_LICENSE("GPL v2");
+#if IS_REACHABLE(CONFIG_PWM_LPSS)
+MODULE_IMPORT_NS("PWM_LPSS");
+#endif
-- 
2.47.1


