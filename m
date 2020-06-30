Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8E20FEBB
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 23:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgF3V1t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jun 2020 17:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgF3V1s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jun 2020 17:27:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60F0C061755;
        Tue, 30 Jun 2020 14:27:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so9971751pfu.8;
        Tue, 30 Jun 2020 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MQBErciIyI85FpBDV0t+8Lcbb9FvJ1w5mLOf7Rx5bGk=;
        b=Ijzh/MFvNwAuuPmLgLmPFfO+rTkLg8UETdEfqUYAGZWlH72Tzsw+4ViGmOO6kb3KHF
         5CL9IjG0tPcq6RHvGQDfZZI7+YDR5ABYH74Iv4D9PwMxyFT5IJeUjs4LLHs4eSR3YR3I
         wHxXWIIHF5fB51h1FENg3+FvVKOGEj2GWfNOHdJ4etVG1+NuNPhE6PZFUMaW7wH18fw0
         tImDJkVHgQFRt5MEGYGj3Jo8MkJGjHLoz0xwc/vncyOwwJdgPIfv5pWWz+yEgYS5rbhs
         FsbWn2bkGeY7hoLwqm+0Gen/EVePDSbOU88/MRO8fR81jkI6sj49Zsz9hHtGELoq4k7R
         A8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MQBErciIyI85FpBDV0t+8Lcbb9FvJ1w5mLOf7Rx5bGk=;
        b=kkf8vZicsa9y2CUDhQ79LiBi9/+Xge9zM67pRjqMO7lw42dab83GC3PNVJUjzFagLo
         elC4qqKd34toGGnywcjxwBtVY3yR13fhIbYaGVS9sw13h0JnydWCmTkv+Th69OE+Ixg0
         Eay7WRNL95JN3dNPWHJvwRvXX06mY2ISnopBPsb8bf8vv0WHE/l7BGE7vwdocwd1igSh
         yteeIBixafx6lf5bhY3b4rWMfhtJjH42dvLhKjE+VBCKKy5Une7L68jV3NkrlAX7UzmF
         aYkvRJKq0KzcJu0ZxgpOR0nyQCU7xeJ7SvDPvQ/0xFWnXhPa1MFQ/rC8Mcm7dRvOqUsx
         AdZw==
X-Gm-Message-State: AOAM530JE5F2BJsZGy5XRD1aFZcu+4CCvHfPBz27145ooKi50/y26S8Y
        j4b8/XmRFD88QYHQbFlH0cQpx+8TTj80ZBJTffw=
X-Google-Smtp-Source: ABdhPJy35NPGb0KZOUK69krtGXjYyP3OWGIt43uOZrw9wYyrqRr7g2NM1taAwkEdxDXzWr1zn/289gUuXkahPQAtk0E=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr11026892pgn.4.1593552468187;
 Tue, 30 Jun 2020 14:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
 <20200629160844.6ecf79c1@xps13> <20200629195044.uvgma53cajiko3gf@pengutronix.de>
 <20200630085828.1aebdf99@xps13> <CAMpxmJUHy+5ynmsU6FhX=MJR6XbwoNr65NGqzuAd0Bm-JS1kWw@mail.gmail.com>
 <20200630124500.m765t276atb3wqgy@pengutronix.de>
In-Reply-To: <20200630124500.m765t276atb3wqgy@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Jul 2020 00:27:31 +0300
Message-ID: <CAHp75VcxQ-qK+RYmfULDx3cHQW9W8__-Gf8EFw7Hgqsz0oPkjA@mail.gmail.com>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jun 30, 2020 at 3:45 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Jun 30, 2020 at 11:13:31AM +0200, Bartosz Golaszewski wrote:
> > I can't find anything in any of the previous threads. What was the
> > reason to not go the MFD way here?
>
> MFD doesn't work because the different "modes" are not orthogonal. So
> this is not a single device that provides several functions at the same
> time that can be used in parallel.

Did I get this correctly that it's either *all* pins are GPIO or *all* are =
PWM?

Otherwise, it fits from my point of view.

--=20
With Best Regards,
Andy Shevchenko
