Return-Path: <linux-pwm+bounces-2633-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2B91B06F
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 22:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE0F1F22E83
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0493019DF83;
	Thu, 27 Jun 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MbTsOCkc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55619E7DF
	for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520319; cv=none; b=InHE3gZzLzGPs2DBaM6ara/yPBGuDp9gYt4kovPj0oWzKgZXQQutPdYR3vqafmdbY8pdnyhlLF0Yuvh3YPwLBeDZtWtJz1YoKvYGduod9OuJDjeuba1PfMfU8KmpRh9O+nSt3AAfOaSv8JsW/swukE0ZEpCindtR52gYcmr7gMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520319; c=relaxed/simple;
	bh=QOTjwplbHCXcvotTRKkaNA40OvJQror24r5KQbK81DI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1dmER20eIqBe6nu4XTcKvbYtio/KCq6KfE9qNwKLFGGxI9Tnln4+aIJnU26lag+/Ju9jHCrTwi1DjyX1D0yRuOOFsYjp7md69vZLMASsLEosw0yEPY7UZ1ebs1NB7GQJUrm1jJl21f4MUDheGmrHUy+crPcnyxdc49X8w4nCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MbTsOCkc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso964266066b.0
        for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719520316; x=1720125116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6aqS7uPgV4ox/wn2MFUN4A6FCb8XC2J8LFOuj1Z8vA=;
        b=MbTsOCkcTv1ylMi6IUx9aDrmtsyBB8k7uf6CviiOwIWYB1RD5VNSoBMo7+Puk4QOoA
         WdxfXdbh9HhSjIkdv5C9pWVcDgnXL37p74D9q3QSQpKCLsVYqSZmHkLIgmFgerSLsJSa
         LYnEALPp2dEXeFrHs/lOfbTRvqlIEF4IqqKA+Pg7umnkbGNyiIa6w8d2BOa+S4aSFjg2
         hJeWdsGudeqtOHRwK1OmEcI0+3gJlqJCk9zMRpgPv43UUbv/I2mx09HWY0LpYD7EsElT
         zIJvdG5wIAwYSbJB9OUCp/917kluCDLqXEqGNonlmTEM6zlcCVjzXUpYWh673JwN4MfL
         7JGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520316; x=1720125116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6aqS7uPgV4ox/wn2MFUN4A6FCb8XC2J8LFOuj1Z8vA=;
        b=iuKBrWLA6IwQgOTX3RyFiiWMbOT3H5BU+MYCxwoU5n9UMg9+VtHbAh4M1M2saleYg3
         05VjcnYFf1kt++miTnoKGQ1SgWDH8gSgEOW8Sgx78Xqo7JDu2afW7fhs776uY9pMEkpK
         gI8NUXIzB72tXH9vp7XB9GHYj5REIEjNlGZ27e64rUIynMQIso72Tz+lwDm5LqezyC8m
         bzHqNGI/LhTCLqOakQ2Mns/PVDtxD8ZpSK2tuXHQAtWw2qAysaVgOB9ABTpqV2VWXrRL
         6TmbK2rwS+/8jM5VWe4ReYIHfeoQfkCVoqa9Tf4PyTh92Ew0R+JaDBS2hX9hAQbYAwjz
         WaUg==
X-Gm-Message-State: AOJu0YxBrcrwV2ds6/xzUHoDqqKvHmai/frWXDbOqKp9+awGjbn5h2Pc
	W0uRF2iMuV1rc9hYjP08AhyLu8I1tg8CmABnWMMhagRywLaMImcFg5PZdUFYLZK7RmOawhTmwMu
	GsZs=
X-Google-Smtp-Source: AGHT+IEoXGsOsFKVqOBYhg+nwusrcWAAEYBwt70L6J1nAiwec11bw6QrS3VLNo8lhmy2JRpSLSuF+g==
X-Received: by 2002:a17:907:c78e:b0:a6f:bc02:a008 with SMTP id a640c23a62f3a-a7242c4de49mr1152116266b.4.1719520315973;
        Thu, 27 Jun 2024 13:31:55 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm8936466b.103.2024.06.27.13.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:31:55 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 3/3] pwm: Use guards for pwm_lookup_lock instead of explicity mutex_lock + mutex_unlock
Date: Thu, 27 Jun 2024 22:31:21 +0200
Message-ID:  <28807cb5d9dbce66860f74829c0f57cd9c01373e.1719520143.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719520143.git.u.kleine-koenig@baylibre.com>
References: <cover.1719520143.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=QOTjwplbHCXcvotTRKkaNA40OvJQror24r5KQbK81DI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmfcwqVI/cxrMbc84UnKoq9o1nWEvijwo726yEp 2ofFY9jAWOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZn3MKgAKCRCPgPtYfRL+ TkxOCACfzj/YDgG2yQX3xhP8mzSy+enaxwMI/LaYQIBrO8/GxmPc9qivFatpSH7DnJ424EcgJ8v PeuTRS6SVe+OmlNmqC8WqMR1nADB8BK8IW8o4ZloGupRvXd2zku+54BUeDxEZw5ihwFild/EeYu inE10VZGCTJWhUSKFubWbFW2pGYTiCEyOoGHQI2XQl2mj0JFK3p2o72yNdc4ixH1a3HqzS0glVw YERAGC5rgpVmUXecHkHhbuU6A1GpXEFRJidrOjWk4hRO6BaUPnn2qefnXgQO8Dbt0rxBm1zP3pJ BHIY5zbFK8T3yE58StGTmzcFPhWxyJhvwBa37p1ZpI+S4Lus
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With the compiler caring for unlocking the mutex several functions can
be simplified. Benefit from that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 57 ++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a0b1aee373bf..a79828f563d4 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1343,14 +1343,12 @@ static LIST_HEAD(pwm_lookup_list);
  */
 void pwm_add_table(struct pwm_lookup *table, size_t num)
 {
-	mutex_lock(&pwm_lookup_lock);
+	guard(mutex)(&pwm_lookup_lock);
 
 	while (num--) {
 		list_add_tail(&table->list, &pwm_lookup_list);
 		table++;
 	}
-
-	mutex_unlock(&pwm_lookup_lock);
 }
 
 /**
@@ -1360,14 +1358,12 @@ void pwm_add_table(struct pwm_lookup *table, size_t num)
  */
 void pwm_remove_table(struct pwm_lookup *table, size_t num)
 {
-	mutex_lock(&pwm_lookup_lock);
+	guard(mutex)(&pwm_lookup_lock);
 
 	while (num--) {
 		list_del(&table->list);
 		table++;
 	}
-
-	mutex_unlock(&pwm_lookup_lock);
 }
 
 /**
@@ -1428,37 +1424,34 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	 * Then we take the most specific entry - with the following order
 	 * of precedence: dev+con > dev only > con only.
 	 */
-	mutex_lock(&pwm_lookup_lock);
+	scoped_guard(mutex, &pwm_lookup_lock)
+		list_for_each_entry(p, &pwm_lookup_list, list) {
+			match = 0;
 
-	list_for_each_entry(p, &pwm_lookup_list, list) {
-		match = 0;
+			if (p->dev_id) {
+				if (!dev_id || strcmp(p->dev_id, dev_id))
+					continue;
 
-		if (p->dev_id) {
-			if (!dev_id || strcmp(p->dev_id, dev_id))
-				continue;
+				match += 2;
+			}
 
-			match += 2;
+			if (p->con_id) {
+				if (!con_id || strcmp(p->con_id, con_id))
+					continue;
+
+				match += 1;
+			}
+
+			if (match > best) {
+				chosen = p;
+
+				if (match != 3)
+					best = match;
+				else
+					break;
+			}
 		}
 
-		if (p->con_id) {
-			if (!con_id || strcmp(p->con_id, con_id))
-				continue;
-
-			match += 1;
-		}
-
-		if (match > best) {
-			chosen = p;
-
-			if (match != 3)
-				best = match;
-			else
-				break;
-		}
-	}
-
-	mutex_unlock(&pwm_lookup_lock);
-
 	if (!chosen)
 		return ERR_PTR(-ENODEV);
 
-- 
2.43.0


