Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18A70795
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2019 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfGVRjm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jul 2019 13:39:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33239 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfGVRji (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Jul 2019 13:39:38 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so75838742iog.0;
        Mon, 22 Jul 2019 10:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yuyB8pILujpflF/Q/M9APeaT5IXpHOGkbQKNsVipriU=;
        b=YMnDDGpqtihngU2XWC4e9SLK1sLrK28a7LKJBSpEwCjcLouedXzcTGrHou65W6SfSV
         rHMHML8qaNGPuIJ3wcIi3ZVgx7puk8T5kviG53nnYuqNcaTiXROyL2NYDe3F31XQcutI
         peVgLKOXOhBoor2j+PgkQg5mqK5LmDOv6hKUAGT87MAWb/oGSpWrm6jL5x+cgo8WoL6d
         evleacvElgPIEumo3tWSRJxbL30GBZqmVfa37En8q7cLC2UiFo0ocoS2KDgDP38A2/fG
         wYXjR9RPSD6i8vyrJWy/yOIHU92Z7rn4mPSOswrCSZIjhOfiMHQj+8r4qB8gayCRwF+W
         xtag==
X-Gm-Message-State: APjAAAX/JE0yrEk0c+62p54U3IXsY3s4ZHyj9RWdMsGNo1uKLKsTbuYg
        xL0qmQdE+byfGfXLKL8tPg==
X-Google-Smtp-Source: APXvYqxNSkCw3W+oC2a+dAbLpos4fIcmpa8N1UVKkDaxst8+m0rwQM+coXmVvshQIkATlSLf6D7EeA==
X-Received: by 2002:a02:b713:: with SMTP id g19mr74167358jam.77.1563817177425;
        Mon, 22 Jul 2019 10:39:37 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id i3sm37295539ion.9.2019.07.22.10.39.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:39:36 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:39:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
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
        ck.hu@mediatek.com, stonea168@163.com,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [v3 3/4] dt-bindings: display: panel: add auo kd101n80-45na
 panel bindings
Message-ID: <20190722173936.GA26950@bogus>
References: <20190626025400.109567-1-jitao.shi@mediatek.com>
 <20190626025400.109567-4-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626025400.109567-4-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 26 Jun 2019 10:53:59 +0800, Jitao Shi wrote:
> Add documentation for auo kd101n80-45na panel.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/auo,kd101n80-45na.txt       | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
