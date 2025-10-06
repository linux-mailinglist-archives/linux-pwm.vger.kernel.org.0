Return-Path: <linux-pwm+bounces-7394-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF68BBE325
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Oct 2025 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C3418947A2
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Oct 2025 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612220A5EB;
	Mon,  6 Oct 2025 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DjqzsfrU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328B244661
	for <linux-pwm@vger.kernel.org>; Mon,  6 Oct 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757737; cv=none; b=M9YqPiAs0D6gUGfKm8RKhwRIOmGtSAXbEWQ7Sx+get3Hjo905fyf10+EIgCz9uiLNaTL4CHMNm4wUIK32yqv+ZXpHLKs9ERydIoHZWCZKf4n5DDYkzlnzTRxgTts8aIPj9d+/m76z8sAoVT7TPs9CjVah9z7YguLtyU+lpPu51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757737; c=relaxed/simple;
	bh=1vmAJo2C8bbZ1UL4iTtwuIFWMgw0C+x9M9sN9mrgUO8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QUlXTDVFMUko9slKNf/wIBss27g+Hlhqe6J04y3X/4E0RG7Ic0xGGRs5b2B7Z25Wu43CFO16dQX8lwzoHKdIyOkrKLqnCZ1nsgflH7e2j0naDp0VB4+0WLEOQ1vGIQXb6TPwBYmyhuvdwXxYBMEjbX3czg6fxcQkSXTRxaQoJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DjqzsfrU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-637ef0137f7so7946562a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 06 Oct 2025 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759757732; x=1760362532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWdBev9qcKa9CTz1IaLJDf8+XBsVfLIP5yVin+8s2Mk=;
        b=DjqzsfrUg8BKUisTXlZ0PhnAXcoPxgfM7LGlPBcTrAkLAojjQ7jghUShkxLNDGd3T/
         S3w+eJCF0iyPOhyGCJ+PdKbx4rjU4YZ7ph8JVWgsgGCa0W0xYN9xEpfIqDEU5r9M8q+9
         eY2YaLt3zERWyDx42ts49A5B0eFqbqaQMuS5aGmmw5lgINmPWWetgikKHr6dWfzFG9xk
         jdAmO1CX6Pv1xreRcrNOVIVjz3tUTe+kAzvqyGVxF0tA6eZZtDpfC8OVLC0DgHMBmiOx
         2lI3a14BGPw7OgJS1IVH/aAfY+1ZTpu23+titBzPDfDXql9TQ7Bonq3/fNaJGL3ZKwky
         +OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759757732; x=1760362532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWdBev9qcKa9CTz1IaLJDf8+XBsVfLIP5yVin+8s2Mk=;
        b=h/TlFc0URrFO9PFMt8vnmyn5zlpfppD4PKXopgw8eq3kqG8v0MNSUKA4Pjqho8r1R8
         sOALZaqrkMOIEmAcUFg773liExUXG5uhLRnOc8SuZ0Mezcc/9hccJKzKbxNS0KmQZGGd
         x0L+CaQ3q8rg9u+WgcLlYYaS5l3MLaFvTqBdXoLrA1NuZUJAOUtm5s1LrWRTv9ZL2qv4
         fg26323EYN331se7ER5n3rOZcYUv48hI0mMj0nrIO5LRjOozwNV2ab81diTksOqsEkOT
         fVcza1/xZK1F3707nIPoxQiOJ56jiXM9f1K1FT/L5or84DSwIODDc2o7BRDJTHlkCyE+
         fYLA==
X-Gm-Message-State: AOJu0YzTJg7R/jlSx+SxoD424fP27PWbVeRymWbf7lWr9vA09pbljHSD
	PwOp6COCH/DpxVIj+NZuILRrdc1S0NdBS0MESMSVK/Bi4e9PKw1RJ4bNkuGzuPsOf6NE33kCLV0
	RSr4U
X-Gm-Gg: ASbGncvQPwxoaJ2MVOWqQntXWCG4LLOyZf50ZVwK0iKM/TRBd1e2UFSyXmo6GZB5SLI
	Rm1BmQyH0GqWVoo0ignxJQU2sDX6B911asmf3oq+awXS2QxSWvr+OGubxSDMEzL/CYRtpo/lJwf
	4Q7ef3/LKIPpG0zuB0cnBzzBIgOhNLQw4+5rqvrlOJSyhOf1fz5esD40nLW6DhSE92ig1Fkh0q3
	41XWdfQO5FHvgbE3OeiV+HA2lMVOr2JpUyVAnPKcg4A0iReSWw3LEXAEysY/mQji5MojquxQGrl
	Mb2S9ypw/vco3pIhST90b1GfwtMIld2KJMJwXU1okKxHOz+K/jYzN5OpWjkhInd5l2OW4VPsSG1
	FltuLOEFtyFQyc0L65jfymXB1gDSMMXT29odBPNz6jaqRrahswzHRMabSNWKvTA86mbU5voPNbY
	i+pLe355PcGvAXVNWu1LFND90=
X-Google-Smtp-Source: AGHT+IFWHZac20cWx3y4yqWy6lPqHqxEV48fkNwW/6pWdtYwElsFMJW9N4tRp09xJUb6K1+RrmKhsA==
X-Received: by 2002:a05:6402:27d4:b0:636:21b3:25a4 with SMTP id 4fb4d7f45d1cf-639348ddf20mr14769215a12.10.1759757732447;
        Mon, 06 Oct 2025 06:35:32 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63788110224sm10134885a12.39.2025.10.06.06.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:35:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Use %u to printf unsigned int pwm_chip::npwm and pwm_chip::id
Date: Mon,  6 Oct 2025 15:35:26 +0200
Message-ID: <20251006133525.2457171-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=1vmAJo2C8bbZ1UL4iTtwuIFWMgw0C+x9M9sN9mrgUO8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBo48Wee+u5t5tHMFgCnZd5Y0QR04cUmsqgEVhJ3 NL4WVY0Y7aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaOPFngAKCRCPgPtYfRL+ TgT3CACwB0KKpt82ANviG6ltOoJTFFsyxpWpJSXWyGJ+a4Wl+8VKJ39Mplx9myAlgyuciONGQ29 YXhoyVCcbV3TZp5mCCjsPUaLfMQXxIlwiHMOSx2jLM4IzFveUJZalMhSD0LuvXqxW/C40rdTsQD HFkyVM7O82WnnaKkWEdFasD/wSejIeg4DI9mhz+EwMVbn5umvV+oSirB6nMQKjB0GuGbiOs9yLo 6PAogFz8JqatrsfZui8TLUJWdhEhof+MS/IJFgISc6gOL3J8SprkKEeyFY93zdYoFkdtRAYs8AU 0by/KV6fO/ddBet/lTy4Wee9zlCmHoktxgbGOja6Bx4/494h
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

%u is the right conversion specifier to emit an unsigned int value.

Fixes: 62099abf67a2 ("pwm: Add debugfs interface")
Fixes: 0360a4873372 ("pwm: Mention PWM chip ID in /sys/kernel/debug/pwm")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

please tell me if this patch make a difference for one of your machines
:-)

The patch this depends on is
https://lore.kernel.org/r/20250926165702.321514-2-u.kleine-koenig@baylibre.com
.

Best regards
Uwe

 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5b75f4a08496..7dd1cf2ba402 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2696,7 +2696,7 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 {
 	struct pwm_chip *chip = v;
 
-	seq_printf(s, "%s%d: %s/%s, npwm: %d\n",
+	seq_printf(s, "%s%u: %s/%s, npwm: %u\n",
 		   (char *)s->private, chip->id,
 		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-bus",
 		   dev_name(pwmchip_parent(chip)), chip->npwm);

base-commit: 8f2689f194b8d1bff41150ae316abdfccf191309
prerequisite-patch-id: 569104417dd341baa45f7c1ff09c5a73062a2fb4
-- 
2.51.0


