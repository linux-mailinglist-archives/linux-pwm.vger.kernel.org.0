Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769C1298E33
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 14:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780322AbgJZNic (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 09:38:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40562 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780319AbgJZNia (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Oct 2020 09:38:30 -0400
Received: by mail-oi1-f193.google.com with SMTP id m128so10487950oig.7;
        Mon, 26 Oct 2020 06:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xeSglgw6V+lXedmY2yfKw+hxq6uo2upHgu1Rrr+TqIw=;
        b=nHxEwAPXiWBA84WKjvuSm4TYDx1HaL/aF/RaypDGeKZD7FIc6DC4qiXfNvuooWSjIn
         nJRykOYg+PwSTik4hf0ymN9Q3GJjBmRp5ga/kFySWk1rHLCvy8s8KkYHt3VyhBENqoZL
         xDGj75fWthb/CiRdQkn2xY0E49po8HtB7dXPmKj9otyWp0yzX1rE+yVGB+6kpbBcFIpH
         QW+IKl8Mg2E9zEqGXsH6yWPl4f16qk3BglbYYGmJe6f3Y7ATIyTH+jpb4TjrPA84YuWU
         hS/s+1Lzm6HLZLklzhk+eA4FWFMq1+zmOI6oEgridcMM1WsNfThLtRB/OjgVSqxjS8RS
         BblQ==
X-Gm-Message-State: AOAM533nHPGYKqaOyToSi2E6tV0YHJeJWLjrBlzV3GQ2RlnYUxTjyufx
        6T92HOi9O08yPwWYqQZAAg==
X-Google-Smtp-Source: ABdhPJwf8rWPGWPFxMh9FCJA9hqD+W6fqMrnAa7HRWtQOWAfWPHvQI2l4u1rlwvS2lGh3pCiZKqHfg==
X-Received: by 2002:a05:6808:aa1:: with SMTP id r1mr10468829oij.153.1603719509673;
        Mon, 26 Oct 2020 06:38:29 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u125sm4017909oif.21.2020.10.26.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:38:28 -0700 (PDT)
Received: (nullmailer pid 43832 invoked by uid 1000);
        Mon, 26 Oct 2020 13:38:28 -0000
Date:   Mon, 26 Oct 2020 08:38:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     thierry.reding@gmail.com, linux-mediatek@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: pwm: pwm-mediatek: Add documentation
 for MT8183 SoC
Message-ID: <20201026133828.GA43785@bogus>
References: <20201019140705.1518822-1-fparent@baylibre.com>
 <20201019140705.1518822-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019140705.1518822-2-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 19 Oct 2020 16:07:01 +0200, Fabien Parent wrote:
> Add binding documentation for the MT8183 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
