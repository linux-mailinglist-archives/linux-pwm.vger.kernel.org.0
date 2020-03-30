Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE991985EE
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 23:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgC3VAt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 17:00:49 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38405 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgC3VAs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 17:00:48 -0400
Received: by mail-il1-f194.google.com with SMTP id n13so9987666ilm.5;
        Mon, 30 Mar 2020 14:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s3VoV0iGSHssFfSmkEpV8NmrUdnQxQrDZOaiOqnYY+E=;
        b=mep/XfHByB+Y6jW1Z+xjtRdYI1CD4BG/DNyf8WLGagFWfEM1ocxqrApfNBfy12Rb2G
         lQFD6C7SngTOmEK8YnrO8wQiVJMni9UJDjqQHFaQItVU7jKJT7meSF3+uSDTAzNE+5f+
         drnY+8Uy+561ejK8/+VPY85eTE9+bbxQ/xxv6h7X6NKHl7sdCTC3Oe39PSKLsc/LtDa3
         BFkGiQhf6k4dnOH6gwqxEDWScMNTZjZZC9oOTP22p5Z1slzb7hY1TsGNxLnSw2GE4EBZ
         TBGZUMLnGzzAfrcAqxFv2Dy84yTT7a8dK753bwroPi12Soc9L3vemeYg+RWfBEn1Ejvn
         kh8Q==
X-Gm-Message-State: ANhLgQ0/ivnhkKbsqjA/1N1XZB+j/l75CD2Ur559RJJtHxouRiQNi3i7
        V8MVuvqaqemA3K2loob5GQ==
X-Google-Smtp-Source: ADFU+vud/zP759a532s/gH7ulc5KJRaFL2fNP6x7E9IgKnJT/rwzUJQ9IGoEJ2O+coYrgUJGQjGZ+w==
X-Received: by 2002:a92:8fcd:: with SMTP id r74mr13968641ilk.39.1585602047313;
        Mon, 30 Mar 2020 14:00:47 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z15sm5262450ilf.0.2020.03.30.14.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 14:00:46 -0700 (PDT)
Received: (nullmailer pid 510 invoked by uid 1000);
        Mon, 30 Mar 2020 21:00:44 -0000
Date:   Mon, 30 Mar 2020 15:00:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] dt-bindings: pwm: document the PWM polarity flag
Message-ID: <20200330210044.GA16928@bogus>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-3-oleksandr.suvorov@toradex.com>
 <20200317174344.GB1464607@ulmo>
 <20200317213056.futfiwn4qgr2njye@pengutronix.de>
 <20200318230539.GB2874972@ulmo>
 <20200319070510.gc6hr53gn7n2osvb@pengutronix.de>
 <20200319170455.GC3354541@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319170455.GC3354541@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Mar 19, 2020 at 06:04:55PM +0100, Thierry Reding wrote:
> On Thu, Mar 19, 2020 at 08:05:10AM +0100, Uwe Kleine-König wrote:
> > On Thu, Mar 19, 2020 at 12:05:39AM +0100, Thierry Reding wrote:
> > > On Tue, Mar 17, 2020 at 10:30:56PM +0100, Uwe Kleine-König wrote:
> > > > Hello Thierry,
> > > > 
> > > > On Tue, Mar 17, 2020 at 06:43:44PM +0100, Thierry Reding wrote:
> > > > > On Tue, Mar 17, 2020 at 02:32:26PM +0200, Oleksandr Suvorov wrote:
> > > > > > Add the description of PWM_POLARITY_NORMAL flag.
> > > > > > 
> > > > > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > > > > > ---
> > > > > > 
> > > > > >  Documentation/devicetree/bindings/pwm/pwm.txt | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > > > index 084886bd721e..440c6b9a6a4e 100644
> > > > > > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > > > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > > > > @@ -46,6 +46,7 @@ period in nanoseconds.
> > > > > >  Optionally, the pwm-specifier can encode a number of flags (defined in
> > > > > >  <dt-bindings/pwm/pwm.h>) in a third cell:
> > > > > >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > > > > > +- PWM_POLARITY_NORMAL: don't invert the PWM signal polarity
> > > > > 
> > > > > This doesn't make sense. PWM_POLARITY_NORMAL is not part of the DT ABI.
> > > > 
> > > > "is not part of the DT ABI" is hardly a good reason. If it's sensible to
> > > > be used, it is sensible to define it.
> > > 
> > > That's exactly it. It's not sensible at all to use it.
> > 
> > If you think the argument is "It is not sensible to be used." then please
> > say so and don't add "PWM_POLARITY_NORMAL is not part of the DT ABI."
> > which seems to be irrelevant now.
> 
> I did say that, didn't I? I said that it doesn't make sense because it
> isn't part of the ABI. And since this is the document that defines the
> DT ABI, why should we add something that isn't part of the ABI?
> 
> Now, if you want to make this part of the ABI, then that should be done
> as part of this patch so that the patch is actually consistent.
> 
> > > If you define it here it means people are allowed to do stuff like
> > > this:
> > > 
> > > 	pwms = <&pwm 1234 PWM_POLARITY_INVERTED | PWM_POLARITY_NORMAL>;
> > > 
> > > which doesn't make sense.
> > 
> > I would hope that a human reader would catch this.
> 
> Maybe. At the same time we're now moving towards automatic checking of
> device trees against a binding. These tools will only ever see the
> binary representation, so won't be able to spot this nonsense. The whole
> purpose of having these tools is so that we don't have to do the tedious
> work of manually inspecting all device tree files. It's also not
> guaranteed that we'll even be seeing all of the device tree files ever
> written against these bindings.
> 
> > 
> > > What's more, it impossible for the code to even notice that you're
> > > being silly because | PWM_POLARITY_NORMAL is just | 0 and that's just
> > > a nop.
> > 
> > I think this argument is a bad one. Whenever you introduce a
> > function or symbol you can use it in a wrong way. With this argument you
> > can also say GPIO_ACTIVE_LOW doesn't make sense because
> > 
> > 	pwms = <&pwm 1234 GPIO_ACTIVE_LOW>;
> > 
> > is silly.
> 
> Yes, it's also obviously silly to try and eat a hammer. I was assuming
> people have at least /some/ sense and try not to use GPIO related flags
> with PWM specifiers. And because I think that people aren't totally
> stupid, I think they'll be capable of understanding that by default a
> PWM will be "normal" and only if they want to deviate from "normal" do
> they need to do something special, like specify PWM_POLARITY_INVERTED.
> 
> I'm growing tired of this discussion, to be honest. So if you really
> absolutely must have PWM_POLARITY_NORMAL so that you can read DT files
> without having to think, then fine, I'll take a patch that adds that.
> But please let's not confuse the definitions for DT with the polarity
> enum in the API.

I agree with Thierry here. I'd give my reasons, but I've got 200 other 
patches to review.

Rob
