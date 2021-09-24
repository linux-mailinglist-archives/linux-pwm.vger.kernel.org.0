Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37F4175DA
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Sep 2021 15:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbhIXNeF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Sep 2021 09:34:05 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59738
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346282AbhIXNd6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Sep 2021 09:33:58 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D539840292
        for <linux-pwm@vger.kernel.org>; Fri, 24 Sep 2021 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490343;
        bh=WNNN/oInJzxgO+63uGtXtE4bZ4URhmkG4TzZ5wV565c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=dghwMXrybK5324J0QR4buuLrWPdxn8KYu7Vfk0NPwf9HNWBQhxutk8Sz5vmo3uxyw
         SoZEanyqkuji20r4GGpUSQ5RfBxpWidgjzOQ2Yne8gWtDt9Tm5U9lL3axDTgBuB72s
         MCe56P9n8yZz0dBxzVxdv1Axz67UN5c8h1Xvrai0WU2fUKZ4JOq+YAw/jWj0E2RB4X
         iubipC7ZJABjalMD+hUkS10MSZ1Chl6H+oLNWUx3HlHH4VGmi5xr3XoKOlPXoOnkn5
         LCe3r3aM5chDQw7pL/xnNnp3mbYwJ4R+9w1SnZLrwjXqrlQ48IXChUXVuZ9R6HTOfU
         QG7KcJQg/FdOw==
Received: by mail-wr1-f69.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso8045049wrb.20
        for <linux-pwm@vger.kernel.org>; Fri, 24 Sep 2021 06:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNNN/oInJzxgO+63uGtXtE4bZ4URhmkG4TzZ5wV565c=;
        b=Frz3HyGS0OuYeVcJ+5//x55uUYuDA/F1nTw6d0ox4GXlVQvnHTgEgVPHTlkrSe6chX
         Ve0YBfjGx8zZPyjBQygWpoRtUDR/ix3dMGjeclotGV7CrT1o3wniKQy+5OSEzsz7mix7
         c1BTtQhr3jbQUQTpWtnFmMgo4+pqtHxGuHhz9OSJdxwLqBk7fsAk6uYkc79QdXUD2OPz
         6MG4SlSydrv21SvS1MZyQVoFhuCuDGDCbLyM2IxeSoGK/tY/tz5P5RBz0UBlg38OIo8X
         7awrCCzU1khGB2xtkUDWgX3C5CkVMDiOC7LQiWSDPzkA9CJL1fkS7H1Me1jYmh0n7lHb
         fRqg==
X-Gm-Message-State: AOAM533DARDbfuebedD5iNabNE9eDA5j6Fh8OAdU/WeVzKRDtLB747bs
        ehNt7yqP1Ep2iuXP2af/HHxFpvdsooruBU8oVLNA70A9MUmQLaBqJPXtqp19FJU3xsSQDAlK4XP
        bTREbfyHOkFL5DK8aK1Or8nO9TV9lwVlhbQ2Bcw==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr2175624wmd.34.1632490342959;
        Fri, 24 Sep 2021 06:32:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxdm8BNCQifJ7uMGJIzTnRdy/iOjAr/qBwQBxmwjwyGKGSg/k4Yt8m0Ov2/oVtlzy9V/5yqA==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr2175602wmd.34.1632490342836;
        Fri, 24 Sep 2021 06:32:22 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id v18sm8400743wml.44.2021.09.24.06.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:32:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: samsung: describe driver in KConfig
Date:   Fri, 24 Sep 2021 15:31:48 +0200
Message-Id: <20210924133148.111845-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/pwm/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index aa29841bbb79..21e3b05a5153 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -476,7 +476,9 @@ config PWM_SAMSUNG
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-	  Generic PWM framework driver for Samsung.
+	  Generic PWM framework driver for Samsung S3C24xx, S3C64xx, S5Pv210
+	  and Exynos SoCs.
+	  Choose Y here only if you build for such Samsung SoC.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-samsung.
-- 
2.30.2

