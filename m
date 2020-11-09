Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF632AC475
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 20:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgKITBp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 14:01:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34550 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgKITBo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 14:01:44 -0500
Received: by mail-oi1-f195.google.com with SMTP id w188so5810662oib.1;
        Mon, 09 Nov 2020 11:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eFMBLTL2PEBWwAPN9U+kNbGLp9Yb/Evdl1oIvaz71lM=;
        b=kFDIS/8CPjNfKDCJZ3LlJYP5n6//MV+c7BkDyC+3HNj0eSbmGbEugXUw9DBAQzTc+c
         RiOuVoIBQP1Vn16j09zaDcuWPB/uADuYWRkhoPuoaEDOSu2TgehGBMKzDVggmnIoUcHo
         OmyVrTI2t61MBotEHpL4113Rzb3XvOoiy2Milxs499sUH203KswD4pmfPpoz6gWOXJbL
         QeUZcunopycaDf8CaclWKAnhViFjerThH5fJkwtdYp6lZkj/PdmYVXfy75zKajbAbnDZ
         VKCT+H6PBd1Bnbs588ViVAqEMypaPr2469Ee/qHOHawuY3la0sFJMVG67zzeyW0r8upY
         QS7g==
X-Gm-Message-State: AOAM530VQrgQ8b733F6as2sabT53ibjSSUsto4XvrSnuPm+VVi9ShaXa
        1vqUTwYmFPm77Rolu8+19wHgTOyBdg==
X-Google-Smtp-Source: ABdhPJyhd8w22tZX0i2ZdxI3coqSF5uqjsf5bOy6yJ+ZdMET91o4ROO4MnjEmThijz4ZdSCDJrN4rg==
X-Received: by 2002:a05:6808:a94:: with SMTP id q20mr384924oij.31.1604948503395;
        Mon, 09 Nov 2020 11:01:43 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u16sm2548511ooj.8.2020.11.09.11.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:01:42 -0800 (PST)
Received: (nullmailer pid 1592610 invoked by uid 1000);
        Mon, 09 Nov 2020 19:01:41 -0000
Date:   Mon, 9 Nov 2020 13:01:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-tegra@vger.kernel.org, Nicolas Chauvet <kwizart@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Chen <Peter.Chen@nxp.com>, linux-usb@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v1 05/30] dt-binding: usb: ci-hdrc-usb2: Document OPP and
 voltage regulator properties
Message-ID: <20201109190141.GA1592558@bogus>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104234427.26477-6-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 05 Nov 2020 02:44:02 +0300, Dmitry Osipenko wrote:
> Document new OPP table and NVIDIA Tegra-specific voltage regulator
> properties.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
