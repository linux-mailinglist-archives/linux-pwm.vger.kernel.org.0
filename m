Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78002AC481
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 20:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgKITB4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 14:01:56 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37916 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbgKITB4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 14:01:56 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so8280466otf.5;
        Mon, 09 Nov 2020 11:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XU7y3c5jKQwTRFURlMcdIsjUqbBQIJvi2dRnhrHPP2E=;
        b=Ww0jOIwc1D4fFERXaqYJ2yPGK6UXnk0+uHzjxUsSkVOdw6LatOUnbnUBRg1jRPss2y
         7T/PEeZzlcX1XMhb36FTwQXLVkmFOnOYS5imdaxor4jROAhdYjoMN2g1SkUx9bNHc9IE
         UMNcDqdgr8o5c2SAJKkfsQcUq4JPINbKsK8aagz6VsA8/xL7NIfO8eo85O1P0ako4pwj
         a4UdG65QStOsnqv5fJFoP0WjupV+k6bYRtIo/ZSpL1RchvSawigCpPW+/Ra3EE69WRD+
         CmEe37yW+dXGfgO0qNd/xLbOUF7cZM+wdFr7oi5nwFSi6+s2hSGxhsvyI+XScIA9U1uT
         DRXA==
X-Gm-Message-State: AOAM531WwmhVlxk6wXRR9VSPTrdktCRsjIP4pLOfw1HZ+WWnoMglkcDh
        TAxtzhBYsdFvvfVPg85ptg==
X-Google-Smtp-Source: ABdhPJw681tHcSTTGqGgpXlkNWmd92BhhZoG61LbluCCQbsQRzYEPiujcl6g2HrH1OOy41T/D++2Fw==
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr11473992otq.208.1604948515112;
        Mon, 09 Nov 2020 11:01:55 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w18sm2383935oti.61.2020.11.09.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:01:54 -0800 (PST)
Received: (nullmailer pid 1592966 invoked by uid 1000);
        Mon, 09 Nov 2020 19:01:51 -0000
Date:   Mon, 9 Nov 2020 13:01:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Peter Chen <Peter.Chen@nxp.com>, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-tegra@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-samsung-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        devel@driverdev.osuosl.org, Lee Jones <lee.jones@linaro.org>,
        linux-media@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v1 06/30] dt-bindings: usb: tegra-ehci: Document OPP and
 voltage regulator properties
Message-ID: <20201109190151.GA1592922@bogus>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104234427.26477-7-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 05 Nov 2020 02:44:03 +0300, Dmitry Osipenko wrote:
> Document new DVFS OPP table and voltage regulator properties of the
> Tegra EHCI controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
