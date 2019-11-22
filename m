Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE3F10730B
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2019 14:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfKVNXo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Nov 2019 08:23:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42946 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfKVNXn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Nov 2019 08:23:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id y19so5492166lfl.9
        for <linux-pwm@vger.kernel.org>; Fri, 22 Nov 2019 05:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G64bQ8A3yMTqtNBBWlyBmb0qrNhP58uWiyeN1U5KLKw=;
        b=oOCpH0ULI7JqIinV2acu9vs3mEAOQ46GMMMuuiYjz4Q2A0TM3VKB5XZ/sQ6BG/fQsG
         Mo7R9HmO1Hr5pSFYXX9CUQ7Bec3RIsAildBF3DJ9hs9r9e5hCU+THo3i9MqeRiPp1eYn
         uUy3QlRloKM4ueQJrjNnpm2brSNUHHJEewfQsc1CXYOvTcdDYHHrCjWH9TO1NLL1YyRg
         E/1iOC8vb52G/qpBQkYGnCJirqwadUlUIXiFpmGl9e84F8QwImAAIb8LLvTQdDb9JeSO
         kEfI67Ph4F9eEap5SGeKceaBfvA6yM6yKL+qd4Sbrh0PF2aahIU91XTuwhG6gFrFz0N1
         6ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G64bQ8A3yMTqtNBBWlyBmb0qrNhP58uWiyeN1U5KLKw=;
        b=L96qcEyfBP93Y/HM9zWvgzwQmrfmGkYNJe55eOh4j8kdCIUk/bfUa18MXxHaM4kMwH
         Qqg4XN/JAu1PsfRhiADDgQ022/MAyGyEhGNzqynPep9ATgOYO8pbXx7NB5985KUggwuA
         Erx28lgJyPM5w34sojIoCQsK9u59HpCdnWDW7BRfF+cOOYVepk+dXA55m1bsAET9HoPm
         eXalmL0S7Unq2QXXNZgHVUcyoj9AMcv1Z1R+9jwzGWhl2p0KQkwNYJQaSN3uFVcgroJd
         /wOp9ys5aVfpuHbe0YEbwtmKdnNefponRNzzNbj4JZsN3j4Wf8KAFuzHPAYVL+EVcslq
         Hz+A==
X-Gm-Message-State: APjAAAUFkxf48cr8htmPdD6itKlfQymL71sdndWBqibfpKz40XQ1w/2k
        rtsWRpF47Nt+aF6pz1nuKEKFYNhM75wxWmMD2XzXAA==
X-Google-Smtp-Source: APXvYqwEF+IMct0sUqko73DZ1FYEj7WuVXA1c8Q04GTvwlG6eN/OQ1Bt+LcQ4w0/EWe1WDQ1kXUaUsPRu4TNl11V9Co=
X-Received: by 2002:ac2:5b86:: with SMTP id o6mr12054376lfn.44.1574429021774;
 Fri, 22 Nov 2019 05:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20191122113230.16486-1-miquel.raynal@bootlin.com>
In-Reply-To: <20191122113230.16486-1-miquel.raynal@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 14:23:30 +0100
Message-ID: <CACRpkdYMoRXT0vGT2NfQaSq6jU-0m3A4JGrk7YAhtDih3meBQA@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Nov 22, 2019 at 12:32 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:

> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

I'm happy with this patch, but I would need Thierry's consent
to merge it so waiting for his ACK.

Yours,
Linus Walleij
