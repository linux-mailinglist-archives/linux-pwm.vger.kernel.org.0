Return-Path: <linux-pwm+bounces-9247-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rTPhGPFNIWqbCwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9247-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:05:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C19763ECBA
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:05:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HGoR38PT;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9247-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9247-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE8A830BA2FF
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCBD3FD159;
	Thu,  4 Jun 2026 09:56:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00F3F1ADB
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 09:56:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567018; cv=none; b=NUbDAb7KO//Lp65rBTg6OEZahJ3gwXYZ5esEbygkj2fKzra/xVa71ZmizoqAc9W13fSssFoChOjfHfXTzTOeCnSNIdUwdjCz+qlcQ8enl9r6+Y+c6LP+gjbmoEBrAHknFXcTOez3CiDoRlmFQLwOkq24el/TEfK0aHDNVruUBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567018; c=relaxed/simple;
	bh=NlDkVlMm1JuUzeAtDRZB+Iz/R/2FhoZf5pp2LkeDlno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFl/iJ9y9Q4toHSTuD15746muQlZTMmogSggBBcIEQDvpY6HgbPWeGcLjWlWubJPf9wKuOmlLxj1NO44Ywy2EL8p1gJqo344N9CZBlkTT95w7qGu4L6WVXxvtVLmKj15XDMfcMwFaYl0MF1j1ZNaWh5ZYbDY7ZNM+hQnRDRZEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGoR38PT; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so2671845e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 02:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567015; x=1781171815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgXQ8Wjt8CwTPh1rq91BMMsmDAAHzwhsHaimZBrxe6g=;
        b=HGoR38PT4SbCSDnTWDUJ+y+snwDBzNTyuUIL8FK+/zdIlga+C6kBvrXlMGfNk5UE9E
         C6BG8vjw/a7PuzGSAUbbba0u/8kTTDd/uBYkvbgzp/Ceh27JUX/Bzr5njo9uSnNaFNZw
         FYaTmn6S4IUiQKCJvAbmWhpeigXKAfPqxP42coNOmtmOJrlmmEoJUu4jZVKgGahpNt7C
         S0C6e/3pP/SIOf6PgnYVml5fXyFIySzNgboi5Nn2ZJve1FPAaB29nfrBggt/c5NdHrFQ
         vGH9D/PKa/KrQu+w4Bcww1wZKioOaSbSMb3p0Uz7+jRxEypgkX74wM3VWLcYD500ocv+
         YdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567015; x=1781171815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DgXQ8Wjt8CwTPh1rq91BMMsmDAAHzwhsHaimZBrxe6g=;
        b=pwRe38lJ5ZaNpVWEoQta2l5J/W5hEhSkkxXatf/T90I7w7RYW5sterikHyOSuy3FZd
         tuya/sY+JuVfHlsqAor9w18Jd6zoBA2+yLh2KLZ4h3kHGVawVlHiEaon4u1zB5V27wHk
         e6rkv8rOWdVatzlETf8zSAme99v02bWLz3TcfJOUZx3yYI9ga9elsVsCHysqkI3qfwUd
         vDmdji6zdkQz9tvErIIC9biJv83k7LeP24n9cD2N4rGr0ozh2Crk653hFmbnWaMwuoGr
         GNytlSaHfTZEGSfb8CRrHhxpVDdfcPFyQ9So5Q1kB+oGY6xjUCcFxXYFXl9rsKmSFZTw
         hY8A==
X-Forwarded-Encrypted: i=1; AFNElJ8Ry8NEychmUwJeFkhZd3lFSW1yvvLjam730H19xaSxkRyqAnQPfMbGG2VCIAeSm2of+MktTHdJtnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAm8C59Zqs4UPuiTOQdIGrb0qVyVQ4bZObLX4s09fexJi7xwWy
	nBNiFgVMOzsQAB7a7YerDR3HHbDkGYmQnHZNXIiLqi37ew6tPoaRNjEAAvjCyQ==
X-Gm-Gg: Acq92OHSnxAO2HuVrXPtZ+TjBKiHdUUYJTvrk2M8qFUasr3LCRDNVYtLYUJ6dmLfQMQ
	8YycThhfX4YpgjgRlYfUQPKjF1axeooZ40Vml1b0iEVVyur2BTwf9kZALylWEL1Jvxb0Q/xcEkG
	LkrZ7m1oxYOTkwWXg84xqYkBZvc8q1RQUz7W4v5oQSxVfWJniPKtQdq24RvjCT469JZzGq2glNN
	7xXT/X30tpPQ/vr5xILY0AMRvpC1ThZCJmAGuDj7umeq62DanYMvexVPRkYwutIWyXCwae6snBu
	Zo2su8i4cq3EXTZ7XE/JqM4q5SaRiuJTf/ViyCzR6AuQXeCQKUYYuhfhd1dl/fVlAbBeAblr++R
	n672cOeKJyT9Z+4sAN8AC2U38/vHSU2h1jbyuV5iiF8s7wF+/8Kk8HP5voVKHiNOz2CPFHu/2JQ
	ymPni1PuC1Na3x6r29zJH2p0E5iK+FQiFYC6K9WVHKYi6trHEsAm088NFlAZM=
X-Received: by 2002:a05:600c:8b01:b0:490:6237:5200 with SMTP id 5b1f17b1804b1-490b5d36863mr117178755e9.10.1780567014917;
        Thu, 04 Jun 2026 02:56:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:1615:3574:e0c0:837d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm38037335e9.8.2026.06.04.02.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:56:54 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 05/11] pwm: rzg2l-gpt: Drop unused rzg2l_gpt_chip parameter from rzg2l_gpt_calculate_prescale()
Date: Thu,  4 Jun 2026 10:56:35 +0100
Message-ID: <20260604095647.108654-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-9247-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:biju.das.jz@bp.renesas.com,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:geert+renesas@glider.be,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:biju.das.au@gmail.com,m:linux-renesas-soc@vger.kernel.org,m:geert@glider.be,m:bijudasau@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,glider.be,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid,renesas.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C19763ECBA

From: Biju Das <biju.das.jz@bp.renesas.com>

The rzg2l_gpt parameter was passed to rzg2l_gpt_calculate_prescale() but
never used inside the function. Remove it and update the sole call site
accordingly.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5->v6:
 * No change.
v5:
 * New patch.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 47c6c2eb3067..49b95e53ad83 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -132,8 +132,7 @@ static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 clr,
 			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set);
 }
 
-static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
-				       u64 period_ticks)
+static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 {
 	u32 prescaled_period_ticks;
 	u8 prescale;
@@ -300,7 +299,7 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
+	prescale = rzg2l_gpt_calculate_prescale(period_ticks);
 	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
 
 	duty_ticks = mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_khz, USEC_PER_SEC);
-- 
2.43.0


