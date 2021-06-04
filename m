Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3560639C1C0
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jun 2021 22:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhFDU7P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Jun 2021 16:59:15 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44933 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhFDU7O (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Jun 2021 16:59:14 -0400
Received: by mail-ot1-f45.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so10331104otp.11;
        Fri, 04 Jun 2021 13:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p9kkV653ZiKdFQ+/1DXekXEvXDMlTVfBf/JFELEUQqE=;
        b=kmC9JsE2AaqmfP+zSMhNsqIIjI32p2ht9YW+ILXN+IdE3TYGMi9q75uWxOafAjRnOb
         HBz1tyOWNUzLmfb4mdiJfszaC9Dqr6yTKRqAClxjoe2fi/wy5gE57urDDO6B2O9e9Fjg
         DhU4V2TpCjREVmCEaYGU6kcYWXEsaH15E0dNhtW8WZU7LBrs3O0apCZaqg8jw1nt0RsV
         rl3dTJ7xdLanL+50h5h2vuMLIILLzjOX6wDZABkQXEnCDfXhzK5JtDfUswp2EacPO317
         WTFCmPucQXiEgvJUqQUHbcWAcxAwAwZ0pEFp/1ljLIg97bsFd8TUnauPzVFiP1IWgB92
         sXLA==
X-Gm-Message-State: AOAM532ZPKzO8tLIzgAAzeL6+xW6q/L9x6lzxOESKMvLc5cRCPrhFURl
        PByDKtOwWonEy6qtu10iZg==
X-Google-Smtp-Source: ABdhPJzQ7m0aAMMJL847Mh0rDqLY21LmtSlVGyeU2JeA2h9e8dIPtikkCaitIoudxCbYStkTKC2o0Q==
X-Received: by 2002:a9d:5ccc:: with SMTP id r12mr5093410oti.172.1622840242753;
        Fri, 04 Jun 2021 13:57:22 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q6sm665894oot.40.2021.06.04.13.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 13:57:21 -0700 (PDT)
Received: (nullmailer pid 3903309 invoked by uid 1000);
        Fri, 04 Jun 2021 20:57:20 -0000
Date:   Fri, 4 Jun 2021 15:57:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        tony@atomide.com,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] arm: dts: ti: drop usage of redundant compatible
Message-ID: <20210604205720.GA3903275@robh.at.kernel.org>
References: <20210528045817.16618-1-lokeshvutla@ti.com>
 <20210528045817.16618-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528045817.16618-2-lokeshvutla@ti.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 28 May 2021 10:28:14 +0530, Lokesh Vutla wrote:
> Commit 229110c1aa691 ("ARM: dts: am437x/am33xx/da850: Add new ECAP and
> EPWM bindings") added ti,am3352-ehrpwm compatible which is similar to
> ti,am33xx-ehrpwm but without out t,hwmod properties. But with commit
> 58bfbea5b1c68 ("ARM: dts: am437x/am33xx: Remove hwmod entries for ECAP
> and EPWM nodes") dropped support for all ti,hwmod for ehrpwm, but
> missed deprecating ti,am33xx-ehrpwm compatible. So drop ti,am33xx-ehrpwm
> from DT as it is no longer needed.
> 
> ti-ehrpwn driver still support ti,am33xx-ehrpwm in order to maintain
> backward compatibility.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt   | 13 ++++++-------
>  arch/arm/boot/dts/am33xx-l4.dtsi               |  9 +++------
>  arch/arm/boot/dts/am437x-l4.dtsi               | 18 ++++++------------
>  arch/arm/boot/dts/da850.dtsi                   |  6 ++----
>  4 files changed, 17 insertions(+), 29 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
