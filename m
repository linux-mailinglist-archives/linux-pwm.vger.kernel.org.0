Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41E947B195
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2019 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbfG3SQ3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jul 2019 14:16:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33274 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388012AbfG3SQ3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jul 2019 14:16:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so29144596plo.0
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2019 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9QcLwsc+g9/nkAYconN3atycpaD3W9Oj7VTl50rUYI8=;
        b=flOWBgeKN66a+lkeYUJw67um1dky5NseAGdVBwDkLgqqgNPE51BaQrLl2XD9uIw7ow
         bt7ThNZmPP60v8Zjs3DNydj3XPHteDsC5c+C7zSiODg1yt4rUB/ita+9jHnavVBb0mr9
         avUKc1BFKlVMQBujqr9SoXL5dRwA4Ep05wSDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9QcLwsc+g9/nkAYconN3atycpaD3W9Oj7VTl50rUYI8=;
        b=QWHe3LHMTqIXZnGMg6IRpWXO+wCg8J+2rsjTkVW5m3a59AYJWT40SO2ZjVHTF1C61j
         y7fUHpJJjxDIEyocWnzPfGxC3p2rQGWoT1i1Elbi71XxKTSQ94rBnDp4HzDcjSNLHLV6
         2qM/Ra5Qi5TStP7/kXjz142lCukfI43aMVH6DvzpsCIZsxyz0VhhofAlKvUHr9uxLnjQ
         wNIXIV7qxGRFvPkCBe6AD+s50UGPJWX2+q6kIe6coYuMJ9E/t0CJIOmglo9cg4SKL8YI
         7i55jlyiH2kKE15ohOsYdsAocl+43L2kMoLw3sQXzMMuR1i3hfzNDD0Jlmc9ldcFYQyG
         Vr+w==
X-Gm-Message-State: APjAAAVS/j3uqRvIeOs6xPjEiCNesDT/S9rZ4qsJliW5SI90GJXCcYhF
        Ukibd6fXaRpl9ETJh/IxGA2JJA==
X-Google-Smtp-Source: APXvYqw8qhi0NlIOlpgPnm+0CiKy/x0CAkkQYAenrtgmro/8bcy85mYSXx1l5obJEIg5J+PbbaIREA==
X-Received: by 2002:a17:902:29a7:: with SMTP id h36mr119155726plb.158.1564510588597;
        Tue, 30 Jul 2019 11:16:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 36/57] pwm: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:36 -0700
Message-Id: <20190730181557.90391-37-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/pwm/pwm-sti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 20450e34ad57..1508616d794c 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -564,10 +564,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pc->regmap);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt, 0,
 			       pdev->name, pc);
-- 
Sent by a computer through tubes

