Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4349044FB22
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhKNTow (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbhKNTjF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:05 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F92C061766;
        Sun, 14 Nov 2021 11:36:07 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v15so30850463ljc.0;
        Sun, 14 Nov 2021 11:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oh6QUonw7MrnLiKi5GFBt9OmRLKhM/HqDNHd5NkKg7U=;
        b=AGfugJA+vMgl2OqYrYViOMXRtJrjgKsheMPgjImFm5V6rsVFKtiuS5FbECR99DDuAz
         /gWFntVOyTV7zcr/pqyLi0USJAosZsjcbdGb43P/6rGqTXFTZ4itpdE2qYUJNzmzFtWD
         oeB89umEEFckWNLeULcCVq9MFuAM4u2N4k6fi0tKHMWhGstf9IcFBn+zpY+jFjtSQM26
         ktMGyUH4W7KktsqYRGW/yLua10IXIeyRyynGgGoZ71L9MHzZl1OdMPwXQpLRwpjKhzsD
         t3i85WFR3Js3ACq2BSQ0jQ+lmEv92IQKET5gsez2Fw0o+bvAA7WeIih71d378QtTXZs/
         qqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oh6QUonw7MrnLiKi5GFBt9OmRLKhM/HqDNHd5NkKg7U=;
        b=5zpimITGJ1f2Kczb5fBdzqHeUHO03ubUEqjXPtZsOpS7TsVJDiSZHX3EguWpfJRkiO
         BfwDvr8B0TuYd4Ug06GnwU6Kr9gNA0CRLpDQCAlifpnkOSbqHIbwxA9zQqPTzW4mO5rg
         Y5MX3Vopof1W7cm6UUKESovhZLi3e2YOvIZwObElZ7+y9lx5f8/NAsGRohWz2RZjOBOY
         777QLarviW0o82mFH0bD5AIfU/D63pcr7TuCvTomduz1ZbMC+WsLzThbEgw5awDCyDnY
         F4/ha1T+yCTmix64vMY7ApCwBnpX9Ll458aHdVaCV9nhZ30sPDsBag/Szu5zScv4wNO8
         ZIDw==
X-Gm-Message-State: AOAM531IYWSuYLBrK61OWe9S98Mhyd38E5/89zvKNsTsyJtoVq/c7tzk
        InYAznZLhWDoNevfGCj4HHc=
X-Google-Smtp-Source: ABdhPJx9Z36PZ6lgKQnptaYDq43ivT/UfIZwEqT+j+PxUHQEa1XCUa2lceTt1X045J+TYkYUxN+lvA==
X-Received: by 2002:a2e:9acf:: with SMTP id p15mr34215654ljj.213.1636918565434;
        Sun, 14 Nov 2021 11:36:05 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v15 09/39] gpu: host1x: Add host1x_channel_stop()
Date:   Sun, 14 Nov 2021 22:34:05 +0300
Message-Id: <20211114193435.7705-10-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
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
index 2ca53d7ed7ca..e8dc5bc41f79 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -226,6 +226,7 @@ struct host1x_job;
 
 struct host1x_channel *host1x_channel_request(struct host1x_client *client);
 struct host1x_channel *host1x_channel_get(struct host1x_channel *channel);
+void host1x_channel_stop(struct host1x_channel *channel);
 void host1x_channel_put(struct host1x_channel *channel);
 int host1x_job_submit(struct host1x_job *job);
 
-- 
2.33.1

