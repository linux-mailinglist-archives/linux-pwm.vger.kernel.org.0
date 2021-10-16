Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A1643030F
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Oct 2021 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhJPOiY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 16 Oct 2021 10:38:24 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45676 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbhJPOiX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 16 Oct 2021 10:38:23 -0400
Received: by mail-oi1-f170.google.com with SMTP id z126so17532076oiz.12;
        Sat, 16 Oct 2021 07:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pUN/soe8xSqu2oYqVJjty1O05ssnZDWQhxdQWf+Tt2E=;
        b=pfA2GSHD6vtH0et05GGMKETNljOjcONa42sII7Ta5PIqciIOuJO8dN3QrrBvRK4sq6
         aKG+5zg44ePAJkUGt5v79SVRSs/wHUlVWiZqtJA8HwQJ1fm6ZEYh68y9/yQtTFX9JnMr
         d6MZvl8B0kxyoQhd9s2Ev/ziMGT1u9JChTPkWt/OOj1RMbPjt4XitQqw1zd2xXeHD9DF
         sx4wXIvqykcYJy2dmafh6sv4Sc2r5r3iqtWsjYWxgZFSKaCqus/2lRi+FOYO8qrjCE23
         MF+cykGQDKTwwdzU8Sltf+ZZ+tipJSvBNZGA0q1J7GzJextOxtPbsHHKXV7g0E+o0Cn1
         KB9w==
X-Gm-Message-State: AOAM533yTVP44dN8rXMVIHCOSmTp4GKf7iOYE65srVyh68B1oVtUwJ/+
        FIvESJuoVXcz8A5n2vmUYCIaaAIsJg==
X-Google-Smtp-Source: ABdhPJwinL1aGnefiRLjvQIakN5SSu385KEOtMYIcvNVMSg3tHZlJwHzZ9/E1yzoAiD+m/OwbGu++w==
X-Received: by 2002:aca:6082:: with SMTP id u124mr18564654oib.153.1634394975117;
        Sat, 16 Oct 2021 07:36:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d10sm1576926ooj.24.2021.10.16.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 07:36:14 -0700 (PDT)
Received: (nullmailer pid 3906826 invoked by uid 1000);
        Sat, 16 Oct 2021 14:36:13 -0000
Date:   Sat, 16 Oct 2021 09:36:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v10 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <YWrjXSAvJimq1UcZ@robh.at.kernel.org>
References: <20211010043912.136640-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010043912.136640-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 09 Oct 2021 21:39:11 -0700, Bjorn Andersson wrote:
> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v9:
> - "led" child of "multi-led" now needed a patternProperties
> - use generic "led-controller" and "pwm-controller" in example
> 
>  .../bindings/leds/leds-qcom-lpg.yaml          | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
