Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B235A549
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 20:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhDISIJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 14:08:09 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35408 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbhDISII (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 14:08:08 -0400
Received: by mail-ot1-f44.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so6543055oto.2;
        Fri, 09 Apr 2021 11:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4yvF98K4lFRVo3XP29/vi2BrNQZ7QCXpM/98vWUndG4=;
        b=MaTiiZ4+elFgWEerQrtCNacS9EJqtcPIbOasJlHt9NMNFKfZahy5WapYpQ7gToAjeF
         MhGdTtbNRTD9GR5ov09KAypSoqCHOrrI7f5VhKK6nSSOhXS+uT4ZsaZVhPovi6pW4eGd
         vfzzNXVt/nid0ZRhNExRT/RNrCC1R/tRcx2Uto6LnaSqhYBdBFspeYeLf3CQ7R3E0reH
         Ni1o3nVEL70FtvtE/wgr29NVoQOY1KfalY6xwM3hKbtx3a2wJUdo/JUqF9zGiZnLKOj3
         TtRNC5UJOYCCU7cAaLH6M8BLFZTm33vOrMMekKpYoFMjrAxwtr5B7i6520IifvsmEOZz
         WesA==
X-Gm-Message-State: AOAM531DKga3NFcrzYei36zyM7A4MKFtCn6ZDWehAiJxHtLxV3ijJ+d6
        UFcHhvp2jxJFm5ZX+5qCGg==
X-Google-Smtp-Source: ABdhPJycyNDeF4TXmOLJ3zpWi5p3KJj9nwxrubKDZZI0I4BTxfGzpiiIDWKvlDp7tT89D/07Lg/cVA==
X-Received: by 2002:a9d:7e8d:: with SMTP id m13mr13036594otp.54.1617991674538;
        Fri, 09 Apr 2021 11:07:54 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u185sm181079oie.12.2021.04.09.11.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:07:53 -0700 (PDT)
Received: (nullmailer pid 3892577 invoked by uid 1000);
        Fri, 09 Apr 2021 18:07:52 -0000
Date:   Fri, 9 Apr 2021 13:07:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
Message-ID: <20210409180752.GB3769113@robh.at.kernel.org>
References: <20210406155053.29101-1-jbx6244@gmail.com>
 <8f05dc0d-8fb7-c200-5251-d9e147b1d00d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f05dc0d-8fb7-c200-5251-d9e147b1d00d@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Apr 06, 2021 at 09:04:29PM +0200, Johan Jonker wrote:
> Hi,
> 
> Question for Heiko:
> rv1108.dtsi and rk3328.dtsi have a undocumented "interrupts" property
> AFAICT without driver support.
> Please advise what to do with it.
> 
> 
> See build log:
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210406155053.29101-1-jbx6244@gmail.com/
> 
> ====
> 
> Question for Rob:
> It looks like that recent "improvements" with regard to checking for
> undocumented compatible strings make it almost impossible to do any
> useful dt_checking, let alone for the average user. Maybe reduce the
> notification blurb output a bit for things that have nothing to do with
> this document. 

It's off by default for dt_binding_check until the 80 or so warnings are 
killed. It's on for the PW checks so new ones don't get added. It's also 
off for dtbs_check if you set DT_SCHEMA_FILES. 

> Unable to fall back to previous versions for older kernels.

Sorry, don't understand this sentence.

> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master
> --upgrade
> 
> make ARCH=arm dtbs_check
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> 
> make ARCH=arm64 dtbs_check
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
