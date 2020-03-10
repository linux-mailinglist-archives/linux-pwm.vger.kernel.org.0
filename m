Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A40E180AB4
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Mar 2020 22:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgCJVnc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Mar 2020 17:43:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45649 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCJVnc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Mar 2020 17:43:32 -0400
Received: by mail-oi1-f193.google.com with SMTP id v19so15520230oic.12;
        Tue, 10 Mar 2020 14:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmuqO8QVdRKURofONAFY/I+OMxAbc3hBwN/Zd0CaDzU=;
        b=c+uXonxk2Ez5Lw4iAGk6VNFbyanHa9c6Y7kG9/TAQbCOWnb8nUtrwd3wj6WIY+0Rdi
         BYooHeKxmVe52L0HlJzx0I0urTuVKb6gpP3YxiFTVbNPvnTdiTrmSnTR4dN9wXHTSzBa
         mi3rUdu9g5oa8ULMoYO66mzzSpxjByzQ9fUFxRnPcoo5mfWEKgDjN/uKnDSZScQPrxu8
         AEfUcAZIp4Os3KwbInJwX+C6cAtC3AQ06WGs0ZRtpJTrRgWwexo4OULr0h35VQpqqEho
         dphPP4hZ84cT41zpRPvTCk6Zf0n5qPY/Tn0UXLYltHJlRMIDOr74vAtErFwemvh1BesW
         dnZg==
X-Gm-Message-State: ANhLgQ24Pn3lu25ROaUkdEtvoRcHVvPb7WmNYPCfj1HrhPgh+YzgAdRn
        YYUT6heylaEAOwRqIt3HNzXWInQ=
X-Google-Smtp-Source: ADFU+vtT6bnvhh1nOi/1f++kPH4ke/6PZMUyuI2Kqv0ia/Rowt5QY+hspcXTJL9XomXyZ3ZdZS3aDQ==
X-Received: by 2002:a05:6808:1cf:: with SMTP id x15mr2826049oic.44.1583876609873;
        Tue, 10 Mar 2020 14:43:29 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f84sm4686869oib.32.2020.03.10.14.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:43:29 -0700 (PDT)
Received: (nullmailer pid 21483 invoked by uid 1000);
        Tue, 10 Mar 2020 21:43:28 -0000
Date:   Tue, 10 Mar 2020 16:43:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     treding@nvidia.com, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, jonathanh@nvidia.com,
        bbasu@nvidia.com, ldewangan@nvidia.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sandipan Patra <spatra@nvidia.com>
Subject: Re: [PATCH] pwm: tegra: Add support for Tegra194
Message-ID: <20200310214328.GA21450@bogus>
References: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 5 Mar 2020 16:57:33 +0530, Sandipan Patra wrote:
> Tegra194 has multiple PWM controllers with each having only one output.
> 
> Also the maxmimum frequency is higher than earlier SoCs.
> 
> Add support for Tegra194 and specify the number of PWM outputs and
> maximum supported frequency using device tree match data.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 1 +
>  drivers/pwm/pwm-tegra.c                                      | 6 ++++++
>  2 files changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
