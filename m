Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B685D3FF541
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Sep 2021 23:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbhIBVDN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Sep 2021 17:03:13 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45609 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhIBVDN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Sep 2021 17:03:13 -0400
Received: by mail-oi1-f173.google.com with SMTP id q39so4254683oiw.12;
        Thu, 02 Sep 2021 14:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IG8K7Ak73Pm6+oIzwqp5J2waDXTL9oO9Diu9ISkZy4o=;
        b=GGCm6hYZTDdDa4GUnXp1lxZzLpEvdLCdPujg0H67qVM0HkcsQaaV6zXPrXA8n49om7
         2LPdvsQHrrhU0aWWZVUdGlacVXbDCeq/ME+E1fMRhzCKDt8ZVQ3drp5mx37DA9DtDVHI
         lb1p/yubuNt73N9D2w/I9ffV9YSHljnuTMf4F6Q/eQ/d4Rfd91vCB4FbgEnCUIWbstey
         L4my/kaznfbzH31YVROvTah5tHYhEPlqMuVIaGvj8xlNaT8h7Cia1fjmsg5PrulNXB0b
         JHt3B6Ewx7z8n9hsyxxYXActIbnEyv4hu0YbBWFEbL6Ttbp1aI1mIE3ht93j0wIRwS1S
         HWEg==
X-Gm-Message-State: AOAM5312H3mqECsjw7jfAt9jmd6Ba/FKa9jlgiFvhYC15s8co9p7W3Vj
        HuXQ+IOu0oAEAjuNUiYYJg==
X-Google-Smtp-Source: ABdhPJycAPaGXMQZQwQA6zRj5ZZ6eg7ysG9pNURlWAHTcxdaLDZMnVyOZFbf3yHxdVuQhmrWzWJTdQ==
X-Received: by 2002:a05:6808:10c8:: with SMTP id s8mr188252ois.6.1630616533982;
        Thu, 02 Sep 2021 14:02:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u27sm581943otj.6.2021.09.02.14.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:02:13 -0700 (PDT)
Received: (nullmailer pid 1417644 invoked by uid 1000);
        Thu, 02 Sep 2021 21:02:12 -0000
Date:   Thu, 2 Sep 2021 16:02:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car V3U device tree bindings
Message-ID: <YTE71AmRgTzhW2PZ@robh.at.kernel.org>
References: <20210901090719.35375-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901090719.35375-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 01 Sep 2021 11:07:19 +0200, Wolfram Sang wrote:
> From: Duc Nguyen <duc.nguyen.ub@renesas.com>
> 
> Add device tree bindings for TPU with the PWM controller found
> on R-Car V3U SoCs.
> 
> Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
