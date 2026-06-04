Return-Path: <linux-pwm+bounces-9244-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pULWELlNIWqMCwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9244-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:04:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B73B663EC96
	for <lists+linux-pwm@lfdr.de>; Thu, 04 Jun 2026 12:04:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=I32NKOWI;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9244-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9244-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D47F130A1FF6
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Jun 2026 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A838E8DF;
	Thu,  4 Jun 2026 09:56:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5E38E8D9
	for <linux-pwm@vger.kernel.org>; Thu,  4 Jun 2026 09:56:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567014; cv=none; b=NiYnxvD7lYDMUBt97d/uPpv3bRQrQgFlLQTHnHwuhkr6x48uT46wVb1nRLOBpg7ooSOK4VKYlySAO9kC+nGXX325Xl8tN/85O4/6Eozt7mZvug4U2RqWG5FQfIctutAJXOjB0T1+53RUQe5gz6bG7QcLrPOmiMtlc9nmAodkybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567014; c=relaxed/simple;
	bh=EB7Ettr8Ri2NzRDhCKydd64Ve4kaYLDjIWunWqzwUuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpOOdfx3VocI9yMgj1UaRA+f1MoVE0IKx4xdRgUuX2Bn1pASlcqcVOd0v7OBkn1oj/BQhalEeZB+n1vwZg8SXBvUvZqUqAOgFto4yIp8zProNvMWx4qQi0+/DXC0PLI5dgJN4FisozfMBnpyoIkDxNsqQyVfpuNGP8hK77lkzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I32NKOWI; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3e03939so4045305e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 04 Jun 2026 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780567012; x=1781171812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie8fAa3TVGPNRGFIullgvrpG6cDSByumclgvyRIodhE=;
        b=I32NKOWIj11L0AOOAE9PTPByFiRc79MhMQvqtAD1jko9drrGiTCRoszYqmAT09JNWI
         4gmj+pAaALp9An7ZWcCANlxtpWu37yCLb/PGnzgUBWdIPX56+XEKVe+Z45WT66OnDuNC
         VADZyProxCHs7DzP0e7KL4rCkeRuecst/SUQMCqhPB3aQcIxgkBHO+O9v9qYd0xbZBu1
         XrPOvHdSTzxiRtrq9yiFOPllU6yORfbAW5Si1+PzSJR6dOxaY8pqVy6HlNx3YvR9YMpf
         jx8eyk1dSXSSy5UU91mGLRGs0wmtngE/LfrDN8k/A19elVI7MDVHdyCJXXwa7Cpoqh1S
         twfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567012; x=1781171812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ie8fAa3TVGPNRGFIullgvrpG6cDSByumclgvyRIodhE=;
        b=F4Hqu0VFAYLREEj6QxDHQ9aZnSrAuG1rcM5vX3l4fvFvhYVdQGKWnGUzrAk7aiTzVl
         MRTkYiuAdbfynCexiMI3P8K9lNYzS8UYSEnrgHL4PtevAOcPiyKdyEI7k+PfuUOMFUAj
         +SZADhxwCSKqpkQRUqSCBxDUl/EbAmKLNrGsXp8Lh7E1kR7iwnHYJ9y3M6rS6veG8dr/
         TslB8N0GT8jkcLE4WFSvPelK+3Ik7rljoG895xfJtUMxgiwUGsInsSGFs84RlAu+Ef9G
         uBVhAzjLlkdcXdsdG0P19uVFhx7V7msqca9Psn/xBBn8gaLn4pW/ud1pH0AkoE09U/Xm
         hjbA==
X-Forwarded-Encrypted: i=1; AFNElJ8HsmqE48lHwFzgfCcoS6gD70ZzY4AJjkuWKFLKN7fa6TSWor9Z62Lp45+GKobPkVMzTytSl59EJlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyipQIMr+ciNKZ+hGq66mdpdhB/c5tj87tPnTdxbn2Gs4i8lA2C
	28TZ+khSxqDWppVCQS9gv7BxXe9SU4duqaI4c0euafUppZafz1tS5Pf7
X-Gm-Gg: Acq92OEbl0iv/2FGLeUqqAqs9pzhqjctUeSCvGCL7HhkyxJWZIcUCTC9y4SDQVJ3xlc
	AG4vNkuFU99HGvpagZJj2y0lMJO1yRAtVaqXoXgkI1ynswi998XTetJVYfMiV2yC4JgaZnGwlB1
	m2Z53iUaREf8MljR8HHhFUBQh4S+EIIpxJP7N3fXDTx+u2uzlzCvQKX9v1vRJDqLbqZD/qbLd24
	cPopHOLtF7pAvMsK20kpOdEWrkOSs4bPCBzZr2HvvSIR8D/jl5+FJKhVM2D2zelml6ySQrpTeUk
	rgwNCYN13T4X7yQI4/V8sRBdHLp8e7LETzby2ad4LHpPbBqBBFWSblbOiUY21RDgM9FholARfQe
	3UEyyZU8FRtsUWe8AqJK3I3E+6HPAMMWJv1ZdDM7E2qgPe4mVqFufplwWGmAlSpAE+4JSmk0vDk
	fiJ6SgINX3NPidfu0LRwL6Y4RmAxZExggsgF7KNd6z96Qh11pjJab6u4kxMwPd4Oy0XGSqfA==
X-Received: by 2002:a05:600c:1988:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-490bc4d7071mr45062895e9.7.1780567011787;
        Thu, 04 Jun 2026 02:56:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a700:7301:1615:3574:e0c0:837d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm38037335e9.8.2026.06.04.02.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:56:51 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	stable@kernel.org
Subject: [PATCH v6 01/11] pwm: rzg2l-gpt: Fix period_ticks type from u32 to u64
Date: Thu,  4 Jun 2026 10:56:31 +0100
Message-ID: <20260604095647.108654-2-biju.das.jz@bp.renesas.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9244-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com,kernel.org];
	FORGED_SENDER(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:biju.das.jz@bp.renesas.com,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:biju.das.au@gmail.com,m:stable@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,m:bijudasau@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,glider.be,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email,vger.kernel.org:from_smtp,bp.renesas.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B73B663EC96

From: Biju Das <biju.das.jz@bp.renesas.com>

period_ticks is used to store PWM period values that can exceed the 32-bit
range, so change its type from u32 to u64 to prevent overflow.

Cc: stable@kernel.org
Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6:
 * New patch.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 4856af080e8e..c9dfa59bc1ea 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -81,7 +81,7 @@ struct rzg2l_gpt_chip {
 	void __iomem *mmio;
 	struct mutex lock; /* lock to protect shared channel resources */
 	unsigned long rate_khz;
-	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
+	u64 period_ticks[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];
 	u32 channel_enable_count[RZG2L_MAX_HW_CHANNELS];
 };
-- 
2.43.0


