Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C856F3EE23E
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhHQBam (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbhHQBag (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4955CC061764;
        Mon, 16 Aug 2021 18:30:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k5so10338575lfu.4;
        Mon, 16 Aug 2021 18:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+pDcrHtMJ3BfM+Az9yuVk7KyrEv5IezDZ4vndEOIZrQ=;
        b=c9mljDf/eNFjDgKd6lAZRYU+Sl1mj936K1QRTM3iyE/zX+e1BIkLLGB1mhFhPd7+Hk
         8PBHlZQE8QArWVeAYo7CCeEbj4E66qlF+JBkg67KAn3/wsCvbkgsJaw8cnHWtq39A7eV
         HmXwu53voVpa0MDeaC/fb+egJU5IhrqsVyTyb8G6ozaHw1HwnJsnoFGc+uQWUEAwQLoZ
         YIBRd6jE7RyINAErjUcu6PUE/1TbZf7eyhrk2BonebVjXj1+vdhtVN/V+UGaLX20DoOX
         k8OjjSU0YfqFyxkx8+FXwuY/clS/n4p8C1hTF6UEWhznMJm5iDlV+IXuGsE6dZZWvRV4
         d/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+pDcrHtMJ3BfM+Az9yuVk7KyrEv5IezDZ4vndEOIZrQ=;
        b=Znw8UwyhY/RCtBLy7h7T2r9FJFleaw1HMog1OD/C9DVGjfWqXreffqcUs8Iu/N92J0
         8/wFifVQNB/a/YADuBfTFPZZ5eHdc8lNcQIteb83D7XbRw988RSXggJLdhmEwlp37bbH
         OOq5OtlCKKoCWwSbZLX9NTXi4AKwJDsIqqmBZTK68AwL1CwCbszclxloKnAwd1n3QZjb
         LOMBcDDv3RKat6S6eQOmcq4bhjhLuGq/fETpSeC0oDrhyCoNCIxiU/96TqLJdTE7Kdsw
         ijPbNfgr1rVULBwH3A7l3wwp/ftCOEM4S1jS3xI6qJo0ft4C9U1KBmhCytSC2ywNz+59
         L/bQ==
X-Gm-Message-State: AOAM533c5XOdsxjnCM4b9YEZKY/BLwHVCpIR69COqwOf8kmXfpdxi9k7
        ZhojIOZ9OD4pKfFA81TZ98Q=
X-Google-Smtp-Source: ABdhPJwz8UxSZOvdKUaNwcA+R7lsn7NPPjiIZX4N0ocLITK1s9++oNokkLZ+Jivbj0hSPfrQgeVN+Q==
X-Received: by 2002:ac2:428a:: with SMTP id m10mr514380lfh.636.1629163802638;
        Mon, 16 Aug 2021 18:30:02 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:02 -0700 (PDT)
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
Subject: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
Date:   Tue, 17 Aug 2021 04:27:21 +0300
Message-Id: <20210817012754.8710-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add dev_pm_opp_sync() helper which syncs OPP table with hardware state
and vice versa.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 42 +++++++++++++++++++++++++++++++++++++++---
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5543c54dacc5..18016e49605f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -939,7 +939,8 @@ static int _set_required_opps(struct device *dev,
 	return ret;
 }
 
-static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
+static struct dev_pm_opp *
+_find_current_opp(struct device *dev, struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
 	unsigned long freq;
@@ -961,7 +962,7 @@ static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 		mutex_unlock(&opp_table->lock);
 	}
 
-	opp_table->current_opp = opp;
+	return opp;
 }
 
 static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
@@ -1003,7 +1004,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 
 	/* Find the currently set OPP if we don't know already */
 	if (unlikely(!opp_table->current_opp))
-		_find_current_opp(dev, opp_table);
+		opp_table->current_opp = _find_current_opp(dev, opp_table);
 
 	old_opp = opp_table->current_opp;
 
@@ -2931,3 +2932,38 @@ int dev_pm_opp_sync_regulators(struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
+
+/**
+ * dev_pm_opp_sync() - Sync OPP state
+ * @dev:	device for which we do this operation
+ *
+ * Initialize OPP table accordingly to current clock rate or
+ * first available OPP if clock not available for this device.
+ *
+ * Return: 0 on success or a negative error value.
+ */
+int dev_pm_opp_sync(struct device *dev)
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
+	int ret = 0;
+
+	/* Device may not have OPP table */
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return 0;
+
+	if (!_get_opp_count(opp_table))
+		goto put_table;
+
+	opp = _find_current_opp(dev, opp_table);
+	ret = _set_opp(dev, opp_table, opp, opp->rate);
+	dev_pm_opp_put(opp);
+
+put_table:
+	/* Drop reference taken by _find_opp_table() */
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_sync);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 84150a22fd7c..686122b59935 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -168,6 +168,7 @@ int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 void dev_pm_opp_remove_table(struct device *dev);
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_sync_regulators(struct device *dev);
+int dev_pm_opp_sync(struct device *dev);
 #else
 static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 {
@@ -434,6 +435,11 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
 	return -EOPNOTSUPP;
 }
 
+static inline int dev_pm_opp_sync(struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif		/* CONFIG_PM_OPP */
 
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
-- 
2.32.0

