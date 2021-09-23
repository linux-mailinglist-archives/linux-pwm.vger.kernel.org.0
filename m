Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAD141671A
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Sep 2021 23:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243231AbhIWVLK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Sep 2021 17:11:10 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43538 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbhIWVLJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Sep 2021 17:11:09 -0400
Received: by mail-oi1-f177.google.com with SMTP id w19so11541174oik.10;
        Thu, 23 Sep 2021 14:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ECAcJQ5j3b9V37w+5AU1dCjJzeuc06UOkYf0x/TJhHI=;
        b=xIdLizm4aubTc3dGOr/JOOrmu/jGmoWQ1B+ry9dtYUiPsD6NfmRoN4HOihRT5Cyc+m
         26xhWVWU5zolKwopYzzACSCyMQyPhWdae9KYinSfzPY5V2bUmsZtHQw253u+mXUwjWcz
         hZ3KtcEaJ7G2AQo6VVgkHgs1IBpP9BcRnck4CkZnO85wIlE7eu5bb6ai3XjNu8f5jYq5
         Vc8mP7zS1F+f+X30oCmD1y+uTkuD3rvthnLu+18HsnIjblgiJ+3d/z5A+JHeqv1LqEfh
         dI5UbMrEeCVxS35KYOftBanaD2WRfDGWBceNepJmXAnA5kKf5mZTrTvWR3FyQkGAyc2u
         NRcA==
X-Gm-Message-State: AOAM5314M/Ns5HRCOV8AJMEoGbhkjzLYg4+Tk7O1cc5lV7jp7CS2BSMl
        JK3KG9Ggu+n2Da6WjjxcI9fQA//FoA==
X-Google-Smtp-Source: ABdhPJxgGB/F5m/HUdgfquhEQY/6qPe41K4exPARMH+1jXMEbOmyXEtt37OEluaLbFS8sOex0LCyaQ==
X-Received: by 2002:aca:645:: with SMTP id 66mr5369149oig.145.1632431377021;
        Thu, 23 Sep 2021 14:09:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d10sm1701331ooj.24.2021.09.23.14.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:09:36 -0700 (PDT)
Received: (nullmailer pid 3527425 invoked by uid 1000);
        Thu, 23 Sep 2021 21:09:34 -0000
Date:   Thu, 23 Sep 2021 16:09:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        Lucas Stach <dev@lynxeye.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, David Heidelberg <david@ixit.cz>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-tegra@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>, linux-pwm@vger.kernel.org,
        linux-staging@lists.linux.dev, Stefan Agner <stefan@agner.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Viresh Kumar <vireshk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v12 05/35] dt-bindings: clock: tegra-car: Document new
 clock sub-nodes
Message-ID: <YUztDv/KbKVAY7cB@robh.at.kernel.org>
References: <20210920181145.19543-1-digetx@gmail.com>
 <20210920181145.19543-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920181145.19543-6-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 20 Sep 2021 21:11:15 +0300, Dmitry Osipenko wrote:
> Document sub-nodes which describe Tegra SoC clocks that require a higher
> voltage of the core power domain in order to operate properly on a higher
> clock rates.  Each node contains a phandle to OPP table and power domain.
> 
> The root PLLs and system clocks don't have any specific device dedicated
> to them, clock controller is in charge of managing power for them.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/clock/nvidia,tegra20-car.yaml    | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
