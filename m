Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64F35C962
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbhDLPFy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 11:05:54 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:40536 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbhDLPFy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 11:05:54 -0400
Received: by mail-oi1-f175.google.com with SMTP id i3so13718445oik.7;
        Mon, 12 Apr 2021 08:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DA+3bC7YalkPeYhisMg+v8Yd2kXOD+0wUU57sv4bQ/w=;
        b=UXKQDW09yhfOhljDtEZ7Ujg7ZOEdSdwpyIH6YK4nwp5/m4lGK5OhcX1po8/oQSOODd
         CzLNYpYW9tqjx/V8osInrwv9i5VNfVjihK1aUVyYs7msLcTAHUwhlsgZ2veFckMyZCY7
         xcM1P4ycWkxKNjHQN4h1XiLXQYl5Za48jIrEu1b7vp3VbofNkMRxIilR0QnbMG2k+WBH
         yq/Wl7jUzkWxFo2YjaaMnwTfVNk177yLUSsc50T6pwK7Gt6AUm53MO5nq8KFviH5JQS8
         0JsJJfq2bh1Xyy067tY1IZGpwA61Q8EoSZ0qbCFLqpuDrW5RUvFqoLKsZoHbgy3XiFMt
         /rRQ==
X-Gm-Message-State: AOAM530/nyySOERWVHJ0vOFx5sRMG8CcfdGr4TXHUTnnlU2gpCPZQMW1
        0NOJx7w7XKlAmSesEVUqlA==
X-Google-Smtp-Source: ABdhPJyO25hHcn5aQcCqyPyKsLc+O9vOjBhqhW4NUWFk4x/dfwhaVeCQCI+JW698edtqxuFU3RoQ9A==
X-Received: by 2002:aca:1803:: with SMTP id h3mr19854196oih.65.1618239935589;
        Mon, 12 Apr 2021 08:05:35 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u1sm2799546otj.43.2021.04.12.08.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 08:05:34 -0700 (PDT)
Received: (nullmailer pid 3898415 invoked by uid 1000);
        Mon, 12 Apr 2021 15:05:33 -0000
Date:   Mon, 12 Apr 2021 10:05:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        heiko@sntech.de, thierry.reding@gmail.com, lee.jones@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: add more compatible strings to
 pwm-rockchip.yaml
Message-ID: <20210412150533.GA3898302@robh.at.kernel.org>
References: <20210411131007.21757-1-jbx6244@gmail.com>
 <20210411131007.21757-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411131007.21757-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 11 Apr 2021 15:10:03 +0200, Johan Jonker wrote:
> The compatible strings below are already in use in the Rockchip
> dtsi files, but were somehow never added to a document, so add
> 
> "rockchip,rk3328-pwm"
> 
> "rockchip,rk3036-pwm", "rockchip,rk2928-pwm"
> 
> "rockchip,rk3368-pwm", "rockchip,rk3288-pwm"
> "rockchip,rk3399-pwm", "rockchip,rk3288-pwm"
> 
> "rockchip,px30-pwm", "rockchip,rk3328-pwm"
> "rockchip,rk3308-pwm", "rockchip,rk3328-pwm"
> 
> for pwm nodes to pwm-rockchip.yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changed V2:
>   changed schema for clocks and clock-names
> ---
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

