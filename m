Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23A93EF75F
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 03:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhHRBSO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 21:18:14 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38763 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhHRBSL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Aug 2021 21:18:11 -0400
Received: by mail-ot1-f52.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so793675otu.5;
        Tue, 17 Aug 2021 18:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eKtNQFzlTBGPaxfs2EmRb1riSIc24m2XgELeYM91Y4A=;
        b=M+mwzdMrhScAez4uMyHWQO0Ykb8m9LspvDR1TUxc81QZHxJhCOBd5CTJSAtOUMiift
         mlJGr/yXV4tSmHnwlqOUmgUYZqI6qWYdwrjyeArTIN3xwP/etluYlq44R7a1jOKd2iMU
         E5cc8B3tL3uWoNRXHiDqpt7T6WHbrBn+NykIspsNchmNr7f5l8J9WDmEU3fSmZwx9c9a
         Go1D6Cth/worurh0Tos4HGFb54IKQDaYCGoIxPESLl9biukXnxHeG9I7I10BQvd/Sg8Z
         zhHPNrwhTne1rax/gRMiYp0RqRsu0e2rs4V4i3NjGCFfResYvrCnqiUlGnUVZL9u/tIC
         DqIw==
X-Gm-Message-State: AOAM530WoGOwQLHNvfZ149og19APDPIs+r7yTy9fhkRnMq3XJFL2Bc8x
        PtW+W4LRs1vdCXzRPeGLXg==
X-Google-Smtp-Source: ABdhPJwU/r4DfRsxBODbwZOAT7Fuj3KBuNK588MGjUDZF59lolTrMg3kNGSScZqTWBSlXRqF+y+4aw==
X-Received: by 2002:a9d:a12:: with SMTP id 18mr4963065otg.252.1629249456779;
        Tue, 17 Aug 2021 18:17:36 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p26sm752775ota.71.2021.08.17.18.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:17:36 -0700 (PDT)
Received: (nullmailer pid 1178148 invoked by uid 1000);
        Wed, 18 Aug 2021 01:17:34 -0000
Date:   Tue, 17 Aug 2021 20:17:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-spi@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, Stefan Agner <stefan@agner.ch>,
        Nishanth Menon <nm@ti.com>, linux-staging@lists.linux.dev,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-usb@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Lucas Stach <dev@lynxeye.de>, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-pm@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v8 24/34] media: dt: bindings: tegra-vde: Document OPP
 and power domain
Message-ID: <YRxfrvd2sR5ALeuX@robh.at.kernel.org>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-25-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817012754.8710-25-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 17 Aug 2021 04:27:44 +0300, Dmitry Osipenko wrote:
> Document new OPP table and power domain properties of the video decoder
> hardware.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/media/nvidia,tegra-vde.yaml  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
