Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13D64F81F1
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Apr 2022 16:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiDGOll (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 7 Apr 2022 10:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiDGOll (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Apr 2022 10:41:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF5A1B215E
        for <linux-pwm@vger.kernel.org>; Thu,  7 Apr 2022 07:39:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v20-20020a05600c15d400b0038e9a88aee7so650068wmf.3
        for <linux-pwm@vger.kernel.org>; Thu, 07 Apr 2022 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+HrqUl2stcAnQOvkV/cLC8sh1bdsuE9uaYRM3SC8TAI=;
        b=QC/NBWbz8s242GqiqGVCxZjqkf65n2BOMSMdySwx5OMCnmpmfgmy2Gl0mqkViPk58A
         B0hFl228YREAAGFp1bTWTBF48v9/vcamAwhlivD7F9RoAWhkxTVUUszkElVwniFp+KSW
         153YOYtKLxloRx116E1JbzBPjjKXbUaIisB8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+HrqUl2stcAnQOvkV/cLC8sh1bdsuE9uaYRM3SC8TAI=;
        b=zMO8FotXhgZj+8jiWDzlPr2qJreYFBl1FABo1NvV+MuzlJWJ/6kpCvBfeuCzN45/f4
         uxtfyFlzYxrc1oVMnRV3JV6yBF5MrSjBPHlogSEbpI4YN1Tdt9+8ULT8c7kVFZ7UdYD9
         uZfcxDNNUVBiZqB6A5R5YrR1VS22dzvvk4PXtZKQ1DjLO1I5VjYQfOiv72WTCCGc0B1P
         ij4/abf+9xnhd3s3N5TFZstVH6roHMvRnpV5zAhb8g6EtEU22cmOvA2ebmHIl6e8/RtH
         8txXg4xRMjxyBMer0gkepA9hJi41Z6BCBWZzO6BCuT+zAn9zfppQZZ4pTndUuyICx+NB
         EFcA==
X-Gm-Message-State: AOAM531NwAumm66ZXt6m0ROWNTrEZ+DntGzRIJPDN7asuVAfs/YxyeOJ
        37qM4yXAgLhSYVMnoBz8Q6NqKg==
X-Google-Smtp-Source: ABdhPJxSm1o4AJPWmwSiOwXUcoOrfrDDoE6QavOVO+5QTW+urJsTAfmBJCV6RwoUxCRXXNUmmjXF1A==
X-Received: by 2002:a1c:f605:0:b0:37b:b5de:89a0 with SMTP id w5-20020a1cf605000000b0037bb5de89a0mr12345916wmc.88.1649342337820;
        Thu, 07 Apr 2022 07:38:57 -0700 (PDT)
Received: from google.com ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0038e4c5967besm7983010wmb.3.2022.04.07.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:38:57 -0700 (PDT)
Date:   Thu, 7 Apr 2022 14:38:55 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: update google,cros-ec-pwm
 documentation
Message-ID: <Yk73f9yyxy5LBC+V@google.com>
References: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
 <20220331125818.3776912-4-fabiobaltieri@chromium.org>
 <Yk20uTE/Vdm2c6jI@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk20uTE/Vdm2c6jI@robh.at.kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

On Wed, Apr 06, 2022 at 10:41:45AM -0500, Rob Herring wrote:
> On Thu, Mar 31, 2022 at 12:58:17PM +0000, Fabio Baltieri wrote:
> > Update google,cros-ec-pwm node documentation to mention the
> > google,use_pwm_type property.
> > 
> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > ---
> >  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml         | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > index 4cfbffd8414a..9c895c990ed8 100644
> > --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > @@ -19,6 +19,12 @@ description: |
> >  properties:
> >    compatible:
> >      const: google,cros-ec-pwm
> > +
> > +  google,use-pwm-type:
> > +    description:
> > +      Use PWM types (CROS_EC_PWM_DT_<...>) instead of generic channels.
> > +    type: boolean
> 
> Either do a new compatible string if the cell interpretation is mutually 
> exclusive (channel number vs. type) or split the number space for the 
> 1st cell between type and channel number. IOW, set a bit (31?) to 
> signify the number is a type, not a channel.

Split the number space was my first (tentative) implementation as well,
but it turns out that the PWM subsystem really wants channels to be
zero-based[1], so I don't think flags or bitmasks are really an option.

New compatible sounds good though, I'll rework a v3 with that change.

Thanks!
Fabio

[1] https://elixir.bootlin.com/linux/v5.17/source/drivers/pwm/core.c#L423

-- 
Fabio Baltieri
