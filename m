Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8871E348EE
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2019 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfFDNe6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 Jun 2019 09:34:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46502 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfFDNe6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 Jun 2019 09:34:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id 203so15508511oid.13;
        Tue, 04 Jun 2019 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfcrsRJhrfQerVRDm2wFc+gch6yIV0MIjROGPp8cm1E=;
        b=i5m1PMvp8p9cwEIvOdb885uIMIQJwkPls9guY5a+TasB3gevGRutzM/EJ2UWNMWwD3
         TIbzJmzvy/+cej9PP1Q5nJhE0iNnl/txyQvq+3YK6n6Qny5NIOgTvtObPHK8Km9kd/i1
         dXkSSEcXYAgpMl2eyPNKGUs2taCpRBNKq3y3c01Bq6e+3O4ubkBCrhHP0y9UlQ+qKAeT
         hfvOkvUUjXBXHzUXyltS02W44szBvUYdE9yoGqhAdDXUhwkE60VrBKM6U+76+vFHzTUE
         1n9kNKSfwmKaIsDtMGJuQU+L/Z/cR67vdDaVqJ3otw6qusGawvOJejYCb/epzpSZf2zZ
         ulVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfcrsRJhrfQerVRDm2wFc+gch6yIV0MIjROGPp8cm1E=;
        b=bM86DWq2k5JksHwlliJ5lKhT5Db6xK+vnqXxStoHzNLKj3oY4LV7kod0ADmucpeAyv
         9vOcva5J+QMy1PZ60RxmAU8pNKPh8KxhS/jVtTbcRf81UR7UrT/IBcj6CjZslez5+JAv
         1BUc8e9fCYSLDLV6zfoFiqboF1CYIQCGgyDU9LFCOkmdDK0512EjNJNjLDlTPo6g2LFQ
         pl6zZ1NGLpoKMuIwN07qqgQuYTmFfuOT79h/5uRMKR6EM15eiSG98qeB9zWwaU7kZn+s
         zBiKpE6JNIXzJftuhSrxu9cdbDykCRZ32Bep+thGBIspo8v6RqIpw3Te9vjRNQN8Rhgt
         SERw==
X-Gm-Message-State: APjAAAUugkqZizvCP7SQJAeIdNkrr2rukMA4GvkHJukFJs3MmvsysKGw
        VOIg8RoDxsUVSck2afrdg1uGJ6cRNn83SmQ8Fcg=
X-Google-Smtp-Source: APXvYqwBiHgyZyfAEuih7Wc6FmDGpR0FRB6kViLPqzzbukg3U+2xUinJiusYONDDZD8K5KQeAYVcObPT5ya9CokmVeU=
X-Received: by 2002:aca:5416:: with SMTP id i22mr4594892oib.103.1559655297365;
 Tue, 04 Jun 2019 06:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190603151223.5311-1-TheSven73@gmail.com> <20190604091425.GL2781@lahna.fi.intel.com>
In-Reply-To: <20190604091425.GL2781@lahna.fi.intel.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 4 Jun 2019 09:34:46 -0400
Message-ID: <CAGngYiUc5_A1umM=8f12BLejq-3aqHnExEQ2RxNABv8u3HdqnA@mail.gmail.com>
Subject: Re: [PATCH] pwm: pca9685: fix pwm/gpio inter-operation
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Thank you for the review, Mika ! See comments below.

On Tue, Jun 4, 2019 at 5:14 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> > This approach will also prevent the request of the "all" pwm channel, if any
> > other pwm channel is already in use. Is this correct behaviour?
>
> Sounds correct to me.

Something that occurred to me right after I pressed the send button:

This patch will prevent a pwm 'all channels' request if at least one
of the pwm's is in use. But it will not guard against the opposite:
after the 'all channels' pwm is requested, it will still allow requests
for other pwms/gpios !

This is identical to the old behaviour. But maybe this is an oversight
and not a feature?

Proposal:
1. prevent request of 'all channel' if any of the pwms/gpios are in use
2. prevent request of all other pwms/gpios if 'all channels' is in use

>
> Can we call it pca9685_pwm_test_and_set_inuse() following naming of
> test_and_set_bit()?

Sounds good to me.

> >
> > +static void pca9685_pwm_clear_inuse(struct pca9685 *pca, struct pwm_device *pwm)
>
> I think it might be better if you provide __pca9685_pwm_clear_inuse()
> that does not take the lock and then pca9685_pwm_clear_inuse() that just
> calls the former. Then ->

I agree, this is much cleaner.
