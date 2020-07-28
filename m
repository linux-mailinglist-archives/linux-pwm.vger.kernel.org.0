Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD3E23066D
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 11:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgG1JUV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgG1JUU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 05:20:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB1EC0619D6
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 02:20:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so17567888wra.5
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=beBH51PBvrNiVY21fyB1FDMkBD4/1CfVqZsExUAdGms=;
        b=AUZBUOCz+C3rUbC09PBQb07wRcuG+Z5atNFGMx6frCJ20iuSZPlI4T6fknCpq3V/8J
         ojiJjQXoLXIm3nkm0LEBfBv4OXrf6lLG5QUbLRzA1+ixupmRCG4MzcvFiTqizHNPbH0/
         XzZPxU1YUQ+SgMlRBsA9NL/4k859nPxCoBO9wQkfPvgYBC6dcegsVSQ0fwQnFb4QzrYu
         42VuVYpxQicy5tc5KWqBaCx7kbfyxq98OarVugo1rGHxL3+GnsB9B7O188y2FlBsK/iu
         vL/PJFJmQe8WxNKsi7xYRRKw4KqAxMCJXsa9lwAaHXh2uJACBdEFn16gde0U6hWIzf4p
         1RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=beBH51PBvrNiVY21fyB1FDMkBD4/1CfVqZsExUAdGms=;
        b=JR/4ZUJJ5Qed8xl3tzb7004IqDPKm8qB3jrLECT2qXGBDFfVXEuhYBoRKRn8YeP+hx
         ir2bT0oGP3mBn7WXZYsrt5U+bRGRxbiwZU+M83TfOubYC2qGCTu5h9Cd1Md6tIqbaXBe
         sE6cSLlcCbrG5YUwDbw/9+kOo4nSiFBjrUX+6HzHUQzein8us12jODuRH7UjFLnVDHfd
         uXOjUXrENz14D2R0bdeE6pPjPI2Bv+tBnZlW2MsD21WG7G+nzarVSixlkNMQdk3gxsUe
         VNYjfRakTxwJXqAyJey/weGTB5PjF0Nuo9cr36sH2AReQPEj2ETSNElwX3WlgHAzzn9i
         pDuA==
X-Gm-Message-State: AOAM530I/XjzijfQaAI4u7WvONn+qSJ6bKJjxTzkQH8FxaSEpg2AGSoC
        OGSHZbuweOsh5O0ontIDnro68w==
X-Google-Smtp-Source: ABdhPJwnXEtbFH1jcD4yCv++hVxdGTxMKRMWQHHEoQcyflVcKHgUz+6JPotbQr2eHetriRLig3jKsA==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr12079678wrn.249.1595928019115;
        Tue, 28 Jul 2020 02:20:19 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id t141sm3376553wmt.26.2020.07.28.02.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:20:18 -0700 (PDT)
Date:   Tue, 28 Jul 2020 10:20:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 02/13] dt-bindings: mfd: Add bindings for sl28cpld
Message-ID: <20200728092016.GE2419169@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-3-michael@walle.cc>
 <20200728072422.GF1850026@dell>
 <1065b0107ce6fd88b2bdd704bf45346b@walle.cc>
 <20200728082707.GB2419169@dell>
 <a47993ca4c77ab1ee92f6693debb3c87@walle.cc>
 <20200728085616.GD2419169@dell>
 <2fd3b880e36aa65e880b801092b51945@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fd3b880e36aa65e880b801092b51945@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 28 Jul 2020, Michael Walle wrote:

> Am 2020-07-28 10:56, schrieb Lee Jones:
> > > > > > > +$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Kontron's sl28cpld board management controller
> > > > > >
> > > > > > "S128CPLD" ?
> > > > >
> > > > > still not, its sl28cpld, think of a project/code name, not the product
> > > > > appended with CPLD.
> > > > >
> > > > > > "Board Management Controller (BMC)" ?
> > > > >
> > > > > sounds like IPMI, which I wanted to avoid.
> > > >
> > > > Is there a datasheet?
> > > 
> > > No there isn't.
> > 
> > Then what are you working from?
> 
> Ok, there is no public datasheet. If that wasn't clear before, I'm working
> for that company that also implemented that CPLD.

No, that wasn't clear.  You said there was no datasheet.

> > > > > > > +maintainers:
> > > > > > > +  - Michael Walle <michael@walle.cc>
> > > > > > > +
> > > > > > > +description: |
> > > > > > > +  The board management controller may contain different IP blocks
> > > > > > > like
> > > > > > > +  watchdog, fan monitoring, PWM controller, interrupt controller
> > > > > > > and a
> > > > > > > +  GPIO controller.
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    const: kontron,sl28cpld-r1
> > > > > >
> > > > > > We don't usually code revision numbers in compatible strings.
> > > > > >
> > > > > > Is there any way to pull this from the H/W?
> > > > >
> > > > > No, unfortunately you can't. And I really want to keep that, in case
> > > > > in the future there are some backwards incompatible changes.
> > > >
> > > > Rob,
> > > >
> > > > I know you reviewed this already, but you can give your opinion on
> > > > this specifically please?  I know that we have pushed back on this in
> > > > the past.
> > > 
> > > Oh, come one. That is an arbitrary string. "sl28cpld-r1" is the first
> > > implementation of this. A future "sl28cpld-r2" might look completely
> > > different and might not suite the simple MFD at all. "sl28cpld" is
> > > a made up name - as "sl28cpld-r1" is, too.
> > 
> > Well that sounds bogus for a start.  I guess that's one of the
> > problems with trying to support programmable H/W in S/W.
> 
> What sounds bogus? That we name the implementation sl28cpld?
> How is that different to like adt7411? Its just a name made up by
> the vendor. So if there is a new version of the adt7411 the vendor 
> might name it adt7412.

Using an arbitrary string as a compatible would be bogus.

So here 'sl28cpld' is the device name, so it's not actually
arbitrary.  That's a good start.

> We name it sl28cpld-r2. So what is the problem here?

Do you though?  So 'sl28cpld-r1' is the name of the device?  The name
that is quoted from the (private) datasheet?  Because looking at the
implementation and going by the conversation, it sounds as though
you-re only adding the '-r1' piece to the compatible string for
revision identification.  Which if true, is not usually allowed and
warrants intervention by Rob.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
