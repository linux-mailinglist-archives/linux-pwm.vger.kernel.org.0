Return-Path: <linux-pwm+bounces-9574-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z+zUMQd1SmreDQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9574-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:15:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E02570A6F4
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:15:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=pCTXEs2k;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9574-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9574-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 436D73018285
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAAE38B123;
	Sun,  5 Jul 2026 15:14:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452438AC72
	for <linux-pwm@vger.kernel.org>; Sun,  5 Jul 2026 15:14:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264480; cv=none; b=EXrNxrmHaEOolPffnV3iYCBWjzdE3bEy/Ir2fqBlu/G0o5HgRWrYE2cHMr/aOYEjaM9kVIEIHOiHYgwJpJcxb2a7IN8CkPiroGibfMmAbd4XNwKitW4iIR5OTw5YjzJB8F2fxxr+uKvmt7CCcGgqoNxVT+EK2joFU/tgi16APXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264480; c=relaxed/simple;
	bh=sNOvo1j1BVK2SkKs2iy52ofW6GrhDki84ncViUoGyRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7sRadyMk8Vqb4UDaBchETIF2TcfYhUXtP9Z5Cf3jrh3vpWjIHHv5HU8aePL4sjUN6b1eKD/z8LxY7LICB0bhJ5r8cikCx9CV9sk37gOJQ9KJShUtLgxkag0/WfDd7yO1/pBu/uI/WlnwSun1RWjGHPpmhIMSQ1ojsmWkLy9kcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pCTXEs2k; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493bab44440so10924195e9.0
        for <linux-pwm@vger.kernel.org>; Sun, 05 Jul 2026 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783264478; x=1783869278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9j6+7Y60iUAiJX3tBBkrUAq02eEDb2OjNu4wGwISMQ=;
        b=pCTXEs2kQsQ3VyEodlak1FZO2ehHwrdJXKFkRdrzE0nT2A/RVjMI1VCyxlPsOr5oG0
         +bpnkUuYnrEE9CDfKD3DeeY4t4xJ7YL5+oEZliyCXEuKQ3U5ay4JoFe6o3V28IK7zwmj
         +B0BAknsjwldhpGT5u0Kji7PlpYZn+PlIzEttepS+3eB2BKYgEtSvni7iqLFmBa0Q4KG
         5zMOIGXoR0ptTi+JzEJBW0s2zC5vREvfXBKv5JLcbyInTYdBHeIDjVtmePbuc1vYEf68
         yFjFJKaAxlWBeUA+ywlaCJB7LcebX8bqZ/HzlRWT8x5b3x0ng9NpBIKnu5n4fLA8M5h6
         wtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783264478; x=1783869278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v9j6+7Y60iUAiJX3tBBkrUAq02eEDb2OjNu4wGwISMQ=;
        b=RP+0M+w0+F80y97eVTjO0WzQ4IgEubALkGmztgyH7H0S9Ic/sm4larMio8JYuIanQf
         9zgYe3Ox3vtui1JvQbp70kYQrwO/sEepYXdHLEje5ocItZNdZv+gBStj1BQV4FtPKOCs
         AB32pCfbj3Gqpl8HklydRQGrHE1Xj0thY/AXDZvf0JBHdzp2lsN0gO6BqTIjIiwk3DXk
         /tpGzHPL0zFZR0q9AZCZdVbjT/XbmOLWWBnccddnfdLltpSanToFPuoDx/RNEbLo1+/K
         oO/vsiXcBH81zyhOdi4EQWUwwYhttwBgcEGo0ESOD+TThLP7FoxExC9R2mPRpKfgPT4o
         CV+A==
X-Gm-Message-State: AOJu0Yybi6gaHVckIRSRujktZdoBz7wIF8schiUWCR0Nqs7cTyqQ68mR
	zUPNaftcBFTql0wmBxaPAIsdcNSeRKALA/UrOiS/hXxuh+oZmWdt4KzLBzM8AOBB9/FyWoubBFk
	skwx4
X-Gm-Gg: AfdE7ckaH8xzKnrOrLyMuJkmOemQpK/lVdmiOCIAuQv8tacxQuPkwRCLOMJ2FE6Lwlo
	bwwvtnsw59E+i/4LwyhlLzsowgCO4KY6uhkoYqWIDAOASHUxflydhnL/tPReUVzBL/uVzuc2ZL4
	2D6gqLPf7HmcKuX7JL/hGYfezIbdvMYrsQ/1Kwu6su4EBR5k19ku6XU4G926Olh1Z0G1B+R8Qhf
	fIsZTuHbGZnp4CsNHPilfZzX9MkcHvKCHULeKPY0p7Y9PtdIAPxSdBxWWLEn8/OY4DGYWiO6W7E
	CQEVY/dGlXFSHV/YrvuRcPfcTOzpcy1lQqhbAbiLicvvjqbNsXYLMKBKsTegpxGepcYKrw1C+jz
	1iZbkG8GmfFD/eRAJn4KWx4nXwGvZI7gYfy3lm9f/nKXYERQeFQxYXiOJMg4pN70Ls/w+R5dIiE
	LkccyLH/Gnjjz0uXJBxQ==
X-Received: by 2002:a05:600c:c0d1:10b0:492:714d:8c4 with SMTP id 5b1f17b1804b1-493d149688amr49186055e9.11.1783264477641;
        Sun, 05 Jul 2026 08:14:37 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493ccb4cafesm197853905e9.0.2026.07.05.08.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:14:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] pwm: Use named initializers for arrays of acpi_device_id
Date: Sun,  5 Jul 2026 17:14:14 +0200
Message-ID:  <1a03da9625e1e6bf2befa13c64525e2dfa2243e7.1783263835.git.ukleinek@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2684; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=sNOvo1j1BVK2SkKs2iy52ofW6GrhDki84ncViUoGyRI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqSnTJSyRmkypgw36sK8aHoqb+zHDRV06KBkwP6 E8bP2r+FTuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakp0yQAKCRCPgPtYfRL+ TmZNB/9zEMQWLkWGfUDpjmO6cvTqolXHrSgV6jrib3HotepTLsJnPdFQKLhKAbqRZFl9RCNgcrZ QQuXFiV06J3Q16c5jdG4y+ZFCrqlM+P9vKoM7n1Lct6OpmMmDo4YwS3ZlJ+0WpRTTUEySgJoV/A 9T2TTUgLPllYQQf/zEMzBvgJQ8SJNYqPraqa+BU7jopKmveoPHVyunWQWlRmYqUwInTe6XzJZ1D OITAhwe03BAtJUIPS/F043JsX5x/+c6EVTIIEUDpIfwpIc/CAFVN1H809XdTQoM+OS8xQeu9SYS VwVdW7muGT01TzhtKzvbfj95rZbkibzWP9xCmK6Gnz2iLLAM
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:zhoubinbin@loongson.cn,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9574-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:from_mime,baylibre.com:email,baylibre.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E02570A6F4

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
acpi_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-loongson.c      | 2 +-
 drivers/pwm/pwm-lpss-platform.c | 8 ++++----
 drivers/pwm/pwm-pca9685.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 31a57edecfd0..f2fb35b7af2b 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -269,7 +269,7 @@ static const struct of_device_id pwm_loongson_of_ids[] = {
 MODULE_DEVICE_TABLE(of, pwm_loongson_of_ids);
 
 static const struct acpi_device_id pwm_loongson_acpi_ids[] = {
-	{ "LOON0006" },
+	{ .id = "LOON0006" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, pwm_loongson_acpi_ids);
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 653ec9d0c8bf..0d4f8bf04e9f 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -59,10 +59,10 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
-	{ "80860F09", (unsigned long)&pwm_lpss_byt_info },
-	{ "80862288", (unsigned long)&pwm_lpss_bsw_info },
-	{ "80862289", (unsigned long)&pwm_lpss_bsw_info },
-	{ "80865AC8", (unsigned long)&pwm_lpss_bxt_info },
+	{ .id = "80860F09", .driver_data = (unsigned long)&pwm_lpss_byt_info },
+	{ .id = "80862288", .driver_data = (unsigned long)&pwm_lpss_bsw_info },
+	{ .id = "80862289", .driver_data = (unsigned long)&pwm_lpss_bsw_info },
+	{ .id = "80865AC8", .driver_data = (unsigned long)&pwm_lpss_bxt_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, pwm_lpss_acpi_match);
diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 617a74de68c7..0982ba4f566c 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -544,7 +544,7 @@ static const struct i2c_device_id pca9685_id[] = {
 MODULE_DEVICE_TABLE(i2c, pca9685_id);
 
 static const struct acpi_device_id pca9685_acpi_ids[] = {
-	{ "INT3492" },
+	{ .id = "INT3492" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(acpi, pca9685_acpi_ids);
-- 
2.55.0.11.g153666a7d9bb


