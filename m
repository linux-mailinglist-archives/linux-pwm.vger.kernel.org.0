Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B04386EB0
	for <lists+linux-pwm@lfdr.de>; Tue, 18 May 2021 03:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbhERBIA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 May 2021 21:08:00 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35351 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhERBIA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 May 2021 21:08:00 -0400
Received: by mail-ot1-f50.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so7235565otg.2;
        Mon, 17 May 2021 18:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=889Beyv1UMO0naKXZ0qFvG63Gf1vGU9LlFLp0aQIaHM=;
        b=Gnfr7Z4pz0oj7julC3o7M4qd+Jd6JsuB9a9kitoexYj7vxVR1OSSFUtoAhFraQ54+8
         1xqUHzzG3uPoT5IVuicrcPbnwKMX+G3nNVmWKh7SUVZxL3rbaiw4d+FmFWGpNYHsebOu
         JYvZjz68RUoSIHTkIMpP7/4C2W2PBO6xLw/3xKk2ApEdUtiF2YC/OYykGOKxp3OE8uYf
         6USxrPXA2om5AF6sHc1YMsnMmgsWRc7yBosb59xyKKzJIREucV77wzQiE3YAUw7xUYk4
         ViAdGvInGruHB8p3JSlNUgPpaeAbMSGxAPcmgt2tSHdi5FtG5mpr0OFS91biGSHnsqJN
         ZhIg==
X-Gm-Message-State: AOAM531+Lp+bDOq07v3paR7hB66ihrR1V/yT6qdSpmtBuzNR7f9kyny1
        sN6RlXSsXlByQVEDvaLUYA==
X-Google-Smtp-Source: ABdhPJzxcsdcpEvW122bFx/IkeffFFw09WWGLE86c7d0Jjbyh7gKOMj4NqNOaLAzc0dNWf5fdJullw==
X-Received: by 2002:a9d:6d88:: with SMTP id x8mr2045645otp.35.1621300002759;
        Mon, 17 May 2021 18:06:42 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 19sm3039445oiy.11.2021.05.17.18.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:06:42 -0700 (PDT)
Received: (nullmailer pid 3566129 invoked by uid 1000);
        Tue, 18 May 2021 01:06:41 -0000
Date:   Mon, 17 May 2021 20:06:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pwm@vger.kernel.org, Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH] dt-bindings: pwm: brcm,iproc-pwm: convert to the
 json-schema
Message-ID: <20210518010641.GA3566040@robh.at.kernel.org>
References: <20210512160253.15000-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210512160253.15000-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 12 May 2021 18:02:53 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/pwm/brcm,iproc-pwm.txt           | 21 ---------
>  .../bindings/pwm/brcm,iproc-pwm.yaml          | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml
> 

Applied, thanks!
