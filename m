Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C4935E031
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhDMNhu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 09:37:50 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:46909 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhDMNht (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 09:37:49 -0400
Received: by mail-oi1-f171.google.com with SMTP id m13so16973023oiw.13;
        Tue, 13 Apr 2021 06:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xn+qkSOy3KWxo2N+mRffQC+USY48yDM1PS9olUJC/UU=;
        b=KsWTb0YyYiUAFaQSSeObFRyPmIkeXV4rBaI7m8hTJhX1eLl+JkyJ3bjsErFZmtzLQ0
         CH1wn/o0sQwi/JfuQuL1Sb7fmroEk1cd+Nf94dKsFmFy7Nv3b72tSVw6o0BN/w0seeln
         HQPugWY/f/IueQccCIIgp9GtthNDHdkPIkG2BMrGksD9FWhkwgxAk9dN5aSUQocVcx/V
         N5NJDv/SwxILCqiDRpla2w7CEifTtW+8kdPJplyvTRrXDH8VgyihVE2hx2cat0OEqRSy
         sfcHaiE1ryaeqZ6EbhGetJEzkvVEeA4lkU0qCmbu9ZQPce8jDuyEbIhl0ea7i2VZb0Gx
         NKQQ==
X-Gm-Message-State: AOAM531Jsv1xaLsXJBWFfPtFaOOChZF4Rv1hHqsbLY/0QNgz1rWB4aIn
        GPrfOq3LM01jw222iz39NQ==
X-Google-Smtp-Source: ABdhPJw0hyiYZe3k60GOvhnPdj8SpMVm2NrmkXHH8u9CXJ6mTgQ6LCCmoj3obd9wm15J9X4nBnBsUQ==
X-Received: by 2002:aca:3303:: with SMTP id z3mr52906oiz.140.1618321048567;
        Tue, 13 Apr 2021 06:37:28 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x2sm3486274ote.47.2021.04.13.06.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:37:27 -0700 (PDT)
Received: (nullmailer pid 1535101 invoked by uid 1000);
        Tue, 13 Apr 2021 13:37:26 -0000
Date:   Tue, 13 Apr 2021 08:37:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
Message-ID: <20210413133726.GA1534983@robh.at.kernel.org>
References: <20210412200155.5316-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412200155.5316-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 12 Apr 2021 22:01:52 +0200, Johan Jonker wrote:
> Current dts files with 'pwm' nodes are manually verified.
> In order to automate this process pwm-rockchip.txt
> has to be converted to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
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
>  .../devicetree/bindings/pwm/pwm-rockchip.txt       | 27 -------
>  .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 88 ++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
