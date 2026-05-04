Return-Path: <linux-pwm+bounces-8766-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA/fFRhf+GlJtgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8766-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 10:55:52 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E33064BAA12
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AAAD300336D
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2026 08:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C2B3491D6;
	Mon,  4 May 2026 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Zhi0A4bS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7716348453
	for <linux-pwm@vger.kernel.org>; Mon,  4 May 2026 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884949; cv=none; b=ZCkGma2WxJ8Eu5y63P5XLSiZYv8aXqok+lyaCbPtASh6rDFaWlJO/qP0v+wJvdwl4fteAie7nxM2r9XM2Q1RqCfcRDMd0Opm/sX8dUK7OjPxBfy2PctCqjzy79t/mDZ/vIDaVH8uw3pgfqLz0Vhtu6CgPj2yIw88Nse/3quaYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884949; c=relaxed/simple;
	bh=u6mATo/e1r+Ukx/DKDqln9GxkUp9W7jio607Zv/DjRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K3sm7plD6yobDBqyosIQg838rG15LYRwPsvLBQ+4rC1cJdxbJRHnsmKtD3LjKcWN1KRu3WHu0i68vDSHP0AWpd/IShCNNOCuzTZrLmKyM5paBU3BL8Uj/KnN5CMzo+3zPfhX7ZKZtlSo1dmJLxnBIFwueD2kSt1mrkIhLeoYsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Zhi0A4bS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so36121855e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 04 May 2026 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777884945; x=1778489745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MoKD3u/P7UWb06HoFd5XqFSOpzUYaTGGs4rM66GhRMM=;
        b=Zhi0A4bS+1/YIUs6mmRpZWIcvQ71PaG+e5LDdw2Iq1ZoR3sJP5nwVu5dw3tKEKWoxK
         ohxPl+1ax2CuAxHGJO3v2yoEk5AcjPWE40SX+ErxAtII8r00V7kxISCnC5U5LUtGeB+j
         1Vlt/sQVhmJM10vAUOPCiPAcHxXxHIJsL/ZehVhPJhuAT8ln9UMFbKCRDFUWnI2jmuej
         Snd4/5wWWJPqha4OzLcXWyINWE/cvz8uATS2rN0euKHMte47GJIPlGIJCLG0I7kt5SGz
         vNUt9nSVmC1N1Ttt1bdVBU0nzD4Y7TBfjIraRBO1kHPsYk8j3YbFgF/inaRg1mxh8tFk
         QZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777884945; x=1778489745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoKD3u/P7UWb06HoFd5XqFSOpzUYaTGGs4rM66GhRMM=;
        b=V/Gu1qy1tgBS4aH3bMXixbJbDn3sm1sgOkZSq1P0vHUPDbRmKNhRSh5TeVXs0yjNr9
         8qXZkyPYZSXu7spvYgWGqIIsC3PpOZ5U2oqy8tEoYb59XwWCFr5KBCZ66xFbwy5E240T
         2siM7zeDDsZwGAHt7bI7m5hAviHWhka/zlCFO/n0MN64UNIN7AJVNXaiuL/dHZ+wcW54
         7e6CvkbhaYEMAXYDUUDiu+68lAslmQNlgZSTzFTd48NVdsApEHUsgu9T/IwCWvmf83BJ
         KgoXqxisCmr+UseYQMhMkAgzRNvZQPmNwMwh2MfJlicLUBPb2xepHj12oQVv3WugYCnV
         xBfQ==
X-Gm-Message-State: AOJu0Yw8szGFmrFq50MZK7CG6nInIRK2d+e9LmRABjPp65g0DhqcvcLl
	J8HshC3cRzivgh47fR4/QA7Z7xXWr2Sgpys2mzyDMyYZKgJSg9ogbwaRJYfXvAodw9/5jjcIWdo
	I1ISN
X-Gm-Gg: AeBDiespQabTqu0+iQ+6eHw9yBVzOPZ1cPMdNGaPp1Z9lYTuqrlG5MnYKMUuDNhQOFM
	RGAaEAbt3lQmcfEqrIZNbtSzWw0HrFMil3z6OMfI4xWQWjaQgBYCv+xjIrs6T+A9vIBThWJ5/Vb
	ad/ipKM8f0Me4c+g3SxZ0x8sOwygiYF1POP4lDxvr568+p40864TXuCFVWU+fHjJSBIQyFJ6X+G
	ZHtCAsqrfZGmntCpj9YRIsug1i0NkLm14Z960s/jiyn8VUT6fSz3xRFPtQ/nTkpPjrpN1vzFTFY
	/SB0pwhUYYfTJnSwi0U5HGgaQ+5KXlvxmxGrnQI9ms9E7dVXSFXMCX6LmDLemAq8b71mqx5PTBS
	X5VrKCYhjT6G6RvJQhQGYzb/fZ5lNFfXkgGOjXy2AOIDFTZrMGUN1kGxFhS136H9cGlABkAN2sZ
	xG4cD+jk56fFlFy8rAkUwsxYIQjPNbE5BExmZo140ZN6FXX2iav9WMXAWe5V2jtzPtkt549S4XX
	Gqjg51DU9qHejF/ScSlMPHbAg==
X-Received: by 2002:a05:600c:34d2:b0:488:c80c:c236 with SMTP id 5b1f17b1804b1-48d10707482mr22033135e9.5.1777884945082;
        Mon, 04 May 2026 01:55:45 -0700 (PDT)
Received: from localhost (p200300f65f114e08f5a4175dadf07882.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:f5a4:175d:adf0:7882])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a81ed69fasm367448735e9.3.2026.05.04.01.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:55:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: Consistently define pci_device_ids using named initializers
Date: Mon,  4 May 2026 10:55:35 +0200
Message-ID: <20260504085535.1914668-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5378; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=u6mATo/e1r+Ukx/DKDqln9GxkUp9W7jio607Zv/DjRc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp+F8IqrWX1yQR1SZsFoBE3S26SrGb44t0x6CVi wWtCvLp80eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafhfCAAKCRCPgPtYfRL+ TsyiB/4+37iQjYVB/TtfKU8sBxPt5RD3TTkU7Q3RBWf4D3kpSONtYcLcYe+M2TKkxOyUrNefFem 1CYw18Xei1T1fgV4lPAcfCBOFzzhHUC1Wr+ugnGeFLJmVpgWzWiIBSyb5gnAqFn3P30fz/PL+P5 BmOa6t6Jm+rUpPYYFFcv+9MCGoud+JE0FU0FsPO5iQjPRWgxWRhEwnLhN7Q4tfvf/WmL71V19T4 O3lYu3xQi4JXY3M6HpHtESoV8spPD2+r6wJ0ZPrdNbvk5t6cuhUybtBWwNoZesrxwTx2J0fHsyn lI40CRPBkBxNriiu/ht3AfyimD7beIQ4M9ChbXLzUCNMJQWF
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E33064BAA12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8766-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]

The .driver_data member in the various struct pci_device_id arrays were
initialized by list expressions. This isn't easily readable if you're
not into PCI. Using named initializers is more explicit and thus easier
to parse.

The secret plan is to make struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
and that requires named initializers. But it's also a nice cleanup on
its own.

This change doesn't introduce changes to the compiled pci_device_id
arrays. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned follow-up quest allows to do

-	{ PCI_VDEVICE(INTEL, 0x0ac8), .driver_data = (unsigned long)&pwm_lpss_bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x0ac8), .driver_data_ptr = &pwm_lpss_bxt_info },

which gets rid of a bunch of casts and so brings a little bit more type
safety. This patch is a preparation for that.

Best regards
Uwe

 drivers/pwm/pwm-dwc.c      |  2 +-
 drivers/pwm/pwm-lpss-pci.c | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 86b72db58741..49609d132fda 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -147,7 +147,7 @@ static int dwc_pwm_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
 
 static const struct pci_device_id dwc_pwm_id_table[] = {
-	{ PCI_VDEVICE(INTEL, 0x4bb7), (kernel_ulong_t)&ehl_pwm_info },
+	{ PCI_VDEVICE(INTEL, 0x4bb7), .driver_data = (kernel_ulong_t)&ehl_pwm_info },
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index ae25d9321d75..3a0fd6593520 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -48,15 +48,15 @@ static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id pwm_lpss_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x0ac8), (unsigned long)&pwm_lpss_bxt_info},
-	{ PCI_VDEVICE(INTEL, 0x0f08), (unsigned long)&pwm_lpss_byt_info},
-	{ PCI_VDEVICE(INTEL, 0x0f09), (unsigned long)&pwm_lpss_byt_info},
-	{ PCI_VDEVICE(INTEL, 0x11a5), (unsigned long)&pwm_lpss_tng_info},
-	{ PCI_VDEVICE(INTEL, 0x1ac8), (unsigned long)&pwm_lpss_bxt_info},
-	{ PCI_VDEVICE(INTEL, 0x2288), (unsigned long)&pwm_lpss_bsw_info},
-	{ PCI_VDEVICE(INTEL, 0x2289), (unsigned long)&pwm_lpss_bsw_info},
-	{ PCI_VDEVICE(INTEL, 0x31c8), (unsigned long)&pwm_lpss_bxt_info},
-	{ PCI_VDEVICE(INTEL, 0x5ac8), (unsigned long)&pwm_lpss_bxt_info},
+	{ PCI_VDEVICE(INTEL, 0x0ac8), .driver_data = (unsigned long)&pwm_lpss_bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x0f08), .driver_data = (unsigned long)&pwm_lpss_byt_info },
+	{ PCI_VDEVICE(INTEL, 0x0f09), .driver_data = (unsigned long)&pwm_lpss_byt_info },
+	{ PCI_VDEVICE(INTEL, 0x11a5), .driver_data = (unsigned long)&pwm_lpss_tng_info },
+	{ PCI_VDEVICE(INTEL, 0x1ac8), .driver_data = (unsigned long)&pwm_lpss_bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x2288), .driver_data = (unsigned long)&pwm_lpss_bsw_info },
+	{ PCI_VDEVICE(INTEL, 0x2289), .driver_data = (unsigned long)&pwm_lpss_bsw_info },
+	{ PCI_VDEVICE(INTEL, 0x31c8), .driver_data = (unsigned long)&pwm_lpss_bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x5ac8), .driver_data = (unsigned long)&pwm_lpss_bxt_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, pwm_lpss_pci_ids);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
prerequisite-patch-id: a31e1d7b9e6310e9c453afcd2037468686cb552c
prerequisite-patch-id: 7779c63f16ef6f7247cdb71c89e66b27e299eb74
prerequisite-patch-id: 6f920b6f8c31dc0ad1689200c37680755c20ce8b
prerequisite-patch-id: 1fd68e883664147052540eea19769ea9e92d0138
prerequisite-patch-id: fff07090df18a39a361bbb091a3f17223b4606b4
prerequisite-patch-id: d0d54f7acecd560cdeb6ea0c0e5ae77a50695d68
prerequisite-patch-id: 5011234352b266242ce01fd8babbf0459bfb005b
prerequisite-patch-id: a935aab66aa9896437ab9d757ef9fdc859d22495
prerequisite-patch-id: 344256383ec67df7fbbb6e35e4301d3d14b2571f
prerequisite-patch-id: 14c277a51a268cdcb630d888c1bad3334018d11c
prerequisite-patch-id: 93f14fa1ae7c71a1389488e87bf5d4ba8dbddf84
prerequisite-patch-id: efe5e069be2c0c039e895fb10bbbf6510fd773e6
prerequisite-patch-id: 21ac68c87f24f9e1d35f3268c04e5b40f93849c7
prerequisite-patch-id: 84fb61dca584c253aa2e461e97df8aad59159c28
prerequisite-patch-id: 8e7cee5cc55dd50271326313cb258934dd8c3579
prerequisite-patch-id: 38526e2d87a08a78ccdefaf3261751220d645f15
prerequisite-patch-id: e608a54ff3511d5345f0b396fd5d8e9b003b31ec
prerequisite-patch-id: 4a715d89f621a2ffb364abeb15db3fa2b9b83317
prerequisite-patch-id: 6d049443e6399e1266e06ba412601308b0e44cdc
prerequisite-patch-id: a42f44b27a7bf3795c177fd5df47258463114c9d
prerequisite-patch-id: d8b8fe8728706b0abdae18fa7a77fbb50db89aab
prerequisite-patch-id: 2c85231c5c460bdbe3293d275e6e7b9c135a5e7d
prerequisite-patch-id: 60892ec2e01f3559dfb6791d3f13035d46b01ebb
prerequisite-patch-id: ed9523b310540069539cab89374600fd0b23a043
prerequisite-patch-id: 3619058b0eb67d71f94ae209ea44f7e6645594de
prerequisite-patch-id: a867be2bb1f4f5afeaf4effbcbf1a3b3d32655bb
prerequisite-patch-id: 1a8c38d82ef577bedd1a665b130dde53ca32fb65
-- 
2.47.3


