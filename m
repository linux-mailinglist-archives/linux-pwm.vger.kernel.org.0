Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96823EF759
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 03:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbhHRBRv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 21:17:51 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36436 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhHRBRo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Aug 2021 21:17:44 -0400
Received: by mail-ot1-f41.google.com with SMTP id r38-20020a05683044a600b0051a2c6dd421so803160otv.3;
        Tue, 17 Aug 2021 18:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XEHzbtXC9SGv3p+rZWW31lZL4W4bCoeIEjmW3iiT8EM=;
        b=snsym/sI+hfnQkvWcVopwAmGP0AOBGuBq81UNQM+w1PXikbAnWcNOVsPa2RjmvPwLh
         zR8ilrD2oP9ec1iYDFnkdapW9oB8Ork2y7YKFE+5iDLlz9/OTm9uwn7N4xBpphCZy/kJ
         zrpNr7Tds/lUA1GsKEV3txGd1jH/df1KEBBAOrhUi6z4URBy/Z4V8ZPQgR5+vsn8k90l
         pw0iBLszGGO0F/CIt9N+5Y32pzDCKqqp8At/FxJlXHOS7xEW5XgR+1yTEZGMoslk3T2L
         TRfLNIZ4nXh1egxz2753qfDxcEFM3eHX+miy8IYxqMzYPVQxHC5VgmDMRzWLJ1xktgM+
         v6hQ==
X-Gm-Message-State: AOAM532H3nCFNNps2gThTuqT0Ckd56WvP+HYKHlwn1/VLTJwAnNx2H1m
        /epAg0NpBIonjuy9D1qhmA==
X-Google-Smtp-Source: ABdhPJzvnfsw5vj8+qJCFSRdy3z+gWAr1zQdU+wI2EZ0149D+ruRFQnz03+14sCvIKuRUTBry0K2dQ==
X-Received: by 2002:a05:6830:418b:: with SMTP id r11mr4821586otu.204.1629249430269;
        Tue, 17 Aug 2021 18:17:10 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j70sm760918otj.38.2021.08.17.18.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:17:09 -0700 (PDT)
Received: (nullmailer pid 1177455 invoked by uid 1000);
        Wed, 18 Aug 2021 01:17:08 -0000
Date:   Tue, 17 Aug 2021 20:17:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-media@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <dev@lynxeye.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-spi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mmc@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stefan Agner <stefan@agner.ch>, linux-mtd@lists.infradead.org,
        Peter Chen <peter.chen@kernel.org>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-usb@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-staging@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pwm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v8 23/34] media: dt: bindings: tegra-vde: Convert to
 schema
Message-ID: <YRxflCWb9ovs9d7H@robh.at.kernel.org>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-24-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817012754.8710-24-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 17 Aug 2021 04:27:43 +0300, Dmitry Osipenko wrote:
> Convert NVIDIA Tegra video decoder binding to schema.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/media/nvidia,tegra-vde.txt       |  64 -----------
>  .../bindings/media/nvidia,tegra-vde.yaml      | 107 ++++++++++++++++++
>  2 files changed, 107 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
>  create mode 100644 Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
