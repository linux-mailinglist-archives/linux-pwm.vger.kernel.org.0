Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0AA7FB9C
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2019 15:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405586AbfHBN6w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Aug 2019 09:58:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45149 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387723AbfHBN6w (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Aug 2019 09:58:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so36087363pfq.12;
        Fri, 02 Aug 2019 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nOwrc06TPbA7F+C0PVpjSzC2KO7oYOPAAALxEDCBL7s=;
        b=C4V0iOrMM/aLpUZOe/CQt9JwyJNhltI7d8uOyfTy8yioMHc8G9olJDRA5QPe3AGDbI
         gLNNNPi25HBQCpQIsyncib/JBMvi7NoHqipwVr4r+CjWXfM6/n7eBAIcoPplX36le/T+
         9K7Suagj8jMxLYXlaJ1H3nacJIiZll279PSjUH/drMjoDRtafk2LDvksrcT0jXjNlpUT
         X4ie6QN95Ar2ujy3u2PiGtK/i3YNkH84zVa2YupnhVw71lJjCVOXtyyqP8k4wWkyAyeR
         RWdmitbSeAKhzmmZoxn8q8+5mnwNTaXcGHGhtzJ6jt5IxKuDRv61uxSJMgGUOm1t+mqZ
         zSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nOwrc06TPbA7F+C0PVpjSzC2KO7oYOPAAALxEDCBL7s=;
        b=btYHnxXUbSnYk1ldEAaGrTXcQ9kg8FaEiv0M6LLRm7mGwCD93xahwVZSTrdti+bqGK
         jnkl3t61VDDUP9tDHljzrP3cQs2ojipu4o245oat5lRSEZEi8iy+39ZizK7HXoOY94Cn
         sATo5NlH/TWWrDFQBzIkKSDWzG6U/fMVk7nXwPV1bYjkqa3XyrJiYkFZW/1kCj5scwVj
         spKDoMN/V+npII963JEdnLMhiU01srI8253cbRUJUQbm7Y//3Lygf/mcG1cxGOdu3E3F
         YdgODjO1S1zEWmCqKglEeHRHN/z/z171FvtUkAmGk8f+i0xNPbwqr4MDoFfk3ywMC5Tf
         m8Zw==
X-Gm-Message-State: APjAAAWWexUcTWy/1S0QkN1R+lq9auA2SefXWl2JKt1ViYapb8oOWIwE
        dMuJo/al6K3GajHZNFMEE/k=
X-Google-Smtp-Source: APXvYqzja+RBNYx14OwEtb69H05qwdxqK4pjco40xyaN80/lTrnM/Qj2O2um/9hqyZHA6P5OGs0emw==
X-Received: by 2002:a62:1ac8:: with SMTP id a191mr59917280pfa.164.1564754331256;
        Fri, 02 Aug 2019 06:58:51 -0700 (PDT)
Received: from icarus ([2001:268:c147:64b2:f351:c489:c6c9:377a])
        by smtp.gmail.com with ESMTPSA id e5sm5057632pgt.91.2019.08.02.06.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 06:58:50 -0700 (PDT)
Date:   Fri, 2 Aug 2019 22:58:30 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: counter: new bindings for TI eQEP
Message-ID: <20190802135711.GA27874@icarus>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-2-david@lechnology.com>
 <20190727204836.1514265d@archlinux>
 <20190802072513.GA30522@icarus>
 <CAL_JsqLA+m5vKZQ1WwWusnVHwX+nnuApiwKXUnmP6ti-PvMZ-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqLA+m5vKZQ1WwWusnVHwX+nnuApiwKXUnmP6ti-PvMZ-g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 02, 2019 at 07:34:42AM -0600, Rob Herring wrote:
> On Fri, Aug 2, 2019 at 1:25 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > On Sat, Jul 27, 2019 at 08:48:36PM +0100, Jonathan Cameron wrote:
> > > On Mon, 22 Jul 2019 10:45:35 -0500
> > > David Lechner <david@lechnology.com> wrote:
> > >
> > > > This documents device tree binding for the Texas Instruments Enhanced
> > > > Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> > > >
> > > > Signed-off-by: David Lechner <david@lechnology.com>
> > >
> > > Up to William given it is a counter binding, (unless Rob overrules)
> > > but new bindings are generally preferred as yaml.
> > >
> > > Content looks fine to me.
> > >
> > > Thanks,
> > >
> > > Jonathan
> >
> > Rob,
> >
> > Would you prefer these bindings as yaml, or shall I accept them as they
> > are now?
> 
> Still up to you at this point, but I certainly prefer them to be DT schema.
> 
> Rob

I think YAML would be a good idea, it's simple and expressive enough
while still being human-readable, and if new bindings in other
subsystems are switching to yaml then we may as well.

David, resubmit this as yaml in version 2 and I'll pick it up.

Thanks,

William Breathitt Gray
