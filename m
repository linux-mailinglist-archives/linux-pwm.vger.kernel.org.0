Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF9B2C6B
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2019 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfINR3f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 14 Sep 2019 13:29:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35922 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfINR3f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 14 Sep 2019 13:29:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so5212541oih.3
        for <linux-pwm@vger.kernel.org>; Sat, 14 Sep 2019 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkBg+ENUJ3Gl/HtO3MIUd1cduukGMGbEN3Be0p7rvUs=;
        b=kwhqEbb34MatHWkpCwUBCbOWtSMV8fDKpO7YvRb3/nzPjURxPGv5YjSG2kapgX0y7b
         kYX2XjkMBbb+M6JSSrzZpqTLX0WEMiRnlhJbSMivYlcZNDAlJTj8PMXImLeKnzHZQofW
         5z0Vk5cIaApJyoey4xnmnfiQmuGwfMWvpPLK6SCUZ0Df2RDONPR1OSMDXSMw8paHd5Pq
         Xa/hfqFLBQ9npO6dPwgMqqx1yKqnY7/99US3ifaBD2PmdngfisJS/cLugVxTWb7tFjvU
         pvOeS9IfUZnaoVSAe/UUnAg7eIeAeKUE6Lb8RS5SHFb06eqctkYtRcX9bzYKf3+fRJgM
         6EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkBg+ENUJ3Gl/HtO3MIUd1cduukGMGbEN3Be0p7rvUs=;
        b=Yqu5XUCfVhagu76iNga6mXXHlTkRGJUXRhXO49nkiGXK8Vml2oauObrmeUtVtBQmoN
         shWk5GrEjO4RGi7vTKN/xWo8MxWgS65TQS3kuZZZyESHmyo6JHO14iKl5V32uvk8bbAH
         tEtM58cZ4qVDEYMQJzc4gVGYonWLML9KM5J5Ve427koMb9Rm8TlSFZLWnrdCMX2gUq8J
         opicxQhmwD/sOvV1iUWuM/5KZpqnlSYrgFNMjEmAWybIYhXVbpT85qutBGkao9OTAGQk
         3wUAq1Rdp9vMFfesL7NEa2GlY+LxnXZP65+KpIch6ZzlbzPbFyTpN7tQlCMKBz0fPa3k
         yIvA==
X-Gm-Message-State: APjAAAXqt3AHkVZaRMz1lOuVnCxKs9ebr7kZmW5eOe6jUIyXRmrx+zpm
        NT7mMkUdLs00cGh10rYiMm7FxJh3WH+gntUfrTVEXA7Q
X-Google-Smtp-Source: APXvYqyjN1EiJT398wPnUCsvIIBnlJt7Qg2579elhaBJLxwi1dCr5lmVyvtD+hOLlYH/iCjesGvWjfOiFRm3GTFBPBE=
X-Received: by 2002:aca:1004:: with SMTP id 4mr7663986oiq.92.1568482174467;
 Sat, 14 Sep 2019 10:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190830182830.81627-1-andriy.shevchenko@linux.intel.com> <20190913125922.GH28281@lahna.fi.intel.com>
In-Reply-To: <20190913125922.GH28281@lahna.fi.intel.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sat, 14 Sep 2019 13:29:23 -0400
Message-ID: <CAGngYiUeKPkSgi8i3_Q09LKJko_D1RUGQYcE12rZ9J3q169gdA@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: pca9685: Fix regression for GPIO use
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andy,

On Fri, Sep 13, 2019 at 8:59 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> There was another patch from Sven (cc'd) fixing the same issue here:
>   https://lore.kernel.org/patchwork/patch/1084046/
>
> But I don't think it was ever merged anywhere. Maybe you can try it out
> and give your tested-by?

When the issue came up, Mika and I considered restoring the old synchronization.
But we suspect that the old synchronization is broken, or has become
broken over time.
See: https://lkml.org/lkml/2019/6/2/73

The patch above was reviewed by Mika, but could not be merged - there was no-one
available to test it out on actual h/w.

I did however successfully test the logic. I disconnected the driver
from its h/w by
giving it a dummy regmap.
See: https://lkml.org/lkml/2019/6/6/666

I am of course open to alternative solutions.

Sven
