Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA5672B3E
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jan 2023 23:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjARWZn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Jan 2023 17:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjARWZm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jan 2023 17:25:42 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F41764DAF
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jan 2023 14:25:40 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 188so275788ybi.9
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jan 2023 14:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJRlUJgto8uB5cGkRdE7zVVbQyEtoN07TyJzGKXUrGM=;
        b=cOiYLD26GMRo0sNZd8nju2ANkQ+n3qs8Xjf5D7XTwBgaPEvmZz9M1Z27xdRO85T2FM
         xExT7Rjf7Y6CNd8+OAZrG6hsCG8G+r+uQZx/eAXNCCaYYfC1z+pp99Ld0GcOx+rlL3ve
         TzfoVnhIYEHpZwVXwdbdWcuFLOeJUWSWTHdULy/DKVTs30/a4k+cZFX/EIdVAOik7NfT
         581mEfAXBvXkZm66DT0dp2web4Si4t34BPfC1T6H/p5xSYTAYQS6+uZXKY7okji3z55v
         kj2sBaQcK9Rd/aSl2v98RAzHqUQ5rx2TAeo+1Arm1Hp5LAxaygH/kQyKZjfUSz+lhHjl
         QWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJRlUJgto8uB5cGkRdE7zVVbQyEtoN07TyJzGKXUrGM=;
        b=1Sj5wPJf07+o7y1HV5IvTc3LD+DrRh8Mpg5N73bc7XkWUfRAaJZDNJb9J8eRNAGhiA
         FWTkJhSOC8QC2jRqaRt5DDVrDKe7ZVxYEljyby4R3JFHoJPebKOTxmUos2xfy6+/UaNn
         /AQX+1GhKKJ6BL1ExTZtV/uI20btKEwuzMqO+MHyRK9RiquJX9sJ88VuxQPIzftbYKJX
         gw/1RjWqMT5kU1OdkJWJTC+8EZ/gqEPgAAYpURwXpyPdlSN/SlITRQTeSh4oSzNqIfkB
         jSOblzyx3qr+r99yNPlBRZDLEpw4a0smNOrq5x0W5duGpOTRjWIJNDeIMXdDQXhKa8TY
         wW8g==
X-Gm-Message-State: AFqh2kohud5BOIegfQ6pfMaBid+/weYHwqNQ43rRSZc5M6JxE4mWQWKR
        eAtFkBYho9dydn9NPT86z94YEle2GQ5lp+UQIJUZ0A==
X-Google-Smtp-Source: AMrXdXuI5hg5AIFwh0/mT980lHJf5WTph67P2AuKuLGHPSAAZV2ksJng7e5hfUWSF+/PtO/j5sWYbhLL4bpWiw9PsAk=
X-Received: by 2002:a25:8746:0:b0:70b:87d5:4a73 with SMTP id
 e6-20020a258746000000b0070b87d54a73mr772093ybn.584.1674080739210; Wed, 18 Jan
 2023 14:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20230118154817.97364-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230118154817.97364-1-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 23:25:28 +0100
Message-ID: <CACRpkdZHqn9Pma1jUG-16S6ygJkemgk6KwS=owovn5K6JRVFYQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pwm: ab8500: Fix .apply() and implement .get_state()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, Jan 18, 2023 at 4:48 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> during review of my previous pwm-ab8500 patch I learned that there is a
> (somewhat) publically available reference manual. Reading in it showed
> that .apply() is still more broken that I assumed by just reading the
> code.
>
> This series first fixes .apply() to not be off by a factor of ~3000 and
> then adds a .get_state() callback.
>
> Note this is only compile tested as I don't have the hardware.
> Also note this breaks all consumers that relied on the previously broken
> behaviour.

I looked over the patch and I can't find anything to comment on
it just seems well researched and correct so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
