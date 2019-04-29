Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBC3ECBB
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2019 00:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfD2W0t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Apr 2019 18:26:49 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34796 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbfD2W0s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Apr 2019 18:26:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id n15so4109461ota.1;
        Mon, 29 Apr 2019 15:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oRenui5Af25LDBg0th7gwZb/BUZtc0JZI0y66saQTqM=;
        b=cdtYlixFfz6J9BgtQGBuXZoDzzh1CyHGUkw5yuMN/+ZNzwbLSCjO3atYHJhzPu1YZS
         aJedC01nHbLmzlFc/2T7yGyCgsj48LLFi5+21J2sUU5BdkEIJtSXAnjkenBy1iUsBGoz
         cAjKYfewbBaNf41j990n1+e9BR5mezn6SwlmG6mLggef72/cAeShUMtS2Iaq68Mr3+bC
         9UsQo81M4k0aeLlLPAjd76YnYbuvk9DTvcHuqGKJiqMh7yNwMXA0laNOWGFhAgvXsQA/
         8TJonX4V3ve4lblLBmo+F2ssTmOqjEai4h8GTQehm1eLhxxPifM8WU5BysHbjEulIfNV
         9Dvw==
X-Gm-Message-State: APjAAAURspMKLIOo1/m1WxHDkZj1Aya0hzmXUianXJ8k43ImTVlCtiPQ
        DstyzEUFVXDrUHtMbuOqwJMeRsQ=
X-Google-Smtp-Source: APXvYqwld5ffy3XYYJumXMPmkKQz5Gc5XST2UIO1EEhtfK4zl1hJZzjNCevWVUbeRLAFuTl7ew5iqw==
X-Received: by 2002:a9d:6397:: with SMTP id w23mr274180otk.332.1556576807861;
        Mon, 29 Apr 2019 15:26:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j82sm14504482oih.31.2019.04.29.15.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 15:26:46 -0700 (PDT)
Date:   Mon, 29 Apr 2019 17:26:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [v2 1/3] dt-bindings: display: mediatek: update dsi supported
 chips
Message-ID: <20190429222646.GA20752@bogus>
References: <20190416054217.75387-1-jitao.shi@mediatek.com>
 <20190416054217.75387-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416054217.75387-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Apr 16, 2019 at 01:42:15PM +0800, Jitao Shi wrote:
> Update device tree binding documentation for the dsi for
> Mediatek MT8183 SoCs.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> index fadf327c7cdf..bd68195458b9 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> @@ -26,7 +26,7 @@ The MIPI TX configuration module controls the MIPI D-PHY.
>  
>  Required properties:
>  - compatible: "mediatek,<chip>-mipi-tx"
> -  the supported chips are mt2701 and mt8173.
> +  the supported chips are mt2701 , mt8173 and mt8183.

drop the space                     ^

With that,

Acked-by: Rob Herring <robh@kernel.org>
