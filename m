Return-Path: <linux-pwm+bounces-5340-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC1A7C88C
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE699189527D
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Apr 2025 09:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BB31E1E0E;
	Sat,  5 Apr 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZnuzkwwW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982F1DED4E
	for <linux-pwm@vger.kernel.org>; Sat,  5 Apr 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743845266; cv=none; b=QinqmTTIASRwNo4Rdd523I+AuJYjrg0hCnzsN/RwS9DLYn9an7WirFNA7JiNEB689bOTFP4yGLnawwX7CAooSVSn1LkdLdpoN8XxTIGlQPqK6mlqsAn+3pGf0LcBUPIpnOlbUQUJxRZekloK+1fJT1KCbtysjN20FqS22/Q3rdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743845266; c=relaxed/simple;
	bh=CS0yADAVELCrL+iW8Kx2zSuRfLKasMZMlkMKaonSN2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQBuzyaUr7nEJf0MyetwJaQjtQFWB/7Jr45flxBdoskFTy1pOOAuz+crGN+WqXjJA7LlGEP/Ds3xLx7oPf3QdX7tvEsFvkeG7JwJZJdZ2/jDj2QAzQdekirVnIJ3YcSHK9X+G1sbzfjUDDYxulYiQAE0H5l9D+v0rLwjxuaMEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZnuzkwwW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so5063243a12.1
        for <linux-pwm@vger.kernel.org>; Sat, 05 Apr 2025 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743845261; x=1744450061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9siO1d0OJXf+kmdtXu0qBtLgacxuY3xseG/1b/zOl0=;
        b=ZnuzkwwWm0UjD5Oeecp6Xi/1hxm3LL6bfor6+M1sPj6eFU2xQ+w33j0zK6tdKLkgE6
         HRL52UppTzeqO4imjucf+bkb+e1rZfSWGItAlcHR83T8w/m10+XhLZfhAbUmazvm7U/B
         wndKaG0qxpmpPlG7VXK2wcf/QuxYrCHGIfJQldJm+8FG8Dg4HZur6o+nwFUwDmFrvtQ5
         pulxFiPk7lOXFzZssvbTymwjbN19T/aPjY+Nh+oXpUuyP34iyqdfFQ7q5QqYJxWsfis3
         0d5rdJ6bbisEjEqN1izhlV/2lRVS/S8m3ZzOpl6YLaLNkX6vrnDb1vHagnEXOuk8E/Gn
         KCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743845261; x=1744450061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9siO1d0OJXf+kmdtXu0qBtLgacxuY3xseG/1b/zOl0=;
        b=lD1SurOfDIf2q85ghEJsMH6vULRezqUeNraBmF6cVcvyEyYKm7IQqkxxC+B4yvSMGV
         vmvCumoOmoAXr9PosEfdqKplVZ8lvprKzE9kt05rAmWHAIKFFcaS5fZkP1VCrEsvLXHs
         eECPIpRgGslcK3ES869pUhyr5D1nX0v0UBR6L+jeXrOgQLoqhuMJZ5MluajZwXhnqeFb
         rahMlMfVGcA56a02CNaPp2wM6E+Y1aY6YJrn7FkphV1k/ahZ8K9RQXFB/fMpenMnhivu
         ZzEA4GL0V6ItrWdgjsxUfQBOojn8xGv7i/Ww56bJBosxZid2DqSiGklr8S7PNFkeQjjR
         I+nA==
X-Gm-Message-State: AOJu0Ywr0H1ALfM8weTzNoVjeV4KrN0nyUR1+l2HmLFdAaFCJNf5gpay
	OClGG74BMpyPEF9vMgYg7uRtnqBjxHQgzsKuOqp1O9uPQyajbL++q+DnbrVQIcpxpmCtPK8kcxr
	d
X-Gm-Gg: ASbGncsn4DdQzjW4mPMWqeAz/xs+rCcB6AvlsoSqpv3BIjKcYOpuzDTz6eJIPegw/c9
	R2by+DgaWupVhgQtMRnAMD7IgPbvJvHvI+Mb7Kfwzo27JPdwT6RYIV0rZfUR+E/NAUODTItBAMz
	avS6/hUIen30CJ8bMVN8F56wiAoNj8uHf4hMjZc+/2TWHZkm6t9WuXBoGclwFAlEFeuTEVw7OB8
	wSkCgb7IrLaXjvotKu3YUiJSOAUcZdui2BsESHMej5Ne2nl7xKfSRLc78sRFvMufid8RI/VdX3/
	XGwr2k4k8Rz40xrzSIHrNEc6rbTF8739XuFMQEV3AMAMP/9k6VnRAQie3mTD
X-Google-Smtp-Source: AGHT+IEHAOg5qx1HK7FVLs7W0Qxv+LAaqChGFqw4tVT6n8qLbrhokvGfFob/wI9f+X8IvCQ2yZT+tQ==
X-Received: by 2002:a05:6402:501a:b0:5ec:7909:1a with SMTP id 4fb4d7f45d1cf-5f0b3b90213mr5271124a12.12.1743845261362;
        Sat, 05 Apr 2025 02:27:41 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f088084eecsm3379240a12.57.2025.04.05.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 02:27:41 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] pwm: stm32: Don't open-code TIM_CCER_CCxE()
Date: Sat,  5 Apr 2025 11:27:14 +0200
Message-ID:  <7803f63b1310ddbd706f51f2f42d30b6dd786b03.1743844730.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
References: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=696; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=CS0yADAVELCrL+iW8Kx2zSuRfLKasMZMlkMKaonSN2U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn8Pd49kNiv7t7/o7GyEzogIHT7M1lDxUwJzEce gRP4hWfBuqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ/D3eAAKCRCPgPtYfRL+ TkdAB/9t2HkMqkvlwY+Jf7FhSonomLwZB3nkfQZIxIbs37gW1zKYpAhW6k4zurBX/T+oPhnxlQv S5KxirYFhXffyyRqQncJrWlccSheAw0YjjPm7KCRLGqPfVO4dCvQDaYxNVfqYouDH/BK73jwIGe +ipg3OBU3Z2JOcrxZ7nRNsntv+UTTnGcAdCcu/FybQ11FZgcDILFaBDKYIhstF20JRKxb6bksfC /4e2hEFa1YynnIZ/p+efhShJeeO/UIvNHXhmmsT9hHxDR8LxwrCY/NMRvASLGSuPX/eZEuZX/Ez PmCs1OBnCmlGUeEdy8pu1jPMM/37D8zcim5+N9bBUnm+MfUk
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of manually calculating the offset of the channels CCxE bit,
make use of the TIM_CCER_CCxE macro.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index ec2c05c9ee7a..c6625f51a199 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -88,7 +88,7 @@ static int stm32_pwm_round_waveform_tohw(struct pwm_chip *chip,
 
 	rate = clk_get_rate(priv->clk);
 
-	if (active_channels(priv) & ~(1 << ch * 4)) {
+	if (active_channels(priv) & ~TIM_CCER_CCxE(ch + 1)) {
 		u64 arr;
 
 		/*
-- 
2.47.2


