Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F75412C7C
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbhIUCpX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241721AbhIUCC0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:02:26 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A916C140093;
        Mon, 20 Sep 2021 11:12:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e15so32422050lfr.10;
        Mon, 20 Sep 2021 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wufLMjvcV2REchuzKnLPe9Ps3w6SDfXDXOXmKrrN/u8=;
        b=JN7GxvpOPNq+Oqp6duDkMntCZ8lBa2OcUwIq2xz81Cqu6aJXcvoSGwYvkEKSn3TGIi
         J/byK0VDMeaDXJRKJdcNNPquP5tCmrqGjYunCi4z2b567hkWsefXfoVApE0ZOtWBjtWa
         g/hqhyiS0h7h+IsYDCTeDEC55jfFprIpznVKtTPnNynj5sOIuqUWnYzk/hVFmfmLI6V+
         YnLIXS68xv13EVQVdA8z1uZg6FDW6l2sy+EwkkGbiIH0J4UOSXD15gD9Aw6/aPZZYHYI
         I7xNcKK3MqvJAOvUfniwLprFKU8hO18nrfUwnNDFwGjj6FdeCzZk6bzrg60DTViqtmGg
         QhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wufLMjvcV2REchuzKnLPe9Ps3w6SDfXDXOXmKrrN/u8=;
        b=f6XVuTJWwHDVU2WYGIqlIEfnlZ4NFqzgbaSZIMMv0rJaC4Y3pV3zspXkNEiWAF0QKd
         u1EHRR/XHMPY7YxbnfceCNO4fONe941lOKVzl2rQH/nIgL1UELuN8CpW2knMpW9hzVYq
         wbh6r+KFHnvsAKkUtikqA8eTRixp54s07dLdpoS6UawdtZLEecEKK/Q4OVUqlILPvwCy
         LxaqSQp08ShblR0jhOFCsBmN9NFGXHDgwznIZV/dBrcQOaHLLWh2C4eqqVwUAhUqpXom
         lkNW9OEtJd9Qg+zC8k1JFRZWAq/0UOcYoOXWz97JLaNwEHkXzMIADZOfw69oWFGusi72
         d3Rw==
X-Gm-Message-State: AOAM532myU69c9B6ZVL4qQggH1yYRHqALjgjWs7vDJ3sD1vtquFdpXvo
        TVTtJAOxsg/+Wn+nKMouBXo=
X-Google-Smtp-Source: ABdhPJzbQIQuQGiApbO9GwH5+NuxjTWqNAoH6tuJ2Tj7QVup+0KXL9BjwmYobjt3qUZFoYVeLQeKoQ==
X-Received: by 2002:a05:6512:401e:: with SMTP id br30mr13112738lfb.399.1632161519020;
        Mon, 20 Sep 2021 11:11:59 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:11:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v12 01/35] opp: Change type of dev_pm_opp_attach_genpd(names) argument
Date:   Mon, 20 Sep 2021 21:11:11 +0300
Message-Id: <20210920181145.19543-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Elements of the 'names' array are not changed by the code, constify them
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/opp/core.c     | 6 +++---
 include/linux/pm_opp.h | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 04b4691a8aac..3057beabd370 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2348,12 +2348,12 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
  * "required-opps" are added in DT.
  */
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
-		const char **names, struct device ***virt_devs)
+		const char * const *names, struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
 	struct device *virt_dev;
 	int index = 0, ret = -EINVAL;
-	const char **name = names;
+	const char * const *name = names;
 
 	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
@@ -2457,7 +2457,7 @@ static void devm_pm_opp_detach_genpd(void *data)
  *
  * Return: 0 on success and errorno otherwise.
  */
-int devm_pm_opp_attach_genpd(struct device *dev, const char **names,
+int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names,
 			     struct device ***virt_devs)
 {
 	struct opp_table *opp_table;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index a95d6fdd20b6..879c138c7b8e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -156,9 +156,9 @@ int devm_pm_opp_set_clkname(struct device *dev, const char *name);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
-struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
+struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
-int devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
+int devm_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs);
 struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
@@ -376,7 +376,7 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
 	return -EOPNOTSUPP;
 }
 
-static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs)
+static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
@@ -384,7 +384,7 @@ static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, cons
 static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
 
 static inline int devm_pm_opp_attach_genpd(struct device *dev,
-					   const char **names,
+					   const char * const *names,
 					   struct device ***virt_devs)
 {
 	return -EOPNOTSUPP;
-- 
2.32.0

