Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DEF37F159
	for <lists+linux-pwm@lfdr.de>; Thu, 13 May 2021 04:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhEMCeh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 22:34:37 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45722 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhEMCed (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 22:34:33 -0400
Received: by mail-ot1-f52.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so1366287otc.12;
        Wed, 12 May 2021 19:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qEHME9tq76pKZapqAg+MH3wJx3w4U0y+wb+99MmHe5g=;
        b=H9jgTpXsdjdlL2TmhkBNleEshEgKfkjaBOlSUijJJfAT+ODkdYy/9ykMKvu8Fj+h4E
         PMz+z7ZEdbJJaazyja3BgZPMsACWh7SEcqzJ55CBohMvGbJfa/POFTVz7wTZvcJoSAJt
         woiZ2VLSUT++PstSZ09b60p3g4cJoa+1UV588BYDovRUFlJQ7CLPKccTzPwh7EgINGvF
         Pzcyw6+Tc0tFxIK9H7bkTfiKJPj71mwgp61m+fGOIQW7Jxdhxu8A4+FkbjK3BluEeE4n
         ZnowXS7B1EZsXqGLSgz7iPg6peDM9a6Om45DNCjwdOZcpqV/0IHPEZeKvoGJXTQIZ50m
         7mVA==
X-Gm-Message-State: AOAM530flF3810Q+exKirTE0kX6V2zzuk9ydgU+G5MjbtDOCWiAWivt6
        gR38DjXCGxaxo4v3fLaw+RYcMZLA2w==
X-Google-Smtp-Source: ABdhPJzYRj34zjiL3/HMpsnugxMA/Dt2D9BuyM/4yFDUNloV+wPx0Xj4cMYvRiViW9rLr+PPZlEZ3A==
X-Received: by 2002:a9d:453:: with SMTP id 77mr34832457otc.31.1620873203251;
        Wed, 12 May 2021 19:33:23 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x5sm365017otg.76.2021.05.12.19.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 19:33:22 -0700 (PDT)
Received: (nullmailer pid 915821 invoked by uid 1000);
        Thu, 13 May 2021 02:33:21 -0000
Date:   Wed, 12 May 2021 21:33:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-renesas-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: renesas,tpu-pwm: Improve
 json-schema
Message-ID: <20210513023321.GA915748@robh.at.kernel.org>
References: <cover.1620648868.git.geert+renesas@glider.be>
 <d36e3690ce8c5a1e53d054552e4fd8b90d6a5478.1620648868.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36e3690ce8c5a1e53d054552e4fd8b90d6a5478.1620648868.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 10 May 2021 14:18:34 +0200, Geert Uytterhoeven wrote:
>   - Include the general PWM controller schema,
>   - Make clocks, power-domains, and resets properties required.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Keep additionalProperties, as pwm.yaml doesn't add any other
>     properties.
> ---
>  .../bindings/pwm/renesas,tpu-pwm.yaml           | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Applied, thanks!
