Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269452AC452
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 19:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgKIS6l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 13:58:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34940 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKIS6l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 13:58:41 -0500
Received: by mail-ot1-f67.google.com with SMTP id n11so10004091ota.2;
        Mon, 09 Nov 2020 10:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pgrZHaOCOPdU/jfeIgQpo9Dm6WsghEsHSG6Bkgxz0XA=;
        b=CQd0hUXv2dV5gCsH2NEr1N4/remnHCQLdNM0IQ5+bZ37jO5yGDlCYbYPNPxZ13c4ha
         EqXEEOjSusHK0GNHF1RADhTIQBiK8+hgX/gFYrPKdiNS4uxci+nSTd2Ij85Iur9YOrjf
         IVooRVCnZEGWVesLElgc4hpNNOn9oyebIG7opYCRXaztHOFMfT+t4x9U4RZNUIY/6YTf
         NT8g+HNSng4mlJoDrOuyivk4t3BjLwyTklqQJRt22OiZeN6JiHM9nHK+LjdnDl5HP3vB
         T+IIj1WMFS3Ey9UKRE1LH96yTzrRdhKxGbKehATqSivJCMAemd3PHLABLlYLLZu+hkLo
         90kw==
X-Gm-Message-State: AOAM530mbwWm1cfj37vN0tJuP/E23UyzGkxNWZpLZtdiglr5NByVjS0q
        3g3LNiQPyZL7h7nJorxhQA==
X-Google-Smtp-Source: ABdhPJyNs3hy9NApzcsU0lR0JiGA6Xoyl6EnnMUG3Iz58jvEQet+apYRfnkdcvKCihcLKFHZgOJJjA==
X-Received: by 2002:a9d:22e4:: with SMTP id y91mr11382390ota.72.1604948320001;
        Mon, 09 Nov 2020 10:58:40 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r24sm2683114otq.77.2020.11.09.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 10:58:39 -0800 (PST)
Received: (nullmailer pid 1588239 invoked by uid 1000);
        Mon, 09 Nov 2020 18:58:37 -0000
Date:   Mon, 9 Nov 2020 12:58:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-mmc@vger.kernel.org, Nicolas Chauvet <kwizart@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Peter Chen <Peter.Chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        devel@driverdev.osuosl.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v1 02/30] dt-bindings: mmc: tegra: Document OPP and
 voltage regulator properties
Message-ID: <20201109185837.GA1588183@bogus>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104234427.26477-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 05 Nov 2020 02:43:59 +0300, Dmitry Osipenko wrote:
> Document new DVFS OPP table and voltage regulator properties of the
> SDHCI controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
