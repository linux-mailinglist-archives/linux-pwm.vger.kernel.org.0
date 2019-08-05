Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD081A18
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Aug 2019 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfHEM67 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Aug 2019 08:58:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54403 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfHEM6z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Aug 2019 08:58:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so74623370wme.4
        for <linux-pwm@vger.kernel.org>; Mon, 05 Aug 2019 05:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98lh3VhEJYcNP4cO6bfAWLsXJomqXzKBLTJKfb0rfuY=;
        b=tMnBMEYxd6Lk47wVxq8np1s07LPbtohRCD9xifUu+u/mzgsVZzai5W9om02Rx3+Nb1
         tv62V9YKJ2x9GGQSuyYppVpgKlfNYYE9mhFKylGM4whvoeB5s2wWMLc+W4EmXTbO0gXB
         oLjGlL8FWWWdesfvwBYBq4LJ0Vi3usyG9KhMN/2TLtcowEOakLiV8qSWKkzmCeDfxKG3
         qRtvMzkDWgc63UQxW79fR00LSbu9OWNG0btdqFgsNig9WykCCzGhqwgfs0YLE6eL0ohl
         JWXR8vRNpcJR0AGTyBKmbK1NXKrbojwL7TVJmgmCvj8GHPKFPfPXoWH9f3Nk+MRf2jzJ
         qLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98lh3VhEJYcNP4cO6bfAWLsXJomqXzKBLTJKfb0rfuY=;
        b=qpc1l51Y17U/aYbbT54YqKqKPdhct8sAFVmdO8sirGZoSQ7ZAeraOilQ57IwII5MP8
         5ji7S340U4m66lxefHkHwWxzPkXfMWWn2Tzb2K7BDbrFEmOiOwXMFvAWPodo8nDydpfs
         j2NU5Kn6HPg4gF249wmO/xjcj7VM6BXXaaz21wiUjd7CGesRabtm9PBEXdpaATS2Otsb
         nSwCSJZXoPiA5mU7NIqWkNBlZlAA3P36BZsQWLFOSDUBXUoxKBsgM2ZlVb3WwY6KlEBy
         oNMJaQZCChn3rGFltvOUhlcjOmwIuNKmdatVjawxn+y2fb6UZNNUD1UyzzEW8ya0SSCU
         KmrQ==
X-Gm-Message-State: APjAAAVjjnQ8/eH9FAAklxpoWQr5kBMSJlJUUp6r0XMhKMltdiyNYO3l
        I+bPc5FUrVWM0A2R4+oKbYmDjohiWvM=
X-Google-Smtp-Source: APXvYqzsqQmdgJj3jeIDVq76HPcJpxfluPpf19/xxhP3uizn5JqLt/VNLa8L7aHlrqKs6BQBR3c4qA==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr18411997wmg.65.1565009932852;
        Mon, 05 Aug 2019 05:58:52 -0700 (PDT)
Received: from radium.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k9sm15582779wrd.46.2019.08.05.05.58.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:58:52 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] pwm: pwm-mediatek: Add MT8516 SoC support
Date:   Mon,  5 Aug 2019 14:58:48 +0200
Message-Id: <20190805125848.15751-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190805125848.15751-1-fparent@baylibre.com>
References: <20190805125848.15751-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the compatible and the platform data to support PWM on the MT8516
SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index eb6674ce995f..6697e30811e7 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -302,11 +302,18 @@ static const struct mtk_pwm_platform_data mt7628_pwm_data = {
 	.has_clks = false,
 };
 
+static const struct mtk_pwm_platform_data mt8516_pwm_data = {
+	.num_pwms = 5,
+	.pwm45_fixup = false,
+	.has_clks = true,
+};
+
 static const struct of_device_id mtk_pwm_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
+	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
-- 
2.23.0.rc1

