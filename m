Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1329539C1C3
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jun 2021 22:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFDU7g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Jun 2021 16:59:36 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43946 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhFDU7g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Jun 2021 16:59:36 -0400
Received: by mail-ot1-f48.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso10340461otu.10;
        Fri, 04 Jun 2021 13:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Elxb3rK3x/4U++qApO9PAM2B/AZWM7MGwkHOJawX95Q=;
        b=llLCvILZebgCl1ISh11EugaPbIglXo1mS3LGU1ey5GIGQFdBdrjntZdLab3Z48UnHU
         4M5E/OmqalSg6by7cuLnNPUjSNgRAMus+CP2T6ewGZM3sGNsihf7hoLvQhmMdxjtaj/P
         LI0M7ZMEzgxigwRlhD9eq5mu7NAirugS0vkUzoYFEhLzxaigPfz+1SB21aUX6v/Ad61P
         Rj3uWJFlTjlsDM3ebpatUrhm7nxJgLmIvXfNzaJFA/i68X6dbTFRJgTyKpetP1dbzLap
         fyBfWkqPCw/G48uOMLpGC3sgnyt4KC9uoAraBg5ajqGZWuavDDHarNsUGreUET3gWXqh
         LJTA==
X-Gm-Message-State: AOAM531yxuGwdj0g9UJhMY06LGXN5jZbpyN+Tz5AFgNldGHMXd7VRLIv
        devzU0aQu5tnuVlH+uAcFQ==
X-Google-Smtp-Source: ABdhPJwDy254Ii6EJyqsrGFEuLwAKAC+6UNXts4PYchcl9t9VYdLQSp/B+FGne9QKEpzYhPLZXBVgA==
X-Received: by 2002:a9d:5eb:: with SMTP id 98mr5455935otd.61.1622840269022;
        Fri, 04 Jun 2021 13:57:49 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w11sm658970oov.19.2021.06.04.13.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 13:57:48 -0700 (PDT)
Received: (nullmailer pid 3904119 invoked by uid 1000);
        Fri, 04 Jun 2021 20:57:47 -0000
Date:   Fri, 4 Jun 2021 15:57:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     linux-pwm@vger.kernel.org,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>, tony@atomide.com,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com
Subject: Re: [PATCH v2 2/4] dt-bindings: pwm: tiehrpwm: Make clock and
 clock-names as required properties
Message-ID: <20210604205747.GA3904064@robh.at.kernel.org>
References: <20210528045817.16618-1-lokeshvutla@ti.com>
 <20210528045817.16618-3-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528045817.16618-3-lokeshvutla@ti.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 28 May 2021 10:28:15 +0530, Lokesh Vutla wrote:
> Driver fails to probe when 'clock' and 'clock-names' properties are not
> populated in DT. But the binding documentation says these properties are
> optional. Fix this by making 'clock' and 'clock-names' properties as
> required.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
