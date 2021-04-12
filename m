Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B388935D244
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbhDLU6P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 16:58:15 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35680 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbhDLU6P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 16:58:15 -0400
Received: by mail-oi1-f176.google.com with SMTP id x2so14836926oiv.2;
        Mon, 12 Apr 2021 13:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2sVPmXqqYHpMPr6v1hWYxCdWgD57bKqmVBWwEqZ02Hw=;
        b=fFgzwN/k24zWYDrqx7/y7CYJ+N4C7syAFbNLIvldKAKUMems/uGE46BKTB9/mtAvWe
         0/n3z6bJ4tZSWMOEtlybFSt5v9Kmj3WLpfbsPktdQmd8bHUcMtZ/Mea7CrQVRMEGxQJD
         g48MqyeBwR3icLWMoBqeCXwVQoxSxJbkbW98i5tumDWWl6i8PvjNiTQx2s5QbtsfkMhh
         yfu135aUbtUmLIhv2uZ7rMh8aWCjtC1DpvJ4rU2x5vNElR5yphjt1jsUd2tNt1LZzln8
         DAvzR/PY/0Jp36iJ2qKatcl+yYRLh0m2oW4h9Abm4mqp0babKQ+OWI2OydFJ3DwRjLu6
         TgHA==
X-Gm-Message-State: AOAM533MCwdYLJBC0HikdG2pZfQ6V7lmqHBdP5DkwilVQ0+AN0Igxw1x
        GPam+oJ0c1tCms4J6wq1BA==
X-Google-Smtp-Source: ABdhPJz9YxXzZV7HBQ97lVOF27AThJosqKvHcLSt7zlTOgwB7qi4nL7B6fFkh+3veL3dckMnu0CrxQ==
X-Received: by 2002:aca:5945:: with SMTP id n66mr783932oib.11.1618261075427;
        Mon, 12 Apr 2021 13:57:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j142sm2059215oih.33.2021.04.12.13.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 13:57:54 -0700 (PDT)
Received: (nullmailer pid 158351 invoked by uid 1000);
        Mon, 12 Apr 2021 20:57:53 -0000
Date:   Mon, 12 Apr 2021 15:57:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lee.jones@linaro.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, heiko@sntech.de
Subject: Re: [PATCH v2 1/6] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
Message-ID: <20210412205753.GA158321@robh.at.kernel.org>
References: <20210411131007.21757-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411131007.21757-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 11 Apr 2021 15:10:02 +0200, Johan Jonker wrote:
> Current dts files with 'pwm' nodes are manually verified.
> In order to automate this process pwm-rockchip.txt
> has to be converted to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changed V2:
>   changed schema for clocks and clock-names
> ---
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       | 27 -------
>  .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 91 ++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
