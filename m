Return-Path: <linux-pwm+bounces-7588-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B84C2FA25
	for <lists+linux-pwm@lfdr.de>; Tue, 04 Nov 2025 08:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF0B3BD6AE
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Nov 2025 07:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51030305E09;
	Tue,  4 Nov 2025 07:33:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4182126C02;
	Tue,  4 Nov 2025 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762241599; cv=none; b=NgY4FhjrgvNz05VGcDr1GK1t6i3awDOVT3R7HxncxIESQclo1jVR34rEwRuy+r6eUr8GTYhnpWC0eLLzW7vkQTQrwdzQSXk87hcJEzBea9hV+LBZpd8tpm4w4/b1zHY4VALEkHAYlZMW/B58ll+tVQ7RYq2PZtO67DH/IWyGd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762241599; c=relaxed/simple;
	bh=qxQ4Lwzk+bM1deNSGCTPLkdLK63ld+S2JJLs0EckS6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fhg6QyrM1ai4hOedWncViSPhIsgj6vd0oPDAEXSCW3Fty+6vwoCDjgEiMgMPm5JSLWPDb7zAeKEjWDR843zH+Ww7ruQpNYwHeHJR3C+BnoyWSJnJqnEInczCuIe10uIZAW/AX+5UGNxyERlfm8G139VFhDBBvnqUXjibrOUKzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAHhOswrAlpskJmAQ--.18495S2;
	Tue, 04 Nov 2025 15:33:04 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: ukleinek@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] pwm: mediatek: Remove unneeded semicolon
Date: Thu,  6 Nov 2025 05:48:47 +0800
Message-Id: <20251105214847.1279520-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHhOswrAlpskJmAQ--.18495S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDuF4rXw4DWFy5Ww1Utrb_yoWfJrcE9w
	4kWrsrXrWUGwn8KrnxJ3yxZr9FyFn5uw409FsYvr43t3sruF40vFy0vrsIgw4DA340gFWD
	K39xWr1fZF17ZjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6ry26F1DM28lY4IEw2IIxx
	k0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sR_TKZPUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/pwm/pwm-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index f2c918c0d26a..fecc1b91e14c 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -266,7 +266,7 @@ static int pwm_mediatek_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_
 				DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate),
 			.duty_length_ns = 0,
 		};
-	};
+	}
 
 	dev_dbg(&chip->dev, "pwm#%u: ENABLE: %x, CLKDIV: %x, PERIOD: %x, DUTY: %x @%lu -> %lld/%lld\n",
 		pwm->hwpwm, wfhw->enable, clkdiv, cnt_period, cnt_duty, clk_rate,
-- 
2.25.1


