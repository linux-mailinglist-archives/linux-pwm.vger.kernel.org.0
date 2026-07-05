Return-Path: <linux-pwm+bounces-9576-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WoaTKkh1SmrrDQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9576-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:16:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0153A70A708
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 17:16:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=ogDYoaBk;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9576-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9576-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D442E300D6BF
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7130738A72B;
	Sun,  5 Jul 2026 15:14:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A73812EC
	for <linux-pwm@vger.kernel.org>; Sun,  5 Jul 2026 15:14:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264487; cv=none; b=ffQkcYIA3zJHtQxNyFsAGV4V58PKX0rb5S0yFTZjgDGFAY9ub+ECm0mASuEd7pBJpEn7AH9jXU60mkSaErHxCDXe0aRSyz7L5YDrNXz77PCs9uu/uATM+fC/loA4TtO4NG2EqQRjzyHqlcoqpmsZ8mgJ11/JXzV4tgOsZ9txMME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264487; c=relaxed/simple;
	bh=nQg1zr12uErvKfv4CjdDXREaeCl7UBYzwGESaPAzRn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqFMQpJf3m2ShaFkC6ejWksvh79Kf/ZSOzgl0867bIHVj1WuSIGkyRlpTxQAZ9b4Hy+Zooh4iZ08bvQnAORbEzVCFqnh9WzTHLmc0TTDiy2njG+UroYCfeyOAOO5eD2VfhFweaMk5So/RRgFHSxXb8t+8sgDtitJJ1S1C4wJytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ogDYoaBk; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c2b3dc8bso14800005e9.2
        for <linux-pwm@vger.kernel.org>; Sun, 05 Jul 2026 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783264484; x=1783869284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR+FvhpeFlO5SaKYOf2iYX9QVp9scXDqtxu7Lek4dW8=;
        b=ogDYoaBkra1XwFG9xrZbxININzyBH1zkWJqQVzZtJBvvO4j6+8WO93hTE308rYm8JH
         OCBgtNdE4PSt37uwpp/PRbdmE6MjuypXDHS51ZPRTQ5CKTKYvsXN2mysXO3LoaY/x4H7
         +lWXKwFg2QnZXQe//yFAy8V2ZaADI1OAK6PaW9ZBZvTmxCfpC9K6BSiwx8v781cJS7Xh
         bBxbOY8DME+clRHZ7C9z19Xs5qLpkThBdc0LS8aGd7Ca8NhDU1Bgzld2nTdtruUgOqLH
         synr/mRZPhfDpg9/O+webiS+Mtck5OEFsprztGdfadinqgDeNqCpzzChi2ynP9Yjmz92
         pcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783264484; x=1783869284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZR+FvhpeFlO5SaKYOf2iYX9QVp9scXDqtxu7Lek4dW8=;
        b=XjtPKULav9j/HuhL8ytbO/fngK26Bwq9bKWNkk8fAWcKwpKuaXKAGkrz2EqleNk7D3
         Gp46goa6H+9ipupdzP6WT4sTOcQ2SGWOJb2TQGLVQoc9Q508BWoSrL2RDI7PcnqWqFoO
         74HK9aOtmUxfkeRhOxbAHyBwVPbByxtqOi3r73vqz61g2s/pgjVZtIS/XbytPSvel/ii
         cQkbc24KC8Oqn2Qq+7bs2PsB0EwE+3T3at8lp9zW+BQjlb5BpJr+lQd46vkoOmaFg6Hb
         Xeviv0skAU+9wB5B7w/hDNlpbQbqUuSW9QnBGv9jCINsEjrTY6an34ushwPLa2Qm5A5l
         +dow==
X-Gm-Message-State: AOJu0YzLy9j6wRfixaSlLutjVEChfWje68THYRAmLn0n+vFzPaEJ4VGH
	nv2xKMVHtrntN5k4XJ7otmKwxanS4FJYU5KVibo3sjxqrxT2skrSYvtwfm3BI4hZftqFGRNRImL
	blkWl
X-Gm-Gg: AfdE7cmrTW4dJiio841gA+UN01IpqSGZTpiyKS8uBFFkSNSpkgrxv3t7AnnyZ88zR3a
	HFE6cTFy/zoGchrrEcOc5G27FqTfM3wEBvNZZ0cTWIl93S+9LSR/R7CiVR5pRdOncibjKVu01W+
	l9KavZl6nLkDZqT3EGTksvS3AnpXocclp9GfwtVRguNuBoH8Ry0k0LEVaicGFDg9epGUq+sKXEn
	CgV720ntFDhpjRl3s6Mg2ve1qXHjsEPFir8JhnCpeqQWlp9xeVFYLqpgzhx8Ew6JGilfU86RH3Q
	NqOGTckL3Lc234cl+rNr43QzQwDeTMf/qqZNwksPR8UO5eKGe30Q5QjiXKvJTvIFBSRj0rcIIqQ
	vmYR+K++uOj81joouis0YTK1HvH6iPcBVCO26/nP1C8BPU04zStzpM8/UixgeE6BEsNWHhBMWpu
	8+4OTsBY5Ei3FDpocJXg==
X-Received: by 2002:a05:600c:3f0a:b0:492:4a50:41fe with SMTP id 5b1f17b1804b1-493d11f05a3mr78159155e9.22.1783264484228;
        Sun, 05 Jul 2026 08:14:44 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493c6375764sm261922565e9.5.2026.07.05.08.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:14:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] pwm: lpss-pci: Unify coding style of pci_device_id array
Date: Sun,  5 Jul 2026 17:14:17 +0200
Message-ID:  <235336ce4e90ca7568303119b6f09fb77adca45c.1783263835.git.ukleinek@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=831; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=nQg1zr12uErvKfv4CjdDXREaeCl7UBYzwGESaPAzRn4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqSnTQLaAQ+HEQsKe6Q9v7PL5+x9pFoh1nC1A39 ouGGGlZcNuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakp00AAKCRCPgPtYfRL+ TjftB/9s37AzFwHzRAqPwyPcZJ78oUkQOpe5Dx0egx8NuexeN7ZqK1N8fODflFWr6LkI8QHfGqC YdLKySy4ba6aZlK4IZTNEP3Su2L7M2LAqZ4v9VGb9rtiAEvVvgiVGZ0y9kHvLO/vPd56M1XmVuz 5HLuzfgEdg+QJeHvszuyjJAvk5so+a4GXa4DzaWM46x+ogvxbj7H7IuWSvtVhq0tNFJba0+Hyqe LUMOWibUc7h5eSCk/NZ0uhEcHUxPwL4jphQT0+jirQR4aoQAJniGebgcU32dQS6baCo+ydL+bTy ndx8jiDkAyMBoNUV6QGd6up+ELxZxA1VCrAijJqGNONgU3Cw
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
	FORGED_RECIPIENTS(0.00)[m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9576-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:from_mime,baylibre.com:email,baylibre.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0153A70A708

Don't use a comma after an array terminator.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-lpss-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 3a0fd6593520..bcbfda1a6624 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -57,7 +57,7 @@ static const struct pci_device_id pwm_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x2289), .driver_data = (unsigned long)&pwm_lpss_bsw_info },
 	{ PCI_VDEVICE(INTEL, 0x31c8), .driver_data = (unsigned long)&pwm_lpss_bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x5ac8), .driver_data = (unsigned long)&pwm_lpss_bxt_info },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pwm_lpss_pci_ids);
 
-- 
2.55.0.11.g153666a7d9bb


