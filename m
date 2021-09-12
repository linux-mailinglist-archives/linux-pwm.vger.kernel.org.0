Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94527408027
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhILULR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbhILULN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:11:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96910C06175F;
        Sun, 12 Sep 2021 13:09:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g16so11354349wrb.3;
        Sun, 12 Sep 2021 13:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDP03amDwCEY6IiivIbDG+60+C+xV/Pv6sR1LEywSYo=;
        b=dXryPcSyGs3gzqsQTrY9mpA3DCXsy1qtI2Vvgch/dp73DtqX/mRKKohmX0tDJDjEOb
         22eZzlRqGiaRAQuj5VWO6OdZhB1UwhaliLlSF6kBqXnQg/4+Fuf/F5e840PG8sqkGkL6
         NdloQJP+NoMUcO7pKodski58EDi76tukzL2Ac9XOWI2ntWI78R17gAoFQwioVnd/FJKd
         NgO/oxnqYcdVDXiVxkLyt0OfVHo9DhWSvnvh6MZbPy4nse0+Tq07s0ygP2TuTBeMLeVR
         XmQ3fBl6Xb7JwQuAcAO8vvl3U1To8moeCJGd2IOe0JyjZs//LOlsgy8at16gazH3aoWl
         oieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDP03amDwCEY6IiivIbDG+60+C+xV/Pv6sR1LEywSYo=;
        b=2Yzhbz7fEYi/XHMjJYbqtry+QFSCE2ZREcgAJuplHXIyXc/PJbyZt4zaucbmMTwwQa
         ZfoUuRjA0mRYZPIC8uuz5DceA9qxS2RHF4j2qQkwkr5Dum9BAwJsHIfSbToIMBDEst1C
         y6YRTFvLXHVLUFXs3BHe2uRSyXauzVnRleIQCFExwIjfMLwLLd20fWTIFKpwu6nYKf3x
         KkW2w7aIR/sTEnIASvht9Tuh6Li2lS54OWMs7H2B5gHSqED5r8V0UzuEdckImDg2lJoL
         nS3U99LyOpebgJXl368IgQtNr85rTcLNOdL1BTc6I9Cjk6mAJ2XluGnn9baytBaezHLL
         IVIw==
X-Gm-Message-State: AOAM533k3zDeV9L4hkM1vapFyQCZdSFWLXnSp1pnubj+MdlhO7t0mb4r
        Hk39xFobtFF3a1riSOoxSMQ=
X-Google-Smtp-Source: ABdhPJwCDhWxV3BpnNX9q3XBX8a/PuihzY2Q6a3tghpwSk7A8GTITDQME8kLH5hVUhZ2lKp57c3mQQ==
X-Received: by 2002:adf:8170:: with SMTP id 103mr9106701wrm.167.1631477397224;
        Sun, 12 Sep 2021 13:09:57 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:09:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v11 10/34] gpu: host1x: Add host1x_channel_stop()
Date:   Sun, 12 Sep 2021 23:08:08 +0300
Message-Id: <20210912200832.12312-11-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add host1x_channel_stop() which waits till channel becomes idle and then
stops the channel hardware. This is needed for supporting suspend/resume
by host1x drivers since the hardware state is lost after power-gating,
thus the channel needs to be stopped before client enters into suspend.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/channel.c | 8 ++++++++
 include/linux/host1x.h       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/host1x/channel.c b/drivers/gpu/host1x/channel.c
index 4cd212bb570d..2a9a3a8d5931 100644
--- a/drivers/gpu/host1x/channel.c
+++ b/drivers/gpu/host1x/channel.c
@@ -75,6 +75,14 @@ struct host1x_channel *host1x_channel_get_index(struct host1x *host,
 	return ch;
 }
 
+void host1x_channel_stop(struct host1x_channel *channel)
+{
+	struct host1x *host = dev_get_drvdata(channel->dev->parent);
+
+	host1x_hw_cdma_stop(host, &channel->cdma);
+}
+EXPORT_SYMBOL(host1x_channel_stop);
+
 static void release_channel(struct kref *kref)
 {
 	struct host1x_channel *channel =
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index 7bccf589aba7..66473b5be0af 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -181,6 +181,7 @@ struct host1x_job;
 
 struct host1x_channel *host1x_channel_request(struct host1x_client *client);
 struct host1x_channel *host1x_channel_get(struct host1x_channel *channel);
+void host1x_channel_stop(struct host1x_channel *channel);
 void host1x_channel_put(struct host1x_channel *channel);
 int host1x_job_submit(struct host1x_job *job);
 
-- 
2.32.0

