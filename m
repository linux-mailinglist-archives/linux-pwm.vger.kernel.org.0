Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888DB3B38DF
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jun 2021 23:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhFXVlp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Jun 2021 17:41:45 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:38690 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhFXVlo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Jun 2021 17:41:44 -0400
Received: by mail-io1-f52.google.com with SMTP id k11so10127207ioa.5;
        Thu, 24 Jun 2021 14:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YnXB8ehdV2cGFafejEyJV7Eeti9SxAJw4sYhn9A6WGo=;
        b=N4cC8LmDAxWRK4jmA3tCYV4E/MYELtc+psm51Ii36C86SaqLWfMHBWf1z7J7KPSJLk
         2kJI8rZVYEzt0yjvgWk4CwezE8iALCxwf5IEXfXpEBGtxSVD2dvaI0nIP7z1F5/lK4iR
         2kMjGf8LG+KqukGXRccWe4R3KLkS+WtdAl6TwhL5T1YC0I3at64Fxz8GlT7GphJi+vCF
         1DydY5FrkA97L2zUjAV0LgL3VV54ZfSgDB+8gJIPoqZjI0F3jirjhzsKx+/ZX2onGwmO
         YRGCJhoW8p/4iUdxsv5zE+NHQKPrQgATKnL/FRgSZyFnI2sjJdxcX9dQlduXrF2hC4Q7
         ZW+Q==
X-Gm-Message-State: AOAM533kZKpPiLFENYyZ/5tNib9LsH++Kc9hubVfByf6NkYMkbunsC0T
        GUCWFAHu9rspmNKfFQ8q5w==
X-Google-Smtp-Source: ABdhPJxUY7xgMb5yo9OZEwj8jvIQPxS3q+2Txh9MVuVIhZrZr+Q1IgcLy5cH6KnDO/7UR9dTvm4Y2Q==
X-Received: by 2002:a5d:8242:: with SMTP id n2mr5853357ioo.198.1624570763893;
        Thu, 24 Jun 2021 14:39:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t21sm1983944ioj.10.2021.06.24.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:39:22 -0700 (PDT)
Received: (nullmailer pid 2032229 invoked by uid 1000);
        Thu, 24 Jun 2021 21:39:17 -0000
Date:   Thu, 24 Jun 2021 15:39:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <20210624213917.GA2032180@robh.at.kernel.org>
References: <20210623035039.772660-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623035039.772660-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 22 Jun 2021 20:50:38 -0700, Bjorn Andersson wrote:
> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v8:
> - None
> 
> Changes since v7:
> - Added qcom,pmc8180c-lpg
> - Defined constraints for qcom,power-source
> - Changes qcom,dtest to matrix and added constraints
> - Changed example from LED_COLOR_ID_MULTI to LED_COLOR_ID_RGB
> 
>  .../bindings/leds/leds-qcom-lpg.yaml          | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
