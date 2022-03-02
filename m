Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146654C9939
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Mar 2022 00:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiCAXXr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Mar 2022 18:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiCAXXr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Mar 2022 18:23:47 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE332071
        for <linux-pwm@vger.kernel.org>; Tue,  1 Mar 2022 15:23:04 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id l25so197848oic.13
        for <linux-pwm@vger.kernel.org>; Tue, 01 Mar 2022 15:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B0gHl0FY6TKEqOe5dLt6k+4Sn54m7FTDQTv9BgJSJmY=;
        b=w0vaAwCSOgyqV35VqOvdvCY5g5lLUapGsVPxGHCUGkyNVEZZ6/kdXXdorDxIWT537G
         MUzstVRDZ3xYnf+Y9IFCbWdyvIkckOkma3wtDXYzlDYyytWeVjj9Odjlj5+D9r8fwvj2
         HBlTjilOI+nEJdz3FhwuFG3VKC9KGwVOZ7O2hrV6heTO5iRov7z0PDXH3z4BPlRzYKTv
         5/jrfCYiWgnu5huDJykK1R+/WVA38iPh2c4glxVQ1n0YucaZOGhzKvcC+t97UFVrBEib
         t7csV3GYm681yeV9UhUvLQCbzuULjwq6xD1qPDdr/pvZDlEKMFcqLg3bq07rx6Y7Y6Ia
         G1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0gHl0FY6TKEqOe5dLt6k+4Sn54m7FTDQTv9BgJSJmY=;
        b=6aQ+o/iuqTQBfOdg5GxOKM6JccWPnLeOSmgDibMWnVjbTlSiESrXDXQ00G4vw3eUUX
         6J9g6lmdemG13QzWFbXhhn7WrDtHvXSBOJW0m2UI33wIf8HjovROp/oQFQSTojYZsQNd
         vCV0G7j6RP+R/CwnGg+w4rlFazdF6Exl0hZUv2ai2FYcGdc0Xp6Ivik1wgKh9xyM6tXQ
         NVdvQPEsOmlsMfXYuJq5OZkoddRQwPwvjyQ7c7qZlx7jpihgRdKsV9+takizWRlET/UA
         aFRGiJ7pnZf4n3NkqFK3vHYR8+yZ/yEJlEZgLZ8tQgxCoZSrAp+JBhSzyjHFYTiDK0C3
         oX3A==
X-Gm-Message-State: AOAM531IU6AKhQKGDtffz0lPC74CQeisucosXrp4tzcrUHm6BSl8kFtD
        KNrj4ckvz4nbpm/HivO09L3BeQ==
X-Google-Smtp-Source: ABdhPJxEJ64Gn/cTmYTu3qBhsOi969AzEkmMsQpBT2a/tPl/ZeLLMLvf5SzTIPzDYBU8Q9JQ6K3z1w==
X-Received: by 2002:a05:6808:1183:b0:2d4:5eeb:1ca3 with SMTP id j3-20020a056808118300b002d45eeb1ca3mr14925434oil.8.1646176983843;
        Tue, 01 Mar 2022 15:23:03 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 16-20020a9d0490000000b005ad3c83e927sm7091173otm.60.2022.03.01.15.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 15:23:03 -0800 (PST)
Date:   Tue, 1 Mar 2022 15:24:54 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v13 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <Yh6rRuAcyiF6QnFi@ripper>
References: <20220218183116.2261770-1-bjorn.andersson@linaro.org>
 <20220218183116.2261770-2-bjorn.andersson@linaro.org>
 <20220224165939.4275x7mzp7qpl2kj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224165939.4275x7mzp7qpl2kj@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu 24 Feb 08:59 PST 2022, Uwe Kleine-K?nig wrote:
> On Fri, Feb 18, 2022 at 10:31:16AM -0800, Bjorn Andersson wrote:
[..]
> > diff --git a/Documentation/leds/leds-qcom-lpg.rst b/Documentation/leds/leds-qcom-lpg.rst
[..]
> > +Simple pattern::
> > +
> > +    "255 500 0 500"
> > +
> > +        ^
> > +        |
> > +    255 +----+    +----+
> > +	|    |    |    |      ...
> > +      0 |    +----+    +----
> > +        +---------------------->
> > +	0    5   10   15     time (100ms)
> 
> you're mixing tabs and spaces here, I suggest to use spaces only. Not
> sure you want to respin for that.
> 
> (I didn't look into the rest of the driver, but assume it's fine.)
> 

Pavel, would yo like me to fix this up and send out v14 or would you be
okay replacing the tab with spaces while applying the patches?

Do you see any other blockers for merging this?

Thanks,
Bjorn
