Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8386399397
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jun 2021 21:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFBThI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Jun 2021 15:37:08 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37537 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFBThH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Jun 2021 15:37:07 -0400
Received: by mail-ot1-f50.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so3496894otp.4;
        Wed, 02 Jun 2021 12:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uELX5W19vdK7VgcXeNAPi2/+xnOFs6GHFEA1rcE0XzE=;
        b=DzlvFftm6esXLAOCrSD2s6LpCMIaiLG4c1Bri3wmTbdIi3RJMMu54A8yneyZn00jM5
         /3mBPAu720nrV4a6kpXViyUNvCYmAPlTM1O0NebWyok9shH/6lvGY786hZN8wA8SP6UV
         dZDAkq5woFw9WdpwSImsVCt9sWmgyW3LHvnQZo9aSVc7gS4SOa9Tzu4w1WzrY6FL0/Hw
         uI1wwE+Fs1yECED/WBX176lb7xutSLsLYOQp68ahbksh3r4Zw/66c1U2pFa6wED5hS0B
         7LHMNfVGRsmDIsjTz6jPF7BudQsUp/BFEc63ZeIegsh0W1LgAHEy7F+08s/rcKPH86Ek
         M+AQ==
X-Gm-Message-State: AOAM532SoONyI5JHn4gAvio1/rZ1EQUQDfwoRlphUHFYfpml8vYMmcpR
        7A8cCWvvtXQ5YqfRqCtgiA==
X-Google-Smtp-Source: ABdhPJwJX6Gj3B+2OzSEv2IpU3/yiuUkwpDjfxx9RHc6frueeMkWWj/KJ6U61HlAsdHZxzB0xOtKxg==
X-Received: by 2002:a9d:6d93:: with SMTP id x19mr26261946otp.117.1622662524090;
        Wed, 02 Jun 2021 12:35:24 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g21sm175567otn.67.2021.06.02.12.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:35:23 -0700 (PDT)
Received: (nullmailer pid 3844879 invoked by uid 1000);
        Wed, 02 Jun 2021 19:35:22 -0000
Date:   Wed, 2 Jun 2021 14:35:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     u.kleine-koenig@pengutronix.de,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        thierry.reding@gmail.com,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>,
        tony@atomide.com
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: pwm-tiehrpwm: Convert to json
 schema
Message-ID: <20210602193522.GA3844813@robh.at.kernel.org>
References: <20210601054402.2223-1-lokeshvutla@ti.com>
 <20210601054402.2223-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601054402.2223-2-lokeshvutla@ti.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 01 Jun 2021 11:14:01 +0530, Lokesh Vutla wrote:
> Convert the tiehrpwm binding to DT schema format using json-schema.
> Along with this conversion the following changes are included:
> - 'clock' and 'clock-names' properties are marked as required as
>    driver fails to probe without these properties
> - Dropped ti,am33xx-ehrpwm as it is no longer applicable.
> - 'power-domains' property is introduced and marked as optional.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt  | 50 ---------------
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.yaml | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
