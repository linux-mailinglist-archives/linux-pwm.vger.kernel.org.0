Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED84E3E5B
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Mar 2022 13:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiCVMVE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Mar 2022 08:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbiCVMVD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Mar 2022 08:21:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665812E693
        for <linux-pwm@vger.kernel.org>; Tue, 22 Mar 2022 05:19:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id i186so1314004wma.3
        for <linux-pwm@vger.kernel.org>; Tue, 22 Mar 2022 05:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ykocWOAz0Uq+UDyAgiBZ8KQwD5sPDMIaIusCx46+2Ks=;
        b=kKY+qozz/qcYG+/WjZpLBwTWsZ5tYB8zXlI70JV8xHO0EZdrLRb7kZRqQpLv1AKLeE
         V+ah86LXYoSNB33ep5SGvLR9hA81Yxkx4CMt8bv6tX4ZZaLpnDpmKrWXjhG9uQiAalg6
         S80CRpCoCzGXB/IyUuz30WFr39JPiBlgTtiJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ykocWOAz0Uq+UDyAgiBZ8KQwD5sPDMIaIusCx46+2Ks=;
        b=CEPqHIoPwFofoxOoDqEshcizxZC7qN13qTOWIjXwXAg9zw12UJNI2tPPimWRoCNke/
         VL9iLURDlqg4SdvJnLDs8gS7QYrpQBXePd0MCAmrF8YsezNrYf4uuszTeBhmzUbFnvqC
         o/bRE58xW9MwimEJCAxW9n3ygfUpcDaQ1TcsavEPuNzffWFIUdLYUzAlZsSNQ+4SLse7
         kYcltTDsgqfLl4JR2g3TmJCD0X2bIQNv1hwhSQZsKltA+a8aIjdBrxlQxYhRAMYndKvO
         SQxvRXd2arCxP/jzR2sXpFKPXRhiOyS0oCC27bSzBus2ZW0r/a1MmUVwgEFgoSCsfMp0
         iZ5A==
X-Gm-Message-State: AOAM533qeg2y7zW/eqMN/35cFGqaE8pUs3q3LOjt0OuGDIglW8KTf0WU
        8qFBLa3uEAT6G1KTL1kCEdaS0w==
X-Google-Smtp-Source: ABdhPJyFLwDH5nAIAcJ9p0nfgQAFOIKhSm1IVpSDXY9TL57Dd6kWriAXvFvzHaFUdFaXQn45mmhONA==
X-Received: by 2002:a1c:e908:0:b0:38c:782c:2a62 with SMTP id q8-20020a1ce908000000b0038c782c2a62mr3433024wmc.135.1647951574957;
        Tue, 22 Mar 2022 05:19:34 -0700 (PDT)
Received: from google.com ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id l13-20020adfbd8d000000b002040daf5dffsm9233464wrh.18.2022.03.22.05.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:19:34 -0700 (PDT)
Date:   Tue, 22 Mar 2022 12:19:32 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: update google,cros-ec-pwm documentation
Message-ID: <Yjm+1ON8o5y/qcKG@google.com>
References: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
 <20220321143222.2523373-4-fabiobaltieri@chromium.org>
 <09b4b714-4fb5-f2af-5a88-b48cbff35b7d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b4b714-4fb5-f2af-5a88-b48cbff35b7d@kernel.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 21, 2022 at 04:47:54PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2022 15:32, Fabio Baltieri wrote:
> > Update google,cros-ec-pwm node documentation to mention the
> > google,use_pwm_type property.
> > 
> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > ---
> >  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > index 4cfbffd8414a..2224e8e07029 100644
> > --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > @@ -19,6 +19,12 @@ description: |
> >  properties:
> >    compatible:
> >      const: google,cros-ec-pwm
> > +
> > +  google,use_pwm_type:
> 
> Hyphens, not underscores.

Oh thanks, will change for v2.

> 
> 
> Best regards,
> Krzysztof

-- 
Fabio Baltieri
