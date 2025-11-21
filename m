Return-Path: <linux-pwm+bounces-7657-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3EFC7AC10
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00826367866
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D552B350D75;
	Fri, 21 Nov 2025 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eab7Ma+b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444234F25E
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741340; cv=none; b=kCvzRFdBslN0dtqm6Ar4R3FlPWlJnIEG+XUou2VJ277nI0SwtsSw1L1OSRKFNH1f6mpjtZuCEWTlS0Bn8a0/NcNJXFrTBhOE52CWgn+K+MzoLJwyf+f4ovciKbfxk4F9roJCkAcgtSThvKTxQ0v5mydymKjPg+crMnsznYOtZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741340; c=relaxed/simple;
	bh=k9V7vI2bmW6KtNvIzvVHcp6NnBpVBCBYYGweS1ZnAJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UolvUDdv/qfkiT+SiAPSsAuZMGVxv+/OeVjamWxNu/dz40xKbjdkoiF5F05gKbTJsoTT3X1MdKmwDFFoLsSNR3Jp1luvl1tQEXOOeGShbQPHXWImJ5M91W7SJiZB4D2A0cEecm6KOd4uKR6+WRfBWjnzsMLbXdMq54Vlytjp+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eab7Ma+b; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so23647625e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741334; x=1764346134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v72bzMxhTcm0nemU+D1UXJWTovPas4rWq7RJYN0fIWM=;
        b=Eab7Ma+b2fWVUGLj2yTjpM/P/dcQIwOembm3uHYuHeU3GfVMOsFM9Qq/DV4y0L3/ho
         inMv+jSayas1s86SqMC92sNLkMzlgNBZloqiNVcCggSR1O+N5eL0wuNeOgD84CD7YJI2
         RuI17+KeS/YX0zdu7ga6qVZNgaxh+AN33RX4sUdWK44EgJQ3MtNctaGqAWIoswHP7Lxp
         kDlvCUjv7ofqQSpdOTK/oUDCSSaSJSMfgjNUo/VtZ9zF6R6HTuFr3qMPZFhCjIDZo9ad
         b8Jw6tc91RzyR4JM49Kfaq3LmtS9k80dk2QMQrD9KEJQdMjqaApQZq0549Uc/5FAVdV2
         9W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741334; x=1764346134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v72bzMxhTcm0nemU+D1UXJWTovPas4rWq7RJYN0fIWM=;
        b=sFo3snFKx+Xk7ZmR13Egnk/lNQf8UkMMYChEWZz5xG/LYCz0LI3dpispQAzPQuYqQe
         9lN8b3RUtyydoD1uNxBmay+uKRGuenMkjFLb+KJ0v2PY6r1mBePkCMvJqTIHGgMS+9kj
         kjW4B7vU+xKym4SQsXk/vNQJSk2NjOTbxNpOoSwe4MLf57cKBfpJ4Ed3END5DW0esPSt
         DkdJ5+E7EGS/J1sDjNaJf75kcrlZCILM9tsFt3utBRM4DWeBmTAyNj95s8iWQGcXX2U+
         cuUu2QuVezJDLcpBsG7amNoZniq1LmBaax0bpabYxL56ypryjgXaqDGxgna6TQA6a0pW
         j8rw==
X-Forwarded-Encrypted: i=1; AJvYcCWXNbn47ekADfVJ6X2qLKFQgigrEtsFGaHEbytu3X++yn1CBasesO3SXsjZX1fisESeytsC2fjTL4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSH2gnqXH5ayST/LYd8MjlQOSVE4KGuyRgrfDaZ0IHccMdamym
	rtpgl1viEwbOg/BMGaLnXHEVx3thbnVD+SlYVsIWLf4cqmxNBWm8t90W
X-Gm-Gg: ASbGncthtqIHr4O7srz6HNqbxkeXtqIWPmXZ+H+K10TNvxR5cMdktqF47Q0zL2d2mxM
	WO4DFucxjfiMIMAr+jzynOArOKFJZdh2SS0czKhiqFL+VKCTD6m9Cco0c/KXH65sbN2IwL0eKVY
	wiKNx6CfEfDRwS9ceYGBZIXCtnFjA8MLvRa81FHExx9i+k2gY91y2RhmMWECxkEihkT9khxK9/X
	hCDgayWbkLkWLOoqxshYLL7YciaY6tE2XGd+1pGhVW2cWUSO4IDzZm/gpzhcy/WSurPum417wXX
	pTHI2FLCdxR5uFX6GkMh8/eawVCxjHy2UtkJS0xZshzBVCWzNlcCY2MLlMw3b4JDqj1qLaR6rcm
	+pTidiVJcUwV/w2fChjdCiKPq/cdQOAcl+OFdL9k9WvpEHYmy1W0xF+G+JGZ9pu8gCZA8n9djT4
	Cr1c3eu2nfWpFH/E6jfGpv6Ba/Oq/jk+okornsp+7nasCDzc/cmt0TAMxJTtWTCL0s1uT8sjg=
X-Google-Smtp-Source: AGHT+IFuf3wu0Rs1U1IDvXOH69U2vml8ZSvlF+J7+ZymSNg5BzHRf17av6t68ABoEaSDJwvhDYtuQg==
X-Received: by 2002:a05:600c:3589:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-477c110262fmr28860765e9.1.1763741333408;
        Fri, 21 Nov 2025 08:08:53 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm89496195e9.8.2025.11.21.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:08:53 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [DO NOT APPLY PATCH v8 12/15] pinctrl: renesas: rzg2l-poeg: Add support for GPT Output-Disable Request
Date: Fri, 21 Nov 2025 16:08:19 +0000
Message-ID: <20251121160842.371922-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
References: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for output-disable requests from GPT.

When both outputs are high, gpt detects the condition and triggers
an interrupt to POEG. POEG handles the interrupt and send notification
to userspace. userspace handles the fault and issue a write call to
cancel the disable output request.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c | 86 ++++++++++++++++++++++-
 include/linux/pinctrl/rzg2l-poeg.h        |  9 +++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
index 2a09888407d0..3dd8bc3465b1 100644
--- a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -14,6 +14,7 @@
 #include <linux/pinctrl/rzg2l-poeg.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pwm/rzg2l-gpt.h>
 #include <linux/pinctrl/rzg2l-poeg.h>
 #include <linux/poll.h>
 #include <linux/reset.h>
@@ -49,7 +50,10 @@ struct rzg2l_poeg_chip {
 	struct device *gpt_dev;
 	struct reset_control *rstc;
 	void __iomem *mmio;
+	DECLARE_BITMAP(gpt_irq, 3);
 	struct cdev poeg_cdev;
+	wait_queue_head_t events_wait;
+	DECLARE_KFIFO_PTR(events, struct poeg_event);
 	u32 cfg;
 	int minor_n;
 	u8 gpt_channels[RZG2L_GPT_MAX_HW_CHANNELS];
@@ -81,12 +85,29 @@ static int rzg2l_poeg_output_disable_user(struct rzg2l_poeg_chip *chip, bool ena
 	return 0;
 }
 
+static void rzg2l_poeg_config_irq(struct rzg2l_poeg_chip *chip)
+{
+	if (test_bit(RZG2L_GPT_OABHF, chip->gpt_irq))
+		rzg2l_gpt_poeg_disable_req_both_high(chip->gpt_dev, chip->index, true);
+}
+
 static irqreturn_t rzg2l_poeg_irq(int irq, void *ptr)
 {
 	struct rzg2l_poeg_chip *chip = ptr;
+	struct poeg_event ev;
 	u32 val;
 
+	val = rzg2l_gpt_poeg_disable_req_irq_status(chip->gpt_dev, chip->index);
+	ev.channel = chip->index;
+	ev.gpt_disable_irq_status = val;
+	kfifo_in(&chip->events, &ev, 1);
+	wake_up_poll(&chip->events_wait, EPOLLIN);
+
+	rzg2l_gpt_poeg_disable_req_clr(chip->gpt_dev, chip->index);
 	val = rzg2l_poeg_read(chip);
+	if (val & POEGG_IOCF)
+		val &= ~POEGG_IOCF;
+
 	if (val & POEGG_PIDF)
 		val &= ~POEGG_PIDF;
 
@@ -95,7 +116,50 @@ static irqreturn_t rzg2l_poeg_irq(int irq, void *ptr)
 	return IRQ_HANDLED;
 }
 
-static ssize_t rzg2l_poeg_chrdev_write(struct file *filp, const char __user *buf,
+static __poll_t rzg2l_poeg_chrdev_poll(struct file *filp,
+				       struct poll_table_struct *pollt)
+{
+	struct rzg2l_poeg_chip *const chip = filp->private_data;
+	__poll_t events = 0;
+
+	poll_wait(filp, &chip->events_wait, pollt);
+	if (!kfifo_is_empty(&chip->events))
+		events = EPOLLIN | EPOLLRDNORM;
+
+	return events;
+}
+
+static ssize_t rzg2l_poeg_chrdev_read(struct file *filp, char __user *buf,
+				      size_t len, loff_t *f_ps)
+{
+	struct rzg2l_poeg_chip *const chip = filp->private_data;
+	unsigned int copied;
+	int err;
+
+	if (len < sizeof(struct poeg_event))
+		return -EINVAL;
+
+	do {
+		if (kfifo_is_empty(&chip->events)) {
+			if (filp->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			err = wait_event_interruptible(chip->events_wait,
+						       !kfifo_is_empty(&chip->events));
+			if (err < 0)
+				return err;
+		}
+
+		err = kfifo_to_user(&chip->events, buf, len, &copied);
+		if (err < 0)
+			return err;
+	} while (!copied);
+
+	return copied;
+}
+
+static ssize_t rzg2l_poeg_chrdev_write(struct file *filp,
+				       const char __user *buf,
 				       size_t len, loff_t *f_ps)
 {
 	struct rzg2l_poeg_chip *const chip = filp->private_data;
@@ -111,6 +175,12 @@ static ssize_t rzg2l_poeg_chrdev_write(struct file *filp, const char __user *buf
 	case RZG2L_POEG_OUTPUT_DISABLE_USR_DISABLE_CMD:
 		rzg2l_poeg_output_disable_user(chip, false);
 		break;
+	case RZG2L_POEG_GPT_CFG_IRQ_CMD:
+		rzg2l_poeg_config_irq(chip);
+		break;
+	case RZG2L_POEG_GPT_FAULT_CLR_CMD:
+		rzg2l_gpt_pin_reenable(chip->gpt_dev, chip->index);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -137,7 +207,9 @@ static int rzg2l_poeg_chrdev_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations poeg_fops = {
 	.owner = THIS_MODULE,
+	.read = rzg2l_poeg_chrdev_read,
 	.write = rzg2l_poeg_chrdev_write,
+	.poll = rzg2l_poeg_chrdev_poll,
 	.open = rzg2l_poeg_chrdev_open,
 	.release = rzg2l_poeg_chrdev_release,
 };
@@ -272,6 +344,9 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 	case POEG_USER_CTRL:
 		rzg2l_poeg_write(chip, 0);
 		break;
+	case POEG_GPT_BOTH_HIGH:
+		assign_bit(RZG2L_GPT_OABHF, chip->gpt_irq, true);
+		break;
 	case POEG_EXT_PIN_CTRL:
 		rzg2l_poeg_write(chip, POEGG_PIDE);
 		break;
@@ -280,8 +355,12 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 		goto err_pm;
 	}
 
+	if (cfg & POEG_GPT_ALL)
+		rzg2l_poeg_write(chip, POEGG_IOCE);
+
 	chip->cfg = cfg;
 
+	init_waitqueue_head(&chip->events_wait);
 	cdev_init(&chip->poeg_cdev, &poeg_fops);
 	chip->poeg_cdev.owner = THIS_MODULE;
 	ret = cdev_add(&chip->poeg_cdev, MKDEV(MAJOR(g_poeg_dev), chip->index), 1);
@@ -296,6 +375,10 @@ static int rzg2l_poeg_probe(struct platform_device *pdev)
 		goto free_cdev;
 	}
 
+	ret = kfifo_alloc(&chip->events, 64, GFP_KERNEL);
+	if (ret)
+		goto free_cdev;
+
 	chip->minor_n = chip->index;
 
 	return ret;
@@ -311,6 +394,7 @@ static void rzg2l_poeg_remove(struct platform_device *pdev)
 {
 	struct rzg2l_poeg_chip *chip = platform_get_drvdata(pdev);
 
+	kfifo_free(&chip->events);
 	device_destroy(poeg_class, MKDEV(MAJOR(g_poeg_dev), chip->minor_n));
 	cdev_del(&chip->poeg_cdev);
 	pm_runtime_put(&pdev->dev);
diff --git a/include/linux/pinctrl/rzg2l-poeg.h b/include/linux/pinctrl/rzg2l-poeg.h
index a5392f956700..311405b0137e 100644
--- a/include/linux/pinctrl/rzg2l-poeg.h
+++ b/include/linux/pinctrl/rzg2l-poeg.h
@@ -6,6 +6,15 @@
 
 #define RZG2L_POEG_OUTPUT_DISABLE_USR_DISABLE_CMD	0
 #define RZG2L_POEG_OUTPUT_DISABLE_USR_ENABLE_CMD	1
+#define RZG2L_POEG_GPT_CFG_IRQ_CMD			2
+#define RZG2L_POEG_GPT_FAULT_CLR_CMD			3
+
+#define RZG2L_GPT_OABHF	1
+
+struct poeg_event {
+	__u32 gpt_disable_irq_status;
+	__u8 channel;
+};
 
 struct poeg_cmd {
 	__u32 val;
-- 
2.43.0


