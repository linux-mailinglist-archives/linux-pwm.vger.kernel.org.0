Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FC243A6F8
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhJYWsW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbhJYWsT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:19 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C87BC061348;
        Mon, 25 Oct 2021 15:45:56 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 188so2242904ljj.4;
        Mon, 25 Oct 2021 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oh6QUonw7MrnLiKi5GFBt9OmRLKhM/HqDNHd5NkKg7U=;
        b=H4yS17PN5Cgk1BXso+3bxFRI0wBy/fkFXrQTKEVEJijpwkbP8KcVwgHeMBmqtHOllF
         R43m4cp/ynQXaE46LwzuFfYuDICAE37ygglKadDvb6x6d6y/b+mAGjOZaACKLnqefn9+
         tg1+NZ7lJLXMogbITe6PYetLSvCo/QF9KBJ0Zg3sv5ZkrVQfnYVxmAAv9APoT1K3mPck
         m5Mj2ugGv0R5ZvLRvcNihMxRUt3CQqOKX0W2sg9TFg3XhHpI7s5JKsyViVJFuwO8B0fX
         COOqOvYHPVI7+XMUNhDF3Bv7tT9d2r+E0rgmTMRA2WGZF68Xs5UIuKHsJVzfpsFhd8Zd
         5RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oh6QUonw7MrnLiKi5GFBt9OmRLKhM/HqDNHd5NkKg7U=;
        b=rtRJDR1cyKvMyT+PKurwMxSh83na1OTJJ7r8pibYud6MZjApzQ6BMKzMwaVtf68Mey
         DIlr6eKSqNL19xA313FKMGaAJ/BG3aVh9x8FtFAjnxhBJyuBye5hmJipMx1ePUwqIkEp
         mQ9dUCzLOY+k3bLBy81Wn78o9YiAmnALJp2Ol6jn1AJn/m7Is9n0uki7EwQJuwoZw0ca
         7vjQ+GYxFwcBDE+eBkXgwaI4AufFjSvvPbbNKvxJFaIeO8KkbSynQsFKuuLuzrMLOpO5
         zNzB46ZOEfDL802a0ryePxe/HRNwgWXYFEwbuHzBbn+/D64/ydYNu/BHqkg5h5Y+n4OF
         Ejng==
X-Gm-Message-State: AOAM5309EQVIMCv4HL4TkGAZ+jl4Mu3Oo68C8dvHwpbQ+YV9K6SjFJwV
        K5su6j0zAiLaQ3KxawiRBW4=
X-Google-Smtp-Source: ABdhPJzVeBW0ULeUzX0Z+QXHWEUyioyNdKvLX6gJxOy97gBQF6t5bmJO0k845nDWU5dj5X/YKuURIg==
X-Received: by 2002:a05:651c:1544:: with SMTP id y4mr21214556ljp.470.1635201954745;
        Mon, 25 Oct 2021 15:45:54 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:45:54 -0700 (PDT)
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
Subject: [PATCH v14 09/39] gpu: host1x: Add host1x_channel_stop()
Date:   Tue, 26 Oct 2021 01:40:02 +0300
Message-Id: <20211025224032.21012-10-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
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

