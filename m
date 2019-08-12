Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB7B8A9AE
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 23:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfHLVtg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 17:49:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40739 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfHLVtg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 17:49:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id c34so24775132otb.7;
        Mon, 12 Aug 2019 14:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bId57j+xCMgHmNke4H/rs1zm5GrySxRkVxKOzngNvUM=;
        b=gCBHpJHRlmd6lNJwpANJIKoeYFzIE9DYzReik3UDmdd2ovdHaDNVTyBEP4Wgk0vKhz
         F4KS8OnBD+1+lsEa1rnt6i5/trEU6lzUmrTffNzrm+ePDhoHHjbjomNA1OSRb9yF5x/U
         rHe9gNwAcUTHOXk/awqmceph7/Xky6H7533BDbg8pBbJi4S5d09T5aQgjvVBcmc6TfGg
         t6YP9ayaAZQxZJOCPwK23zduQKH3d/JeUE5x9WHxwl8gDuvnTd0CMvZYVWV4GB4gM5db
         jAklDAbSNKFZeP3xoz0+GuMo5GXQroQHC0N6L8bLUz94O+dBH26ZNBFBU5WuyG+Y7cZa
         dOlQ==
X-Gm-Message-State: APjAAAVTUPNyEdXOkd0crbDrGStIJlGgS1iahexNlejVKIWvrYLc0U+f
        X7ReGaHfPFz1GktV5Q89Gg==
X-Google-Smtp-Source: APXvYqydXCuTRQqJ+qulK7XUYr9oCHuac1Wfp89EYjWA89p2UUzerGucxvamiLfRUxWnafYzdRe2lA==
X-Received: by 2002:a6b:fd10:: with SMTP id c16mr34339686ioi.217.1565646575229;
        Mon, 12 Aug 2019 14:49:35 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id r5sm86648270iom.42.2019.08.12.14.49.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 14:49:34 -0700 (PDT)
Date:   Mon, 12 Aug 2019 15:49:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>,
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
Subject: Re: [PATCH v5 1/4] dt-bindings: display: mediatek: update dpi
  supported chips
Message-ID: <20190812214933.GA5954@bogus>
References: <20190807060257.57007-1-jitao.shi@mediatek.com>
 <20190807060257.57007-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807060257.57007-2-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Aug 07, 2019 at 02:02:54PM +0800, Jitao Shi wrote:
> Add decriptions about supported chips, including MT2701 & MT8173 &
> mt8183
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.txt        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> index b6a7e7397b8b..cd6a1469c8b7 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> @@ -7,6 +7,7 @@ output bus.
>  
>  Required properties:
>  - compatible: "mediatek,<chip>-dpi"
> +  the supported chips are mt2701 , mt8173 and mt8183.
>  - reg: Physical base address and length of the controller's registers
>  - interrupts: The interrupt signal from the function block.
>  - clocks: device clocks
> @@ -16,6 +17,11 @@ Required properties:
>    Documentation/devicetree/bindings/graph.txt. This port should be connected
>    to the input port of an attached HDMI or LVDS encoder chip.
>  
> +Optional properties:
> +- dpi_pin_mode_swap: Swap the pin mode between dpi mode and gpio mode.
> +- pinctrl-names: Contain "gpiomode" and "dpimode".
> +- dpi_dual_edge: Control the RGB 24bit data on 12 pins or 24 pins.

Nothing about this in the commit msg...

The dpi* properties need vendor prefixes and use '-' rather than '_'.

Rob
