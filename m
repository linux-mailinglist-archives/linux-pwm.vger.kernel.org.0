Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCDC35E035
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 15:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245530AbhDMNiR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 09:38:17 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:39845 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhDMNiQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 09:38:16 -0400
Received: by mail-oi1-f181.google.com with SMTP id i81so17000615oif.6;
        Tue, 13 Apr 2021 06:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NCfulLhASkF88YSVbFbXw+77PePkNkMy3z6Ere15nDg=;
        b=pR/ti4CYq1hhxY2EUN4MHtvuxKb650DJzGVc3Rhz2zfqTFepEESP2RiQTnIXy2+c2r
         en64FLADPL/j7VH8S9ebOUEa7gEym9v4elXWotCDtqCRpJQQkdE8h4z0nkd6q24N6gs8
         i+aowSv+X0xCPOnz6MskUvay1c5jfvmaMpjFntoOgw0Nf7zXdepGFtN+E8ZJyOjlVCN/
         Y512aTYcjSSqn4/O2bHg1MTNrb7fNsEJYtxEFvGRDpCobblfjF5HejE3cFoiMOWUnMCP
         db13Q4GxEXNjPBc2q0Bw27MKSTHIGBcjfu4GXvbuyI42ERqvzt+UfkNaM9PwrXZSFXL1
         j3GQ==
X-Gm-Message-State: AOAM532fGLFtQ5wu90TXBZ6NSReeKXsX2cRjy/zUhT2a8OuT4JmZ9KEf
        /qA6YBBO7+o4vt0BOJ3nvA==
X-Google-Smtp-Source: ABdhPJwoB6nerGCsqk2RnCpz9BLfhmFDaJqLZVqu6kmHEQeNF7ERD7F6xRZMQgH/qyHta5MM8irjlg==
X-Received: by 2002:a05:6808:98b:: with SMTP id a11mr68964oic.14.1618321076612;
        Tue, 13 Apr 2021 06:37:56 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g11sm3412058ots.34.2021.04.13.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:37:55 -0700 (PDT)
Received: (nullmailer pid 1535864 invoked by uid 1000);
        Tue, 13 Apr 2021 13:37:53 -0000
Date:   Tue, 13 Apr 2021 08:37:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-pwm@vger.kernel.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        heiko@sntech.de, lee.jones@linaro.org
Subject: Re: [PATCH v3 2/4] dt-bindings: pwm: add more compatible strings to
 pwm-rockchip.yaml
Message-ID: <20210413133753.GA1535744@robh.at.kernel.org>
References: <20210412200155.5316-1-jbx6244@gmail.com>
 <20210412200155.5316-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412200155.5316-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 12 Apr 2021 22:01:53 +0200, Johan Jonker wrote:
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
> Note for rob+dt:
> A tag was not added on purpose, because by the change of schema
> for clocks and clock-names I add "rockchip,rk3328-pwm" to
> the "if:", so strictly speaking V1 and (V2) V3 will not be the same.
> Please have a look at it again.
> 
> For some SoC nodes this patch serie generates notifications
> for undocumented "interrupts" properties shared between
> PWM channels till there is consensus of what to do with it or
> someone makes a solution for the whole PWM block.
> 
> Changed V3:
>   fix mistake with compatibles introduced in V2
> Changed V2:
>   changed schema for clocks and clock-names
> ---
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
