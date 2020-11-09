Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BEC2AC43D
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 19:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgKIS5a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 13:57:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35826 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgKIS53 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 13:57:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id n11so10000353ota.2;
        Mon, 09 Nov 2020 10:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yp+Myu+RbCp/hhggXGpFgymnJTdUJhcL8XQ+E+Agqsg=;
        b=uF4ICZHwbNkw+7QU963JESi95i2PMWWRg5B3jNapcoVYnUNZhyHvFCP507UwGqtAUV
         ZN8PnOGC8FMktOUxkw9j04RYTcPKKTdHS6XQcox8mN+/o8BfxvWPjLQVBVUWTicQKMd5
         NxVuK/dPL1ETwELkKsyQ20kand+UKcOGVVwY3znsfjO7AAku4U2CE11AiYRlEbcoZqUh
         ROFm+nulGhwqRdzNwg5xqngAqeek5zhUqVW2A66dh7lzgV3Te6kEJ5qNkJ/0nNkxDHFl
         3tIXRDYzK+W4cwK8/m/nvbNU9ZlvEhelrA7v8JHyqhzK+m2xTWVFrdnflT7MOT9benoz
         SXww==
X-Gm-Message-State: AOAM5339xECIA6+Y8hThpXO0StsvzSD3qk/Rw95Ptp3u5NHP4qSZoaVx
        2wxQ0Z+Gjq8B7ACJZkpsgg==
X-Google-Smtp-Source: ABdhPJwTrJM8+DV6yoj0yZkvksdAC3aJsLLLrx1WHxgB39fkbPYVnHOpW6Iq5AkW4A4fHBNfxiLHQg==
X-Received: by 2002:a05:6830:2093:: with SMTP id y19mr10923388otq.219.1604948248350;
        Mon, 09 Nov 2020 10:57:28 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o29sm2726530ote.7.2020.11.09.10.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:57:27 -0800 (PST)
Received: (nullmailer pid 1586563 invoked by uid 1000);
        Mon, 09 Nov 2020 18:57:25 -0000
Date:   Mon, 9 Nov 2020 12:57:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     devel@driverdev.osuosl.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>, linux-mmc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 01/30] dt-bindings: host1x: Document OPP and voltage
 regulator properties
Message-ID: <20201109185725.GA1586511@bogus>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104234427.26477-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 05 Nov 2020 02:43:58 +0300, Dmitry Osipenko wrote:
> Document new DVFS OPP table and voltage regulator properties of the
> Host1x bus and devices sitting on the bus.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra20-host1x.txt   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
