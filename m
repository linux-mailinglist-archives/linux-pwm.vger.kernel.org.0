Return-Path: <linux-pwm+bounces-9573-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pF3zCeN0SmrHDQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9573-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:14:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5CD70A6CB
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:14:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b="Gmg/KqrZ";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9573-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9573-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8072E300C59D
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E02381E96;
	Sun,  5 Jul 2026 15:14:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264238911F
	for <linux-pwm@vger.kernel.org>; Sun,  5 Jul 2026 15:14:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264478; cv=none; b=t55KtnfQJbE3TcDis7g8aHWsMtOTUg+VekyLmq6J5Q4/Bgq4bvRt5OwHP7MJaZH/MNOg/aH+qqn8xbGhd/9rs/v1PaOv0VoJIvlrUBif2VgNl+3gUsDzzUTltD3xGJVXTqpK9lSzAY9DcvIXk/ZHNhuf3Q6qCIVG5YqNuSg1iuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264478; c=relaxed/simple;
	bh=zF3VNn7RhCP3SdAUgMQxXDAvH6U7gsx9W23EW2IlzvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQGazbRUPF/U8UEdExRliTgPMmZHf+4MtdkHEsMfmzuAo3xZlyYwkpoz58mGohB5nPPmTkI4roKgJAe3gK176rpyR5QAcZCTpyXS/P96uwdsWZn8/E85eJ+GAc0Z0SkxxIqYPUgZzOAAz5XN8lZgkbAjCRkThLNS0mJk1stOvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Gmg/KqrZ; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so11479405e9.0
        for <linux-pwm@vger.kernel.org>; Sun, 05 Jul 2026 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783264475; x=1783869275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuasmBppa9Pt1V2rpj3a+3Hsp0Js+92DQ0n/av5fldY=;
        b=Gmg/KqrZ3pRRXEyteWZjv2Kh3UQrcMQqdjcKS5ME/hKRE5v0UX+J15TOyBSEsQaDFr
         yg4hQqiMaWSmDQoioFNRA+fRvZEFfbDOaeK+a+GTdypGJblZqs/oach/ICYJFuI5mYhD
         MUFDZPLkrL+B0oIauPMDPFO93Z02C86U5ZxY4r2cl0AXm8OjI0QaC/zEjYE9VasxvbnE
         4DP6NMqFhByhIVlPM8R8gKgVez8+tX6X+DQfyl5arI/Kz5r8x1+Xo8o7PpJfBdsYNAgP
         438EakcDy1gY3syfN2bEDCSXkykL6sOlX1CaeO3fh21zxUlN57/yMhI8sB3CecEvjGga
         K/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783264475; x=1783869275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SuasmBppa9Pt1V2rpj3a+3Hsp0Js+92DQ0n/av5fldY=;
        b=fqwVSfmARekvZAiPTNeTDq70IhyCGIyjI1R9VF4Jw9YRyPrmORCEUKGJlWgN2Aof3m
         NlMbA+qZRPvwCZrN/obZCHShgM/rTG1X+bBKpKKcFV5Tm4LO2JyJjVM8+cNlbcx2Gb5/
         aHiZ68g1xMBzZmyMBpTQbX1ciY+76YkB6dqgc2Jnz7t/51ax0Vb/inbBGpnQOGzYvs9v
         edAB40hM/8DOY/OMLPz3WLp9tXppE+eMCaYO4rM40JqP7avt7sgdpf+oZfwSCEbifxoQ
         BKXVmaa+WFLKftmeEINitnhwB/kD6ZQLOxsIdOE9Swg2nxVZr33gyCgc6o6q6whs1JWw
         qvvw==
X-Gm-Message-State: AOJu0Yx1KisAOl4iG7+nvnQBoe1TMYrR94JKc/UtgDGmbgM08EY8YK0w
	ReJke/OiRMfjtI8RABpVFvmNIu7N6WEV7tJnutrzOP9VWUqk1TUfLdR08JPI6+h4bOLIbrjvEXA
	twE/N
X-Gm-Gg: AfdE7ckJlsnqEcwbElhqUgbdZQUN5uuxbYmZTKI+6QAFpf08imdCqO9D2cHquIFlJX3
	pmE4pMoE5LEuOsSiq6K/XDJwTmKhMblen/KW9neFQGv6qhYgciPEKQ+OQ1rL/mb0lKpWe+80bIE
	tv6kDrOkkIq8UCjXUEyM9blnds2XSVT2j/yGJgWIWizg1uDHiyyo9A2LDSUiDLM8jDVKEcj1jLT
	82lQw09Xi3jgZ6/rFibcYzp0e+WQdv4HEjGb5bMfn2OSAv0DMPHhneT/I9z1niSl7p4Mly54I+V
	4F1QSwTbspZntAmDxaSRvJaBNDZ9ruRAYfjIEDs/NAn83k2I97YwaquGKz4SE36aJf9Ydv9TNSi
	HQRQY2rSWNCsUFUzbTFOAXXoXy7BJW5wItACtpa7GohPe3ByBZ4M+BwQomIyB3OXoscAqqHBSte
	fN86Hig+hTGF8Vd6IBWg==
X-Received: by 2002:a05:600c:5309:b0:492:5551:19c6 with SMTP id 5b1f17b1804b1-493d11d06abmr84711155e9.7.1783264474827;
        Sun, 05 Jul 2026 08:14:34 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493c63b6f28sm292154225e9.9.2026.07.05.08.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:14:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] pwm: pca9685: Drop unused assignment of acpi_device_id driver data
Date: Sun,  5 Jul 2026 17:14:13 +0200
Message-ID:  <7e5fbc8c03527d50fd78b2b89ff22843ea1b84e6.1783263835.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1783263835.git.ukleinek@kernel.org>
References: <cover.1783263835.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=zF3VNn7RhCP3SdAUgMQxXDAvH6U7gsx9W23EW2IlzvI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqSnTHGmR/2rdYRT/VstKvTXRNO9PjMHQ1wE4N+ rlQVfiSnpuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakp0xwAKCRCPgPtYfRL+ TtjmB/9XQlidX786lO8S89S9B+8G7WA5PRvWU4EL5jVzAHVY47o/XyLosPjJvyOEXa7owWXJbXt e0Bsoebh7KPwY7dbspJ0QBRnm8aUYcKsAESZmp5VNbkoOoaNT9gLp+/cGwLML0Oxx9sLRMUux59 FVQmKSdkov8XtNtTRkZc+ik20by4/GLhGaNOGq6PQtDhHvVsPI9P95eYmnrs+rzJ7lBZiux5Jl/ xWqORB/0C3oA5boBUOiEkJg3NwcIIkf5nT0oDczKd6Kv1f34TQRS6cJzovluiz4bSCT2/YyUf0P n+Glm9hY4XJeABSBPLPxwxg7ijxCAWlyS8dJHWnECdZS0l1N
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9573-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:from_mime,baylibre.com:email,baylibre.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE5CD70A6CB

The driver explicitly set the .driver_data member of struct
acpi_device_id to zero without relying on that value. Drop this
unused assignment.

This patch doesn't modify the compiled array, only its representation in
source form benefits.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-pca9685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index a02255a64ea8..617a74de68c7 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -544,7 +544,7 @@ static const struct i2c_device_id pca9685_id[] = {
 MODULE_DEVICE_TABLE(i2c, pca9685_id);
 
 static const struct acpi_device_id pca9685_acpi_ids[] = {
-	{ "INT3492", 0 },
+	{ "INT3492" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
-- 
2.55.0.11.g153666a7d9bb


