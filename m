Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9352AC459
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 20:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgKITAf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 14:00:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33554 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgKITAe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 14:00:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id i18so10025257ots.0;
        Mon, 09 Nov 2020 11:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5YUEvnB3to37KnbuxcK5tx/hJGsx2a/LFMlp0aY5TLQ=;
        b=Tc+X+1wqK3/xtP5HkUIR8KrxzEYhDJabr970iEUnm2ug5RYTg34qMADYz82WUySPS9
         rEu4Bv/sBkwXaywUvHpLpzReODh1Y6YJ9hX+DHlReJK+tvwMcznsmWrv3N6Yh7HmtOrN
         2PVGb8xCxQjnbIEBsBowVKGx/qtm9uXNQh8hGgmc3/sDszwG18UILR5JmtIcGmC7hmib
         kQvZIdOuoVNendY4pdFU2TAMozY1N2J03c3yMbSf5gORbksw6Kztnv5LX9mmOB2Y+cha
         8pIhvPavLFwmwKAXYxlZI0Y3btdVKWflAOrr3yOUlXqVLlH8+nBwtdzHMWxhDLAEvWkL
         +uSQ==
X-Gm-Message-State: AOAM530hXMTIQ7I2iqazWWatml82vabbb/oKMIPLRC4vvBkmPXJ1CPOW
        b9okBzfLhDl0bNFoFDsmYRA72m06Cg==
X-Google-Smtp-Source: ABdhPJyMX9zDE7/Gr58n7kd8OGZN4yCUG4rGtgbFXHnSLCafRqgq9w/7W4V89fBfDlqFoI1WEyH4Pw==
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr12134497otr.151.1604948433035;
        Mon, 09 Nov 2020 11:00:33 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o9sm2602082oos.29.2020.11.09.11.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:00:32 -0800 (PST)
Received: (nullmailer pid 1590838 invoked by uid 1000);
        Mon, 09 Nov 2020 19:00:30 -0000
Date:   Mon, 9 Nov 2020 13:00:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-tegra@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>, linux-mmc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, devel@driverdev.osuosl.org,
        linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Peter Chen <Peter.Chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        dri-devel@lists.freedesktop.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 03/30] dt-bindings: pwm: tegra: Document OPP and
 voltage regulator properties
Message-ID: <20201109190030.GA1590784@bogus>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104234427.26477-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 05 Nov 2020 02:44:00 +0300, Dmitry Osipenko wrote:
> Document new DVFS OPP table and voltage regulator properties of the
> PWM controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
