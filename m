Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D622AC463
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 20:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgKITBc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 14:01:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41752 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgKITBc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 14:01:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id n15so10000681otl.8;
        Mon, 09 Nov 2020 11:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sxvGIdy8L6aF+X1tfnngpFsA6hnyaeT/BHnffJ6GLdk=;
        b=d483n7oA/kU2y7jN0MAYdQPmEavEuG/ovOR1SpHWrnPSMqpi90CETucU2VgvfGpbKo
         ahvh7xE+vGy9JriKKKnpVbYv6IrCUDPHOkIksrOXiscoIpAh1m+eDyoAv5GinPM+/ehx
         xUY4PMKmo/+KvUvbArL3nZO4RJzK9EmwH0vabEnAIwW7/2SJK0tV6awn7QAPngGQploF
         zmgbBLHE6mnrw3myn9FTtT+uQJ5HDnt7F66tFHa5PhW61+YYFXoX2GZeF5pcOUIgfccK
         v0Uva0fYTaVnem33TJFoD4qxmX1YoqhJcJ7ffu/YvNHx75NN0gstbnYFTDp5K8jyZtn0
         Ik9w==
X-Gm-Message-State: AOAM532ZAXABec5b6WZYJkl7yDRjVzx/otjaBXglPsdcDxISXxnjSva9
        UQzb4rw5Z+ogBzyyAisRuQ==
X-Google-Smtp-Source: ABdhPJzOhkMgIOJrja36004ip5oRoceuSmOgBqEWKhX4GWjGFsinIHUsPIQPsWh2l7hn0/HugmXZQw==
X-Received: by 2002:a9d:3d06:: with SMTP id a6mr10887306otc.368.1604948490950;
        Mon, 09 Nov 2020 11:01:30 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h6sm2563055oia.51.2020.11.09.11.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:01:30 -0800 (PST)
Received: (nullmailer pid 1592258 invoked by uid 1000);
        Mon, 09 Nov 2020 19:01:29 -0000
Date:   Mon, 9 Nov 2020 13:01:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-samsung-soc@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Chen <Peter.Chen@nxp.com>
Subject: Re: [PATCH v1 04/30] media: dt: bindings: tegra-vde: Document OPP
 and voltage regulator properties
Message-ID: <20201109190129.GA1592208@bogus>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104234427.26477-5-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 05 Nov 2020 02:44:01 +0300, Dmitry Osipenko wrote:
> Document new DVFS OPP table and voltage regulator properties of the
> video decoder engine.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/media/nvidia,tegra-vde.txt   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
