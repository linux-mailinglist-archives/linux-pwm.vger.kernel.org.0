Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D84F39C2E4
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jun 2021 23:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFDVvF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Jun 2021 17:51:05 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43857 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFDVvE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Jun 2021 17:51:04 -0400
Received: by mail-ot1-f48.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso10463037otu.10;
        Fri, 04 Jun 2021 14:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=USdbMhWSRgMqODaRMx3wKYgyJf2pCkCziKl2l0CDKDo=;
        b=ErQHTbJIzvpp9rOpytpj6NpMoRDsgM9+CQ97K77aQ4pk63Feodp4xYqPl6uNEWGYIC
         7MdWK8fxViFDYqfz7HrR0U8LOTAn80oBjEkAJ7QZJVA9Dy0cfGvjiTXtwDxO+YDg4SFm
         cKY3SZkKcRp+Wy5kM83FskyI1OPQoIeJfpJYlWEVvGGOmhDVMMNVIYfN1f2aKpOzfC6u
         27kzsbYHf8PLhj4L/akZ7TbHMXIMJuANErFKZ2O75yxdxqbMhkOa+Jx3cMnqijsBj6ih
         EKFjdJxsRmsrkyE5Il5D4GYDYij3Pg9WNvE3a7yw7c2cKhFTrCipyEVuSXz0VC8XOYdM
         AFQg==
X-Gm-Message-State: AOAM531ztgIpz3/1B1em+f68bCc88SmtJu/2jeq2POKsjAuiOFnMGeUu
        0MnqKOamXoFkNpyHJBAynA==
X-Google-Smtp-Source: ABdhPJwwMN055pDTnS3iLcssrEc5Fq8uTwxHn7q3GorjKCpg5IWVlPe9miBhiAs75SD5YuQw1gQ6Sg==
X-Received: by 2002:a9d:7a5:: with SMTP id 34mr5340827oto.371.1622843357711;
        Fri, 04 Jun 2021 14:49:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j26sm736132otp.15.2021.06.04.14.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:49:16 -0700 (PDT)
Received: (nullmailer pid 3984270 invoked by uid 1000);
        Fri, 04 Jun 2021 21:49:15 -0000
Date:   Fri, 4 Jun 2021 16:49:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        tony@atomide.com, Vignesh R <vigneshr@ti.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: pwm-tiecap: Convert to json schema
Message-ID: <20210604214915.GA3984212@robh.at.kernel.org>
References: <20210601102804.22152-1-lokeshvutla@ti.com>
 <20210601102804.22152-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601102804.22152-2-lokeshvutla@ti.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 01 Jun 2021 15:58:03 +0530, Lokesh Vutla wrote:
> Convert the tiecap binding to DT schema format using json-schema.
> Along with this conversion the following changes are included:
> - 'clock' and 'clock-names' properties are marked required as
>    driver fails to probe without these properties
> - Dropped ti,am33xx-ecap as it is no longer applicable.
> - 'power-domains' property is introduced and marked as optional.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  .../devicetree/bindings/pwm/pwm-tiecap.txt    | 51 ---------------
>  .../devicetree/bindings/pwm/pwm-tiecap.yaml   | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
