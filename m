Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2BB3F79EB
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Aug 2021 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhHYQNf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Aug 2021 12:13:35 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35736 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhHYQNf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Aug 2021 12:13:35 -0400
Received: by mail-oi1-f176.google.com with SMTP id r26so378969oij.2;
        Wed, 25 Aug 2021 09:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YEmE8S1S2FpZxoj7vCBgXPaRtZHDLRa7c7YhuXp2BMg=;
        b=VD9ZAjeSl5rEsMfMBBaXG9PXluFY5KhRFawNmJIRLehODx7MQTxhonXLm0iIsh8EPx
         VYo3NFgkBgDrJxNfGMptUHQJJUQuJPcU2NpFlfRsMxfg+ny1bEWBskTT9x8ETDDDDh9p
         9OYA+VH1LSOilTOhIwERoYpNLiuihNHE3E2DrVPcGtvj6bVkck+/n+LLrdFezeVZSvD+
         raqJOCH6PUiy7jrS0jk2CLg8t4lotzj2Llf0/xhy6pqxL+CrqwEWYVweBTww0C1aawRp
         XRWi99pdsjXJOo9n8EWXLdRM1Z5mm7/xvpVYTfBqhYQu3vwbxb7J7Nbhb1CUpjB/i7aW
         fGWA==
X-Gm-Message-State: AOAM531n18EOPGTHDjuLqGra31L4wK319cABmHz2e0or+ewFrop1Z1j9
        7exrAe+UESkZglVXsEiIGg==
X-Google-Smtp-Source: ABdhPJzTqMi3HwCG0dj4SVKilrtaWKGA/e40IYlN+I/U8GNGR8FuVoGBTIztwKLNxwszoVD8AkfH3w==
X-Received: by 2002:a05:6808:1494:: with SMTP id e20mr7371883oiw.111.1629907969073;
        Wed, 25 Aug 2021 09:12:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b24sm53305oic.33.2021.08.25.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:12:48 -0700 (PDT)
Received: (nullmailer pid 2880915 invoked by uid 1000);
        Wed, 25 Aug 2021 16:12:47 -0000
Date:   Wed, 25 Aug 2021 11:12:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-pwm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Kathiravan T <kathirav@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 3/4] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <YSZr/xo2a60PYTuW@robh.at.kernel.org>
References: <3b70f9e757e018d3cd91a882282040c4c0589a93.1629884907.git.baruch@tkos.co.il>
 <dbf064fb60b1654af25f65d89f75bd397162d701.1629884907.git.baruch@tkos.co.il>
 <1629900658.219829.2719822.nullmailer@robh.at.kernel.org>
 <87ilzta5xn.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ilzta5xn.fsf@tarshish>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Aug 25, 2021 at 05:59:45PM +0300, Baruch Siach wrote:
> Hi Rob,
> 
> On Wed, Aug 25 2021, Rob Herring wrote:
> 
> > On Wed, 25 Aug 2021 12:48:26 +0300, Baruch Siach wrote:
> >> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> >> 
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> ---
> >> v7:
> >> 
> >>   Use 'reg' instead of 'offset' (Rob)
> >> 
> >>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
> >> 
> >>   Use single cell address/size in example node (Bjorn)
> >> 
> >>   Move '#pwm-cells' lower in example node (Bjorn)
> >> 
> >>   List 'reg' as required
> >> 
> >> v6:
> >> 
> >>   Device node is child of TCSR; remove phandle (Rob Herring)
> >> 
> >>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
> >> 
> >> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
> >>     Andersson, Kathiravan T)
> >> 
> >> v4: Update the binding example node as well (Rob Herring's bot)
> >> 
> >> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> >> 
> >> v2: Make #pwm-cells const (Rob Herring)
> >> ---
> >>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 52 +++++++++++++++++++
> >>  1 file changed, 52 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/pwm/ipq-pwm.example.dt.yaml:0:0:
> > /example-0/syscon@1937000: failed to match any schema with compatible:
> > ['qcom,tcsr-ipq6018', 'syscon', 'simple-mfd']
> 
> What can I do about that? Is it because qcom,tcsr-ipq6018 is documented
> in a non-yaml plain .txt file?

No, it is not documented at all.

Rob
