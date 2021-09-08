Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850A8403AFE
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Sep 2021 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhIHNxg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Sep 2021 09:53:36 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36836 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhIHNxf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Sep 2021 09:53:35 -0400
Received: by mail-ot1-f45.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso3049706otv.3;
        Wed, 08 Sep 2021 06:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AKmh/iz5GjXb9jV2WgJE97BiPPD0UyKSlV6g4kHyX3s=;
        b=I9ic/V8VG4CA2/SmVs3OykJwaBzoTvlrfAXYm6BwjerYuONFv1uKa3GvIoafbRekR+
         /UfPEQQKLeIJ4Xw1nGHi6dcXMDTOOOVSFks6WEWu86LRGENYBqwY+zMSloetEN/GO3pV
         UnwY4mODOIHEtgyvwd2jeLxKg6kNAiNTSVUEIakPp6KwriKSkHPaFQpimhoI/3iWoauT
         QYb0401IixZt5zAdLVRyQ+zV191bg/CeHjNtCIGoHcU393xphAlkul+NIKTMDr5CbXZs
         4DPPLhFDvL1Sa+DPgoMiBX9jLvgZufgmLDSgQDKbWFmEBSiSutQwjC0Yt7jxV3gYhRpm
         mIZw==
X-Gm-Message-State: AOAM533yDoC5CtBoM4Y0z+yEoPttsRy/sNrxXND13XG8S7Id8pI04MU7
        +EaVrD/SnEyFHGJNEsKhXMqgmLbnmA==
X-Google-Smtp-Source: ABdhPJxd3SOXPp/7v6o3tgZbg3vbfrZDi4PgpGQPAUK5NRAjGoi/3JeLE7nLEda+67RBMXZs5xyCeg==
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr3104033otn.239.1631109147643;
        Wed, 08 Sep 2021 06:52:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l4sm448987oth.4.2021.09.08.06.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:52:26 -0700 (PDT)
Received: (nullmailer pid 2029684 invoked by uid 1000);
        Wed, 08 Sep 2021 13:52:24 -0000
Date:   Wed, 8 Sep 2021 08:52:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car M3-W+ device tree
 bindings
Message-ID: <YTjAGLlLvUOF4eO9@robh.at.kernel.org>
References: <20210906094536.45223-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906094536.45223-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 06 Sep 2021 11:45:35 +0200, Wolfram Sang wrote:
> Add device tree bindings for TPU found on R-Car M3-W+ SoCs.
> 
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
