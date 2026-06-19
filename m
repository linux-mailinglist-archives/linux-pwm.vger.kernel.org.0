Return-Path: <linux-pwm+bounces-9340-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q37SI+FqNWpMvwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9340-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2026 18:14:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AFC6A6FDC
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2026 18:14:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=Zo9JQ0BU;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9340-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9340-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 914093008683
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2026 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FFA35F16C;
	Fri, 19 Jun 2026 16:14:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D839903A
	for <linux-pwm@vger.kernel.org>; Fri, 19 Jun 2026 16:14:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885659; cv=none; b=LM5ofyDxVTnYHMzsUSkXwVD2eKQ0nPNmOxcIqLv/ZCm03grjIjJJJ6Im7Ye5+T6ytaZFZvFn6Vi1Ha/Gq1GAYDNwdUXWjPFwa8KHIij/xlW25Crl/IE5DwVMs1knpckzx/E1YpeOaTtj43pQqyL2LetM5HqnVycTEf27rIPoUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885659; c=relaxed/simple;
	bh=fnNxGLFaq2MndCm5i7t2bwkeFXbozsUNQN1veAni4p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mvmJWoKTDyN+57LybfOVnt+v1U+RHOSZC4m/grQcmrEhYzFICoDmWzh/Bco67BRWo8YYegtzDegwhSnEgBnorenaO7FZnmPeU+RBu34rk1jfORgmzbXQzeW3yI3YaaTNjpxDx/nplGQmTMFN+Cz4zgNqamsf1pptkcJckjTKR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Zo9JQ0BU; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-460662fcb4eso1650239f8f.0
        for <linux-pwm@vger.kernel.org>; Fri, 19 Jun 2026 09:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781885656; x=1782490456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIOoNh7TSiUWG1xRX9QCBSnyI959oK0JOauJmzZgdRU=;
        b=Zo9JQ0BUJLJS+ILIgQRhBDzH0KTxp6N8JttA8pCZxSMtY1jhsCHYi05ZcjAn5KHrDL
         FMYL/Cnd8Qx3dcEppa9D3xdCUt5lijvF7L3eyV/8W58Alw1G9oIwyhrLNy/Ilzqyul6v
         VxY+bKQ9X2PXfjgUrI5ve3hv7WdtM5qg5A0lIL/fqnTPXWczKSVcaq+RfNBnAO5q9EH2
         u7UaezNfo5XUdEAwPpbOUulTZrzXyJBxerblo4a4Urpg+WPcLR7AqnAI2SO4elvQgXnZ
         p/ykKkzXtvaOUZjhS5brNE0NRzDlOf5s/04Th2z+WNfl8Oz/R6j4zZoC7YmyRkDFsErx
         Sj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781885656; x=1782490456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIOoNh7TSiUWG1xRX9QCBSnyI959oK0JOauJmzZgdRU=;
        b=PgttPpvnqBsycnSvA3DglsM+1O3LECB+rdXOrt9O8speWb/RMO1zKfz5PfY0CihM9h
         /5RqJaSdS0HyDZfV5na9MsWmzfd1ZQn7ea7hZGMy0NNJc5Q/73lIJNcX59iA+/HoRr3z
         fcYtYbCHRj8Dcy8/Yy9UVBqcFWSGd5K5GPaVO0+oMwh3DTVzWuRY4ei9K71zpptqfd9L
         Rr5yrtaj/wTOoR6bkPh7JD65FfLl88ey3cFr66234Eo2GK+Dcct4wYD6iHZ4zw+HAsvi
         Z8ZKJWygKWE208mgGr/0jwSwFfUMLURM1jj7yucTLcpFa7XKcC4AT/iWgC+LszpcQ7TX
         zrRw==
X-Gm-Message-State: AOJu0Yzo4rH6mltMjxhrPIwXofj9BYY6LDTPGl/67g677AvJBNUrT4Kx
	UsJbjNUk/RXy0KHVU54O2/fkEqtnNBm2XUHkaja3pLH1ENoY9wz73bQKkEf4YvR+cs3ziol/sLL
	SayVd
X-Gm-Gg: AfdE7clGdzK9NDF1QCSDBeSTF99trhV7OrzVVg3gmo+5+BRamexcO3gvZ/xe4/wwmeA
	VSu2e4CjmEHDfg5WlnnedfE9sx/EjjMM4MVALtm5PFYROjmB5icFRXF0Glr1nPJBY74KYB3Rmhd
	hpiSkxpqbnXMnHdv+W26ejklIqjbgj4cFYaCwToiSNfkb9qq4Z497O3jm9BNF2Q+18VoNOAh7Rz
	FbIi6tBhwuKTqAivQGi8pjvG8fBxLASzjrpddkArjzkkVPADmOlUtWCFjieHsXDMh4kRNRvHUUB
	fS0UU90qKRw61jQGgIjJNkEkNbCcRP16PVrG9+MKLuCREzyKWRJkL6c4WPxpqMGcke5nqdtTACR
	DeiFgfP2VTuseg/ku1XP4jNhG76ZpPXQNrC0DmxOaPQiG0uAQOwmQMS1gqqGRTTaXjGHuc8/R7R
	vzYF9xrWVPkS3BF5dXr3q5SxAayh4CnX7pNt+Sm6xff5dScJgVxPhFb9YiDhVqqR/hAYgtmgzS4
	wk=
X-Received: by 2002:adf:e004:0:20b0:464:f0a6:74b1 with SMTP id ffacd0b85a97d-46509d57e7dmr5813772f8f.33.1781885655984;
        Fri, 19 Jun 2026 09:14:15 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-466648c698dsm177024f8f.16.2026.06.19.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 09:14:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: mc33xs2410: Initialize spi_device_id arrays using member names
Date: Fri, 19 Jun 2026 18:14:10 +0200
Message-ID:  <3fc7783506cc6429b8942cb7294926a6d4cb353e.1781885606.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=fnNxGLFaq2MndCm5i7t2bwkeFXbozsUNQN1veAni4p0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWrSE+XINa5e5pMifZflWkVDc0Xk/cOmQlYcU dhgH9lojwOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVq0gAKCRCPgPtYfRL+ TqHGB/4sYAfu/2AMUIUceGc69YlTPDdFaysc/pAp52ltzm5uB9MWitYl3camFkVaqvztqFLVHU/ 42fI9PsAuiK6qPMZ2Y8aYmmb0ZY7lNYv3ond/RvoIJBxWfznPXH1Rx8EaxaX5aWDrZq2CnyChMf zxj6B2k1Alr7jmH4F/Dak/mjhF17Xz5JUvwjJduqIAr4k8dDHq1ZhCgZtxEhZIKMo0fmHcmpWDO rAgTITYcMg66fs8gxmSw1CssAenAeZfr57mJFw6UTjpSLckIAI1Rubm47GeaalTBHHcllCPnW6z SILTJh8ya6Y4spbj0HztF3om5/ajK07hqx2uQnhev1m9iLge
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9340-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:dkim,baylibre.com:email,baylibre.com:mid,baylibre.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88AFC6A6FDC

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
spi_device_id that replaces .driver_data by an anonymous union.

This patch doesn't modify the compiled array, only its representation
in source form benefits.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mc33xs2410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
index 6d99e3ff7239..9f89b60dda78 100644
--- a/drivers/pwm/pwm-mc33xs2410.c
+++ b/drivers/pwm/pwm-mc33xs2410.c
@@ -381,7 +381,7 @@ static int mc33xs2410_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id mc33xs2410_spi_id[] = {
-	{ "mc33xs2410" },
+	{ .name = "mc33xs2410" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, mc33xs2410_spi_id);

base-commit: 3ce97bd3c4f18608335e709c24d6a40e7036cab8
-- 
2.47.3


