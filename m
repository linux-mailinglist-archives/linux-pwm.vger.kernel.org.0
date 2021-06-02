Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B75F39939D
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jun 2021 21:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhFBTh0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Jun 2021 15:37:26 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:36558 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFBTh0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Jun 2021 15:37:26 -0400
Received: by mail-oo1-f44.google.com with SMTP id v13-20020a4aa40d0000b02902052145a469so829765ool.3;
        Wed, 02 Jun 2021 12:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pm7Iu9IHKjSnprzCKiU543Rykd3Cwbz6QAFH+vit6nw=;
        b=Fi6cD3qa9kwchjqTaczK9oZw09S1FiTEuLW/NTIP9aNJHLfCTC7BUeGu3JVQQ+bz2x
         Goa7zydwR8ndyWRmzpIPM1rqzbn7gKVcVJKAumuUy3cCa7crlGxcGZ3jzlc3RYvGlOgR
         Lvodtw03eZDeoaf3v3/cU3t4ow5YbHH6rPfSQ3YtKvizxVjfXQ1oquVQIRb33pDEtAwi
         R2lddiaIZ+T72vVPNLg4FhrEq9C9KfwGaJxTbckn8pRDaTfGKxGYg/hIRXHNav9j278o
         MPqj0HaWMLGsYO4s1Sdh56I1WmHCHIVaLnxriNG5+FN/VmzJwZE22aO3gMw6FO+u3THM
         NxcA==
X-Gm-Message-State: AOAM5315ioRzcNS8XbjNpFIvsnrHHayeVwtsiJ3s9ASi529r4ZnJQ++4
        Y6D9UI1iPL5B4gNeVOM///5X5v14hw==
X-Google-Smtp-Source: ABdhPJyaITyUBqfPzxbXDNFT3MMZo7ANUY95iWYMKd6RnDGk5ExrcUkhMvt4ds2uDcvEfpFD12evgQ==
X-Received: by 2002:a4a:8311:: with SMTP id f17mr26075020oog.83.1622662542300;
        Wed, 02 Jun 2021 12:35:42 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 129sm169068ooq.34.2021.06.02.12.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:35:41 -0700 (PDT)
Received: (nullmailer pid 3845518 invoked by uid 1000);
        Wed, 02 Jun 2021 19:35:40 -0000
Date:   Wed, 2 Jun 2021 14:35:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        tony@atomide.com, lee.jones@linaro.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        u.kleine-koenig@pengutronix.de, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: pwm: pwm-tiehrpwm: Add compatible
 string for AM64 SoC
Message-ID: <20210602193540.GA3845460@robh.at.kernel.org>
References: <20210601054402.2223-1-lokeshvutla@ti.com>
 <20210601054402.2223-3-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601054402.2223-3-lokeshvutla@ti.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 01 Jun 2021 11:14:02 +0530, Lokesh Vutla wrote:
> Add compatible string for AM64 SoC in device tree binding.
> EPWM IP in AM64 does not support High resolution, so named epwm instead
> of ehrpwm in compatible. However IP is till compatible with features
> supported by driver with ti,am3352-ehrpwm compatible.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
