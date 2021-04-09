Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0835A54D
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhDISJv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 14:09:51 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:33328 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISJv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 14:09:51 -0400
Received: by mail-oo1-f42.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so1548097ool.0;
        Fri, 09 Apr 2021 11:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LVU+FsLg96bFDUDU6A9aFOp+y4DojD87pf/U1wdf1yQ=;
        b=JBvg/V5TVFCTTj+eLs55oxyp3QA2giOeTKcBT1ksq/W64QSOyYlRlai/sAJI7VffRh
         SikVVP4gA7MYF1MnB7xQ1F/2HwyXBTsc1Niyl8rsWZWbGXqp5yCgBJGhlpIxZx7kQGN1
         piF7+jBvPvWq/lm1lCk5nYqEONDbOIjnvY+PXUpDTv6l3GGO+w6cqHuSsoSurZMSblqq
         lHeGRtdv9tq5B2+B+oItqSNEPzeH34fZlCJ3G5vzLlsX54SHCqbuu380tOcH4mvVmb98
         qBAcHWw2W+48ClM+8nMof0s+pApjxCpZ8n3xvMP20wE9h0+2xg0rZ92a7AMjcAPQC+zn
         F8eg==
X-Gm-Message-State: AOAM532XGl1HjlhZU0L42E6cOUHm3toSfCbk6WoTJJiZDSqkshZ9HLC1
        Z7nTDhp6WkaUkUBmXMQlDw==
X-Google-Smtp-Source: ABdhPJyL7uQP3fZ6rTaXBePGYdufLxlMHG1qIzUu+Yb1eFiH7dGCjpSv6zGCyXO+9GlTpBbewdlIbw==
X-Received: by 2002:a4a:4005:: with SMTP id n5mr12920298ooa.61.1617991777612;
        Fri, 09 Apr 2021 11:09:37 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l15sm290618otp.4.2021.04.09.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:09:37 -0700 (PDT)
Received: (nullmailer pid 3894955 invoked by uid 1000);
        Fri, 09 Apr 2021 18:09:35 -0000
Date:   Fri, 9 Apr 2021 13:09:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 2/2] dt-bindings: pwm: add more compatible strings to
 pwm-rockchip.yaml
Message-ID: <20210409180935.GA3894908@robh.at.kernel.org>
References: <20210406155053.29101-1-jbx6244@gmail.com>
 <20210406155053.29101-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406155053.29101-2-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 06 Apr 2021 17:50:53 +0200, Johan Jonker wrote:
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
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
