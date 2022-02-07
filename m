Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F9B4ACB7C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Feb 2022 22:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbiBGVn0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Feb 2022 16:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiBGVn0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Feb 2022 16:43:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC3C06109E;
        Mon,  7 Feb 2022 13:43:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57083615B7;
        Mon,  7 Feb 2022 21:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E81C340F3;
        Mon,  7 Feb 2022 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644270204;
        bh=yyFH/BpoYHmQ85gjKtjby1VQY1sqjcuc6iOstBz9Jx4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kwb1L9xrSn5kL2hY9sY7qNakeNjhY9Ksx1I36Olfj0OEPOPiea9JlNiO0iOnSJog/
         xatZeUzZ4pPfXErzmecsszDgiw5zueee7UiTJTIftvZ9azx6ECvfzF+NBfYY5U3Mck
         EnMhF/cIb/ICwH8/n/uEq83WMbZWZr8yovoz1pkVSpEJnISkGiO6PM8QlIn0TPC6tI
         eXU4ob463XtxT+ddLme6Ve714JrwWFKaP7/O5iCCMKBnWNM4xcVIdlGrXNcrhO4OOR
         wcmPMRruX2wFNzwncP5oxsNWxVom77KG1S2yoxLK8AcWx9P6Ne1otWK0nK+cSl1Am9
         x/5w6vIIkPK4Q==
Received: by mail-ej1-f44.google.com with SMTP id p24so8396589ejo.1;
        Mon, 07 Feb 2022 13:43:24 -0800 (PST)
X-Gm-Message-State: AOAM531sAnhi4tcHHzbeYfrcaP5wj0OYd1tLyc371Ji6x5UzP/R2ZFPI
        BGL6z6yq8edb/iIFO8xIgfPWLBscmp2kRLqbFA==
X-Google-Smtp-Source: ABdhPJwcTPTS5lN9kjeNU1UmmKYcelai/6b2Bz1+DUYaA+p4ouzWvIVpvotfk1mDa/IkiXJ42SEJ9tHfZEUWLQ0itJU=
X-Received: by 2002:a17:906:c14e:: with SMTP id dp14mr1298826ejc.325.1644270203029;
 Mon, 07 Feb 2022 13:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20220207100326.426940-1-sven@svenschwermer.de>
 <20220207100326.426940-2-sven@svenschwermer.de> <YgF/TfKCxXJNdypY@robh.at.kernel.org>
 <1e4e8efe-1fdf-ca9c-7c5a-9903ef4a7fce@svenschwermer.de>
In-Reply-To: <1e4e8efe-1fdf-ca9c-7c5a-9903ef4a7fce@svenschwermer.de>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 7 Feb 2022 15:43:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLTnwnAT2S0f+0ckz+s8-cEUbwXFiytd4w83y-yn0C-+w@mail.gmail.com>
Message-ID: <CAL_JsqLTnwnAT2S0f+0ckz+s8-cEUbwXFiytd4w83y-yn0C-+w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: Add multicolor PWM LED bindings
To:     Sven Schwermer <sven@svenschwermer.de>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Alexander Dahl <post@lespocky.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Feb 7, 2022 at 2:44 PM Sven Schwermer <sven@svenschwermer.de> wrote:
>
> Hi Rob,
>
> Thanks for your comments.
>
> On 2/7/22 21:21, Rob Herring wrote:
> >> +properties:
> >> +  compatible:
> >> +    const: pwm-leds-multicolor
> >> +
> >> +  multi-led:
> >> +    type: object
> >> +    allOf:
> >> +      - $ref: leds-class-multicolor.yaml#
> >
> > This schema says 'multi-led' here should have a child called
> > "^multi-led@([0-9a-f])$". You are off a level.
>
> So it should have been?
>
> properties:
>    compatible:
>      const: pwm-leds-multicolor
>    allOf:
>      - $ref: leds-class-multicolor.yaml#

Not quite. DT property names and json-schema vocab names should never
be at the same level. So allOf should be at the root level.

> This would imply that the multi-led node requires a unit address (reg
> property). That doesn't make sense in this case. How should we resolve this?

I meant to mention that. Update the regex pattern to allow just
'multi-led': "^multi-led(@[0-9a-f])?$"


> >> +    patternProperties:
> >> +      "^led-[0-9a-z]+$":
> >> +        type: object
> >
> >             $ref: common.yaml#
> >             additionalProperties: false
>
> Sounds good.
>
> >> +        properties:
> >> +          pwms:
> >> +            maxItems: 1
> >> +
> >> +          pwm-names: true
> >> +
> >> +          color:
> >> +            $ref: common.yaml#/properties/color
> >
> > And then drop this ref.
>
> Curiosity question: why? Should I refer to an unsigned integer type instead?

Generally we want schemas to apply to nodes rather than individual
properties. Think of each node as a class and nodes can be 1 or more
subclasses. It's more important when using 'unevaluatedProperties' in
combination with refs.

'color: true' is all you need here. So it's less duplication. Not so
much here since it is just 1 property, but in general.

>
> >> +    rgb-led {
> >> +        compatible = "pwm-leds-multicolor";
> >> +
> >> +        multi-led {
> >
> > Can't this be collapsed into 1 level? I don't see "pwm-leds-multicolor"
> > having other child nodes.
>
> It could. The reason I added the multi-led level is because the
> leds-class-multicolor.yaml schema calls for it. Perhaps I missed the
> intention of that schema but isn't it there to create a uniform binding
> schema structure across drivers?

Yeah, I guess that's a good enough reason.

Rob
