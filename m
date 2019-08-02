Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FAE7FADA
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2019 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405951AbfHBNe6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Aug 2019 09:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405938AbfHBNe4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Aug 2019 09:34:56 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985B721842;
        Fri,  2 Aug 2019 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752895;
        bh=AOM4fOrWcXJ0jseQxBiq/7aKw9Ers/tE8HeByVSd9QE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NPdPO8QNKIFHyLclnfIENqqo8qqzd5J2DZ9sZ7Xl1c9FNVHe6c95crzwNrqo7EOty
         dHW/39rLodUwarCNs5QSW5E2JjLbuXcx1MMEE2ukSTUdQMBunSX0DqBS2bF7Y/zEAX
         IpxS3njbolU9vgEwncAH1+MMasCMnSLGN9Qxvn24=
Received: by mail-qk1-f173.google.com with SMTP id d15so54752163qkl.4;
        Fri, 02 Aug 2019 06:34:55 -0700 (PDT)
X-Gm-Message-State: APjAAAVXvGAJt0YQrTA6Qc4+mBJ339fibdQ+klG8GeQ1N5ji8RU48u9f
        jZiJj/0nwgtUtYpwmgtwCYRVt4bhptDiyH/89Q==
X-Google-Smtp-Source: APXvYqygjBn1/EWko56cFZKxIUhfaf9MMi7BKzf/8JqnTcJxDMsyOkDdJi2i2SRjWDVkquDwVn6DCbZfSUuL3VM0CT0=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr91698408qkl.254.1564752894791;
 Fri, 02 Aug 2019 06:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190722154538.5314-1-david@lechnology.com> <20190722154538.5314-2-david@lechnology.com>
 <20190727204836.1514265d@archlinux> <20190802072513.GA30522@icarus>
In-Reply-To: <20190802072513.GA30522@icarus>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 2 Aug 2019 07:34:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLA+m5vKZQ1WwWusnVHwX+nnuApiwKXUnmP6ti-PvMZ-g@mail.gmail.com>
Message-ID: <CAL_JsqLA+m5vKZQ1WwWusnVHwX+nnuApiwKXUnmP6ti-PvMZ-g@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: counter: new bindings for TI eQEP
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Lechner <david@lechnology.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 2, 2019 at 1:25 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Sat, Jul 27, 2019 at 08:48:36PM +0100, Jonathan Cameron wrote:
> > On Mon, 22 Jul 2019 10:45:35 -0500
> > David Lechner <david@lechnology.com> wrote:
> >
> > > This documents device tree binding for the Texas Instruments Enhanced
> > > Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.
> > >
> > > Signed-off-by: David Lechner <david@lechnology.com>
> >
> > Up to William given it is a counter binding, (unless Rob overrules)
> > but new bindings are generally preferred as yaml.
> >
> > Content looks fine to me.
> >
> > Thanks,
> >
> > Jonathan
>
> Rob,
>
> Would you prefer these bindings as yaml, or shall I accept them as they
> are now?

Still up to you at this point, but I certainly prefer them to be DT schema.

Rob
