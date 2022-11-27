Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99194639C45
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Nov 2022 19:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiK0SWg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 27 Nov 2022 13:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK0SWf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 27 Nov 2022 13:22:35 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5D5D6C;
        Sun, 27 Nov 2022 10:22:33 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id e189so6219449iof.1;
        Sun, 27 Nov 2022 10:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vukWGyYF9LYnWEtUXZi++E5sJfGRcnavjJ89dxRwcfA=;
        b=NX9rsp6+QjC1mPtLbdgo8pFJ1CiwpUJabVGx9r4r5SBk4YxtS3JdKGx7BbBMduDVUE
         NnyDbDR3aVLuAvUhCCRUwtPHzdSsGqSx8hkShKLeU+NDYP15nIt06hH1YDr3rOVpOV61
         +eC0DldiZZ65BI8NPFSQdJDunX8hPsESCF2KJDvaSG6zCTWl8S0z68xLyCpmsjhjuwng
         NkdIGlYm/4+DvzgeHH6GLY/2v5lkxfMGPmGfu0eEJpqMqzPkfmKOnoe8CB8QLjfnh+00
         5Bg5+jkujIvBNXO8NJ5vNuyHoYCG9pcNcHvGulPpsgDooyLudPD0Wf/OtMhXVbxc5Yp7
         m05Q==
X-Gm-Message-State: ANoB5plYTMf+BcgcAVCavTH+Mc37bpOiojQbMngxBSYtf/imLqeg1eab
        Sp2QDU6css+jQmKwcL8rXw==
X-Google-Smtp-Source: AA0mqf52id4ogOIrUkQbo6wDm6Jj1UbJySa/csflYIxoWGpZdD7lafsWa0xqORF+oFNfTceNY8Asbg==
X-Received: by 2002:a02:9547:0:b0:375:3dd1:743c with SMTP id y65-20020a029547000000b003753dd1743cmr14810797jah.281.1669573353061;
        Sun, 27 Nov 2022 10:22:33 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80c1:3b80:81db:640f:ef27:c9e2])
        by smtp.gmail.com with ESMTPSA id u13-20020a056638304d00b00372bbd04b75sm3611473jak.87.2022.11.27.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 10:22:32 -0800 (PST)
Received: (nullmailer pid 144847 invoked by uid 1000);
        Sun, 27 Nov 2022 18:22:32 -0000
Date:   Sun, 27 Nov 2022 12:22:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Allow decimal format in
 addition to hex format
Message-ID: <20221127182232.GA128974-robh@kernel.org>
References: <20221122123225.59106-1-tony@atomide.com>
 <20221123024153.GB1026269-robh@kernel.org>
 <Y33ErrigR4II6EYH@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y33ErrigR4II6EYH@atomide.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 23, 2022 at 08:58:54AM +0200, Tony Lindgren wrote:
> * Rob Herring <robh@kernel.org> [221123 02:31]:
> > On Tue, Nov 22, 2022 at 02:32:24PM +0200, Tony Lindgren wrote:
> > > Let's allow node numbering in decimal format too.
> > > 
> > > Simple human-readable increments/IDs are usually decimal, hex is only for
> > > addresses as noted by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>.
> > > 
> > > Let's use an improved match suggested by Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> and improved a bit by Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de>.
> > > 
> > > Cc: linux-pwm@vger.kernel.org
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > > 
> > > Changes since v2:
> > > 
> > > - Use pattern suggested by Krzysztof and Uwe
> > > 
> > > Changes since v1:
> > > 
> > > - New patch added to deal with pwm-omap-dmtimer binding
> > > 
> > > ---
> > >  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
> > > --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> > > @@ -13,7 +13,7 @@ select: false
> > >  
> > >  properties:
> > >    $nodename:
> > > -    pattern: "^pwm(@.*|-[0-9a-f])*$"
> > > +    pattern: "^pwm(@.+|-[0-9a-f]+)?$"
> > 
> > So now pwm-10 could be either?
> 
> Yes.
> 
> > I'm fine with decimal, but can we do that everywhere we do this -N 
> > naming?
> 
> Do you mean the '[0-9a-f]' users that don't use '[0-9af]+'?

No, I mean for all cases of <nodename>-N, can be we consistent. Either 
we use hex or we use decimal.
 
> 
> These can be found with:
> 
> $ find Documentation/devicetree/bindings/ -name \*.yaml | \
> 	xargs grep pattern: | grep '\[0-9a-f\]' | grep -v '\[0-9a-f\]+'

Not quite. It's just cases of '-N':

$ find Documentation/devicetree/bindings/ -name \*.yaml |         xargs grep pattern: | grep '\-\[0-9a-f\]' | grep -v '\[0-9a-f\]+'
Documentation/devicetree/bindings/phy/intel,combo-phy.yaml:    pattern: "combophy(@.*|-[0-9a-f])*$"
Documentation/devicetree/bindings/pwm/pwm.yaml:    pattern: "^pwm(@.*|-[0-9a-f])*$"
Documentation/devicetree/bindings/timestamp/hardware-timestamps-common.yaml:    pattern: "^timestamp(@.*|-[0-9a-f])?$"
Documentation/devicetree/bindings/watchdog/watchdog.yaml:    pattern: "^watchdog(@.*|-[0-9a-f])?$"
Documentation/devicetree/bindings/spi/spi-controller.yaml:    pattern: "^spi(@.*|-[0-9a-f])*$"
Documentation/devicetree/bindings/rtc/rtc.yaml:    pattern: "^rtc(@.*|-[0-9a-f])*$"


And there's probably some more in dtschema.

> 
> Not sure if some of these need to intentionally limit the node numbering
> to 15.

No, I think it was all just cases of 15 should be enough for anyone.

> 
> If you have some other criteria in mind, let me know :)

If the numbering is hex, then it is as you have it. (Though we can't 
enforce that.

If it is decimal, then the regex should be ([0-9]|[1-9][0-9]+). 

Rob
